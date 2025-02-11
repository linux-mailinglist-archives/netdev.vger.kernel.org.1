Return-Path: <netdev+bounces-165191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FA9A30E2F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D4F1889590
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8B24E4A4;
	Tue, 11 Feb 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zbQYrIxr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6026BDA1
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284021; cv=none; b=O50/3c1z/h/456WCCobDK1Apmko+K+bPFZJDFPZ2/1vYcV58Pc0R00URLlvK97iCsLIYoIkcej3byUAs2HQi68DkmGvZj6kFb/pZO97m8eBBPFcfuHFiSd7731HOmR0T3dY3rGC2HXBgjGuu9zlZkQr0cfgeMBMFqoSNUmLtWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284021; c=relaxed/simple;
	bh=ORph6WHhdfjjF7TRBD3THrGxoj2KH/dnNiVfNhMUQ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECCSq/cR+lhKsVwTjV9pQULOOjS2AuGPS2H1++KTvv2IaBWv8phRE6tdDsMAF4i2hJmsmp+RX+o3YsRrCX+HFZTmeNdrEpviHXMhk0vu1BO7SFJPX18PMqMKVbNuSi8a5BfcevN21xU/+4uuiDHKlhSgw4pAqwG0YFBbbAKu7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zbQYrIxr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43934d6b155so18862865e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739284016; x=1739888816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdO/Ig7NZab+toeg90dGiJddg/UfhLpJehJrPuMO4q0=;
        b=zbQYrIxr6E6plwGe7NBjLSE2UqMuz4ycHpGoWO8onlDAktPnOOH3jXcfaSAW+u+SVK
         P0caVDBmq0gbrCVbyd7udovGK39VKEcVQaIp6zNF0LjVlRYEhO0O2ucNhzZ0c5lREfsA
         jYE4dybzzFmsoCsAQMirLUCpm2BHPj6Z3OUBD673MhZH92j8V5BiCVSB8y+dhpUI/3Yo
         N5APL2OdvmmVdl4n1MzJdY4KLrswC3swnbW5vUTHe2o6a3wTvGBILKCVzNAqsuUXNz5V
         fxaNuCPeD1LoBjWwy8VlRdB4CXtTxvR4bix36btpdLZYovzyp6Mz8BwSOJKlmvDz/891
         fknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284016; x=1739888816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdO/Ig7NZab+toeg90dGiJddg/UfhLpJehJrPuMO4q0=;
        b=kgrqTUVrefFfvczw/90xDUfdt7iVX3aoXtk+3zVbVXKTNkYI0x5euOskswYL7sf/JV
         Y9GCmaDtj7QXTW050zjlIGlEZ8p9rDPevYt/jZP4CpcdNnkB5vh4yZ21EdKyq9DupZ+i
         49KoxyG2Hk4d/lPAGfuilacjHc9iZS3pfwoVMt+sii40n3vjB4MLs+aT0p/3JrKmuWo7
         x7evEkp4XsgqmiQbjpMj0PD3KoFNCkgDnM5W3MKWdvi3BIWY2QcKqP+/JJnY2qgnBTlm
         0hst6pwDstU3xm6CNOU5lRzlkFHxhIRfRpJxdH3/rYLXXJqe+rIJ+I1/AWuKn64UEvfi
         0TbA==
X-Forwarded-Encrypted: i=1; AJvYcCV7fgYysn8XxvLfh0STyA/RCW2Q4nKg86OEwSIgQ5nWAt6b8G2/W3dZMzFyirV5JIxByQEDdxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbDXZ5Cll/ldNQlaJr1+bd9MIObLg0joF/dOuUoalC3bUPsh4
	GaZBB4WSjyJd3+7hk2Po0Pm8UkI+HSU2HBJdvdMEtNDw6KjHVe4nItm9kVq3YY8=
X-Gm-Gg: ASbGncvT1+AegRoXOYWF4D7CV6Ya6D/Eaj8/VDCgItAxGGp5Z0g673S7TL5FIhXYva9
	tL7iyHP0FXxRQMUJsSO4lkKBSigLiOYBTyCPD49cAUTHWfhEgeYuzH+8Pe8OKrEUAdqHcF2dBDc
	2zDztKCg0Ua7b9wf35XG48aTly+xEtDf1tWVwUDbpfVhcoa05e3zUj3kOAP0HqzczFBce7+1DbE
	q/1HP3/wk25VeY49EUllxEsQdlSNVR1iCAG+rfZaLWwaMXF6BKUE66ySqgQKmFbKA5q5GZ0f3CL
	w5pPsypS49MRW9qNB9UNfKE=
X-Google-Smtp-Source: AGHT+IHApfzEjMGqL/0DrADKbcQGnkZz0jDtD18J71jZ1ZAzO8f+lEUzK+sCz/k/xGmSCdNplmf9vQ==
X-Received: by 2002:a05:600c:484a:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-4394ceb21fbmr30063785e9.6.1739284015875;
        Tue, 11 Feb 2025 06:26:55 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394779a96dsm52749215e9.4.2025.02.11.06.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:26:55 -0800 (PST)
Date: Tue, 11 Feb 2025 15:26:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, mateusz.polchlopek@intel.com, joe@perches.com, horms@kernel.org, 
	apw@canonical.com, lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com, 
	Igor Bagnucki <igor.bagnucki@intel.com>, Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v2 5/6] ice: add Tx hang devlink health reporter
Message-ID: <k24eu6e64meeunvif2g3m4xqkzj3h7jmgs4axvmcic2tjpxewx@d4uyeqraobuj>
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
 <20241217210835.3702003-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217210835.3702003-6-anthony.l.nguyen@intel.com>

Tue, Dec 17, 2024 at 10:08:32PM +0100, anthony.l.nguyen@intel.com wrote:
>From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
>Add Tx hang devlink health reporter, see struct ice_tx_hang_event to see
>what exactly is reported. For now dump descriptors with little metadata
>and skb diagnostic information.
>
>Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> drivers/net/ethernet/intel/ice/Makefile       |   1 +
> .../net/ethernet/intel/ice/devlink/health.c   | 192 ++++++++++++++++++
> .../net/ethernet/intel/ice/devlink/health.h   |  47 +++++
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
> 5 files changed, 255 insertions(+), 5 deletions(-)
> create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
> create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h
>
>diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>index 56aa23aee472..9e0d9f710441 100644
>--- a/drivers/net/ethernet/intel/ice/Makefile
>+++ b/drivers/net/ethernet/intel/ice/Makefile
>@@ -32,6 +32,7 @@ ice-y := ice_main.o	\
> 	 ice_parser_rt.o \
> 	 ice_idc.o	\
> 	 devlink/devlink.o	\
>+	 devlink/health.o \
> 	 devlink/port.o \
> 	 ice_sf_eth.o	\
> 	 ice_sf_vsi_vlan_ops.o \
>diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
>new file mode 100644
>index 000000000000..984d910fc41d
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
>@@ -0,0 +1,192 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/* Copyright (c) 2024, Intel Corporation. */
>+
>+#include "health.h"
>+#include "ice.h"
>+
>+#define ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, obj, name) \
>+	devlink_fmsg_put(fmsg, #name, (obj)->name)
>+
>+/**
>+ * ice_devlink_health_report - boilerplate to call given @reporter
>+ *
>+ * @reporter: devlink health reporter to call, do nothing on NULL
>+ * @msg: message to pass up, "event name" is fine
>+ * @priv_ctx: typically some event struct
>+ */
>+static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
>+				      const char *msg, void *priv_ctx)
>+{
>+	if (!reporter)
>+		return;
>+
>+	/* We do not do auto recovering, so return value of the below function
>+	 * will always be 0, thus we do ignore it.
>+	 */
>+	devlink_health_report(reporter, msg, priv_ctx);
>+}
>+
>+/**
>+ * ice_fmsg_put_ptr - put hex value of pointer into fmsg
>+ *
>+ * @fmsg: devlink fmsg under construction
>+ * @name: name to pass
>+ * @ptr: 64 bit value to print as hex and put into fmsg
>+ */
>+static void ice_fmsg_put_ptr(struct devlink_fmsg *fmsg, const char *name,
>+			     void *ptr)
>+{
>+	char buf[sizeof(ptr) * 3];
>+
>+	sprintf(buf, "%p", ptr);
>+	devlink_fmsg_put(fmsg, name, buf);
>+}
>+
>+struct ice_tx_hang_event {
>+	u32 head;
>+	u32 intr;
>+	u16 vsi_num;
>+	u16 queue;
>+	u16 next_to_clean;
>+	u16 next_to_use;
>+	struct ice_tx_ring *tx_ring;
>+};
>+
>+static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>+				     struct devlink_fmsg *fmsg, void *priv_ctx,
>+				     struct netlink_ext_ack *extack)
>+{
>+	struct ice_tx_hang_event *event = priv_ctx;
>+	struct sk_buff *skb;
>+
>+	if (!event)
>+		return 0;
>+
>+	skb = event->tx_ring->tx_buf->skb;
>+	devlink_fmsg_obj_nest_start(fmsg);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, vsi_num);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
>+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
>+	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
>+	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
>+	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
>+	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);

Interesting. What is the kernel pointer put into the message good for?


>+	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>+				     event->tx_ring->count * sizeof(struct ice_tx_desc));
>+	devlink_fmsg_dump_skb(fmsg, skb);
>+	devlink_fmsg_obj_nest_end(fmsg);
>+
>+	return 0;
>+}
>+
>+void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
>+			     u16 vsi_num, u32 head, u32 intr)
>+{
>+	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
>+
>+	buf->tx_ring = tx_ring;
>+	buf->vsi_num = vsi_num;
>+	buf->head = head;
>+	buf->intr = intr;
>+}
>+
>+void ice_report_tx_hang(struct ice_pf *pf)
>+{
>+	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
>+	struct ice_tx_ring *tx_ring = buf->tx_ring;
>+
>+	struct ice_tx_hang_event ev = {
>+		.head = buf->head,
>+		.intr = buf->intr,
>+		.vsi_num = buf->vsi_num,
>+		.queue = tx_ring->q_index,
>+		.next_to_clean = tx_ring->next_to_clean,
>+		.next_to_use = tx_ring->next_to_use,
>+		.tx_ring = tx_ring,
>+	};
>+
>+	ice_devlink_health_report(pf->health_reporters.tx_hang, "Tx hang", &ev);
>+}
>+
>+static struct devlink_health_reporter *
>+ice_init_devlink_rep(struct ice_pf *pf,
>+		     const struct devlink_health_reporter_ops *ops)
>+{
>+	struct devlink *devlink = priv_to_devlink(pf);
>+	struct devlink_health_reporter *rep;
>+	const u64 graceful_period = 0;
>+
>+	rep = devl_health_reporter_create(devlink, ops, graceful_period, pf);

Why this is not per-port? devl_port_health_reporter_create()? Tx is
port-related thing, isn't it?

Someting like this is already implemented in mlx5:

auxiliary/mlx5_core.eth.1/131071:
  reporter tx
    state healthy error 0 recover 0 grace_period 500 auto_recover true auto_dump true
  reporter rx
    state healthy error 0 recover 0 grace_period 500 auto_recover true auto_dump true


See mlx5e_reporter_tx_timeout() for example.


>+	if (IS_ERR(rep)) {
>+		struct device *dev = ice_pf_to_dev(pf);
>+
>+		dev_err(dev, "failed to create devlink %s health report er",
>+			ops->name);
>+		return NULL;
>+	}
>+	return rep;
>+}
>+

[...]

