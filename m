Return-Path: <netdev+bounces-241385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85260C83474
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26CB7345BED
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6699627E07E;
	Tue, 25 Nov 2025 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSq46zwj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A83275AFB
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042682; cv=none; b=T2Lhdq3qLYLy5almgIqhDCZyUncOCFa437AWc6kHA3D4WHLKE/1r1DXY2xrvabecHYrDB7zwYSTl9/1u9JRfoFruVOD1UMuF05pIMFLrhah7kaQgdkaDs9PatEXr0GyYPRt2cQCXoZj2uP0NEeL8dN74I5/mJqVUT2mV9cTNYTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042682; c=relaxed/simple;
	bh=dAfgW4Ar1n8Hw0g6jXbTdY4zB1z9a0eRO7LLQdAK1h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1+DuMI3PeJ1prsaeRPJn2LeJAfB1DPFc7uXFM0ZtuHF4WVkNqHwQZRB/pnJuuOy88Xxd82Z4gP4qPfrR/FrLTgV4wMWEQOHoqYODgGFqis2O97Hzqyp/7Gyh4yiRdt8DAUCyIztJWkcVUckdkE0q730Zwxq+mHrujAkIU8mcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSq46zwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E68C4CEF1;
	Tue, 25 Nov 2025 03:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764042680;
	bh=dAfgW4Ar1n8Hw0g6jXbTdY4zB1z9a0eRO7LLQdAK1h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSq46zwjOsl9U9wmZHrQW3s1gKul0gVCH/3Aw6rXW1jmsmIqWzBI6fyNE1+DoYIGr
	 ISrzvXh9ddrfaaPqOFkyIjOnXUxKnJfB6kP8D4HPRMtU3uMxuWSbl7Id22GH7PwIgR
	 rlW9NmhK9mQ9reLeyOatVW6lcOmxaNRoiqlwmiPXy4LPcNh0aXjLuxssQrlXLFjVBf
	 iFYEu5qDuBxAlYr5VZAhfu/KxMs2oGMl1B9IE8oCkMD4UfJ1556rF8a7nY6kJThfqy
	 E2iG/v8ql8vIhtGiBsXdeVIRsyrRymwaz4mJJIcH1QbfWkOvRa0oGGVVLg8YFFKV7u
	 Jr0z8tndUzBJQ==
Date: Mon, 24 Nov 2025 19:51:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Liang Li <liali@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH net] net: vxlan: prevent NULL deref in vxlan_xmit_one
Message-ID: <20251124195119.0199d58a@kernel.org>
In-Reply-To: <20251124163103.23131-1-atenart@kernel.org>
References: <20251124163103.23131-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 17:30:59 +0100 Antoine Tenart wrote:
> Neither sock4 nor sock6 pointers are guaranteed to be non-NULL in
> vxlan_xmit_one, e.g. if the iface is brought down. This can lead to the
> following NULL dereference:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:vxlan_xmit_one+0xbb3/0x1580
>   Call Trace:
>    vxlan_xmit+0x429/0x610
>    dev_hard_start_xmit+0x55/0xa0
>    __dev_queue_xmit+0x6d0/0x7f0
>    ip_finish_output2+0x24b/0x590
>    ip_output+0x63/0x110
> 
> Mentioned commits changed the code path in vxlan_xmit_one and as a side
> effect the sock4/6 pointer validity checks in vxlan(6)_get_route were
> lost. Fix this by adding back checks.
> 
> Since both commits being fixed were released in the same version (v6.7)
> and are strongly related, bundle the fixes in a single commit.
> 
> Reported-by: Liang Li <liali@redhat.com>
> Fixes: 6f19b2c136d9 ("vxlan: use generic function for tunnel IPv4 route lookup")
> Fixes: 2aceb896ee18 ("vxlan: use generic function for tunnel IPv6 route lookup")
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

clang sayeth:

../drivers/net/vxlan/vxlan_core.c:2548:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 2548 |                 if (unlikely(!sock6)) {
      |                     ^~~~~~~~~~~~~~~~
../include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/vxlan/vxlan_core.c:2631:6: note: uninitialized use occurs here
 2631 |         if (err == -ELOOP)
      |             ^~~
../drivers/net/vxlan/vxlan_core.c:2548:3: note: remove the 'if' if its condition is always false
 2548 |                 if (unlikely(!sock6)) {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
 2549 |                         reason = SKB_DROP_REASON_DEV_READY;
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2550 |                         goto tx_error;
      |                         ~~~~~~~~~~~~~~
 2551 |                 }
      |                 ~
../drivers/net/vxlan/vxlan_core.c:2464:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 2464 |                 if (unlikely(!sock4)) {
      |                     ^~~~~~~~~~~~~~~~
../include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/vxlan/vxlan_core.c:2631:6: note: uninitialized use occurs here
 2631 |         if (err == -ELOOP)
      |             ^~~
../drivers/net/vxlan/vxlan_core.c:2464:3: note: remove the 'if' if its condition is always false
 2464 |                 if (unlikely(!sock4)) {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
 2465 |                         reason = SKB_DROP_REASON_DEV_READY;
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2466 |                         goto tx_error;
      |                         ~~~~~~~~~~~~~~
 2467 |                 }
      |                 ~
../drivers/net/vxlan/vxlan_core.c:2352:9: note: initialize the variable 'err' to silence this warning
 2352 |         int err;
      |                ^
      |                 = 0
-- 
pw-bot: cr

