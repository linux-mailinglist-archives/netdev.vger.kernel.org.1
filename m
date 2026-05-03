Return-Path: <netdev+bounces-283622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMVhI6lt92ndhgIAu9opvQ
	(envelope-from <netdev+bounces-283622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:45:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D74B64B4
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0088A300DF46
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5537E2ED;
	Sun,  3 May 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1S1oMeA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9D37F8D2
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823128; cv=none; b=FgydvB+Rjs4kLaQmg6D5foayX7rn08p7XU6xFRS6ILYI9OmIUlFs6C2tJIA5TUuuH3QWuCrH8EYPgBzJutB9Ofobqc1l+Z/yQJvn5WVu/noL93tOy9+yXxCO9/Mq+Rml0hUO5E0/TNRvUhYdTPOorZelCD6e5rcZT6l4MnEGmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823128; c=relaxed/simple;
	bh=OPjsz1jGKcVX1fXkIdGnfGN/KyXB+Pxn7dgh78NmvUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rABDiM7/PZhp9UBLuczS77v8E4R+AaeTXG0AJGqGLW13eOS5QeSl7I2mQvRnDB+y7x+rXgT2knBaG5QSO/4uaTaDo1Wig4xhBA+HOgkmXkNjUcbkbzabNl1aVXp9IsKPz6NaBA9/ELFw+DlU7C/a68jTTyA//yVLxbP9Q0Np8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1S1oMeA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so2104312a91.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777823126; x=1778427926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffXicW+s1cKBNHB47hunsEtf/NKICiphlYlpye9diJo=;
        b=P1S1oMeAacGM+NlZ2MwUDuQy66aKT5Na1DH59Qk3a3hJNOTb0T9V9S4OpMe2kD8T6m
         eAaJztFJezw24ZVxz+BaLLuSD4hUJIHY9oNh6173aJw8ERfaZGxAtEJw74eMoj506Wxa
         HqJoG2lw0z8/RQ+h9+OLORnNbdjB2Fagk1YTye7hilmpfGXZVBZm+VDahXG0rP8ssXlA
         e5UHh16z8yXW5p01qI6+eYZNvGRTF1CraKyxmoBlR6mBoCTcNpZSOCGqnic7TtllmDTQ
         62KgTIcAzF+kRyOiU1TWuXFXe9t5ohZUbeUkElNTsEZlIAPv3fgNrskNMyDKQrFK5EGg
         FmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777823126; x=1778427926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffXicW+s1cKBNHB47hunsEtf/NKICiphlYlpye9diJo=;
        b=Rb36sUu/5oF72FtcgzzAnnR5z0Tcp0MC8vS7tqN+EaBpgTmvVcW4mguUL81Ba2TLTT
         koJ/+V7cq7NQ8NQJVyfh8MydSV/RQQxVPfk1eJs4+TtM5r7HUGOl8szMLB4luu5LmBHk
         fU6wEFDSZOW62p6O5uanojKxKYQIUx+/e2SFOVSI7x/nvgPTyvFq4d43UaHZ1cfDBaDD
         rAOE/yA2lkwqfNlstvuvkRTH10HWJiw4Udzhj1CSMmBO5U3Cr5wEo7myTR5Bw5PuSRIF
         aJSijeMzCi5fnNpGQsZs/SqA5IR0NTaI5vZs0hTU9aW2JzSGDGoNnwPdkmU7gkFJpW7S
         S8RA==
X-Gm-Message-State: AOJu0YwiPHPVdDgCUmufdp9zjiXjrMuLHzm1Jssv9f3akJhCPH5Nk0ER
	RjfQrb884ZZojjWTRU3odcrTQ0y8t7Csj0RYzNERzmWLA10dqlCakXcW
X-Gm-Gg: AeBDiest+A8az30pGjrdtnhaX8+wwpl1DNLy3tBKpessK9x0gTtrs/V/s6DDdQDKIzD
	NQXd8fruShn6LGSemwK3u/r0Apduw8hqTLQh/8aSc+NcfzoStN4XGCohd6D7JnNswVWL/P5u8EG
	EFc41ZRdWe8R+Cl96jNg7w2ImQDC9xClezD+zjzPAm0I+tItVwDazm0nJoe/dqA2SGcypCiuf2x
	5X9kvzRSQ3PcVTPcAkppzmGBTrTQbiEp5sdEnTJoBsuI1RE8FtuALrcwCNL1eYkTZQjuyru4Ix7
	1ubvrS1+jgkwQ/wG2BQ/xNeXMULjYA5/MYtooVYGJIDQndfAdZgKpaMl/gH/haJVquI9LrojigO
	NWtvFkLY4+wkMiM0goCj7bChb5vvEzFZdUle/v+IwWmZQ56GV3j0pnQCOdoE2bvJzqYkOe1AeUk
	KJQYwSIM/gabKPveNqxVuHO9OiImk=
X-Received: by 2002:a05:6a20:1582:b0:3a1:90ef:7e31 with SMTP id adf61e73a8af0-3a7f1f9bad6mr7018485637.54.1777823126239;
        Sun, 03 May 2026 08:45:26 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6ec67sm7207421a12.17.2026.05.03.08.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:45:25 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next v1 RESEND 1/6] seg6: add support for the End.MAP behavior
Date: Mon,  4 May 2026 00:45:05 +0900
Message-ID: <20260503154510.912576-2-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503154510.912576-1-yuya.kusakabe@gmail.com>
References: <20260503154510.912576-1-yuya.kusakabe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 089D74B64B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283622-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,end.map:url,end.am:url,end.as:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.bm:url]

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


