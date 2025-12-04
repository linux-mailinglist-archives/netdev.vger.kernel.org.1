Return-Path: <netdev+bounces-243547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CABCA3627
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FADE300E03D
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F63314A0;
	Thu,  4 Dec 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHzP+grE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="po30Ij9h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD619AD8B
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846310; cv=none; b=n/J+8if17xaMFCd8SUneweCkLBgi9rNWhh45xqoJ/VHtj2FBGw3RrXEfw+cdmua7znyAXL4/maSlX92k7p+va7RHK6G5I+dn5cjgVIN7YWgsOrCM35Iq0uXF5SmXERH1r1Nm0719MNb+1Fy0Y1mqlRtnK+HAc9IlTrIE81YNNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846310; c=relaxed/simple;
	bh=FdreTvf1w6SbCYIXQ3yPiXixekkBuUPqS8ciJpRvAUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLo7rO12PVrVeOQU/kguVbgrSSiNwg2VVHjzbu7fDcOW4uE1eaivU7Y5MKpvh9yGZMv8tjeP+re9R2DLvEWdGUr6gdSRAVohr+9OtIWV+tthocQ/8ltrcXXJEmlymY7UadPx0oM4ni7BMKNc54fvmZdjWy6EjCpjM4kvnuQAqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHzP+grE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=po30Ij9h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764846307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFLIr5RpOZwQW/XBO4InL4XCa+kmzOLYpY3+ymKRjT4=;
	b=dHzP+grEu6qGUegn/HisRiTCGMoiz046jM1TJNZCOPDy1DNlWhRtMSvZx3EAGx8+8B/UbQ
	+Qwj3HIpfeTbqXYSvvA+qmCTBvovJFOugoLnb6BvhxIR40WgyRoodoQ0I6QsbnQPE00XJ3
	Sb2drtOmL0an2Eyfdo9wtWCuULhKd4Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-qxihDx3uNZG61Ur6NoQbVA-1; Thu, 04 Dec 2025 06:05:03 -0500
X-MC-Unique: qxihDx3uNZG61Ur6NoQbVA-1
X-Mimecast-MFC-AGG-ID: qxihDx3uNZG61Ur6NoQbVA_1764846299
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso7867085e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 03:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764846299; x=1765451099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFLIr5RpOZwQW/XBO4InL4XCa+kmzOLYpY3+ymKRjT4=;
        b=po30Ij9hp7XWRX6lJQjWGq6gZP97dTEkaKukrbZxiA4G4438qSfQ3+9W3rsLLWc3LX
         GRm536ffSnI1J0HCwxGh/F/ZZDmvKJd2xB2Vt1eBlkEZ6simHP2z0dW6RC/W0AJDoJ8X
         hQe8Oi2kGvDbGu25axWijkuJ6SIEWrhPsVTbtItNji3+mkp9ltNnHJWTyTsmGbas4J80
         T2I9USs4LImcHkn5pgFawmJWZFGmi3X21ViGTgwnO2Pb6k33yOzt2ayI2UcAmJwyuXzn
         po67P1C3BLXz68nj2qeOpMxtVnLw400SY74yeZX7ZsXeOpqm9u81C6Ve2QAT8CxVmiXm
         g5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764846299; x=1765451099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFLIr5RpOZwQW/XBO4InL4XCa+kmzOLYpY3+ymKRjT4=;
        b=C2tf7WKqZRICj/yCFFFD73TsYVme7/yNNcfGOh0NmhH9RZqftjy9LNX5r0QHlRoX0Q
         8kqbxQANq29EaH2DZDhWOxu4Z9JI8l+QfPS4UalezWvpycME6mlpsSSyJTR+6yxihQOb
         aIcdiJtZFph0JCSLtiuljXXNkGt94SSBCZpPRjB39CE9e78QQFk26uzZbLxfmbg0yKHS
         HEFWxJY4vZP+aBN6sjyfIQgCMxtj/8DfM8PRBkN4j2aPVYzWf50oXAgDR2FKAULfb406
         foVsuX9epnO4Es5KkY+nAA0yRn0qVqX2R+enXCBhSi/BS7uf3eEaveegrP309PHwHkw8
         d52w==
X-Forwarded-Encrypted: i=1; AJvYcCUF2RF+0wF2+/+H9xKwpOsjdIkWSZho6kK6CGKD9LyRyO3oEhvqqhNMHib4NJDIT7kaUOpQzkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLY3mRZ8ka/7qg5sR2Ner2Yrxt4Bos7p9JSDWtSYFYdYuQ0sxg
	1HDKE7Cr9OpCfEO/XRmQG3FUJSPE38VqOpmDlI6xS/OWnyktqC0Z83KEnxGRUntwYwQm4R1LzkV
	ZYdCt76UgCqvvqz4AI8L9Ss3sbJrN9fxeayMEkKwrc5073iwZiP9BnVwrXA==
X-Gm-Gg: ASbGncuhv1X5ye961sqdr8j+Sqxbea+fxmOPlCvbKrAk6Jo5TGOjpF7KC1zQOHXIk9T
	5qek8ox2Oi0vFP6HRn8rKhn6DITRUbuI0qqracEJPhrdcJW+x8+o4Aa1GhnIw3fTFNkKI7coDxl
	qLMFhp1mMQU1yZ7lXnGqB7Csmv+EIk4Z63Z3xj33NRIHSyZq5Gq+XJ2abC54nS5Y/NN0YHLpjHk
	uYRIspCvgA7u/obqa/fqOQABCeiiNUq4wou1OEAn/jX9thJiZgbj9Ik6cKPvT0eauZQt06xJEgG
	BsL2ThokO6fSZhlc9C2kA19IhALpFAg7ZkZ64E+BjVs9e8fWnmXAqHpw0Jl/E9mt6jSnmmyoEp2
	li10XqnklQ3IC
X-Received: by 2002:a05:600c:6288:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-4792f39cb7bmr23778105e9.34.1764846298967;
        Thu, 04 Dec 2025 03:04:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUHIXCO9+fsfECkCmm9xg1Y8sdapnLLcOqNS0qdhtA99YvTLXjlgg6DzeN9hxFmVcV4ihIeA==
X-Received: by 2002:a05:600c:6288:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-4792f39cb7bmr23777655e9.34.1764846298566;
        Thu, 04 Dec 2025 03:04:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm2594915f8f.17.2025.12.04.03.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 03:04:58 -0800 (PST)
Message-ID: <f63784dd-a4af-4023-894c-a8e4082b4f6f@redhat.com>
Date: Thu, 4 Dec 2025 12:04:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2 1/3] dt-bindings: net: realtek,rtl82xx: Keep
 property list sorted
To: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Rob Herring <robh@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251203210857.113328-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 10:08 PM, Marek Vasut wrote:
> Sort the documented properties alphabetically, no functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
Linux tagged 6.18 final, so net-next is closed for new code submissions
per the announcement at
https://lore.kernel.org/20251130174502.3908e3ee@kernel.org


