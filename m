Return-Path: <netdev+bounces-208970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A50B0DD0C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3F6188D523
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327DF2EA740;
	Tue, 22 Jul 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wot0JqVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938312E4988
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193102; cv=none; b=RPG0GweLcAO/aWBCh/P9tjyOucTnSkGL+kbHQWILJJui1sTzLw5lMcv+tGV/g4ND+XaKMdsCfEig7h4H01VBh7N97Zk2dxNnZlNtyROd9ggwWFKzNUd0N+3jbAZQ/aw3WFrZGO5Cjrvz9iewyuXxjPtGYG7a12e4afYhaf3zffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193102; c=relaxed/simple;
	bh=/oJFpL/qioW8vYik6ecZfIbYZuNesfEGbgYsl9ugCps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN+61rRswOQhDSVY4twyvRFujjzyZEb7cHcbE8aq/1uhbA1M2h3rZd3Zi3Aj0q63kh5L9BAcxhKE9uaSBBss2uoPtwXTfHUvUEUx4v8zaBJH7iFxOTSMo5ALiHB6zkaj/TutDWGUFeFDyldQwJhu4dZr6QKrSaKT1LWU7VFmZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wot0JqVP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so41965121cf.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753193099; x=1753797899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oJFpL/qioW8vYik6ecZfIbYZuNesfEGbgYsl9ugCps=;
        b=Wot0JqVPEXkMSLT7AC7eeCvy7FXrJjh1TIParIHDUzTWLnxoOAOj+0zzarP1DNEmFG
         jjIxNgMnsDvTHsLM2j9eSqHPU+L/hy+wzx/KW5dUi/GIwSdc6b6ZHb85c2xmhVCGdMcr
         bN/W/wJ3Cdk47Xlwk/J6FiyFGvBFh8gpCzubAlxhuLrjL2xjBrAX4MJuhcy8C4LrCHbC
         Kt51rfa3CpeidfNsTBQmwFmEj5cjIEZXoGdKju0j17GkAlM/0JIsf1pexE6aovMK7kVL
         UeGm9Ykv9lGexGIylWxZxs7kQB9DyiYu092bSp2Kco3isQE2Wut78+Ns1jTNn5HZd1fU
         VlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193099; x=1753797899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oJFpL/qioW8vYik6ecZfIbYZuNesfEGbgYsl9ugCps=;
        b=qFH+gPB12SwoD2Pt+Ktqw1zcAQpjLUBZ2IOdTn6b/gJuA2ER/UHZe8k7Pzlu15C3Oz
         aStyXePZNk/L5AEbV5u1TuHSdIRkphZHkaJ7yL/b1vz6AujHe0+Q25zkBonKFlqx/ckE
         UCe361YsLn2pSvTHV8hKUj1z1teS+ZQFM3N1WXPZj6S5ui0D7NPAZq8T8XfGytZRi77l
         YkTHcgVfG9KMFIyjXclXj9sg/hY/M6+SHnnPcSwjYom+woqQoxWbTqVPNIX3b/8UjpJq
         BkTSsMr7PxHvNHpuWGa6qPtNfhZb16rxOs4JGjYNXkAtsfYfa4TFmMlVCVTQdT7Bwft1
         outg==
X-Gm-Message-State: AOJu0YyKYq0NemovWcp70nekaZsUlbAVCwn4jGIxuWh6FtPYbxN0APn+
	yJDbJIoPB8DOvkW1fzhxEWpjeA1L7Yb4PUWkE4lUF+hebYThGLQrh2/h+83TkwkD2EKSZcijed2
	VPB6csTDLmB7u/cfMO9Wx0Avpjn1btJm7qQAeG1TJ
X-Gm-Gg: ASbGnctX9xX2k4xCyRvLbp/g+xiy7xw+HJFnrMyzSDg0FjUGDBbvYsqDXfYbaIFl4uQ
	ClRMUk7Aj8kjZpNNOwlpjN0to07VAwTEC56FBjhQZkpedCmwhkXvpDI1vV5ayZ66y1GIgdl6KUn
	/BRxUlLIrNA9xKRjnyaaEsXst9GuzzVuir96x0CBDHFGrn6UD66JlzmaOUytQYTNOhswSPnckEN
	zhVZfKGtNkZrT6H
X-Google-Smtp-Source: AGHT+IHfWFn0yBFNphwhG6GHfW6hWSddAmiFuPrhbHTKC8yPHWBWCSlcRrgV4lNzSaqZhZd21fW1iq9s7XLPhpv1Gxw=
X-Received: by 2002:a05:622a:653:b0:4ab:af74:e0be with SMTP id
 d75a77b69052e-4abaf74e17amr253639241cf.43.1753193098809; Tue, 22 Jul 2025
 07:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716081441.93088-1-nbd@nbd.name>
In-Reply-To: <20250716081441.93088-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:04:47 -0700
X-Gm-Features: Ac12FXxqPV_GV0PovyzMNBY1n0-MH84t7kYRdSouBY061BcCtVj6nz7uduEtEVo
Message-ID: <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:14=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> Only handles packets where the pppoe header length field matches the exac=
t
> packet length. Significantly improves rx throughput.
>
> When running NAT traffic through a MediaTek MT7621 devices from a host
> behind PPPoE to a host directly connected via ethernet, the TCP throughpu=
t
> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/=
s,
> using fraglist GRO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---

Shouldn't we first add GSO support ?

Otherwise forwarding will break ?

