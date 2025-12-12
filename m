Return-Path: <netdev+bounces-244501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F27CB901C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E04CF300D54A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926B30AABE;
	Fri, 12 Dec 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE3mfPyP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B1299957
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551123; cv=none; b=PTZ3jDO6Q4mHPE8SCoeZaQ5hcNtz+kFC4tzaQJ8nDocsu3kb9BFA7WDn4zw8bPYHgBJ824ATDshiXN9QfNzJxIUB50L3rN/uryjO7Eqqx8zbwg5q0zyxuPzOI3ha28LwQjaVa7gcl0VOqQb1TcnkWlPeQZdZp7AjxbnIjgZRVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551123; c=relaxed/simple;
	bh=UqY+yiLaQuiVuCXEZUTKHeKvJK1tzjeO8F5/j9gYSMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMV4A0SA7GmmzUrFZOJXo/4dViImzilg+pp6o4tIVhzCtT2tMHT8TYeGQlL83WQl5WqYltK3d1zwSM3a32t8iUL3Isw9fkLQKgXofDw3J8gfyGlEJi/Ac9z7Gtovo1IZh6brPWPJsSQv1WdWsAyPDLJeKQXj7TOmsW5OzcPe04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE3mfPyP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64981b544a1so1730525a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765551120; x=1766155920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bdq+s2ZwfYVuONhzydOJ97RjH0CLzXEFqbGidtolnQ=;
        b=UE3mfPyPVfhnsKnzrSUYaBqyJE6s2OqDA5DKwRkIowRm+9HmRHAnI9r4JqstPNVXF2
         mKkfLrODPGcTWh8IZAFdBewx87NaFaYaf1iP3RVG9/ohswjnoecMaMukDknX07Xa8mYM
         Ns+g96+8mZkEUsHKbzupgN34ajpS9rbWjb3EFsFmEY9U7Ye+hdtxeT8J5Xb9dsH1ei7T
         80JNnKMVL4f59/lN1zYslb479YmF8U25ugPWDWBbHQItkfmkNceh0je3hl2HRUyerQJK
         WELAJk5V+ufdSM0wIc3iLBBzPaTH75j9J6OcMWLjEN2H2yfxPkPYk1Q7SNlN8FYtHKaZ
         gB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551120; x=1766155920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bdq+s2ZwfYVuONhzydOJ97RjH0CLzXEFqbGidtolnQ=;
        b=h877nwqv/hz9l4MgdZ+OlSZyPLDEhScJe1Ka62WN+kdjr4k87N1xzy/+zmcVmD6VJE
         tc/cWYfAZRAoMuLyBZKAjNY5mPmgnemQg+gYB0ieQWwyS5hqSzrnv2zQD24T+cVQ9ACs
         Fi6C+OsBKkEOdHkpkFEgB6ltD3muH7WuAL/2fzoAEYuAGf7Tp5yI1XtQjcQyojIkOMsM
         PEuwoGn3c5WNw5fEk+HsnmBCzuW1CptMV/k7aXZycaRVMyY7zV1S5eZd510cP5fAKZo+
         luQW4yk2AmP5Vhwr7MprUWGWn62eyWy7xDCi6sw1//RAeAvaBh+jzQwf89UgXKcpfv3K
         mo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM19Zpb49WbMFe9fBtRE94FQkhqV+5qq67MwOAw5xq12I3CONgymWQl2kwUzGSkL+NmDCh8og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGS04utqM6KLnxjXK47K4t0/ySMT2ZuYaZh6D79P9TYp21KgK
	LE1cJh2OaaxQC8o5Y9mEvgXFti767eNgbRxW0IRYsdQYENrWTF92GWj6
X-Gm-Gg: AY/fxX6mZdNkk6IiAMYjIYNKbL/ghXGZTlSp8Bv9PnpSVjWhRl9jNpUpRIp5tWQJQ6P
	Hk5M2b6SM7/leRnXPuX4h9wFjlNgQ4xATJLubZlTjQeU0NeO1DH1ye4JE1WmQUshW3/ViMwIdJt
	OqucQ/Gy8y/AN133zAXAgE+I3wVSa/msTuUr6fYJxWHN73wEacP+YTaxoOSZVahAkhvx1dgiwzo
	Vvx90mjrtW1cOp3VUhmNPPVRKTNZBmSsvoXkCgFY3GCvkxkMLLcnR/HolOAEU6D7BVLjwllo+S9
	/TvADdAQAV2E4wd865UR/oPlsLF68h5Y0H5R4x0d2kLX1DFxy6nyqtk/IKuiR0rp2uiegh2BqYl
	D6r/TCzXj1ddsp0gKYijewcEcvKh3K7REEw0K967GBjN5AiwxEaUaTw/vV/sde/rbRlxkGu/xNu
	I9qgZ6LwAR0N8=
X-Google-Smtp-Source: AGHT+IFGPQs3clltXIfWm+Vn8fLF+G/QkerjA1itJMxmint1Fsoag8kkKjn1NIkD84kir9MLUM6lug==
X-Received: by 2002:a17:907:60d0:b0:b70:b3cb:3b30 with SMTP id a640c23a62f3a-b7d23abe574mr221476166b.59.1765551119710;
        Fri, 12 Dec 2025 06:51:59 -0800 (PST)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5142efsm579431066b.38.2025.12.12.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 06:51:59 -0800 (PST)
Date: Fri, 12 Dec 2025 15:51:57 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: hkallweit1@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	rafael.beims@toradex.com, pabeni@redhat.com,
	ben.dooks@codethink.co.uk, netdev@vger.kernel.org,
	francesco.dolcini@toradex.com, edumazet@google.com,
	andrew+netdev@lunn.ch, conor+dt@kernel.org, linux@armlinux.org.uk,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	devicetree@vger.kernel.org, davem@davemloft.net,
	geert+renesas@glider.be, kuba@kernel.org
Subject: Re: [PATCH net-next v1 1/3] dt-bindings: net: micrel: Convert to
 YAML schema
Message-ID: <aTwsDUMDosM-aJk5@eichest-laptop>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-2-eichest@gmail.com>
 <176553538695.3335118.18332220352949601890.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176553538695.3335118.18332220352949601890.robh@kernel.org>

On Fri, Dec 12, 2025 at 04:29:50AM -0600, Rob Herring (Arm) wrote:
> 
> On Fri, 12 Dec 2025 09:46:16 +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Convert the devicetree bindings for the Micrel PHY to YAML schema. This
> > also combines the information from micrel.txt and micrel-ksz90x1.txt
> > into a single micrel.yaml file as this PHYs are from the same series.
> > Use yaml conditions to differentiate the properties that only apply to
> > specific PHY models.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  .../bindings/net/micrel-ksz90x1.txt           | 228 --------
> >  .../devicetree/bindings/net/micrel.txt        |  57 --
> >  .../devicetree/bindings/net/micrel.yaml       | 527 ++++++++++++++++++
> >  3 files changed, 527 insertions(+), 285 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> >  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
> >  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/micrel.yaml:504:1: [warning] too many blank lines (2 > 1) (empty-lines)
> 
> dtschema/dtc warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20251212084657.29239-2-eichest@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

Thanks for the finding, I will fix it in the next version. Somehow, my
linter doesn't catch that even if I run it manually, sorry about that.

Regards,
Stefan

