Return-Path: <netdev+bounces-150716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D69EB3D5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C5C1882936
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983641A2C29;
	Tue, 10 Dec 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gvv7sk2a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED61B394E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842014; cv=none; b=YIbx/6ORGukLv7DFTVuVAogpGC24I9Kbo4+5fXGevdiKxd8zts95F9wMDZ11M8sJ5BIDcFGDWzAnsfrYUSrtO72PzvvQmIidL3buILp3W0IaKtpfCIRFZBqww/OHLTt+bYKNPhayHpeyOFWY8fHvdR0ru5/0wEJ719QfSTjqqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842014; c=relaxed/simple;
	bh=Nl+fEKPU8cy+sv33O8Rg9ideXyyOb+2XwmsRLPB7s8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6EdChNI8YyAaVIUoZKWtbyhWsRaK9xhDvc5xfZxGhfchZY69hRDDdAYjTLqf/gCZo2IO8NywYKjcVoXHwBIxlFU9HJmLCvgbIohq9qlSWfVmB2hJnqKt9Ja3z4gJyX3guGsKDL6knxVIViBSkGRa6dEHKZ+zyiwxisnn4ukGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gvv7sk2a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733842011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqI6eO8t1NukwlxkIOkI4UYoE5e/L4idWgQlEabBPtk=;
	b=Gvv7sk2aun/yfoZFrvI0s/4BlTSNi5GzX2X69Z+TcW+0yUDaRTOVBx6Wnib6ReHI7xfTct
	Z31NtMP4OppjgJV3muMXMDUpINXgeXcMqCjLI+y0pXb4O66Eo/bTFNVkiH/gC1Cs4x/24x
	l4XCvV969GkkvOj9O9tXF69gRyyKaW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-MXBCPpZjMiuQ-3Ythu_FBw-1; Tue, 10 Dec 2024 09:46:50 -0500
X-MC-Unique: MXBCPpZjMiuQ-3Ythu_FBw-1
X-Mimecast-MFC-AGG-ID: MXBCPpZjMiuQ-3Ythu_FBw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ded5e92aso2229496f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842009; x=1734446809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqI6eO8t1NukwlxkIOkI4UYoE5e/L4idWgQlEabBPtk=;
        b=IrTo5NE5YfgVCBNjMXHoGksIKPDLmxAVwTj1kYIQdaxLDitfYKSzMQ8DeKPr0rSlKz
         g4jbEud13ZgSwggscHaOxu3drOW08CLYFOr3TU1tJDXPQKGV9UBvE6Jx7vIwtA99LL0t
         d789ZrK7k29iyknGQyfAmtkBq7OpRoo0uGd3gTF/4zojBm7DmTFtoJQ91+XTyhkSn/CF
         9RMY6kUDpVvlH11L2KyRIOsEIfZy79E92WwutY7RzrdM9SekFvP01dii1/IH5jTZK5WQ
         IR6br5lyKMiYr0foRzzwlRZHmy+r25ClCKGVdhefjU6gFob32HC6qq5akApzlQZBCA1G
         m4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWhdCT619cXdhOhn0OphPZkZQcR+wcgVBkF25vJK+4UkP7EcNAfGeslQJP1h5taezepvcZUo9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HivmrOlrre9+svO+QKvTh6EOMMhA8txYvZJSqA5qtlq75eHC
	U/qylrNpR8ASzNvxTPOH11lQw43mmes+oH8WPbVWGeKoDJhPcmXI46RScIqQKLkRtNP6n4ir155
	W7TrZ55o+lCKDyGbFtdGM3pwACkC3nB8ISDH/rf5CXDVsyJDVwMlMjw==
X-Gm-Gg: ASbGncthkOa+nYXLhjKZlCTW/fcl4dQGoTFv78akG/2nq7oAsaqFAoDjo3Su2h00btJ
	THNcJ08T2cPj4yLyFoEm2n/cti2XDvQnZEdHTWSdjaMgl2mV372+0UJBiNZKfhBuEXx9H1ctvO6
	WlytwRoqBcmZYaBtxCRtmntvs+NL/Pz11bXKayM8v4KkyCcrhzTf7VoJ/rJhtAJnmRp/KgpEnMz
	t6tRUYV6t7nfklbQIKDPsbH0JhTID+UjkxGtfAs1BB4KiV5n8CXNx8ML9S3vNiY5q+qFHH4x0T3
	tp5Cy4Rer2jlWXMvcy/S2+j3Lk+ane/y8mHmWEB89Sr5g34=
X-Received: by 2002:a5d:5f53:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-386453fbd04mr3647144f8f.53.1733842009378;
        Tue, 10 Dec 2024 06:46:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHit5L/EAWOuUuBe/IVLddIr8m2DHFTsZMzRiWDImjPpVldvrflyWwOFb7AVtYbVp0RnQRMsQ==
X-Received: by 2002:a5d:5f53:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-386453fbd04mr3647117f8f.53.1733842009006;
        Tue, 10 Dec 2024 06:46:49 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.station (net-37-119-201-53.cust.vodafonedsl.it. [37.119.201.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf3cd1sm15887783f8f.11.2024.12.10.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:46:48 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
To: leonardi@redhat.com
Cc: mhal@rbox.co,
	netdev@vger.kernel.org,
	sgarzare@redhat.com
Subject: Re: Re: [PATCH net-next 1/4] vsock/test: Use NSEC_PER_SEC
Date: Tue, 10 Dec 2024 15:46:32 +0100
Message-ID: <20241210144631.20573-2-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210142434.15013-2-leonardi@redhat.com>
References: <20241210142434.15013-2-leonardi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Series adds tests for recently fixed memory leaks[1]:
> >
> > d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
> > fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
> > 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")
> >
> > First patch is a non-functional preparatory cleanup.
> >
> > I initially considered triggering (and parsing) a kmemleak scan after each
> > test, but ultimately concluded that the slowdown and the required
> > privileges would be too much.
> >
> > [1]: https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
> >
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > ---
> > Michal Luczaj (4):
> >       vsock/test: Use NSEC_PER_SEC
> >       vsock/test: Add test for accept_queue memory leak
> >       vsock/test: Add test for sk_error_queue memory leak
> >       vsock/test: Add test for MSG_ZEROCOPY completion memory leak
> >
> >  tools/testing/vsock/vsock_test.c | 159 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 157 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 51db5c8943001186be0b5b02456e7d03b3be1f12
> > change-id: 20241203-test-vsock-leaks-38f9559f5636
> >
> > Best regards,
> > --
> > Michal Luczaj <mhal@rbox.co>
>
> Thanks!
>
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

For maintainers:

I made a mess with git send-email, this R-b is only for patch 1, I haven't
checked the others yet.

Luigi


