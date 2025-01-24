Return-Path: <netdev+bounces-160712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D50A1AECC
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C059416BFBC
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8C1D63F9;
	Fri, 24 Jan 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUw9NZyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED81D63D5;
	Fri, 24 Jan 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737686590; cv=none; b=k0YwuVI6be13Ut7pG0xq3tfLvlzFz/qe7ZaEK9yQgh45NwAjWUCSGBPKTyvfLLk5T26PYTE4tE/C2eHHrJMJ5nQC9UennjfdLoJQRCjELSnFZpIeaeDyDaVB+HiaV+pLlXlAjFB6qaTjQpuuUC0Mb7PQhZjTpLh9vBxR21/62KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737686590; c=relaxed/simple;
	bh=fI9nzUeJGaja/QPz/36HA0dJTh/JAm9DJP9AVQRXfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjB0NiaK4E6W9R7lz1mvW2jWeWI74M37YGMPK1v7nCSp+D/tXxJzZuqPE8tKapn/WkrG2dA/YJzYL/Mw4TP2D2RYlhjHcTrSaTCgBc/yxW4EpOoA7ZdmdGem/tUz7N2wHWfDErCynZW+STxMuHoo73xwEf1SmiEoHoe2elDIbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUw9NZyE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216281bc30fso38122875ad.0;
        Thu, 23 Jan 2025 18:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737686588; x=1738291388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUr8glPor4PY9LWUaf6Hy93FwZ+OFlyI/oBmRms57JE=;
        b=fUw9NZyEAXbwa3cSBUrSrcdJXU428OIYym49SzgNTh19EnqvuNKmwupRqLUddA3ouH
         /jzufpajpdjWtlWdL9UTVkU9DBOG4LeZxkj6aAPtSlHUeUgd63QRRicc5gXLMSnWrFG+
         ZUdvPD+AJGPSkXZyJ+E3aOX3OkhfBE0xfblyy3dmfJrZL/t+uKwra3cIJcPV7YCjXxUY
         QRwEzmzwwByxQIu1L1JSA5i9Eal6OW+R4bOPpk8pyPI2s0JC8gxTkp7bqsISiqJqZqDw
         JTUc6DLsw7gcgeIbEJyj7Ca8s9ruMuWqo2vJ0nAhjamAHwBUUPlw7kJfHNKSpUVJYvGk
         TFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737686588; x=1738291388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUr8glPor4PY9LWUaf6Hy93FwZ+OFlyI/oBmRms57JE=;
        b=nSIFAgUq+X9k2x+j+zm/cZpPRGVUBsmA/a8KE/aHIfLFtAA+imKInKxr02fLaBITim
         04RwCvLT6jK3SdBSiU1OnwnipWIRla9nnQnVrrBmyT704HRo3jtehK5135G7OCT5MGKC
         umZvaWL5SEj6ajXxxQg80iASNTUiogTUAP4yzFtw6UktIaMwfLj1i+cUR99TgA5v6GPL
         zrYKv0Gy43wcbqBAQQQlK9NHKuoca4Oh+tmGvJJ7BIMQCSHAxzLHaNSfePCx8531zC5L
         q1dfl6k1UIz3xUJvO0JrMW2SwMR+Z+kFKbPPP2wmw32e6ZcM2kcWHyuOLMh0TCmys7eZ
         L4rg==
X-Forwarded-Encrypted: i=1; AJvYcCVDHSQAhSs8N8eQTyGKNTzU+fm185Eoqt+WZNFNEopeUe4YuH0pzC/SPDRXzScoU1RnFgtRIa4yu7pWIQw=@vger.kernel.org, AJvYcCVGk0BGQo1MpT+x11K9TK7FOE30MjbA/24Ce48ZouqPTKzZd1wsfJP4YKTQNGpVQUil2RKM6E3m/nia7F4=@vger.kernel.org, AJvYcCXvXGwf9fRJT9lGmcpx684TS9HnVIqudfzajp32LozSp7Dc1NZZqWaDcNSlYQ29JuEqsn1UMRAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsTm3Z65ZpeXHF7Lu+VlBHKtuAo7ONU7amw3pb1104/CvoUom
	m3ViiVR3I4h8YGgoRSEmBgiR8noMPUguXavCh01NguLMoJ8PHTsp
X-Gm-Gg: ASbGncu8o9UcwtlEXHkUrWCVWd585zK6XLKKcMUqJy1cCF+3ZFtn8fSeTOmEZaiq+1G
	bqdHw4yeXPjc+vqJtw3KDY9pYYoDwFyUSR+Tu4xofEuRpikq2oNx/cJV0SeWW8uh6275qSiYCZv
	y28RnYH6Z4Qf25JAFeCQNcE1vvWzetBjYlPz6SQl7+MzpJKeR0eZysCauVZuVl/jsIg6PvuxYmp
	TmPfhs1dvMrjE4ArnK8YWEhDTbXAceqTSkPH7r6idoA6gjbdhT5Sb66DnlmUWBx/ASee0LM0RaO
	A0ZtoQ5GOETq
X-Google-Smtp-Source: AGHT+IE1TjZAhue2BOZibYjg2nefwmslQC24rfaOQvrKIXArpghvt/uN1d+O/NDrEY+ImyktqYYP7g==
X-Received: by 2002:a17:902:c951:b0:215:b058:28a5 with SMTP id d9443c01a7336-21c355c65a3mr359067945ad.18.1737686588269;
        Thu, 23 Jan 2025 18:43:08 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da41413e4sm5866175ad.158.2025.01.23.18.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 18:43:07 -0800 (PST)
Date: Fri, 24 Jan 2025 10:42:56 +0800
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Brad Griffis <bgriffis@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <20250124104256.00007d23@gmail.com>
In-Reply-To: <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> > Just to clarify, the patch that you had us try was not intended as an actual
> > fix, correct? It was only for diagnostic purposes, i.e. to see if there is
> > some kind of cache coherence issue, which seems to be the case?  So perhaps
> > the only fix needed is to add dma-coherent to our device tree?  
> 
> That sounds quite error prone. How many other DT blobs are missing the
> property? If the memory should be coherent, i would expect the driver
> to allocate coherent memory. Or the driver needs to handle
> non-coherent memory and add the necessary flush/invalidates etc.

stmmac driver does the necessary cache flush/invalidates to maintain cache lines
explicitly.

See dma_sync_single_for_cpu():
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/include/linux/dma-mapping.h#n297

dma_dev_need_sync() is supposed to return false for Tegra234, since the ethernet
controller on Tegra234 is dma coherent by SoC design as Brad said their
downstream device tree has dma-coherent turned on by default, and after add
dma-coherent to mainline ethernet node, stmmac driver works fine.
But dma-coherent property is missing in mainline Tegra234 ethernet device tree
node, dma_dev_need_sync() returns true and this is not the expected behavior.

The dma-coherent property in device tree node is SoC specific, so only the
vendors know if their stmmac ethernet controller is dma coherent and
whether their device tree are missing the critical dma-coherent property.

