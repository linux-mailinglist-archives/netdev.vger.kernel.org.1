Return-Path: <netdev+bounces-123189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A367496402D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C95B1F25A3E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6EA18E352;
	Thu, 29 Aug 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrB2k8uW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC818E047
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923915; cv=none; b=mmcrlBxTMLLFbMzR0zWg0nTEiBju3EvL5kKOqCELLcp49J1TdMVi9X2P3NVDIwNiPwcGrAdNRh90zZbiiThX3PXnFHxMYLJOr438h6/Q15UgN2NueCyHbG+232xeEMe/O97C9wvURAvTHtFYCjhs2V82gPO7JpkFzg6uhMHADGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923915; c=relaxed/simple;
	bh=8g40356MkPjuZIWUbOwfIyP6ezuFvyDzC9eJ8+ejyiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1iVPgn2/fEBAuiwA+0Ez+dWQfFUlqEiluqw8ELsZxLNDXui6P50DpkYk/8GUw/R9BT02ZjwchhWQplvEYM61d8rL68mm2qWYD3NzvWFrDOnu4AJeQi7CsH7JLUElFw1jOd3SpDbewqKBrXQAvtMp/PbMeUqzge2cuoCAdOE2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrB2k8uW; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26fda13f898so295106fac.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923913; x=1725528713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJuN2WgVTPihSaeD+gIc0BwVQLvX8pr42m/aNkKE+GY=;
        b=mrB2k8uWsuWXo9RJrqTOV/jxW6QHIlTd6/exHmI0gzgCfxZTtaQwdyp7UUTPW+97AB
         JE/KUurtwSlc2pl8+AMLhaZ4ck4fbT6ctBsO4sEXrymWugMf4+dF48W6GqNoUMDRZVWC
         +8FGMtouc5ICnc6JfI0KqF8udALjOyfnEIcMpD4etIXLArToALM591foUTOgaN0RDYMq
         LbL5IBfJMv8qeg8m6jJ3i6tMDj705swydAQvfAOYsLJGj5fIG/v9XdIRkwISVRKPHqu4
         QiMeU7U+4RIgTDj33YVLhhT/frGGH7wPuIkzRKRzfH3Zdm3kiB5zke77ptaNudYsae1T
         LZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923913; x=1725528713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJuN2WgVTPihSaeD+gIc0BwVQLvX8pr42m/aNkKE+GY=;
        b=KmNzQn+NoH65lnv3QcPSMbRpvMwHhRSChubztFHxp7U3exwdtgNJYMdFKaFESTPcR9
         f6qGhX/IFn2GDNsexs3tIxkx0tok/rO60D5j4/F94WjVjodTeOP23IPyPl4tGkrmJvaC
         r6wvIM+YL6GwBa5eS0kL++kEB6jOu1REnYFCx7mHFS1i7VPADE7lGqBYsPdJQkYGnjUj
         ly07jZ4fkL0p3IIiNdlsowJmJIM+yN0pMK6OTu44TOoiTrWY9e9nf8pLtvEAhuUpMcVn
         n1JsmLF/FqDeCCB+eUxOCcc+NYes8D5txt9LslE/6JCTbHOy56+mWF3FVl1/E70To0pd
         EHEw==
X-Gm-Message-State: AOJu0YxYBeHGKrdpVthibMc/CaIhCo7iKJNNaY2YYu8wbokvOLBBM2UR
	/pInsJuZOOFKXoG2Bf0Ztq1ING97PgoybPZkPDKIjGyCPCj01xNWUbCDoPE51vBfaw==
X-Google-Smtp-Source: AGHT+IEwiZsluC8L8CFb5S9/BfwTEf8vfLG/Xd2tREk6SNs4ATLxfmWKQ4RurFbjw3jai8VsKODW7w==
X-Received: by 2002:a05:6871:24c5:b0:269:2708:aff6 with SMTP id 586e51a60fabf-277900cfd38mr2338339fac.16.1724923912752;
        Thu, 29 Aug 2024 02:31:52 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c417sm743276b3a.197.2024.08.29.02.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:31:52 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCHv6 net-next 2/3] bonding: Add ESN support to IPSec HW offload
Date: Thu, 29 Aug 2024 17:31:32 +0800
Message-ID: <20240829093133.2596049-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829093133.2596049-1-liuhangbin@gmail.com>
References: <20240829093133.2596049-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, users can see that bonding supports IPSec HW offload via ethtool.
However, this functionality does not work with NICs like Mellanox cards when
ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
supported. This patch adds ESN support to the bonding IPSec device offload,
ensuring proper functionality with NICs that support ESN.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4eb4d13fcec9..f0d479c95dd9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -648,10 +648,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return ok;
 }
 
+/**
+ * bond_advance_esn_state - ESN support for IPSec HW offload
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_advance_esn_state(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
+	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


