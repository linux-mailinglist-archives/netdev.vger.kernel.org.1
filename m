Return-Path: <netdev+bounces-272589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mETsCWqQxmkyMAUAu9opvQ
	(envelope-from <netdev+bounces-272589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:12:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90687345D72
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 119D43065F02
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E56228CA9;
	Fri, 27 Mar 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Wsnwd2nW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EC2475CE
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620481; cv=none; b=nW50xyT944p+Cv8yHIGNVxLxR0eHjDnMtVs1XZytdLc1TY12iKD2TgvwDQSSwUQFISDFReNrFqCkbfWMtTjhAXmHiL2WDyh66zA8vw9eJyhUkXNZ464h3SE4RsuE7kr992KIuV+Rc17hknOgKkFGvF198sR+t/0DQQMGWYJG4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620481; c=relaxed/simple;
	bh=rRksI+m2mi8t2pFy0Z2QaKiRCaMZ8dF+KrcPUDEGuno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPdZEnuM34Mxp96if5Dcqa85v73irsuTaKrI1rsiA1IxcOKj1BtYq/QvrI6HgiqWvy1VtSfXbFIr+RCdis5Af3Qay2FC5a7SGc2Nl25t1tm4xOTvCXOqf0AZ2i10RzQ989fx778Zom6XNiA+3xMt4fnpVomAwFFmHjYLSH8o1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Wsnwd2nW; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-43b8822fc05so319586f8f.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774620478; x=1775225278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVSt++haksPJKg0vq+e2Vr65n3ZppEcs5oP+RaopyJU=;
        b=Wsnwd2nWtOGAambFUx96Q3F/ZEFjr3NnQY5k+Qr9xGJ5IHU00ROROPprALdQl7Qae6
         lvYKdgYbOSu4ZJwZhe43b/FEwfDFKf5i3r7oaqdtHdYllrqPhN8yVqC+y7vT68xe9l8f
         NM/2cOCZwUrl9Tk5fhjYS7rzsJ49wfzv3AGlAHgtzlG5VLPMw1NV5wE0H8sDDjrflmDY
         sZn3shT5rjB5OEwOZRDhqpByVeKdsOipXqVVo0fez2p4COKq9U9YckcxomlDAJSwCdjE
         dWS7+ePxZj5GEr1yzyTx8B9i0UUdYJg/0MlGRwpeEO9lbI8YwRZVkeIwmonZpf2WjcE7
         tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620478; x=1775225278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVSt++haksPJKg0vq+e2Vr65n3ZppEcs5oP+RaopyJU=;
        b=VUeBXoigGN8MdzxARAi0GphG11kFYa1cQCvJpqGaedl87vkuQpBlWPetptZVpeHF/9
         LNPpThbf9FLRebjqwUM5rtnCxI8NEqakJqaw4CIVdziihLyfPKfVaoEggXQX7HLUW53X
         vxOeP18sgRjSXAl4bKAT1mbnntaQS7aPhX3qDhkPYdh9qpMi0IeGtJxxP8orQ7Yl7A85
         bmEIKsFeJ2fPKJ8ZsdJqaY8oIz6AuiP/4QIF2pfb69qIxazQ36eXA5tRic74DAOV80BT
         L6dXp2CtWwVqapaMng921qXUzvYJHwWemxL+yGissaiULxEFv1DZplhyQdME/ukgE4Kj
         YEKg==
X-Gm-Message-State: AOJu0Yx8wzHQY10H3KKaPUvtrbDfWmYQkYOUROfH9R+M6BHViBowXzNM
	IDcFd0KTjA3xQRusNh+LouBwNc+M6bZJkIa48GzLIzK/uglcB3cSWv5HHuqlyGgR3DEegoQt2ZD
	+i9IeGSLnyJqZK45Mt/NdorDiUbxOJzpwL8Wi
X-Gm-Gg: ATEYQzy/wLsgFNWwiu1Sz5/fAvFXUgv2S/wUPWTQH2FGIIDgfAeuZcEcEWZHhwcMaRX
	L9Y4O7LQKJt7gGWWdGJfV5Z1JOfqBQ8+5rJd8L0yLOFRu/U3GGYw8vC41Chc+sSCW0biiHbuIWC
	OjxbA/WgnoEtmzie0pIj6llkqpwz7y/Fxe1w4gHSvVvz+ai+hbyqZY6aLj6djoirkNQ+3EA8IvX
	NbIRTA5K9+wmcSBKF2NIys7JhPiROTHrRZa4uf8UneoDBXlWl8JxGqje3flvfXzT4vAZVdtSSuL
	rz9Z5S5mdR9PsrnRtalqMyExfx9P3ipzoT+3nm727tsQsc4/G6yppDrDMP090GQmDJakzo+c3n9
	JfqhtM/WMetBu1TKmxCdJZL4hTKnt/1lM5elZCzgdY+8eTgRoDXwIcQKTq66UiuwobgMQCAb2xw
	vn
X-Received: by 2002:a05:600c:b99:b0:487:1826:e13b with SMTP id 5b1f17b1804b1-48727f2d001mr25037005e9.2.1774620477778;
        Fri, 27 Mar 2026 07:07:57 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-48722c8473csm3783455e9.1.2026.03.27.07.07.57;
        Fri, 27 Mar 2026 07:07:57 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 9C9E5205D4;
	Fri, 27 Mar 2026 15:07:57 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1w67qv-0041jf-CI; Fri, 27 Mar 2026 15:07:57 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [RFC PATCH iproute2-next] seg6: add support of 'nh-vrf' flag
Date: Fri, 27 Mar 2026 15:07:39 +0100
Message-ID: <20260327140755.959928-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272589-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 90687345D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This new flag enables to have x-vrf routes.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---

A formal submission will be done once the kernel patch is merged.

 include/uapi/linux/seg6_iptunnel.h |  2 ++
 ip/iproute_lwtunnel.c              | 10 ++++++++++
 man/man8/ip-route.8.in             |  9 ++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
index e1929d21c0b6..81e5c699d157 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -20,6 +20,8 @@
 enum {
 	SEG6_IPTUNNEL_UNSPEC,
 	SEG6_IPTUNNEL_SRH,
+	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
+	SEG6_IPTUNNEL_NH_VRF,
 	__SEG6_IPTUNNEL_MAX,
 };
 #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index a7885dba28c1..e6a61c0d5046 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -267,6 +267,9 @@ static void print_encap_seg6(FILE *fp, struct rtattr *encap)
 		     "mode %s ", format_seg6mode_type(tuninfo->mode));
 
 	print_srh(fp, tuninfo->srh);
+
+	if (tb[SEG6_IPTUNNEL_NH_VRF])
+		print_string(PRINT_ANY, NULL, "%s ", "nh-vrf");
 }
 
 static void print_rpl_srh(FILE *fp, struct ipv6_rpl_sr_hdr *srh)
@@ -953,6 +956,7 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
 	char segbuf[1024] = "";
+	bool nh_vrf = false;
 	int argc = *argcp;
 	int encap = -1;
 	__u32 hmac = 0;
@@ -981,6 +985,8 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			if (hmac_ok++)
 				duparg2("hmac", *argv);
 			get_u32(&hmac, *argv, 0);
+		} else if (strcmp(*argv, "nh-vrf") == 0) {
+			nh_vrf = true;
 		} else {
 			break;
 		}
@@ -1005,6 +1011,10 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			  sizeof(*tuninfo) + srhlen))
 		goto out;
 
+	if (nh_vrf &&
+	    rta_addattr_l(rta, len, SEG6_IPTUNNEL_NH_VRF, NULL, 0))
+		goto out;
+
 	*argcp = argc + 1;
 	*argvp = argv - 1;
 	ret = 0;
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index aafa6d98a4c2..37dcaae49195 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -240,7 +240,9 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR ENCAP_SEG6 " := "
 .B seg6
 .BR mode " [ "
-.BR encap " | " encap.red " | " inline " | " l2encap " | " l2encap.red " ] "
+.BR encap " | " encap.red " | " inline " | " l2encap " | " l2encap.red " ] ["
+.B nh-vrf
+.IR "]"
 .B segs
 .IR SEGMENTS " [ "
 .B hmac
@@ -893,6 +895,11 @@ applying the reduced segment list. When there is only one segment
 and the HMAC is not present, the SRH is omitted.
 .sp
 
+.B nh-vrf
+- use the vrf attached to the next hop device to route the encapsulated
+packet.
+.sp
+
 .I SEGMENTS
 - List of comma-separated IPv6 addresses
 .sp
-- 
2.52.0


