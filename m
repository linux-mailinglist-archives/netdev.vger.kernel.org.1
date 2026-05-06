Return-Path: <netdev+bounces-284939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFqvKl9o+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068904DDE93
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 359A2300D33F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24749691C;
	Wed,  6 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="KqxrOusY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF6480DFD
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083918; cv=none; b=JH+eHe/vc/TzPuoeguZiL8+tZWzE/Uex7gIdVkXBsQeDLSk5CCYGaasc98/iYJfPLoPXvytNzT9DVlZgRwjjf+NX/nR/uMs7XkKQkMIjeIIeuCH9M6LzptDXSD3A1MEbQxKl0r/7oPV1IsujrUXUSTXKm053eOhc9UvT2+M2yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083918; c=relaxed/simple;
	bh=5D0WxI713FBvDeddEujw4c9zetJUmOcKk9K5e8cSEJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3PQWHWRVwTjjA7GafLmiG6FASmY+ugCOEFM3Ji0TND/m6Aw3YoYBsn6Ron1wdmqGeVVdS81M4oeioVFdv4fg25Ta4ga4F8Pv4N3x5AjVGrVlmogKBYZ4i9G0EWmJpLycnCkar4o+VLEqwb5t+pDjwrPQkzQ9wXKPcJ0pEVEA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=KqxrOusY; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso47994385e9.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1778083908; x=1778688708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyEs4dLj8iehL7vjvTrWPcDCPVxX9KcCGdrInqBS79o=;
        b=KqxrOusYc50INsJ7dO0pj0x1ZuL/beDHdaCkdSPqhaNtK9mjDfvsbF/mEygj004fT6
         6/nwixbBFgYn1g98YNw+D589FCzPG16AUM6KWBA02osvGxp/2/dfPokBXM8akOCRVQJf
         DEp/h8NfLV8Fc8ngbt36CP3ENWPPVd+qLQiOfZgNYObJlXRUzE6o9nT2+s/WkLZRU+Kg
         8t6TDaIElGL3nMT2EYhz3TtP93Kspej5kdvsjPZOSLBhJ8BL3mxYyfJZgKIm/rNWAgsG
         CZkxRKOGSNa6SDZCNb6bHc1EVnFdUdfYgZ1hb6RsuvGuWq1taw/kR7B4SqmbrhdGMVww
         sHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083908; x=1778688708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyEs4dLj8iehL7vjvTrWPcDCPVxX9KcCGdrInqBS79o=;
        b=akgz0cehogNiQQknX784dYzCqQZVn/hIjb3k87Zu+z1es3uoGAup0PFQ/4zZSwC3GV
         bRas9wUgUjFU0FOjm1VKsoooaWqJScwT4Ym7waxRbibDgohrHICOq4bZovc+dd8FQj4z
         fP7U5lTfQm7JbpRAcGd26Qv+k3HNj+0V28CwARCdnORbG5DnsKzsbIX9fnaf5f82+30n
         28LGAG27pO8qNJDRLOyQnyZkIU4CAL2bNcaYZWUdtunGFtmccxzW/y8ZzhsLl9jmlHLU
         98mmZkXNkXESPFLQ8insG6e8jheJPYDH7s7Hi8u0K4AKuro0MNtWJTQqlP5RRjsvrCE3
         EK1A==
X-Gm-Message-State: AOJu0Yx/kFkXN52BHczd1reSp9Jhs0ahGWFFkZVHWUu+mV1VeNeRwwOr
	wgdJzUwQw40zBifPmN/rb36fCNCXkeyRVGggoXzyX0VGrCZIIYoI6MrxoJO57sqdqiZBvSClIy/
	GdBl5v8ProdRbjF5ZVR/mMvQp3O0F4tvCUKKf
X-Gm-Gg: AeBDievQDe84ZlfHSymP1z+KbN28pshuRGpiKRQuK5SZURy82BYok/sN+obXNr5oI7C
	M8DQ0cX7HKVvqS4WqOBPNmSJJwqGhMelFLINaf4nyBQgCoMq6TJezaamJ0HTilEwPw+HZ6W/UVp
	aRheKYQprsF4eal2DcLOnEls8RhtTytCNXDr/g8aBNqIv85XfPsu5vcf+El3uHMLVK11t2pf+WJ
	4v8zTfy/G4I5Wia/pIpuN/PIHWr5OJXkAze5r4mDBS+LOtWL+nNRB4J4N9gCDygfTVSzHU53wxA
	hnZejDZCFB2DWn1GZIZgfSZDu5e8Ob8CDE84/O/FjFMHOKLYcH0Oo3bvqkM2nBWxXKR2L3DS1uF
	4z1xZ2bf5AUg5mDmYLncMSgIbEZkeebw7el0kuiwY7qm3GnC+iE5fKoHuXHcvI6g=
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48e51f24340mr48169735e9.8.1778083908186;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-48e538b4085sm1787275e9.3.2026.05.06.09.11.48;
        Wed, 06 May 2026 09:11:48 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 12E8A1755D;
	Wed,  6 May 2026 18:11:48 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v5 2/4] bonding: 3ad: fix carrier when no usable slaves
Date: Wed,  6 May 2026 18:11:42 +0200
Message-Id: <20260506161144.465485-3-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260506161144.465485-1-louis.scalbert@6wind.com>
References: <20260506161144.465485-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 068904DDE93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284939-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Apply the "lacp_strict" configuration from the previous commit.

"lacp_strict" mode "on" asserts that the bonding master carrier is up
only when at least 'min_links' slaves are in the Collecting_Distributing
state.

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c     | 21 ++++++++++++++++++++-
 drivers/net/bonding/bond_options.c |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index f0aa7d2f2171..1247a1e048df 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -745,6 +745,21 @@ static void __set_agg_ports_ready(struct aggregator *aggregator, int val)
 	}
 }
 
+static int __agg_usable_ports(struct aggregator *agg)
+{
+	struct port *port;
+	int valid = 0;
+
+	for (port = agg->lag_ports; port;
+	     port = port->next_port_in_aggregator) {
+		if (port->actor_oper_port_state & LACP_STATE_COLLECTING &&
+		    port->actor_oper_port_state & LACP_STATE_DISTRIBUTING)
+			valid++;
+	}
+
+	return valid;
+}
+
 static int __agg_active_ports(struct aggregator *agg)
 {
 	struct port *port;
@@ -2128,6 +2143,7 @@ static void ad_enable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__enable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs update */
 		*update_slave_arr = true;
 		/* Should notify peers if possible */
@@ -2151,6 +2167,7 @@ static void ad_disable_collecting_distributing(struct port *port,
 			  port->actor_port_number,
 			  aggregator->aggregator_identifier);
 		__disable_port(port);
+		bond_3ad_set_carrier(port->slave->bond);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
 	}
@@ -2830,7 +2847,9 @@ int bond_3ad_set_carrier(struct bonding *bond)
 	active = __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
 	if (active) {
 		/* are enough slaves available to consider link up? */
-		if (__agg_active_ports(active) < bond->params.min_links) {
+		if ((bond->params.lacp_strict ? __agg_usable_ports(active)
+					: __agg_active_ports(active)) <
+		    bond->params.min_links) {
 			if (netif_carrier_ok(bond->dev)) {
 				netif_carrier_off(bond->dev);
 				goto out;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index d358b831df77..94b7b0851f16 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1706,6 +1706,7 @@ static int bond_option_lacp_strict_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_strict = newval->value;
+	bond_3ad_set_carrier(bond);
 
 	return 0;
 }
-- 
2.39.2


