Return-Path: <netdev+bounces-252376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOxkKUU4cmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:46:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520268154
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B27B87C0A6B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBB341AA0;
	Thu, 22 Jan 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhLhGL9I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoLyCIHz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7533FE2B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090359; cv=none; b=O+e5OXJ+bhRehjx1RH3N2kzOSaqBt+x6TO8jcMBTfTAXUs2HSD6PMuGABWESWYUAAWk3wMkkYTevB7oMPopdH7lyqaKW4N7TDJHyEM2PrM0mDH1vdjDrQlNrT28cCoNSE1oTPytlEmsPIbR4iDGtlNeyACujnZIifnekbVoy/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090359; c=relaxed/simple;
	bh=7DsYq732Z+wfiiF7Hg9kNp6UOxBMr1KogXlgUYj6UqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUYQ1UxyB9atl69NhHZCewegfaNOxo2ZuAnKD/MsUmA1PGueaDkmGyJVFm7bcXdJ3S0qJpXrEMrIhTOQUazQENE7wEuWZu2tChC7hx2LMRpsHSULmyRfOR12PMtGSrEkcICK9iFym8fTRqFnjwn7jcAapFjzdsQt85K0c6cHyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhLhGL9I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoLyCIHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769090356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G7cMxHVtTcrtT4DIDCCaSRBPUXVsb4jm3b9QFleE3mg=;
	b=PhLhGL9IGLccq0JM8T4NDdqlmZ1lJgYMkv+kVam43Kgupt4xNuSkKXyPJ2Xsd8mxd09Pe4
	2yk9Na0Ix15/kIqDY1cDWHLR0JsW9VxQUmiXNt0qen9+xO151xQ8JIiyyDLEZkLgSFEzdx
	PjamLKMRXUUNIIrSBo2dZfmG0sbm5uQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-jZGgh4CNPTedh8Klo8TFJQ-1; Thu, 22 Jan 2026 08:59:14 -0500
X-MC-Unique: jZGgh4CNPTedh8Klo8TFJQ-1
X-Mimecast-MFC-AGG-ID: jZGgh4CNPTedh8Klo8TFJQ_1769090354
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee868f5adso8927345e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769090353; x=1769695153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7cMxHVtTcrtT4DIDCCaSRBPUXVsb4jm3b9QFleE3mg=;
        b=RoLyCIHzyrSOq0/UmxPGHfzCh6ejkzeaP15IZo4YbLijcMH5kU160UmdKEGFcbtilc
         fKaWApTbIDyRTK7YNTipMt1wekI9FmI53foxoPvqEwWrF2XKe3iQksarOnVIUdYo3hMY
         iqlbWzr19pFrH9tBR6N/8KpFvArj2XY9YbMsMbNf3bXz118SRSORIs+d79qHDc0kWqW8
         qQfl+/2GBs5+s6Szax28Bu2GYmxgMzm2lqQ6lif1ALZQGiG1I9R7XJIebFKyM69CmOF2
         YceaVN2e8QPxWo317k9GkDcJIiSqIItzQoVzi2LN74D+Gko2vE2dRICO4t9ipi2IzICy
         qWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090353; x=1769695153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7cMxHVtTcrtT4DIDCCaSRBPUXVsb4jm3b9QFleE3mg=;
        b=Q/Oy1GTpnb4UnPob+jz9r/AFsdvevWfCQSbrF00/rifXLz75mVKd8Z0IeXI1AYXPRX
         WYSLsodJqFdmlXn01N7cp4Aafy6b9COhu+kkYZqFnF6uMoxWNqoiZZrEKaiH4aNXtpVi
         0h+h99vXfWu2HHP2iswdUMjthG6aBR7DvSm28aaN/o6gmohv6EdprLwsrHJPUF6XGutH
         PxQ4saBrPc8GvAFUeGzkzvXBtGvGEA6d7LoePru7kfXuBzNdbVjnp3fHJS1LeGlBpdX3
         4R9XsTRzbVxu5va0fzYD/XoQuPYRL2PNTbINOtU8aOHJfhcVwoANPpPT9eymyznPovX8
         cL7w==
X-Gm-Message-State: AOJu0Yys63iVgyjUZ5uN8rFXlM8qoEi26ewIjmiDnVi+xpTDgzOhpi+x
	1fjDHwSnuKRHU4HUkKbm0K0a7qX/pODulgKby8opLKGKSbV0P0Hi9NHSGx8n0B0oPLNzlUqictL
	0aomQ11UvyRLPFQS0U9bYOfuCzIIOelW153VWwMfpi/W19lnhazzoYhZ7DtKgdCc8jg==
X-Gm-Gg: AZuq6aIIQVy9dwhCKeUij4y/7jh23/twfPR/vIW2EP5rONl4xoSccmF1N3MGiiKaiL4
	rQFVWDWSbPqPPFmw7hUzgotP5wxqrvcZxo+zIt2TON1tWBXzeMfgtlmW4WLnxdhDK1nKTxxh3Gc
	BKKBN0jBqkvljFnnxN3NSmsXBvoC9wMK8ljsbZMOlHbbrdUK+ypE3rG6TIhW96bKzJsP+GHGI4q
	Ep9yVPNw/ynfTqVmiNjbABqlRI93ablkywavQz+UrY09kPj3bb+eIqqdPKYkv3fUopMbY9F5DZ/
	lhfU3pRGVjRIlNeKOIqT+M0yjMJzU4rKiLMcbiqWRj2bRZSImpCIfWSsENKxxX1n/51QtJp5OY0
	FGulbblmeGoYqNkU6TqEDvHXhuFfLayl5Wd2v
X-Received: by 2002:a05:600c:548c:b0:480:49ce:42cc with SMTP id 5b1f17b1804b1-48049ce4465mr32000675e9.9.1769090353178;
        Thu, 22 Jan 2026 05:59:13 -0800 (PST)
X-Received: by 2002:a05:600c:548c:b0:480:49ce:42cc with SMTP id 5b1f17b1804b1-48049ce4465mr32000185e9.9.1769090352657;
        Thu, 22 Jan 2026 05:59:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804706ef6csm61753305e9.15.2026.01.22.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 05:59:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0AA3F4B3646; Thu, 22 Jan 2026 14:59:11 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2-next] man: Add cake_mq documentation to the tc-cake man page
Date: Thu, 22 Jan 2026 14:58:49 +0100
Message-ID: <20260122135849.200981-1-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.37 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252376-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,networkplumber.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3520268154
X-Rspamd-Action: no action

Add documentation for the cake_mq qdisc to the tc-cake man page,
including a section describing the differences between the single-queue
and multi-queue CAKE variants.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 man/man8/tc-cake.8 | 54 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/man/man8/tc-cake.8 b/man/man8/tc-cake.8
index 47f8f9854501..27873d889955 100644
--- a/man/man8/tc-cake.8
+++ b/man/man8/tc-cake.8
@@ -2,7 +2,7 @@
 .SH NAME
 CAKE \- Common Applications Kept Enhanced (CAKE)
 .SH SYNOPSIS
-.B tc qdisc ... cake
+.B tc qdisc ... { cake | cake_mq }
 .br
 [
 .BR bandwidth
@@ -132,6 +132,13 @@ eliminate hash collisions.  Priority queuing is available through a simplified
 diffserv implementation.  Overhead compensation for various encapsulation
 schemes is tightly integrated.
 
+A multi-queue aware version of CAKE is available as a separate qdisc called
+\fBcake_mq\fR. This variant allows the CAKE shaper to scale across multiple CPUs
+on hardware that has multiple transmit queues. It is mostly a drop-in
+replacement for CAKE (and takes the same parameters), but has a few differences
+in how it treats traffic. See the section below for more details on these
+differences.
+
 All settings are optional; the default settings are chosen to be sensible in
 most common deployments.  Most people will only need to set the
 .B bandwidth
@@ -170,6 +177,8 @@ parameter can be used in conjunction to specify an initial estimate.  The shaper
 will periodically be set to a bandwidth slightly below the estimated rate.  This
 estimator cannot estimate the bandwidth of links downstream of itself.
 
+This parameter cannot be used with the \fBcake_mq\fR variant.
+
 .SH OVERHEAD COMPENSATION PARAMETERS
 The size of each packet on the wire may differ from that seen by Linux.  The
 following parameters allow CAKE to compensate for this difference by internally
@@ -698,6 +707,48 @@ override mechanism; if a host ID is assigned, it will be used as both source and
 destination host.
 
 
+.SH DIFFERENCES BETWEEN SINGLE-QUEUE CAKE AND THE CAKE_MQ MULTI-QUEUE VARIANT
+
+The regular CAKE qdisc is, like most other qdiscs, subject to the global qdisc
+lock, which means that it does not scale across multiple CPUs. This limits the
+maximum bandwidth the shaper can handle to that achievable on a single CPU.
+
+To avoid this central locking, the \fBcake_mq\fR qdisc can be used as a drop-in
+replacement for \fBcake\fR on devices that have more than one TX queue, as
+follows:
+
+.RS
+.EX
+# tc qdisc replace dev eth0 handle 1: root cake_mq bandwidth 1Gbit
+# tc qdisc show dev eth0
+qdisc cake_mq 8001: root bandwidth 1Gbit diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0
+qdisc cake 0: parent 8001:2 bandwidth 1Gbit diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0
+qdisc cake 0: parent 8001:1 bandwidth 1Gbit diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0
+.EE
+.RE
+
+As the example output shows, this will install separate \fBcake\fR instances on
+each hardware queue. These instances will share configuration, and can only be
+configured through the root \fBcake_mq\fR instance. They will also share the
+bandwidth shaper state, but will otherwise run independently of one another,
+allowing the CAKE shaper to scale across multiple CPUs.
+
+While the \fBcake_mq\fR qdisc is designed to serve as a drop-in replacement for
+single-queue CAKE, it does have some differences in how it treats traffic,
+caused by the independent execution of each sub-qdisc. In particular, the flow
+classification and fairness enforcement between flows (including the
+prioritisation between tins) only happens within each qdisc instance. This means
+that global flow and host fairness cannot be enforced by \fBcake_mq\fR.
+Approximate fairness should still be achievable assuming flows are evenly
+distributed between queues, but this is ultimately outside the control of CAKE
+itself. Users requiring exact fairness between flows are encouraged to stick to
+the regular \fBcake\fR qdisc.
+
+For details on how the shaper state sharing algorithm works, and its scaling
+properties, see the publication: Köppeler et al, 2025: "Have your CAKE and eat
+it too: Scaling software rate limiting across CPU cores", published in the IEEE
+LANMAN 2025 conference proceedings, and also available at
+https://schmiste.github.io/lanman25.pdf.
 
 .SH EXAMPLES
 .EX
@@ -781,6 +832,7 @@ qdisc cake 1: root refcnt 2 bandwidth 100Mbit diffserv3 triple-isolate rtt 100.0
 Cake's principal author is Jonathan Morton, with contributions from
 Tony Ambardar, Kevin Darbyshire-Bryant, Toke Høiland-Jørgensen,
 Sebastian Moeller, Ryan Mounce, Dean Scarff, Nils Andreas Svee, and Dave Täht.
+The cake_mq shared shaper state algorithm was implemented by Jonas Köppeler.
 
 This manual page was written by Loganaden Velvindron. Please report corrections
 to the Linux Networking mailing list <netdev@vger.kernel.org>.
-- 
2.52.0


