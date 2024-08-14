Return-Path: <netdev+bounces-118451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35B951A6F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F404D1C21D70
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD31AED3E;
	Wed, 14 Aug 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xflRKiKI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347413CABC
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636549; cv=none; b=kPFQ1pwVpoaQqhLnl0ZhJROBbIed/SM11kPUVAHjETzVEmePhY2U5JB01R8IRilx8qRjZbgl3vgt11hQw7s61JMLZUEh9nbyTDUAc07eyPqUUMZaUp+8MXzCuL3+dsHUpMuT4ociabbppEUM8J1qtIyjx6vxam5zzoq8OQH7PTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636549; c=relaxed/simple;
	bh=19q1gGkjxUPS+gVjduBiyChW7OfOoSMsvwD77sPZHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpVgDYObuOjOyaCMwbKjNsPS3KYsrT0NbsFrXgz5mVwqkIbJSrVFbQPDZJIt2m/2EKX7Voamr1mhom7u1iSbSTACDsT8Wiav28AKiQZrDEONEZPFS027yl3BhzegSRQ+e2v1Jv68iFzTvbeYRL6moZIIwoNU5qSB9LPJUBmnnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xflRKiKI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42819654737so48190195e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723636545; x=1724241345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4nvtD3c7ebsVrPpVCsIwSE/KyHPBO/xTewUEQFql/I=;
        b=xflRKiKIKN2/oU90S8tG1nGg26HDSkQ83UzsXRrjqsu7CzNQk+ay1oyN5dlPQx7SR3
         virKEhrPbq2eAkq+H0vMIpawvVw5vti+2oIGnHBhTyVCtN5Uf7IFhCFro4yv8gtdAEHK
         dH1V5zRj/Sq2xmaSTquHuwGf1PrIZj+MzhMCeojqypwHfRnJzYwbJNnjrf32iqJqezXU
         v8d/ULpUc5sUwBTUwn4zRN4WexASMyC2JiTIwa27kazCT08EJhhn/kwYKPm31B8i5ChJ
         PouWuXYkCrRQ3YxNFotz941bDISloML/1d7wP5C00Ye6LFY8zoi2gLEBBW9SfudMN3R3
         Ox5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723636545; x=1724241345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4nvtD3c7ebsVrPpVCsIwSE/KyHPBO/xTewUEQFql/I=;
        b=CLlNRJR0ZlqMOKnM/aBYaawJG/rtiGvONghLvffbopbvYf1pZCZYpWJLyUMxscz4j2
         mLbIUfcotQqYKkQP9m1QMNWRijYQZx0HIeQ141/j22BzUHy2WSQgSTWiZV+kQqUGGWEP
         ieZbdu5uN8XCktIW146dofuYkIz2AlZkEET0R36NwD/Yv1MeopIHHblCF0vPTh5dlWm+
         7B9h2VgBXnmaCcGPTwXHDwU0xQTrOMI2wzjRpRBAQpNbYgJaWzizSy6dEsgNngQjdkHb
         dNU+hV0b1fJT7OiZLgZOBW3VxxtDWLZJH+Of1OLeZrJgxUmrgUm6HADQotld4nVHNvZc
         Vmkg==
X-Forwarded-Encrypted: i=1; AJvYcCVjqZvidtqz577NMZRmeaFCR5uQtJu3xPwunqZJhWI9Cud0TmPM+cPfOO1LM+e7j4aAJPmuLxRmEqGPmT0avs8rPMGIh989
X-Gm-Message-State: AOJu0YxLZiVnBNAPw6v1WJ++aVKqO05JKuBGrIK/WUNL1716TefTmlGE
	JgB8kf6gUkLh7qNUyaPtzmlEFZsieWR4TbjzdgUZLLW4WcN2MzDqevcXH9z6i8E=
X-Google-Smtp-Source: AGHT+IG/oWYG/5D+p98Rp7KAVxRVxjGJs1wOlXg+00mZIUXb5l1hERyUsUPY2xsjzxQExrxEaDi0XA==
X-Received: by 2002:a05:600c:3588:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-429dd23d80emr16028355e9.17.1723636544378;
        Wed, 14 Aug 2024 04:55:44 -0700 (PDT)
Received: from localhost ([37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a7111sm12766566f8f.117.2024.08.14.04.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:55:43 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:55:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v4 03/15] ice: add basic devlink subfunctions
 support
Message-ID: <ZrybPfS9bUtn-N3c@nanopsycho.orion>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
 <20240813215005.3647350-4-anthony.l.nguyen@intel.com>
 <Zrxt64Ff5iG1W21p@nanopsycho.orion>
 <ZrxwqMyIyfX1XcPn@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrxwqMyIyfX1XcPn@mev-dev.igk.intel.com>

Wed, Aug 14, 2024 at 10:54:00AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Wed, Aug 14, 2024 at 10:42:19AM +0200, Jiri Pirko wrote:
>> Tue, Aug 13, 2024 at 11:49:52PM CEST, anthony.l.nguyen@intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >
>> >Implement devlink port handlers responsible for ethernet type devlink
>> >subfunctions. Create subfunction devlink port and setup all resources
>> >needed for a subfunction netdev to operate. Configure new VSI for each
>> >new subfunction, initialize and configure interrupts and Tx/Rx resources.
>> >Set correct MAC filters and create new netdev.
>> >
>> >For now, subfunction is limited to only one Tx/Rx queue pair.
>> >
>> >Only allocate new subfunction VSI with devlink port new command.
>> >Allocate and free subfunction MSIX interrupt vectors using new API
>> >calls with pci_msix_alloc_irq_at and pci_msix_free_irq.
>> >
>> >Support both automatic and manual subfunction numbers. If no subfunction
>> >number is provided, use xa_alloc to pick a number automatically. This
>> >will find the first free index and use that as the number. This reduces
>> >burden on users in the simple case where a specific number is not
>> >required. It may also be slightly faster to check that a number exists
>> >since xarray lookup should be faster than a linear scan of the dyn_ports
>> >xarray.
>> >
>> >Reviewed-by: Simon Horman <horms@kernel.org>
>> 
>> I don't think it is okay to carry the reviewed-by tag when you do
>> changes to the patch. You should drop those.
>> 
>> 
>
>I changed only warn messages, but ok, I will drop it.

Well, you changed the pfnum assigment too. Any functional change means
drop the tag.


>
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>> >Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>> >Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> >---
>> > .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
>> > .../ethernet/intel/ice/devlink/devlink_port.c | 290 +++++++++++++++++-
>> > .../ethernet/intel/ice/devlink/devlink_port.h |  34 ++
>> > drivers/net/ethernet/intel/ice/ice.h          |   4 +
>> > drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
>> > drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>> > drivers/net/ethernet/intel/ice/ice_main.c     |   7 +
>> > 7 files changed, 342 insertions(+), 3 deletions(-)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >index 810a901d7afd..b7eb1b56f2c6 100644
>> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> >@@ -6,6 +6,7 @@
>> > #include "ice.h"
>> > #include "ice_lib.h"
>> > #include "devlink.h"
>> >+#include "devlink_port.h"
>> > #include "ice_eswitch.h"
>> > #include "ice_fw_update.h"
>> > #include "ice_dcb_lib.h"
>> >@@ -1277,6 +1278,8 @@ static const struct devlink_ops ice_devlink_ops = {
>> > 
>> > 	.rate_leaf_parent_set = ice_devlink_set_parent,
>> > 	.rate_node_parent_set = ice_devlink_set_parent,
>> >+
>> >+	.port_new = ice_devlink_port_new,
>> > };
>> > 
>> > static int
>> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>> >index 00fed5a61d62..aae518399508 100644
>> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>> >@@ -5,6 +5,9 @@
>> > 
>> > #include "ice.h"
>> > #include "devlink.h"
>> >+#include "devlink_port.h"
>> >+#include "ice_lib.h"
>> >+#include "ice_fltr.h"
>> > 
>> > static int ice_active_port_option = -1;
>> > 
>> >@@ -455,7 +458,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>> > 		return -EINVAL;
>> > 
>> > 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
>> >-	attrs.pci_vf.pf = pf->hw.bus.func;
>> >+	attrs.pci_vf.pf = pf->hw.pf_id;
>> 
>> You should do this in a separate patch, most probably -net targetted as
>> it fixes a bug.
>>
>
>It is already on ML:
>https://lore.kernel.org/netdev/20240813071610.52295-1-michal.swiatkowski@linux.intel.com/

Then I don't understand why it is part of this patch. This patchset
should be on top of the fix.


>
>> 
>> 
>> > 	attrs.pci_vf.vf = vf->vf_id;
>> > 
>> > 	ice_devlink_set_switch_id(pf, &attrs.switch_id);
>> 
>> [...]

