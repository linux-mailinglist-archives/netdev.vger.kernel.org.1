Return-Path: <netdev+bounces-225482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD0CB9425F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 05:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F222A4710
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2699C236437;
	Tue, 23 Sep 2025 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZYrgFucN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8310226CEB
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599312; cv=none; b=alfAy87RJixNaVESa77l1a6oVzaITw+NonrgzpueT8hJijcM1j1p9lVFcdVKd8jViE7qtsi2skmBmWsPddxFWZ1cerWPAj0knYuLcSHXHmcw58ITNqLQXkPcweMJpDe4+ZOyuB6HxkAq2oQYOWN77ymYcF4AsYxnpi3tor7SsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599312; c=relaxed/simple;
	bh=mQPHn1S+2cOk8JDiDWYhCMMZNssEJC2ax3kEngRL21U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEBomWMnCa1Bl0HLXiaIbTsow03Ua9bynXI9Yrr/l3POv67tLng3o6iFfFSwHE0aJvi4B00TTzK+MsG+qxJwSYJ5tN898+P7JEq1/9VPT5cFeZTLlwGawo5Gy6nwNRd1LleNpBlvraqO2yzVcCQtQP8saVbp5o0LX+P8UQ/HX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZYrgFucN; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so3789310a12.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 20:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599310; x=1759204110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYDvGUd2Jld6tjPKgY5+g1YmBqRCMAPFap1tnPhbVWs=;
        b=dXeHTtUaq7Do88/lL2hzWF8LprSOrpi4fcqBJarsyHIf9Ew4Wacfq3P77A2gFo0ZkL
         pnH2NoH0N58UN6Z/1VeqYQPfE34/CwsbviHtXQXqMAHbISI7Joi4uMckTX5vaSTW0OuX
         vNp46/pXIpHnY5A3fZ86V4t4Qmy6YXofAyQkRTgAmbM08P2DdzHcXXGzUDgRYrmeRqkm
         k6D9uddC0qcBrq6sP8poHRLav+ELFkVWzpc/bR3zVQHLb6fCHW4ru+sBpm8L39zI/X9M
         FRxwgd83m5DIv0A+loVWN3zipgF6skRMxPEGmXj1UsV3Gb6sNm8/a7lHRnmwwHh06uTB
         W+tw==
X-Forwarded-Encrypted: i=1; AJvYcCWvWU03iAm5GUvUQT4gZOS04WftSFlnDmltWq+RHP18Kc8J8w7Jj1d636m3Vsy1LUozUOLHuEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwq97qdmytJ8+/8vN0MksYox0myJyFlnomC35td/pyNQLvNR8
	Du+m4ZeP4o+Yz3mYgz+ss/m9AWxkFmPDyTX/aNshwM1e6ASXCKx9YoL/HQc8PcEmR4q6K4PneEf
	SCie7SLtCIAQo0f3k2jJFzW4e1QGd3tZHFA2xxlxKCNoJsSROW0A5LKQqjNX6lpUoycIN8qhlxJ
	PHbkIrnRjc/4RLVCCPE+Swgzvbu3OVUgGYLmI5qSa/228BeNL12S6z0anVRso8gWeTKvV/amYVS
	ipfd1qY9QA=
X-Gm-Gg: ASbGncv+1uW8bqtKTittKxizPnqssVQ4s6J1muUxSGklm/BBBb3FbwbWAh9XjzW36E2
	v4UwvGUYpfAUgF1Pez0oRuEU059kl43DCc/NcEDA+nQ2Cs2pfIx/L/w7D8MIeQv4yzwcpfMtjHo
	x+h4UsyxzVw94TFXjfmOWEP6v0eR5/H/iYUXMprwG+8JJWjJlSg8exGCvwakFL+HStOSIWhvWFf
	2ihkLlQYUtlBBMkLoWaHRZxwdrXau2IB1I7MVjA/itLU3/cnk0CqZeC1sMLjssoC4whv0EEUUlM
	Aca+bNsM+g1Pu+Fu02F/oLuy/p6QLJusYZqRjeat8xHKbPCz0YyvJvgxnDuLQlDbCmiNCgh23/U
	Sa61jEi7T2dm/yRiNghQYnv8alx28RSUiIgZmG0atvc8LTKMp6nAKtQC1ds88gYTKGbi444PAZe
	g=
X-Google-Smtp-Source: AGHT+IHGbRWZtsGfmvql3zRnbBHBtah3h84dshMa9GO9GGeKu2HMLYahKV5BmZ9K7oTTF6eAPtCmcqJ18555
X-Received: by 2002:a17:902:dac8:b0:26b:3aab:f6bf with SMTP id d9443c01a7336-27cc67818a6mr13207335ad.42.1758599310078;
        Mon, 22 Sep 2025 20:48:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269800470a5sm9013415ad.5.2025.09.22.20.48.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 20:48:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so4986018a91.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758599308; x=1759204108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYDvGUd2Jld6tjPKgY5+g1YmBqRCMAPFap1tnPhbVWs=;
        b=ZYrgFucNU+WAJ0mvDgetInV99GfnTAMSBOdxOv/dsXqR5xU7bW+GArQDI/W/7rRKQl
         V7KHAahQ0SeXb6kgRl+6wISsnLLgz2RDKaHj85qBjAYYxeG0mPH6BioTua1tcfoTFuyU
         EAKQS12iaxHTtEXVVYDUf7CEyW5/h2re+FGSw=
X-Forwarded-Encrypted: i=1; AJvYcCWWMp46YCMXgN6MjlRrgBbTZdXHrWMzRjikcVCojRsEpfk1o0KhVh5ZujDdYIx5OHMy3+9QIsc=@vger.kernel.org
X-Received: by 2002:a17:90b:54cb:b0:32b:8582:34be with SMTP id 98e67ed59e1d1-332a950f80dmr1290186a91.13.1758599308303;
        Mon, 22 Sep 2025 20:48:28 -0700 (PDT)
X-Received: by 2002:a17:90b:54cb:b0:32b:8582:34be with SMTP id
 98e67ed59e1d1-332a950f80dmr1290176a91.13.1758599307892; Mon, 22 Sep 2025
 20:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev> <20250922165118.10057-3-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-3-vadim.fedorenko@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Sep 2025 09:18:16 +0530
X-Gm-Features: AS18NWD6zyX2_dFmJ8lCN3cfomR1pBmiLUlBSZJAFe7gqyuh13UlpJUuW953S6A
Message-ID: <CALs4sv0yZCWM-uk49WP8PU7ogFXVsc2notbtKBLX93e3KoRkpA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 22, 2025 at 10:30=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> Convert bnxt dirver to use new timestamping configuration API.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 35 +++++++++----------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  7 ++--
>  3 files changed, 23 insertions(+), 27 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

