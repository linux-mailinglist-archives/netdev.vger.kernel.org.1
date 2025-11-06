Return-Path: <netdev+bounces-236382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9AFC3B709
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899421AA5C9B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483191FA272;
	Thu,  6 Nov 2025 13:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CED22A4EB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436974; cv=none; b=SZnq79vJasyFGFi5ZAwFYIZOE6wasNhWLU/aUFpkhrRH5KdaiO9g9hnugcCVZPO1MOZ5/uBmgifT5RX8zcQdQPTG5/vV53/nhTLDVou2Rveg2yhCVToN/rfmSjDwe+C+xQXGdVlak2gcOzKqcwfnpAuSr3SlkPGaCTR0FN2TMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436974; c=relaxed/simple;
	bh=I3VUE6vhtWsWrhjiq89donvlpgI2hn86BAEVlUadz4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ5VsN99jqpWYM7V0NqeurVvsm3EU9Zh40M+PHme89U8OQu2Q39JiEPLDZ6jHrOuOnoMHnElNwythP1dNUxJ7sXWCRdkMfv+e3que0UkyhK+8d22hORb8Q/PfB8/nF22pzGfI0fETdrsdF41WB6exKKfGWTNJNIwXBib7Pylho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so1198796b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436971; x=1763041771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zvXQzHMZF+ClpmnJuOqJcZtH05R/CK4p6fsF3c0XaE=;
        b=USC65AVpZJDPzzPhkIb8ir6+LXVU7snuv6InvGMMyCd9AFS+Qf20SIAdXhVxuvMp8s
         /PFkkJI++nLvolh1dY1VKx7impVIJOHMdaPyKhmukAxcLPDukI2pVwj6kHGwrLGqiOua
         gHlg4quymheDnTmk/JexItLsAMxtTUpRge4WNA4vuOmKBtKfRyj0rUyuCudQcP3n/085
         X3RDO4ZMLwJDEnmkMwTvyhnesUkeKVZHw7wMMrxl/tiG0QplnCk5VAFXFJ7D9Ee01v0F
         QuE6APNTdYpisMJgpRKFh3MkNEfJrKuVWe/OnKWehkqR8+MRgBt6imOwWpTIChIYi1Xn
         T2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUfoao8Co0Sj76sFBlzD9cGPdp93hl2boZTLNyv7iQLtYQgf1nX82epFOHlfgwa2OzPXrl/Ido=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDoVp/PJgXXgc3VNrwAo9In0fgMmYS4SoC7Ch9Lg56J8FfF/A
	6fTvr9TLcXulXijtdeA7DWZOsOvd1en6hSwcNW3KBh8PEQYK49xX+NhN3xvq9yG5
X-Gm-Gg: ASbGncs2V3n3Q0buLXuwmMH4eYMi5DtxjzQ4Mu+WwCtibC6UeCZ/+5HORZRzBZUz97P
	GuO2+zNIjprRDrnoXvnZ1ECMy2VmA5h7qxJsn2mRVixpuYZY5pc5tpb3cRB/NHxEbHKcJ8LtlCt
	Q/aED8H3co7PpMlsQ5T3gOL53u12P42iUIwtEVrWebXtEkLVQLc9YzRFL6+1jBJfY7zuscHeFZb
	c/qZ2cwP0H97cBFu2zTf4XRveJgQ7FQjNgN0nNocRo2Tosvsti3IAW6bIXX1luag42wTCCPpsaH
	sn9wqxCyw4eaHSp/IUnrZUrBOTQz3zyLCnsterOaJ9zLrxRhbiZkFRX4cmO03MdPmECBkhhL983
	TOK+1WZrt83IyPMxRqWgQ9ZnGoZcusuqPkL6nG7g5BjAsg1xRnQ9Lpa5EQnawNgfCjn3zf1+EQ0
	miM/y7R+4LXfnh/LvBFIgpA4ERXimpNtAQsMcoWYSZ4g==
X-Google-Smtp-Source: AGHT+IE3Kmnaj2XzUig3jg7O2k7W8U9bDIzBlXMvjwg/f/jI+VdaZ4JKs4uL56JffoOS1eiQFUd3+w==
X-Received: by 2002:a05:6a21:8984:b0:350:66b2:9722 with SMTP id adf61e73a8af0-35066c1de70mr5883150637.17.1762436971123;
        Thu, 06 Nov 2025 05:49:31 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed1e73sm2758190a12.12.2025.11.06.05.49.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 05:49:30 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295247a814bso13692115ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:49:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUtovxi+3te8pShI/z4uCurgtVaPSt4QyeI/2Y7irmFGuG5gve88CVDyOhr0hmyw4dh7APER4=@vger.kernel.org
X-Received: by 2002:a05:6102:1620:b0:537:f1db:7695 with SMTP id
 ada2fe7eead31-5dd891f5d34mr2214888137.26.1762436493734; Thu, 06 Nov 2025
 05:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-add_l3_routing-v1-0-dcbb8368ca54@renesas.com> <20251106-add_l3_routing-v1-3-dcbb8368ca54@renesas.com>
In-Reply-To: <20251106-add_l3_routing-v1-3-dcbb8368ca54@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 14:41:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYzpJ8iqyPqbR7Bd=qpqDyV=GJ+Vw5fZ2G2S27gYO4+w@mail.gmail.com>
X-Gm-Features: AWmQ_bk8o_RbFEO18v2EcWGSAt2mahWgELrgaPK-1AkGfKDcrGdbiBTIxT5Zu7E
Message-ID: <CAMuHMdVYzpJ8iqyPqbR7Bd=qpqDyV=GJ+Vw5fZ2G2S27gYO4+w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] dt-bindings: net: renesas,r8a779f0-ether-switch.yaml:
 add optional property link-pin
To: Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

On Thu, 6 Nov 2025 at 13:56, Michael Dege <michael.dege@renesas.com> wrote:
> Add optional ether-port property link-pin <empty>
>
> Signed-off-by: Michael Dege <michael.dege@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
> @@ -126,6 +126,9 @@ properties:
>            - phys
>            - mdio
>
> +       optional:

Doesn't look like valid syntax to me...

$ make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:
ignoring, error parsing file
  CHKDT   /scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:129:1:
found a tab character that violates indentation
  LINT    /scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:129:1:
[error] syntax error: found character '\t' that cannot start any token
(syntax)
  DTEX    Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.example.dts
/scratch/geert/linux/linux-renesas/Documentation/devicetree/bindings/net/renesas,r8a779f0-ether-switch.yaml:129:1:
found a tab character that violates indentation

> +         - link-pin

What does this mean?
Description?

> +
>  required:
>    - compatible
>    - reg
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

