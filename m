Return-Path: <netdev+bounces-105246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06C9103D1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54396B20C53
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBE1AAE2E;
	Thu, 20 Jun 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7C/bGWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5A1A8C02;
	Thu, 20 Jun 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885637; cv=none; b=iOIE63zxk7yV1Kra8LcM1YphZlt4n3SLrkEwsSrl9J5yF9CwNB93jwtHwbBcn1OuGhTWTAFUZPZWazk4BNEh2VSk/C4OxRtpsmzpymwyMBEWxw5hfXq+GnmWlKtG6BbHmajXopj8VQPXA4VBaKjFBhzUB5BHbJnYriYM+ulUyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885637; c=relaxed/simple;
	bh=Cv5FkU6Zt3NNmsmaF8RguZIxIrGhmnpzKJznIXzUnNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gquLcRAZ3bB9c1fXuAPQw65p3HKfdehNP71kzsfLflauifI+LbjyITgVyWVwI7Y3PrJk717r73FfGxBybWQAAe9Z1YgIBuWFEqmYNWLB0gEGDwBiQCKBKuWwpjXqZSdI1TpQhwx9S/XXBrLj/JXNLlzKXXNd7LvhHr/KVRfwJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7C/bGWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DB8C2BD10;
	Thu, 20 Jun 2024 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718885636;
	bh=Cv5FkU6Zt3NNmsmaF8RguZIxIrGhmnpzKJznIXzUnNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7C/bGWll6J0ZRCVhLxYf34LFpkGOMS32G9IwveTpUxXI3pCqVsJaxqMXM27dl6ET
	 RR6hMfntiAqW/bxCwDSwaTkc8r4f/DQVPJoN9lAoETVRcLecqdyLg+POiAs3ppfxFR
	 ZTvYj5idUnWYI4TCTKdoDqVkIc6aoONbwolUNOOfQmTv4svTaBu7lyobiK/430/9CE
	 R9cuQW1yihN0Ze5syzphFh3CwtFkFJUiAo7eN4keP8e+sW8eNsEO5hLn18alOa9uBH
	 7CTzY30BXopeotbcovVguF6tBgpNS9XOkoDoz9qzT5hCijHUTDh1+8MoibqFY+CSXH
	 CEI50R7UGK8YA==
Date: Thu, 20 Jun 2024 13:13:48 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	donald.hunter@gmail.com,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: Re: [PATCH RESEND net-next v14 5/5] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240620121348.GE959333@kernel.org>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-6-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618025644.25754-6-hengqi@linux.alibaba.com>

On Tue, Jun 18, 2024 at 10:56:44AM +0800, Heng Qi wrote:
> Virtio-net has different types of back-end device implementations.
> In order to effectively optimize the dim library's gains for different
> device implementations, let's use the new interface params to
> initialize and query dim results from a customized profile list.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


