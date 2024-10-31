Return-Path: <netdev+bounces-140578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5E59B7144
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA64282B52
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F417C98;
	Thu, 31 Oct 2024 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wkWreBLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24923A9
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335524; cv=none; b=ZKv7YUHprl/BXjW2iRlVZ3t2FsbjYJkADnXt3Iq+LjrVL91e/pP4qouEfbE6LAf0+D9UR5DNh9N4uvJpZCekUE9uyqe8fPe7Um5aqW4Gqyez+KcOaCWPeUuEBBzPoelKaIRVPUDJcs/Yw3BCgOD1Od3R7RF7ohIhq1p03N4gByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335524; c=relaxed/simple;
	bh=DlNwPIxvoDePtUKHBG/Dt1fSWAKy9cm1/TEoVetVqZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6bgIuZ4YTnpbcPchn9KakZP/G+BVujoszpgfjBf4x6/JUcPcxCrgyWSP11aszZmgXm9pWP3dLUFX58j2nEc1WPrPGt8qkkuxf/kB0PVV8596EHlCu4U2PQD1J98uDyeww7LCt/wOl4NM5gWb4s0j4PS5pZ8edd5kexhNLw8cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wkWreBLQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e59746062fso347629a91.2
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 17:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730335521; x=1730940321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUD0KPvqMk9qfe6LI5x/QFIzi9ou2XERMnVYjUAAYzs=;
        b=wkWreBLQnfI2Ok2nfm1mSAxJiIDAtieavaRNsxUb810s6Dc0AdDwG73QpGm3dFp392
         woIc2YYuJRigcT7OxWp1eUUD7N/Et9/zw+diGvP1fMzXS07MQ5CVpkgD+vlNUT5gd7Hv
         hCUJ0OnIbHa2SUZqECoXM/btgzulLUooZsiqZncouzAoxcLcGPQpZ6G3z82ombzXBnMC
         VxSo8Nha8fro6dxcSSlqW8Dym5b7hl5t1TGofMkxqJhByuqC5kcIiyO/M6RuB/ILnm+E
         FN8FEWv16B4FJu5RwyXH5XphW3aqiCruZeVETa9MUIG0A4U5OJqZgw+FpiflsHvQBUVq
         AP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730335521; x=1730940321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUD0KPvqMk9qfe6LI5x/QFIzi9ou2XERMnVYjUAAYzs=;
        b=aO1J0uN7EHrUb6PpaHTVZMz4BhYUFCuVy3a+6ct7geDb0MOcIm8ehS72/tdPzU+VOI
         GT/wThVM+r2Wqq76SLZ8Q0Yz6en7Y1WaFimS9RobRPNrwdUdqpsTsN9HtVLnV98HISF/
         B74lkbY0GNEl24dxtOW8gbV00rSup11Xjz2iUf/dM4SoC87VUEYKyxKB/ybZvAunPATS
         Seso06B3z1DnkXNB7y5QwMvJZakv1vUyvJK836zv8AsUJj3XNQiv8nk/46V/RKrVtsmW
         Zk+4Pd8Z0pYRs41/Zhtp1LImjH5AsmWWhpkXdyNx64RsS71krIXn5lJRMLyT9b8cpnMg
         cfYA==
X-Gm-Message-State: AOJu0YycuU9y1oi6r2OqR5/+A4NEHjZYmB2JyFCiImPIlSkYZcQKCIpN
	iasVrgqhugde1PL6Fe7Lt9c2plx/pNjfQlTZtcbjmt5UlRhUjhGKjt2eMDeKEAbLQSim4jtDAey
	jqQg=
X-Google-Smtp-Source: AGHT+IGVdwehaCX4ipap+FU6VthaUmmb1Nw+SpydfSQKG1Qps6M11BqXxxDqZrDRF4J8WonCbKYnbw==
X-Received: by 2002:a17:90a:e7ca:b0:2e1:a81f:5520 with SMTP id 98e67ed59e1d1-2e93c158c64mr1960415a91.1.1730335520616;
        Wed, 30 Oct 2024 17:45:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db4296bsm286596a91.48.2024.10.30.17.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 17:45:20 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:41:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, entwicklung@pengutronix.de, dsahern@gmail.com,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
Message-ID: <20241030174140.4ef77885@hermes.local>
In-Reply-To: <20241030222136.3395120-1-f.pfitzner@pengutronix.de>
References: <20241030222136.3395120-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 23:21:36 +0100
Fabian Pfitzner <f.pfitzner@pengutronix.de> wrote:

> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

Use print_color_string for printing addresses; to be consistent with other code

