Return-Path: <netdev+bounces-196739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F9AD6228
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186E116227A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE95248F4B;
	Wed, 11 Jun 2025 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnfSWhNE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCC246766
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679564; cv=none; b=Fpf9MHh1oW0D8YZTh+lPEI92EIdJesZ9dktmoABI+gH50GqvLFdKMy1INLgjoYMFzeDqmkLzOaIK3iXOVVea2kkeMpfc3MkQmZH9iIU5mmCvKlJ/eFleBvfbNyLYUkEveruW3X61W1Z0SYrscHy5spB3BYf+8psb+RmmlJc/ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679564; c=relaxed/simple;
	bh=lJcNb+m+LrHIPtdT6t16yrrQCjtNIkMPamXEoDgkxPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR2YZ3X06OBI8qDTsIYDsceGCiCqoXN2YgPTtJqpw0GTdwSYQ4FP4Ttu/MAgFUlDkodw6qbjNtAc/TxcV8GYExPQTOveqyiQpm3rs6VgIM5rHbTjXcdKhPX83hV5n+8Ris0Woe1hNcRxULoJbjbtRKBtOGcHqoDJWVT1Wxugz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnfSWhNE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58197794eso32981cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749679561; x=1750284361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6v+Lx00PogSpTLtqb8OpINwiWwlsYccfvqmwc9X17g=;
        b=qnfSWhNEmnLo+96JaUmmKyqsLdGqWhy8YxkJqM2/p5rBgf2gomvE5Qbq+d10VBUAWY
         cKVvqyMFEZ2lixu7OLK0bfANSBJ59cn2jXdxA2tLPaQkT4NMSLkGNvGT8MhlyR5Dr5LT
         os9DykNyOMtxJDA6qbwukURoS8qtn9rS/RnfNrY/WdlBLBYMw1TELBiQN+x1/Ko2RzNT
         c02IN2+VgykqwhHDK4kF01Nu7BfLlxK3FHxQw0RZRt+6z50gUSAXKDTPlPGzMA0yySnK
         TlH7oZdEliBuEZRtC8yVBGDJ8wGbWwpm6e878mmiUyoBA8p71PrM8DIopTJv0npCwAJ2
         Vcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749679561; x=1750284361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6v+Lx00PogSpTLtqb8OpINwiWwlsYccfvqmwc9X17g=;
        b=F+AqIIqbiyTVe21GjkRDgYA6E/E/CvRpclpN6GYsmiaKxyhSmvfHXUz9B2jCZo/vsl
         8EXC3Rr12cv8WrTDNoBxi7U3ulqQudC6eV12v55xb/A0luaA5AtUVoPR/2gFlO1QWTGo
         kDOsouq6l3K7MgDWhQGQ5LJU5CqZw+o1BqK+y1xac+jShYk5BFqiCuO3SN/k3aIdM0fN
         IHw8FZw9bNQuWONkCX1e0+M9tOtWRlBVsdElhX3T1HrM5Vd7Noj/0HqqLGjf5Xt8KeiR
         E8gbHIAfR5U12HaWddXSX/rHf3sj51m0nMNEdwWl2anCirFWsIsKoZhunfywdDbAI1Gn
         c9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXTS6I6W0S+vha10ty3lqYsMU+PL59U5H7GaoVxzoKu77YUyQghZVVYf+MJbQyJyvG8TDoCnPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+o2hjJup3ZHtJjUuubS/vdTAUoCYRrAiCWJDF7ExYM8L0Rr9w
	582vLnH+12bZvTI9uggXphlqBZS6Vy9spnahP5F0hxynUoTgBpDlmekrgMSef25HhFhaV47FUst
	wVFpJYmeRaXXaeTGFBVIZawxHEzTPr/tNnADqUKjZ
X-Gm-Gg: ASbGncvCQNphGecFvlS3G82SRA1mCwpORDqf813nzihcNQSPEjcNub1tM7GX/XO2qi+
	nE4xXOX5/ZCgL9mZmrAh5azQ3KG4xx4k+i+R4OWtHHc+ykNKaR2qoTHLMPep2/CvlBrSfibXkb5
	xtEYS3MBeIHfdJuECGbxzwMezIE2PbcHHQt6E6Y+PVS5ytqJre7NIsuMAkxTnpiUo5tk1zhQ8yM
	A==
X-Google-Smtp-Source: AGHT+IEBY/UkjQXV1lMnORLfnY9FIZMyMUT3D+2LVLKUtBU9gMCFpZwOtsADD3cHrQ41s2NITvc+hR4EZITi3Ul7ziw=
X-Received: by 2002:a05:622a:1882:b0:494:b4dd:bee9 with SMTP id
 d75a77b69052e-4a7243a7933mr859111cf.24.1749679561232; Wed, 11 Jun 2025
 15:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609184029.2634345-1-hramamurthy@google.com> <20250610182348.03069023@kernel.org>
In-Reply-To: <20250610182348.03069023@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 11 Jun 2025 15:05:50 -0700
X-Gm-Features: AX0GCFuYF3MGPH4TMlK1EsMcjlLsjn5eZWHe_VzolC7pfg4XYeyAOBeZ_oIJfVw
Message-ID: <CAG-FcCNg5BWcqTBcMA+WYHqFdG-htnYXDuXZ=S+QuwhugZ6fyA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] gve: Add Rx HW timestamping support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, richardcochran@gmail.com, 
	jdamato@fastly.com, vadim.fedorenko@linux.dev, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Jun 2025 18:40:21 +0000 Harshitha Ramamurthy wrote:
> > This patch series add the support of Rx HW timestamping, which sends
> > adminq commands periodically to the device for clock synchronization wi=
th
> > the nic.
>
> IIUC:
>  - the driver will only register the PHC if timestamping is enabled
>    (and unregister it when disabled),
I checked around the other drivers and it looked like they would
register the PHC when initializing the driver and keep it alive until
destroying the driver. I can change it to be that way on V5.
>  - there is no way to read the PHC from user space other than via
>    packet timestamps,
The ability to read the PHC from user space will be added in the
future patch series when adding the actual PTP support. For this
patch, it's adding the initial ptp to utilize the ptp_schedule_worker
to read the NIC clock as suggested in the previous review comments.
>  - the ethtool API does not report which PHC is associated with the
>    NIC, presumably because the PHC is useless to the user space.
>
Thanks for pointing it out. I can add the phc_index info into the
gve_get_ts_info on V5.
> Do I understand that correctly? It's pretty unusual. Why not let user
> read the clock?
>
> Why unregister the PHC? I understand that you may want to cancel
> the quite aggressive timestamp refresh work, but why kill the whole
> clock... Perhaps ptp_cancel_worker_sync() didn't exist when you wrote
> this code?
Will utilize ptp_cancel_worker_sync instead of unregistering the PHC
every time on V5.

