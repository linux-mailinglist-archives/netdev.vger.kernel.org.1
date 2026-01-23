Return-Path: <netdev+bounces-252591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNKKITnScmnKpgAAu9opvQ
	(envelope-from <netdev+bounces-252591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 465576F3CF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C1C5301683C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D737BE6A;
	Fri, 23 Jan 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOfE8wIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A5272E61
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132576; cv=none; b=lH91BAzGVAEGRR0id70VJzZ191S2SMVAHdeAG5bBPhctIroMbdBhewPcyx/pEbX3YS6X8KDyZid4Qfh5cYqyBObAiau8DAblutzy3to21wpOlNh8vN/frv8GZirAxlnLrwL1gTwmAB4iTDn6yEV/wJmQoZ0ALoEEfeqI63H7lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132576; c=relaxed/simple;
	bh=XgQZQFLyE+cZXfrumIA0EuNEWtSsCOWImP0qsgzSk5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6JEsORo0JKjbyncHueN+RcCKlJD6o/ZLLYs5D7XELps949qemX71QaeJMwCzgu+NWp7r2cZANMpBRjex2ob4Z83FIB9jiXQWvBO0VRqMdwj/06JlZtr6Fd5cCr3K4LGTLRlA+2aRmHucfcsDrEhvpjnrHvN47C+kZbsKwFn1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOfE8wIb; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12332910300so719527c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769132546; x=1769737346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uifsBKed8myajuNyljKie4CeDV4OXM0xUtAmhIR3vmg=;
        b=TOfE8wIbEcArpcrOJWAKo2lmXRiva9XZq55572B/R2Asi/go4G18GOZEEpWc22HirB
         lFzS1ATiH1joxa1AC7j/ADrMq1K9FavZQBmJ0ts/FTLt3oQ/23LvaTg0HTGO2Rtz+Qp4
         GXjXjt9QpluapX43lX0gy+6jZa2hGsajGobPnlEsrl6pus44+Ui/zvDUCFbxzFRi2DNp
         IfyRUc2VYnKImrm3ZaIzL1kBDqmPomCgH12LS2OWUbWe/tffTTlsfZp3wmMU/Q+YSGjM
         8zxjK8EkndYpPAq7lUaz3dyEI4LnIPZCoAdeeXL0meaMJqQF1ALtH+6ZKkdMILFA9lUA
         hQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769132546; x=1769737346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uifsBKed8myajuNyljKie4CeDV4OXM0xUtAmhIR3vmg=;
        b=aTHB6wfntxaCsnAuSQp8vs7uHkz3mxa0ld17oMXaZQ9dOiiATwvIMZfbqDnupy/nRx
         Z5wan310vvMycH7Ey6IeSYgIwPGgLY+BoSEXUwUzNfxR+J/J3hajB95j8lA87q38Dm3a
         h/Tz8siJB3Ak9urJFzNVWFt6Ox4SivWalIQdb7Vpd5pic00G/YZv79d2mRCy9X5befpJ
         VBfXq5tdvdbL6Jjn7Imn+4NiUeBge094LTXbj3FDQ9FvRyOVO2TpLkfpUaEJka892GM/
         NpYv+Xp65yDdGU6TFdVb2TVlvG/oOg23dBLDteeNSNN2nLw1g8nK6gk9igiHwayK5J10
         9E0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHdisrUhDTQESF2Mu9+MX0BfBgUECyh15Xl1NYQwuc37/jQkR3AaR+8WAaUU1cnDNe07hO3lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzn4zoKldlLQCGHGlvn/oeWKkC/N41IvAXSXnM9keXf5ivJqqo
	4Ku3+czkSDolhjwbzvgbZeYfX67QLAVaaLu1EzPPEWG8danwqB3++PyU
X-Gm-Gg: AZuq6aLkWm3p7pl2/hb7qfdWNWnVgdpbQQSghu6JP/9CDEETkJRkCTE7WBqGsCDEuT3
	4se2ln89zZLqeksuiLYUiGNF4NGtMr6qaumM1FMy+QDg9oTYyXVwnlD3IJsWYJalx0WRuqs+9Ap
	g7M3zSs9zLDK/xTEJLbCmSVBeAa2OPNI2VwzdgsMvKxGilqrxvZoP5hRD8rGooqpwG0VsMw1xG9
	w5mlYOczbhqMy9yywlIFFTeyQ7LFoD2N/e/RwytgQ6QVgUKk5wtRhgA+wN+3CZUxF+3SmbS/CyF
	eO5uL1xJDJsCAVXY3vF2jC9PxsZq1o2pXhwwRkAqD/GHme38nzPt9dXZzNwuhrMT00aFgDPp7vM
	URSl/QM7II4Y11XF4K32ZzCXFGKN6IYQAFnZRQYzw9lDt0P+aluQf5yavR53Gfs8=
X-Received: by 2002:a05:7022:e16:b0:123:345f:5d9c with SMTP id a92af1059eb24-1247dba58a2mr589486c88.2.1769132544457;
        Thu, 22 Jan 2026 17:42:24 -0800 (PST)
Received: from gmail.com ([2a09:bac1:19c0:20::4:33f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a44d8sm1770093c88.14.2026.01.22.17.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:42:24 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v3] ppp: enable TX scatter-gather
Date: Fri, 23 Jan 2026 09:42:13 +0800
Message-ID: <20260123014214.225278-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252591-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 465576F3CF
X-Rspamd-Action: no action

PPP channels using chan->direct_xmit prepend the PPP header to a skb and
call dev_queue_xmit() directly. In this mode the skb does not need to be
linear, but the PPP netdevice currently does not advertise
scatter-gather features, causing unnecessary linearization and
preventing GSO.

Enable NETIF_F_SG and NETIF_F_FRAGLIST on PPP devices and add an
.ndo_fix_features() callback to disable them when the underlying PPP
channel is not using direct_xmit (i.e. IFF_NO_QUEUE is not set in
priv_flags). This allows the networking core to pass non-linear skbs
directly only when it is safe to do so.

PPP compressors still require linear skbs, and their states can change
at runtime. In order to avoid races, instead of toggling features, call
skb_linearize() before passing buffers to them. Compressors are uncommon
on high-speed links, so this does not affect the fast path.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2 -> v3:
 toggle features only if the underlying ppp_channel changes. Call
  skb_linearize() if compressors are in use.
 - https://lore.kernel.org/linux-ppp/20251103031501.404141-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f9f0f16c41d1..d706a175cea9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1545,6 +1545,16 @@ ppp_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats64)
 	dev_fetch_sw_netstats(stats64, dev->tstats);
 }
 
+static netdev_features_t
+ppp_fix_features(struct net_device *dev, netdev_features_t features)
+{
+	/* Don't advertise SG/FRAGLIST when IFF_NO_QUEUE is absent */
+	if (!(dev->priv_flags & IFF_NO_QUEUE))
+		features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
+
+	return features;
+}
+
 static int ppp_dev_init(struct net_device *dev)
 {
 	struct ppp *ppp;
@@ -1619,6 +1629,7 @@ static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_start_xmit  = ppp_start_xmit,
 	.ndo_siocdevprivate = ppp_net_siocdevprivate,
 	.ndo_get_stats64 = ppp_get_stats64,
+	.ndo_fix_features = ppp_fix_features,
 	.ndo_fill_forward_path = ppp_fill_forward_path,
 };
 
@@ -1641,6 +1652,8 @@ static void ppp_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_destructor = ppp_dev_priv_destructor;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
+	dev->hw_features = dev->features;
 	netif_keep_dst(dev);
 }
 
@@ -1710,6 +1723,10 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		ppp->xcomp->comp_extra + ppp->dev->hard_header_len;
 	int compressor_skb_size = ppp->dev->mtu +
 		ppp->xcomp->comp_extra + PPP_HDRLEN;
+
+	if (skb_linearize(skb))
+		return NULL;
+
 	new_skb = alloc_skb(new_skb_size, GFP_ATOMIC);
 	if (!new_skb) {
 		if (net_ratelimit())
@@ -1797,6 +1814,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 	case PPP_IP:
 		if (!ppp->vj || (ppp->flags & SC_COMP_TCP) == 0)
 			break;
+
+		if (skb_linearize(skb))
+			goto drop;
+
 		/* try to do VJ TCP header compression */
 		new_skb = alloc_skb(skb->len + ppp->dev->hard_header_len - 2,
 				    GFP_ATOMIC);
@@ -3537,6 +3558,12 @@ ppp_connect_channel(struct channel *pch, int unit)
 	spin_unlock(&pch->upl);
  out:
 	mutex_unlock(&pn->all_ppp_mutex);
+	if (ret == 0) {
+		rtnl_lock();
+		netdev_update_features(ppp->dev);
+		rtnl_unlock();
+	}
+
 	return ret;
 }
 
-- 
2.43.0


