Return-Path: <netdev+bounces-226776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2FBA5211
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EC656210E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F827B342;
	Fri, 26 Sep 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeJ4X9Vf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678526F292;
	Fri, 26 Sep 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919521; cv=none; b=GC60sN9tKyD2ga36sodk8U/JKuLwICv9okjlmJal2CsFM7rUlcf1t23URwvzpbr95+mlpMHelVT8fT3Bp0i3oqRonvEgKX9MykdqN6t5IZCOL+ImufISFsqlK58sQvRaF96Lz4StJZPRYnsb0LlHPDD4qybRNpDN8kzmQkSuINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919521; c=relaxed/simple;
	bh=nK4s3PChxs9ivgkRpl+7c0vitjJwwK0qPwlyJ0//ySU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+gSW6jF0MzPoCeLxCCScwdvSRBNI8neCRgystNa/hLvJCX5u0ZuVNX/qhY5py3h4+WpXBqvKjd3CGeE0vAQlWM9ab/29rp8Tus8UuBfpoyrlpJCrVanRf8uOmYjBLwDg6Tra/bbMuDN1Ef4NqjDc7a+ikAOUZcdFPc64CE1sPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeJ4X9Vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C32C4CEF4;
	Fri, 26 Sep 2025 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919521;
	bh=nK4s3PChxs9ivgkRpl+7c0vitjJwwK0qPwlyJ0//ySU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VeJ4X9VfCc9NDA6LowNjOrAE+wQlbVvlyOkrlJDcABolKSKzNBC5D/kBfE/hE1zEM
	 zoEyflQon29VK+oJQaaEFolM/hvR/JvVG43Yg3ir4dL1vvqgZoVVg3S5W5E9J9I/Nq
	 V9ry6jyEj8QJayhtD3e8BJmd/tOuudwbUrwHi9ZmG6QRG0l5o6ZlGaUvgoVVe1+Qt+
	 /IxbL5TbeHvymcIX2NEm/cGlXAv3EYmgViJ9kn0Hgez36/zL4m68m0+WdBY6ZcbTaD
	 CwuRxfJP74RsK5c8CGXZQrlF7FMriWRmCu9OIzOE9ujZrekG/jPIjVkV9lLKztDQ7F
	 ix4E4asVR1Z5w==
Date: Fri, 26 Sep 2025 13:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <alex.williamson@redhat.com>, <pabeni@redhat.com>,
 <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>, <kevin.tian@intel.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
Message-ID: <20250926134520.502f0009@kernel.org>
In-Reply-To: <20250923141920.283862-5-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
	<20250923141920.283862-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:19:13 -0500 Daniel Jurgens wrote:
> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list __free(kfree) = NULL;

Please don't use the __free(), you already have an error path in this
function, what is the point. Plus

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

