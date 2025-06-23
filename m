Return-Path: <netdev+bounces-200272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1AAAE414C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E11883FC6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DF24DFF3;
	Mon, 23 Jun 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Wp+d/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732224DD0F;
	Mon, 23 Jun 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683407; cv=none; b=WN8xOvCACw9cNjnGw6xVsyBIOuxzumeVKqxVlpwxs2yXub+W7PMXJfgbsWZo66FpJJxJYu6/weudt0BuGtIh+iNmYtCtrJwqB8+85H1VwhsTpRRNJiG34SA09CVidgZew+fwAWCDFr3XKjK6tkb/d7aT9U6ZWoyBEOKZ/cBOYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683407; c=relaxed/simple;
	bh=7n4fuwiYJUTibWNIDCfCMV6f+zSGKadvPylADSrSODI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqVrpvGSpbha4srJ9rBlQGmQCNvzcDw0/SCjK4U6WsBlZ+XmxLFQQstdD/IGyiNh3ljVelOL8lGYpLYW0C97fNSF87ZWx6W2P/iuDdlMkn6YPCLlQnxYlYQGjx+ccG3DXW/+Rvnc/BiE4hGn1xf+T5t4MEseAFR5Clauu33DNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Wp+d/s; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54e98f73850so3591600e87.1;
        Mon, 23 Jun 2025 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750683404; x=1751288204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/PYDyDKGZYKEGjVXXHlyij22R64l8wztxMeZv4XmnE=;
        b=Q7Wp+d/sE4YVPl1V62uzQbfTm5BJkbN9IG3EyVo8oMQ2TFzvo9edQ4Wg9vAHUD2o0o
         ikip2CydU0wkQNwKI1UHjn5kGZWK9I65MALDWkCnLRvDRiG+4/LcRNVi+3yXWRoxzgg2
         s6Np22jYOzXM5b7zqer9o1xHebXyV2mrbowX78bQSYHpG/D975bSMngMjXURGNdlZn/g
         BjkRp3GWjCSEw8zsAA+7QzupsicmhZxZDci79VYJ0ZJW0c1VmsUqjZmET9F7aVbcV9uA
         ENNiohvOgckeyJzInKkATZPCx5jnOt7+oHpUg9437RLag313cAxUc6xs5OFWowpCQlC2
         P9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750683404; x=1751288204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/PYDyDKGZYKEGjVXXHlyij22R64l8wztxMeZv4XmnE=;
        b=Ow8tDL2yeEdeNfYEe3C3lWz87uVHq490c/2C7RG5rW9ks2FM8zo7EysMGF+XJjEZ1/
         fqpFMoP2mQEMoos+sTWhUFsn8HpBY8Z6X2KwRfzXFk2mGx4h+Fx1cN4vu40uMnf5caaE
         12owkSicceQutx1qJNvN6c88MKZpiwFQwYatyaHOlaJ2fH4si7khDSkay+HEAqMHniEc
         lzBKZS4o8i2i28lO4q7Xxb3sw9Buh50EoLp/qpxZyDUi0MaMSNkgNmWp4cEEh/nI9pC7
         f3corirLMnw1BzVH5eCTTQxbpQnYOywnPUmWU1OUY7AsLv04xrjBMHVIUrpIxSrbttWx
         3wPw==
X-Forwarded-Encrypted: i=1; AJvYcCVIm+UrywZpowmE0ot1tzfm2LMNBpbNx2uE+b0cpNlY9iThqGOf+NCmN/QFnefbNdxPxU5EJq7DmZkP@vger.kernel.org, AJvYcCWBoghLT+Z8ZbPLlt/Kf/DQAJAfoGHvFw9oycTDKi19SEQuZCWkiU4ryCTLpmUSxX1cWlWG0WCyZFpLg+iL@vger.kernel.org, AJvYcCXfAzLgE8Ly6VytGEDSJ3bf9EL82a11JPHXevpgJkMXDPXyUAUwDsxQ/wI3YovT04jy26Zk5IMF@vger.kernel.org
X-Gm-Message-State: AOJu0YycCCjPHFbRTeHrNeGvcN884BqEEqPdU8XI9ZHpDtc5Ng+uW9/P
	I27HMzgXmQYU+yzfPYoU4fjDtNTtjmGbY6oiVzM6O0hZTdGbOwvJMlR/m98xR6PQ2g5m9OQL27O
	VS9dUpimfFkqiT/hFz4iEqd6ydg+PhqY=
X-Gm-Gg: ASbGnctNd0sh9hxxT+/b+j+ViSP7OCwgyXmWWJQuvOPQBh66POh1OPXm3Tdup1ITr6W
	nX0rL21cQGCeezra2YnTa3W2rG9xx/k5MZcXj7G7oppg3Gw6St3Zp+3hyYkrF2ZKMPZtdeS4dnx
	OlIgSgjzA3BPP+yUUeQeNSR8/Is7pgM+b7PQIwdeZwSG7E6flMLV58WZkZiNF/L1039oszvI2Dg
	dM=
X-Google-Smtp-Source: AGHT+IHVX0GlIPq3TBaQtLm46YetyZZ0s+N9/Y4hGKlfh5oMqO78Ds4mOXk6wiprWLKaWnye4Cex5x6r2Jq+usWNPy8=
X-Received: by 2002:a05:6512:159d:b0:553:ceed:c85f with SMTP id
 2adb3069b0e04-553e3bb4cbbmr3113374e87.21.1750683403609; Mon, 23 Jun 2025
 05:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623095732.2139853-1-joy.zou@nxp.com> <20250623095732.2139853-9-joy.zou@nxp.com>
In-Reply-To: <20250623095732.2139853-9-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Jun 2025 09:56:31 -0300
X-Gm-Features: AX0GCFuGOUHw2mx0QPMnuqMm-hZkSD1S0Ck80ClMf9fqxc9r2EVikPukaYObI_I
Message-ID: <CAOMZO5AzU03qEg80vhyU=CrgVgYt+rn=WQ7SphtADxOc5eG5tQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] pmdomain: imx93-blk-ctrl: mask DSI and PXP PD
 domain register on i.MX91
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, catalin.marinas@arm.com, 
	will@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	ulf.hansson@linaro.org, richardcochran@gmail.com, kernel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-pm@vger.kernel.or, 
	frank.li@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, aisheng.dong@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 7:00=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:

> +static const struct imx93_blk_ctrl_data imx91_media_blk_ctl_dev_data =3D=
 {
> +       .domains =3D imx93_media_blk_ctl_domain_data,
> +       .skip_mask =3D BIT(IMX93_MEDIABLK_PD_MIPI_DSI) | BIT(IMX93_MEDIAB=
LK_PD_PXP),
> +       .num_domains =3D ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
> +       .clk_names =3D (const char *[]){ "axi", "apb", "nic", },
> +       .num_clks =3D 3,

Instead of hardcoding the number of clocks, what about using
ARRAY_SIZE() instead?

Like it was done here:

https://lore.kernel.org/linux-arm-kernel/20250619062108.2016511-1-xiaolei.w=
ang@windriver.com/

