Return-Path: <netdev+bounces-116777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E66B94BAD4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA101C21FAF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92336189BBE;
	Thu,  8 Aug 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5DBtPhO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED4188002;
	Thu,  8 Aug 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112662; cv=none; b=tVywlqQT7YkSPWaelUXgDTvyjDeTGIaYTKYytflEB/LU2gljzATit6o3KbnpkhreAqx/YgxEgJEqGaP8A3QqhVcDJH0Dytb2SxkpOFOb1F9UmfBm2KscQ04ZatOlEXRdxrkIybJHFtrcLpXBiV2zH7Qta0TQFgwmQ0YaAbu/MEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112662; c=relaxed/simple;
	bh=0h8X65a3TGdk6XooFBukyv3OsQLApBPzylo8BcV2a7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB8ZsbbRD8724qRDAs2NwGwqjYqGdrBEPBFQdPfB0AotkkrHolOws1oM1cI0HwQW8RAxYB6WQIEsCMXq/IlehYeO6FMTFzN00ulMvhBgXFBUTISygfjuFQax4QMwheM7nYnePT+PdcsaeCwqxq3tUAZwd6B2nO9WzjSc9p+AgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5DBtPhO; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5bb03fe42so401854eaf.3;
        Thu, 08 Aug 2024 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723112660; x=1723717460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0h8X65a3TGdk6XooFBukyv3OsQLApBPzylo8BcV2a7U=;
        b=P5DBtPhOSPuX8JMUg9v8Ojd8cMdFpkCEfKwgd8Ig+r3VDQUqOSu5Jmec3h22AHE4YO
         jvFJDjtM+LtKUjSuszR9Wgsw/LMdNCWubusi2EG9jo3lULrDhlrcQhdR2iCfnPdtHosg
         +2pSv7x2nABW0iWeI8AJS2b0HVeOWpAQkHDb59VYLreUkmld/KizONNPiRd2G+0J5EXj
         aMWg9hloa/w5Dz3quqi8dN5/zC2AI/yHbpaEYWTxel1iLoM9tlY7MPkELDT8kINEWmKm
         IKaseEUJlbh+WvEvhoB3KNoCFQ87Ul24DCF7nLp0i0u+y5S76eFVIsITwkyv+eZ/X+7t
         vtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112660; x=1723717460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h8X65a3TGdk6XooFBukyv3OsQLApBPzylo8BcV2a7U=;
        b=VL71MMCGDoSUQR2693wvDL74sogwAuKVjz3kja2yI3795N63W27WYwdLMV/nI5biXu
         ZGGV8IT/se21cay++1XOBPXauEB/ZuRgcMVANZBxaO70zdHjKHfz8Q2jEHjbgZF23ofI
         krY4wBEIdq4gW4XJOMV/nOSTMpkNHZNO57AvVDtwVOIk496NKnWu/r4wIH3mmcKL+IMN
         IUG/aOP8tAJYtF0CWtKE7jKnANXittUUWZQE28fp1gn+fXnZOaD1qqyZ42mwUv4ILlgP
         o2qzJIrphulqGhDw7PrwwXB3vDVBptvflwHGYtGvmQfifa3AYCA4BvtdYQBmTuGrSVTH
         BHtg==
X-Forwarded-Encrypted: i=1; AJvYcCVKpNQBavWAX6VKcoxVoHMw3XFch9v1pLTcK9lDsTQMwJy5CC9PdhhqXDXHe55c8Xvf4HDbdRgLjLq0ww6m38Ph0hI8Cdl9
X-Gm-Message-State: AOJu0Yykp7eINajRV/QQLvdie+cd/p+KC9Se597OMW9Q/cIxR4rIFEHy
	ZMQOtEhwBi+Y1JhrezpIJTEfNwM98bNo1KYa/13oI1j1+FfQTcvFMV+CSdNKfdHzEcSJeOctpCV
	xwH1aMezj/y5HPLRpN5OeNMZE4cc=
X-Google-Smtp-Source: AGHT+IFFTVlETuCO1Zr41NPyxcUtGZspcfL11K8SvlTW/f6SCXULvKar2Vf0iEjkjnLj50/QR/kiNT5Qeuk862Q2yOk=
X-Received: by 2002:a05:6820:2710:b0:5c4:144b:1ff9 with SMTP id
 006d021491bc7-5d855c90e79mr1325427eaf.5.1723112659798; Thu, 08 Aug 2024
 03:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801123143.622037-1-vtpieter@gmail.com> <20240801123143.622037-2-vtpieter@gmail.com>
 <20240806171704.GA1749400-robh@kernel.org>
In-Reply-To: <20240806171704.GA1749400-robh@kernel.org>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 8 Aug 2024 12:24:08 +0200
Message-ID: <CAHvy4AqNzvXG+DVZ0-mwaYbgpLcUhcXEvFo8+ODftr8tprAF0w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: add
 microchip,no-tag-protocol flag
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed 6 Aug 2024 at 19:17, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Aug 01, 2024 at 02:31:42PM +0200, vtpieter@gmail.com wrote:
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Add microchip,no-tag-protocol flag to allow disabling the switch'
>
> What is the ' for?
Typo
>
> > tagging protocol. For cases where the CPU MAC does not support MTU
> > size > 1500 such as the Zynq GEM.
>
> What is "switch tag protocol"? Not defined anywhere? Is that VLAN
> tagging?
>
> It seems to me that this doesn't need to be in DT. You know you have
> Zynq GEM because it should have a specific compatible. If it doesn't
> support some feature, then that should get propagated to the switch
> somehow.

Hi Rob, indeed and as indicated by Vladimir Oltean in a reply to this
patch, such a property exists already, dsa-port's `dsa-tag-protocol`.

Driver support is to be added but rather I'm changing the Zynq GEM
driver to support MTU > 1500 as in fact it turns our the harware does.

Pieter

>
> Rob

