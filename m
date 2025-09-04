Return-Path: <netdev+bounces-219821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26BAB43271
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F233AC3C9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00BD274FE3;
	Thu,  4 Sep 2025 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TshFx6jQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390811C8FBA
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967679; cv=none; b=QRP6KCsAN4LXxZrlONeKvKMVY5X5sQbqRQhm4dVxzGF6TJe3GDdGWq0YmJkA7CohJs9Ef8sD4uKtA7U5XlRIFZImwmWqkPiHtXSUPfcmdGUH/t4hxECX82BKNma6Pf/VkNcy4xnPZBriG6c7ox8V8oaXKpvYZt+n0jKAtIJYOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967679; c=relaxed/simple;
	bh=m/vCBCXDSpn6pOe/k47oVzon0gg8QM7aJuAEIKvtpfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvdEJLB5CWXETir7i+O1HqN6Ghlqr0FxWrexKO22nWitfPN1kdp+isYzhnrzDkFAA9AC9yfjuRyErOTuaZupPs0J46sgEdQpaFUTaG28WqoMEGiDPlveqXgpgQWbB7mZSu4fgM+trsOk9chXYcNoADJcmfhh6bDrIe+aIoPEVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TshFx6jQ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3f660084016so4965225ab.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967677; x=1757572477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/vCBCXDSpn6pOe/k47oVzon0gg8QM7aJuAEIKvtpfo=;
        b=TshFx6jQ9h75BEoQyMgPNdMcCDk0UlMjs7R1zYy4g6PMPnDd9lyENzh7fR6veVmL6n
         2hN2577lyv80/kKfLFqKlRCVNW3fh1f9J1We9FiK40mUncrXm6/tWhg2wYabz0PtL6fD
         WtCHwhgMK223J/DjGWoo+0mbWy4A5cXeSMUVQTQJYPB33X4UMuNtvHGgVSRmsLinUGi5
         b2j+Na8YzLEokRuNJMQ5LQ5aSwxl8/Uzp3LNcOwDrBExajYYA6zzubkzCc4lMtZrCELX
         xFR/HFcw9NS1Z21ONBx8OeXRF6OnLiyi+QbdKsuNGEljRLzr9vbF2frYbeINN048/IRW
         GdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967677; x=1757572477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/vCBCXDSpn6pOe/k47oVzon0gg8QM7aJuAEIKvtpfo=;
        b=jWPTwi2HyzTLy4DQ/aTNQxHUvFMp5m++c857COsGBMHS4qir9g0ZWvjFLZks2Lw9ze
         RJRcYYvZWwZEHtl7BmvPyqtSc/gyL4+Wc5v3K+CqE695avP19L5G7VUyK7yHEFWOQlog
         hUrQmktsqLWIz8HNe7zPIvIWKllIGcbzeC7UdwgVCBb2Qzer9bMxptvvhhF7R+p1xd4B
         GexiubNZcLUCn2lbMNgcPba0HcHR2ktx9pvaIADGF44zZ8C0/m1P8ecvk+zVAUcm6TD1
         2TlFlKpMVwRCru1KG+HMiOxfrlwduG0cstp9xjOmDFUkN/24kC1tGKBiqCkmnVFPh7ps
         MQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGb9cCxvFuf49JGvdy6GKKRs2IrBHkLLf1ASfkSyZWX8mkBXLuPs4uyW1Pt4ZFaLbP4dQ7DY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0WZhP67m4TzLqd7CnZWuG20S/8Ix3nAhPh/ZyAoALm1DXE/JF
	l2ccHyPuvy7axOgmitxspVG3Z4w0TBs84G1OSCKwuLlpYhiNM8iGno3wTxShG6I3O4sDiJuU+6W
	q2nmYO5RhWBo7848K4wCwdDTyxqghG3Y=
X-Gm-Gg: ASbGncsb88g8ifVBH0V1O0XCdDXL4da4P+kRZ1CH7NeKChbLrc8/F+glnptpTo2VhTx
	nEfQI38nREobm6R26M1GItV0liBo/fpc7MAX6OZ+aVRVR4OqFfYPm9p0cDXYgfwwWwVChVj9NhN
	gRXg4lHCuShYiVPpS0m5sWbHtCnt4Emxrbz10+FBEKdsCiQ69wI+VgX5r2CHsCwrzEClDYj01ky
	qy0Tq0=
X-Google-Smtp-Source: AGHT+IER4mhtcWdcAmKKzvqaxnbbJi3qLGKAGrn6eV7I+ph8BjxVXSJNlfcT6cu4E1s0A2+8IrS5voWhRsY8NjVyzR0=
X-Received: by 2002:a92:cd8c:0:b0:3f6:690f:f30d with SMTP id
 e9e14a558f8ab-3f6690ff381mr12479565ab.10.1756967677308; Wed, 03 Sep 2025
 23:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-4-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 14:34:00 +0800
X-Gm-Features: Ac12FXwg-10VYCr4877V3xJ5f4vjCpCVH_zTdEsJTLW03xp9bCz53hC_PG8FM24
Message-ID: <CAL+tcoDnrDCEGEggRnxxmFOV1qODr+jHTMqjW9idD0p8w7jTSA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: use tcp_eat_recv_skb in __tcp_close()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Small change to use tcp_eat_recv_skb() instead
> of __kfree_skb(). This can help if an application
> under attack has to close many sockets with unread data.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

