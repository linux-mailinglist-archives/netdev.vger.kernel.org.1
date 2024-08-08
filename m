Return-Path: <netdev+bounces-116654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73294B517
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957FDB20FD8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC60BA3F;
	Thu,  8 Aug 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq4Qrl0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E76FD3
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084409; cv=none; b=tuBCraxy9AlYQyZmHrSNQquRTi2oWRJqIh+/biStiahAkAGIJ58a05KD77GzCi8V7LswoflYlBVhfITj8PFfT5q8k4DfcKSKHonV8RNQVGCOzlyQRnyfQZ5gmZ7cw5X3yghOoYiWaHhD1H9eWcNxUv2VgGzpsN0rOmAeiM4ooPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084409; c=relaxed/simple;
	bh=Z5k9G0db02yEHmXxmkEGgJqZYQkpPePYZyx7AWCsZJ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Rq5kJdQYydLklaI7r0G0PAHwuUXJ2qiyasLaQYAsXtTFWPydk9Z3Fb/ebDfc7+nuBEpDn6G0tSFTG53EJ+EK3aMeLpE0S4utFL22b32Em8s1qLT0v4gwlKPf+bE+wqqrcWYZAOxRpiH4dc5r5+paa4t6HD/1ooRuMJ+NT6RNyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq4Qrl0Q; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dd2004e1so27628585a.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723084406; x=1723689206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wANc4Ej9BDeutz7cYoGZQDWS4Nq8qKIXob9m8ZKcAQ=;
        b=Qq4Qrl0QQQHRVRURk8DuDr7qPx/hIdgX0aV5zyRU1FOA5IGHbDQDz5RuHzRiTTxhbE
         T9CXcI4FP/l3WNhpSc6HNvR4m9TWITNMC7epaSlpSElXCjUR0PReTBMAetDB07i7Gida
         cnall0+nNUMpjLzxlnmjVGTBRcAbRRX6xYOc55yFmplpSqulNSXsJynkz3xnsMo1t9UX
         AD9YNqtq+BZxamHlVzhIEbxwgVFt3LIYejr5noro28RWJGb/dJOrIFV4+I8UdlgBqq16
         SgDG3mZN/XnEc8XCaPku4pWaFbCBWRzKLk/xo05gXhCVatcjWj1I/0LJckI+jd1/tHMj
         9bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723084406; x=1723689206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wANc4Ej9BDeutz7cYoGZQDWS4Nq8qKIXob9m8ZKcAQ=;
        b=KSJTPhJSMFlNzehzhpUsQv2vXmgl6oF/O8K+84OEhfGSR98//v1r6zt8rUe0S3IH5I
         DfYlP7+oJGw6BzrMBGg0fl4/ByTbjrkiVol3ahlof3FY2y4PLun2T+LpeEwgC2bXk8/V
         ajNeKIpdMB+KIh0+HC6ZeSeRpcOYugDylsiowaUUmpOe70fI4eZ36E61nzAJ5jqtvicT
         0IKIIqcN1Q9dUgxzOtgzbDr0XmK8QSRni+Wtr44CIB3gkcEGiaGumgaaV/k0S6MlQtRM
         UPHsysv6gHsNmW0QUADv3hYlQXfKiAAsbcTyN5/gvUh0W3aHeI4q2iPG+4enEL5SG1q/
         ryWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlqYWA5uXFI/KM7yt8cUX3qwn4Ew16gv4bjh72l3krRyqsst3/v8l72wRPnCmmjYGzBtHxUMJ2M9KbnhojQPaiwJwsv7VU
X-Gm-Message-State: AOJu0YzrDCWEUfEN0WU6xSi0CBeUeXP1lcCIng+Anzd5nwAoFtPEvyjY
	nAMqXPX6qwOHm5F3+F5ll7qwXLRCN/YPi1nffRJD7PCftJynWdpYSqQmag==
X-Google-Smtp-Source: AGHT+IFTSbvDhqkYGjRHsYHsb+sYLl5fo3xFCSsfCdz9qcm2DIDp2hGe65LR0hNcqgzo5C9r7Wd3nQ==
X-Received: by 2002:a05:620a:1aa5:b0:7a1:e3e5:c8c with SMTP id af79cd13be357-7a3817b21a5mr52906885a.5.1723084406356;
        Wed, 07 Aug 2024 19:33:26 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1d63sm113002685a.102.2024.08.07.19.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:33:25 -0700 (PDT)
Date: Wed, 07 Aug 2024 22:33:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
Message-ID: <66b42e75a0918_37950029475@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240801-udp-gso-egress-from-tunnel-v2-2-9a2af2f15d8d@cloudflare.com>
References: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
 <20240801-udp-gso-egress-from-tunnel-v2-2-9a2af2f15d8d@cloudflare.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: Add coverage for UDP GSO with
 IPv6 extension headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> After enabling UDP GSO for devices not offering checksum offload, we have
> hit a regression where a bad offload warning can be triggered when sending
> a datagram with IPv6 extension headers.
> 
> Extend the UDP GSO IPv6 tests to cover this scenario.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

