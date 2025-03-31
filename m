Return-Path: <netdev+bounces-178381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8CA76CC7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FE118881B4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CB215073;
	Mon, 31 Mar 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls2OIPgX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92379C0;
	Mon, 31 Mar 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743444853; cv=none; b=qlk4+XYnIOCzopEy6wlJ4+6APIZJOxW39Q/sreWCgagh+N1VnGQQ6JFrIBryRo4zbrs494/MaKZdoz6vn0uVuvqZ5aF49dgT/FiTI61kC23XXyIHGsgWR9HigN/XhbMVYtYF6TVtYLXbYz4o6zv3ZwXh/5VtjV9pkvxh4zm7Oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743444853; c=relaxed/simple;
	bh=R8z5shiXlAJJhQoIwb83l7c8bOKbIxipiJo6viYBdqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRIH4Y2ZBMRGSOV5PbKTwVuVMIyanCFwl6yit/pwyWoCU8QXY6wETznqP9hPAMVlBkf0xkXhhu+MK7oBHxRbVillj9E2I9g700UM7UcN3MMjU+0E8O+D7FWW1Zhrzkqz3IPVVPqX+Q37Td044nVP/q85Hxt4jLt873EgHLdFUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls2OIPgX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so5609029e87.1;
        Mon, 31 Mar 2025 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743444850; x=1744049650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5lk9jhdHxqhJGM2EvAiNOOlsC8BNa3794LCUzwdQio=;
        b=ls2OIPgXn2RFRLP1kEL6ExuMpIxpuFcETQZqyb+tF+T9e0qWebl2vqbCJoftRKgkUG
         ybV3ogJI+Nq8xK56IWFDgFaZujrKblETiUPj3QxQbyG+0bbg49dtYpWLYOAU2dhTXXic
         pCt4ksMUL/kR6OMBAW/bvYw1Usg2/wnqBoGhAM1hirYpqgR1zyYurDfRaq8ttnEHmfUg
         llPkbtPW5tvqVRr6VN0Zd4gcctL1k+Z/KEhzMzVCLFeob6Pg6+kNmP/GGmPL2hVQMDs/
         kgb/XqQYlnu83nPCDxAYnbtA853M8VQEmCeP5Hxo/kWxhaUOUjO6YbyA2xDS5xAkBT9L
         R9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743444850; x=1744049650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5lk9jhdHxqhJGM2EvAiNOOlsC8BNa3794LCUzwdQio=;
        b=OF5KZKYatiN0wp8xvZKIu4zN9QJcJVhofbya/IZJYGH9FvNAmS0nMLmyZIyxixHhXj
         662NwitwANbvPbXQBKVrw6KYHMeqMEguL4PEczF2+jdqNx6NLu0D/+dlJ+DUJ+xI3GvV
         cTYEu9Qvet6tYr57B1AFrcivRCPWRz4ljWXJvSCahx9M5TKxQGA2LGh4hRu3mU0H4d7o
         7uyHkbHQTT+1kfAHis9W1FTXzyubUwUG/lIHW9tUOX0Rdy/Uh5u7cN6rdBYZ87HT8dXW
         VbIj4tdoeFgFavt8UA5bEr85xdqCHvKJyvKxNDZjktE0T1xPl6AFPoErZhoSvoPo/MbB
         BKQg==
X-Forwarded-Encrypted: i=1; AJvYcCUvputytTjGzeePvfj+oQbPl1wEPNeiK7yOOXLgSBmE/nmqGCf9vz6O65vJnwKQ0P1S76cub3UCMoaxs5e4@vger.kernel.org, AJvYcCWbznTdTfzwdp/I0HGvr7AfI5DpJfka+WXtDrJ5akK/Q9KkjecEKsbr+QGHJeccjwoK09Gxz87a@vger.kernel.org, AJvYcCXRUjetb0doaDy7xTlDWoFCAw6fQfl22Ewd7JTPBRmrhSiv5wMEQbgcbJ1XMTOOzOeNySgRPdxLkRGW@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJ7V+6HR9gW93F1bV7eaynIdZl7wbnLHccC1PMB7AA5Iiq+a6
	/UQVvnLaOeP6pMhR5vBcaEaBiZMCfEfulChdIAkkv4UUEX/L0B36wux4YgpQBQTXILaXdoa7zfy
	ghSYQsWx3nm8ks/qMWXVC5jt+fvQ=
X-Gm-Gg: ASbGncvL1AM5RLyNvvPtLbBOo1dZL/zn9ZSj1Ov9kI5u4+Ed3MHXJDOkNfnmtD0ehMC
	nPcGfeztpt5DoPWwnzybRIlO6QCuRdV82X1AMd1uwrS2nT8o98sLaifpQFtJbtqkji80jYyO+Qp
	RSXBIWQcMFjGkhHqEZdwL6UI7OuBLSigiE6cX+q9oOB0lxHefM5Leown0ooV4kWKdDotNE
X-Google-Smtp-Source: AGHT+IHKzL9HwLPvv//AcrZpsGw9jXwcmKxRn4dqH2+JnEGKxalj4U2wocYAbP1m6LV80Fp1ly5wMt1Lp9f4JagIqw4=
X-Received: by 2002:a05:6512:31c3:b0:549:4a13:3a82 with SMTP id
 2adb3069b0e04-54b10dc6b6bmr2519774e87.21.1743444849596; Mon, 31 Mar 2025
 11:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331103116.2223899-1-lukma@denx.de> <20250331103116.2223899-2-lukma@denx.de>
In-Reply-To: <20250331103116.2223899-2-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 31 Mar 2025 15:13:57 -0300
X-Gm-Features: AQ5f1Jq-g5W90csHkjK9HYDezlRlK94-DydnLNjU-qHoYaOMSuEvsPfN0-r6dq4
Message-ID: <CAOMZO5A4P=JbmXRyz91e3DSFbXjG7aRxMyBaTMsfB9jpVG9tww@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add MTIP L2 switch description
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Mar 31, 2025 at 7:31=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +properties:
> +  compatible:
> +    const: nxp,imx287-mtip-switch

For consistency, please use "nxp,imx28-mtip-switch" instead.

imx287 is not used anywhere in the kernel.

