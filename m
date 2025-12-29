Return-Path: <netdev+bounces-246220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A539CE64CE
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 655D7300FD6E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935426E6E8;
	Mon, 29 Dec 2025 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge/++Wvv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4B24293C
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001013; cv=none; b=u7xV04Gf/rgGm1pLWBdKm8S4OAcC+XnAmzUCySnQ2Ann84R71Shm1inzH7xgV5PZJQ3LpuQqUtcBwUqKBK9GXQEazX1iNWzaF4Yb2sePcx0plMoLvdqIJqfPB77J0JwWRGNpV4qk+B33PFZRE5r65ofzzl3frvOKbRTE+c+O1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001013; c=relaxed/simple;
	bh=y0DBFrvTw5WGdJotdWoUOWRFqnUJHGhrLoNAJ0wT9kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SawwUsUULc2lf4an68boD80xrB+rriS0M4ApQtQhrbMkipQtVS2MSwHddFEVAW+9FHO1TtDk+1Pz9rsd+EMTC+rK5vI3h4kHNwa/0jtSmzwYVmboqML767XbxtmjTl+a/ndDRw3sgZWFSeJAoUulTl1eA2hCoZD8sm8cJchsly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge/++Wvv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957c929a5eso12980146e87.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 01:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767001010; x=1767605810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zy6FaAKrnG9vWUbCJzba2W1+Xz+O91x0kok02ukJILw=;
        b=Ge/++WvvfTI/b0rED819cAWCD/grpvWrpAEWvKteReG87oHunH3Co5Nm33I48vG5tN
         G3hljpNUER3uKaEdPqEDWUsimXzW4d4mG5OEjm2fFIP9w0xj+kA9Z9tzG/XJrBoYXlbo
         O2YUqTodqvk29q+vUwwvH913bKyowHFDqqRJdvvXtwiHzIo08QSS4qu674HFXpp5ANzi
         c8MSP286AuThBBXQ+xcfNtInRK0nfBLioCSr4mm+lMwCaUIWQMM7wVCIoTyq2ezep+b7
         PBieBxcEnfg3wzyZo5sF7w6+4HveW5E6FJSe+f94Ks/UGNNHL8p6oGaG4L2+/A3jo1zK
         YCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001010; x=1767605810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy6FaAKrnG9vWUbCJzba2W1+Xz+O91x0kok02ukJILw=;
        b=DrhzBLbXtZcEFwCY/0h0b2MsBdg3wjC7nPo9Pe0uBBQ9znYbqKG+oAo5L/+i0T727z
         j5+70YKMJLddWykjpeBsYQmx4O2KDgF7xJ3+QhDMN/v2l+4lI7QV9MYmatmcz/qU7uRL
         hrozWLK2G5tlqhxtVpLHq2QfTeFhosYG9TRofpfyv38k+8KnGFdQHM6pyGWpD9D5RFYC
         EZE1RMtuVHkXUwUksSN3zHsDnwlC46LXNP/sIg/lin/AOHFxzncM7iAdnfeIM/19iA2e
         dUprjxMKKobYbVD0YEE9ZWgBJRlIq20zm2icZ4KcUsgQIICl4AT90xPw4OmiO/Kxmd6b
         j/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWCW8EZ2/ZyJMO0HyHA9Hb+ieqOxSUj9afXvkiLwH8fBy6Zl55ti72bLjWma48HfA+pbvXjMHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykii3bIcxaEKaOEP8MSH0JgNg3BMfiWEbXPhY4Aq9iJaVOUfLp
	1KR32mzG7yBEE+p9/MQF0JVQ8kkjK8QysQM4xDFHoG+yqSvTQ/jNzG0D
X-Gm-Gg: AY/fxX5FIjfiTCcGk49XNh0sDe3c6kW5pinSavbPmKM5OZLq7DP7oPV5bmbi/HUUbjS
	A+shGtTiN3zoWfyWOCVQsYZQuNBK5D4YFL6noEopqSAnnQarqDuZcHExGnZ6omAoD3eZfLu7hoN
	CGrmaqgST/u0OXK/jIuofqoGHzVDqLqT/RPeAjIVjnScTxM0o92R8SwIozKgsHQgTky3knYEt7F
	94LhoispZ3CpOcmceiuEXIjjfe1UeisCO3bUEk80BTnrDumWgL3/93j06UFR4dT2oS1Y9gygZno
	CRUFRqWNUHh6GyfXAydQwktT+S9cMX8MZvgQfY6StDymePojci0+BmlsN/NF8dHh5Hsm9hcEp6X
	sCp5vC02fgwj2VQiGwAx8aYWNQTUymrIBEiNEmeRALUY467lzljKu0dTghilbX84rk2toeRTBh8
	BhZxdKpwG5fV8=
X-Google-Smtp-Source: AGHT+IGHm0Kgnu2qkWrY4EqAUf2ZqTKoDeBs41GVC0pxMiQJd7hpHFbnbDaD1TLfB5HETP94i+VV9w==
X-Received: by 2002:a05:6512:4020:b0:598:f262:1666 with SMTP id 2adb3069b0e04-59a17d1258dmr11279969e87.16.1767001009412;
        Mon, 29 Dec 2025 01:36:49 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:305a:a3c6:f52d:de0f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618d59sm9115943e87.61.2025.12.29.01.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:36:47 -0800 (PST)
Date: Mon, 29 Dec 2025 10:36:45 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <aVJLrTnCefcjF39m@eichest-laptop>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-2-eichest@gmail.com>
 <0376a133-44a7-40e8-be7d-0d04d33c0ec7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0376a133-44a7-40e8-be7d-0d04d33c0ec7@lunn.ch>

On Tue, Dec 23, 2025 at 03:34:57PM +0100, Andrew Lunn wrote:
> > +examples:
> > +  - |
> > +    ethernet {
> 
> This should be an mdio node, not an ethernet node.

Thanks, I fill fix that in the next version.

