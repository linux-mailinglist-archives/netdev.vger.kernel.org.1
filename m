Return-Path: <netdev+bounces-69214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718684A2ED
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D099028B5BA
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DDC481BF;
	Mon,  5 Feb 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THAfD0+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8645481D3
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159583; cv=none; b=cICG1lNrXN1k/UeKBWzDKSW6hhSlC+IPLSF4vN50Qk1D0xbXPzS2rnA70s+pm11i/s+g7Z3gK8+RVfl9RJGbDJ62hHecPURVRg8/a6/QUCCdYkZKvwepZkGnguHbojKlZ8DZi4FZGp7+kEpTjaxtlSVErrLDDNwDwOskoyhx/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159583; c=relaxed/simple;
	bh=L6J91ZwtQxJs7VebFqQJ1XGDU9Pzok5b5HvYlaSib1c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aalIuPzTXRcSqwWipaLoc/ufojnhWZ6Miu5ivFgUpCKoAEerfncPYTFzUE6T5pB/Bib17HI0FbO5Qeqv0AYgkGx2lG1yAtxKjrvxssrqFfvAqbFE+//aZpk+CYFgwLRrU2JIXM57RRqUOMzc1BjxIETh7Xtb2eiJgzc4k/WYfk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THAfD0+k; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e118b528aeso2336473a34.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 10:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159581; x=1707764381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNVfzD3OEZrVNN2/snO06E/YiW0rpsU7ImFMjbgDBjI=;
        b=THAfD0+kpodaJyayeNEUkTBmAFqH4o6VPxQViY8XKxjkfuxqgagIiXLEIV7AxzRM6t
         h/NP5C0Xw/Afa85qb9UrvuasQUiXJDf86U1a1BQgMXwPSDTxSgIcd0fsW7Xlv6GCjsn5
         y8p9cEiEbY+uWYCzNf66QvDus1nUvXeXALjvUyknwUo6/l7FkssFk5kuRAbnSTiMmrQK
         94BwLZkyeaKR4GqSwVdI2J+C9T4dhQ93OtwZx5rRLMkBrBInRomhcMQw1imlaUaCzUQ/
         2G8NGmA5RGQMEbY7N9PE9y5a/Gpo27m9uLPd0gUspR1VnQ8dFhnMWOp497WPkMAcgNZn
         kCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159581; x=1707764381;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SNVfzD3OEZrVNN2/snO06E/YiW0rpsU7ImFMjbgDBjI=;
        b=CqPVEOBsm3DxA1b30CgAE8fX4A/x0KJ5jsWPmzh4seG+89/SFJaLCuYc4Rg0upCdad
         jb0JPFzxfFzr3+SexlBk3nYIfcoxCrM6HTrHM5ft3eyebALyN9pVLsRKS8bvMSG0A0/r
         c6TLDTtGeVVsBUEaGSaIG73hda+zenRynbMS17PgOwVQpwkm9KE2SDeTk+O0kpTzEnwZ
         zmPvnaAQwSW48QRNPt09vLgDLkxJoPqIFRhxZFFdigGwzrIuM5r1+ViKOraUEQ6qWupo
         ks6C/TE/BKKVkKtilnxDgbTmA26+51QdAVFsRi12HO7AH2obRj5uaXQ7R2z6RiAFQqsK
         6POw==
X-Gm-Message-State: AOJu0Ywk8Qdkx+vGKFwEscpuDQTw5ulEd3VSbCZkynhe0WKy/CPEzXeL
	M8Yh15D8K+u0bVlJy15e0Ga4lss9fqjgDVgdIvm36aMTJsxNTyn4
X-Google-Smtp-Source: AGHT+IFqyHkKIXTArzvlDRQ01POz0ruzb4OpNJVci+uSkhGXP4fcbdAKskwaYNGlYz6fz5Sinh88Fg==
X-Received: by 2002:a05:6830:3111:b0:6dd:e530:8c12 with SMTP id b17-20020a056830311100b006dde5308c12mr708861ots.4.1707159580704;
        Mon, 05 Feb 2024 10:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXRJwECdsJeN0+PZjSbEzLzpUEv7bFv9/el9vYT2UJ3nwho5OnV68durLiBKNGHs+7rMg82SJGEBk08BP7yPr9Y4jCuXuwgdZQiPmkIqayZmrHFIF5sjLV/ZD52aFMyhOeS4xs2l45PQ1h1ZGLWUGj68B00dgCnCt0qLITYnFGjSFb/0uxcOP+zTL7JyRT/ZyJGclNTisTRNpYFmg4QDHcyPVPyu6XGG3nOUfzxtk0oCdocyTN1NiNEFnN9xhA15BKaK4VG1ie9m6Xg
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ku23-20020a05622a0a9700b0042c20fcbac1sm201517qtb.41.2024.02.05.10.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:59:40 -0800 (PST)
Date: Mon, 05 Feb 2024 13:59:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+c5da1f087c9e4ec6c933@syzkaller.appspotmail.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65c1301c2fc9c_7b2e029449@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240205171004.1059724-1-edumazet@google.com>
References: <20240205171004.1059724-1-edumazet@google.com>
Subject: Re: [PATCH net] ppp_async: limit MRU to 64K
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> syzbot triggered a warning [1] in __alloc_pages():
> 
> WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)
> 
> Willem fixed a similar issue in commit c0a2a1b0d631 ("ppp: limit MRU to 64K")
> 
> Adopt the same sanity check for ppp_async_ioctl(PPPIOCSMRU)
> 
> [1]:
> 
>  WARNING: CPU: 1 PID: 11 at mm/page_alloc.c:4543 __alloc_pages+0x308/0x698 mm/page_alloc.c:4543
> Modules linked in:
> CPU: 1 PID: 11 Comm: kworker/u4:0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Workqueue: events_unbound flush_to_ldisc
> pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __alloc_pages+0x308/0x698 mm/page_alloc.c:4543
>  lr : __alloc_pages+0xc8/0x698 mm/page_alloc.c:4537
> sp : ffff800093967580
> x29: ffff800093967660 x28: ffff8000939675a0 x27: dfff800000000000
> x26: ffff70001272ceb4 x25: 0000000000000000 x24: ffff8000939675c0
> x23: 0000000000000000 x22: 0000000000060820 x21: 1ffff0001272ceb8
> x20: ffff8000939675e0 x19: 0000000000000010 x18: ffff800093967120
> x17: ffff800083bded5c x16: ffff80008ac97500 x15: 0000000000000005
> x14: 1ffff0001272cebc x13: 0000000000000000 x12: 0000000000000000
> x11: ffff70001272cec1 x10: 1ffff0001272cec0 x9 : 0000000000000001
> x8 : ffff800091c91000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 00000000ffffffff x4 : 0000000000000000 x3 : 0000000000000020
> x2 : 0000000000000008 x1 : 0000000000000000 x0 : ffff8000939675e0
> Call trace:
>   __alloc_pages+0x308/0x698 mm/page_alloc.c:4543
>   __alloc_pages_node include/linux/gfp.h:238 [inline]
>   alloc_pages_node include/linux/gfp.h:261 [inline]
>   __kmalloc_large_node+0xbc/0x1fc mm/slub.c:3926
>   __do_kmalloc_node mm/slub.c:3969 [inline]
>   __kmalloc_node_track_caller+0x418/0x620 mm/slub.c:4001
>   kmalloc_reserve+0x17c/0x23c net/core/skbuff.c:590
>   __alloc_skb+0x1c8/0x3d8 net/core/skbuff.c:651
>   __netdev_alloc_skb+0xb8/0x3e8 net/core/skbuff.c:715
>   netdev_alloc_skb include/linux/skbuff.h:3235 [inline]
>   dev_alloc_skb include/linux/skbuff.h:3248 [inline]
>   ppp_async_input drivers/net/ppp/ppp_async.c:863 [inline]
>   ppp_asynctty_receive+0x588/0x186c drivers/net/ppp/ppp_async.c:341
>   tty_ldisc_receive_buf+0x12c/0x15c drivers/tty/tty_buffer.c:390
>   tty_port_default_receive_buf+0x74/0xac drivers/tty/tty_port.c:37
>   receive_buf drivers/tty/tty_buffer.c:444 [inline]
>   flush_to_ldisc+0x284/0x6e4 drivers/tty/tty_buffer.c:494
>   process_one_work+0x694/0x1204 kernel/workqueue.c:2633
>   process_scheduled_works kernel/workqueue.c:2706 [inline]
>   worker_thread+0x938/0xef4 kernel/workqueue.c:2787
>   kthread+0x288/0x310 kernel/kthread.c:388
>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+c5da1f087c9e4ec6c933@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

