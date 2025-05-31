Return-Path: <netdev+bounces-194455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F55AC98C7
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 03:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1C4E48CF
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AEB1D6AA;
	Sat, 31 May 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaX9pnSH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E544C74;
	Sat, 31 May 2025 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748655102; cv=none; b=LBQNavdzAw7V883TTwDizoD1Zi8jxNc5Q+e7XGMhRuIsWmR0iKxxg9h4MMBFfNTzMCKb2dVgMBLjw6cplfBvKvU+XZURgqoMSY9PIlqvwhxXfYgmWpLa7VgYZ7ZPS6HwVgO79NreJWzKgtfa5N6PA73xXNZnrV3fraUpyBdyOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748655102; c=relaxed/simple;
	bh=SeUxHDr/ovRgaIvx1nnr6AEFPNfj0/y2SyAmVaiwcko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9apiDmaLOEMQTeAj3INTUyB2z6+9jVR4gGdHDxt41mQIDGfJ8uFIvN6KaMZ2DGqvZhGPEye25omY1FP0/nZfkhP4+Ymx4U6m6jrPrPAgnV4uXF9TTLwoHkB/hZCmy1Oxv9YXLqUfFEXRX7K8T7nn67URodhZ0itarHd6T3BiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaX9pnSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD5BC4CEEB;
	Sat, 31 May 2025 01:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748655101;
	bh=SeUxHDr/ovRgaIvx1nnr6AEFPNfj0/y2SyAmVaiwcko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OaX9pnSHDCbGdiDnup73JGl16WHOa4dTLIen1Z+gHD0BtEFl6UYvX4tbVA9iy5an3
	 taGfejmVAUotdaLZntWpY3i/sfH5rMc2o0QKzUaDqJhI6WfAq1FJtpbNnzPhXdS0pX
	 cd7A8fKPMyoxS/zkxmVkbHvNH3xoaz3EbLu+pYopW8Lc08C0MF6PyMcKUFaZaUsm4v
	 S5sLCI4MyxiYCggletz5cpNQojT1tkRNdQORLOkQN8XoKM7CGTarIeSnI6XATUn75P
	 HXOHnt99fUrh5t/xIRAwzGHe7XzvT9DXr71wqp3yZ1Y9DCbpN4Z6TBgv8mzPuxlUNd
	 sBxcMQYQHt80Q==
Date: Fri, 30 May 2025 18:31:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 john.cs.hey@gmail.com, jacob.e.keller@intel.com,
 syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] e1000: Move cancel_work_sync to avoid deadlock
Message-ID: <20250530183140.6cfad3ae@kernel.org>
In-Reply-To: <aDoKyVE7_hVENi4O@LQ3V64L9R2>
References: <20250530014949.215112-1-jdamato@fastly.com>
	<aDnJsSb-DNBJPNUM@mini-arch>
	<aDoKyVE7_hVENi4O@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 12:45:13 -0700 Joe Damato wrote:
> > nit: as Jakub mentioned in another thread, it seems more about the
> > flush_work waiting for the reset_task to complete rather than
> > wq mutexes (which are fake)?  
> 
> Hm, I probably misunderstood something. Also, not sure what you
> meant by the wq mutexes being fake?
> 
> My understanding (which is prob wrong) from the syzbot and user
> report was that the order of wq mutex and rtnl are inverted in the
> two paths, which can cause a deadlock if both paths run.

Take a look at touch_work_lockdep_map(), theres nosaj thing as wq mutex.
It's just a lockdep "annotation" that helps lockdep connect the dots
between waiting thread and the work item, not a real mutex. So the
commit msg may be better phrased like this (modulo the lines in front):

   CPU 0:
  , - RTNL is held
 /  - e1000_close
 |  - e1000_down
 +- - cancel_work_sync (cancel / wait for e1000_reset_task())
 |
 | CPU 1:
 |  - process_one_work
  \ - e1000_reset_task
   `- take RTNL 

