Return-Path: <netdev+bounces-136313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886DE9A1479
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E2A1C22EB0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267AD18C332;
	Wed, 16 Oct 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZK8YfsPo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED02125B9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112433; cv=none; b=CNfxb6mLi7DUmN+vMG1dxR21wlq90IZ4zT6X7W+ssNtU1YZCONVHKoJoIWQ6L+pEjIhnCE3DdjLmet/os5aMthpJ8eENHDioQOa3jsmO2ztXACCctZLDQaGTtIzCBLk8yIDx39keSRJKR06pDmyjOBLa2oIwdNQ1BKIkvR9aIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112433; c=relaxed/simple;
	bh=n0mkAAOpucCSo8CSK/PgWiFCRSPNEpJJq8MlcOz+fHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoD4SHKO9FH+R0gJZAaJQse+s4pX3IP6iaDtg1nnQ0ZrWQaENViGOxyYUzw+5ZV9lw264aNy0Lt3JkBnMGoh9S238KQIk916wwTFFBq+DHFrdDLwMoNtTgaj7h5mR4ymVmGugYU9hGl+nPKw3gbIHT7lEhywhT1meCyLphFf97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZK8YfsPo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729112431; x=1760648431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0mkAAOpucCSo8CSK/PgWiFCRSPNEpJJq8MlcOz+fHU=;
  b=ZK8YfsPoBTNpoth0gPsRmb8qiEsuYJWtG4Zg6L8y8H2xZVdRy0o/uTfS
   po+FdBei4XCHx2OJdNNH3hhGlSFiExKQy1oFCMEhG4/wJOxQ8T50rVP7l
   qLPcAkuIGMOmC6xcLAHCNY7KylbP9qV/a9RP0xSI2uxUVwA2++bSgCOyR
   wP6qdclqyJDYT/MjJUj7OMk13thVQ5W9YSKAwtb2fqA9LzRDK3t3Ka55A
   kl7QLJEA6EzZC+sLdYb2ff7oqdnXrhz6O5UFN+++6NpTg3g05yCBVYMfc
   H6VKBJv+zLDBnTbbRJlgC5YSQQaOttTiiPDPz3gOccKUItcP+ICTCPE0a
   Q==;
X-CSE-ConnectionGUID: wOIEpYoARGaUBhUI3ePt/Q==
X-CSE-MsgGUID: MmOYvSuARE2XSQz4ubNrjg==
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="32910108"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 14:00:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 13:59:59 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 16 Oct 2024 13:59:57 -0700
Date: Wed, 16 Oct 2024 20:59:56 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V3 06/15] net/mlx5: Introduce node struct and
 rename group terminology to node
Message-ID: <20241016205956.4jfgn43ehfltmqbq@DEN-DL-M70577>
References: <20241016173617.217736-1-tariqt@nvidia.com>
 <20241016173617.217736-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016173617.217736-7-tariqt@nvidia.com>

> Introduce the `mlx5_esw_sched_node` struct, consolidating all rate
> hierarchy related details, including membership and scheduling
> parameters.
> 
> Since the group concept aligns with the `mlx5_esw_sched_node`, replace
> the `mlx5_esw_rate_group` struct with it and rename the "group"
> terminology to "node" throughout the rate hierarchy.
> 
> All relevant code paths and structures have been updated to use the
> "node" terminology accordingly, laying the groundwork for future
> patches that will unify the handling of different types of members
> within the rate hierarchy.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


