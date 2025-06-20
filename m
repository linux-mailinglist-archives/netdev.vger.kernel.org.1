Return-Path: <netdev+bounces-199822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CAEAE1F3E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E987B21E1
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF52E613F;
	Fri, 20 Jun 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="dlCqraj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB459283FE1
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434302; cv=none; b=jTxke96+VJ+iCA5wM4JcSfwjLzm6VOFQ6W050GSkHKS+Jv0c2AyXgxkz47FLuodRKVpqDpnVjcrXtQ/iXI2gFrbWTbKJOPuIFY2cv1uMSMaJkxYQiYxVeqH3voiLPkPgjhnQtFL9wBewNdMwwikucRecj4P+2EzTnYJ4Y0FoT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434302; c=relaxed/simple;
	bh=lHTOwL9lvZ4ijeUppZwwhc+Vzcxx1dmkbdS75en+/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVyYf5PWd2r/HqbbW+SQSnyO+gPmhjHNB77/3ofvsVKVih3Q3xXq0NnEJEzh5UXAba1CMA9/OqFCIGsCwAvOpI14RGMsKyAM/+vSqOd07z9UGYEWinNbcfvqQeiTWggO15auvDRfngysc08CtauS7pdtRwNNVfYPRTeTM1qTbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=dlCqraj+; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f37b0247bso41217241.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1750434299; x=1751039099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHTOwL9lvZ4ijeUppZwwhc+Vzcxx1dmkbdS75en+/QA=;
        b=dlCqraj+Jzn7HgLEzDiwZLYPSr+73jzWSVe00jGnzI1bf7x7MgkU+WAhB3OpLPR2Xr
         692buocp3miHbHXsV7ibcDrUypEZQKjGMXhyYJGL7vTyDkDiAukTiNGAYU64gpHSRqG1
         Gfjg2/fLyXWvIC4l7AWhLptrvnrlKYrwpJPc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434299; x=1751039099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHTOwL9lvZ4ijeUppZwwhc+Vzcxx1dmkbdS75en+/QA=;
        b=Pf/ryUBDHrdOjN4NBgSdii2/W8QZKDIwcGiTFZOB+3Q+ko66ROED6WD6NOZULfKKFy
         MUstREzZqxd3t1/womnBO3Hr9OG6RnHfzI+Qi2vITt4kmSy8l9dtOniuIBgX2ASMwW7q
         /I4ndeqlQkianvYUiC4XEqOw2iusIJyez32xK3IFlyFzJGeE3IG64Qoc/2efvm9qVwwW
         Ttb//eXELPTgfHIoIwmttd5HT7oJAMUEy4ujjZIVk7HK0fS3Bs0OpqheSIDINmAq2Xdw
         LhpF3/+L1ACDwbqP7Pbw3Ft9j/5tfmj7BTRQwW+ChQNtVb6sttpVW/hE2bgUVH3/PMmr
         D02A==
X-Forwarded-Encrypted: i=1; AJvYcCVmvJ/tCecjGQ7cOYbgwcG+JSfZm8idNWvSR9FpBNcmQMcaaTGMegfI43DGXdsHUJDDMt+jWgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROBLIGiVgJvd4BOEYbL1edkUL+z/OL2Z6Uy/XmOpu27LBZllX
	aZEYcMsHWNHJRrqrdlWs2aOVcC3ev83IxGOg9BrIqTb+9Q1L9KDTjy6PvDWBxTAYXUu4qT46XyN
	HX6nUSCmb+WvMwWYCVULu/Eay1V/6lAN6ELN6bx6fHg==
X-Gm-Gg: ASbGncvtBfxe+h/lWokWgBX6nrZ7TIVtzjuotm/ScwNw4g+mEcQU2bFazN8dZaucKDB
	udKd71uQTTHPiPpCz1FabTepXoAeYv7+I2C+lu+A2VOohmMKwlTTmhPN/T22YwlNEprK5qPpchp
	VF1haa0Qj4c5satnpcRAMu4kJTBGh2NZNQLdwb252vbTh6o6Y2rh9l0X33
X-Google-Smtp-Source: AGHT+IGfetZb5YTOzADWhLIueyC418gbZDS0IQ33L6/V3exTYghPGnj+6eGEUhq/L4fKkQm1rR8S3IzC9dcb07MI32s=
X-Received: by 2002:a05:6102:1611:b0:4df:4ef8:8624 with SMTP id
 ada2fe7eead31-4e9c29d297emr697185137.7.1750434299409; Fri, 20 Jun 2025
 08:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
 <20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com> <20250609122146.3e92eaef@kernel.org>
 <CALye=__1_5Zr99AEZhxXXBtzbTPDC_KEZz_WCDDavjwujECYtQ@mail.gmail.com>
In-Reply-To: <CALye=__1_5Zr99AEZhxXXBtzbTPDC_KEZz_WCDDavjwujECYtQ@mail.gmail.com>
From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Date: Fri, 20 Jun 2025 17:44:48 +0200
X-Gm-Features: Ac12FXys6L7fct_1U66TenHgZHLNfks9sBYqKL_WAEa9WiwjarPPkDph6JQvCek
Message-ID: <CALye=_8_zGg3vnKtk4qrTN2RN7Y4yfEqD1G3Sf=AJSCwBcJkbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] net: Add splice_read to prot
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:57=E2=80=AFAM Vincent Whitchurch
<vincent.whitchurch@datadoghq.com> wrote:
> On Mon, Jun 9, 2025 at 9:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > Can we not override proto_ops in tcp_bpf for some specific reason?
> > TLS does that, IIUC.
>
> I see that TLS writes to sk->sk_socket->ops to override the proto_ops.
> I added some prints to tcp_bpf_update_proto() but there I see that
> sk->sk_socket is NULL in some code paths, like the one below.

To expand on this: TLS is able to override the sk->sk_socket->ops
since it can only be installed on the socket via setsockopt(2).
tcp_bpf on the other hand allows being installed on passively
established sockets before they have a sk->sk_socket assigned via
accept(2). So, AFAICS, we can't use the same override mechanism as
TLS.

