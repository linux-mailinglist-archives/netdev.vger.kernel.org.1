Return-Path: <netdev+bounces-88034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE728A565E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E11C21465
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC878C71;
	Mon, 15 Apr 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz1C1AOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05B76046
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194858; cv=none; b=r14PoekLfMSC2VnbY/DfeL5yAyDNS1xRhPKf0ho1eMkE2RS3ELlSYpDrOAiWqh7UzMMdLZBcnu0evN3UGppCbVUZF3gmcEF0KJ0BLEj0cdd7NgHTvp4ejHaFRfeZMKWCwxMXhGkUgfEAqcc82tqtQK7Dqj+8n2uFOHGCdCdRHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194858; c=relaxed/simple;
	bh=K684+xOEQxmYo5QLH8VxV26rPRLzfZxHY+TO8v1kGQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6r93PAjMdndTC0Rst1+dqTOM6xXBy4XMKQ0IFoDeMYaKqTHKgd/sj1KfYZd/h/HxwoqnmtS4uHTI0he3xLz96JqRF6YXczDmIgtWzcDANXSUr2yLOYXbAbz6IA9XTy4ByRpZILkdJRQHM9vm9Pauocuzz4pTZGnvXz181ylPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz1C1AOD; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3d2d0e86dso1477144b6e.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194856; x=1713799656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iDPwJjyq2MIYW1ygvvGBm1ZCOEtgZxhDAxvP2M2VPSs=;
        b=Uz1C1AODAz4ToiT8hZKfFG2bJg+lbEoTtLjQ8FsYvzrI/J/4fc6mcGLpqDyU6483Eg
         4C2Lcac2RDlKG9xEcMUb3k5o4+6KqbVreMKbEkcYitIidHRPPE+55dtoHg85snDZOfnj
         EJFAlPijLw79S7AIi53BHd00MzFIhtW5U5FNPkXUd/cT/QrqkY0UndpJs6EosnveZ/hc
         88bwU9lYpbcCKLgkaGGGG+jCBaWSBxOX5ZjDFLDSO+TqfU/rU5UJKNPg2uIuZpqZgBuL
         u5EqTR2d//Uo4tyDw4pronRbPJIgOzjW751jMpDjn6cE+aSCoPaEtPLAnnerzfDFcS/v
         8cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194856; x=1713799656;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDPwJjyq2MIYW1ygvvGBm1ZCOEtgZxhDAxvP2M2VPSs=;
        b=uHeXyQXYUxsfx79hw8gAlNtpGuFFEUZy7CraHRpGNjdn5MSnKEUBVSrPcPnUpLllLj
         D9Sg8pOwFTBf0xTvuLkQGXXDJux/tg7drjUDg8icTyeZyWyuAdnYLv6VGLTBB1SgVwtB
         WQ3VN48/i8LWK4WKLVlAqKYP5JPgUVBy6cT+006nBhxL/vqr5i5xX1N0Rfhwsb4XH68g
         IEDn0Q/qUf0Oo1+l38frBG12bP3IbIf9Wtmj7khrsnlp+lHk/X43hrfA3LX5J4Qub3+j
         u+HvSlvFFA3CPWQkrwK8K0WvlhGkby/kiuWWVkIy+rnu6nuwNbHt2E1nmEp0uW3yMaB0
         YRqA==
X-Forwarded-Encrypted: i=1; AJvYcCV6kG6d/fgY8ayzbdejk+EcwsqyB2NtqvKClO8H35geWd4MzX/qDAJd3/fHfkbWFmNQuV6l5/mB0QUj3uccUZOrE3Ltf4BC
X-Gm-Message-State: AOJu0YwhywKAszdPCFBLY+7k6TDL1jUZ14l+AyPIzDQx3vaZcYXqs68C
	pT0Q/gUGqNUkdd1iGsbioh7DUK2nXlhm5dmL5bfW/uXsJ3SlXtsy
X-Google-Smtp-Source: AGHT+IESvnm90j9T0EKPUdtFyHDge68fZoLJosz8o07a7icCKQ+wjOKopYtHrw2HvR6R1nb40T7Rjg==
X-Received: by 2002:aca:d15:0:b0:3c7:51f:156c with SMTP id 21-20020aca0d15000000b003c7051f156cmr6405249oin.29.1713194856192;
        Mon, 15 Apr 2024 08:27:36 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id h11-20020ac8514b000000b00432bd953506sm6132256qtn.84.2024.04.15.08.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:27:34 -0700 (PDT)
Message-ID: <eff4fe5f-c9dc-40df-a7c4-8abcad579918@gmail.com>
Date: Mon, 15 Apr 2024 08:27:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: ar9331: provide own phylink MAC
 operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/2024 8:15 AM, Russell King (Oracle) wrote:
> Convert ar9331 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

