Return-Path: <netdev+bounces-40666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329FA7C8408
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637761C20A99
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAE1134A2;
	Fri, 13 Oct 2023 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5HDk4rT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF3125A0
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5316CC433C7;
	Fri, 13 Oct 2023 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697195204;
	bh=dHEzqTXEd5FUqIWp2K1kqMsP14aeiGQKm0u06PA0HcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5HDk4rTMac0ZEF70SjLE1OdS4lgzRgjZOcMi/zVghFKH2rSbdQwMHk5HJ7GgUBct
	 oXigqpxJ2qdal5HQr6ITv22qa12IRW3OyuIYq4ZplaqbV3Tsqy3ZTjJsx7okY/ut7+
	 OfxWc1TE+R43VI1XKXV0M39RIG5Ezml63PUPZZyEGChJCckwtwz50DEFWRoQ1LQp8O
	 YGGdT1fJGF51wGXv7tyCjKBASMgZs4G9H9Sxz29t6YXp4Z25/8sAjbO/n6yCioORTN
	 PlCWeNa6p7dL9PUP3sLuHvLcfQVclrUQLcFmVMlIphoWQ/5BQcSA2P+hK/OIgtOO8O
	 8AV43E1pBvl0A==
Date: Fri, 13 Oct 2023 13:06:38 +0200
From: Simon Horman <horms@kernel.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
	johannes@sipsolutions.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] rfkill: fix deadlock in rfkill_send_events
Message-ID: <20231013110638.GD29570@kernel.org>
References: <000000000000e3788c06074e2b84@google.com>
 <20231010010814.1799012-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010010814.1799012-2-twuufnxlz@gmail.com>

On Tue, Oct 10, 2023 at 09:08:15AM +0800, Edward AD wrote:
> syzbot report:
> syz-executor675/5132 is trying to acquire lock:
> ffff8880297ee088 (&data->mtx){+.+.}-{3:3}, at: rfkill_send_events+0x226/0x3f0 net/rfkill/core.c:286
> 
> but task is already holding lock:
> ffff88801bfc0088 (&data->mtx){+.+.}-{3:3}, at: rfkill_fop_open+0x146/0x750 net/rfkill/core.c:1183
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&data->mtx);
>   lock(&data->mtx);
> 
>  *** DEADLOCK ***
> 
> In 2c3dfba4cf84 insert rfkill_sync() to rfkill_fop_open(), it will call
> rfkill_send_events() and then triger this issue.
> 
> Fixes: 2c3dfba4cf84 ("rfkill: sync before userspace visibility/changes")
> Reported-and-tested-by: syzbot+509238e523e032442b80@syzkaller.appspotmail.com
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>

Hi Edward,

I am wondering if you considered moving the rfkill_sync() calls
to before &data->mtx is taken, to avoid the need to drop and
retake it?

Perhaps it doesn't work for some reason (compile tested only!).
But this does seem somehow cleaner for me.

