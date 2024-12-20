Return-Path: <netdev+bounces-153542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753DC9F89FE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D1169637
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A040125B9;
	Fri, 20 Dec 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUbOk/Zk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974DF9EC;
	Fri, 20 Dec 2024 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660521; cv=none; b=uw+PhQ3LVxsphlel73/cUmCQNmCbXTzAp7rvj7fxuskuoADpoZWMbrqPlhQX+3z6EEqaQjVsRMLNuY4VfP0I71hEd76GO8ntNq0SMQZlUVbgZLRQLnfNOrm9QP6YIgLd+3/i9EtJhqY/kHDcH7Xr3kNJnZigzlbSgoZESIBGcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660521; c=relaxed/simple;
	bh=q929ul6zfpaR6ZcKX1JWuxy9TJbKjIOIv+fU7eichRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYbunehGyPjgTioCM+zixi8jhco0kz0V8/vxIoAx0RJexL2qI3QrwLLl/Sa5whfq6jwRqt7K6xAaSJJ6q3n4cEu7rXlAUqso2ZurInn6Qqm8O4iMx/S9tEkzsmUsG15Z+3G8jd19TdqTGvtfbus52nUuwJpB/yzrnAmatvKZT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUbOk/Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F7C4CECE;
	Fri, 20 Dec 2024 02:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734660520;
	bh=q929ul6zfpaR6ZcKX1JWuxy9TJbKjIOIv+fU7eichRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUbOk/ZkTfI2nFvMG6hWaucMBSsmjBUZDpzGOYoPgFIm3uCXBalC3EsoqIZzKIkE6
	 Rq2u0uW1AiaU73mBHwPZW2e2GIgOWkelq0yvDiAok6U2PUrAPvcdVzg31Kq4zd07jb
	 6ldrYtFB4WKN3VuX6j+o5QyZ2xVAe+6m3q84DEFYP9bb83vdR/E/f7U3zlngSU4fRZ
	 VTtfMMthwJ5MfFD1iwW/iKbDza5QlXQMTX2gftvZgn+oyCSUtVFFOXIsjfKzi3bKTy
	 ZcwC3pO+Xtuvx6KcRosSLVxqlIQvEJjzHlqNb7ElLEDLjyXWsBZzhOUM9crMC8YLN6
	 p6uDdHDCP+/Mg==
Date: Thu, 19 Dec 2024 18:08:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Taehee Yoo
 <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com,
 corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241219180838.2cddd591@kernel.org>
In-Reply-To: <CACKFLikUM=Vt1EeYEs_-amCmahak3nQPSbwz_v4T1pB=UShQ3w@mail.gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-4-ap420073@gmail.com>
	<20241218182547.177d83f8@kernel.org>
	<CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
	<20241219062942.0d84d992@kernel.org>
	<CAMArcTUToUPUceEFd0Xh_JL8kVZOX=rTarpy1iOAD5KvRWP5Fg@mail.gmail.com>
	<20241219072519.4f35de6e@kernel.org>
	<Z2R1GFOg1hapdfl-@JRM7P7Q02P.dhcp.broadcom.net>
	<20241219121841.3ed4de71@kernel.org>
	<CACKFLikUM=Vt1EeYEs_-amCmahak3nQPSbwz_v4T1pB=UShQ3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 15:41:17 -0800 Michael Chan wrote:
> > Or maybe the HDS does happen with XDP MB but there is another
> > limitation in the code?  
> 
> HW doesn't know whether we're in XDP mode or not and can definitely do
> HDS.  But again, HDS is disabled currently in any XDP mode.  Andy will
> respond to discuss this further.  Long term, we may be able to enable
> HDS in XDP MB mode, but for now I think we should disable it just to
> keep it unchanged.

SGTM, this series accomplishes enough things already :)

