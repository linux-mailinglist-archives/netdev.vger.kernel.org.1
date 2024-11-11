Return-Path: <netdev+bounces-143623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA29C3622
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FA31F21270
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDB413D520;
	Mon, 11 Nov 2024 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DULgE7Du"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645822EED
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288760; cv=none; b=qehdzVe/1E1M0qa82/amwRAyZcOggmYp/Vtbq+ujsRylGECIjN1yNlXet1r2IKsPmWDlvWYjqZXRhOI+0sgT2ueMKin0tPE6ZcXk2CSz+B5HHibF2n/mbsRdhD3xH42lXwDtxRQAf4tKOorPlJqJrclFcykFI3JbcFM4l4yKh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288760; c=relaxed/simple;
	bh=GWjzpgXH45K95bMUM20LixJD6wKYYxknr/0q9jOAuXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HevZ0aP3d7fl/MDv1djf4ZeubcXrjoe1btGV/FoGyaSbPqQXlNXdeGPegqbHVLEPATmvz4wIR6paFhYVg88quroOMpp3pDPDNdlxlouif1q2mWboYw0SlVXnLJePvor7NMmNE8F0TM/1UYDhNzlV6eVWWRyjjQ0uPQymRVE6U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DULgE7Du; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3BE9B2C06BE;
	Mon, 11 Nov 2024 14:32:31 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731288751;
	bh=vZiZ+3bz/6/Wnjuj2iYX3hKDfgcWmeQhZAMrYtVLEP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DULgE7DuEKPdrEah0QBCNxEq0MVW2yOcOkHqXnYnNFaGDJFrY8SjPmctsPxgrWC1a
	 pnWswVBbaf5KJD230vcavDtKPvjG1pLOoe36KqTwhC+V9NeOR8hceVgFQYo35/H8EW
	 0mFmxLC5+LDzuXWftCw1q9eb5NUU2bs0wvf/ys56SI5V+okKcVCgbT9W/63CC0guYl
	 mBt3h0jCUPrygPDHjkkDOPgrKYwjnU+TaouHIS16X58lKrxva4xQkugrnmYd+sLVxI
	 lcqnap2YYrQPr9OlLwEtYVqBe99Hm2sS9G0Ft6ByXf3cPXhyabm4MmPJyxIkmJHemQ
	 haLL69fkvi2VQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67315eaf0000>; Mon, 11 Nov 2024 14:32:31 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 10F8513ECD2;
	Mon, 11 Nov 2024 14:32:31 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 110FF2A151C; Mon, 11 Nov 2024 14:32:31 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC net-next v0 2/2] net: dsa: add option for bridge port HW offload
Date: Mon, 11 Nov 2024 14:32:17 +1300
Message-ID: <20241111013218.1491641-3-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67315eaf a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=sVghOlvp1KO_yCYPZfwA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Currently the DSA framework will HW offload any bridge port if there is
a driver available to support HW offloading. This may not always be the
preferred case.

In cases where the ports on the switch chip are being used as purely L3
interfaces, it is preferred that every packet hits the CPU. In the case
where these ports are added to a bridge, there is a likelihood of
packets completely bypassing the CPU and being switched. This scenario
will occur when a L3 port is added to bridge with an L2/L3 port, and both
ports happen to be attached to the CPU via a switch-chip. This will
result in the switch chip bridging traffic in hardware, where in some
cases it would be preferred that packets entering the L3 port always hit
the CPU, for various userland operations like packet inspection etc.

To prevent this, make the DSA framework aware of the devlink port
function attr, bridge_offload, and add a matching field to the port
struct. Add get/set functions to configure the field, and read the field
when adding a port to a bridge in HW.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 include/net/dsa.h |  1 +
 net/dsa/devlink.c | 27 ++++++++++++++++++++++++++-
 net/dsa/dsa.c     |  1 +
 net/dsa/port.c    |  3 ++-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 72ae65e7246a..32ed8b36f06b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -291,6 +291,7 @@ struct dsa_port {
=20
 	struct device_node	*dn;
 	unsigned int		ageing_time;
+	bool bridge_offloading;
=20
 	struct dsa_bridge	*bridge;
 	struct devlink_port	devlink_port;
diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index f41f9fc2194e..dc98e5311921 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -298,6 +298,31 @@ void dsa_devlink_region_destroy(struct devlink_regio=
n *region)
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_region_destroy);
=20
+static void
+dsa_devlink_port_bridge_offload_get(struct devlink_port *dlp,
+				    bool *is_enable)
+{
+	struct dsa_port *dp =3D dsa_to_port(dsa_devlink_port_to_ds(dlp),
+					  dsa_devlink_port_to_port(dlp));
+
+	*is_enable =3D dp->bridge_offloading;
+}
+
+static void
+dsa_devlink_port_bridge_offload_set(struct devlink_port *dlp,
+				    bool enable)
+{
+	struct dsa_port *dp =3D dsa_to_port(dsa_devlink_port_to_ds(dlp),
+					  dsa_devlink_port_to_port(dlp));
+
+	dp->bridge_offloading =3D enable;
+}
+
+static const struct devlink_port_ops dsa_devlink_port_ops =3D {
+	.port_fn_bridge_offload_get =3D dsa_devlink_port_bridge_offload_get,
+	.port_fn_bridge_offload_set =3D dsa_devlink_port_bridge_offload_set,
+};
+
 int dsa_port_devlink_setup(struct dsa_port *dp)
 {
 	struct devlink_port *dlp =3D &dp->devlink_port;
@@ -341,7 +366,7 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
 	}
=20
 	devlink_port_attrs_set(dlp, &attrs);
-	err =3D devlink_port_register(dl, dlp, dp->index);
+	err =3D devlink_port_register_with_ops(dl, dlp, dp->index, &dsa_devlink=
_port_ops);
 	if (err) {
 		if (ds->ops->port_teardown)
 			ds->ops->port_teardown(ds, dp->index);
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5a7c0e565a89..20cf55bd42db 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -529,6 +529,7 @@ static int dsa_port_setup(struct dsa_port *dp)
 		return err;
 	}
=20
+	dp->bridge_offloading =3D true;
 	dp->setup =3D true;
=20
 	return 0;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index ee0aaec4c8e0..de5908495287 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -493,7 +493,8 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct =
net_device *br,
 	struct net_device *brport_dev;
 	int err;
=20
-	if (br_mst_enabled(br) && !dsa_port_supports_mst(dp))
+	if ((br_mst_enabled(br) && !dsa_port_supports_mst(dp)) ||
+	    !dp->bridge_offloading)
 		return -EOPNOTSUPP;
=20
 	/* Here the interface is already bridged. Reflect the current
--=20
2.47.0


