Return-Path: <netdev+bounces-159031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BCA142A7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DC3A5EFD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86530234CF2;
	Thu, 16 Jan 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqj/PJ7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1A230D15;
	Thu, 16 Jan 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057465; cv=none; b=s4Nb8/xaCZo90UzYs9+mkF94acJtImQACn1bBBGdFYgtF+7BPAP24SJlqOln1dagbR34r53qLQHeiNzIlnnXJgFCKGayjOxrcWsN/q+j3sOmiE/oRt0+P41KgC4eeYM0Y+X2BhBOvI931PpkGuCwcgewxzMGAa+3ITK67vpyM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057465; c=relaxed/simple;
	bh=BpGbL4CFfsflMGaBvp4j9m1dN/ZGd8uGCM2kddow5H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAjW1IV3NYXZd8ICt+P0Cxz2GhyOXwTNA8A4RBJom5FGrTFvAflbLHpQW6UmElDdACZ2rgeTfFZu3BaAMgxpuRBMwAAiAPB6fATXRPPEWYkAvaKlIx1mwPhFxIRcdyLdIOZ9F2sjFWue6rf369CvEWUITkuGuZNloNCDrkxihEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqj/PJ7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D391AC4CEE4;
	Thu, 16 Jan 2025 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057464;
	bh=BpGbL4CFfsflMGaBvp4j9m1dN/ZGd8uGCM2kddow5H8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aqj/PJ7JlbWZi20JPqqhgl4FtKBowEHKrr5py0QJZaT/h7NwbJLKWtfZF5HVJ+f01
	 eaumhpfu06/SjCfeP4TGZg7LFj0jw5dpOxHBHmnfIZjWAOLq6Gictv0ymZ294BVo+6
	 wZxDS8gqUVXCZFkkiyPfGqx6r+MImWIilKWs1HvUPklZ8YaFqKl3Gk24rjgg7ys+D2
	 TpIs5/FNVV7ktyFEOULoBvnjU5NoveD+FaNRhRgWJYYvPlaC2gBzCYDaoTGt87wI8+
	 WcnzI/xvOoCtspwq+cwpNhM8PyQ0GWcAnShRPgNtAGka16GTj2unoDYSF7vH1jGFbW
	 mkYRd0WRyzITQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30225b2586cso22797981fa.0;
        Thu, 16 Jan 2025 11:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW38vvo3stx7Ioar8nLc1MbPGeqpt4aVo7z81FL9fgFP08vGJZwHI2RLusrHINGIk0TCSXJ59IcwZ3x@vger.kernel.org, AJvYcCWPYRJIkDtAGvVQvLYm+QBuFt60rsNME98I3qxLSiZfbZ4aovU0d1DK9emLQyHxSSVAU8jr62T4xwtHo8D4@vger.kernel.org, AJvYcCXNxpFpLHNf2ls7C/lgIDPTX3PE4vVC8I3k7DvpeSRyeRz71MjCyz5HxkFBx4jtp8bUo33sDDdF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmz+/M38sM09yJGXf2TWArHNanO2ps6GD1pS7fQ/lV5dlSHYzC
	z/uPQL1kFUiYMGu5lpcvNTBQ/0QdNnKvfZzVu3LpeN9Ra9YJ8pUHSQURhi8RMf2l23/wR4vFNiy
	xlvAFmIuapKNAYTtQx6kEurO2Mg==
X-Google-Smtp-Source: AGHT+IE8PDn7axUoinBnTIfZ0cfMVPVQgH/bj9hTJDusIxJXQXf3Z2wDnrh+6FvWe+I1CQJPWkBXl12skSmq8p7UwQ8=
X-Received: by 2002:ac2:4e16:0:b0:540:2fe6:6a3c with SMTP id
 2adb3069b0e04-542abe955e7mr3496186e87.0.1737057463177; Thu, 16 Jan 2025
 11:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114220147.757075-1-ninad@linux.ibm.com> <20250114220147.757075-4-ninad@linux.ibm.com>
 <173689907575.1972841.5521973699547085746.robh@kernel.org> <35572405-2dd6-48c9-9113-991196c3f507@linux.ibm.com>
In-Reply-To: <35572405-2dd6-48c9-9113-991196c3f507@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 16 Jan 2025 13:57:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
X-Gm-Features: AbW1kvaz7cz0JErISAQO978pEbpoqDGvU0yV8aV8M5Xy632yu2go8X9lmt54eW8
Message-ID: <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, 
	linux-arm-kernel@lists.infradead.org, edumazet@google.com, joel@jms.id.au, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org, eajames@linux.ibm.com, 
	minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 9:04=E2=80=AFAM Ninad Palsule <ninad@linux.ibm.com>=
 wrote:
>
> Hi Rob,
>
> On 1/14/25 17:57, Rob Herring (Arm) wrote:
> > On Tue, 14 Jan 2025 16:01:37 -0600, Ninad Palsule wrote:
> >> Allow parsing GPIO controller children nodes with GPIO hogs.
> >>
> >> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> >> ---
> >>   .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++=
++
> >>   1 file changed, 6 insertions(+)
> >>
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> >
> > doc reference errors (make refcheckdocs):
>
> I am not seeing any error even after upgrading dtschema. Also this mail
> also doesn't show any warning. Is this false negative?

I believe this happens when a prior patch in the series has an error.

Rob

