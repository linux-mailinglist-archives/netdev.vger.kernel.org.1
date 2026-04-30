Return-Path: <netdev+bounces-282949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLFGIaqJ82m74wEAu9opvQ
	(envelope-from <netdev+bounces-282949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 914624A6188
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 688953004D90
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BF36405A;
	Thu, 30 Apr 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRYN6usF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C727349B0A
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567721; cv=none; b=s6dSoEMmjdv4JhInfr5plFpCdlnGb0cvq4MR5fRY3IPIvyVqfoHlJfomiEk4wXAdj2qX7lea+Kf27qYYTmoXS1yi5bYNYbzY6M2lJQTIppHSVC7CaXGkA1lbBxxBaV3ied1vyBjb3kDLM5cUceAbsUq68Tf7btAL6rxMyriL64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567721; c=relaxed/simple;
	bh=GkpKU4XozAnfRNUYdiLmU+0WwjazJSknrwv6sd6JmSI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Iu8878knjv38+qlRAYXKZIbWs6fugoYFoWcK4TDvhmIOvDpccMX00oVWIF+p2l6Zu8ZIjFiX1bCtNlvT6TxvWF63LtfNUOazUZeMdjxw4/2JqN4/FajCDpIfwiqkoeNRTMPDx3V4P3gA5+C6Sflk0BGQICN+A7/dmOURQu9PL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRYN6usF; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8eabf08affaso285869785a.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777567719; x=1778172519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1FzJ5xY5z4LHiTKkrELilBbSkxF0ncX3ngziNIJZYdw=;
        b=ZRYN6usFSKzVLBKMnqVGysxmvXlYeLrmWT+M8PikWPJiXy+xxXqrNBvKJSOjlEqS79
         cLaeQZZF8rQIFpo2CxpaLHzxr19w/KYLIeaAuIxCX2Kl3xfZI7s/9RMnWR/nM2pxR5fO
         w4M/WrqRsPeTrZA7VGPaDhwW8Po4baAMKBgqVLID0urRpU0O3DnPZDtYyjF5eTHlUOBw
         ECTWwkj6aQo/YLZ1PSEIaDAuRNVY5YKINWH3OQoXzX1mEiollIqaN49ujfTETvAKvPmY
         3O6cM+IhlaZJlWEP2f9cFx7RFsH9/TpmjlxpaNY5A56s1AcUB+lQiwnZFCUf8jQO/0j4
         v+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567719; x=1778172519;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FzJ5xY5z4LHiTKkrELilBbSkxF0ncX3ngziNIJZYdw=;
        b=fRPdev6EtZN052Q/vntZxZYTmSss2NCUYHsjf+msLN4Ds3cLONVcR6pJqrsP794I3u
         Ch/TYJRzDSWWh7HGxGBbA882ysLHCCkyi97P1HTuqv0sqnR3/Vm1tgyUJ98U9XauLgU1
         0rDYmuJ+regeWr07/ltKWuGAHwuL8ph9Flzp4M2Nmk7zjMvBXy47D3BxZ/ev8elMqJhL
         nwP0kkDVlxAEMQgjUCgFWEvHFuQ5/6MyMm31klkzgPWfm9aB6lJoc50KlZR4dajKoQAq
         8BNfPCDC47VKfse7BhPj6H27Q0cEgN9DX5bm/YQQD3oEHO3BuOvyK4uQth4kSvR2HBAa
         O+6w==
X-Forwarded-Encrypted: i=1; AFNElJ8mpWE8c2vjWfhV4bP9AFVCytgl5bu3KpoRGuVu5G2CfSnm1vpAxGApkuXE7KqI1ga+DMaxt6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAOyWISpUvCT2C45rj9sr3P2lu5o6mo4TUNQd4SGuSc1786eF
	pIjvIxKmeBdmgDjsDFl0RoC1+/uIbhbX4Yu2MGxIq2iwhlKv+l8J4OFYUlGFXDfJlRsK2qguHEf
	HQfvJBpKCRVxbSw==
X-Received: from qkpc14.prod.google.com ([2002:a05:620a:268e:b0:8de:d98c:d163])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40c1:b0:8eb:73f6:b5a5 with SMTP id af79cd13be357-8fa89223971mr571142885a.44.1777567718592;
 Thu, 30 Apr 2026 09:48:38 -0700 (PDT)
Date: Thu, 30 Apr 2026 16:48:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430164836.872079-1-edumazet@google.com>
Subject: [PATCH net] ipv4: igmp: annotate data-races in igmp_heard_query()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+ae9a171f239b14485310@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 914624A6188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,ae9a171f239b14485310];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

Multiple cpus can run igmp_heard_query() concurrently.

Add missing READ_ONCE()/WRITE_ONCE() over following in_dev fields.

- mr_qrv
- mr_qi
- mr_qri
- mr_v1_seen
- mr_v2_seen

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+ae9a171f239b14485310@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69f38675.050a0220.3cbe47.0002.GAE@google.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/igmp.c | 58 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a674fb44ec25baf963dbaf9e72ccc45980b858b6..a9ad39064f3bb7fcfaace52448473f0425b2fa07 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -122,16 +122,29 @@
  * contradict to specs provided this delay is small enough.
  */
 
-#define IGMP_V1_SEEN(in_dev) \
-	(IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 1 || \
-	 IN_DEV_CONF_GET((in_dev), FORCE_IGMP_VERSION) == 1 || \
-	 ((in_dev)->mr_v1_seen && \
-	  time_before(jiffies, (in_dev)->mr_v1_seen)))
-#define IGMP_V2_SEEN(in_dev) \
-	(IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 2 || \
-	 IN_DEV_CONF_GET((in_dev), FORCE_IGMP_VERSION) == 2 || \
-	 ((in_dev)->mr_v2_seen && \
-	  time_before(jiffies, (in_dev)->mr_v2_seen)))
+static bool IGMP_V1_SEEN(const struct in_device *in_dev)
+{
+	unsigned long seen;
+
+	if (IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 1)
+		return true;
+	if (IN_DEV_CONF_GET((in_dev), FORCE_IGMP_VERSION) == 1)
+		return true;
+	seen = READ_ONCE(in_dev->mr_v1_seen);
+	return seen && time_before(jiffies, seen);
+}
+
+static bool IGMP_V2_SEEN(const struct in_device *in_dev)
+{
+	unsigned long seen;
+
+	if (IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 2)
+		return true;
+	if (IN_DEV_CONF_GET((in_dev), FORCE_IGMP_VERSION) == 2)
+		return true;
+	seen = READ_ONCE(in_dev->mr_v2_seen);
+	return seen && time_before(jiffies, seen);
+}
 
 static int unsolicited_report_interval(struct in_device *in_dev)
 {
@@ -954,23 +967,21 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 	int			max_delay;
 	int			mark = 0;
 	struct net		*net = dev_net(in_dev->dev);
-
+	unsigned long seen;
 
 	if (len == 8) {
+		seen = jiffies + READ_ONCE(in_dev->mr_qrv) * READ_ONCE(in_dev->mr_qi) +
+		       READ_ONCE(in_dev->mr_qri);
 		if (ih->code == 0) {
 			/* Alas, old v1 router presents here. */
 
 			max_delay = IGMP_QUERY_RESPONSE_INTERVAL;
-			in_dev->mr_v1_seen = jiffies +
-				(in_dev->mr_qrv * in_dev->mr_qi) +
-				in_dev->mr_qri;
+			WRITE_ONCE(in_dev->mr_v1_seen, seen);
 			group = 0;
 		} else {
 			/* v2 router present */
 			max_delay = ih->code*(HZ/IGMP_TIMER_SCALE);
-			in_dev->mr_v2_seen = jiffies +
-				(in_dev->mr_qrv * in_dev->mr_qi) +
-				in_dev->mr_qri;
+			WRITE_ONCE(in_dev->mr_v2_seen, seen);
 		}
 		/* cancel the interface change timer */
 		WRITE_ONCE(in_dev->mr_ifc_count, 0);
@@ -995,6 +1006,8 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 	} else { /* v3 */
+		unsigned long mr_qi;
+
 		if (!pskb_may_pull(skb, sizeof(struct igmpv3_query)))
 			return true;
 
@@ -1015,15 +1028,16 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * received value was zero, use the default or statically
 		 * configured value.
 		 */
-		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
-		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
-
+		WRITE_ONCE(in_dev->mr_qrv,
+			   ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv));
+		mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
+		WRITE_ONCE(in_dev->mr_qi, mr_qi);
 		/* RFC3376, 8.3. Query Response Interval:
 		 * The number of seconds represented by the [Query Response
 		 * Interval] must be less than the [Query Interval].
 		 */
-		if (in_dev->mr_qri >= in_dev->mr_qi)
-			in_dev->mr_qri = (in_dev->mr_qi/HZ - 1)*HZ;
+		if (READ_ONCE(in_dev->mr_qri) >= mr_qi)
+			WRITE_ONCE(in_dev->mr_qri, (mr_qi/HZ - 1) * HZ);
 
 		if (!group) { /* general query */
 			if (ih3->nsrcs)
-- 
2.54.0.545.g6539524ca2-goog


