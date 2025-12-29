Return-Path: <netdev+bounces-246222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47142CE64F2
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D54A300769E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7C2737E3;
	Mon, 29 Dec 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWMKuJWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27819DF8D
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001122; cv=none; b=pWPyALwLJ6bV3eEoBP3eDac0ZtPPx+305MU4ioaIaKwdzodf2GpIKnukEGDRtyvTwL/mZUqoFScMewpU7Bf/vWu2uEHDRsA8gHpVMKFQOEbNctgpE62riIPEIoIaKEDoTzEmCoE0K44fghuioT5EeHign59idfr5bO+wcdZ877g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001122; c=relaxed/simple;
	bh=kO0i91k+d7tY6/QG4tUs31NHp8dHfbbaZl7dtded2jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQqsBZJCfZ2QMX6ElCC9zD38WbqkPGBTsUHZkqEbDSovHqwK3tLf1JXYDi7DGvZMHeEBJlLnA7+7OfOE0LtjthOepPEwip4KFhHN0NOXQ8fC3udffg0pMWJGY71Lo2OyGGi6ORPbfXI604pmnUuoQxZ7vR8JO9mwh7OzlLvPZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWMKuJWe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a8195e515so54756295e9.0
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 01:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767001119; x=1767605919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2v6eGE/fsBCG08y0w+YOqZFZuaUBiOVQSCHWFP/Cm7Q=;
        b=WWMKuJWexeil8ckPYQpGGMns6r+o08XLexOJwKRXhZUiKHR/SQfTCfqb5nKfeB3NGo
         xsSi0y+eufJKfXfd+LjHj+4GSlYkLJerJi10V7fQ3m1N2td2tmDJvYNKvh9jyKtD0soO
         GSC56KLQ0Z0sWEs9SJgoYr1YHKK05HlGmkluihiSol0xNc25tyjp6wcl4fUHgqJVlMxu
         1gAu5JHFfv48Y9AI1quYP3+n6aIb+SJTWqadMRKPofElkDElU4o+HSoKjLpH8oAC7JNI
         cd/Bb6dJsxvuSASPW0kYcWsQ1IQOOR0JyHplBDSqHobBSOEDVa097BltUen2kfw4s2Ki
         B06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001119; x=1767605919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v6eGE/fsBCG08y0w+YOqZFZuaUBiOVQSCHWFP/Cm7Q=;
        b=GLT2lWj2sRXNwYeXCRJxYoXhOkBymgpLFFE+Hsg32QK/4AN6/PTBNgVVY5jOIp4ipy
         rDnTn8bJVGgeBBGfvdWwOyEu4aWBLW1Mr6AlHCP0FaHS1GNWgYESWncKuMeIMNpUT1dB
         vyJGCDSpWXwi/xwuQWRQ76XOccRk41CZqWKhqJlXggkZMoprCRp9l8TBVkISn5fmk5tR
         B6Gsxo5+rbZZGxsf6VAzKa/on/vBrUvnf3SjIVafoKxeZesq/KtzSYJnd/CdymkhBM/r
         AEe2Kw8pL/bHaylICmOVeWH80ZCBekkj+L8SaanHxsHpG6KSF3f8pk4Ci7e8apmWHy3Q
         4AvA==
X-Forwarded-Encrypted: i=1; AJvYcCUKF6/scvyFl5ds/YNWtMnB4epzKhWgOwjqqUSbQ5bLm6vH4mtz+mbzjH92MsnBOONovXv4geA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFHxZMVAOPPfkMgK8ClL7fuEYrMOB8L0ln15NRA7l2sMOamiW
	T56VS3mBokQhZx5evXOyzrBB3ejONNTZ+vwg7+Ec/5eK4kiMtXAc16Nq
X-Gm-Gg: AY/fxX4MNR73Eo2sv2fFunDPTMgs1+WeevxGEFOD7QqZbNR+Vx9N4+7HAVIzOTpD3Vn
	pGiB5Dntho1GiQUoahGc4dWa3pQ6bmAXsE0DXLuXQBIOlCvUopixE11EwsmEtl1sMym2BT5ZeRS
	SMQ7QG6XNW2tADoWnZoxJzCqvIqH7V9hFETTwL9aDyebh2nmO6pgxv7RxjU6gQLaUgn85n+avv3
	jjH+svkMPfdntMxWTiXHfMPgzutD1STyQWa+nCt+agyxYi1u4vDP2/r/wt48ee8i+IymJi9KhTb
	vr5PwoPQmhlRRoUR5gG0G6lpgaSKTz5nutmUlZOsNeGzVm8MFZEi2DrRE3NUH3InknElVO3JZxM
	CAMRXSM8DgA+h04zJtGeGLdnIiLIIH/BPLlIJIBFlEpXWVdniXTCRXs7nXieYlkoWdMWYGF/wRn
	+CnmQzHuX/oMI=
X-Google-Smtp-Source: AGHT+IFmJBKrx79I0aO/TCtk1jPLio3pSmUtd1zLczM3bhThrb/I9UAqTUIaMvwAwmDnYrYkvxa1YQ==
X-Received: by 2002:a05:600c:314d:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-47d586e309dmr30248375e9.15.1767001119444;
        Mon, 29 Dec 2025 01:38:39 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:305a:a3c6:f52d:de0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273e4d5sm588774905e9.6.2025.12.29.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:38:39 -0800 (PST)
Date: Mon, 29 Dec 2025 10:38:37 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: net: micrel: Convert
 micrel-ksz90x1.txt to DT schema
Message-ID: <aVJMHQZYugDoWHD3@eichest-laptop>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-3-eichest@gmail.com>
 <84bd049b-3c60-47e0-a404-be764758f5b1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bd049b-3c60-47e0-a404-be764758f5b1@lunn.ch>

On Tue, Dec 23, 2025 at 03:39:24PM +0100, Andrew Lunn wrote:
> > +      patternProperties:
> > +        '^([rt]xd[0-3]|[rt]xc|rxdv|txen)-skew-ps$':
> > +          description: |
> > +            Skew control of the pad in picoseconds. A value of 0 equals to a
> > +            skew of -840ps.
> > +            The actual increment on the chip is 120ps ranging from -840ps to
> > +            960ps, this mismatch comes from a documentation error before
> > +            datasheet revision 1.2 (Feb 2014):
> 
> > -  Device Tree Value	Delay	Pad Skew Register Value
> > -  -----------------------------------------------------
> > -	0   		-840ps		0000
> > -	200 		-720ps		0001
> > -	400 		-600ps		0010
> > -	600 		-480ps		0011
> > -	800 		-360ps		0100
> > -	1000		-240ps		0101
> > -	1200		-120ps		0110
> > -	1400		   0ps		0111
> > -	1600		 120ps		1000
> > -	1800		 240ps		1001
> > -	2000		 360ps		1010
> > -	2200		 480ps		1011
> > -	2400		 600ps		1100
> > -	2600		 720ps		1101
> > -	2800		 840ps		1110
> > -	3000		 960ps		1111
> 
> I think this table is more readable? But maybe without the register
> value, which is an implementation detail.

Thanks, you are right. I will add a table again in the next version and
drop the register values as suggested.

Regards,
Stefan

