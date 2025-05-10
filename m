Return-Path: <netdev+bounces-189481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BDAB24E1
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BFE7B6E62
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19503238C34;
	Sat, 10 May 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ml5p0kfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F11B043C
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746899850; cv=none; b=POXHd3ReHBLD5JMLan9RldVYXI++vXlI+IMGjH73z7XxJmmcYBsQuC5g2ZI9TZxCMkRvboj/lTJoKLAh3VCyfiMroCkZcE6IzUXk7ty7GE2RCQyf6e8XwZW4NVjIJ7O4oK0HMkEc/xCspxTWoNB1kIUr9MtaJP6xa9/XHsYoOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746899850; c=relaxed/simple;
	bh=d34ipLqVZ9iGLUvQ+y5HF9s3GNDo5n5UVO0m4PXFUMM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ERGX/4DLJlWFGM0O+CgxGXG4ReRC/FTHpXhflLooX7RTTg4tT8CpcKj5VSii7S0im5CCyHqSiIC7g0pdwZzHktZRjhSaEk+Wnk8JpC6tbp2evMP3qX59q3VaIPYQsCZ3CqnmMsEtFuOJwt244s5c/iuXlaq2GZkIZlXTn1Rldqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ml5p0kfC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf680d351so24210315e9.0
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746899846; x=1747504646; darn=vger.kernel.org;
        h=autocrypt:content-transfer-encoding:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d34ipLqVZ9iGLUvQ+y5HF9s3GNDo5n5UVO0m4PXFUMM=;
        b=Ml5p0kfC1oimuhd8zURVIseQ3VgTDQmdhH5n4EgSpKpUkI5qeOLs/XrYSMRX0Yi9D5
         fH00pTfiWH2N57uhEE3jdkvWWDxEG7lhXCET/0xnZLaRQaa8PNwKN75xNA84L+MJ/ZX0
         PkOvwJ1wHv8qSwJ5305eHx/WErugQN1DK94OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746899846; x=1747504646;
        h=autocrypt:content-transfer-encoding:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d34ipLqVZ9iGLUvQ+y5HF9s3GNDo5n5UVO0m4PXFUMM=;
        b=sitHUSJW1t282RkVimq6S/MQYq9JKmLdhQ6LEwWdHSA7erY03BsrOYELOQT1sXFwpt
         FfyIccDSQrwC0mNd/hl07w/X7Zbq8VUCLbd6+JM42ZvIo0STe7KUnmpeHuz+hCV7iKft
         E/w6aCxPWQLlvPWa4mBwNZahQSRV18ApPFiqwgAnGqyVJREER71FJzNrNftHraoBtPvO
         MAcjPrxyeeLOkfLFhCo11paL40Gp8tbcqIu8Xcx1Djev/MCjpHNm+/v3ZOm2r/j/rbZK
         RZrk4Arz1CGU55QMRNZ67AvehB5JBQNdRfhtcB3WX8G3cmWpC7eG6gsXiW7bUsl5No6w
         9BNg==
X-Gm-Message-State: AOJu0YzPonPpgNFRyiW9dBp5xRLUf7tnFKzIQqu+zGhsmYTuqT4y/ooh
	AAsgEmzD5jObznm5sgQEvzWT+6Yq0lXLy+KkyyIltf2kWX+CxMNd3OSrUgCcFA==
X-Gm-Gg: ASbGnctsP0nE8udAHQg7Hc2X1hI5ZGUckpiosP3v66XWO+lzbg+LHRJ5aVhyYGsSahT
	3N0CXfI2lWitB3uk3VnX0M9BmcPABdO9ky6n1/wz+sKCDecKhpmMHzAXVg5SHH1BwL6O/SSLtKv
	od65dIz0TGXUdWwA0KcSTWSE9/BIUnVEBZuRiUyrJHcxSs40J7iO2H8xhIHnNBOIuTtyOQJsXwU
	/bp35KgZWLAD0Kj0EfNOkVP9NAB96qNGdLpjzucnrcwo8Gj/ZXLILXRQV8+gTgaTDX8anBFmi8g
	tV7S9/tkDSbMWs0uO6OXfnqhl1SkiBleGs5mOAgElHgsN97N58bhY+hiIjKLNV5vWGkDhC+x0HP
	S+3SQ/P72VEcG5mVFOb4/z53TvFY5gDy4FmZsUToVv22caaVo4WA=
X-Google-Smtp-Source: AGHT+IFd2LnzlZ3nhJhhZUlH+mzupRSVkBvDToFErP6/IOhrQ2ZLeF9KLFljIhby9GdMo6RCH360iQ==
X-Received: by 2002:a7b:ca58:0:b0:442:e27c:48da with SMTP id 5b1f17b1804b1-442e27c497fmr8459775e9.8.1746899846307;
        Sat, 10 May 2025 10:57:26 -0700 (PDT)
Received: from ?IPv6:::1? (2a02-8428-1d82-4101-9376-9a2f-6774-5cc6.rev.sfr.net. [2a02:8428:1d82:4101:9376:9a2f:6774:5cc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d596a5e4sm78696455e9.31.2025.05.10.10.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 10:57:25 -0700 (PDT)
Date: Sat, 10 May 2025 19:57:19 +0200
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: b53: implement setting ageing time
In-Reply-To: <20250510092211.276541-1-jonas.gorski@gmail.com>
References: <20250510092211.276541-1-jonas.gorski@gmail.com>
Message-ID: <B4DA2F66-16EE-41C9-B816-3C5061A30C20@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
 3LBXw4WCw3QhOXY+VnhOn2EcREN7qdAKw0j9Sw==

On May 10, 2025 11:22:11 AM GMT+02:00, Jonas Gorski <jonas=2Egorski@gmail=
=2Ecom> wrote:
>b53 supported switches support configuring ageing time between 1 and
>1,048,575 seconds, so add an appropriate setter=2E
>
>This allows b53 to pass the FDB learning test for both vlan aware and
>vlan unaware bridges=2E
>
>Signed-off-by: Jonas Gorski <jonas=2Egorski@gmail=2Ecom>

Reviewed-by: Florian Fainelli <florian=2Efainelli@broadcom=2Ecom>

Kudos for wiring this to bcm_sf2 as well!

Florian

