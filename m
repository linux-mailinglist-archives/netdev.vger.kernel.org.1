Return-Path: <netdev+bounces-194752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB3ACC43A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1E316EF0C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C11531E3;
	Tue,  3 Jun 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jabPjZZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526654A0C;
	Tue,  3 Jun 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945979; cv=none; b=LwsulWR1QXn9L2+84HGPKWFIBFXEgDdWh+P6qaUhnsLHEe73hnYxTuZw4vwJ/mgdyVZ/v4y1SCIfDwPSd0ATvHIeTrFWNo3pqRa+eFb4ky124z9QUylSw1iqW/P7v0mQ7/bl23KNfX7XUnpPgPHMQqrPCRqY5YQJEJngQLtb/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945979; c=relaxed/simple;
	bh=PAhUoW4wFfW9zAsqJadOC30sXf3dehCXjxVbgX8JaMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT40Yh1nPp12YCwRVjGLwn8B9lpcu7R9vH0MsRXOo8oDyQoq6G7Y//btWzAAQ1smcqHwQzr2ngM6M1hq2/koUr42Ukzhvr4hmoTO3LgcyXfm6mNyzz6mNdU+FG6jLDotOZJ3R4OzfX70ehHIJ34NohGhuVBWmkG09z8RUtybBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jabPjZZg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso917764f8f.2;
        Tue, 03 Jun 2025 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748945975; x=1749550775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRyosMpxpGamF2C6lhKfiTpIH7op1n7yk0t4vAVTg5s=;
        b=jabPjZZgxa8ZJtroKZIfeit5alGxtilyeaOiBIHn+OFIaKsWGaEjwlvXcQ3Sw+RLtr
         PXf2IaClHT20UsFlDlk5f9QFmHHg91kX6jEvy0Agq9grTcU9D75qOyg02dbE5gmgLPBa
         ZbAlbkXoxPjjK9Rb0rD06oVSJdbvDG+kbT6WROIpe0Z9jH7K0TbFUa9cNVXcJQtpHctM
         fpf/Ti3AOFMWe/WRw1fnfrCjG5OSJBJlDhhMmEu6zmyOlbodYfxffCRu39mRWXZuG2YK
         Iu8s3Rg5sV8ZYVMh//Q5YqR5KraB1DKUqMHN4mGwS/Yme3V9sthzo6fSXfNPQDbmvRJ4
         TzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945975; x=1749550775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRyosMpxpGamF2C6lhKfiTpIH7op1n7yk0t4vAVTg5s=;
        b=EjeSJiMlv9tXfFzIMjzoOTf63c9Ieu6u3XE02F0RsvVlJnZ6pMxqZmEK0C9/pTF/27
         VSyb7OqSMFJ1Tn1cJd9N7lRXmqbkKDCQMSfYQgKgLyyiqVPmmgElYHQbKS3og2UsH0mV
         3t0F3H/s0tIRcd9KDUnnRd//3SMVzcIQVF3cC/Np3G9eKnsx3uFf1iZLCTf9eD5sqjfQ
         ibao3lxISwgj4ih/LBa2gleAQgpx8ZucisF1EVaqc65vTITHuaXs7eLzT734agtiILb5
         hfMlWwHtYNJp8wN4vwZGkuDAakiNjSJexQJr+TJ+mI+uvF1vXsxA7BkJEg1e8/QPvzsf
         cqNg==
X-Forwarded-Encrypted: i=1; AJvYcCUGOK8lgyPe2DfdSFLZfJpYrETIHZM7vHK/b27TOscoagww0HWCKnJq2LXi+noH3H51p3vu6utv@vger.kernel.org, AJvYcCWHpS4dq9kN1mRQP2pBb8mxylomUJ/8K220oc7eD3xm2UTqAtRBrpsqQ9DYHzOkdJS+4NMQ2IRqXaPGKOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wg52oHfRbwqHeS11SuuuVj4vbHXdagJi4QfwbTT1KxtyjGeE
	xiiVuyGJyGTOcq8dMcSwPLo2aXZ1ywwzptULkI5zbH6LDYXjJ7Qms6Yt
X-Gm-Gg: ASbGnctsoB7/3EPNGg4bV2tHDs4bXPaI4GhIej1JN/3bppU015094fTP+4/ApuxPAw5
	Rwz8aFOaah/Wpn0wbS6PbjNsHHTQYFe2+/2w0jZ7QY7oTrhj60M6Wq60dMhH7NFt9WkWzSGFKTW
	hC07qZFh9VY+EdTJOxOdh6XwcSj+h/dTyIHLxpkOgNSJ5H9bo/UEEzFz5bbMruuL01Xk0Nm2agV
	jRN/xjAGRE12BBjn/DV9NQEpvgOZ12Lxvc7K26FQHEXQEWmNRhGZ0OTCv/SFh/+kLP13twWBjmy
	1ioBjfeiUD0Aw+z+ec+pvR9nMAmK/a1i0oJlykmTjKYyPGDwWw==
X-Google-Smtp-Source: AGHT+IGeKbZmzZod6osApZaO46BOvVpdCEMFDwPFRZta3wOlLMFi4JOLZSIW2usprckf9A2HfTToGg==
X-Received: by 2002:a05:6000:25c8:b0:3a4:eed9:755b with SMTP id ffacd0b85a97d-3a4f8966a5bmr5146077f8f.4.1748945975312;
        Tue, 03 Jun 2025 03:19:35 -0700 (PDT)
Received: from skbuf ([86.127.125.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6d0dbsm17342901f8f.40.2025.06.03.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:19:34 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:19:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	jonas.gorski@gmail.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vivien.didelot@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [RFC PATCH 02/10] net: dsa: b53: prevent FAST_AGE access on
 BCM5325
Message-ID: <20250603101931.fgj3p46wkupjdrn4@skbuf>
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-3-noltari@gmail.com>
 <20250602093728.qp7gczoykrown34k@skbuf>
 <03565c9a-9345-4c1e-9c00-b16ed8acbcf5@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lwhczcmnpusi3ipa"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03565c9a-9345-4c1e-9c00-b16ed8acbcf5@broadcom.com>


--lwhczcmnpusi3ipa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 02, 2025 at 11:01:40AM -0700, Florian Fainelli wrote:
> On 6/2/25 02:37, Vladimir Oltean wrote:
> > Hello,
> > 
> > On Sat, May 31, 2025 at 12:13:00PM +0200, Álvaro Fernández Rojas wrote:
> > > BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
> > > writing them.
> > > 
> > > Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> > > Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> > > ---
> > 
> > How about implementing a "slow age" procedure instead? Walk through the
> > FDB, and delete the dynamically learned entries for the port?
> > 
> > Address aging is important for STP state transitions.
> 
> That's a good suggestion, I suppose for now this can be b53 specific until
> we encounter another 20 year old switch and then we move that logic within
> the DSA framework?
> -- 
> Florian

Hmm, thank you for saying that, I didn't even consider consolidating the
logic in the DSA framework, but it sure makes sense and we already have
almost all API required to do that.

So I now have a WIP patch attached, but the consolidation into the
framework is definitely a net-next activity, since it will also affect
mt7530, hellcreek and vsc73xx, and those need testing. Also, for b53 it
further requires changing the port_fast_age() prototype.

The question further becomes whether for stable kernels we should
implement a local slow age procedure in b53 like the one from sja1105,
only to delete it in net-next, or to skip it altogether, go with
Álvaro's patch as is and concentrate on the net-next implementation
directly. I'm ok both ways.

--lwhczcmnpusi3ipa
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-centralize-the-slow-aging-procedure-from-sja.patch"

From ceb0f0b25ecd3bae6629bbb74fe30f030ddd3a0a Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 3 Jun 2025 12:40:30 +0300
Subject: [PATCH] net: dsa: centralize the slow aging procedure from sja1105
 (WIP)

With more hardware drivers which are unable to perform a dynamic FDB
flush on a port (see
https://lore.kernel.org/netdev/20250531101308.155757-3-noltari@gmail.com/),
it makes sense to move the sja1105 logic to the framework level, so that
more drivers can flush out dynamically learned entries (relevant when
transitioning to a bridge port STP state incompatible with learning).

The drivers which have .port_fdb_dump() and .port_fdb_del() but not
.port_fast_age() are mt7530, hellcreek, vsc73xx. These will go through
dsa_port_slow_age() now.

TODO: multi-generational drivers like b53 cannot signal that old
hardware cannot do fast ageing and should fall back to
dsa_port_slow_age(), because they offer a single ds->ops->port_fast_age()
to the framework (which returns void), and the framework relies purely
on the presence of the function pointer to determine that the function
is implemented. We should change ds->ops->port_fast_age() to return int,
and treat -EOPNOTSUPP, so as to fall back to slow aging even in that
case.

Also, this change also has squashed the conversion of some function
prototypes from "struct dsa_port *" to "const struct dsa_port *", to be
compatible with the dsa_port_fast_age() caller where dp is a const
pointer. Eventualy, these changes should be split out into a preparatory
change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 53 --------------------------
 net/dsa/port.c                         | 50 +++++++++++++++++++++---
 net/dsa/port.h                         |  5 ++-
 3 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index f8454f3b6f9c..77faa43880ed 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1910,58 +1910,6 @@ static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static void sja1105_fast_age(struct dsa_switch *ds, int port)
-{
-	struct dsa_port *dp = dsa_to_port(ds, port);
-	struct sja1105_private *priv = ds->priv;
-	struct dsa_db db = {
-		.type = DSA_DB_BRIDGE,
-		.bridge = {
-			.dev = dsa_port_bridge_dev_get(dp),
-			.num = dsa_port_bridge_num_get(dp),
-		},
-	};
-	int i;
-
-	mutex_lock(&priv->fdb_lock);
-
-	for (i = 0; i < SJA1105_MAX_L2_LOOKUP_COUNT; i++) {
-		struct sja1105_l2_lookup_entry l2_lookup = {0};
-		u8 macaddr[ETH_ALEN];
-		int rc;
-
-		rc = sja1105_dynamic_config_read(priv, BLK_IDX_L2_LOOKUP,
-						 i, &l2_lookup);
-		/* No fdb entry at i, not an issue */
-		if (rc == -ENOENT)
-			continue;
-		if (rc) {
-			dev_err(ds->dev, "Failed to read FDB: %pe\n",
-				ERR_PTR(rc));
-			break;
-		}
-
-		if (!(l2_lookup.destports & BIT(port)))
-			continue;
-
-		/* Don't delete static FDB entries */
-		if (l2_lookup.lockeds)
-			continue;
-
-		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
-
-		rc = __sja1105_fdb_del(ds, port, macaddr, l2_lookup.vlanid, db);
-		if (rc) {
-			dev_err(ds->dev,
-				"Failed to delete FDB entry %pM vid %lld: %pe\n",
-				macaddr, l2_lookup.vlanid, ERR_PTR(rc));
-			break;
-		}
-	}
-
-	mutex_unlock(&priv->fdb_lock);
-}
-
 static int sja1105_mdb_add(struct dsa_switch *ds, int port,
 			   const struct switchdev_obj_port_mdb *mdb,
 			   struct dsa_db db)
@@ -3222,7 +3170,6 @@ static const struct dsa_switch_ops sja1105_switch_ops = {
 	.port_fdb_dump		= sja1105_fdb_dump,
 	.port_fdb_add		= sja1105_fdb_add,
 	.port_fdb_del		= sja1105_fdb_del,
-	.port_fast_age		= sja1105_fast_age,
 	.port_bridge_join	= sja1105_bridge_join,
 	.port_bridge_leave	= sja1105_bridge_leave,
 	.port_pre_bridge_flags	= sja1105_port_pre_bridge_flags,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 082573ae6864..2875bda2603f 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -52,14 +52,53 @@ static void dsa_port_notify_bridge_fdb_flush(const struct dsa_port *dp, u16 vid)
 				 brport_dev, &info.info, NULL);
 }
 
+struct dsa_port_slow_age_ctx {
+	const struct dsa_port *dp;
+};
+
+static int
+dsa_port_slow_age_entry(const unsigned char *addr, u16 vid,
+			bool is_static, void *data)
+{
+	struct dsa_port_slow_age_ctx *ctx = data;
+	const struct dsa_port *dp = ctx->dp;
+
+	if (is_static)
+		return 0;
+
+	dev_dbg(dp->ds->dev,
+		"Flushing dynamic FDB entry %pM vid %u on port %d\n",
+		addr, vid, dp->index);
+
+	return dsa_port_fdb_del(dp, addr, vid);
+}
+
+static int dsa_port_slow_age(const struct dsa_port *dp)
+{
+	struct dsa_port_slow_age_ctx ctx = {
+		.dp = dp,
+	};
+
+	return dsa_port_fdb_dump(dp, dsa_port_slow_age_entry, &ctx);
+}
+
 static void dsa_port_fast_age(const struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
+	int err = 0;
 
-	if (!ds->ops->port_fast_age)
-		return;
+	if (ds->ops->port_fast_age)
+		ds->ops->port_fast_age(ds, dp->index);
+	else
+		err = dsa_port_slow_age(dp);
 
-	ds->ops->port_fast_age(ds, dp->index);
+	if (err && err != -EOPNOTSUPP) {
+		dev_err(ds->dev,
+			"Port %d failed to age dynamic FDB entries: %pe\n",
+			dp->index, ERR_PTR(err));
+	}
+	if (err)
+		return;
 
 	/* flush all VLANs */
 	dsa_port_notify_bridge_fdb_flush(dp, 0);
@@ -996,7 +1035,7 @@ int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 	return dsa_port_notify(dp, DSA_NOTIFIER_FDB_ADD, &info);
 }
 
-int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
+int dsa_port_fdb_del(const struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
 	struct dsa_notifier_fdb_info info = {
@@ -1151,7 +1190,8 @@ int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 	return dsa_port_notify(dp, DSA_NOTIFIER_LAG_FDB_DEL, &info);
 }
 
-int dsa_port_fdb_dump(struct dsa_port *dp, dsa_fdb_dump_cb_t *cb, void *data)
+int dsa_port_fdb_dump(const struct dsa_port *dp, dsa_fdb_dump_cb_t *cb,
+		      void *data)
 {
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 6bc3291573c0..ea20ed6d706e 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -48,7 +48,7 @@ int dsa_port_vlan_msti(struct dsa_port *dp,
 int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
-int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
+int dsa_port_fdb_del(const struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 				     const unsigned char *addr, u16 vid);
@@ -62,7 +62,8 @@ int dsa_port_lag_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 			 u16 vid);
 int dsa_port_lag_fdb_del(struct dsa_port *dp, const unsigned char *addr,
 			 u16 vid);
-int dsa_port_fdb_dump(struct dsa_port *dp, dsa_fdb_dump_cb_t *cb, void *data);
+int dsa_port_fdb_dump(const struct dsa_port *dp, dsa_fdb_dump_cb_t *cb,
+		      void *data);
 int dsa_port_mdb_add(const struct dsa_port *dp,
 		     const struct switchdev_obj_port_mdb *mdb);
 int dsa_port_mdb_del(const struct dsa_port *dp,
-- 
2.43.0


--lwhczcmnpusi3ipa--

