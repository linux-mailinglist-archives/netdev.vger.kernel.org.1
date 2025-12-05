Return-Path: <netdev+bounces-243881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA804CA95DB
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 22:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CE23028DAB
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9C257459;
	Fri,  5 Dec 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAS4QhMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED871A317D
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969408; cv=none; b=Jud8qyArbbDc66K06bZb6YqmmgJUu+8VOX4OF2mhLs9oWDKQRG39rw3SZpX+8/Lt2U95A277mWY5RLQ33gCxTCxPnal2XvM03r710qEfMd4HZ6gD9GkXLxGRY9o4Mxm7/c2kA/4kTr6UcpGI2/+t17F0aRCyDiHQK/ImDtbXxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969408; c=relaxed/simple;
	bh=tcwMF1u7d3ohgpmS2mxHfc4wRFvpiyjj0O/l4GKooTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ibyw+sAfyMkCy5+1cxQruTDuQ9uRshvCCdUS89qxnQcKhfcrKQQJXx12+APsrjfSykJ5eFzgaDpJxXhIvnZxH8OgIHU3SpDyXW1c1J23ISsyuIX6FcK+oYGWrEn3de3QVrKAAvBrt928uWK/QLHH0k1Cvl7MPtMMQVYoYJcmivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAS4QhMw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47774d3536dso25108695e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764969405; x=1765574205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Nxf+UbxVML8lqm9dUwCL46TJXN3lpM/MynhhK+ht9M=;
        b=NAS4QhMwzen90LiRI6lX/N6fRfB3dyCpOZ1dpTw19Ngw5VbLV4WzhPxCToPzpgVP/Q
         swDRV5W4epy0JrsnkBr3XPitt4+aL3nn6nYy8ixG0OB0Yq+rv3JO/OF5E9tEP0AMnOO+
         vT6KIq2XG6Z4oGWG8Q3WyikgHP/ooSUhCKFx+XHybYXHQPo3yg/qr7Un6/9kj1mWORZ2
         8qU2cu33U1ipSJ8KECmAl/RZw+JWrx8H0Ex+ODVXRhc9G0fGR169U5JyaJ9umxM8s0h/
         o/HAvwgpimLI9phexHWOAO2ESvmoQzarQegt4sbc7YHOj+rz+x66Fp8ovc/MtAmR5DHO
         vuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764969405; x=1765574205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Nxf+UbxVML8lqm9dUwCL46TJXN3lpM/MynhhK+ht9M=;
        b=c7x52A/EGV5shDlce0amnP7MCAVhqmd8uXHI64JSCoBoD7d/pD1Ha2hGKIX/J/AgB+
         AhLwv8fyakPB4iCDKnMIVtuTJ400qp3PiunvFvulprQmWTofKCGpkMd0gIJ+6K3lxbZn
         CKdAF/6rmfnAajL8TSA4v0Y5Pp/VtXdJrVO8EckBZb4kVr09pAoxqMZg5HirZ9dQyaRe
         H067icJNdfSgJ7pQrcsxvH6sTtibOItvxeRRwNwZfUhaFWvPT/0VdbIC1Hk/X64DFiaf
         y7htWgV3hZ8F+qhV/xSKI5C1RxgJ1c7F9MPFErq/yga96YegvzIM9bLVDHX/G5gyJ757
         6/ow==
X-Forwarded-Encrypted: i=1; AJvYcCW/IvUNbYlr0q6cZqYkg/O/YSB1RG4klWZTkJCqIoH3DcuDliVyxINYdnzLJRsrBaJwaHDMMxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWux7ysKzCmFILE3VAzYrOM0kemeHo1vXXuy+I36OdSTzg+wAj
	aQIP7VBbnTwjZYDE4SFqhV7VB+sZKzEqIpqWoeb2eMrJ4EtrMqAjZE/G
X-Gm-Gg: ASbGnct/AkvrY6976r8xBZMvGBf8//Nuk5sR2lb8EAIokP/DKtGYE8rCElEVNcGt/te
	S1ZUbDOnTrRc2kGr8BbzfsJCJwaKe8bBDAJ6imQbAx2y07Ggro2Sehy7dblvQ7n4MfiC6IHqcZv
	NsqAUg7TH0Yn9NYCo9K1r4exw1Teu4mBLc6TybSGFUkCtaBClyTcm0/sk7zSOE+Otk3Z/IFa3mk
	PPiJ5fdOrUtzEp4N4R9saFYEzTbotePoxFIHpojEWH9O6CuP10Y5oi+ai6Wh/KcVtVekfs6I2b/
	ftz2ki+5Uv0nQURWjTaOogsOgfD3iLmfeFVGDv6EMpoGXOTxhZcXW7CLridnfqlwAKA50bMLo+2
	zdgFDe4tfvPPxf4odUNpj4NTQe4IRoa/JjWm6CvlFj10M9ptdlaoDv+ydTifMUsPRpuFG4McEbt
	PZtQwJhvRAqQDkWkdkALO/Mbn7i1Srs2QEQ+IRJukVxQbOUB+Thj5bp0hCeirOU9whSSQHj1w9s
	POBDE7HJSXxekB7+Rt06CFj9oVyrfS2mQHX/gmPQcmzvn2aTU3e5g==
X-Google-Smtp-Source: AGHT+IFZChau8OMeC1OLCqeCPNebVKaNk3vumCCd23Bu0iJLrPIjbfoD1uBKQKJb6ckkVpzXZJNNzw==
X-Received: by 2002:a05:600c:5306:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-47939e22a9emr7139775e9.11.1764969405296;
        Fri, 05 Dec 2025 13:16:45 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:b600:41b3:37ed:a502:9002? (p200300ea8f47b60041b337eda5029002.dip0.t-ipconnect.de. [2003:ea:8f47:b600:41b3:37ed:a502:9002])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222506sm11795875f8f.28.2025.12.05.13.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 13:16:44 -0800 (PST)
Message-ID: <10441fbd-8022-402e-8551-e0f8ec0449f0@gmail.com>
Date: Fri, 5 Dec 2025 22:16:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] powerpc: switch two fixed phy links to full duplex
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <64533952-1299-4ae2-860d-b34b97a24d98@gmail.com>
 <5d302153-c7f6-48dc-95cc-0dc4f25045c6@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <5d302153-c7f6-48dc-95cc-0dc4f25045c6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/2025 6:50 PM, Andrew Lunn wrote:
> On Fri, Dec 05, 2025 at 06:21:50PM +0100, Heiner Kallweit wrote:
>> These two fixed links are the only ones in-kernel specifying half duplex.
>> If these could be switched to full duplex, then half duplex handling
>> could be removed from phylib fixed phy, phylink, swphy.
>>
>> The SoC MAC's are capable of full duplex, fs_enet MAC driver is as well.
>> Anything that would keep us from switching to full duplex?
> 
> What do we know about the device on the other end of the link? Maybe
> that is what is limiting it to 10Half?
> 
I found no hint that anything is connected to this ethernet port on
the two boards. Hard to find any information because the boards are
>15yrs old. Seems this are dummy entries, just to let fs_enet load.

> 	Andrew

Heiner

