Return-Path: <netdev+bounces-105245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E39AA9103CF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D165B20C27
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA561A8C02;
	Thu, 20 Jun 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDnB9ziL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4017624F;
	Thu, 20 Jun 2024 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885614; cv=none; b=FHrADKlQH5ZAlixwfZ4JBAu+w+ywNnnilOP27waW4vpyOs5lH3Sy7aVTXIvqSVFrTqZx7KkiB3nxlyaj8d+wWd3Woi/kIjwMxW6X8GocBRL7bm2ABKE80N3esjSEj7a/TzmltHfqIbRVTeZrdvF+iNONrTUdZDge/kN6+ihiU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885614; c=relaxed/simple;
	bh=ALwyHQYnQ27XucrUcBOJzCVCOO5Cid8DE44fswYyyik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcguG9t3zkxHiXTJX9ztXl+8CuErFZFGOTFjoSpW368OaOk/j0wAx9xb5VCjoAk5jO3onxBbIiBpb2KX/A4d8fAdCuVzJndHLV/qXxM8eibayqGSWskc5bjzog5znYa7osocoMlkhU67hv3KN4aUU4soe/od+BPOdihnGXFBZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDnB9ziL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0501DC2BD10;
	Thu, 20 Jun 2024 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718885613;
	bh=ALwyHQYnQ27XucrUcBOJzCVCOO5Cid8DE44fswYyyik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDnB9ziLO3XA+/E03jwt8HOznYGFblBHQw/HytOstSiPW36LleicO3EZdzDm1zi/b
	 0H1x3MVPWYWiU55Kd6AFIHlRyU1weP2maMf6NGV6xzR3ecjvgjMfWOyXUtwRxhXv6M
	 Elgy8PNGZWbARLL7BLQ4AHhwSHjgBSF8ZhfDrDEh1/PLXsXmzfPmTbF9TSD2zI5e9v
	 rp6AJJi8+g8MvL5/A/ICclLEZ+Q84kBNJRoVV3NMauhigTtWfqkOWhiDw0KrOWtzV4
	 t33y3BX5mHv6QRu6usZZdg0XuKkSXBptCC/MLo3E6ENBMHdch7KMe+QRDWdSKqJub2
	 xmDcGBkdlvdnw==
Date: Thu, 20 Jun 2024 13:13:25 +0100
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
Subject: Re: [PATCH RESEND net-next v14 4/5] dim: add new interfaces for
 initialization and getting results
Message-ID: <20240620121325.GD959333@kernel.org>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-5-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618025644.25754-5-hengqi@linux.alibaba.com>

On Tue, Jun 18, 2024 at 10:56:43AM +0800, Heng Qi wrote:
> DIM-related mode and work have been collected in one same place,
> so new interfaces are added to provide convenience.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


