Return-Path: <netdev+bounces-290030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HQzOw/3DWry4wUAu9opvQ
	(envelope-from <netdev+bounces-290030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C48595228
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D36BE30A59E9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1AF36D9F5;
	Wed, 20 May 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="VSbv80PT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF929D26E
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298519; cv=none; b=YpvITueXf4KCPEPIaDsj4qPw2dSOeYbBIx/bzK/HaCwjSRtgbW1mgAB0GsgAY1bB63yyzb0gXD7eQiSPhjvWEde37KEsFsU/zsdILDBwT50kNuJgjtc9gNJ2YgMhLEXpy6l7zY/4ozPHUpDHVe0LC40uETtzcdy9S1AcZVX9+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298519; c=relaxed/simple;
	bh=ZBO/SdphN9zDOvGzXhJf8SQYpbHcGXjcAExTLeWpMxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DC1lVGBN4z0z2HRJzVmu9+hoc+Xgrn17RJJdld+CUxvZlFQ92keQhsRSRl6kdw02ohm0oGAf6CGMMFC+CR+cp2JKagqAb/3YnW11pgQWGRBToAUw6eMIQiGPUFswEK7q6vjfksInrG0M7WfEK309OAxffHVHKJnIBYQvxx1uvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=VSbv80PT; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-134ac81c445so3303123c88.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779298516; x=1779903316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMEtxpno9Ebxg/I5+HFaUM6nSA4zFzlhObUIuDICW+A=;
        b=VSbv80PT8dRQ3+xVeJl0bi0Jb9+aKmoSzEFUXZdZCTFQrCwd6J1sRyX5m2fCTCm4Ct
         YT80iACkS4Ndy4kKHrmKJ+rFPpUaDFG3OP8MZP+YR7bXbk9m/TcLzUhxD2x7H570I/gi
         2J4/Joydv4iTToMCoHZQubFcz45H+C6D2htmh0KRbGaPqt3LYRcJ+y1zpbZaSleTf2tm
         /5g18v5jK3paG8lC3YV+O6HkbIbaPVIv68qeEcIvoCCojH5DG/aRQAyY8i3JhpcOuRZU
         e+LEAimwMu0Aht9A6A2cqpFlTrUHsHDcC5G7kgB4JZ+iJoaQfFgZCT9XikkZTTkFYOeO
         5gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298516; x=1779903316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMEtxpno9Ebxg/I5+HFaUM6nSA4zFzlhObUIuDICW+A=;
        b=GdY49g2H60qGXMp6/kL/iDA/VImiPAvGmfrArRW+7KbJvObXQAFTIKbAGy3lnjoy7p
         aqVvnl1mPmVbdcfIF5RnbQ+3WWRsemuPS8ngADl/I7NiPp2Q43e2fj/iVnnYJgX8MApN
         pyk19057X193Z0kRSSpGrDM4H0Eg4L9G3vIvuad1+e+zl6ixKerlCh9MZ4IL9vBKr+BW
         Z+x95yI1XNjZfuCZwlFq8Q1KSSrRP8wQwFfQbzf6qxCMSF02A9yF/6dNv54q2zMmV8vo
         fM3U8l2c0kvCbk3shOrNabmFo3zbRgPm1TDBHdglVPjdKeVHbNQ4Y6U0hdibEVX1EsRN
         KXgA==
X-Gm-Message-State: AOJu0YzT1mIWiJY47m86sb7ej4gAerIgC1GvL2kWdXVIzZlf707OEdx+
	c5HxgPyGFSbgacswzoW4fwd0+6Gv5QS8WJwin+jvRY42gcmn2QbaEi7xYIaJ9Dg4S0pY98qKE5j
	QWMfopGc=
X-Gm-Gg: Acq92OFkyPIsCdjw6IyBFFXmBf558yIvBLZy9lVRaeQ4iO5Tc1zjsvDJKksSQWrI/kN
	JnNNCVPZ39eHzVMgDyFKqtwa1U2i8ZtQOnOk4OLA/by8NF7IWnzg3LpEnCg28/BR3yol0kLVw0x
	YeAZuLCudB+r4mylfqyk5e6zUObv8gkfZVvKafeeaqnQLv3NuSPqBEC3KahWSMwXUsnwXflPiKc
	bmA5kXJc0P2Vfl0D3ZMIDHRCL3Tf0nxTud17pUj1hy1/80SBP9sb6PWlwPM6OdjqJdmgPmueBxT
	lPLF0wXLgXwh2aH1/3+ioa+6HUQuaJ2o+h+CNlO3cLU/Zs7wcYTobLzxA4BzfvVlOfvyws3GgPQ
	7bdzkiWj9ogieLAOqPMw/rGNgNRWuJUlGHX8JwWLQmPvBoARpHgIejNot96g/lr0vs+GB95KvOc
	d1VG6vYShmgRqL0qRkDIgnu/PqY46Kdwma9BzCi0mBnRFVU5dV3DeI9AkxEK8A9A==
X-Received: by 2002:a05:7300:dc91:b0:2f2:b544:2fd4 with SMTP id 5a478bee46e88-303986a4cecmr13196438eec.34.1779298516154;
        Wed, 20 May 2026 10:35:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcc5asm19086573eec.22.2026.05.20.10.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:35:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] tc/netem: display per-impairment xstats counters
Date: Wed, 20 May 2026 10:34:46 -0700
Message-ID: <20260520173512.807908-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290030-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]
X-Rspamd-Queue-Id: 93C48595228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The kernel now reports struct tc_netem_xstats via TCA_STATS_APP with
per-impairment counters: delayed, loss, corrupted, duplicated,
reordered, and ecn_marked.

Add netem_print_xstats() following the same pattern as
fq_print_xstats()

Example output of `tc -s qdisc show dev eth0`:
  qdisc netem 8001: root refcnt 2 limit 1000 delay 100ms loss 5%
   Sent 1234567 bytes 15483 pkt (dropped 774, overlimits 0 requeues 0)
   delayed 14709 dropped 774 corrupted 154 duplicated 309 reordered 61 ecn_marked 0

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/q_netem.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tc/q_netem.c b/tc/q_netem.c
index c48fde11..98e28909 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -870,8 +870,34 @@ static int netem_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *
 	return 0;
 }
 
+static int netem_print_xstats(const struct qdisc_util *qu, FILE *f,
+			      struct rtattr *xstats)
+{
+	struct tc_netem_xstats *st, _st;
+
+	if (xstats == NULL)
+		return 0;
+
+	/* future proof for addition of more stats */
+	memset(&_st, 0, sizeof(_st));
+	memcpy(&_st, RTA_DATA(xstats), min(RTA_PAYLOAD(xstats), sizeof(*st)));
+	st = &_st;
+
+	print_u64(PRINT_ANY, "delayed",    "  delayed %llu",   st->delayed);
+	print_u64(PRINT_ANY, "dropped",    " dropped %llu",    st->dropped);
+	print_u64(PRINT_ANY, "corrupted",  " corrupted %llu",  st->corrupted);
+	print_u64(PRINT_ANY, "duplicated", " duplicated %llu", st->duplicated);
+	print_u64(PRINT_ANY, "reordered",  " reordered %llu",  st->reordered);
+	print_u64(PRINT_ANY, "ecn_marked", " ecn_marked %llu", st->ecn_marked);
+	if (st->allocation_errors)
+		print_u64(PRINT_ANY, "alloc_errors", " alloc_errors %llu", st->allocation_errors);
+
+	return 0;
+}
+
 struct qdisc_util netem_qdisc_util = {
 	.id		= "netem",
 	.parse_qopt	= netem_parse_opt,
 	.print_qopt	= netem_print_opt,
+	.print_xstats	= netem_print_xstats,
 };
-- 
2.53.0


