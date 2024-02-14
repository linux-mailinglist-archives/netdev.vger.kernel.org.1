Return-Path: <netdev+bounces-71659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17128548AC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 12:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3055D1C22727
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105B1AAB9;
	Wed, 14 Feb 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jz85hSk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEF19BA2
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911168; cv=none; b=fpAC6T3ncnBX91Qb+xqwCsX5At+rg5NQ1xatvYB3FDgQPFvSmvEelCj5agr/9kGPuF0dymzS5GCwfNqbZWrZJ0x/ApzHfFP23jF9kKvGoQ5hz8ou97x++2POWP9xqJUzOx3CSRt2DWvMwYWF6Ju0HnaQcXlUWA5ia9FrH0jxDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911168; c=relaxed/simple;
	bh=5cBCTJmIkuZecSiGwWsCCZ+RQXy4vsGvUq70KIHkdRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpH3kx9MxdZEhN9oeZmlfRODzSkrGZ6f+E56sjtdlJg9mK1ofgnDvMJH+Yq/8eoSU/hCxR4FbSveHMYmd8L+NK/GwKwAlgue83S+0zj2vFntJH25TxZpi8P2ye5Awi0Y30MM79noncqq/wZAmt0IIudSoNOrILXAbIV8DZu0fzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jz85hSk8; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc745927098so4524873276.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707911165; x=1708515965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMm6H1+3sxiadbeuUfjignaOEewFpqqASgu/afNzhas=;
        b=Jz85hSk8sJ3tV1YSHJgKQYN3avRkFwAkYHyFkfdkR5bGnkuHFUIL3Yxipq8W7CqHN+
         hF4lv1jpqa8Z7Rr6zUFjf+/JtdP93kROVM6KhxO5LhR0KWU4ryCRA1FErAHk8OECtgNh
         /5px+6vagjYxMf4+bfnGA3/1dP8fA3+6AG/l5IazpqEu7C7jYIL3VDzdIvE2SczX2NEJ
         WbJsK7X+MIDtrFU/9ZBLJBbUEJ7aNb90nExFsjedrQk4+CDo8k8UgS9r2fDK790FeZej
         u+ZL6TvA/ogi/AkX3MMnmCqsfA6PdVSz7ZqJGHJlQXPpXeAcIWAr7YdmVBa4fss4yMmC
         kaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911165; x=1708515965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMm6H1+3sxiadbeuUfjignaOEewFpqqASgu/afNzhas=;
        b=OMGmig304a1kBKDHHWI9tuNtn4Vpyph+Q2nZkxG2ONchw0C1BhtGjT9fQy81jsnNss
         +nOFZ5UJHXgT0npnN37stKOcRb6KMwid3grky1qKMVnrh2OBBaOvSG/d4ajv3a95ln+N
         5k/fAgYV3ccN2LDuz/MizyCWDsoY2Aqaqb8Sc6DjjI+KUHBFzTPdYJkBn4Wx44UrpZhs
         5v0mwkmQBdyai0uIBnwhJJP2phrMUZjZ8C90iLRZseXVKJ5sF127S98jSQeeoV2+FwpH
         IUo2rqsaksIxBlxBv9x8ZeTq275aXpWidqqCNYjOLa0i5LOJpKIsNlb6lI3NNa3u1abb
         e4+g==
X-Forwarded-Encrypted: i=1; AJvYcCWD7FzAVqbwkMm9u+I6sXZfG4RaSKdIx2lNEnRw2+lQCuZlvi5msahM65HrkfJgWduMd6XmRdc+T/R/2NL23ftdTrY2DwUE
X-Gm-Message-State: AOJu0YzbCdCmSqm+or4Ckz+35vMO8wTWnzb7t3Jk6SYoZZkpSbZ6i4Gu
	u6K9iyasmj5C15MIpG47vJtqYnHGxP4IfWk1hQMZpD9WLSQfcCeiiZKDvsETm6ZeC+kRlczF+6c
	WTcFHjThpdWRy49ItV5MMxL8PzEiAdqMlWvqUmA==
X-Google-Smtp-Source: AGHT+IFTWaiUO0/FDR6+92ostMkJC/ZQk2A+9uMYuYsQostIt3tNe1w41GyxBHI4EGWLZGEFOqxCNQkKG0weW2iyQng=
X-Received: by 2002:a25:854d:0:b0:dcd:5e0f:19c7 with SMTP id
 f13-20020a25854d000000b00dcd5e0f19c7mr1595156ybn.54.1707911164746; Wed, 14
 Feb 2024 03:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com> <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
In-Reply-To: <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 14 Feb 2024 13:45:53 +0200
Message-ID: <CAA8EJpqO3j-BEQ9tcbH5HpskpbC7bJpEEpc5Y5ySb2B5c+WC3g@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 11:20, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 1/26/2024 1:35 AM, Andrew Lunn wrote:
> > On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
> >> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> >> enabled by default and it's RCG is properly configured by bootloader.
> >
> > Which bootloader? Mainline barebox?
>
>
> Thanks for taking time to review the patches. I couldn't get time to
> respond back, sorry for the delay.
>
> I was referring to the U-boot which is delivered as part of the QSDK. I
> will call it out explicitly in the next patch.
>
> >
> >> Some of the NSS clocks needs these clocks to be enabled. To avoid
> >> these clocks being disabled by clock framework, drop these entries
> >> from the clock table and enable it in the driver probe itself.
> >
> > If they are critical clocks, i would expect a device to reference
> > them. The CCF only disabled unused clocks in late_initcall_sync(),
> > which means all drivers should of probed and taken a reference on any
> > clocks they require.
>
>
> Some of the NSSCC clocks are enabled by bootloaders and CCF disables the
> same (because currently there are no consumers for these clocks
> available in the tree. These clocks are consumed by the Networking
> drivers which are being upstreamed). To access the NSSCC clocks,
> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk clocks
> needs to be enabled, else system is going to reboot. To prevent this, I
> enabled it in probe.
>
> However looking back, gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
> gcc_nssnoc_nsscc_clk are consumed by the networking drivers only. So is
> it okay to drop these clocks from the GCC driver and add it back once
> the actual consumer needs it? So that we don't have to enable it in probe.
>
> Please let me know your thoughts.

If there are no in-kernel consumers, there is no need to worry about
them at all, nobody is going to access corresponding hardware. If you
have out-of-tree modules, you also probably have your out-of-tree
overlays. So you can make use of these clocks in your overlay. I don't
see a point in dropping the clock if it is going to be readded later.

-- 
With best wishes
Dmitry

