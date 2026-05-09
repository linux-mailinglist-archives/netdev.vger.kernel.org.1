Return-Path: <netdev+bounces-286198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLg1Huhq/2kR6QAAu9opvQ
	(envelope-from <netdev+bounces-286198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF2B500A89
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153FD301CA70
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CD2F0C7E;
	Sat,  9 May 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="pZkgn3w1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C13BD237
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346691; cv=none; b=DFnKBvYGz8f0u3BlX4N2UUEQPFvnTGmCAF7hWdk/1caG7JcpG2OkizQfGaFajaVZRzyPFARDNieB1iVxmlrFSsRyZe3QTJbYY9Rk3hpQwZ6jtI6yg8aUMPE+53LrxlrSzLo7DkPr3LEmk2OeYmox98EM/JlEaOv/kOmFKHnaBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346691; c=relaxed/simple;
	bh=peqX1YAkfU6+GmGuHyIQsNBnGq2wOdN0UNX+1uIlAUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJIkeJOA2xfwz26/oOsXZrb2iFPqHlrl1tlpaE5tIFZueK6Jtj7cfLaFLMNVz11q+dBRFH6DMbSTLwjfmZPuSVQ9i1y/nR2g7Pk/F+f0lC2H3UId78lPB3JvlJjg2V5aRhG4Ue/RFnzNqAQ/r2kX6vL59cUTpOB0yqLZRPnhMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=pZkgn3w1; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dca45ca21so4314775c88.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346689; x=1778951489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64lDVztC9B3GOFqDGABXlpr/RRaS8BKSplxfsZ8LdQU=;
        b=pZkgn3w1aJMUwru2St6YrMkUUm3O5fydxJxmg8AVbGNC4eYEXkOVDUsIH0VcFD+fZT
         qDOmcD4hBlIbdqvLnUMhVHV3oOQWrUXUDQnPbSbf0hZagYpPYLUg7rky9c5ZdIUSSOsl
         SZCUWn2RSqrEptxjlrtXPWFBaem+go8lrcARYtBz4/MV1YGrv2jgRnH0PBLmF9sVwyCu
         NsRSwVoZ4gOrQyZM0tt0ZIqE7X0PW5s0ZCvRpvhiY5gGCHyaQsnGe77JaU7qbV02cZE7
         sWszYC5iihuLcsvSuBs/1++JxVBkpWYKDSnhurqNV+4iignsq3BefyFByYVpT7m9DExH
         q9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346689; x=1778951489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64lDVztC9B3GOFqDGABXlpr/RRaS8BKSplxfsZ8LdQU=;
        b=Os0nsXvI15wQTRw/VRBEbJHy96DfkpAunqlUWvf5uCDLTGNF34e4+WUrTtB4PJGHa5
         DwTmyIW4O5A5IAM6rxy8FsnrGQewYtNUU9K+4j4AS9LCWRvoyIHO64YBY+wzfdVDRsnP
         iSqEvXZTCxCl70fdAVBv74V0wkzM+VI/9LkIAwUNIm94lPvnUdLBFQD6+ZOev15R/cXJ
         cwJGfKmmFVnz966PExhf6gXGyln+oog26yJpVEWsQ7MvhshOo+G3SKvmCdMaM62IRR8P
         1xsut6tYPqEG4brJVjsfBRLNo5CIBsdoYpb3SybQnRxlzbPyvc1kAYbVh7X+yCMl06/p
         hRQg==
X-Gm-Message-State: AOJu0YzIyjqFWwpjdNAIlKHJQpyp1ZeWnWJaRFpQHgwaES5xQpAKr0Ws
	3PpGPhYNpyx79AFgsHCygDGRXoskBt+kLckQ1ZjLS0O4jDPwBjwSuEozWwARqYGSw6i3z2RS6Jg
	0p3Gx
X-Gm-Gg: Acq92OHPJ5N69seW8iDxTor25grvVLiDxYzqumcDCKrSomRS9Yb4yoQIuBNe/XZeNic
	quZd7wrFwuSalPxPMb4R9PF+TwM4Zhz4KgN3SpjlV1Vq51NARy757JJ0df4dc60U+he7SYK+HtR
	U+docusOuuN3WnzSfC3Cwrog3099jPW4yzWfFoXJm6FyZO9Qej560MQTdMhuQr55iniIVZnfdoo
	bjGF+XrP7Ercb4vljFsXUwulClbB4LRWC965mAJ9SCjToxNWdCtCrotGPKIN9BxfiaiwzOGDHsb
	P0LMx/Qhvx7LSjHSzaH3WOHYZ4+WwESaT+urNSRRdBJBWaIyg5rF2mWrDMJKIbeav/L4GaM+RNL
	8TCfEoCyv98q9berBKSR5dO8Y9NKJE4Dy9F73DCrfPPtDj6w7LU6RL4mv+SN2w8AM9wn8QkcYUp
	8A5iPGQX4/t2LtvkV/9Im+HUmBRuIzLwur
X-Received: by 2002:a05:7022:e981:b0:12c:66fd:6595 with SMTP id a92af1059eb24-1318eb52ed7mr9219707c88.34.1778346689558;
        Sat, 09 May 2026 10:11:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm8524568eec.6.2026.05.09.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:11:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 2/5] net/sched: netem: remove useless VERSION
Date: Sat,  9 May 2026 10:03:23 -0700
Message-ID: <20260509171123.307549-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509171123.307549-1-stephen@networkplumber.org>
References: <20260509171123.307549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBF2B500A89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286198-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 616d33879fdc..6480de1d07d9 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -27,8 +27,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1413,10 +1411,8 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("netem");
 
-
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
 static void __exit netem_module_exit(void)
-- 
2.53.0


