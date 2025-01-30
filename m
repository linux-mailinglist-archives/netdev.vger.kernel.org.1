Return-Path: <netdev+bounces-161597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C1A228A3
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 06:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9217165A3E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 05:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F901865F0;
	Thu, 30 Jan 2025 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUoht0Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5C183CBB
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738215600; cv=none; b=JEaNUxAqPiLIadxV4OtaQxOVQKAYT7qV610/nKeJ+2v1ZOezQbmchwVmDEdakuOr1frdtgjdoP/JgB41gXhOQ9K/ljzVEwkb03JI+e37y1v8KiLRF41HqpAKEw0GHDS0D41/LSIe7CaPnxNHbCsR4o2R/Fii+8DjwNxVN4WZYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738215600; c=relaxed/simple;
	bh=k2TB9RI4DUrjT39n463CRE8WJy+MBsg3App0eKbjl2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ma+RSMRX/gbWDPz8c8ZsKPzpzv5W1PkXemU2d8J0fXirumaQ9TjrziBY/7Y6A64HkWZYelYIh0rAj+U+zgRL4hJVey0yvdjBT9SFaZMPL3O7PbeZs1HNrcgareTSM7uHautFabpdA9zKoGS5H/8V4YOt7x7MMY4v5Fs4DlMbaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUoht0Kv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso2130105e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 21:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738215595; x=1738820395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tawOs+rXlsMzCwf+LGEPYlHYgGznelnhxMiN2FkCFWk=;
        b=uUoht0KvpKOA1TDbX4xxuH3dqEofoeVVI+At4AsKOed2dTNim8sDPScfa8hEy6wtIH
         i1JEDir3ObazStXkF+TESYw2cvbfeBQi9lHLZ7baBDQ1ISsgxdFJumWo0Z0fowFSNitA
         avsOydQb8gVcBsvWTYSZuMSOnDghLEOtv6dgasvszyidg+doiJXBqn8biLDV6jvgSdlx
         3fgqr1bOkYpN6LLF3lbQHo6j7MIq/gtGUX+s5ygCN01iPZwlry4O43iYR5nYDPhwsh9j
         4nQdBjDlTQcymoq7K94rt8TeqPKi64fo+LmP1WBF29PK/iq9vkJ/uSCWAKV7BAky4W8w
         4dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738215595; x=1738820395;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tawOs+rXlsMzCwf+LGEPYlHYgGznelnhxMiN2FkCFWk=;
        b=gWNz+lYZ2XMf+zYrBsNraTd28NUDn2e5oLFcOmwd9SjsoGA06FYMJlrfG5eQzwAKoY
         ztbWrC+/vPXvj45JE9JXfzhAQvwB7rXN4hNuW+yiVEDpg6maxlvceM9JrPM5+5YuwxMI
         VCRIelzVtFgpMX8WBr+lbogee83vsarwxKAcxXdD9vsTKQJvLeFMVLDgVKeZKoXg6y4b
         6m0fdbmoQBebpTYzV3Vg0qE89KBYoV2LkiMgsU8CAZkQQVanU7eqIE368aJWBIkCgXt8
         UKhm+nbzBHlU88nDkcYw5larR3O/us3JfwWOqRhj68zHCwt7TPCoqMUwZB/Rz2lpoa0O
         G0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKY72GBWvoRaJx4W0MAidEEQbW53A6fqcGWuCTE3eAUP6C9RQqXuAk3x7ivzIR2nhoyDwWdvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWNFllf8wqGjNtUbn49HnpF+QbH9Cnk823tk8eS4RcQBk9awv
	ocTCD6KtGbvaPBtw6FVTIRIyC0SfqnHXjRlf9zNkId08cK0dE0enZCrjTsD/O2k=
X-Gm-Gg: ASbGncu2tNP9IJwtdVq7Bvv0U6MAutlzDsbhSZXcbbozquSFjDCKDGJHR8zIRxY4Mcb
	Z5P5H1EurCQ7VnXSJUc7na2LL8Kd3yUv/dNOmrVzPQTLp1XmT9u5Cy5NiQblzbc5w4/1T6+Wb8U
	rNrPsFqV+WrEiTdFwhR5eagUiIntGSevcQuegxiCGuGQjSRqRfGRC0zRWf7Sfqi2qCm4XwrbYKA
	XJn4OGk8eM1/uEj8f45HMilgtqTQ7aPS5QP9AWkLeNuJBKEc+UhHbvVf7qcQc1fLL6o33CkYfgH
	YgTPxBKhY/LG4Sy9Ijz/
X-Google-Smtp-Source: AGHT+IGkob8f5Rg4ltVari8jUgRwXDAeSVmbKqSg9q5LIabRwV6jxbIS5q51TZ7Z/+nr1pGS6FTS1Q==
X-Received: by 2002:a05:600c:1d1e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-438dc3bd896mr50750435e9.8.1738215595009;
        Wed, 29 Jan 2025 21:39:55 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244eb0dsm9882645e9.27.2025.01.29.21.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 21:39:54 -0800 (PST)
Date: Thu, 30 Jan 2025 08:39:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Michael Chan <michael.chan@broadcom.com>,
	davem@davemloft.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org, Somnath Kotur <somnath.kotur@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for
 TX rings
Message-ID: <8a4bcb57-ca1a-4fa2-95d6-cff55b41de44@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116192343.34535-10-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-Set-NAPR-1-2-support-when-registering-with-firmware/20250117-032822
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250116192343.34535-10-michael.chan%40broadcom.com
patch subject: [PATCH net-next v2 09/10] bnxt_en: Extend queue stop/start for TX rings
config: x86_64-randconfig-r071-20250126 (https://download.01.org/0day-ci/archive/20250130/202501300808.5bqgHMA6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202501300808.5bqgHMA6-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/broadcom/bnxt/bnxt.c:15769 bnxt_queue_start() error: uninitialized symbol 'cpr'.

vim +/cpr +15769 drivers/net/ethernet/broadcom/bnxt/bnxt.c

2d694c27d32efc David Wei     2024-06-18  15691  static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
2d694c27d32efc David Wei     2024-06-18  15692  {
2d694c27d32efc David Wei     2024-06-18  15693  	struct bnxt *bp = netdev_priv(dev);
2d694c27d32efc David Wei     2024-06-18  15694  	struct bnxt_rx_ring_info *rxr, *clone;
2d694c27d32efc David Wei     2024-06-18  15695  	struct bnxt_cp_ring_info *cpr;
b9d2956e869c78 David Wei     2024-08-07  15696  	struct bnxt_vnic_info *vnic;
5d2310614bc883 Somnath Kotur 2025-01-16  15697  	struct bnxt_napi *bnapi;
b9d2956e869c78 David Wei     2024-08-07  15698  	int i, rc;
2d694c27d32efc David Wei     2024-06-18  15699  
2d694c27d32efc David Wei     2024-06-18  15700  	rxr = &bp->rx_ring[idx];
2d694c27d32efc David Wei     2024-06-18  15701  	clone = qmem;
2d694c27d32efc David Wei     2024-06-18  15702  
2d694c27d32efc David Wei     2024-06-18  15703  	rxr->rx_prod = clone->rx_prod;
2d694c27d32efc David Wei     2024-06-18  15704  	rxr->rx_agg_prod = clone->rx_agg_prod;
2d694c27d32efc David Wei     2024-06-18  15705  	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
2d694c27d32efc David Wei     2024-06-18  15706  	rxr->rx_next_cons = clone->rx_next_cons;
bd649c5cc95816 David Wei     2024-12-03  15707  	rxr->rx_tpa = clone->rx_tpa;
bd649c5cc95816 David Wei     2024-12-03  15708  	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;
2d694c27d32efc David Wei     2024-06-18  15709  	rxr->page_pool = clone->page_pool;
bd649c5cc95816 David Wei     2024-12-03  15710  	rxr->head_pool = clone->head_pool;
b537633ce57b29 Taehee Yoo    2024-07-21  15711  	rxr->xdp_rxq = clone->xdp_rxq;
2d694c27d32efc David Wei     2024-06-18  15712  
2d694c27d32efc David Wei     2024-06-18  15713  	bnxt_copy_rx_ring(bp, rxr, clone);
2d694c27d32efc David Wei     2024-06-18  15714  
5d2310614bc883 Somnath Kotur 2025-01-16  15715  	bnapi = rxr->bnapi;
2d694c27d32efc David Wei     2024-06-18  15716  	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
2d694c27d32efc David Wei     2024-06-18  15717  	if (rc)
5d2310614bc883 Somnath Kotur 2025-01-16  15718  		goto err_reset_rx;

cpr isn't initialized

377e78a9e08ce5 Somnath Kotur 2025-01-16  15719  
377e78a9e08ce5 Somnath Kotur 2025-01-16  15720  	rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
2d694c27d32efc David Wei     2024-06-18  15721  	if (rc)
5d2310614bc883 Somnath Kotur 2025-01-16  15722  		goto err_reset_rx;
2d694c27d32efc David Wei     2024-06-18  15723  
377e78a9e08ce5 Somnath Kotur 2025-01-16  15724  	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
377e78a9e08ce5 Somnath Kotur 2025-01-16  15725  	if (rc)
5d2310614bc883 Somnath Kotur 2025-01-16  15726  		goto err_reset_rx;
377e78a9e08ce5 Somnath Kotur 2025-01-16  15727  
2d694c27d32efc David Wei     2024-06-18  15728  	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
2d694c27d32efc David Wei     2024-06-18  15729  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
2d694c27d32efc David Wei     2024-06-18  15730  		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
2d694c27d32efc David Wei     2024-06-18  15731  
5d2310614bc883 Somnath Kotur 2025-01-16  15732  	cpr = &bnapi->cp_ring;
2d694c27d32efc David Wei     2024-06-18  15733  	cpr->sw_stats->rx.rx_resets++;
2d694c27d32efc David Wei     2024-06-18  15734  
5d2310614bc883 Somnath Kotur 2025-01-16  15735  	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
5d2310614bc883 Somnath Kotur 2025-01-16  15736  		cpr->sw_stats->tx.tx_resets++;
5d2310614bc883 Somnath Kotur 2025-01-16  15737  		rc = bnxt_tx_queue_start(bp, idx);
5d2310614bc883 Somnath Kotur 2025-01-16  15738  		if (rc) {
5d2310614bc883 Somnath Kotur 2025-01-16  15739  			netdev_warn(bp->dev,
5d2310614bc883 Somnath Kotur 2025-01-16  15740  				    "tx queue restart failed: rc=%d\n", rc);
5d2310614bc883 Somnath Kotur 2025-01-16  15741  			bnapi->tx_fault = 1;
5d2310614bc883 Somnath Kotur 2025-01-16  15742  			goto err_reset;
5d2310614bc883 Somnath Kotur 2025-01-16  15743  		}
5d2310614bc883 Somnath Kotur 2025-01-16  15744  	}
5d2310614bc883 Somnath Kotur 2025-01-16  15745  
5d2310614bc883 Somnath Kotur 2025-01-16  15746  	napi_enable(&bnapi->napi);
5d2310614bc883 Somnath Kotur 2025-01-16  15747  	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
5d2310614bc883 Somnath Kotur 2025-01-16  15748  
b9d2956e869c78 David Wei     2024-08-07  15749  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
b9d2956e869c78 David Wei     2024-08-07  15750  		vnic = &bp->vnic_info[i];
5ac066b7b062ee Somnath Kotur 2024-11-22  15751  
5ac066b7b062ee Somnath Kotur 2024-11-22  15752  		rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
5ac066b7b062ee Somnath Kotur 2024-11-22  15753  		if (rc) {
5ac066b7b062ee Somnath Kotur 2024-11-22  15754  			netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
5ac066b7b062ee Somnath Kotur 2024-11-22  15755  				   vnic->vnic_id, rc);
5ac066b7b062ee Somnath Kotur 2024-11-22  15756  			return rc;
5ac066b7b062ee Somnath Kotur 2024-11-22  15757  		}
b9d2956e869c78 David Wei     2024-08-07  15758  		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
b9d2956e869c78 David Wei     2024-08-07  15759  		bnxt_hwrm_vnic_update(bp, vnic,
b9d2956e869c78 David Wei     2024-08-07  15760  				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
b9d2956e869c78 David Wei     2024-08-07  15761  	}
b9d2956e869c78 David Wei     2024-08-07  15762  
2d694c27d32efc David Wei     2024-06-18  15763  	return 0;
2d694c27d32efc David Wei     2024-06-18  15764  
5d2310614bc883 Somnath Kotur 2025-01-16  15765  err_reset_rx:
5d2310614bc883 Somnath Kotur 2025-01-16  15766  	rxr->bnapi->in_reset = true;
5d2310614bc883 Somnath Kotur 2025-01-16  15767  err_reset:
5d2310614bc883 Somnath Kotur 2025-01-16  15768  	napi_enable(&bnapi->napi);
5d2310614bc883 Somnath Kotur 2025-01-16 @15769  	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
                                                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Uninitialized variable

5d2310614bc883 Somnath Kotur 2025-01-16  15770  	bnxt_reset_task(bp, true);
2d694c27d32efc David Wei     2024-06-18  15771  	return rc;
2d694c27d32efc David Wei     2024-06-18  15772  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


