Return-Path: <netdev+bounces-98490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB08D1988
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DA71F22F50
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F9D16C848;
	Tue, 28 May 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTZlC065"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8D13AA3E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895898; cv=none; b=E3FTCnIuc22TbC6NWrf15lENUzFJVDvttcNjeitxkOQ3C3u8KLLAHeOpLIKtoYNgGAFWDjiC1hEZD7NBOVtrjuztoQJA7BXJ3C39wal4nvPioGx4pIC3DMRDTgC9kk5dsXJtcAgc5iCi3mMrV/qs1utelWns6D5C2R6yG+X5wX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895898; c=relaxed/simple;
	bh=GKNNsnpA7oWIH4ewJ6j4qq8h2A6X0du/6J4R0lCXUVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuWrx/Fn22WsqxF7FKADkUiquQ9x4zEICzMkumOsl2Sr+vX5/UsEnoqsc0fvjwBU/5g3yVozbeo3QEQiwEMM2GGiQhT+r+Xc5+KbBtPKYXlrN8P0jHqvm6Wq+GyHW8J2MicczUA8GPJyl3PX9qwwAQtjl42ZbGHYPQoTQy+Et58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTZlC065; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57863da0ac8so25015a12.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716895896; x=1717500696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKNNsnpA7oWIH4ewJ6j4qq8h2A6X0du/6J4R0lCXUVA=;
        b=fTZlC065sETo6A0khgq0pGqAZUUdSnUFWNNfjACghHkCcmKnTWpetlh0JTeLaKXbU+
         gLOP5yEP2EvMroN5aeGQHMQFsbWkM+D5/N23yBtwb+k66kA0KFeK+ZxrAFSAv37nfm4t
         MDYwgBTxfRlyOqRFh+U+sKtWDekUZ3eL2RMWDJmQ+LyS1AANCSV26KsvOmGYVMRT95I+
         kaaYCPS4x8icjZqueaczBSEJH1lsMfqdMNRudpPGVzRv0aPDVRYJifyhkl1NYeTCjOdZ
         fNaJnWn7lOuxZMy41xKWefqZWJdi3v9wXzCx3N5neMTONqZIDBmOImnGIpuXIxAF+yAP
         O/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895896; x=1717500696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKNNsnpA7oWIH4ewJ6j4qq8h2A6X0du/6J4R0lCXUVA=;
        b=CX2yr3e+t0Ak79wCFoTJAXVg8UvLyNeNaXO7n/QBOWqi/GRRKpzKa6fjoexxBmIMgJ
         3rF339iyUKCqvh6GB1cVfhx0OaBzYy+g8+09CnRMkq71mJ7NNZ6HISqXsLo91f64vRrO
         DJ18mNDUlOMl1o9VquoGbLEkid1h+snj5N+4vrgE1kTfjNIrbsra+Ll2/gCF1VE0A/22
         obMHpy3E/xIHkoSU5j/GNnPUnGM0IIsP986Zy15Zurcu4ywHV9ILJIKFPrFJZ8cj8LJR
         jCECRGVYJ0DEOIZXmv9iug+FqB64YuYl4+k/d8yAGTcW+bFTakmzGNx5YsGzVajleLov
         lVkg==
X-Forwarded-Encrypted: i=1; AJvYcCU59irh8neYqplaTB/TPhneAhWh4/Q0u7KBASQfNl1k5T3x3T2L6SsopF3mLjGwEslJunvfStcfnPEhQlZi/2btqki6zaB2
X-Gm-Message-State: AOJu0Yw56wWTpDDQxmNPfl/yq8xPXBToH7/wCE8cSbg/K6Snw37g5Q8S
	X8kZxAAE/obz4yQnJMWpDOfbw3hqpk/qc/B/vDiHvaSawXo/ONzukJBbBPqnTgsSGqID4TpAPJK
	zLIN4B9FgTqbfOsLZJy6fZ2jvifByxu5b4SfzyDAuhMuPdQyN1A==
X-Google-Smtp-Source: AGHT+IEkLZ/K62qhkia7TtZh+6b3vc2BmBrIfOlPf6MVbZHNyL3334xTXaDtJVIOrC0Drq/oP754/T0hH9lptvWmCHI=
X-Received: by 2002:aa7:c58b:0:b0:579:c2f3:f826 with SMTP id
 4fb4d7f45d1cf-579c2f3fa49mr317934a12.4.1716895893688; Tue, 28 May 2024
 04:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
 <CANn89i+ZMf8-9989owQSmk_LM7BJavdg7eApJ1nTG6pGwvLFHA@mail.gmail.com> <cace7de5c60b1bc963326524b986c720369b0f1d.camel@redhat.com>
In-Reply-To: <cace7de5c60b1bc963326524b986c720369b0f1d.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 May 2024 13:31:20 +0200
Message-ID: <CANn89iK=oYdC=ezujf+QOWsbVEXDx1vLLV4Cbd8bJH+oU+RDiw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
>
> Waiting for Neal's ack.
>
> FTR I think the new helper introduction is worthy even just for the
> consistency it brings.
>
> IIRC there is some extra complexity in the MPTCP code to handle
> correctly receiving the sk_error_report sk_state_change cb pair in both
> possible orders.

Would you prefer me to base the series on net-next then ?

