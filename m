Return-Path: <netdev+bounces-221671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0BB5182E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839FE17E954
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E32320382;
	Wed, 10 Sep 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YANOrVFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6131E0E5
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511835; cv=none; b=NQxbEE5iuEFft7Sf3ynVOOOShWz0IPWRoV73OKOR7RBqPqXewcxozGiwfs0yLz8eEn0et22CiwiCn5zsE2FfcFbWpZn7g0/7UMjRvf3wojL10uf43w/OdvQL4kRLMwdBXk8Eb9gukYHTv6YCigvvivoP6pbsawY/Yk/pwn+uI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511835; c=relaxed/simple;
	bh=geyyEYjk1K6ztSTDk78aVJVN3bfFFO7mnbJHVuJmCv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1apN68XKCdz3pstBu61rqD8jGIqtwo5QkXbyG5dz6iKLwnts/w9Dvdb2jmSIqzAipubf/7JD/95HZ5KRduusqXmhif3Y27TyNZM7YauB09oFq7d/Fj4pzyMzueUzGgox2NCHFpwKM68Dojm/plysLR0aMmsD/LKEpCZMYzw91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YANOrVFy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336bbcebca9so52605671fa.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757511831; x=1758116631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYusx74gMgivYw43mzCgiUQelBrscv4e9WlUdU22ggg=;
        b=YANOrVFyFccA1JYWsWJbTWW/GzUPp2wituaBGlY/cQFANxiYpX2YQzm5AtuuKPBZWG
         ruA3Rze3+tjNKS4MuOg8ctXb0Ncp8+zW1hlJ9pL+1KQ5T/9T7Sha17FpiCIP7btqHzOE
         UiiBUczdbzwcK5NF6ZX8s/h2Goz2hznUDfTDEKmpFTGn9iqi+qXJZW+Gv0C/4hFD8j0J
         cikR+XdDEiOwcDmwyJupwUAna2MQSuit2jUVZPmYbdnPwQ1dLT1W/s6mMJ6Km7e2zVo3
         I9WMzb3L5jMZ+X502hsxWSj6ZADlmySD33MmZ5i4mRRdbEE3S/xFDzYlegq7Cz9USrDi
         aGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511831; x=1758116631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYusx74gMgivYw43mzCgiUQelBrscv4e9WlUdU22ggg=;
        b=Fc69nzApHvOGZ5MDhjT1dIDz9yQK2FWn5UkrSVFIqofSgM7iJkY0I0SN06GEkKukm9
         cHDljrUZC/dud4Qo/zVMGhT4Bq7nhbyYjVb3Gnz9TSVDjZNTKeQMHRLqfrOg85NMjKwX
         8vKwZ6lmZWNg7UoMMGW5sznym93XuKKYicO2kjcgysn2a8FJ8EIBm+fyK/kAGJz/9A/+
         AtHg9zEg5dVxZuPcxRhEonKcNFbgjo/EYbXd805rhAClQDAKPxo++M0vCx89MF97xI1R
         vSUf5Nfv7iELnFTexD7AGXmgXX/O+l0lYaxpDzCLacYdOpTwHKoVvn7nGwAEP5LRKWFC
         RAlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV/K0chNA0VpPkzRvdql8qzaaaPVfNWiWOTolyjSqNVTNGt79Iisd6O3cdCugdzyXe9BoOyZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmH2tneLyTwSTUVat/h1gzu+FIvFx7ja7R3XICtIs+Jx+XH4I8
	m4F0JRuu4PsE8b2/fBB2PzjsMfUn3K2ogiCZB2RefYrB0cLC80r1k/4bLk4VG3ISxD5cFT4fd4g
	jQBfMg7ahIhQdRe/rRMK31rAmJp7hOrzAwKsXnmdPDQ==
X-Gm-Gg: ASbGncsA2BcMCx4rpzUtrL5q8NIDiAmd2b5KqzADtFaLng84n6/P0QLcvXioqGfEU40
	Mji8em204olkmfQ0rjUc31pRu21jNolTbc520Ldt81NEOit8mS/1D3o2yZjvZgxhGiQrzpjAWsP
	QYLmmKHuxdVLhfmFdtzecoa4QekVCrc8+qd+Et58RzwsxpW5LczauUlGxbVWbkcWYcGFI75kxlP
	6vnfD/oiNsXHJOCkPfkLT3V+2P7yGZVW9q0SAw=
X-Google-Smtp-Source: AGHT+IFm09bgx/eETS+zxh47Y2IF1gRYf9rbRYIHHMrehDx0L8qn2Ht4Uw5vNEiZ6L2mWS3ck3SpU2dCp6qBpa01PJo=
X-Received: by 2002:a2e:be0e:0:b0:337:f57a:6844 with SMTP id
 38308e7fff4ca-33b5a3fdaa8mr43894421fa.43.1757511830680; Wed, 10 Sep 2025
 06:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
 <20250910-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org> <175751081352.3667912.274641295097354228.robh@kernel.org>
In-Reply-To: <175751081352.3667912.274641295097354228.robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 15:43:38 +0200
X-Gm-Features: Ac12FXyZX2mI5u5h6corBWI5JwEw3xwlMcAzjYN5jnXKYMZIVsaIzZH2ILMwq1U
Message-ID: <CAMRc=Mfom=QpqTrTSc_NEbKScOi1bLdVDO7kJ0+UQW9ydvdKjQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Eric Dumazet <edumazet@google.com>, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Vinod Koul <vkoul@kernel.org>, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 3:38=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Wed, 10 Sep 2025 10:07:39 +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the firmware-managed variant of the QCom DesignWare MAC. As th=
e
> > properties here differ a lot from the HLOS-managed variant, lets put it
> > in a separate file.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../devicetree/bindings/net/qcom,ethqos-scmi.yaml  | 101 +++++++++++++=
++++++++
> >  .../devicetree/bindings/net/snps,dwmac.yaml        |   4 +-
> >  MAINTAINERS                                        |   1 +
> >  3 files changed, 105 insertions(+), 1 deletion(-)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/renesas,rzn1-gmac.example.dtb: ethernet@44000000 (renesas,r9a06g032-gmac=
): power-domains: [[4294967295]] is too short
>         from schema $id: http://devicetree.org/schemas/net/renesas,rzn1-g=
mac.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/renesas,rzn1-gmac.example.dtb: ethernet@44000000 (renesas,r9a06g032-gmac=
): Unevaluated properties are not allowed ('clock-names', 'clocks', 'interr=
upt-names', 'interrupts', 'phy-mode', 'power-domains', 'reg', 'rx-fifo-dept=
h', 'snps,multicast-filter-bins', 'snps,perfect-filter-entries', 'tx-fifo-d=
epth' were unexpected)
>         from schema $id: http://devicetree.org/schemas/net/renesas,rzn1-g=
mac.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/renesas,rzn1-gmac.example.dtb: ethernet@44000000 (renesas,r9a06g032-gmac=
): power-domains: [[4294967295]] is too short
>         from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yam=
l#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): po=
wer-domains: [[4294967295, 4]] is too short
>         from schema $id: http://devicetree.org/schemas/net/mediatek-dwmac=
.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): Un=
evaluated properties are not allowed ('mac-address', 'phy-mode', 'reg', 'sn=
ps,reset-delays-us', 'snps,reset-gpio', 'snps,rxpbl', 'snps,txpbl' were une=
xpected)
>         from schema $id: http://devicetree.org/schemas/net/mediatek-dwmac=
.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/mediatek-dwmac.example.dtb: ethernet@1101c000 (mediatek,mt2712-gmac): po=
wer-domains: [[4294967295, 4]] is too short
>         from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yam=
l#
>

These seem to be a false-positives triggered by modifying the
high-level snps.dwmac.yaml file?

Bart

> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202509=
10-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org
>
> The base for the series is generally the latest rc1. A different dependen=
cy
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
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

