Return-Path: <netdev+bounces-225408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924CB9378B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0A13BD97D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9BE314B66;
	Mon, 22 Sep 2025 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cpUd4xVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B12F7ACA
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579483; cv=none; b=AZ8dyVKsxC7bAw8XRu2o7GcFqji2nO7S59eHYg2sce6OCXkjing9oyVBRy5Usq2TShuStvuDNHyLl0wUOQvJAWnwCG5E9O3HEXp5ck9pEpGQTgRAYZF8eyfYV2tVo8i8sdaPsvd/wxLuEZC6mF8jevA1dTbnhD12w1SDO88Yiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579483; c=relaxed/simple;
	bh=nIxPcTWKpYFMQ0DKFJV1uZUhaHCYkbbN3+FEmJpwJVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4mQa5K/Q7/hRlMyv366LjM9Rp3deTvUI5qFCGI8C74GNiqLbb7rIzkpPgODLqPuT86qbLbsyoHmrDPSTosWMf7HLcfskcaoH/H5bDiQUN7Ogku0AWLOquEuV4+81Q63yk+qgrCXnarEICX7Ffmh7A5/M0OLYVoFbyIEudAKjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cpUd4xVH; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-ea63e86b79aso3673862276.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579480; x=1759184280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIxPcTWKpYFMQ0DKFJV1uZUhaHCYkbbN3+FEmJpwJVY=;
        b=bkRpZyK8ocGoz6EMJPnkCY55T/2UDY5ij5eKMNtkiuhDyWuNrXW9zloIXa5ogZPyq5
         vhCFJj1ttxP24/gnXw61PCw67grTpgBCf4k0WDzymACVSNvAcPrDfcqvgRFa8N2puhcE
         6qoEKJLu98/vslCJyAZG/ffDjEUmkgG8XbSAbYJ1wVN1mOFpoOLASfc9Oxa0LKt3ICxa
         0xv0qtP+jLaOtrBt5cUwF0YrRuUpA1mARWkQtCiI900/TtuSXhgXERx36dfjDe4NACFP
         1VbLSTuPsO8BroYm19m7v4yPHH4B1zAqnlHxBzMG/KTajTRJQltjnEPOjNKcmajweMFC
         s+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4fiEM5VZdRnae63SgcZmsRSyJvFGMxgagd5N4+OU6/9k8SZS/V6nb6DhhxBKqvnYobKLeig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlWvblaY7P466fJRlsPusuRa46rUOydM5+vDGsqYug9/PH7tA
	NRXUvorRD35mr3fFFjdLelGQnFUWXYma/xeIBgXeVDA87fMKLC/5LrAWE7Pj4AJMuFCdaldPET6
	9/HYhDYp9GgnLF8YuVsZU2IFTHSCLTQbkRq9hIm/Ex6nCZMdv1UZA6WMvEiHEaVcweOSraklDs7
	yMNK5aFBtkZxmaoGxtI0E7ZRVO8GSEAIpBO56HpuKYSO79RHvgeLO5L72tV5U19besxAjZCxjS4
	nREl5w3jG8=
X-Gm-Gg: ASbGncu3Ubl+HHk4WEjn0gysYe0XZJzO024EOW+JN69MXj4dzTj1cE1VnXPBBHlKtA9
	+A2H3v5GcfP0Zh/BTpERb8WhGcrcV1RLBDbdsgSKiLkWVsePO0S2rD7udiBu02zpZ9fywQ9WTr1
	s6L2V7Y1n1zJnQbAlwEJnJmcR8yUwf/2NuIe9WXsYW7vB46F0q077qWtArsQ6XwQiPTgg/qALu8
	THuB77e8IUxZoxwojI5dl/rnnhhFdLzZFvdix4W2lBbfNpAjk0fBfehOipXfkEVygizJkUCSibD
	AyOMByCdyib+6qYXh9ZkQXGy3ZbD7/gjXei9cvIKfQe3Fi3sMoDxnV8hjYofCHWeAKmJ7AejUoA
	tz+NqNMtIAmX3rheoDzNAz1cot/fCqhhNr9I7AeuEuKbUq3BZMzeCliBoPM8pdEs3qCXbIWmUx6
	ZskA==
X-Google-Smtp-Source: AGHT+IHZ3ZHAH8JEORetromlhX4SIbV6ZO0t5q1PdKFMV/+P+o60kPnG07SodTZgauyMMrvelUv+nNEN3Wcz
X-Received: by 2002:a05:6902:18d4:b0:eb0:2379:5416 with SMTP id 3f1490d57ef6-eb32e4421d2mr545795276.12.1758579480132;
        Mon, 22 Sep 2025 15:18:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea5ce864154sm599758276.19.2025.09.22.15.17.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:18:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b28ae2e8ad9so179021266b.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758579478; x=1759184278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIxPcTWKpYFMQ0DKFJV1uZUhaHCYkbbN3+FEmJpwJVY=;
        b=cpUd4xVHqDk1OQqRGLHz6TzuuZFdCMDQ/W2S5u5dzymRUEfHjG6OdoLfQNfbRsL/ow
         AW3pJ6sNQgKy+ig6h5uZkJ6R7QJLrhm/HOlT4l1mrxiX6pciv4hWLe4YFFmuQ7AhEA+6
         FKQ3US2EV1UTzkykRaBcyP3B/yYqi7nL6nyMA=
X-Forwarded-Encrypted: i=1; AJvYcCVbhgCYWEbLe70uh4jmJIgOpzaNYTjzk3S1z1PB693wIIXH+lKSGEZn972wxAzjcLYk4/HBvPU=@vger.kernel.org
X-Received: by 2002:a17:907:1c10:b0:b17:ec4a:4f2f with SMTP id a640c23a62f3a-b302832a11emr23161066b.27.1758579478530;
        Mon, 22 Sep 2025 15:17:58 -0700 (PDT)
X-Received: by 2002:a17:907:1c10:b0:b17:ec4a:4f2f with SMTP id
 a640c23a62f3a-b302832a11emr23159066b.27.1758579478204; Mon, 22 Sep 2025
 15:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev> <20250922165118.10057-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-3-vadim.fedorenko@linux.dev>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 22 Sep 2025 15:17:47 -0700
X-Gm-Features: AS18NWBwoY3nZK5IVkqdDHZdTHN6e9YYz3W5Nh8dY4PG-rItMg3EnRakIzFCeG4
Message-ID: <CACKFLik_Ti6msHDfstakA+j4xBX7gC4BwaT-MfxYXdKQx67K+g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 22, 2025 at 10:00=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> Convert bnxt dirver to use new timestamping configuration API.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

