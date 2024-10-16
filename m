Return-Path: <netdev+bounces-136310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523639A1476
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16830283BEF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD41D2B13;
	Wed, 16 Oct 2024 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RWicn6ic"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5B1D27A7
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112268; cv=none; b=jAoMR99u8fkta9C1Pu8Ns1OzaLbKzgTrnMpe1kb5EcTUzpYVZHC/xzFTRAaJ4nCJfyKEzHmUG+r1gefJ4JZA+tgzWIWcFekneG5A4YyU6uF0xE+vwDZsblh9HFnvebSCPIW4keMSBSvb74hq2CpyxNipXu/yaN4P8sQ1MuZiyNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112268; c=relaxed/simple;
	bh=ksU7U5EcproD8Z1IUN6H7JdNaTflODCFh0FmK8n6JfA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuUUTvcG0c7fmlKvPfrfrXTzOklAGADmNTGnQYlFVP0Jt1UNCKqM8bfN5p8HNg809aG5DTyJcoWGKn1Ljg+sWsa79EoC/mJQ7huxVGwQfnJxYvcU3da97QhipFeLmP1cwgym/na99GhP5fkE8CluZMhnzLEBugVmd8+Q0VZob/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RWicn6ic; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729112266; x=1760648266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ksU7U5EcproD8Z1IUN6H7JdNaTflODCFh0FmK8n6JfA=;
  b=RWicn6ic5H78Kc9rJmbyQ1ZQSgm2iixSbkJZwoteRhZSeqY5bh3teEVN
   KSOzK0g+A0sk8DHLjw5mTFxwsUqovAB/bL/HO38e1LFfVY2TeVSBwBhrS
   w+7g+ZxX6J80PL7CHvUY/vGzWyhcpuzf9RwD6sL2TIqBcgITyvl8CL1B4
   RX09gY2mJ74puWdD7GRmjBDWSoa4nj+VGr2Uquvy3yE7lJx+8Y+LVLgLv
   5GII4rrbEiJ6rSKNwGr+S8qLzWuYiSOsbwbofJ+mdwp7FPLSZO0RflCZV
   CEKnZI9PwV0FcrHT9w4Ftqq1cTG+A2e0NuYA/MQG7+BgfSBXaWWE0n2Us
   Q==;
X-CSE-ConnectionGUID: bsnEJfkMTlWVJFkuWK6bcg==
X-CSE-MsgGUID: vOiUk4tRQIuiq+ar6OfsXw==
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="200540547"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 13:57:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 13:57:25 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 16 Oct 2024 13:57:23 -0700
Date: Wed, 16 Oct 2024 20:57:22 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V3 03/15] net/mlx5: Add parent group support in
 rate group structure
Message-ID: <20241016205722.4cnfo7eon3bjrjfv@DEN-DL-M70577>
References: <20241016173617.217736-1-tariqt@nvidia.com>
 <20241016173617.217736-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016173617.217736-4-tariqt@nvidia.com>

> Introduce a `parent` field in the `mlx5_esw_rate_group` structure to
> support hierarchical group relationships.
> 
> The `parent` can reference another group or be set to `NULL`,
> indicating the group is connected to the root TSAR.
> 
> This change enables the ability to manage groups in a hierarchical
> structure for future enhancements.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


