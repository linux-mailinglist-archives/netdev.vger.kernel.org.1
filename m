Return-Path: <netdev+bounces-118375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44C9516CB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D901B1C215A3
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EF1422C3;
	Wed, 14 Aug 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QZZ8bwnp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFF140E34
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624945; cv=none; b=QB0aCtGLIcwfiZSLvoncbv67cu+VrseenAy+qXdvX3cb8NvjGn/puTi4hqGalY0wW9VQ7zN+jZo4MWsqFiYGndY6u1xHWeFsOasEETYwzrS5N4TyKCnGqElbwvG4TpyunqhOgLZRqTD106NqMAh0kMuD2KM6KM0A1Devj1LelcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624945; c=relaxed/simple;
	bh=OMSQgYBYCkbJlCeBh7cHM21du5ujcyxOTDNvginWvok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCnRL4cBxUTkj2lQ+Va69fTkr/NNycWJoftGoIFnGqX1vWaKpIkixfLOR99wLZ9pm43qXWUzgnBVeIROvCopDMUj6tLShoD1erHNhPSndOEeuEyCXCK8yrfRX6nqVKobcvNmO+aKDXLcIQFi8W0VCHghPw27y8m42mDp+Uq602I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QZZ8bwnp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a94478a4eso117385866b.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723624942; x=1724229742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MtcYVbcKdbU5eaP94ytYIcsWmU2jQHJH0R3AboN+gQ=;
        b=QZZ8bwnpJbH/cCFst96nn8w3/wFEkR3B2uymnxedBGmLPW0813yi301uExslOsyVKA
         FgnYN25g+dQB/dhi9xd/k5qpx8F9AZzlABBLDMQc4615jKE6NHL0zqze4M8/97QGvXVN
         GZidp+IYuztc6XHcRjyM6omgQsZ6M7I8OGxv7ohTIoLG/Csb0H57i31H3lQWM4AV45i1
         cFAiay2scbUBavtd5YF5LnkRuyok0JR2wioslUqOR+UG7NpCMuHiWh/IIa5/74cxMhtK
         VH4qvY298ZFLvqkWNKZfLqmDlnxSUc1wZ36nEwEPqfNzWmVCRAET1/wk53nHkswKRSch
         manA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723624942; x=1724229742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MtcYVbcKdbU5eaP94ytYIcsWmU2jQHJH0R3AboN+gQ=;
        b=c6eNrUIvFCPW95Upa7D1M/CMocrcA3XgwkAu4NAjOvOiu6fEe3hMAeabIjgqEDAc76
         cXHcEbPas0O1MGdJZEicGNi2PH2QnG2Yl4uzldURZRZlSPDUplGRVl2ySkzJmcUIeXjO
         DPrbc0fpD8v6Cta8fmRYsagYV8Sta0dL/IZWWrUDjH/EIQ3to4u5dZXHzfIiG1clbbiG
         3xBnzGV7c/MguqoEJdsKSx5fOkNo6pH+pvUtayfsc4zAEX5jPyuL0oSvzLmrGGPjRnlz
         GseipJHSlF0IuqyLqaV1Cbqd/STJcd+j2qoh6YY+4F4pLVH6rimZkJ3yohjX1rwZQpeH
         lY6A==
X-Forwarded-Encrypted: i=1; AJvYcCUf+Cp3J4OQykKn089/9Xc6qVkYQi8jYhZJ61gz/4MgW/Ut+izk2LGTlObbGHYCR3cvE2xewesXzeS95fA0jpkYYWXmiEun
X-Gm-Message-State: AOJu0Yxuap4P56xxQ3t2vNeRFQwHk54Wl/hYoGy9GTxXzQoBKe8k8uaA
	hr7EdXg0zegtigtYQ89lC5G2Q41250xwsNQDbr1LINm45HjPjJyQlRrXKnrWhRA=
X-Google-Smtp-Source: AGHT+IG0NqE4ab/A5abtvoxOBcpk656uGEdQRk/oOFrUy/P7AQkMfYirHE5f+BKa1HMdLscurQoPbQ==
X-Received: by 2002:a17:907:3f9f:b0:a72:7ede:4d12 with SMTP id a640c23a62f3a-a836ab73ef0mr114946866b.5.1723624941583;
        Wed, 14 Aug 2024 01:42:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f47b26sm146059166b.41.2024.08.14.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:42:21 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:42:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v4 03/15] ice: add basic devlink subfunctions
 support
Message-ID: <Zrxt64Ff5iG1W21p@nanopsycho.orion>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
 <20240813215005.3647350-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813215005.3647350-4-anthony.l.nguyen@intel.com>

Tue, Aug 13, 2024 at 11:49:52PM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Implement devlink port handlers responsible for ethernet type devlink
>subfunctions. Create subfunction devlink port and setup all resources
>needed for a subfunction netdev to operate. Configure new VSI for each
>new subfunction, initialize and configure interrupts and Tx/Rx resources.
>Set correct MAC filters and create new netdev.
>
>For now, subfunction is limited to only one Tx/Rx queue pair.
>
>Only allocate new subfunction VSI with devlink port new command.
>Allocate and free subfunction MSIX interrupt vectors using new API
>calls with pci_msix_alloc_irq_at and pci_msix_free_irq.
>
>Support both automatic and manual subfunction numbers. If no subfunction
>number is provided, use xa_alloc to pick a number automatically. This
>will find the first free index and use that as the number. This reduces
>burden on users in the simple case where a specific number is not
>required. It may also be slightly faster to check that a number exists
>since xarray lookup should be faster than a linear scan of the dyn_ports
>xarray.
>
>Reviewed-by: Simon Horman <horms@kernel.org>

I don't think it is okay to carry the reviewed-by tag when you do
changes to the patch. You should drop those.


>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 290 +++++++++++++++++-
> .../ethernet/intel/ice/devlink/devlink_port.h |  34 ++
> drivers/net/ethernet/intel/ice/ice.h          |   4 +
> drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
> drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
> drivers/net/ethernet/intel/ice/ice_main.c     |   7 +
> 7 files changed, 342 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>index 810a901d7afd..b7eb1b56f2c6 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>@@ -6,6 +6,7 @@
> #include "ice.h"
> #include "ice_lib.h"
> #include "devlink.h"
>+#include "devlink_port.h"
> #include "ice_eswitch.h"
> #include "ice_fw_update.h"
> #include "ice_dcb_lib.h"
>@@ -1277,6 +1278,8 @@ static const struct devlink_ops ice_devlink_ops = {
> 
> 	.rate_leaf_parent_set = ice_devlink_set_parent,
> 	.rate_node_parent_set = ice_devlink_set_parent,
>+
>+	.port_new = ice_devlink_port_new,
> };
> 
> static int
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index 00fed5a61d62..aae518399508 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -5,6 +5,9 @@
> 
> #include "ice.h"
> #include "devlink.h"
>+#include "devlink_port.h"
>+#include "ice_lib.h"
>+#include "ice_fltr.h"
> 
> static int ice_active_port_option = -1;
> 
>@@ -455,7 +458,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 		return -EINVAL;
> 
> 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
>-	attrs.pci_vf.pf = pf->hw.bus.func;
>+	attrs.pci_vf.pf = pf->hw.pf_id;

You should do this in a separate patch, most probably -net targetted as
it fixes a bug.



> 	attrs.pci_vf.vf = vf->vf_id;
> 
> 	ice_devlink_set_switch_id(pf, &attrs.switch_id);

[...]

