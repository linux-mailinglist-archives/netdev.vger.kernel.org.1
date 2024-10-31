Return-Path: <netdev+bounces-140815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E49B8582
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A801C2186D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF491CEACE;
	Thu, 31 Oct 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="disxoHPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D871CB51C
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410937; cv=none; b=h2BATruKWIB1GRTcXAfXVrlqphYsmPxWHjBv+08ZtqCHxFC/+NFeJYAhRfVVL85u4XtKiUIn2K2QKE5hfZVfP7DeAgHdBkRtAXB9R5re1/+QixKe7oaWYwy21qdhKkY+AcESOWMCE2R54qmi8WmKgrkIGlHxuFIxKoHnQ8wd3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410937; c=relaxed/simple;
	bh=qje4o4Km5X0xM4CWv+LErCQA/bTsL/4zncexCqcgMDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VU/OQsz9wPiTkHh3mkUixcCOP6YBrbadd3wegE/X0hP+/WUn2EQuwfiNGdGJdAqBdVGOTe/v/3SNSE6wQJU9GBbh0utO21U4TWaxFvNn+wdObO2TpDgUBh5/M7RfbAmFLS1lda6rPRvUWIdYw5uqV2/df7ry9T8aquGVmoCE4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=disxoHPd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so1854973a12.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730410930; x=1731015730; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVoj8LBe60pfc0HAB18NgyRuMmJrHLNOYpy+LUyLjmU=;
        b=disxoHPdG8pF1oLWJRmDKnYGjAwQ5Iy5H6ugH8GJpM+AkZx6TUAPqAtSlSI34Ta/Ma
         EgjpvcDYPvpIauQAeHnv00MimP1IHGuHIGIa+dHI5cJrsOJJfb9sS5nSzrnBa1i/pld7
         xEr9bFQggYWBoTxIC4DD7Qrqs8WKoQ0byM0k31/3fA/l9l5PjPDjSm8Buq15E/83c/lx
         3n4N3o2MWpr43jQgy+BqdOXiJ7YYETsTMaOWErDH+NajH+yN7loUXz5818SO9BknP4S4
         J43Ga0QF8YGaX+PSJiiYnI87Ps7VzwP8pZ0gXJdf+FybY1E/kAFtKh2lB64PUugqcf1t
         pQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410930; x=1731015730;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVoj8LBe60pfc0HAB18NgyRuMmJrHLNOYpy+LUyLjmU=;
        b=Gnm2IffMwpBoE9yTfI3pIr8u+YyUCwIBfI4aN+zhlACMCsH64BxgP9EEAZPSNVWl7b
         CJmoz2eFAzqFz/9mJFPeiXJiIAjxx/G26OtjlcXgl3id67pQuDi2nRoan03CPcsjWze7
         P5ZAKZr2nAj8zhiT2GoUDF/D76b2MpjvJJQoCytvImYhCnpqFUFhAM03Y5JW41KFKavs
         vis9riLGl0BulPcI1WMUwGrs8zZShKlIKXB4pTtke1u9QIDhl9Dm8dleK0XwjNcGyBHd
         XJG7yV/V59SQBCTm/F+KiVZvcoXmidfR4dwYRJXxUBKG4eD1cchKaHWlXMtgj3HoC3F+
         VbTA==
X-Gm-Message-State: AOJu0Yzbq68U7C/Hq7gAJ8GvDmU+8ezrLo3/DLHKAvNLh3ELPqHjTaLU
	3OLc0LtjlrUjrsWaGgYAr6oPPgvFczxbyBjf48sBjx5e11u6ukCs
X-Google-Smtp-Source: AGHT+IGqpU1igfWpwh18ejvEyajAn0DggHXwC01DBR66K8MhJsDjffPEIYt3HSpgqlmxE22Gz+21YQ==
X-Received: by 2002:a05:6402:27d0:b0:5c9:8293:6cc2 with SMTP id 4fb4d7f45d1cf-5ceb9343309mr1023855a12.27.1730410930201;
        Thu, 31 Oct 2024 14:42:10 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af9e:3f00:f876:f664:2bd5:aff4? (dynamic-2a02-3100-af9e-3f00-f876-f664-2bd5-aff4.310.pool.telefonica.de. [2a02:3100:af9e:3f00:f876:f664:2bd5:aff4])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cead91061bsm859616a12.74.2024.10.31.14.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:42:08 -0700 (PDT)
Message-ID: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
Date: Thu, 31 Oct 2024 22:42:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] r8169: align RTL8125/RTL8126 PHY config with
 vendor driver
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series aligns the RTL8125/RTL8126 PHY config with vendor drivers
r8125 and r8126 respectively.

Heiner Kallweit (3):
  r8169: align RTL8125 EEE config with vendor driver
  r8169: align RTL8125/RTL8126 phy config with vendor driver
  r8169: align RTL8126 EEE config with vendor driver

 .../net/ethernet/realtek/r8169_phy_config.c   | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.47.0


