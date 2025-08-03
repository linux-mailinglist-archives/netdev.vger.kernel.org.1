Return-Path: <netdev+bounces-211494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E2AB1967D
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 23:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BD51894148
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C886359;
	Sun,  3 Aug 2025 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AYJuuAm2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF012E7F
	for <netdev@vger.kernel.org>; Sun,  3 Aug 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256724; cv=none; b=JsGhO92PpPzYgJh8Zzl7qVepuwXEY7Jvk7AyLihgQwqRPtajzPmag3Mzc3P+++Ba218MGZc3R8wxMlaeD2yb23SDNFyUTcTnFkwAElEJM3x6cRHUMRw1az+oGVfFWG3g8LmmhaSjY/jQBKS7KHLUfhbK6reh9blav5bUG4NknrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256724; c=relaxed/simple;
	bh=kebtq0RuDNNDVlCeB5XanF877Q4p84byR6VUvwFsSHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=iUXHBcp+43b7gTpKg+uOEMsrUEurwbBrc48Wc/sP7o/KTwSnGCzx3PIkkTh+oEa3d3iJFByR+VQA7OfONrVfNv0R5UXJSFPG+XLzp0YaQo2eINQa5E/yd8QQwGbMyBzDX5Cyz6XaFSwuJuB01/il0F3hxpDSZe7NO4aFIWFHCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AYJuuAm2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4560d176f97so30238135e9.0
        for <netdev@vger.kernel.org>; Sun, 03 Aug 2025 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754256720; x=1754861520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P+RNyAbGWRp290LAF4vq0TCqvvldMoZBKGxLp8aZ8I=;
        b=AYJuuAm2rZxN66KGqZPJN571ZR136Px5CwyXOhpHj/UQFSFgnOeEDURJ9c4PXRh3gg
         +mbwrHRQQrn9yuxbNVD+3QZoFYOsJi4o3avoZMf6ea5gHwXRvS6Jx7fEodAlfnMXknYM
         940Tl7mNjLwCB75w5u6iHK0yeBvSdPwXfD5sYGj3gWcscPdU9nNLqefIEK0G20GE2ARf
         6mGbGl/Jlscg+eTZC4diBJskruc/gITEiBx1dwxCGsCj87cN8EEQa97a3i4OQ4lFtbzA
         zQjfzBMV2OzJTXo++vMUfP6fMhJpkzDbU7mcBqo+kolc5W9YoeS2Wxzz9LEVk/7IlwZe
         k+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256720; x=1754861520;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P+RNyAbGWRp290LAF4vq0TCqvvldMoZBKGxLp8aZ8I=;
        b=Jsqb13Syr1D0jfBd6BvhOX0m5fuYuQ42TY7bqoqdw6DeFQXDLapCn1+Rb7PWdtzrE+
         dGMI8dSZtYkxK6kUJ227SGCi63WoD5RVRD2hnnYUm0eFWYYQOl0YGDI47d8GGAOsA0sX
         3LzT4Z5/syGtgiKEBAwyH78MNvMhdCT4AFfUbw/EOrLZ67sQAz3TeOL4mgq6wVzHVcDd
         /VJuqU6P7K0jv9l7x+JOITKdfdWG9wGHGzDSS08KdbImnQ/Cxjo3O2nCa4utCZeXquIY
         OHpffOhZWRPWyvDmiaw5AQvYXaHfUYGP2uv2GqKQMQC4fthnosjCGcdg3xUap2s7BLN1
         NvLQ==
X-Gm-Message-State: AOJu0YwO00RqahtH59hnT99JlWxbiEYscfCmXp/vqY6vrAak29xSB7kt
	/hIm7rtp1ZlEsD3GyrAhtDqEJxsLmjpjY1NBKWtK/QYkSh2NFeSfW8KAT73je3nsr1T5DyXws7T
	VClAE
X-Gm-Gg: ASbGncsvWgjMd442PL/sBvXFtkxAukQ4hbAQsGtBxPhHwo5owtM9g6Fw5b2ZKS+yYIe
	0S7BOiGjpjkJb0izJeRAdt8VtPf6NbdTZ9mIlSwSggciKq49cwtwAbla508VF3VWSD2RI5mq3S+
	vDyaC0J6fC0l2S22fAq5DGYkMYkH+bR0g+Ur8YmCYbyshqKh0BZRoXOPo8/33LR/AaWEoeWyv9C
	qp/jsS4yPPPl5EtGnCNfNbK14+ZCZ66kFzx1dW/isb6R9eRgFzKwqeIFUnY5oYsfzz7ZvBZ7DpA
	x7cNDlUT6zO8xiMhaM+lsLbsQZE4JvaovQztGEYxH4bs0qUUmOX8Z5LIq35tlLDs1rSJyHz1d9R
	lFIy9hDPpDOlP7nFsVQIN4gdmeLQioVmCtZpzGSxKv1EJbO3C+YCNL6slgDKdoRV8n43sc4uyx/
	0=
X-Google-Smtp-Source: AGHT+IFaoxDij5he+EEMPpOcuPwZYBC5RQxpdLFgykxRkWq9PIhpvNXPJczi5y8U85jKNhAkbKRTig==
X-Received: by 2002:a05:600c:1554:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-458b6b330b0mr59423925e9.16.1754256720406;
        Sun, 03 Aug 2025 14:32:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm43919645e9.14.2025.08.03.14.31.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:32:00 -0700 (PDT)
Date: Sun, 3 Aug 2025 14:31:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.16
Message-ID: <20250803143154.2d700ad4@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is a smaller than normal release of iproute2 corresponding to the 6.16 kernel.
Some patches delayed until 6.17 because of summer vacations.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.16.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Hemanth Malla (1):
      Parse FQ band weights correctly

Stephen Hemminger (5):
      uapi: update headers
      uapi: update headers to 6.16-rc1
      bond: fix stack smash in xstats
      uapi: update from 6.16-rc4
      v6.16.0


