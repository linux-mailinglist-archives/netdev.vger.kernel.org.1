Return-Path: <netdev+bounces-222609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091FEB54FAB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C711CC7EFE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416330F552;
	Fri, 12 Sep 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZY+ICV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16335303C80
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684095; cv=none; b=U8OLsINkUirAyVPE587uq8VJg2Znf5MzJsXFsCjHnQqvOV7avF9e7ll8tdusz3RrqlrA6lTHvTYOQxfaWxZcaC5UUhe3euvhJA9P5IHYCz3iTGzlG5sdmv6N3zaGvUT3FefFAaKWQ/7UOPEBKz622hAvVA52/oL74lJpRjalRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684095; c=relaxed/simple;
	bh=fEA2x43XLCIFZ1HAK3Qmgt2WPelPhB3G6VX1hKyr04E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuRinNcVO6/zRz34BmD4dOxGcRkiGgHuyVpuCEn0I6m4+pu6bUZVVjM0zh7UmCRKFMNlF9FeT8CkCw92xiwbtfz9d0/vvI6EtNUWtHxvRI0UY/2vp98Xfp7eQPeIKYhQ83dwyKdl/lnj4ZeHOYrBKg90HPgp+THENG1GB+vGwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZY+ICV6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e9e137d69aaso1347665276.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684093; x=1758288893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2bpJdu9pcJQYlguGDM8bqSYyNGG/RarwGDha2QaDV7I=;
        b=HZY+ICV6iudkiQNYe2sLLea4NT501Dw4egsi9L6nTGUS3TP4likQcWCh0l33zEkBor
         qld7HSDUKGCUZ3+K0pF4lA1NirUluSRDV7pIkFP+hsPRrt7d8IVtUvbAqpgAtK/rMYs3
         ggav0uF00M845sDJV/DSYbF8jXSMUNnFIPASX80UqZyWNik35Qs+raHmfHG/lGH+933g
         CQB8WuC2LHrS3Tdo296WX3l/jWoi+AtyWBkgtjg9iY8nsGB/DEVUNeDQ4gFAkY+ayQoe
         gMTiOLlY43MuWoA4ffPTPYUnyJz8bzYTCWyahejh6QpwdZqjTto+O57VOagO0Y1NYmte
         SESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684093; x=1758288893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bpJdu9pcJQYlguGDM8bqSYyNGG/RarwGDha2QaDV7I=;
        b=XxuCAqc4Gcr3Xvx88AGq4iMlUD4NZDJMeu0DPTZ0u3anBescezNnKkKhYBQ33j7Ce5
         HkImHhRe5eA1cETTidGl1v3PwMH9wottKeJ6qUkFcQYhQ6L3ty0aDsFH4onDxLomuS9F
         fqr6Kau8Jfgzk7miWmuPih+DFI2rz9Aqz1RxhVxezN2JntenhhEqgFol0oU86dQi7n6t
         epQNOXY2trYwD6ZCb6cbo4aFqojqHbAixmNsd+IkWK3qqCh+eOtFa2gGQgF/x+SKk/HA
         pVLoDOrILcKZuC432D656UJjhH45YugmSRmso6dR6paO2HE1e8sYBXx/+hX/gWYIi5SD
         CEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWs14u7RVymNFQyMiC7fPo+HI2htbIJ8G6RnenZ92eSOVY5pkhjC4Nh5YaR8x+E0LvY3dfXqcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01QGL4mmCe6q4RmH6gsr2R3RDn+l/AB/58zsCczyUI0ht8mYN
	0A96eObTTmSJAT1uE60U9HIN9u9oJ05zYP6VFdKCFMU0oj9TFkY4blBoi/3S1MkUcljZM+VPJjv
	spY3JFftWdjhjZVK3x8muOm7xx4VhckzktPmjqMaKOBL5jn2rtA/z
X-Gm-Gg: ASbGncs+ExHQ0Fvo3+AXrb1A96czpJFenzRoodsZvneOXX+HWacbklfVPKI8QIatU9V
	KI/GAi145fFiEB1r/EnJYM7SXlNgKSaQ5YFQm60hHignDAvAlcqvI81ft8N5peVSh1Odtu8MqWG
	ptac+/4C6YLsYpEA8foAvRKGCl4SsJD4mDyFa45Oth3Mtw0+S1d86LislwrlnkkGZMABrF6OZTB
	BGH4XjtVMqKRF94EBo=
X-Google-Smtp-Source: AGHT+IEuZCNOuhgw71RPHODJCaUVdzYWPbD3/yFfpzIGoCGg4ZN37cLNl53g3621ReprRkmpK3fxKWmw69qSmb5zAxc=
X-Received: by 2002:a05:6902:420a:b0:e96:cb0a:de1e with SMTP id
 3f1490d57ef6-ea3d9a52b30mr2169012276.24.1757684092934; Fri, 12 Sep 2025
 06:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-1-5c319c696a7d@oss.qualcomm.com> <aMP+cdmPkej+lPtN@hu-mchunara-hyd.qualcomm.com>
In-Reply-To: <aMP+cdmPkej+lPtN@hu-mchunara-hyd.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:17 +0200
X-Gm-Features: AS18NWClkCqcmoRAoe-mTGNfJBFQQqeUo2elvNw9ONlW9bzSgs8qRR9fnA2vWEI
Message-ID: <CAPDyKFoZEWyysS+WT=JBY388kFgKUeUL5hxm1wL1pmn+NUAEhA@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans compatible
To: Monish Chunara <quic_mchunara@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com, 
	Wasim Nazir <wasim.nazir@oss.qualcomm.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 13:05, Monish Chunara <quic_mchunara@quicinc.com> wrote:
>
> On Mon, Sep 08, 2025 at 01:49:51PM +0530, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> >
> > Add the MSM SDHCI compatible name to support both eMMC and SD card for
> > Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
> > compatible string matches existing Lemans-compatible formats without
> > introducing a new naming convention.
> >
> > The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
> > document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> >
> > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Hi Ulf,
>
> Could you please pick the binding (this patch) through your tree, so that the DT
> Maintainer can pick up the remaining dts changes through the qcom tree?

Sure, I usually do that, but sorry for the delay!

Applied for next, thanks!

Kind regards
Uffe


>
> Regards,
> Monish
>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > index 22d1f50c3fd1..594bd174ff21 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > @@ -48,6 +48,7 @@ properties:
> >                - qcom,qcs615-sdhci
> >                - qcom,qcs8300-sdhci
> >                - qcom,qdu1000-sdhci
> > +              - qcom,sa8775p-sdhci
> >                - qcom,sar2130p-sdhci
> >                - qcom,sc7180-sdhci
> >                - qcom,sc7280-sdhci
> >
> > --
> > 2.51.0
> >

