Return-Path: <netdev+bounces-221266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DEDB4FF6A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0063A5D5B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0634DCF9;
	Tue,  9 Sep 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDtAtzzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5034AAEB;
	Tue,  9 Sep 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428210; cv=none; b=Ocl6isoJ2uNsirAq/nXBG6A+26FUx87P+eTnT36ZiftOFlcM6i1xBfNTTXG+cHsSp5vbyvpjSVeg8i/P5UQn+GwhJsm5Agdq1Wywh9fu9UVuWr9UPRakNpl7YPggr2gaefkUIUB4ey63BZFhrQhy6m9SrvwoJq0SPPWoHrblA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428210; c=relaxed/simple;
	bh=KRjaBtF4hYxJsGseUeg+Y0eXGfXJT0zaNr3kbrQCUR8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=W8WIS7D88uzQmg1UZMB6zyYjS8lhWDJHAAkCWdqPFgszBz/eqNgQsivky8UtTLhlfyH/QjX3mKdtvqS+y72RNZaTyh37JHVho6TafMc7YlOvOoVbKLPgNikTy6n4quMJl5wcXnJN0hH/nVeoLbtrvIFH8Q/5RuQssES9NeDUZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDtAtzzm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e751508f21so662191f8f.0;
        Tue, 09 Sep 2025 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757428207; x=1758033007; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eafzXxLVuwYLYmi+V4eFRSHBip6LsOIhuio1i56TeOo=;
        b=nDtAtzzmzBjmL9v8NlWHRHah79CJ1ENm9v7ID1pNXmDbs55twXViaTOBoWi94Tzxcy
         7KSeTH4vxCPxJ7kFDxpNz1y1HeO0zy9yj3hTGioHhQTbkiswFgBzRlMfQ7jwMi9mM4CP
         VCNxPrNDvGXwGM+mipRmchU77zCr2GRGvs0licrXKeRVdwVSrRKkGppoFJB8DHtu5+Ey
         e/zbiG+s8ACTwp03sQM/LPQPjMjjjPbJXUW83U7OT0lb6fY78jfxT3JuW/TJXF4pORPk
         UtUGuh2bHIC3V/tPN6m3z4HCQCc8k+J4RCyr1MkEgM4IGmUAj/5a9oInayyzsAgxBR/D
         BlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428207; x=1758033007;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eafzXxLVuwYLYmi+V4eFRSHBip6LsOIhuio1i56TeOo=;
        b=JgqoHnLgwzgIU9j5O9Slo/cDEFpRa5PbhDqR65XRktwZ8oJbdW3B/1E2s3m2AeXfY9
         kIO6GzMO/UYFUDaMBFzPf4AcimFg74T18iAmEF3wbmbUvjq2FYPPmo97cAbY1cP/eKBt
         LvMQS6H5wHanaYY82eZCucypyqMiQy3vhgzImfZzAJOPUNrc8d0lvB02XdfbjI3wBC0z
         f9+Sl6Z+PfjiH1aEhPvgDnwF5LWB2vzfPFS6bQ5YVm6Zr+z+hgVhhWcF56xnxdf50V1k
         rkfycz4H5dGUy89qxbwDmmPUpS/oLdCGgkV02gYGPaWOWFCIl7iYIIJNw8R8tuZQASf+
         hnpA==
X-Forwarded-Encrypted: i=1; AJvYcCUEy4uBvqtNZWzksXaCY7GuOM5AedGOsJwrqd3PTfhd0j/wD9Tsq3Ck2XQ/71ScJiQWqJE7TJpEgCcKALQ=@vger.kernel.org, AJvYcCXi/Vqsv2FeP2Bjl1SnDfpRGNhDRe9bToPJLrq2H86R0Zs55jM+BeCiDETLoqPOut11Kx/6huHr@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgQ+6aFDXooLep409eB/1PvmmgrH0AAv9g0Hj/QgMCqI39O0x
	/Sj60W9Nfhy9mM7G6TXOAfgL5JbCCIL452olp8qnsW/N6lQZ4er9iIeY
X-Gm-Gg: ASbGncuon7ozaa/G6tz+HswPjG4mid16BdIZ+IP1f9sjPGJ85zJrM8uNJq77NMTR1DE
	9D0KpDvsq/bcWYiXOD48MPkNl010tdg4woljSuyZqdpKqalDv7JX7wLUjjNQJ6ldHuFdvr//3Mm
	ydSCC+Q2JN4MYwDSrDIO87JI/xFgab0wlLZZZ7xXCClhKGuXoYA5Bp4D8Q4HKA4MEEvdtUQHIf1
	pzUkhcj1SQHLkU5KwVk/DELATKkmWfpLGzEgqAwMUMgHUzZWR6pDq4nzHQ70xkSWiRUyygn6WWF
	lsWXUzYYhY0wixHpHsUMlGiJrlwgOUJXZiomgi6QDi0GkHWRG3HxgshC+S7SwK9Zj6Da2jSFLR1
	apap2T/5RrYcD+L57/365vr3gmEae27Lr8A==
X-Google-Smtp-Source: AGHT+IF3z0trXsqtmFusmmSttovUbEF46n0A1Xs5kgPpDUNsp2VsCMkramwt1fxfPirQNkjeJMdi1w==
X-Received: by 2002:a5d:4ec5:0:b0:3e7:4277:ddc2 with SMTP id ffacd0b85a97d-3e74277e0e1mr7787119f8f.10.1757428206503;
        Tue, 09 Sep 2025 07:30:06 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:837:bf58:2f3c:aa2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df15cac87sm11373855e9.2.2025.09.09.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:30:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,  Heiner Kallweit <hkallweit1@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Florian Fainelli <f.fainelli@gmail.com>,  Maxime
 Chevallier <maxime.chevallier@bootlin.com>,  Kory Maincent
 <kory.maincent@bootlin.com>,  Lukasz Majewski <lukma@denx.de>,  Jonathan
 Corbet <corbet@lwn.net>,  Vadim Fedorenko <vadim.fedorenko@linux.dev>,
  Jiri Pirko <jiri@resnulli.us>,  Vladimir Oltean
 <vladimir.oltean@nxp.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,
  kernel@pengutronix.de,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Divya.Koppera@microchip.com,  Sabrina Dubroca <sd@queasysnail.net>,
  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v4 1/3] tools: ynl-gen: generate kdoc for
 attribute enums
In-Reply-To: <20250909072212.3710365-2-o.rempel@pengutronix.de>
Date: Tue, 09 Sep 2025 15:05:22 +0100
Message-ID: <m2qzwfk9gd.fsf@gmail.com>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
	<20250909072212.3710365-2-o.rempel@pengutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleksij Rempel <o.rempel@pengutronix.de> writes:

> Parse 'doc' strings from the YAML spec to generate kernel-doc comments
> for the corresponding enums in the C UAPI header, making the headers
> self-documenting.
>
> The generated comment format depends on the documentation available:
>  - a full kdoc block ('/**') with @member tags is used if attributes are
>    documented
>  - a simple block comment ('/*') is used if only the set itself has a doc
>    string
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index fb7e03805a11..f0a6659797b3 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -3225,6 +3225,29 @@ def render_uapi(family, cw):
>          if attr_set.subset_of:
>              continue
>  
> +        # Write kdoc for attribute-set enums
> +        has_main_doc = 'doc' in attr_set.yaml and attr_set.yaml['doc']
> +        has_attr_doc = any('doc' in attr for _, attr in attr_set.items())
> +
> +        if has_main_doc or has_attr_doc:
> +            if has_attr_doc:
> +                cw.p('/**')
> +                # Construct the main description line for the enum
> +                doc_line = f"enum {c_lower(family.ident_name + '_' + attr_set.name)}"

It seems potentially misleading to emit "enum attr-set-name" since they
are anonymous enums.

> +                if has_main_doc:
> +                    doc_line += f" - {attr_set.yaml['doc']}"
> +                cw.write_doc_line(doc_line)
> +
> +                # Write documentation for each attribute (enum member)
> +                for _, attr in attr_set.items():
> +                    if 'doc' in attr and attr['doc']:
> +                        doc = f"@{attr.enum_name}: {attr['doc']}"
> +                        cw.write_doc_line(doc)
> +            else:  # Only has main doc, use a simpler comment block
> +                cw.p('/*')
> +                cw.write_doc_line(attr_set.yaml['doc'], indent=False)
> +            cw.p(' */')
> +
>          max_value = f"({attr_set.cnt_name} - 1)"
>  
>          val = 0

