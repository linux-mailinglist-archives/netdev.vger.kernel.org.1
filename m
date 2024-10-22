Return-Path: <netdev+bounces-137864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6149AA256
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D1CB2112B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5D19D89E;
	Tue, 22 Oct 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHEBE9hE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801D19D880
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600979; cv=none; b=p3fmN8jsW+AM4svaa1Jmfci8vQkuznLtYOH/xFt5CmpfzDU1aFmUQqdKHHZ1DWvScwKGp+juw/dsYKtYI3vCDnGmJj0hYFK6kKb7QzEhhTAiE+hFVwi+2vSwj1n0vwJWJEIDL5sAk0eeo2BYcbdGKXRKR/M2dHdu39hZcx0rp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600979; c=relaxed/simple;
	bh=ARtJ6kvqIGcFruTXV6okIoHVDlTbGuGMZPlyUCFrYwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITsxZIC5bfQkNuZMYFFLArM/mPDD05QNcoLznSOCyyl/bjxvK+5Qrw0A+pyQTmTfZOiRxvltaTMQNH7dz5DoUY6XzUdsrBqF3q0H7RQrTzZ0LL5RoaKuMvLQHTQ8eOXRjCgTnL2j97oZULyWL1KTCslT4xZmLTKb/FrPfOJVC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BHEBE9hE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so60965581fa.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729600976; x=1730205776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARtJ6kvqIGcFruTXV6okIoHVDlTbGuGMZPlyUCFrYwk=;
        b=BHEBE9hEaqC6baMwuNBt5nYatLvADUvDXL9ZHcL3GcqprjCwLoe0MFvdQcYnOaIuf8
         bfg6q4TtTS+CyqfLkgH48tpq2TIs/7MzjtrgbqH3rRpDWDKEmBU84+eBgEFJ/J4HZxoP
         GolojXA9o5l91ZNCM3vBKGu0ktjcuJR/YZhFuypxwSfxzTn11jqmhmJffniOx6kxDQFt
         wC5JSF7zpKfIBJC6REu9MoPfu6Z7br0oVn3MU4yaKitIUTVQXY/iaq1bpQg08t+oFqVP
         pggl4lPEXz9hwyY4qgEQFinI6Bhf57bYwkGT8U8UcXJUO/oghEyMrbRphcd3xA0mjp/8
         6/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600976; x=1730205776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARtJ6kvqIGcFruTXV6okIoHVDlTbGuGMZPlyUCFrYwk=;
        b=ZdW+3JB4/fCnJzyrDXmzugVbrFObIPRp0CAH0iqVF1OGMLfYjiqvPKk7BMKC37dwXN
         N52QzJ1MZlZknVFPXTMCXZ+Py8V3OSz50N6Z0ihsKve6+ZOoAaPWGrhZlpqSJdjCBjmn
         0xtEA9i/RVwsMgdH8Wf1GUySykJyEQP2ycqx0rPeScOkkeMCmXI6X+AQkDwNpnwKLtfx
         tlnBNX/jx9KKynKOZJPICPQxYhwgAWB0Jx60qyg8orZNTE3zqGrMR0lwjRmIYpaUp5O4
         IcNQVhYQ0iFXxve9POrmjP7KF0rwHdrd8vPREj/QE+/LmDgSnxSpKGuMCEWqs9AltJVn
         GJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZPt9QWTlt5pOFdI6Ui3yU40vplxDnKrkos/RN76+FL8TBg++L0NivKCNtJF+HaEgwDLtrFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1n6wYMJfvIa9WkgwuF+fF29eNyVvlv4A2Ih/d8gnkR8JjxBkI
	is/LnnpphEfMX7sfaaCc5zpnBv8qysz0bpXLaCz9wlU3MUmWPIe3peMQ9jMa+GuB7GS7XqU3MJf
	bXKqxvp2Kiy3cvdD+4VYgGjjfpo2tBKwHhFdwy8nH2kfkEVGL
X-Google-Smtp-Source: AGHT+IEBcVfZ3JWaOM04XJNSL54UsLyONVoNwTnqh64hkWL8NFdGQD13XXBI25QnSA6vmIj5FcVBmPLEvaztSgYOWOI=
X-Received: by 2002:a05:6512:2393:b0:539:f65b:401 with SMTP id
 2adb3069b0e04-53a154a2413mr6984977e87.57.1729600975700; Tue, 22 Oct 2024
 05:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018-qcs8300_tlmm-v3-0-8b8d3957cf1a@quicinc.com>
In-Reply-To: <20241018-qcs8300_tlmm-v3-0-8b8d3957cf1a@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Oct 2024 14:42:43 +0200
Message-ID: <CACRpkdYY=qLocvD_c-1TkJep3QMAOOWkmAYanvDzhyBgsC0RYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: qcom: Introduce Pinctrl for QCS8300
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, quic_tengfan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:20=E2=80=AFAM Jingyi Wang <quic_jingyw@quicinc.co=
m> wrote:

> Introduce Top Level Mode Multiplexer dt-binding and driver for Qualcomm
> QCS8300 SoC.
>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>

ACKs on bindings, up to v3 and no maintainer comments, driver
looks fairly standard. Patches applied!

Yours,
Linus Walleij

