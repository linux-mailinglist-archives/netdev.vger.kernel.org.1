Return-Path: <netdev+bounces-78994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE708773E7
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 21:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579BD281B78
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905354E1BA;
	Sat,  9 Mar 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="vdlD+wbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8D20DF1
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710017071; cv=none; b=kCnq4ux7Cop0kFobcI/C3Ku3zMPXgkvkvoEbfttrCHF3nh2R1DKca2NxFmlf2sxyxwuHv+7rKoEsQbFx3CZUQjKJ2kYHSZRb2J1lJxVJh9kkCHCC5lN6UBlm6BLJHiZNqkDHP9Nonktdjs3zFKGLKRk7OmcK2Hh7QipEbGjzScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710017071; c=relaxed/simple;
	bh=6je8OJStr4Pa4XP7b3zCWLl8tAl7bGyeNCcit1YI6VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpRm1if5WsCqd+uAAfAkA5RfizvsVUX3Ar7uIe9NO/Utt/ELNXWWNNRq+FIsWuXMtPKjpQIhxg8ctMO7C3mpH8Dt69I4M3hEye5q8NmfleRpkh3a/BZm5epW/6W08FZMHXowdbJrcqa7+tXYk5yHF1ec4WBnVSfXTnaTwQrJohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=vdlD+wbg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d29111272eso45935271fa.0
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 12:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1710017066; x=1710621866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a5lXn9mjoihAOGhp7B+d0tg2VVCvh11rhrbmBOOVVV0=;
        b=vdlD+wbg0xbBuOhaBDqU2aN+bA0uyoYvisrWborIGP9pGqAUvRu7nKhu5/hCTQMvOP
         RA+9wbfuXXWMbGsL7PSLjGrNPEKM2e1gPejHpxVUk1FjTfstkY+xBW5UVaz2HPIWt2Q3
         85eBl0fseSQM+sRpkx5qJ9Kdu7rInStXxYFmfvgIepvHjTb5TDHApPAy9l4KqtpsEsFX
         D2F4tdOpofbspFQuNasKaepVPG6ZBw4skqxK4XKmP26BaLPsj0YDE0sOxkGZ1lXA2JEK
         6mLATPtfnb2yXhvRI5ymrpPTH386AE5np21KiSLt3OQJ5CUDf7yrblGEpPYA9it1sc+4
         iwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710017066; x=1710621866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5lXn9mjoihAOGhp7B+d0tg2VVCvh11rhrbmBOOVVV0=;
        b=w0MBDMAjONmgAfq0B35NnugC4lSJVrzIzuXDBGjml6+Sn6OGge1OoYJ0taOfnguHdg
         cHQbxFTAhfSByFbp0u9Ucwbkos9AG0A5dyn82CvJS7nb5BRLKkgxt2my6Kq2I0Sw6KNa
         VaS4eAnvaWbr5BzK3up5V1arzHzVZnNlM7RJWY51CnHLjlyro3u4AxLVp5L0S8P331NA
         DkC2Xh8KcugjRkleKtsFxOVDZy5meCq1/WjOX3znNbbhZlNwO9PMQXGI2yqa4Pj06Rqw
         RMX3rK6FS0AUN75gb9TbNr1kwxdVZBo3O2g3yko+XoCXa9S9IhBRU7HRYFbMBib1BjNG
         BPLA==
X-Forwarded-Encrypted: i=1; AJvYcCWEDRj0C5WTPt25q3CDKKh83danOuh+n3koNzhANF4kFRrSbU9U7AuyM5icem0RP/pt4+f2m6SWuJaQRAcpYvOJkeFiOViV
X-Gm-Message-State: AOJu0YzkSxbuSz3cPEPa2n+vmnAiP76YBhZhB6OXZGy7sxQPkHvNaNpe
	Z5LLn7DbQtMNOf0w5Rz34ZMmiS/6gZLEP7i/W5Fp19gvdyZfMsFh4TUD98yGQ9I=
X-Google-Smtp-Source: AGHT+IE7NRyT3Ley26CaCThuo+hkdSr8zWugv9KKHw8axIGBGzlqd9vLx13tVr8cXJkBTaD+r1jm1Q==
X-Received: by 2002:ac2:4548:0:b0:513:5cd4:692c with SMTP id j8-20020ac24548000000b005135cd4692cmr1599691lfm.44.1710017065638;
        Sat, 09 Mar 2024 12:44:25 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id l4-20020ac24304000000b005135cdcf4a4sm422870lfh.32.2024.03.09.12.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:44:25 -0800 (PST)
Date: Sat, 9 Mar 2024 21:44:24 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 2/2] ravb: Add support for an optional MDIO mode
Message-ID: <20240309204424.GJ3735877@ragnatech.se>
References: <20240309155334.1310262-1-niklas.soderlund+renesas@ragnatech.se>
 <20240309155334.1310262-3-niklas.soderlund+renesas@ragnatech.se>
 <f7bb4374-0afa-b79e-e64c-bd97b6680354@omp.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7bb4374-0afa-b79e-e64c-bd97b6680354@omp.ru>

Hi Sergey,

Thanks for your review.

On 2024-03-09 22:28:47 +0300, Sergey Shtylyov wrote:
> On 3/9/24 6:53 PM, Niklas Söderlund wrote:
> 
> > The driver used the OF node of the device itself when registering the
> 
>    s/OF/DT/, perhaps?

I thought we referred to it as DT node when talking about .dts{i,o} 
files and OF node when it was used inside the kernel? The infrastructure 
around its called of_get_child_by_name() and of_node_put() for example.  
And I believe OF is an abbreviation for Open Firmware (?). IIRC this is 
because ACPI might also be in the mix somewhere and DT != ACPI :-)

I'm happy to change this if I understood it wrong, if not I like to keep 
it as is.

> 
> > MDIO bus. While this works it creates a problem, it forces any MDIO bus
> 
>    While this works, it creates a problem: it forces any MDIO bus...

Thanks will fix.

> 
> > properties to also be set on the devices OF node. This mixes the
> 
>   Again, DT node?
> 
> > properties of two distinctly different things and is confusing.
> > 
> > This change adds support for an optional mdio node to be defined as a
> > child to the device OF node. The child node can then be used to describe
> > MDIO bus properties that the MDIO core can act on when registering the
> > bus.
> > 
> > If no mdio child node is found the driver fallback to the old behavior
> > and register the MDIO bus using the device OF node. This change is
> > backward compatible with old bindings in use.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey

-- 
Kind Regards,
Niklas Söderlund

