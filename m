Return-Path: <netdev+bounces-32292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C503793F36
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689AD1C20B52
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A14DDB5;
	Wed,  6 Sep 2023 14:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17426A32
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 14:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F22C433C8;
	Wed,  6 Sep 2023 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694011598;
	bh=XtjFHz0kr2CxSLZgBm1IwAfLDFLkZ1dkYl3QsDcvQ9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PQ9Z34R0d7wRZVJfRRULUzuEwV8WIXua+dYUyRvVCHsmvEHcXuUIvxZ9ePPXfPMgs
	 kdeRB7sl8mR8omCkBW6WIU3DFSvbsED2zNCf+d7FR2ypZ/7DesUpqp2a5tCRGXBnOz
	 xm3G5rIH7IUFLeh3d7frvooAc4Rs8E318Ipkdw13ZhvKMlHbKrS/QwTT7kQszraNs9
	 AYZNnHxgxdZxXeRhgxhAW4IfollC52k5vJWGxdrBAAqspfoeVH0+BbKhYDnXn1tZ6v
	 OxLroTnYsEBE908P3/zMgl77nhyXH1v/zZjo3ufyhGdpPDmVCNXFhvzZzi6dj1V/Av
	 QOQuA6rqhYKyA==
Date: Wed, 6 Sep 2023 07:46:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com"
 <bcreeley@amd.com>, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Message-ID: <20230906074632.0fc246e9@kernel.org>
In-Reply-To: <SJ1PR11MB6180C190E2ADF4FB2B17A430B8EFA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230824170022.5a055c55@kernel.org>
	<SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230825173429.2a2d0d9f@kernel.org>
	<SJ1PR11MB6180F2DBE9F6296E35451B3CB8E9A@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230905101504.4a9da6b8@kernel.org>
	<SJ1PR11MB6180C190E2ADF4FB2B17A430B8EFA@SJ1PR11MB6180.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Sep 2023 02:52:30 +0000 Zulkifli, Muhammad Husaini wrote:
> > In the ioctl uAPI we can't differentiate between params which were echoed back
> > to us vs those user set via CLI to what they already were.
> > 
> > Maybe we should extend the uAPI and add a "queue pair" IRQ moderation?  
> 
> Good advice. BTW, if queue pair setting is enabled in the driver, could we change the existing ".supported_coalesce_params" for driver specific?
> 
> From:
> ETHTOOL_COALESCE_USECS which support (ETHTOOL_COALESCE_RX_USECS | ETHTOOL_COALESCE_TX_USECS)
> 
> To (new define):
> ETHTOOL_QUEUE_PAIR_COALESCE_USECS (ETHTOOL_COALESCE_RX_USECS)
> 
> With this, I believe user cannot set tx-usecs and will return error of unsupported parameters.

Do you mean change the .supported_coalesce_params at runtime?
I think so far we were expecting drivers to set flags for all types
they may support and then reject the settings incompatible with current
operation mode at the driver level.

