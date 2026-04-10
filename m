Return-Path: <netdev+bounces-277262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLs9MBaW2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C83413D2A52
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0881300EC4B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA335AC27;
	Fri, 10 Apr 2026 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SEYZUIFR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6C346AFB;
	Fri, 10 Apr 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801870; cv=none; b=k7ZkWmp9TG+nAFDMEFqo/JAKBT19P+Sao+7UkYduDVow2FmKGsDfgAx1HZXY6a/Tdt/LwtFzw+FjDq9mmbz5E73TYfU2wEen/66mloxAGkJuC5Gk59BpqU1oS7eGH8HwtMCLNIUMUJp60ZM0d+28gAZsoYLW2rr08srwdp3ArkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801870; c=relaxed/simple;
	bh=k7Bl40ND0izrraTo2iqYR9VWnNM9qb0c1MGMEVehBv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQu/6kDzmBD4Ll6Osq+/efzHK/8bMVEFcAb+cLSzqt52sM8n75E5/WrjygXbksxE6N2/PacsibaIbHN654pDrxtd40I4Q2UsrmncO6rH8bk+ORBT1+74L/dZhaf6oO+WfllUqyBKe4Ekv2XJwTH9WkZAhpw62JY68egnxer+EFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SEYZUIFR; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eP
	lj0l3Pj4+bjFqZ6o5saRtTsk6tAaSXaEymjlhAFEA=; b=SEYZUIFRvUlOyUnziw
	cz7+zYkZh2aARduBXPkN4S0EkW4aa3Q5hIsJPOEFz9DGcORzjT2C6PjxZxhmBA/d
	cCOU3misgjHasRsR3yRBEFDzuVDcB8S4+OPTJ4Eg0+e2HecN1f7Tcs/igUv+t25a
	9Nr2B2pdqrFx9GGff+bwukmVA=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3B_nhldhpioNMBA--.57048S3;
	Fri, 10 Apr 2026 14:17:13 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: jk@codeconstruct.com.au
Cc: yuanzhaoming901030@126.com,
	yuanzm2@lenovo.com,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH next-next v2] net:mctp: fix setting mctp hdr ver reserved field cause  data dropped
Date: Fri, 10 Apr 2026 14:17:03 +0800
Message-Id: <20260410061703.3547-2-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410061703.3547-1-yuanzhaoming901030@126.com>
References: <ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
 <20260410061703.3547-1-yuanzhaoming901030@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B_nhldhpioNMBA--.57048S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW8Gw1UKrW8XFWkGFyUWrg_yoW8Cw4UpF
	1DKrW09rWkKFW2gr4kAaykXanYg3s8Ka4Uur4Sgw40qwnxXr18GFWIkr1UJw18urZ7KF93
	JrWY9w1UJw47XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzOJ5UUUUU=
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBsQkwO2nYlelHEwAA3q
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277262-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[126.com,lenovo.com,codeconstruct.com.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[126.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuanzhaoming901030@126.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C83413D2A52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuan Zhaoming <yuanzm2@lenovo.com>

from spec dsp0236_1.2.1.pdf page 26, the mctp header contains the
RSVD(4bit) and Hdr version(4 bit).

mctp_pkttype_receive invoke mctp_hdr, and get mh->ver whole byte 
compare the MCTP_VER_MIN, MCTP_VER_MAX. the reserver bits may be by 
misleading used.

one type hba card will set pcie vdm header Pad Len the same with RSVD
bit, this will not work on mctp kernel solution.

Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>

---
 include/net/mctp.h | 1 +
 net/mctp/route.c   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index f481007a6..1392fafe7 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -35,6 +35,7 @@ struct mctp_hdr {
 #define MCTP_HDR_SEQ_MASK	GENMASK(1, 0)
 #define MCTP_HDR_TAG_SHIFT	0
 #define MCTP_HDR_TAG_MASK	GENMASK(2, 0)
+#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
 
 #define MCTP_INITIAL_DEFAULT_NET	1
 
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 56c441e90..aa0e89d67 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -464,7 +464,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 	netid = mctp_cb(skb)->net;
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	if (((mh->ver & MCTP_HDR_VER_MASK)) < MCTP_VER_MIN || (mh->ver & MCTP_HDR_VER_MASK) > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -1345,7 +1345,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	if (((mh->ver & MCTP_HDR_VER_MASK)) < MCTP_VER_MIN || (mh->ver & MCTP_HDR_VER_MASK) > MCTP_VER_MAX)
 		goto err_drop;
 
 	/* source must be valid unicast or null; drop reserved ranges and
-- 
2.43.0


