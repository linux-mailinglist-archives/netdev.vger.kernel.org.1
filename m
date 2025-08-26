Return-Path: <netdev+bounces-216985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5489B36F92
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7154E3B0B53
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692BF277CA6;
	Tue, 26 Aug 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdotIW7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F53242D9A;
	Tue, 26 Aug 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224343; cv=none; b=mOxnS4dG9psbYRbNAbC8opeOkeHSTMf6S8HkdWuawLdq/izxOgK0ulu1qmUrEii/q2sF5Ua3rfKka46gjtRQ8b2A0ZxhxpZa7fUEWxQ5Jsnn4qDqDHrNEwureDiQH+Buyv3ljkFa1ctBmodR2zRsLUyD3qDPYHzVIzrqqXj+1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224343; c=relaxed/simple;
	bh=FjceF2bXmue3HwrOsvYAV28Qy+mXPtyOsYpBSJrTMMw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LEf+TujTp+rRe2ie3kefxVdQvHk9VFLLPL38q4YYa2VQJCye77tqE4SZ3bIStjHkIQCTw8FabDyfmIX6XM8W23ajHD/WHdsku+ujE0fgzZnzjGxxQc9d7OjjYY58oKmkyFr/7ZsW78OCBve12cvR3weFQ+hi0B0yUovu3T3vYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdotIW7i; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-51ea6c8ae03so2328479137.2;
        Tue, 26 Aug 2025 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756224340; x=1756829140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGNdMOA4rilU8AON0kSO3AFj/6OjCufJ+EO41YUA7F4=;
        b=ZdotIW7ipKY0sPI3SuqXomReh96PPwHecUDA63W3psIuARwtGHz4EUNEpIDKpSVm3i
         llip4Bdnr2Q+WD/YSs3865lWTz4pGf7K8WTRaCyemNPXMCg0mYbkFX6WzmqV94yfxZAH
         nYW4cPoHqz5P70mxxrf820isn1Aph3Tm99nVMp9EMmIQ/qjCNFBh1uJ1FmCSt81xohxu
         zUnBrUGyQMj4AiVk4vzE7iLiOBygyuTs8ujo33DoF3YVloIzydc2sofFxITRoZgGNue+
         TbY3sdwcZwWByMaUAEaDE4zxu1cl7m1QGv99stnRk5Q3IZEQcjyiaxMC/sVR7hkUQG0J
         W82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224340; x=1756829140;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jGNdMOA4rilU8AON0kSO3AFj/6OjCufJ+EO41YUA7F4=;
        b=LzcX3L4lnHNOcaW3Ox7wq9c8meRNhwVnuLv/LR0xHn1nuI9BIKRUY3ytTqNf3Kmii9
         Ty1OY7yNEy/IJdojGutOVhqirSN9c0RhKshnYcYIOA6q/TV42wR4o6xR3tJ0ks95ZHZJ
         m3KNHLZoY1vVWvQCV67eA5syDe7iNuXopFrlONP2a8IAdT2mFStgUuCbseLglV2B6otO
         hvdpI+8EA2nP8F98VWNlJFUPcsVEl/84NExR7m+oBlF/BDwl90sFqWq09dQXmo6+oiqM
         3GvxVLbJAWXICotYyzACq0CwHpTOW+PBMizi1vciM2KU/dcb56D7eDx5IMkjmMmT+0JY
         Ac3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9+6LjVkZw/CR2qjmdNBo5DPx/scddRI+kc0WOGCyJB/GdDDgyJ8/GZJJ+AamvNSmXJ20u+gm@vger.kernel.org, AJvYcCWsVwgFGAVZuSX4hMx1mOR8gSAZCdAVvMgqHuML+w7dwS6V98iSYjQisfW8f9v96eEeTm+j+NueUovg5mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkMmWoXpRctC2WS83XBLM+1I9w9bCzoIdmQyUgznu+95XZBzw
	GJ2C4zYFQk+p1JW0V/GfUc3f88O2H1yMcWl54I+3dn9eQH3Dnv/Lho4k
X-Gm-Gg: ASbGncs5f5SmW/Tf2lr7UpqrUlneQkXUa2v5JaBDziSobovfgzZSdks0O4ZooTWBf9a
	8YLqD3PzaoflIsvzoKuryjZdc+qwuz2O9tPlW1JgsU3qep2p8TAGsKYuBmEwkjmoY0RPwyOGLFI
	iyjwvxjLLtZ9Rbi+in8mLUDrOs5v7tAZ0vhSn9/ff0a+WwIh1SjuoqcqnSrHQSmHP8gf/P1d1FU
	eWRlFSjIdc0y6JotPJ2fqDA7WE5ByBLwz60WHx/7Prn2maiks6AUp2caADWNMcM0x+r68zt/YNP
	3d4n5zJGwHB3NEwFzsaz+JSy003oAWowPnCDGobOrtJzFduV5GU+bkciGmtNd9/XKkLijLxDJMm
	DXmBEv9car4cXJ8uz3MRpBaGScUkRIRqGjHgLnXiHn24mrrOL9Yvk4LkkD7s3NYQI3V5Tt5dF/A
	65Xg==
X-Google-Smtp-Source: AGHT+IFj7ZkVh78A/2pvdV5VZOEaGB9H+EbiLlB1J0P88BwFBWhxtHWN6o3UpiDtlkqIrxo6n2BVUw==
X-Received: by 2002:a05:6102:32c1:b0:519:534a:6c4b with SMTP id ada2fe7eead31-51d0f1ecf95mr5326957137.29.1756224339924;
        Tue, 26 Aug 2025 09:05:39 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-89419c5c76fsm40212241.11.2025.08.26.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:05:39 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:05:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2d7599ee951fd@gmail.com>
In-Reply-To: <20250826145347.1309654-1-jackzxcui1989@163.com>
References: <20250826145347.1309654-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v7] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> On Tue, 2025-08-25 at 20:54 +0800, Willem wrote:
> 
> > > I understand that the additional in_scheduled variable is meant to prevent
> > > multiple calls to hrtimer_start. However, based on the current logic
> > > implementation, the only scenario that would cancel the hrtimer is after calling
> > > prb_shutdown_retire_blk_timer. Therefore, once we have called hrtimer_start in
> > > prb_setup_retire_blk_timer, we don't need to worry about the hrtimer stopping,
> > > and we don't need to execute hrtimer_start again or check if the hrtimer is in
> > > an active state. We can simply update the timeout in the callback.
> > 
> > The hrtimer is also canceled when the callback returns
> > HRTIMER_NORESTART.
> 
> In prb_retire_rx_blk_timer_expired function, the only way to return HRTIMER_NORESTART
> is that the pkc->delete_blk_timer is NOT 0.
> The delete_blk_timer is only set to 1 in prb_shutdown_retire_blk_timer which is called
> by packet_set_ring.
> In my understanding, once packet_set_ring is called and prb_shutdown_retire_blk_timer
> is executed, the only way to make this af_packet work again is to call packet_set_ring
> again to execute prb_setup_retire_blk_timer. At that point, hrtimer_start will be
> called again. Therefore, I feel that there is no need to perform the check in
> _prb_refresh_rx_retire_blk_timer. Only let prb_setup_retire_blk_timer to hrtimer_start,
> is that right?

Good point.

Let's clean up the control flow a bit more to make that more clear.

For one, no need for delete_blk_timer. hrtimer_cancel will cancel the
timer if it is queued. And the callback spends the vast majority of
its time after the check. So the odds of delete_blk_timer having any
effect is minimal.

And if the callback just restarts itself unconditionally, no need for
the special refresh_timer and out labels. Or the somewhat complex
calling flow between _prb_refresh_rx_retire_blk_timer, prb_open_block
and prb_retire_rx_blk_timer_expired. They all just schedule the next
timer the fixed computed jiffies/ms from now. The only special case
is when prb_open_block is called from tpacket_rcv. That would set
the timeout further into the future than the already queued timer.
I don't think that an earlier timeout is problematic. No need to
add complexity to avoid that.

