Return-Path: <netdev+bounces-154141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894409FB996
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 06:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36AF188413A
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51314D43D;
	Tue, 24 Dec 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEEbtGqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247C219FF
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735019628; cv=none; b=EgNCeOd5tMxaoNXBNaPgFznuN6/mTzSJBn5LV88V3rRVeDdMhdFFM7Wtly1n1PUphhyEN7HSIaJRLgDpAgeraa8iE0hr0KyZTH+rJ3a6RUnrKi3B6jkgAzsMnDtmRhnNz873HSTEj9zHG0fgeSpBuKMEY4FVg0TPd529Pu5zmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735019628; c=relaxed/simple;
	bh=UIATde0aTuNB4jSMwXvaSPPg0IMRtXYb9IfEiQhla60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo6jmIfd9APu5uVAbC7aRjVuAU6Nc/n6XfAuJX8Tb0Pa1gKE54ZOrO0nh/kUh6VaOd2DI2vLyH5zZ7vxegyAe1eDF1i1dsg5xCANDIf/6CzyiBR6gi6FAiSSF38i8+EirIztbVloOIrpFUH1CLqNbnFhbzgk9Yty1hnjhVOqBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEEbtGqo; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e398484b60bso3824504276.1
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735019625; x=1735624425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8k22NIhRUfREomzvEHYBMUyh3YhmCBtF7z7x287Diw=;
        b=eEEbtGqolWqsEdR0FklP9LzGo0vMkS6HTRexJ6rLNcNnCjJBx0rTEeAB5iyxY/TzYp
         n9OJxhxywqmvGhX9hUQ+sNPzdId/SHXWYe5vgsT/vmhfhBtLxqjZOFbrDn+BLmFhG+KU
         cLpD2z4fgLskXLpDl5xqGLMLFEtkntKGw3imdGbGmZwr1IqrF+oEOG2jVdkbbx5IFEdb
         Y8E7j4C2QQZriZEny6zarcDOcwseoy9k9ZBGb14I3vCEpn/2W39i4XNBLEH4Ll/fFDcp
         rJJJGKKWk1l08p3aCpg/fVd9108T77dLURXvdwJ7tsyKKhwlCMSezi7aALIYzQNiVahz
         sE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735019625; x=1735624425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8k22NIhRUfREomzvEHYBMUyh3YhmCBtF7z7x287Diw=;
        b=RzemwSnktKgkWv198Gv5ShgBZHD6or1rFDX6vNR7GGKpL23/FB7GOW4g031AVuc8U0
         l2CkL7OPKwHjo7lBJF5sXplyouZvryZ3E+s051LgtZZ0B2r4tRFQRTFZuW2cEc1/jymc
         j7ODv/F9iHDUpF984tckwVxe7oRs2BI75NzLZvqkhG5uIDGV6Zqq8UH9ZFCj8T7bFS0d
         If/qjMlsbt9PopMrAUX9uCGpXZ7F0sQ5xlDgVfU92qDJxHWwNA/9Ov0wH9aqjbLZFtQ4
         S+cCIlvDT1xCKSiRLKkTUTeGuIsiyPn+zh7mm5cmqumc3IAp6nqOTdw/uiHK+NH4EOz6
         8snQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvwtYe/5jLSkXRdOa7F96AQif9W2lkjWyIJDn8YcRszRGOyQMOhOTCGDcrXiDHrOZffZyHfPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqV6IJa4DCQYnpICoSMETzPrhCq1H8snXO7+Qn7nPqFIpdfC/g
	w35hD0VvmK2n+czXQufC3+fsniqiRvb5S9XgjPClO2ysKFtvw4CHcXlc6nGE8IBkpDIsa8UdyB6
	vJOIjkaGwxpzh/HA4vM8TnasFkR4b5ISQcPp6IA==
X-Gm-Gg: ASbGnctLgbzZJoIoY0YMJehHgLKnLolqYDI88lclXMk4HB6Zr878YY13hDXvKyNkD9A
	lndGCqsZpt7ZNZvMNy8TzIxIx6b9r6j0ZoKf902rzqoXV7MUnA0mo
X-Google-Smtp-Source: AGHT+IHZNTB32SM9lZHV7jMuubh0s3yOGJoM9z09zuPN2nLMSX1RRST3+VUlZjXDWOXCRHlJ3OmlP+RWk9nmIxIonSI=
X-Received: by 2002:a05:690c:680b:b0:6ee:5cf9:f898 with SMTP id
 00721157ae682-6f3f820bb3dmr106099737b3.33.1735019625469; Mon, 23 Dec 2024
 21:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224-schema-v2-0-000ea9044c49@quicinc.com>
 <t7q7szqjd475kao2bp6lzfrgbueq3niy5lonkfvbcotz5heepi@tqdiiwalhgtg> <c57a18aa-6606-4a3a-b508-8e335fda3e31@quicinc.com>
In-Reply-To: <c57a18aa-6606-4a3a-b508-8e335fda3e31@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Dec 2024 07:53:34 +0200
Message-ID: <CAA8EJpoSUepFZgXHmozdPwWdtrjYiMa4bDsozuEr=tec1wj_Gw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add standalone ethernet MAC entries for qcs615
To: Yijie Yang <quic_yijiyang@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Dec 2024 at 07:47, Yijie Yang <quic_yijiyang@quicinc.com> wrote:
>
>
>
> On 2024-12-24 12:16, Dmitry Baryshkov wrote:
> > On Tue, Dec 24, 2024 at 11:07:00AM +0800, Yijie Yang wrote:
> >> Add separate EMAC entries for qcs615 since its core version is 2.3.1,
> >> compared to sm8150's 2.1.2.
> >>
> >> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> >> ---
> >> Changes in v2:
> >> - Update the subject for the first patch.
> >> - Link to v1: https://lore.kernel.org/r/20241118-schema-v1-0-11b7c1583c0c@quicinc.com
> >>
> >> ---
> >> Yijie Yang (3):
> >>        dt-bindings: net: qcom,ethqos: Drop fallback compatible for qcom,qcs615-ethqos
> >>        dt-bindings: net: snps,dwmac: add description for qcs615
> >>        net: stmmac: dwmac-qcom-ethqos: add support for EMAC on qcs615 platforms
> >>
> >>   Documentation/devicetree/bindings/net/qcom,ethqos.yaml  |  5 +----
> >>   Documentation/devicetree/bindings/net/snps,dwmac.yaml   |  2 ++
> >>   drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 17 +++++++++++++++++
> >>   3 files changed, 20 insertions(+), 4 deletions(-)
> >> ---
> >> base-commit: 3664e6c4f4d07fa51834cd59d94b42b7f803e79b
> >
> > Which commit is it? I can't find it in linux-next
>
> It's a tag next-20241108, titled 'Add linux-next specific files for
> 20241108'.

Nearly two months old? okay...

-- 
With best wishes
Dmitry

