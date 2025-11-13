Return-Path: <netdev+bounces-238433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB7C5900D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22FE2500572
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2C3590AC;
	Thu, 13 Nov 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BHgmJ2EB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BA3570B9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050697; cv=none; b=mYFhfzy0TF6bWcEEcrsK21yzf5rDYUNNMMT09yFG03ACoYXuJ9D0Jb6fE6Fl+Gu+LAWP+UJXnaRcN3RA2uQbQtyQ6yxc3kxBoTUzD1Ba+wN+fOAqXnd2nlf3Kst/v5WPKU5eyFR7fPguSDxdmUU6gtL9rLDFxZEDI0jCQBG1JcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050697; c=relaxed/simple;
	bh=UeFN3NDqbPUJ0rZEw0wFwWIfjrarRiwRq7NbTIlEjG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A37bNs5fYZhogS19q6zXwWgGYRlWZS4XLnudZDSD0AcwWVqtqdrRXoX28d+GTWAu9BaV43xd7N6DnL3CEDgH5l2FbwJquk5BX8zIRaa6kYBKA/+CQuJ8DJjJZzmFO1X1KlLYiBirOFC8pWD/p8IBt7bhtaVlSNdjnVCwEdsrj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BHgmJ2EB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-786943affbaso8813807b3.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763050694; x=1763655494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeFN3NDqbPUJ0rZEw0wFwWIfjrarRiwRq7NbTIlEjG0=;
        b=BHgmJ2EBDTpWPP3qkTbIn3JsDcrP1jC8Q6Jr4p3td2XPEwjqZw07xbruvQpZpCcIZr
         draiyokg9vqA+fy9C3r4pWFHZidfHaMH+KEn1nYGrKY51d0OYDMLTzkSdiAoy2p4VJrR
         QKES+l/CWxbj4iSlZuq1OJMdoyclTxgdTQnmT44qSFrqYE1iNZawrTGh29SbEsJ9hvGa
         pDQB4rnTPZHXKrhaMcHePum4hYw/ITHf5/hgcC5ATYar3gs8fSbdB5fs3Db1X40aA1tW
         sNpICo163DCMiIYx9jIrHLn/onyQRs77pH28suIOeGylRcdeqz+dnktA9D6ID7FCwP03
         2HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050694; x=1763655494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeFN3NDqbPUJ0rZEw0wFwWIfjrarRiwRq7NbTIlEjG0=;
        b=Z9V8C3PiRfdRIHW3pIac96PAyjUIY/ZZ5TezOLZBwEXzJX32+V00vr13bxJpQWxEaE
         iLvq6tjlvX+zz/DitOV63yGjD/oqm1JqxUHo4TFMteo0Gks8O0bTjbKj5IR+gLs3B3Qk
         TSWB/c5DpdndntsLw6udYyTua0SG8nqrqXYVG8pLvAW4aT81ohhEqpBniaW9HzAKl/ZY
         N6M+LlUvuobLO39PWgbdIcu59lyYE1x7lha76QXjTb5Sd+oIgwG1eWYU2+zkXxjs5+r4
         YfphMqQrAVvujE+e8DX/IafPLnYq8kdvg/W3fif1CEmt5QiUgop7Nrb2FZTkZh385iuv
         qVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl6u5/5D0UHn6PV0L1Byq4rAXSR8RKg4pe42Lm5eWNi5URPVA1ZcHwSy2bQ70tVKAPP5Ywnk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/vxTUFVMxHbjwZv86Q4CgaYzPnfuPdJiJHdUGHNzIFU5/ODI
	GF1+CX+QLKfyW7nl8mYKReijiROl+kDSamFzqxu3tvmCTXWrj8J0e2nmJt8r4/nzxyKYTm7BveO
	SaIIILX/qYrSzEYrl9W0cQwTRWawgdDTmpRBbxt5H
X-Gm-Gg: ASbGncuNU9ltak+6vNN8cDcsEj6JF0FW6uIbcMyQYlploLE3xohFTHtG/nFLOg1jkDD
	2sIB4WskxqP/ae1vW3cymUvnDwYXl9h73HnUCJtZHZLD0t2HkH+S7YPwlFw8FNE+vo0lLUDxdSX
	3iJWqxCmNKu124GsT1+JLLdYbjR/pzXs+vkoRIVbAK/tWoKw+yl5e05/ic9vuCOV5Nr1+UssgDq
	gVoeBx7IxilulBeQtTbQ9RAZZMjfUiDSYfE6Lawvav1DZZM1cuN5dn40kpb1qc1ApZC
X-Google-Smtp-Source: AGHT+IGErZ56xqXDc0nriOIEwuDATL/9+5vVIOypV8eSxeuhuE8+8bWn/vQNaQxp2XxkJyi+X1ZRT16TEpBMSe2+Uy8=
X-Received: by 2002:a05:690e:7c2:b0:63e:2250:2210 with SMTP id
 956f58d0204a3-64101b6b517mr4235182d50.59.1763050694408; Thu, 13 Nov 2025
 08:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112125516.1563021-1-edumazet@google.com>
In-Reply-To: <20251112125516.1563021-1-edumazet@google.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 13 Nov 2025 13:18:03 -0300
X-Gm-Features: AWmQ_bkVSq9BKbnWo9UgM0P7k_nK_I88bNwebCnPmmkKyuAty0FVOlVCN-1dcZI
Message-ID: <CA+NMeC9WciDGe0hfNTSZsjbHDbO_SyFG3+cO0hHEc5dUyw5tTw@mail.gmail.com>
Subject: Re: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Paul Blakey <paulb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot found that cls_bpf_classify() is able to change
> tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop().
>
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop =
net/core/skbuff.c:1189 [inline]
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x=
76/0x170 net/core/skbuff.c:1214
>
> struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
> Extend qdisc control block with tc control block"), which added a wrong
> interaction with db58ba459202 ("bpf: wire in data and data_end for
> cls_act_bpf").
>
> drop_reason was added later.
>
> Add bpf_prog_run_data_pointers() helper to save/restore the net_sched
> storage colliding with BPF data_meta/data_end.
>
> Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc contr=
ol block")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Closes: https://lore.kernel.org/netdev/6913437c.a70a0220.22f260.013b.GAE@=
google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Paul Blakey <paulb@nvidia.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Thanks!

