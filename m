Return-Path: <netdev+bounces-40965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09D7C9335
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B0E1F21A58
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69936566E;
	Sat, 14 Oct 2023 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdNQl4Z3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA921877
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 07:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DD7C433C7;
	Sat, 14 Oct 2023 07:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697268587;
	bh=t4c1adpH10ty/zfKFnqCTgo2DQwG7YdUBbzGZstMMQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdNQl4Z3hRpyFSPqeobB9ZK0gxWKCdp1JyTcopWAz6zURN9Fd8BAY496uKtEvJr/9
	 nrNzpWOi0PicSKaw0lviGNM8e11yNWadmnEM4+W5jV1cjdGnBK1n/XmxO3vGwj6Cuf
	 EBeuI8mJhWVNqz5Pwb0sC91EFukA61XXPiqZ0rUCR9DEN0ZU9HDXCxeP+YCOd+PV5r
	 5orrKD9OsBBHf99gdgIUWq8X481Mk6SXFxGdjqtPmd9NR/TxpFNUFOL+bXLD/SPUL+
	 MBU5N/OFi1v2nM1rMriYYW3q7wmk46I+3j9T5C16NOxae4Vtz2lhN9YawIQ+rYJNdU
	 Nq6UnWzOQDkOA==
Date: Sat, 14 Oct 2023 09:29:43 +0200
From: Simon Horman <horms@kernel.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
	johannes@sipsolutions.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] rfkill: fix deadlock in rfkill_send_events
Message-ID: <20231014072943.GV29570@kernel.org>
References: <20231013110638.GD29570@kernel.org>
 <20231014024321.1002066-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014024321.1002066-2-twuufnxlz@gmail.com>

On Sat, Oct 14, 2023 at 10:43:22AM +0800, Edward AD wrote:
> Hi Simon Horman,
> On Fri, 13 Oct 2023 13:06:38 +0200, Simon Horman wrote:
> > I am wondering if you considered moving the rfkill_sync() calls
> > to before &data->mtx is taken, to avoid the need to drop and
> > retake it?
> If you move rfkill_sync() before calling &data->mtx, more code will be added 
> because rfkill_sync() is in the loop body.

Maybe that is true. And maybe that is a good argument for
not taking the approach that I suggested. But I do think it
is simpler from a locking perspective, and that has some merit.

> > 
> > Perhaps it doesn't work for some reason (compile tested only!).
> > But this does seem somehow cleaner for me.
> BR,
> edward
> 

