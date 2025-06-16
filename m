Return-Path: <netdev+bounces-198122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877EADB532
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BD818872B8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBC20C038;
	Mon, 16 Jun 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RbV6EqUo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFE2BF01B
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087442; cv=none; b=k+KXCrxanX6MGUfiAEYmEtQn1Qpqxct8VenovikK0Kw1DNTu1G/vulUjg3QZz+FN3mHPNGT68GD8PqyEMPv4ElJZ0HQ2/IOUF/CVIlh1RR2R/aL8qOqzxvEYY/BSzB7ehUDWpwGDHmKy9Lc1Mdwl5XAqxakCNUGIGidyQ4JXC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087442; c=relaxed/simple;
	bh=q4TdalR7abYhC1edKTX+jZ7RdJf6EHkRjD0T4l54DoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJv5wMw3D5KdXWge6K71CD7qQalW/6A+uD96lr3d3ak5O4SbXCGEzJBQpYUfLHn2xwnrysLU00eOUAr5TAf1e9O4QKpGz35QOjsIvYnhlIjMEa458yKd30nnJYXGEGzntWyzBJB1b8RTWWYuC3MVA8Di+ygukA+u2l8eVleyVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RbV6EqUo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3145941f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087439; x=1750692239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF60HHVrNcI4iTxK1p8Ap3HWFqO5znVdWpUelG2IIFA=;
        b=RbV6EqUo551qS7E1idJs6ph68uq0CfM9JjJ+3XDUaHPoKI6s0wb89SfATLBXqcI7/B
         4XygFn5f/7lVIIUwPOGZ3WYIXTbUF8KDj6Hj7EEbXMoQfY2kxySheAFPdC+YoqNmWUWY
         ae6KOjrQUgh0OBBVw1WvICNZ9ik9badAzx1xOF6pBVPHjxMHZcvpJXAeQvmrBYmDatMc
         u2GLqIIh44j3woTPMeIPc4NBUarLqjj7tyQfGHyRDltIuprjRyCBgH8L24KLXGMYBYxc
         h39yrfDspYzyblW6nkcXK/1nCM8n0jXZEmXIrIgtQxgi+wrMXyAPJ7GdKWwYZnphEykc
         Duqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087439; x=1750692239;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF60HHVrNcI4iTxK1p8Ap3HWFqO5znVdWpUelG2IIFA=;
        b=CU69dlmmEZAEwSsCj7cmsvvNdg+G6lH4zV2o4DOLaShwu2WBGZZaczjSqAAp52tpc4
         MC84VlGYFlhd+TV1ky6dXBkX5iyORvBUL4McqpLQXVUeGb7bdKR3KPvAOO/GB088rHLq
         wvUHXVIG8RmIAOlNXPRd+E1YX9bz/xfm2P5ZVCei7ViKIdMVQUWXyWRVDemSlKuLRLwI
         qosfdJXd9mnLu0kpfHhe6fKOMYSkrTPZOuYgboUH+HD6NrC+FFXXOoNys+zC4FFGUH+Y
         9Pe40BtIa2dyA50RXT23jFMm9QwEw3htk8Tei6dkA1U5aiSuI3B7omkNWVX5zOuFFXMQ
         Arcg==
X-Forwarded-Encrypted: i=1; AJvYcCUYANFrGSud6mk/8JPazrh8R7ZzRm19Qp9jxL+4RfF7PdsNiMR9nzR2BI1v8zYQUVFTIC3iXEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7uTjW26IxQqeu+KvzaFXp9Q6e1zI8jglxwYhM+CLzvQmBzur
	GevhjdXr/xpaHCgqZvikzw0ttVRPdpacECuyX5PoQaqjNyP2siJI2LDmcUQTGOLn8hY=
X-Gm-Gg: ASbGncsDkDoWykPbTQx1GBZJT1N+uGsLPpppaLRcFag5uE8hTYfWvF9q+4GGg272UUz
	OqKN7gFua+WPoV0asoiVCWrFycstkgCn6YHZ0u3WeD/HDrnqjqyP63D193VAnJRIU5oy5Tir0v8
	H1Eso+uuyZlTr0yEnkGWaYE2SxXg1IxYmdJpJUktiUd/LzbUv+aqiLWvpiD95z5H8gjMlZXnlNX
	mrKGQX6JUIpulb08+QimcIr6VIP+f5g2oF2yUJaxg3ADpLcse3KPQjmW79EN+cKBCEgoZiczoee
	v8kKw5gu2SSMmcxEitIlwmSFOv3wdcxLTo9YxDr+oFVNfrw4+0eA0EoXzHqZG3FS9b0=
X-Google-Smtp-Source: AGHT+IGwvOWKyM412fudvPrM6z8FEgTIk+C6r8GvJ8HOktClslj4MXAPMSdndeNeikNtUQWd0wrJpg==
X-Received: by 2002:a05:6000:288d:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3a5723a3539mr8133077f8f.34.1750087439181;
        Mon, 16 Jun 2025 08:23:59 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a5407csm11512896f8f.12.2025.06.16.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:23:58 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:23:55 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 2/7] eth: igc: migrate to new RXFH callbacks
Message-ID: <aFA3C5sSiI5F7eZH@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
 <20250614180907.4167714-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180907.4167714-3-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:09:02AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

