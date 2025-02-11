Return-Path: <netdev+bounces-165193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C5BA30E38
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC531889AA0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578A1F153D;
	Tue, 11 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bJ94sB9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE41E5B87
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284238; cv=none; b=J/xrfgTTcKA98Au7OvkgvhwM2ivFDfLWD/GPXQVPC4SmqF58WlNSikVO7F4iM412AYg/MH16oLBNKWtNX6rtG0W9NQ/HHc5LnRWA/KmyxbnmnL+j1qe+EY058LIOSfRjgVV8YsIH/VTfxWbzdyX10rEkKTDYBgVAEnK1rs6pJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284238; c=relaxed/simple;
	bh=LGP0MnohrCHX0TA3mcNR6Xq2PTPKx1CkipgOAe1wF3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTPe3AzOlVI16TU+izoBdUxkL6cUCjyvNG7hBLwk8wz5Bvp+PePKlSel98soRxHhgCxZhLb3UzQ5qBPgvqQQjnj7r1o2PdaLnIt07WPqxJfXO75ILEAbdXRV2hzeZv2PQLrbM7A+POF02hJkyrp7ycVPs13s0iQWZeEF2hXpH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bJ94sB9H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dd006a4e1so2943022f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739284234; x=1739889034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT5tvu7Lyv0hBJXCQsnSMPe1PwARbc0dto+OXPgtBhE=;
        b=bJ94sB9H8GngVZphEt5u27oGboNA+LHlfHdJ5KZGPblAr61vKU66XmeV7q3QMSsJOs
         s1MOxZjo9zNtJnrW5iLeacm2p/u7oxpFPIIQLc/hsaPVcoxwRxBrj+v/c0s0k3k2G5rl
         bEKxYJEgu28CG4B3mRHP+yOMgWbkxdrBKymhXAmJv/z7JgWadd/uPeTVkTJlkzTdyn6Y
         s4pReROfhYcB+1meCTEeAbgwL5L5OgEcHJ00swCL4C0X842NxgIbrmXNSQkc+v6MYxWr
         4Rf11QKIxniWMGiiw7Sona6GsMy1CgwVddtyp5dmb4Z7+sQWCEd/WowOEZedu1pNoONA
         HnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284234; x=1739889034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT5tvu7Lyv0hBJXCQsnSMPe1PwARbc0dto+OXPgtBhE=;
        b=hjX8bVpiWVCAvKqOpm/guTsma+WM+qslNKCHJXfzGkiHOeZCiQiQz+rEJkERmwcWls
         NAj7Hq0FrolePuOFFOOEtWNHjvph57roptYFljp5HHW4CKs5EANLTGtfr1sehLxUmTso
         Acfy/9YbNJYigctgQj9p8fNiQrTtEofy4S/hM4RoUcdi5yk34S14tbzViAHOum8uOrLW
         t96vGrqlV2LI04AUxSVfTlMOVZLWoUawYsGUSPI3CeU4QAhL6XlOjPOa/JR5grx/YOmP
         YhF5YiffRqzqeJDwnpBpFNCs+DkgArGXkaoRU3X5voPdyWZp2HEL+aPydOn9OQUbV2dO
         WHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBfCqZQGhOAf4AjmTrwmzPENZKT4v0hswCeTVt7LW7NqczasKESC75OHNjxXqPfaIMqRsjtP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfKzhLzR364Qb2WiV+W7GjrFvJRXmD0AuiEU1xteCZExS4OXV
	6BsQK7/fFfZvd0b2/9Q/SDOhi/gQscDUsN1lwvtEfgIeJFgQD2jirQqAgGbJZqY=
X-Gm-Gg: ASbGnctycCgu4g21nb6mFiZCBxKBmSFiWHJHU2opHHAg9AJyw4LkqI/96VVxB8/283E
	aAE12xXjmo6kbNALnQFueUOcQ+xtiPZ7/FhaZM8blG7RQ29O1DNEODwfZ9Nkp4wICMnxYz2y1eh
	23NX6lX8U8Fqdb3vU4bzJ16EzgaPLyzJh+tWsViRjCYVwVFaeSkIm4HvWAIlWBKcYDLvgGcYvGM
	J3PyPqZ+8xSYiEjrv50GJAd8y7S/+yOlxbxEaK54IMJ7ZsTxw1zeIfsAKrz1BJoLS3Gk9zOCL6e
	HnfiwIZTEwJShQRk9oUZ7Ww=
X-Google-Smtp-Source: AGHT+IF0/gy1RxQKBi+eAAAPCb64jyzQxzY5jIwS5gj5A4lW1zbtrxfRSCdp+Dh7uGod25DOHNO82Q==
X-Received: by 2002:a05:6000:dd0:b0:386:37f5:99e7 with SMTP id ffacd0b85a97d-38dc91133aamr13227800f8f.33.1739284234286;
        Tue, 11 Feb 2025 06:30:34 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43947bdc5c4sm50481085e9.23.2025.02.11.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:30:33 -0800 (PST)
Date: Tue, 11 Feb 2025 15:30:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Ben Shelton <benjamin.h.shelton@intel.com>, przemyslaw.kitszel@intel.com, mateusz.polchlopek@intel.com, 
	joe@perches.com, horms@kernel.org, apw@canonical.com, lukas.bulwahn@gmail.com, 
	dwaipayanray1@gmail.com, Igor Bagnucki <igor.bagnucki@intel.com>, 
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v2 6/6] ice: Add MDD logging via devlink health
Message-ID: <k2stckvckusd7pdjkvxpbfqabnarrqc7igcirnhorj2gobidgj@iugsqakc45b6>
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
 <20241217210835.3702003-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217210835.3702003-7-anthony.l.nguyen@intel.com>

Tue, Dec 17, 2024 at 10:08:33PM +0100, anthony.l.nguyen@intel.com wrote:
>From: Ben Shelton <benjamin.h.shelton@intel.com>
>
>Add a devlink health reporter for MDD events. The 'dump' handler will
>return the information captured in each call to ice_handle_mdd_event().
>A device reset (CORER/PFR) will put the reporter back in healthy state.
>
>Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
>Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> .../net/ethernet/intel/ice/devlink/health.c   | 77 +++++++++++++++++++
> .../net/ethernet/intel/ice/devlink/health.h   | 11 +++
> drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++
> 3 files changed, 94 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
>index 984d910fc41d..d23ae3aafaa7 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/health.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
>@@ -26,6 +26,79 @@ static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
> 	devlink_health_report(reporter, msg, priv_ctx);
> }
> 
>+struct ice_mdd_event {
>+	enum ice_mdd_src src;
>+	u16 vf_num;
>+	u16 queue;
>+	u8 pf_num;
>+	u8 event;
>+};
>+
>+static const char *ice_mdd_src_to_str(enum ice_mdd_src src)
>+{
>+	switch (src) {
>+	case ICE_MDD_SRC_TX_PQM:
>+		return "tx_pqm";
>+	case ICE_MDD_SRC_TX_TCLAN:
>+		return "tx_tclan";
>+	case ICE_MDD_SRC_TX_TDPU:
>+		return "tx_tdpu";
>+	case ICE_MDD_SRC_RX:
>+		return "rx";
>+	default:
>+		return "invalid";
>+	}
>+}
>+
>+static int
>+ice_mdd_reporter_dump(struct devlink_health_reporter *reporter,
>+		      struct devlink_fmsg *fmsg, void *priv_ctx,
>+		      struct netlink_ext_ack *extack)
>+{
>+	struct ice_mdd_event *mdd_event = priv_ctx;
>+	const char *src;
>+
>+	if (!mdd_event)
>+		return 0;
>+
>+	src = ice_mdd_src_to_str(mdd_event->src);
>+
>+	devlink_fmsg_obj_nest_start(fmsg);
>+	devlink_fmsg_put(fmsg, "src", src);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, pf_num);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, vf_num);

Why you don't attach this reported to representor devlink port? I mean,
exposing pf/vf num just because the reporter is not attached to proper
object looks wrong to me. We have object hierarchy in devlink, benefit
from it.


>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, event);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, queue);
>+	devlink_fmsg_obj_nest_end(fmsg);
>+
>+	return 0;
>+}
>+
>+/**
>+ * ice_report_mdd_event - Report an MDD event through devlink health
>+ * @pf: the PF device structure
>+ * @src: the HW block that was the source of this MDD event
>+ * @pf_num: the pf_num on which the MDD event occurred
>+ * @vf_num: the vf_num on which the MDD event occurred
>+ * @event: the event type of the MDD event
>+ * @queue: the queue on which the MDD event occurred
>+ *
>+ * Report an MDD event that has occurred on this PF.
>+ */
>+void ice_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src, u8 pf_num,
>+			  u16 vf_num, u8 event, u16 queue)
>+{
>+	struct ice_mdd_event ev = {
>+		.src = src,
>+		.pf_num = pf_num,
>+		.vf_num = vf_num,
>+		.event = event,
>+		.queue = queue,
>+	};
>+
>+	ice_devlink_health_report(pf->health_reporters.mdd, "MDD event", &ev);
>+}
>+
> /**
>  * ice_fmsg_put_ptr - put hex value of pointer into fmsg
>  *
>@@ -136,6 +209,7 @@ ice_init_devlink_rep(struct ice_pf *pf,
> 	.dump = ice_ ## _name ## _reporter_dump, \
> }
> 
>+ICE_DEFINE_HEALTH_REPORTER_OPS(mdd);
> ICE_DEFINE_HEALTH_REPORTER_OPS(tx_hang);
> 
> /**
>@@ -148,6 +222,7 @@ void ice_health_init(struct ice_pf *pf)
> {
> 	struct ice_health *reps = &pf->health_reporters;
> 
>+	reps->mdd = ice_init_devlink_rep(pf, &ice_mdd_reporter_ops);
> 	reps->tx_hang = ice_init_devlink_rep(pf, &ice_tx_hang_reporter_ops);
> }
> 
>@@ -169,6 +244,7 @@ static void ice_deinit_devl_reporter(struct devlink_health_reporter *reporter)
>  */
> void ice_health_deinit(struct ice_pf *pf)
> {
>+	ice_deinit_devl_reporter(pf->health_reporters.mdd);
> 	ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
> }
> 
>@@ -188,5 +264,6 @@ void ice_health_assign_healthy_state(struct devlink_health_reporter *reporter)
>  */
> void ice_health_clear(struct ice_pf *pf)
> {
>+	ice_health_assign_healthy_state(pf->health_reporters.mdd);
> 	ice_health_assign_healthy_state(pf->health_reporters.tx_hang);
> }
>diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
>index 5ce601227acb..532277fc57d7 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/health.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
>@@ -16,9 +16,17 @@
> struct ice_pf;
> struct ice_tx_ring;
> 
>+enum ice_mdd_src {
>+	ICE_MDD_SRC_TX_PQM,
>+	ICE_MDD_SRC_TX_TCLAN,
>+	ICE_MDD_SRC_TX_TDPU,
>+	ICE_MDD_SRC_RX,
>+};
>+
> /**
>  * struct ice_health - stores ice devlink health reporters and accompanied data
>  * @tx_hang: devlink health reporter for tx_hang event
>+ * @mdd: devlink health reporter for MDD detection event
>  * @tx_hang_buf: pre-allocated place to put info for Tx hang reporter from
>  *               non-sleeping context
>  * @tx_ring: ring that the hang occurred on
>@@ -27,6 +35,7 @@ struct ice_tx_ring;
>  * @vsi_num: VSI owning the queue that the hang occurred on
>  */
> struct ice_health {
>+	struct devlink_health_reporter *mdd;
> 	struct devlink_health_reporter *tx_hang;
> 	struct_group_tagged(ice_health_tx_hang_buf, tx_hang_buf,
> 		struct ice_tx_ring *tx_ring;
>@@ -42,6 +51,8 @@ void ice_health_clear(struct ice_pf *pf);
> 
> void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
> 			     u16 vsi_num, u32 head, u32 intr);
>+void ice_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src, u8 pf_num,
>+			  u16 vf_num, u8 event, u16 queue);
> void ice_report_tx_hang(struct ice_pf *pf);
> 
> #endif /* _HEALTH_H_ */
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index 316f5109bd3f..1701f7143f24 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -1816,6 +1816,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
> 		if (netif_msg_tx_err(pf))
> 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
> 				 event, queue, pf_num, vf_num);
>+		ice_report_mdd_event(pf, ICE_MDD_SRC_TX_PQM, pf_num, vf_num,
>+				     event, queue);
> 		wr32(hw, GL_MDET_TX_PQM, 0xffffffff);
> 	}
> 
>@@ -1829,6 +1831,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
> 		if (netif_msg_tx_err(pf))
> 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
> 				 event, queue, pf_num, vf_num);
>+		ice_report_mdd_event(pf, ICE_MDD_SRC_TX_TCLAN, pf_num, vf_num,
>+				     event, queue);
> 		wr32(hw, GL_MDET_TX_TCLAN_BY_MAC(hw), U32_MAX);
> 	}
> 
>@@ -1842,6 +1846,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
> 		if (netif_msg_rx_err(pf))
> 			dev_info(dev, "Malicious Driver Detection event %d on RX queue %d PF# %d VF# %d\n",
> 				 event, queue, pf_num, vf_num);
>+		ice_report_mdd_event(pf, ICE_MDD_SRC_RX, pf_num, vf_num, event,
>+				     queue);
> 		wr32(hw, GL_MDET_RX, 0xffffffff);
> 	}
> 
>-- 
>2.47.1
>

