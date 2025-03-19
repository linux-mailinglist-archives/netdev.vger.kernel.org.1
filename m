Return-Path: <netdev+bounces-176231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3BBA696C3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BCC8828D7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248041F8743;
	Wed, 19 Mar 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgQJwJyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D571DEFC5;
	Wed, 19 Mar 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406297; cv=none; b=jiVokRq6GOgMJ4o/jhpL1+wJ8ZM9MIoaLlIrqjzV1Ew5E5yJof7FX0Tey8Q5sbfGuRCPIYCbD1qEnXjPD+w9TmLtZ0yUCn6qXVgrVZaM2qkteJI2yg3Uf5mUdpGRAIdVo1IdqKPFSik8BIi7TbarK8W/HVhN/sXS6NCWX0pbkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406297; c=relaxed/simple;
	bh=tNhQx6js1NXEoL6aB4Zm3AhBRWJuJKXfVaGnhQHZxNA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orK22De9fiM2CdpQGUkYjjacuUcEhbVBx5j63M541RD7RSf20b07t1jltzHOiuITv1/QfCTIZ1ESvNMpkzAoHH4tHpz3t3WjoDisNrLno1mlglGXaLZXWiaHcHm/q4/UFXm2jn+qyCjxfV5un9klNbje/3+uky3f8AE16hQo5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgQJwJyO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so23184135e9.1;
        Wed, 19 Mar 2025 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742406294; x=1743011094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ryBh8q8OrvCyqXnG+GLkOFPKy3gBau4MAIyOyG75a5M=;
        b=FgQJwJyOYvuQ82F3oxFDGlzD7R1fbC+yaAD4bRYMec0u1i+kHhb+udubIvHanZU4s3
         ebPW6sFu5OGeCmZrdbZ83Ti7CzMPjAa/TNaFCivAMy/CyccJQhAUFzDX+bDxkudXu3Om
         KhfBm3rG1b2LV0u+a/IEpaNhMT02RoQisiufdxulMbfSs787ofb3u7yNYxnwhmDuGCzT
         EGj5R0m6DEJLxxW87ofh/IdfdZAI4t4wkAAwVQamsWgoXLYLRmXUbktukLMluScKktNS
         r2K8V+2bsYkuNOilZfxWRXzDobcuX5F9eYYeOeySXmrsbovu7cumTcIum8cWVOPMypuK
         Wpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406294; x=1743011094;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryBh8q8OrvCyqXnG+GLkOFPKy3gBau4MAIyOyG75a5M=;
        b=R2KPjpRxCZdzcqE3ln8fvepWhVFXoc0N3fegwnkqDBqDMwk5RhVOY//6Norjk6+0WN
         i++hiDGE81LKkrQQV0l9SsLDS3gI7cSzKlgByKEWWyqqDIKkIdisfX5NAgWgVa+juUpP
         a5K+yzq9Fdv0QfbwV7HEHtYmF3G0K0qmSVzFpsytZk34R2tSmDDDzsF/wuKQrv0PvKOw
         PwcFN14Kb0Xv4MBNSlW7Bg/4QeJkOddNX3YoqX7yLCw8J5NLStIbnUTYQuCTwSAF++Dt
         0gqqryRk+EU3Rww5VutxK66LVEidIDNqsZSW2htagi1qS4dWUCEr+KHhcUQYumLBAGpV
         uhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXb5dNpBwzXp4Etn/joTrWkqj3dDZ1o4Afud0PrxsuKVCer80rIpe3CX8iW8XX5y2hkKER5IAlMBhC@vger.kernel.org, AJvYcCX09R4y2ybh6B1csivRgLpP4OhVXWRmLh8mJNF8WwILDGGwfYULM2PP5Sf8LWz5AOP7aINit76p@vger.kernel.org, AJvYcCXXBIVlnFU5WFBtLwWuAVPJoWzYYUZ96kqsUwqY8U/rfivoNu56bA/suVAJym+w/mGjH/ZuBmh6dkaYX6Bn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8xZIQO+PozkaGQGdb0soG4Cgo0y2rizKLQ+eOz9+kqFqpAc4
	KsD6xb0v9SEl3j+S33L6icZfBvjI0aA0afq18i4QuPhXfgFiz61i
X-Gm-Gg: ASbGncub8EOPD3FltjYVFe17BI3JMIRzkiBZaneYy6p1FTPwxY/iP+ngy75mhfPBzQj
	hTXJL3c9HVdkOgLpWYtu61/inmb8F+dWs5SlFih12jMV8dalIFw/fJvDGJSVhDuj7IgEVx0DED9
	nPwmHjFSVu3rOgWnZcHhugj1PgTvlNzYBvH3Oqf82hmzT5eGdlHgk5y2Lb0kcdYMXk3/fU0zDwV
	Npv6D7T8LWcN7T1vS3Jn9UhMbi+z7NSbK7Gf50jfysWGz8WaoWW0OdgI0SPqw17cP6YYIPTNTAd
	/R44fLEx+Q8BINajgMttOc3cXCs0p5SdX1kYYlVocniEF7dqhM9pvYAcTdO5AjoKhDnDEiWRtIZ
	w
X-Google-Smtp-Source: AGHT+IEnFFFnx7cAsJMrMu7kkH7UnKHIBEdYX6TVoUlF8hg1k5y8nfj9LW9UHVLVVfHl7zYuamLFxQ==
X-Received: by 2002:a05:600c:34d3:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-43d4384301amr31691015e9.25.1742406293390;
        Wed, 19 Mar 2025 10:44:53 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df344dsm22192793f8f.10.2025.03.19.10.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:44:53 -0700 (PDT)
Message-ID: <67db0295.050a0220.1d586b.0585@mx.google.com>
X-Google-Original-Message-ID: <Z9sCkh2R9IkGoAjD@Ansuel-XPS.>
Date: Wed, 19 Mar 2025 18:44:50 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 0/6] net: pcs: Introduce support for PCS OF
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <Z9r-_joQ13YdJeyZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r-_joQ13YdJeyZ@shell.armlinux.org.uk>

On Wed, Mar 19, 2025 at 05:29:34PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 12:58:36AM +0100, Christian Marangi wrote:
> > A PCS provider have to implement and call of_pcs_add_provider() in
> > probe function and define an xlate function to define how the PCS
> > should be provided based on the requested interface and phandle spec
> > defined in DT (based on the #pcs-cells)
> > 
> > of_pcs_get() is provided to provide a specific PCS declared in DT
> > an index.
> > 
> > A simple xlate function is provided for simple single PCS
> > implementation, of_pcs_simple_get.
> > 
> > A PCS provider on driver removal should first call
> > phylink_pcs_release() to release the PCS from phylink and then
> > delete itself as a provider with of_pcs_del_provider() helper.
> 
> This is inherently racy.
> 
> phylink_pcs_release() may release the PCS from phylink, but there is a
> window between calling this and of_pcs_del_provider() where it could
> still be "got".

Ah I hoped the rtnl lock would protect from this. I need to check if
unpublish first cause any harm, in theory no as phylink should still
have his pointer to the pcs struct and select_pcs should not be called
on interface removal.

But this can also be handled by flagging a PCS as "to-be-removed" so
that it gets ignored if in this window it gets parsed by the PCS
provider API.

> 
> The sequence always has to be:
> 
> First, unpublish to prevent new uses.
> Then remove from current uses.
> Then disable hardware/remove resources.
> 
> It makes me exceedingly sad that we make keep implementing the same
> mistakes time and time again - it was brought up at one of the OLS
> conferences back in the 2000s, probably around the time that the
> driver model was just becoming "a thing". At least I can pass on
> this knowledge when I spot it and help others to improve!
> 
> Note that networking's unregister_netdev() recognises this pattern,
> and unregister_netdev() will first unpublish the interface thereby
> making it inaccessible to be brought up, then take the interface down
> if it were up before returning - thus guaranteeing that when the
> function returns, it is safe to dispose of any and all resources that
> the driver was using.
> 
> Sorry as I seem to be labouring this point.
>

No problem, some subsystem are so complex that these info are pure gold
and gets lots after years, especially with global lock in place where
someone can think they are enough to handle everything.

-- 
	Ansuel

