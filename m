Return-Path: <netdev+bounces-235207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0FDC2D735
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF25E4F5F50
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704B3164B7;
	Mon,  3 Nov 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vBSwVUBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60031AF1F
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190365; cv=none; b=Q+4ENnqd7gwC0q5/4RCW7mXCsN2o2jlwLrT4g63KbrcGjaHXeyHZ7GXVsw1Xvj64yYAiOm8furhylWAcJAm0Q1NkoV39Ihb+vxQ+QjbXXMd1dWPQQ4r9mTTKojyEU0WKgrcDmPhMEQEi/XsMDyB8Yvw3BJyM3FoGUFiveGHuzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190365; c=relaxed/simple;
	bh=ykkLoYOuaWcFu4WGWepMaxMO5r32F9euxnEAAxSaMU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2+3ASv89vZKCWjc0m3KOUtbBTWkO0MxvMjCVDXdxafEqP4+BgPUWypmpfsYZanJZ/z854copTV/m8gUW2zVwGUJTxgF76gAkzvuk0WLQd8+XK/gb3TCaCpmfVAihY4de+dpLK+Ay+6DpfuvQz1EK+cSrjCm08E2QEkFMEndqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vBSwVUBq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36295d53a10so40019841fa.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762190350; x=1762795150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfJm/0K/IK+TFySYahec6wkbZ/mH3F/d8fqO8oHuTx0=;
        b=vBSwVUBqaj0jOXEmNQ0HLYU0QSnjBNQm0dhjCCBCjxQmjZHe1uSqjI0w47BNU/yfhC
         CvCXrpYUtIwH9dX+/Xd6dMjtLabtr5eXvwh9mKhF4Vw+ozoKogSheImJ/t+VPtzsewo7
         NF2y/FM1x8jNahLdGR9WtVvz7FzDO4VJxOOMzcPhZ3l8HKqND3j+mPVnRcDULkdI+omo
         fQScYzLcpU0zkjJUPYCndSyIOwZ8Gn0xGLxg/XyYo9N/OhzsZpEcMOhCoLq+y/bfbvUe
         M8syK+R5nt2fjqgk11vB84LHxG3IYCZDDbtH54NfyQBHg8VeFfslF7CayMkbRYXSwQfF
         jQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190350; x=1762795150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfJm/0K/IK+TFySYahec6wkbZ/mH3F/d8fqO8oHuTx0=;
        b=clXfxMOzpYpzeB7yzBY0XTBErTHdrkkF2BcFx7yYVXwOw49v6emiLe8xMeSNWeVWUc
         nVpV4FdM2OPJEqUJe2dp5ipLVI1r7w+DbF0D9cT5ZnKGi1DXbcQXl5Dshd9obzGVO8Wf
         KmLxMOHTwmSxyOfNfLMdkkl5wp4RPNTFeHRWMjJEOrDt+/YOp55IhyNpD95enEUlozpi
         BVj+sEDan/wegvge092x0FEJID9+bfqGmUTDzRmBUolZnP7I+ZFrEwStPPa0jNnLgNN/
         JsWE4OB+1d7ktkueLW+iOStAmiDYsXtGVN/p2KgA7+wSIayxl5aIkn3lxczaUz/otoaW
         Ab8w==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ddh5FySuyrjl70LhoT8vrRlAsI/oYJlOKksUCH9IMCXZackg2TWjHP2e46jqBc3PxSRwC0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeuMr8xmCTNDWsUy67/f4Cj7GuvFIYAvWbYdfoaxryXkUrrqlg
	th6PHupdGOJTQGv4u0doiQ+iJQhC4Ri69g5i6CEwoYuBpbT/OMEe/lUQ/T7q8Baah66UfE3ZdNL
	7MwGazHZfJqoSXoLsa7xGqWtRcmM5VwoWjR19mKO1xg==
X-Gm-Gg: ASbGncuPFK070OZG2+fsIe/KAuiHso+HrzLd8oHs3pCgdofsYi2wdkEcmmJj7u7fQ+6
	5SG7nH7OaGD7AJ2oJ3pFvPPojJQGOQHy07o7hV6H8gZaazqG5YYodLiEda6apsyeN+AQAZFFzZW
	mghQdA9kL12PecWPgcLcrRfVSqHkgq8+S5tOjyZhYdbBFJRgvis/hv4Kn6y40tJNkFPpEk78Qwy
	Q4w4PzN/loXBiGQhWWHxNkd7Wq99evzOp0CDzyyShVN4gRNv5GeQ65XVYOvyYEbqkH/pKpovUTh
	MMZx7UG42x2dLdREfndtThIwLr8=
X-Google-Smtp-Source: AGHT+IGyFfYznWtlzK+1dscg69T3Xfj2HXDxx8skS1npII5281AQkb1LuDH6QTamNOOg1pxOfm3nDu+XQdPeX9ecORA=
X-Received: by 2002:a2e:a546:0:b0:37a:2c57:579b with SMTP id
 38308e7fff4ca-37a2c57588dmr22924761fa.7.1762190349831; Mon, 03 Nov 2025
 09:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
 <20251027-qcom-sa8255p-emac-v3-1-75767b9230ab@linaro.org> <20251028-wonderful-orchid-emu-25cd02@kuoka>
In-Reply-To: <20251028-wonderful-orchid-emu-25cd02@kuoka>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 18:18:58 +0100
X-Gm-Features: AWmQ_bkcWkBdzid9BUjDSUzrVzjV4d_nhcsRcb-w2ymlO8H-z-8gOwTsZnb5fIM
Message-ID: <CAMRc=Mce_1O5fRn8xCu5GRc_hFUtMgotx7ZK1EHF4xZMoWsawA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> > +
> > +  power-domains:
> > +    minItems: 3
>
> maxItems instead
>
> But the other problem is that it is conflicting with snps,dwmac.yaml
> which says max 1 is allowed. You need to fix that, along with
> restricting other users of that shared schema to maxItems: 1.
>

Just to be clear: snps,dwmac.yaml should stay as:

power-domains:
  minItems: 1
  maxItems: 3

But all bindings referencing it, except the new one, should now gain:

power-domains:
  maxItems: 1

>
> Shouldn't phys be required? How device can work sometimes without its
> phy?
>

Actually I will drop phys, the serdes PHY is managed by SCMI.

Bart

