Return-Path: <netdev+bounces-267067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKu7BDnDsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:44:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB1272D0A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC9AD3064BC3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCF3BD64D;
	Thu, 12 Mar 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC+y+b3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4B18A6A8
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322872; cv=none; b=qNM6Mgz1xslaAf3r++7h40Hr/5a7yIdIUIAzAoixLVmcLhl+Nvw5iu7v56o/nBRP/TLl6hHM8bzoMWeb8CfsG0p9tsCpIYbitHkbJOTsIFxE1n9d4Wjzp9KLDTUUqQfCzwSR1K0c1srh/UAXod0FChOWlD6uFUCjT3WVVSSEn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322872; c=relaxed/simple;
	bh=waraj5aVzmh8TaApwAwE+I7GTdNW5H0awz3aoMmNyyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNKK6NPMUCNmuI/nvq/ny03xfZdjf2dFzEsIuFJWMA0rNVx3zWktetlGeW8fGpMX0J+AGJjEbgF7rW9n/Cl1ctbWuaBwxdOnkCfuYTpk76/cdjILTcJPFwGFgoxDMfHyfdSdJK0FTTjZaYkMhBs6Lo5jwmLaziZYFJDdGH+DWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC+y+b3U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso3332764a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773322869; x=1773927669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAwHxaCXl501xCvwTjF8MsYHH2W+UlwYAi/493OFfIU=;
        b=FC+y+b3UtlYe9p7/e8Br0wM5PCjo1zky6OiEZd3JefPnp6yIKL/UNYxWQMAafJSqkb
         bvTK2QKxLx05oDfsfWu8j7OIqbN6aQc3sHHXiXfIIleWaLP5Z7dql1Pca3Z3thNBu25c
         Ffk9rWEu97SruD0ImfeQDxOrHD3ghZGG5vWdHLno5WZj4EK19KU+s6zrVTyzFdJGCrDs
         XlW1IzG7KDwWaosCwXmQa0jv0zqPGH0kYFu2ydQQI4FxDKdJWLPn4TIKPHZasesG8qbu
         sefFwMrK9gYYJZjMnmPZqINqDFsznCd1jsd0pp0t2+5ZEssDrvK97I/tnuUJ2oGBR6Z0
         r0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322869; x=1773927669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAwHxaCXl501xCvwTjF8MsYHH2W+UlwYAi/493OFfIU=;
        b=wkKpQTAEHmehTkmvZLEJZtNCLaAw1Xdw4vZdC4cNMdkfYWxfdcI1EXkQrJuITlfHhs
         ymTj61BcSFQrR6A9Gq5vvnXZlcYwkURn0vCWy3K0+Ekq5K2TQospjnYKEG93tBhpBqcE
         rHNYJ0bOIYf49+IoW5laf5FZuasz/CP6aPPDELtf1Y5mJVvboiz56LyC/jqiZ3UxIPUT
         iSZEC+ZfwaSajJWEoXHEAHBDkkfu+ERGVS+Cl3V7TwCT3DmDHaF06UGfxAuT9HSIbE6Z
         rNfrPItxcwDZAqUg7OV4TuxEuxKZSw7XTvtP8hQZOpQkYQPpIgXjgucOVQX2NZN4Zda7
         1+8g==
X-Forwarded-Encrypted: i=1; AJvYcCWt61wu94RgWAMOAgY9sqyPG8aDWhMZbCPdxwR+KOLY0+PK32lWIvnW5GWIZyCFG5LLbcsC6rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KqwCQY6Xti7DYshe/xNk7LQ49lNYLJY2CfXMXTv0JWx0Mh25
	eN+SaOJoBeRGc+dB5x/IjnkhsLiphkeIg1I6S7ucphlrWRJIsm9vUWrH
X-Gm-Gg: ATEYQzxhq/6/UreOqyNDt1Ue6VU0EZn+UGJp4AxcvMUsmCQLvKzSAQPr3xzb/EtJHrL
	x+Ft6KI8Su+2byGZ3Et9e0tm8HiyVVmBK8mpTutopw7Iu/nj9rktuuC0dYrv4QOxsJMnhV7wAfA
	uRhJSCOrLQKcLrqlRvZXNW5DYuD3PSDpU+o+7wSpdqJv1El4rVeEUWziH///xcFQ4/j8Ve9E06B
	obpwAwfuPDMaJEW0TqoB4yyNAotRnT2lfun38ZcSeZOQEH7NbZOm+s96o5pnRmPQCFjjCbzVEVP
	HiMBU5HFGrZHI8EdM/Uy4zu43VLIoCR49LO38z6SofIC2LJrBEJHHAV67ad375xvC3OjvwjZwwA
	Vr0jTOm0Yu/VTipdPYohtt70u+sKlzmAvHl/DC9D6i7OPd4raVMbgnicugR+lrizRc8jbc1Vilp
	JURCvKcYNx40zW3whWjfglHK4=
X-Received: by 2002:a17:906:fe49:b0:b96:f02b:3d5a with SMTP id a640c23a62f3a-b973ffcee42mr208925966b.16.1773322869240;
        Thu, 12 Mar 2026 06:41:09 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14dc3asm135857166b.39.2026.03.12.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:41:08 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:41:07 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: micrel: Sort lists
Message-ID: <abLCc6Kb6xIQiMZr@eichest-laptop>
References: <cover.1773321267.git.geert+renesas@glider.be>
 <013afe74bef9a4d4af8b5a204cb4891518f7274d.1773321267.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013afe74bef9a4d4af8b5a204cb4891518f7274d.1773321267.git.geert+renesas@glider.be>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267067-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email]
X-Rspamd-Queue-Id: 1FDB1272D0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:27:35PM +0100, Geert Uytterhoeven wrote:
> Sort lists of PHY models and compatible values alphabetically.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/net/micrel.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> index ecc00169ef805dc2..5d25f0d0a508a6df 100644
> --- a/Documentation/devicetree/bindings/net/micrel.yaml
> +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> @@ -51,9 +51,9 @@ properties:
>        bits that are currently supported:
>  
>        KSZ8001: register 0x1e, bits 15..14
> -      KSZ8041: register 0x1e, bits 15..14
>        KSZ8021: register 0x1f, bits 5..4
>        KSZ8031: register 0x1f, bits 5..4
> +      KSZ8041: register 0x1e, bits 15..14
>        KSZ8051: register 0x1f, bits 5..4
>        KSZ8081: register 0x1f, bits 5..4
>        KSZ8091: register 0x1f, bits 5..4
> @@ -80,9 +80,9 @@ allOf:
>              contains:
>                enum:
>                  - ethernet-phy-id0022.1510
> +                - ethernet-phy-id0022.1550
>                  - ethernet-phy-id0022.1555
>                  - ethernet-phy-id0022.1556
> -                - ethernet-phy-id0022.1550
>                  - ethernet-phy-id0022.1560
>                  - ethernet-phy-id0022.161a
>      then:

Looks good to me, thanks for the cleanup.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>

