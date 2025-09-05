Return-Path: <netdev+bounces-220224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642AB44CA7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA673B24B7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAFD258ED7;
	Fri,  5 Sep 2025 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pa0nujBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED707CA5A
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045639; cv=none; b=sShLQdZnP85fv17WpVxREd5F9pOkytrQUXBo14dKkX1ptKOtGtuxOBsUAiM+Yrwm6EnJ9/P9Aujr8Ef5iwfXRjAf+Mgpmo2x/4XWqYrm712YUIhCVUiXI6F682XM+OOoWHivyLSSeG9j8c45lx7RKcEH0HqZt/7e6U5hZQHSbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045639; c=relaxed/simple;
	bh=0fYRl15KIX0WePQH2MFQdJgEu6wtt4B+4sM9XqpEHp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xxm+hEaDZ1Gx5UO8FQ6F5hUttHte8xHWlYlHUnJ31/+CLazwrO/A83PcPuvl8EQdyBKdzRjTMZ1Q5w4ckyCH76+515TGSVM/fQWM9MnNYiQr+dx/v3UDGMoO98iR8MToTk14Ct4YLJBianvCh/6QrBqiiJA3AiVOrXNmI3cH+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pa0nujBX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-336af6356a5so13788421fa.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757045636; x=1757650436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fYRl15KIX0WePQH2MFQdJgEu6wtt4B+4sM9XqpEHp0=;
        b=Pa0nujBXCifPQc3nIHCWUFY3HJpuGZw9+3DSEDyNLt7E6+n5KjdX3pLQI4hxrfHixA
         lln7Gh9oqN7xgSaWqTJLqCrnDbX+b4f3yCy2mKf4+mVZpEWnmJDLz+JPP7kITlHBT7yq
         VJlYjFM2/38gZsSnil4Vi96SpNsC2vB8Legb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757045636; x=1757650436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fYRl15KIX0WePQH2MFQdJgEu6wtt4B+4sM9XqpEHp0=;
        b=MXfXZzF1QqpGjnaY3jbU9CapCTK7VC2IlXprvXTt999THnrtJ69twIUxCC57i3tPQJ
         uZ+WBh+lfv5U49s8eduyZcPTj9QqF+3/X1Qhc3OSvT5upioDW12Nlm2YIW5aiQXbXIJI
         xmfFMIwJdJeyRhp1zEfIQqM8Gz67E/7HVJqlzh9JIdbI5twSxq3wT4z2IMYl/4iK/wS6
         9q4OFpX8vlrPovG49JTTr4QC0vjWBuF4Sx9SNaybPL2TSHgg8pRcFK16KMzodSfI1suj
         DOl+o+wAS4/NdFAA1EnUrE1RUQHm37wEQvcnPhUxb/DjMK1viOKBj4mHPgme8XCug2mK
         xXOw==
X-Forwarded-Encrypted: i=1; AJvYcCWJU2vrBbvlldyJ7irelyByHnrlZAGJAcJLnTY9SPNoinZn9VZHHElWD39nZltSPppfO3dCfmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFSEOye0xxuz28yCdyC0ZU3GpqVCJm/lkOM+ymzKnlbEt1lfD
	ORbRktxJ+zfLndWIE9mkwbkPQPiCsMgh0MGcTU8aawCBWZ69ss789A34WbgXExHSWL+JHZaTG04
	PcyLvpVoD8BFrelCvqZsQHUVv+FAb3SQQ6bgOxFFl
X-Gm-Gg: ASbGncvlLpGI8l+1ntenb3xCopkIbg3b7HJ5aVBwbzIJU2vY0lCUIaegA65tveqAQvr
	nzZs+9O/8KOWWZDhA0gi8oCywwzXJ86xrlDF5pMxpsx7tSaGYF+pro3R77PS4xu9xV1CFlFvZIT
	oRufWjIyBy6QPyXlKKegiTfl4OaBwG3RcytHwjddoe21z2e2ql3kV3aDeI+YLz/qETHSo7WfNIM
	lHO6YjNFVCTjY4iLgSvDcPPKfWwqgzU5hn8ULeMQ37+4K4C
X-Google-Smtp-Source: AGHT+IEa0TMIVMFiRNiOTeyQqmllYD/2S0wrm6EQ9v6TWvwu76YIEfNVYAC1dteqcnsTmIHsn61yA6m1gNmuAQeVk3M=
X-Received: by 2002:a05:651c:2129:b0:336:51d4:16b3 with SMTP id
 38308e7fff4ca-336caa4a818mr59122681fa.10.1757045636072; Thu, 04 Sep 2025
 21:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-7-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-7-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 12:13:44 +0800
X-Gm-Features: Ac12FXztQWtNoog-vK5ygrU2ksjNm_shuXo3XvVwDmyxsQtnU3LNJR6VMH81zew
Message-ID: <CAGXv+5HjikmVaK_++METYBvTciQt1OTm77TU_e4Zh52MpCZ8bw@mail.gmail.com>
Subject: Re: [PATCH v5 06/27] clk: mediatek: clk-gate: Refactor
 mtk_clk_register_gate to use mtk_gate struct
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196 uses a HW voter for gate enable/disable control, with
> set/clr/sta registers located in a separate regmap. Refactor
> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
> it in struct mtk_clk_gate. This allows reuse of the static gate data
> (including HW voter register offsets) without adding extra function
> arguments, and removes redundant duplication in the runtime data struct.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

