Return-Path: <netdev+bounces-109240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC765927830
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48373B21827
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A821AEFF5;
	Thu,  4 Jul 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsFrKgjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2A1AE0AB;
	Thu,  4 Jul 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102918; cv=none; b=cyXpdxJvaLKHH0QvJieFIRAA43UauBBokxWEr6HA0UBK3KfkI+JU8KaiVlmZHeQyfyTWM49Kr6+L06zih9wRYtdJa4CyJ+I7cN4klMTT1c+OevDdWWW/GrVqON3RNHRefnux63aGLw58Voaxy7lu7MzT20FLmJg1xaw1TqEj2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102918; c=relaxed/simple;
	bh=iKe+A1sDrt5xlzKN/n2rJO4eHJJBwyHXukKi30vutIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT5dNuvvAvn7t10pSni1shZR+kGJHCCprq1m07srLz2oer+xduvo/gDchwsJ+RQPGRvLSaTc76C4Zxpn6x7kT2TtV+cH751J2fyAWhvytpvrZCka62mgLSrFNtZOvAPCmp3FslmzvHZiBnKOtiRfTd+G2roU00XW+eMw+iVHG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsFrKgjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1B3C3277B;
	Thu,  4 Jul 2024 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102917;
	bh=iKe+A1sDrt5xlzKN/n2rJO4eHJJBwyHXukKi30vutIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsFrKgjSi8vVf7H9lDMOqWrfVP/QCiaFWSED9mYqEX3iD3Y2yTMVnxqk37Lici/ur
	 vmOPqR+JZnyW+NaLx4QR8qIfe/YpF/Uxzij0ziIRx/SIKHpIPj4mBJOYiJlOCWGOjk
	 HJnnC2cbmwR5sezXcUWalJghK90Amhxcr5X0jm1cT1kQQw/inFe7fBSgpkLCDdj+H8
	 3rEVO+pqkrTy7NeGxNxYMQX4sRL2pjhF6r7GsOYj64iL+8Wo4YWCgU2vItKHU7I1b1
	 43OaaHc5fl33BeBiB8m3TkAqF0TKecOhny2qbGhqieKYIiXNhNWY7QwsF6ped3ip2W
	 efhD9f5o9uyDg==
Date: Thu, 4 Jul 2024 07:21:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, <oss-drivers@corigine.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <louis.peens@corigine.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <yinjun.zhang@corigine.com>, <johannes.berg@intel.com>,
 <ryno.swart@corigine.com>, <ziyang.chen@corigine.com>, <linma@zju.edu.cn>,
 <niklas.soderlund@corigine.com>, Chen Ni <nichen@iscas.ac.cn>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next] ntp: fix size argument for kcalloc
Message-ID: <20240704072155.2ea340a9@kernel.org>
In-Reply-To: <2230e0ee-2bf4-4d86-b81d-1615125d3084@intel.com>
References: <20240703025625.1695052-1-nichen@iscas.ac.cn>
	<5cafbf6e-37ad-4792-963e-568bcc20640d@intel.com>
	<65153ac3f432295a89b42c8b9de83fcabdefe19c.camel@redhat.com>
	<b30c7c109f41651809d9899c30b15a46595f11ef.camel@redhat.com>
	<2230e0ee-2bf4-4d86-b81d-1615125d3084@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 12:17:39 +0200 Przemek Kitszel wrote:
> >> This patch is IMHO more a cleanup than a real fix. As such it's more
> >> suited for net-next. For the same reason I think it should not go to
> >> stable, so I'm dropping the fixes tag, too.  
> 
> I'm fine with targeting it at any of the trees.
> 
> But I still believe it is a fix, even if a trivial one, and even if code
> "works" - it's a "wrong" code.
> 
> Here I received similar feedback in a similar case:
> https://www.mail-archive.com/intel-wired-lan@osuosl.org/msg03252.html
> and I changed my mind then.

Comments, docs, and the MAINTAINERS file are special.
This is actually changing the code, and at present results in the same
binary getting generated.

