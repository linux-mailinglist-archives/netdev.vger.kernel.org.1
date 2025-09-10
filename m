Return-Path: <netdev+bounces-221592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB25CB5113E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11A11C80D4C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24030F801;
	Wed, 10 Sep 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpVYH/di"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1830F558;
	Wed, 10 Sep 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492962; cv=none; b=AzcHUNjnXKjzdRCswPpuv5BGwiVeCp+4bA7V6xkiCVRWZvw+Kt+1tNLROcui0+Bun++y6fsZyo+NkUyP9V5pMlFsW1odkTw6RT25T10c/cq9aeMBTfAIh+kkvN4i2bVyUu7s3H3pGVT1kxjrt34h3B8wtl1X6QNsbZOsjhP8rUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492962; c=relaxed/simple;
	bh=1mTwkUq7dRAhbqn/fyhOeIAqtw/i0fbkfFE21F31X28=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ozeOnD7ulU0RgUgbwqAVy/LVK3bvc+5u6ScPvo1cjfABZ6yVyLSEgAYMI3IaCt15RhbdrESplmZ+GfNnITpOKI05A2KYyXfUT4RP9bHoMIvJJXGbDTHcjQSX4bbTTKNYZvG+FxSgJXMbXlQUCV1oyqEVCHFerpF6UIXfhiRF0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpVYH/di; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b046fc9f359so1146605266b.0;
        Wed, 10 Sep 2025 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492959; x=1758097759; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mTwkUq7dRAhbqn/fyhOeIAqtw/i0fbkfFE21F31X28=;
        b=fpVYH/diGkul4fPuInIqNFRHiLZqVta+VVNSsJAlIrNzZCNZxz2H4ECS7rUmbWtn+5
         7cdlg8SvF+qJlUZfI+IN3+Y7bQBq4aK7hqIY63VRtuRNjG6chzP8ZI09vs6DAOtL1o4a
         g3eAjkgxDChDKjl3u3hm61zFvsec9eMxHnEdAVOxPS+VEc98/zN9xfZ7JGNYHsrKtH3K
         SU1iZem/APO/PkwfK8KrgTG7zAqSXxj111OwhUs6Cn5vnfWSWsF0QcWSg55LZ6f6YbA8
         owgQjFcfagiRjpJCLXrNhPupvp1p+B+/J1jkOccBJLSdUW/rfIvHSf4h2uS2ajDpF6Hs
         1Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492959; x=1758097759;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mTwkUq7dRAhbqn/fyhOeIAqtw/i0fbkfFE21F31X28=;
        b=dwaB8d+qhQ47XMctOFef3ehTkqtdBcFqgs9dEmqlN5YCujoQvXOcs5p485ZTjmpPwh
         WKH9utLckeUtP4ambJgpLkyFL81tCsEWg3geROLXLmXgwsJpIXgiwFqtVdqcKtskBn1o
         xRqpuivmLBZcA7btP+XYe5/bq08KRN5a8GPklLhQyHQf3nOy0bwjsAZub58dodhkobAp
         AL3lHhK7C8J9Vg8WWoSORBM0H8EQIfBYqx+RyqLWaegBFGfeMJGgFwqMK8110S3QVJaa
         uGIvEhxVok9oB3ZRVknz90JeqKiEr6G8KEXTYx6RhlqGmBJ3G43KkYmH7G4HN++HJEpT
         m+PA==
X-Forwarded-Encrypted: i=1; AJvYcCV7BMAxHnkYrLGnasr6ssmlVtKJuriW5MYZMoTTDOBLLaOoTVGwo4uBg9ews2OR1JD+t7z9Cvx7d66KG1M=@vger.kernel.org, AJvYcCW6//Fg+JFTYVMfUxzuNnIUaaD26IpDPwobqCg56oTi92KRsSPlrdFOzPgqKo+d8xMtuldbU66J@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXCZF9D5vt60alqDE0+DOSXx9ySnq6IDkEqfY/xPi8aArs3xf
	CXbQ1KGUWEPKKpScEXmCY1Hb/LYE7M/pXNraZXK/OUXmNu9nGH0Ks8Mc
X-Gm-Gg: ASbGncuDDsgwVXUt45ceXcnKGqK12+I0u64QBanwvvdWJtgY5z9YQuWfC6jdNAt1OQI
	ZlC/Jux8Wqdu0yiVl866i+nm80kqUJe1WbPd7lValWrLiOUMrYJOltRHFOqw+QlWYaGST0z9FJl
	IX7pDmMt0VwrQ41K4wNUDEz4HpNVLaTiosfurmQvuLzhy2ysUthZzv3QptnapfW9Fd8lo9auU1f
	hxki7r/NQhRfPBNvUdmgJcFqc0CJUwYk9YogJSAa/Y+4kUeNCup1dyRoZ9EpgZKXi6V1Dk62US/
	juZgmMXZFsGagKAavXVVVi1bJv9ChRvD7bhPwX9buCIID7HOn3gU7qL6F00HVU+XxocYHBoamiW
	nH9bHClBPg4YSVUTQ+w8k9qjmOyfUyBJRgqg3siPC3hc3QjcoH2aqu9NDkiG3dWFo2BXVb5LnC+
	9UZA==
X-Google-Smtp-Source: AGHT+IEGlLGLHWy4VSYvtPlZdL0zIAxuRa0BqhKCh35i4BIZvTkG53oBP+b+dE3GST5/RJnfR/ncqQ==
X-Received: by 2002:a17:907:2d91:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b04b16d300dmr1359997466b.58.1757492959169;
        Wed, 10 Sep 2025 01:29:19 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334b3c0sm125451966b.68.2025.09.10.01.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 10:29:17 +0200
Message-Id: <DCOZ9AOMAZM0.G789W69TWCUO@gmail.com>
Subject: Re: [REGRESSION] net: usb: asix: deadlock on interface setup
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Oleksij
 Rempel" <linux@rempel-privat.de>
Cc: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
 <regressions@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com>
In-Reply-To: <DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com>

On Sun Aug 31, 2025 at 10:50 AM CEST, Hubert Wi=C5=9Bniewski wrote:
> #regzbot introduced: 4a2c7217cd5a

#regzbot monitor: https://lore.kernel.org/linux-usb/20250908112619.2900723-=
1-o.rempel@pengutronix.de/

