Return-Path: <netdev+bounces-137618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DD9A72B3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D331F227E7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914D1FB3F2;
	Mon, 21 Oct 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYS13bYV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A71FB3D4;
	Mon, 21 Oct 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536999; cv=none; b=iOx8z99Fi5+/RKs202sPkeRW1CxHNqoDJoi+g1oLTLBTUbiK9mPjyIUCbyHhhp1YmPTu24VbB3n6fJIDm+qhgzGpu6xxM9tyxUk9P1yYMhHz47EGraGFLiza7ntNJDk9gEPHIgx7KDn3Ua1whBmhD6l3FTj0FWH5scdIJNefBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536999; c=relaxed/simple;
	bh=5ns1Cp2df/roLKSbVD+hyIOYBeT05YJkiVNpaqDapcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyCVfW2IoWRI/v0yH2A+u0ZiHTJxGyjJoPBKCEMBlD4uOKsObBKTGJZTV98x/P7OZmuYQr2LYOcxxN1iPAThPoATcqBpvasI5kuv8s9ifxyCZRbr1NeIuMAPFCgoELlHIu6RQHhFS8T+tQhKQAlhSuWSRfg7tasplqZRbpYcPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYS13bYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD995C4CEC3;
	Mon, 21 Oct 2024 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729536999;
	bh=5ns1Cp2df/roLKSbVD+hyIOYBeT05YJkiVNpaqDapcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYS13bYVmhf6ZzPB1+G+UaZq5OAx2MSrh62g1WhUF86FGCCXbFYSVe6seTOP94tdJ
	 gMY6AjyLR78R0Ah2Uys8x0/XEKQuDYnMgceQXIz6sayNN2j49trb3yEvWcWIqB/rK8
	 YoPaS0BLCwmB2FQSdMCJyH+vYWcIYLYKG4vI/9Do=
Date: Mon, 21 Oct 2024 20:56:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Li <dualli@google.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Subject: Re: [PATCH v3 1/1] binder: report txn errors via generic netlink
Message-ID: <2024102102-much-doormat-cba1@gregkh>
References: <20241021182821.1259487-1-dualli@chromium.org>
 <20241021182821.1259487-2-dualli@chromium.org>
 <CA+xfxX5ygyuaSwP7y-jEWqMLAYR6vP_Wg0CBJb+TcL1nsDJQ-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+xfxX5ygyuaSwP7y-jEWqMLAYR6vP_Wg0CBJb+TcL1nsDJQ-Q@mail.gmail.com>

On Mon, Oct 21, 2024 at 11:35:57AM -0700, Li Li wrote:
> Sorry, please ignore this outdated and duplicated patch [1/1]. The
> correct one is
> 
> https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.org/T/#m5f8d7ed4333ab4dc7f08932c01bb413e540e007a

Please send a v4 in a day or so when it's fixed up, as our tools can't
figure this out (and neither can I manually...)

thanks,

greg k-h

