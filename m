Return-Path: <netdev+bounces-119129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD1F95444A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75622818AC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808613A896;
	Fri, 16 Aug 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoMH296b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FA13A26B;
	Fri, 16 Aug 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796648; cv=none; b=VHOximy/NbijonRjavuixbk3Ff9isBNyl9GsTmpKkzkwWaIT58KrqahdjlNxSOFdaSQgGQx/0u0U9kiFTy7jkJNpd8nYuNN5pxWikw08hvu30B2SoKilt8G7i7CYEOnuOyec8xPnWUhQLNkXDOMOZPyKfk7hZSbwCUc6axhbwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796648; c=relaxed/simple;
	bh=IiNHzqaGpQsMRMD9TA17SqkxP/qb21zVGIdoXUJ/IHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYctHFaGrJV2fMtDI9BIXxAIT6brrsQQAlbgC0Zce+DgU6uVf8J/SM10/1ZaBvtHUm0L6J+FfiBayWhlYfrUKmCW2YkNc+wc8h3SU2mTW4Jj0pzpgnDQbgskqNeegpNJnCJLmSKdBwj3GxJ8oR2OorIDu/C7V9NWvSqtdZ6pmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoMH296b; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-268eec6c7c1so1124680fac.3;
        Fri, 16 Aug 2024 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796646; x=1724401446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mt7cmJhnccQWu/9cWXpdzK0cFZpHG00oH/rJ6h+75mc=;
        b=FoMH296bmKC7bAqyeWlZ+N5PY3+EhrVwChbPr9V6HVyTSuAOQ6trK+07yqUAQUIQtl
         79DhziR05SHFZTfkU6f7TiecNen8YppowNv293+4ZWOm5Q0yOUmXIig4fk8GxF1MXrBY
         W/kmsRfpwz31ToOiSIyvzk2+gafQ3r8DyVycmz2mOtJCfn8RgZAWtn/TpgcPAb8+NN8r
         OThNPIFHEPBFxYR40xKCBs2/k80qn1A9aSsUNg69jQ/161VwISOzfgCAo5Lwi8pmULXG
         yTKZw3ujbc+b0dD+OJ81R3BqJgsARR5NGwF2PHmulD1JGs3rbPjh5SJ28BHCtXMuCBm2
         TMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796646; x=1724401446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mt7cmJhnccQWu/9cWXpdzK0cFZpHG00oH/rJ6h+75mc=;
        b=vq8RNHmORgM/PERosw9Sc8BTqusYwt7BBa8oNK4UPPoIh3i85QGmo+qILuVoI3l/EM
         tN6RqUJ7x91AQSVqUxFwC11UkiC9zxmImPGXjDKR7W93aC/qranzY91EZ6syPb5eT5gi
         yy8EFvXoo63BW/nLdfEMdk+NsoyaxhqIVTtm8TmNWgx4HkX7O9fxzaTJzO8C66IDeWl9
         XDP4HtvOnphdGIEc3UH2No9eyWNEiWC8eZ2Wm8IJQ1uUBsjkvkxI2Sq/EuVziCaq49f8
         aXWkEuGz1kmslmF361HyM+KybUvLSc4ijmhqkEimHrQ0Wl9Fu8aVU9HAjUc4m0iCswiy
         e2/A==
X-Forwarded-Encrypted: i=1; AJvYcCX43rppQ9xcUnwl9BjAo6CXFGL6ft4IvpqM+pct+BB22cW+VQA0+asuudPQ8pxbLss3+nN4xEchpA6cT+ERsPCtDSAKoNWFPrBt9e7GPKYFmGl+vXvJbtcAF/XxhPo6vrbAvw+6wzm+qT784eeG5Y7CiiztR3VO6mxtN/phYUKWUg==
X-Gm-Message-State: AOJu0Yxo8w4b4Ga7H+foDqOYp1QAx0z/iIUwqUncA4F9OJoKIIpxcfSQ
	PsKUfKAfyMl3HTUYpf1OExsViSg+D7xr9OVCtt+iegH5u4cfBbwkgmn10WsmqTKC6iBOcJTIctj
	YF/U9ImApbSbWOqR1Rfk6ctAkOck=
X-Google-Smtp-Source: AGHT+IFB08B011Hg+xh85G9fYink+w99UUHcebksfvo5gqopEdUjZVwkWvf8XdImzq3WYMHCIREcF/Dfb3/AFPcmWAA=
X-Received: by 2002:a05:6870:4154:b0:270:2733:8159 with SMTP id
 586e51a60fabf-2702733c0d8mr668903fac.17.1723796645803; Fri, 16 Aug 2024
 01:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816065924.1094942-1-vtpieter@gmail.com> <e3dff6ce-7fb2-47fa-9141-9281e5e9de5e@kernel.org>
In-Reply-To: <e3dff6ce-7fb2-47fa-9141-9281e5e9de5e@kernel.org>
From: Pieter <vtpieter@gmail.com>
Date: Fri, 16 Aug 2024 10:23:54 +0200
Message-ID: <CAHvy4AowJHZNcJB=ZM7h770jcGxPhQ_Pb6y+HU68c4bnWWKY5A@mail.gmail.com>
Subject: Re: [RFC] net: dsa: microchip: add KSZ8 change_tag_protocol support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Russell King <linux@armlinux.org.uk>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Friday 16 August 2024 at 09:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 16/08/2024 08:59, vtpieter@gmail.com wrote:
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Add support for changing the KSZ8 switches tag protocol. In fact
> > these devices can only enable or disable the tail tag, so there's
> > really only three supported protocols:
> > - DSA_TAG_PROTO_KSZ8795 for KSZ87xx
> > - DSA_TAG_PROTO_KSZ9893 for KSZ88x3
> > - DSA_TAG_PROTO_NONE
> >
> > --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> > @@ -53,6 +53,7 @@ properties:
> >      enum:
> >        - dsa
> >        - edsa
> > +      - none
> >        - ocelot
> >        - ocelot-8021q
> >        - rtl8_4
>
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

Hi Krzysztof, thanks indeed I forgot to run it after my last modifications.
I am aware that the dt-binding patch should be separate, I just thought
it'd make more sense for this RFC to have these together.

> Anyway, what does "none" mean in terms of protocol? Is there a "none"
> protocol? Or you mean, disable tagging entirely?

Indeed the 'none' protocol is DSA_TAG_PROTO_NONE which means
disable tagging entirely. The concept with advantages and disadvantages
is well described in the paper with link which i part of the commit message.

Cheers, Pieter

