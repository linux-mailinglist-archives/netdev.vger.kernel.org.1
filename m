Return-Path: <netdev+bounces-158292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD9A11559
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE6188A8C6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8334214201;
	Tue, 14 Jan 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nZayV3xB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB72139D2
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897167; cv=none; b=DtNkshQbTrRNvUz7Qz9Jdw+gQdjtYJ7CJ8/qrj5loKVarg5izLYN038AO+16AvpjvdfJSZdEav7UBFxEHaEcZfcWHhYe5Xp0Fs23jX+v2eDDKEN56dB6PNSd0/5l/D3kiX8PHbcHlltrDNH7bfTEZoPvCsA4h6z7s3m/zPWiK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897167; c=relaxed/simple;
	bh=M/zA5myD7TcCfQp5oOilhju7M9SI5LbUs6P30WBHxK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQS7PxZ6O5nLO1Ri6+7D6OmwL8qpEgxUh2SpsBadDyWFobXLhIF5cAJ+FoFw7v3RlaKoy/4b/rdB5SLJU8qK/HbBP0wBndLV2PsdQUL1l1YLEaexN70w6jtptVld1lGFCYTL9+RtvLocbizWzldJtcdle6gZpJDapXvkMUqL+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nZayV3xB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166f1e589cso130332235ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736897165; x=1737501965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV4PmVLk16CjHPkaMxzQZluPn2DMGP8myx2jLb4e+Pg=;
        b=nZayV3xBwQ2gIMwoZXpS8KOs/Y7VgcZn7BL6Tlj9Uy/1J2vH4XNvFgKEXMXpTmKx5O
         8rycF5UxSE+KSwrkgDxQu7hxNAWoDM+5EUW+JD8cw30L9cRFl7SJcpsHLyFu8OiOURHe
         M/BqM+f8QmhfypSSteSuvtcsxgCefShNoOwdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736897165; x=1737501965;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NV4PmVLk16CjHPkaMxzQZluPn2DMGP8myx2jLb4e+Pg=;
        b=Je0x6riMwkYPHDO6ZzXYdR/C2R/XoiitnGKAmNO24AW3MPupO9xg7oSr/QDXGuJsnf
         hulpFQFcv+N1dwR7+CNGcL+eTCuPUAMWfslzNnX+aAre96MAgYg6hoRncEW73VUXyoaf
         kJpKhaBtC5PFsMt5202wYgI+ic0IFueBquGm7m46cWEXEj0QXM3b4Oz/F2m/kmNncfPT
         v6x47rB4owjk/kN9Aj9FF+TflL6oQNvIxpthWTfZPIw180c20KHKR9BS+3/viLoXJgpC
         4Ljkzyi/DbvQkjLibwC05ViYBSewHt1HlBigyr9AFvF4/MxJQOyZvB1TLsxLhJwQ3Ej0
         DsMw==
X-Forwarded-Encrypted: i=1; AJvYcCUKihMdLVzv8ww29LEkVuZCftLMZzt5PJYeodEplblLQRSY9vwDjdHPcWTaj2fbqkWB3VEx4Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43EGWdMTm7h2WQHKxORwcm6W632OH1c+1UISjO3TUprz1t2oR
	61mlGn2WNjifxASG/FWwTlPYjV8rCFFafgap0kbl9ArRXVhh7+VrxQP5fuKxs00=
X-Gm-Gg: ASbGncuDAwpFDefQGNWbdMSqpE0p53fEFjSVIpLopI6D20+cSY48j3pGKl/yLCV8GAr
	xfzpPEu4R/ixtdqglahL2g3DbEBnR2Az6BWp5OB2iT+AOWvVYqQe1KiLYuuiaA14jXXU32wG1Re
	8rsh0Aw2yYDV8WSLlXeHy43yOryX0hghcR4d0gOyb6ztROqan0Lh+D/n7pkIXuk+ceT5rnDD9t4
	i4D9+ENs2m5W/6rkfVFCpX19hSklHwtXrj6EJpHAW8Uvhc/oK1/Mropy5NRjj+oXmkb3c+S7ZrB
	05vPBVG9MAcwfpccMAtKunY=
X-Google-Smtp-Source: AGHT+IHFPFr5ciMlkXuJKMpdKsuIG5B3oWU/wQ0JkBhOmdVXMKwtxjYVcUrFRpNdNfwpkhHQYwGirQ==
X-Received: by 2002:a17:902:da87:b0:215:9642:4d7a with SMTP id d9443c01a7336-21a83da6a40mr434425125ad.0.1736897165605;
        Tue, 14 Jan 2025 15:26:05 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a7f1sm71225625ad.124.2025.01.14.15.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:26:05 -0800 (PST)
Date: Tue, 14 Jan 2025 15:26:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Question] Generic way to retrieve IRQ number of Tx/Rx queue
Message-ID: <Z4byihk_5pqXcLvB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Daniel Sedlak <daniel@sedlak.dev>, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
References: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
 <20250113131508.79c8511a@kernel.org>
 <adf7c053-ffde-4df8-bc24-99740906410d@sedlak.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <adf7c053-ffde-4df8-bc24-99740906410d@sedlak.dev>

On Tue, Jan 14, 2025 at 09:32:26AM +0100, Daniel Sedlak wrote:
> 
> 
> On 1/13/25 10:15 PM, Jakub Kicinski wrote:
> > 
> > We do have an API for that
> > https://docs.kernel.org/next/networking/netlink_spec/netdev.html#napi
> > but unfortunately the driver needs to support it, and i40e currently
> > doesn't:
> 
> Thank you for the link, I somehow missed that part of netlink...
> 
> > $ git grep --files-with-matches  netif_napi_set_irq
> > drivers/net/ethernet/amazon/ena/ena_netdev.c
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > drivers/net/ethernet/broadcom/tg3.c
> > drivers/net/ethernet/google/gve/gve_utils.c
> > drivers/net/ethernet/intel/e1000/e1000_main.c
> > drivers/net/ethernet/intel/e1000e/netdev.c
> > drivers/net/ethernet/intel/ice/ice_lib.c
> > drivers/net/ethernet/intel/igc/igc_main.c
> > drivers/net/ethernet/mellanox/mlx4/en_cq.c
> > drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > 
> > Should be easy to add. Let me CC the Intel list in case they already
> > have a relevant change queued for i40e..
> 
> Thank you for directions, will check Intel's mailing list and poke around
> with implementing that.

I previously tried to add support for this API to i40e [1], but got
pulled into other stuff and never picked it back up. Wanted to
mention it in case it is useful for you.

[1]: https://lore.kernel.org/lkml/20240410043936.206169-1-jdamato@fastly.com/

