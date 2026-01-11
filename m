Return-Path: <netdev+bounces-248841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA9BD0F823
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3851430281B4
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38D34C989;
	Sun, 11 Jan 2026 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksk5eWmq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9233E36D
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768152343; cv=none; b=mfOPwUVce/Gdtmq4YhjnWCYQpDRYxVoSxi6WmUFAFV5XDFXN61dNgSKg50+FTg3IhWhUsvM6opprdLAk/nNnhUdlXSJldmSV6pjRpB717m/y2YKSVAiFwc1szHFBsduJjP4a7N+SFtJKhFmIo9IohM6Qm4mClqf+F+ZTy9c0/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768152343; c=relaxed/simple;
	bh=cjljBLZoG9fTTRHU5MPWlw8jUvnwV31ogQ1b8q01e9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU8h54g34QD7NYQ3cblMq2n2l3idRBXWDOKZrfHk0QgXi8Hnf8HESU23biOVEa5WqdM4wXG9HIFlLnmihBPLvvaYQ07GSl5yju5f0SGtMYM9ktmwfT3TkvMuDkjLkZeAyuYHWP5p6YuQ2j23OY0h2KDHBg1Pq3qabt5KW6QEeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksk5eWmq; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f36012fb2so7333832c88.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768152341; x=1768757141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ/8RXQ2BzAPZZ+7WcWKfp4Acx6XbSu75geK+PzPA1M=;
        b=ksk5eWmqdswn5qrg5JFPGUt8x/KEch6FgwLyP1s6P92uCnhN0GAFnR7QHqzBJchAj3
         PSfdzCzzwnbprXdQewB9ftW5AfyuzY/OBeErDtVADab3rqVbYuC8AktMnTBmoZ6X1VrM
         T/VsXgwiOG3ubg8YyqlWLRXMCgIDiKBRGZNL2dEcg+1mybXSQ6QPq2hJU55BN7p6fxKd
         dAj7xI9zb68m9pNAsrTymiy1TeoqsMPfXSubZ5J4urEbm7O5LasZ3QCWa0DcPnW37+Ef
         6cAXd2uBzFVVQU1xs0raMi4NgIFMOLSGApwppmibUbkq4yTahc7fJMV/Kyp1/yHxScHQ
         EIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768152341; x=1768757141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJ/8RXQ2BzAPZZ+7WcWKfp4Acx6XbSu75geK+PzPA1M=;
        b=oai9FrWPfn87AEzWwBuXzhlKRb5yINFSUSc2fZaxm0ha2ua7QgKVC3TcBJGFTBOddu
         C0VgugaWVERF2yUDM8DDD2Py2cfK83YLJqpG/FtwW8mX619xgr697RJCe+6SyCWjAqyF
         s9KyxMZ0CDxLB6KD/P+UQsbhe2A6p7bbw+4SIwgcKtzjWApwSBDpdljeDsjTxqDbrGcG
         5H59xEmflf3MvsKyM/KgWxXOxs/KdHxM9pYmn1Rob5tx+m+uuaCDE/2m3ulP3GZ8y2V9
         xtxCrRyZIxoAvwpaflIDY+H40X8RnOWFWqRoKTrpCBIioLtrtJNUEaiO+811wGS0FxlE
         5Tpg==
X-Forwarded-Encrypted: i=1; AJvYcCWx4ZCevs5WUjicLUm7lm573Q2JIe/L8u82sIWQoWeYPxU/xF/oBMoK8GwM35MZeDC7HGyhUW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8UxUH3hmNolCET7+mVEdeSE4Y07xuGL4hW+oe7hwxAQrHmKp
	Fdm7RwyLAYRhXNKUzVtckl1UQHdpb9faOwEW/tNf8hx1dcTOcM/6vcWTdyrv6xzofQyil44gmhE
	LeJgEVla8YXQsVdDhBwdyzZrBbgyKSa4=
X-Gm-Gg: AY/fxX7AOiA2+6YCVTvDugf4nCpjV29luag8O9KvvcB+pMmCnNuKv4kKnbZp8rK6Nra
	O8gquR9UhGyAwDID71lsej4s3BfWqqTOK6ai/uKmDeeawKKuJrmxFrE3/9TFjQaiKfMUebdIoKQ
	0tcJSAF0T272CfJLLG2k2gdQEXaKF8LToT62NKk92IN5/36Uj3+OOXN+Ym771nm/S8zuEiT9iXd
	NrTiBomwzIrNgbjxvT7zp5dNGaQEOYpoMiKc7S1xjqg4k2jSVsAhjnZoNH0B1vhPLracWQ=
X-Google-Smtp-Source: AGHT+IEaxiO9VrZHryDc9a4FiJJYpzSl4h8Yoaer6Hw81gPMyUIXR57kAQpI5GWShCmt8uws/7bSaGG3zA2H8dev+/E=
X-Received: by 2002:a05:7022:2522:b0:11b:9386:8256 with SMTP id
 a92af1059eb24-121f8b7664emr14650331c88.43.1768152341101; Sun, 11 Jan 2026
 09:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106123302.166220-1-islituo@gmail.com> <20260108175357.52ad56c1@kernel.org>
In-Reply-To: <20260108175357.52ad56c1@kernel.org>
From: Tuo Li <islituo@gmail.com>
Date: Mon, 12 Jan 2026 01:25:29 +0800
X-Gm-Features: AZwV_QiV5wVa8rngopuLYqt8ndR8Ooaak_ajSzfytrySLFdNvQneQYeWWgyVqXY
Message-ID: <CADm8TekXPCwfYpiTUJuh6F6Uy3db-2rUzG900SJPz5Pad_dwrg@mail.gmail.com>
Subject: Re: [PATCH] chcr_ktls: add a defensive NULL check to prevent a
 possible null-pointer dereference in chcr_ktls_dev_del()
To: Jakub Kicinski <kuba@kernel.org>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, kernelxing@tencent.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub

On Fri, Jan 9, 2026 at 9:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  6 Jan 2026 20:33:02 +0800 Tuo Li wrote:
> > In this function, u_ctx is guarded by an if statement, which indicates =
that
> > it may be NULL:
> >
> >   u_ctx =3D tx_info->adap->uld[CXGB4_ULD_KTLS].handle;
> >   if (u_ctx && u_ctx->detach)
> >     return;
> >
> > Consequently, a potential null-pointer dereference may occur when
> > tx_info->tid !=3D -1, as shown below:
> >
> >   if (tx_info->tid !=3D -1) {
> >     ...
> >     xa_erase(&u_ctx->tid_list, tx_info->tid);
> >   }
> >
> > Therefore, add a defensive NULL check to prevent this issue.
>
> There seems to be no locking here.
> It'd take much more to make this code safe, sprinking random ifs
> here and there seem like a waste of time.

Thanks for pointing this out.

Given the lack of proper locking here, I'd rather drop this patch than add
ad-hoc NULL checks.

Thanks for the review,
Tuo

