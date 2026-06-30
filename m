Return-Path: <netdev+bounces-303098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J21FOnClQ2rkeAoAu9opvQ
	(envelope-from <netdev+bounces-303098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:16:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 716976E375A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZKXC4K1R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303098-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303098-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCD90325C10D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE640759B;
	Tue, 30 Jun 2026 11:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D184071E3
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:02:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817342; cv=none; b=noVhC+IUgEk2wwkw7KJttRws1JX9a3cpoR/iJx5zRiHCNcOXIDxh9RjjxNa8e/fa6D+FTB4QIXbyXlMyN1FYkcrN5Okc7PLsfsar72ggzjhr1pizotcxmQb+iLvvTNJEJ9NM6rzyPgSI7uXDP0f2YXccM3VV3ql507qbcs+YlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817342; c=relaxed/simple;
	bh=znty9fKu1I3j6mk8GJ7YhBLBxJh2skExwhcdv1n8kQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo8T75xtlKlRM8GOh25rFl0uxFjMuoku9pzc1SJHfCcOeb++mVbjYT93hP3pub94XX4Db9/QLHNKGAozTq2O0b+ES8ucRuG/Ln2z9Nh+qiEmH5vz2yoBwQUDz69wPw8tdD/QJbT0njB+DG99nkXlYOlzGK8TGGKGnWJZh0KLj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKXC4K1R; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so3334935ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817340; x=1783422140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6UKdS5fC0734haXSHmcnGsohuQh5WonZmb4ruRSjAQ=;
        b=ZKXC4K1RH7mdCysAGO3lDzrX8qgA5GRpPPIHODtDiU7eaEmC/zwaEh8uM8b8nYTfdZ
         9eVkn0Iq8fVH7U6izyyP1vRLL6jvV2d35bXkoHYnHQT9Ym6B71gQ8Me49WsmJuzMrHHH
         tx3dXeLJMdT+TCNURK8/pp/zNgd3PuGSn+uBWZGbsTTPN/jikPTVESKkroevNWMY/M3c
         eZ62RmyhaVfuaan4hu2fTlx8q04iiY0gPhl/TF7tyLqOuwqDyGVWMcKK2hRo7X/ojViA
         3138KhqJfmuq7b1cr7Z1J+oKkYc442WuMAolXSmgbA764XNH0p5B6uIAYMgtUdc2Y4xW
         gF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817340; x=1783422140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6UKdS5fC0734haXSHmcnGsohuQh5WonZmb4ruRSjAQ=;
        b=flU8tW/bVVEithSw9SIvr7y1nUc74d7Bh4HdEmaYvjwMUCsM4wkOfqI0gejDlibLH/
         lbpFEsk42woZoqJ1IpQDlT/DWmCoWlUzS7G1lwIosaBuaVltCs3/PUJb37ja/fPjMpas
         7o6zLuYhDZLXaDR+XXg08aytBskf1/UAlQmDbzgVvc4G/RjzC9CHtoA0WMOSeqoUkHvO
         R+jCoYLqGdGH33gfzyaC7818HbpfDhjyiZfs9rB54F6ztad3ZP425biX+iD4MfdakjDd
         WvpH9GIxiWq6e0NDOhP1V+D3YZtJi6FhPOIsfpdsGnxDRWDHY0X3MJ0D6u2bKTIONhlc
         DjQw==
X-Forwarded-Encrypted: i=1; AHgh+RrhMi7q6YKIij34e7Fu1/PuREcTi0SrYATldpSI2Iclt6WHs17/kPE0Oh97ZaEUS1cEZQEnev8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyen9xTpLoGYbtXUXQVgFDwkhE8Mv92j2u9CumONl6DY7X3kJ
	UKiiBmr3L87auF6vacm2y17iTWoSXAfp8Jk62bl5hYwVYyD4YHYJvM6I
X-Gm-Gg: AfdE7clHsyzx/FWpSZ0d47Hwu4MxFSMOyj+dSho7OCPY6x5eBLl/eJN7gEryoMcweCd
	vshJeZe6RIeDQmf0/oxQjj7N7NjLELRMXf1ckhqkh+V9x+GPL2RC7JqME9IZf3thp+kltQQEkyB
	y5sK/FH/t02smW7F2xcBPgQvdAPiTUU1//r1jMfp3HGPPRp4KTSvPS1JjM4UOt+qJvMUA2JSMCG
	D7IPNoTTfZWKQwN2rzQfjFg/xLv2yQ8F2NEo0gMvMMIiuLt43CaiusQW1XWAxZtBG/mbiwNppR3
	HM2QjlS7rNpyTivQIRKeZ3YdFmYneFsyXgtNwan2THniTDMJ5K20umwwTZV3USbia04YHGjnvm5
	4hIANz1BtiRvd2LP5IFxdfHsocPou2XFT2LXDIJ9cwWkiEAdyjO3Y00bsMfmtwb8+v08gNg/TCY
	8rNcBRKYRW28xUs+dK3bQuJhpo7v7nACqIkBYLR+mn
X-Received: by 2002:a17:902:f70f:b0:2ca:1114:3ac8 with SMTP id d9443c01a7336-2ca449ab595mr9725845ad.11.1782817339786;
        Tue, 30 Jun 2026 04:02:19 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:ae0d:35d1:dac9:a0e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a701b5sm11455265ad.17.2026.06.30.04.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:02:19 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] net: ipv4: report multicast group user count
Date: Tue, 30 Jun 2026 20:02:05 +0900
Message-ID: <20260630110207.37841-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630110207.37841-1-sigefriedhyy@gmail.com>
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 716976E375A

RTM_GETMULTICAST has been part of the rtnetlink ABI for a long time
and already reports IPv4 multicast group membership through
IFA_MULTICAST and IFA_CACHEINFO. It does not report how many consumers
hold each membership, so userspace still has to parse /proc/net/igmp to
get the Users column.

Add IFA_MC_USERS as a u32 attribute carrying ip_mc_list::users in
RTM_GETMULTICAST replies and entry-lifecycle notifications.

This gives iproute2 enough information to migrate the IPv4 part of
"ip maddr show" from procfs parsing to rtnetlink.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 4 ++++
 include/uapi/linux/if_addr.h             | 1 +
 net/ipv4/igmp.c                          | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 163a106c41bb..0ecbd24c890c 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -123,6 +123,9 @@ attribute-sets:
       -
         name: proto
         type: u8
+      -
+        name: mc-users
+        type: u32
 
 
 operations:
@@ -176,6 +179,7 @@ operations:
           value: 58
           attributes: &mcaddr-attrs
             - multicast
+            - mc-users
             - cacheinfo
       dump:
         request:
diff --git a/include/uapi/linux/if_addr.h b/include/uapi/linux/if_addr.h
index aa7958b4e41d..7fb630b7fe31 100644
--- a/include/uapi/linux/if_addr.h
+++ b/include/uapi/linux/if_addr.h
@@ -36,6 +36,7 @@ enum {
 	IFA_RT_PRIORITY,	/* u32, priority/metric for prefix route */
 	IFA_TARGET_NETNSID,
 	IFA_PROTO,		/* u8, address protocol */
+	IFA_MC_USERS,		/* u32, multicast group users */
 	__IFA_MAX,
 };
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c141..116ce7cec80e 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1473,6 +1473,7 @@ int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
 	ci.ifa_valid = INFINITY_LIFE_TIME;
 
 	if (nla_put_in_addr(skb, IFA_MULTICAST, im->multiaddr) < 0 ||
+	    nla_put_u32(skb, IFA_MC_USERS, READ_ONCE(im->users)) < 0 ||
 	    nla_put(skb, IFA_CACHEINFO, sizeof(ci), &ci) < 0) {
 		nlmsg_cancel(skb, nlh);
 		return -EMSGSIZE;
@@ -1494,6 +1495,7 @@ static void inet_ifmcaddr_notify(struct net_device *dev,
 
 	skb = nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
 			nla_total_size(sizeof(__be32)) +
+			nla_total_size(sizeof(u32)) +
 			nla_total_size(sizeof(struct ifa_cacheinfo)),
 			GFP_KERNEL);
 	if (!skb)
-- 
2.43.0


