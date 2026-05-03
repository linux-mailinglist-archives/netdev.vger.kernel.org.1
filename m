Return-Path: <netdev+bounces-283615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF+nBSdq92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6A4B6412
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59B583005EA1
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3835CB73;
	Sun,  3 May 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQhfBdU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D535A933
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822244; cv=none; b=Owxe68IrxjsMur6qZbmJDVx/c22UJ4RAOcF6XggGSVCS+e/UrV3XhxZfaHixO0VzAvU5DjtFSFlviyM1vark+LEryAH/jftzH9/gbQhn5qjeEN17z3xqPU+OquhD7srwbBLzTtR++ymRsuuM9jFUNloH8VdV58Kp3MXmPgqR2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822244; c=relaxed/simple;
	bh=sc4tlZUeCZTt2mIbUl+jLc5bOKaQYA1zIGKk6/vhJsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKOhrRM/e6jJ+lAuwVox0xyT35PxHIg8PEAaXabbP2py4CsrzpBTS1VZ4UXJIWX2jHO2t7UQPyeZFxkOjNYFo/iHmWEE7IKS/Ykc2OiBos8hGCU9aSj3vy1swOPhHMPos36J0vV2hZLJLWdPWpoeuXNQTqecuCYx4apeZfTu0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQhfBdU4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82d0b68837aso1693541b3a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822243; x=1778427043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNDZOj2WUAK/gipZOjXIfiwM56S9Rh4PhTymU9djk+w=;
        b=CQhfBdU4/UEUGl7bhfGxW2FHIN9MvOLRkjgB8f5BG6nllrm8W2Ei+9NnuKwuzDfWYH
         hsSVhVj+EIWvd0LNGT5nngB8wLxtqZe/q+HbCixUSUXAWxrQ7oO92ibdgcJQ/QvtR99a
         yz50wSmvUhWiK/eyl25qYAr9AlGsXrQ05esNOI1tnvbLsomMnph+J0VatizPGmsIlOLy
         AvYG6a8OQ8ECb10fqrYZQaWPoaqPIha//XLYVOd2qg00/1HOFxduD291H38IQBC8+Yuk
         UZxdxz5RzWldeIL17aFaaIIZYKGmTpY2Zf0hyXfqyJ5Pe9kH/RdJGxi1jDPFt74n3E2c
         9QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822243; x=1778427043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eNDZOj2WUAK/gipZOjXIfiwM56S9Rh4PhTymU9djk+w=;
        b=VELuczMXFKLqUfxsHboyjxD5pam8WLqmXkso+2Aa4YAOGkE523SPu/2ZVxFZLrfyZu
         qr+LPteauZ5WnN343Jk2hXByeyJXGIJvtik5mp4KIxXGaJwxnNekEwmkoeMXkYHp23uH
         NC4rXWmqOrLjN3hlctYVkFHr2gDMGlNpprwwoaCfZb70ooo1LMhVj4FNGP5kTV6vUvfQ
         xELh9dhTXejZ7ll3M6GOVSpNRjEv6ZWuTsLXhisJZCcEw1pmSkemgYyAOGANBvc8PteO
         mECqH5mOAhEHmF67zkysSyVsN4cR/nvUzKvrYqpWz9M1KAARdAHD+ydSPQgYpKFZD6Ls
         rdYQ==
X-Gm-Message-State: AOJu0YyTqf7krsKzJ0LPuC73lb7/xhVIo48tPA5beqoDZHEPDJxoRCMf
	v65ialFj9SsP3hKusXhwTzOOOKdm/jFCbFHQoio76WuVULNB11mkBHu9
X-Gm-Gg: AeBDievWonCwy96OVK3tCRLPL/WSTLtQCTDPWKeSSR4BL41tJzy4MtFnwGt8h/9SxgP
	eVaSXMrEjuXP+MkbRN+eBBRF8hbP36O70IL9wUgkn6/L4xvtz8QHr6gs7WNrrJgOpwkXl6Ugagg
	HFTo9uOaWV+HiN7aMvDf95FZz2FYwAtESRhf9Ga1L7HQg0yqi5QNEjlJGBp/+n5gBUdDZtAhC2K
	aFuCf0TLdpCrbSF0hu4dG9Wh9R8P1URPdhVyc/c7L/Oe6yT6nSMDqKfcvbKs8eqTvanHmDqxEoF
	2WOkBMkAU/06cD6kiB/VfHNyPcQUtaK3VNJUunE6VZlO1AF0T8ltbpFAACZ9JsfF3eJnO2UInyK
	5XklItg3keGalT0P0t2mrSbfLHv7T712nZMqK+K0oGyFjHeIGOKja8d3akCx6xibkW4ETVxowgx
	aXrrnL+iCWNxomBWraxPKxdBaj7wU=
X-Received: by 2002:a05:6a00:a884:b0:82c:9c47:fefb with SMTP id d2e1a72fcca58-8352d213738mr6469332b3a.20.1777822242630;
        Sun, 03 May 2026 08:30:42 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:41 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 1/6] seg6: add support for the End.MAP behavior
Date: Mon,  4 May 2026 00:30:01 +0900
Message-ID: <20260503153006.900533-2-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DC6A4B6412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283615-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.984];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bbsakura.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ietf.org:url,end.as:url,end.am:url,end.map:url,end.bm:url]

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Add support for the End.MAP behavior, which swaps the IPv6 destination
address with the next SID without consuming the SRH.  The new SID is
specified using the existing nh6 attribute.

A small per-action attribute validator is also introduced so that
invalid keyword combinations fail at the userspace layer instead of
returning an opaque kernel EINVAL.  Subsequent SRv6 Mobile behaviors
extend the validator with their own keyword bookkeeping.

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.MAP \
    nh6 2001:db8:1::beef dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  3 ++-
 ip/iproute_lwtunnel.c           | 13 +++++++++++++
 man/man8/ip-route.8.in          |  9 +++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 6e71d97f6f44..1678db71e8e7 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -67,6 +67,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_BPF	= 15,
 	/* decap and lookup of DA in v4 or v6 table */
 	SEG6_LOCAL_ACTION_END_DT46	= 16,
+	/* swap DA with new SID, leave SRH untouched (RFC 9433 Section 6.2) */
+	SEG6_LOCAL_ACTION_END_MAP	= 17,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 5b9e7ac1134a..61394847018f 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -105,7 +105,8 @@ static void usage(void)
 		"SEG6LOCAL := action ACTION [ OPTIONS ] [ count ]\n"
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
-		"            End.BM | End.S | End.AS | End.AM | End.BPF }\n"
+		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
+		"            End.MAP }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 00b4f7565be6..15c0077a4566 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -405,6 +405,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_AM]		= "End.AM",
 	[SEG6_LOCAL_ACTION_END_BPF]		= "End.BPF",
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
+	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
 };
 
 static const char *format_action_type(int action)
@@ -578,6 +579,16 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 		print_seg6_local_flavors(fp, tb[SEG6_LOCAL_FLAVORS]);
 }
 
+static void seg6local_action_check_attrs(int action, int nh6_ok)
+{
+	switch (action) {
+	case SEG6_LOCAL_ACTION_END_MAP:
+		if (!nh6_ok)
+			invarg("End.MAP requires \"nh6\"\n", "");
+		break;
+	}
+}
+
 static void print_encap_mpls(FILE *fp, struct rtattr *encap)
 {
 	struct rtattr *tb[MPLS_IPTUNNEL_MAX+1];
@@ -1571,6 +1582,8 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 		exit(-1);
 	}
 
+	seg6local_action_check_attrs(action, nh6_ok);
+
 	if (srh_ok) {
 		int srhlen;
 
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 9f29fd436f59..c0b1e87ad022 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1024,6 +1024,15 @@ followed by the specified SRH. The destination address of the outer IPv6
 header is set to the first segment of the new SRH. The source
 address is set as described in \fBip-sr\fR(8).
 
+.B End.MAP nh6
+.IR ADDRESS
+- SRv6 Mobile User Plane End.MAP behavior (RFC 9433 Section 6.2).
+Decrement the IPv6 Hop Limit, replace the IPv6 destination address
+with the configured next SID
+.RI ( nh6 ),
+and forward via the IPv6 FIB. The Segment Routing Header is left
+untouched.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


