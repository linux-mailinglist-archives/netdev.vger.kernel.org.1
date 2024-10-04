Return-Path: <netdev+bounces-132057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D164A99044D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DD51F21CB1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BB210188;
	Fri,  4 Oct 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHF1MGNE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A55149DF4;
	Fri,  4 Oct 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048451; cv=none; b=Q/XLr5BWjzEFvhe0KAkOJZh7KcWOEuTZJJ/PbY0IsgZZIDnzHDr+PbzRmqDLBbbfehZopAOf2bKh/gMeXyfC+ztzDxZFDRXPZ3YInV/rutO9ttkTTAYwysPaLaqlHhhPTAXgxa/3vfmjmlSlR/p2z63WX33GKi4sG1tMhDqYbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048451; c=relaxed/simple;
	bh=a93hVSkItuu3hCe0uBJSZlAAwH2LqSJVgJljySUsJm0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=hTfrWNDCe1yJLX2/UsabU9YfH3DpCtvoOHJync3zuXbuFCAzMJW0NkyX0c8+mtyTcfHXDvfnXp0A4HEzNQ0INd2QnLuc6KchjsUXMPfOE4xScUCj0Rct7qkQIPUwtx3EPQlHt2XL3H5kaeIknM8paN7ckcNJF4H4gVRr2klkXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHF1MGNE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso18431355e9.1;
        Fri, 04 Oct 2024 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728048448; x=1728653248; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22cBRwE57Xw0sioNBB/NhLn4DPgBWGUrQGpJqtIVHq0=;
        b=EHF1MGNEizcZ1/XVgly+zR8gvTHJpnwPYL9/97TgrWzvL+07D50gLHKbxQY1aYh5V3
         WEOUAXXcVgoDfcWKOYJCrwYYwF+FJ6viFRyq1wZolJjXLKjErtRTyCoOHo7vjJRvF306
         NohzWoesjZ/934aBgM0+h5EySNYjFf8zrrgYO0f8wwAeOEbzOQrSoOlhY0l1/0v8qHz6
         jx1+QnGoe2J8dH2gvCVCjwbeeukiOUdy2fcVSwITCCGoY2WjMH2JwlwJSEZF4mQUvNjy
         qFaS9AScbvrQMjntfplNoKpxB3D49xqaABiK6HIvDRqK4ro0MFQTg6O8SjGdeu7TDpW9
         S2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728048448; x=1728653248;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22cBRwE57Xw0sioNBB/NhLn4DPgBWGUrQGpJqtIVHq0=;
        b=RNo8V5pKGEuKCVlpo5Rii5temWPieXxTloWtAhNwRwwrKnPgzrotgkXW6a6JaWe3+a
         A84tY0uX+5nT8tq4CXRtRF6VboKZFsQoAdldLklV/aYl6zOBWWHnsJCQJkQy7kudyBaV
         9AxKYoQ/bOmVseAFwcZW0xHEAl22KeHikjf5cW2o0LpVdrw0vWNQObZqqV5aS7ZbZB7I
         hRbTMgAvVeHzYXpUJ22Krm1ibELffG49b4R8RKm5M6PLy3oF0JEBGzuPJ/dDdEyVuLkI
         elKq+kP1rPZ4D9vrpEZVitwwFTjS6UBTDX3xpY6sPN3As/ktvsJI+xRrtisY8H4ZgdSq
         fbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmhvoYKebDfU3OPCqt+13bgmbXfeRhc2JKsCMFG3LVrKoMrDkNe+zUXu5XGDa9BwI79vXkSoJ7@vger.kernel.org, AJvYcCUu6C9vpPrV6XuVvFbXu5i4J36Ztej7Gbag21bIbGXxm3ARwjW6VBjxh3zpoZhgTntjubC4xrDaHkc=@vger.kernel.org, AJvYcCXLzNNrrjDbtGKdDsWLz0gvw1Bw4u9civeQCPhEwPrQrW0rSYIuCwSnpd/EAqflEgCsqQD27R66i6a5HuAh@vger.kernel.org
X-Gm-Message-State: AOJu0YywBDHCTE6yxFFWpUq/ADrwXsnBPnCsboQ+X9dxmRI72D5Rfsd2
	tjBX0ftyueNx9u1xd8ZEYDjCrk1CKQZs35b877Jz6u95ELbQI7OD
X-Google-Smtp-Source: AGHT+IH3yRfRGBBOHC0hZKS9HHSTVHJgXqCz4P71fKXwCQTPx3XtSJMJI4pbwzjjO5SWKJWuVhC+aw==
X-Received: by 2002:a05:600c:3507:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42f85ac1ff6mr20186185e9.19.1728048448049;
        Fri, 04 Oct 2024 06:27:28 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:395e:c10e:1999:d9f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d07fde1fesm3303168f8f.0.2024.10.04.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:27:27 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  linux-doc@vger.kernel.org,  Kyle Swenson <kyle.swenson@est.tech>,  Dent
 Project <dentproject@linuxfoundation.org>,  kernel@pengutronix.de
Subject: Re: [PATCH net-next 07/12] netlink: specs: Expand the PSE netlink
 command with C33 prio attributes
In-Reply-To: <20241002-feature_poe_port_prio-v1-7-787054f74ed5@bootlin.com>
	(Kory Maincent's message of "Wed, 02 Oct 2024 18:28:03 +0200")
Date: Fri, 04 Oct 2024 11:44:47 +0100
Message-ID: <m2r08wf8ps.fsf@gmail.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-7-787054f74ed5@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
> Expand the c33 PSE attributes with priority and priority max to be able to
> set and get the PSE Power Interface priority.
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
>              --json '{"header":{"dev-name":"eth1"}}'
> {'c33-pse-actual-pw': 1700,
>  'c33-pse-admin-state': 3,
>  'c33-pse-avail-pw-limit': 97500,
>  'c33-pse-prio': 2,
>  'c33-pse-prio-max': 2,
>  'c33-pse-pw-class': 4,
>  'c33-pse-pw-d-status': 4,
>  'c33-pse-pw-limit-ranges': [{'max': 18100, 'min': 15000},
>                              {'max': 38000, 'min': 30000},
>                              {'max': 65000, 'min': 60000},
>                              {'max': 97500, 'min': 90000}],
>  'header': {'dev-index': 5, 'dev-name': 'eth1'}}
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set
>              --json '{"header":{"dev-name":"eth1"},
>                       "c33-pse-prio":1}'
> None
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

