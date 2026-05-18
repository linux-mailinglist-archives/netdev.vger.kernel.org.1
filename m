Return-Path: <netdev+bounces-288860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCCOOjuqCmoK5gQAu9opvQ
	(envelope-from <netdev+bounces-288860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:57:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB05667A7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70169301026E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078723DCDAB;
	Mon, 18 May 2026 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="B8y1ajx7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DA3DCD8D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779083830; cv=none; b=QtS3OC1XLkc7NsogB+9axmfSh2XpEgLUGG4tj3Dy0rmwuNzaqAyGI75fyGBMt0weuTS0vaswsihHaqDGryzXxGaOcGrH6dBpR4fD2Whw2tIEb1AkCk/23NcgtPVyAT70kF/Fb63syqlGH2de8aP35JHC7jG9FeiYOMxNRIj822g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779083830; c=relaxed/simple;
	bh=dZgsj3svlkH/KZ6CkOn0pPVe9UUBaOaXE8i5DZxoDi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RXBPO6pe0AO7p9DLP0v3liqURcFm5peeBjhDTCFUKDLAkfnzmYLsVe/WDSl7QdxICJfEDcAT+2mYczBpaBSnhni8qAE4//9BbrTpstnxrhzN0JZINKtSbFHDk3WvX6tJchbjRd+HYPUNqfCQAWLV2TJUB+kvX83mMwt3gkdO/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=B8y1ajx7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8bb09239328so18052696d6.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1779083821; x=1779688621; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ulqQPlVV/y7BfD0xL+liiVg74f2HlR/Ki2I9yWqZnA=;
        b=B8y1ajx7BcjMcnQT7nxrqPDWLgmIox/VUycZcnAX9D3EXjZnh8hGysreEYxa+0OmbB
         S8AEa+faINs5l0jVpPzFoXrxOgzlJ81TolWRnPFWeBc91EoY+c+SpUCm8W6JpSUsdyre
         eSH4G/lXgf6Lcup2H/5GJj5hXo1zQ2jamjts+VspSoU5e/BtJ35AlEfUqc+lSc4HVdwG
         MzP2udak7wpQAGwoJH1PM24BXNc7jnM2/c00LIU8C9vEMVAAjitMYki1nycqegFL4dFM
         j5+4ADNwfWtYmRuFqsge3SpthNts2VqlFa1q7yExbx7aUYzpjo1R7J3EhjAJfSG9rqhb
         gjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779083821; x=1779688621;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ulqQPlVV/y7BfD0xL+liiVg74f2HlR/Ki2I9yWqZnA=;
        b=Wv5DA7B4JZZ235ENDpSCaDa4Q92q1eNpwtTUkmDrpm0AcVb8BdiuqN1a/xzAqO629u
         x9/iiOvgGKHftqPCCrpo1s6Amk2uGGeHWvSWHXxASNnVtmcfDFkpeklrkqVD1M7CbiMu
         R7O841m5Q5d6E2pwKt4OceSHz+21SF1yEgEIYqvzA++al0ZiAO/4lxfF9V/1Vbw8Tq2Y
         eOEzTKccF9AVPx8mF7sEPLMzsncpcybqj1xxpiT/hEcgejdRVwtsytu6ud2qG58lALEI
         DahmcUpHQ723qRimhGa4i2zghJbAc9iAbAoZWH7P6vIvAldGpcKeslyDHIQhe1PV6mRq
         /VdQ==
X-Gm-Message-State: AOJu0YwIvE68LhTbOpr7ntjJuiVIbrXlvTxwu2rXNYmc1zGSsjNP38hL
	mpbhAu1N6ymA55u+VNG/jjE9ZNpmoG5RwCQiVid0nPLAx7gqInQjN6XS9bFg7R7GIixe4BMWlBs
	MZacn
X-Gm-Gg: Acq92OHRgYcB4w+LDmUGv2AcjJGdcH6xPn1KXP6vEy4JvkrkFFix7FTxGSfW4oJXr7i
	zmUbQ4oU+x64hC0ko6ThOhVpbiw9x+ZhXJDNG768iHFVmJsKqqijkvKz7GR22OpdJiaWbuIlz0q
	UZMzhZssMsqPmiu6DDGtxv5XsPb1u8JqVJJtTNX4Qmag3XyrmvDsBYm/nlWiXHjYIO3mQw5ePkM
	5VM41jbwxh8dh7ozNuPzXK5uVjKvxUWXcpsmyAAUVIDqH32LNZlKI9hwzm9F1YBqpCaog/jKRln
	pjFC3CtftWF3JIXb29FO/eah1siUFqpyTQhg9r7pKUSUweLpBMk7iws41dejyS8XAXGWIwTDiGe
	mz8ILPCAiDNq5+e6sv+CoCPCB7qRdLIl/8mxjVkCxm3HDRtvGFtzYz8uLr1hhaMgk6UbFEtBF5H
	Iq5Nwor8EDHdIDiDyjvdSKA31xziBIv2HjLw1BhbLOUZdcuArBslrd
X-Received: by 2002:a05:6214:242b:b0:8bf:87c5:fa21 with SMTP id 6a1803df08f44-8ca0f706530mr255919346d6.49.1779083821544;
        Sun, 17 May 2026 22:57:01 -0700 (PDT)
Received: from juliahub.com ([66.31.114.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm45866836d6.4.2026.05.17.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 22:57:01 -0700 (PDT)
Date: Mon, 18 May 2026 01:56:59 -0400
From: Keno Fischer <keno@juliahub.com>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mlxsw: spectrum_dcb: Reject writes owned by an
 offloaded qdisc
Message-ID: <agqqK_6PxbvAwsMX@juliahub.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 6ECB05667A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[juliahub.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[juliahub.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[juliahub.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-288860-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keno@juliahub.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,juliahub.com:email,juliahub.com:mid,juliahub.com:dkim]
X-Rspamd-Action: no action

Some bits of state in the mlxsw driver can be controlled by two
mechanisms. The first is the DCB netlink command set (RTM_SETDCB
and e.g. DCB_ATTR_IEEE_ETS/DCB_ATTR_IEEE_MAXRATE), reachable e.g. from
the `dcb` userspace utility. The second is via the qdisc framework
(reachable e.g. from the `tc` userspace utility). Because they touch
the same bit of state, it is currently possible for the ETS config
to get out of sync with what the qdisc expects. One hard-to-debug
consequence is that a config script becomes non-idempotent. E.g.,
consider

```
dcb ets set dev "${port}" prio-tc 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
tc qdisc replace dev "${port}" root handle 1: prio bands 8 \
	priomap 0 1 2 3 4 5 6 7
```

Here the user made a mistake and put the priomap in the wrong order.
The first time this code is run, the `qdisc` specification overwrites
the `prio-tc` specification. However, the second time this code is run,
the subsystem sees that the qdisc is identical and does nothing, causing
the `prio-tc` setting to stick and the final mapping to be different.
This can be very confusing, since the same config script creates two
different states.

I think there's two reasonable ways to fix this. One would be by
reflecting the ets state changes back into the qdisc, so that the
qdisc subsystem notices that it's been changed. However, I think it
is clearer to just forbid the non-qdisc API from trying to make
changes while the qdisc is offloaded.

This is similar to the existing check in mlxsw_sp_dcbnl_setbuffer,
which does essentially the same thing in reverse (buffers are only
explicitly managed when there is an offloaded qdisc, otherwise
they're managed explicitly).

I hope this saves the next person a few hours of debugging wondering
why their tc_no_buffer_discard_uc_tc_ counters are going up.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Keno Fischer <keno@juliahub.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 +
 .../ethernet/mellanox/mlxsw/spectrum_dcb.c    | 10 +++++
 .../ethernet/mellanox/mlxsw/spectrum_qdisc.c  | 43 +++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index b03ff9e044f9..ecf4525c42a4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -1260,6 +1260,8 @@ int mlxsw_sp_setup_tc_block_qevent_early_drop(struct mlxsw_sp_port *mlxsw_sp_por
 					      struct flow_block_offload *f);
 int mlxsw_sp_setup_tc_block_qevent_mark(struct mlxsw_sp_port *mlxsw_sp_port,
 					struct flow_block_offload *f);
+bool mlxsw_sp_qdisc_has_prio_ets(struct mlxsw_sp_port *mlxsw_sp_port);
+bool mlxsw_sp_qdisc_has_tbf_subgroup(struct mlxsw_sp_port *mlxsw_sp_port);
 
 /* spectrum_fid.c */
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
index f1ad937405a3..6e689d5de6fa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
@@ -151,6 +151,11 @@ static int mlxsw_sp_dcbnl_ieee_setets(struct net_device *dev,
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 	int err;
 
+	if (mlxsw_sp_qdisc_has_prio_ets(mlxsw_sp_port)) {
+		netdev_err(dev, "ETS configuration is controlled by offloaded qdisc\n");
+		return -EBUSY;
+	}
+
 	err = mlxsw_sp_port_ets_validate(mlxsw_sp_port, ets);
 	if (err)
 		return err;
@@ -450,6 +455,11 @@ static int mlxsw_sp_dcbnl_ieee_setmaxrate(struct net_device *dev,
 	struct ieee_maxrate *my_maxrate = mlxsw_sp_port->dcb.maxrate;
 	int err, i;
 
+	if (mlxsw_sp_qdisc_has_tbf_subgroup(mlxsw_sp_port)) {
+		netdev_err(dev, "maxrate is controlled by offloaded qdisc\n");
+		return -EBUSY;
+	}
+
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
 		err = mlxsw_sp_port_ets_maxrate_set(mlxsw_sp_port,
 						    MLXSW_REG_QEEC_HR_SUBGROUP,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
index 73519301b744..c2ce4f3f562e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
@@ -2316,6 +2316,49 @@ int mlxsw_sp_setup_tc_block_qevent_mark(struct mlxsw_sp_port *mlxsw_sp_port,
 					      action_mask);
 }
 
+bool mlxsw_sp_qdisc_has_prio_ets(struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	struct mlxsw_sp_qdisc_state *qdisc_state = mlxsw_sp_port->qdisc;
+	struct mlxsw_sp_qdisc *root_qdisc;
+	bool found;
+
+	mutex_lock(&qdisc_state->lock);
+	root_qdisc = &qdisc_state->root_qdisc;
+	found = root_qdisc->ops &&
+		    (root_qdisc->ops->type == MLXSW_SP_QDISC_PRIO ||
+		     root_qdisc->ops->type == MLXSW_SP_QDISC_ETS);
+	mutex_unlock(&qdisc_state->lock);
+
+	return found;
+}
+
+static struct mlxsw_sp_qdisc *
+mlxsw_sp_qdisc_walk_cb_find_subgroup_tbf(struct mlxsw_sp_qdisc *qdisc,
+					 void *data)
+{
+	struct mlxsw_sp_port *mlxsw_sp_port = (struct mlxsw_sp_port *)data;
+
+	if (qdisc->ops && qdisc->ops->type == MLXSW_SP_QDISC_TBF &&
+	    mlxsw_sp_qdisc_tbf_hr(mlxsw_sp_port, qdisc) ==
+	    MLXSW_REG_QEEC_HR_SUBGROUP)
+		return qdisc;
+	return NULL;
+}
+
+bool mlxsw_sp_qdisc_has_tbf_subgroup(struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	struct mlxsw_sp_qdisc_state *qdisc_state = mlxsw_sp_port->qdisc;
+	bool found;
+
+	mutex_lock(&qdisc_state->lock);
+	found = mlxsw_sp_qdisc_walk(&qdisc_state->root_qdisc,
+				    mlxsw_sp_qdisc_walk_cb_find_subgroup_tbf,
+				    mlxsw_sp_port) != NULL;
+	mutex_unlock(&qdisc_state->lock);
+
+	return found;
+}
+
 int mlxsw_sp_tc_qdisc_init(struct mlxsw_sp_port *mlxsw_sp_port)
 {
 	struct mlxsw_sp_qdisc_state *qdisc_state;
-- 
2.54.0


