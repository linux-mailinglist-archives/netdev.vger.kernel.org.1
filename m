Return-Path: <netdev+bounces-298947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MiHCDMktLWqedgQAu9opvQ
	(envelope-from <netdev+bounces-298947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 12:15:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430267E582
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 12:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rWq5wC4a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298947-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298947-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E9A301AF49
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB06344DBD;
	Sat, 13 Jun 2026 10:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795C2135B8
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 10:15:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345733; cv=none; b=glNxsmZ5tJ+PtuXXa5YpBG0IQn/to5F+nT1J0d2tRDkPk7qy4N7bbyaPZfVT+Xw6c5/yvMUOEj+nvG7hVUdEQdGClJZnfqG4HxcgowjZcNHGrQRJjOV7QF21Mv7Q7RgCNQRuvY/vPTNTFmkp3CoyOsjPW1Kfcf9YppkkTZXfslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345733; c=relaxed/simple;
	bh=/hUK1IZcn042JbW4LmirwRqdQLa12bkk8Cn0mJDvbUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fvt1smd2lMcc3rplEuBQlxmijEFkRPqPERGNUS1RT7TFzB5tB4H4ZhPbj8qNWkqYmqIULCuO5Zvsj9Dufp/ndCAykUM5BujcIpd2vjGduACES4TM0WkNyCFjyEZdtqaAV6MawB45cJqYkP1P/m7snepjfR3cSD7by4R1dnjK2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWq5wC4a; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed2195323cso268431366b.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781345731; x=1781950531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2n7ubYPUbw2d5bbeL3JfwCvMX4qY0mWyFpI+QwTZQf8=;
        b=rWq5wC4aQa8OIGyeOvx1J0SmFbIYS7QfpuIt7XG2c0PKf2rzWAqALqSz+K/P16/M19
         IYcNqOvjdz22ytIsviafMiPIVHBIvj0IDtOohCDnSr1JaU01b2zB+3z17y3OJ7G6wmMX
         La8KqKCfhU7McVGGUXFG8DyfeofrPnDVuaj4mU6KfYgs9QUmYSOWwTj5rvKwiUKfaGls
         GMQbfWw+oaEOHKyi157NBtGUTb/4j46kqrHEqZM9BZAngWcpIyah1bd4jqP0uO3DDnTK
         3DSRnKD+owyIBRAd7h1u36jJMD1D35+PCwddg6YBN4Fk/jVl1yvy5t7307GzUGofKYbj
         IaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781345731; x=1781950531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n7ubYPUbw2d5bbeL3JfwCvMX4qY0mWyFpI+QwTZQf8=;
        b=lq5tXdIRsv/iPDxDwyLAK6jV432PtW7lIAUVlxYweLmUagio/LitxkX+0q/D/M0Onj
         cjRvYwY7Q2OxjTMyI3tmFTdZyOWHk2/QlDIsYofceXB+JSXkyNRPs8sYaL8jUDuzg+pQ
         xV1xn7blXnkFbEkgs/VWYplqmpfnsd1FkiVoYquK/HlxeO8XuBvHkTpcuyyO++G9RZ57
         b2wH8u2zoxNmN1uWmm34hdGStz6vj3IlaSqfM6uREHOok7ZYlh+Qt4nG72hMz8Ii0R2f
         +m8r8MCvuV3gsWdZ7LSuQ3/ErxY+qspIot4YZztOJ2jApTfa/T7jnK1+n1vnXENAAAmF
         cKnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MmgeH8H130yoK2KMIEV4mTQFXrG01aNPkJRg5GIWUKEOsmVC2Bv3VOrCJZ5sxc7T7/4M5Rok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5jSUENMjhby4GIAj+KLCZ3pn3eZwqbkwn1F6Hl7AGNjhS3Yl
	bnM1tkoBlu67rmZTaFlZnmm1Z1Ka/+j40yUCM1cMZB89piVmdUm9Dm2+Cj9DMn4hnEac
X-Gm-Gg: Acq92OFvh5vj58Lu4tGjJ3aR7r+0HSoAZsl6d4qAVEGeZis8MqLUBRplzcKh0W3TxyC
	DR8+3IJJwEyQOvcEaL5YuKDpS1RMyIZdSP6mdEKGeWCGnC68vpPyV1jjT2jOE1k6Tjx5aY2N8HV
	Dp1gjOVx8JmzQoHJUwX5+kW7qXsqUZ5X3dgAKJFdVxcEBt1adwXS8PLCj3O+wg/xC4rbiB6AjAD
	q3yRyYRhJ9u5buOBYSGHy+Fhk7mGYADqnWw/VMj59S9axIfGIcYH461Dr7qZbLVCJq88fMrhTAR
	pHkk9bh8vd7YO/5Tvm6eqd1dApwSv9dKdhPTM4DoDsCD9ecMMEW63ztOMXFC3E/IB0kQB37mn0B
	tqzNEf4XTQc8r/mYUN5HsmCMpJZXyOIN9RM8Gxecw41vvcY2MIunlB/MWzjExhirKNz46kSKKqM
	hqTNr/vpSyH8J5q/+c3le4s0Bw5lOO/ZrfA+M3eKywOHz3
X-Received: by 2002:a17:907:3e94:b0:bd3:6ec5:f141 with SMTP id a640c23a62f3a-bfe28e1ce2dmr369247566b.30.1781345730843;
        Sat, 13 Jun 2026 03:15:30 -0700 (PDT)
Received: from archlinux ([2.26.254.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb9113103sm200076366b.63.2026.06.13.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 03:15:29 -0700 (PDT)
From: NeKon69 <nobodqwe@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	victor.raj@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NeKon69 <nobodqwe@gmail.com>
Subject: [PATCH net] ice: Fix use-after-scope in ice_sched_add_nodes_to_layer()
Date: Sat, 13 Jun 2026 13:14:40 +0300
Message-ID: <20260613101440.80190-1-nobodqwe@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298947-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[nobodqwe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:victor.raj@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nobodqwe@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nobodqwe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8430267E582

Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
changed ice_sched_add_nodes_to_layer() from recursive control flow to an
iterative loop.

Inside the loop, first_teid_ptr may be set to the address of a
block-local variable:

	u32 temp;
	...
	if (num_added)
		first_teid_ptr = &temp;

On the next loop iteration, first_teid_ptr may be passed to
ice_sched_add_nodes_to_hw_layer(), after temp from the previous
iteration has gone out of scope.

Move temp outside the loop so the pointer remains valid for the lifetime
of ice_sched_add_nodes_to_layer().

This was found by Clang with LifetimeSafety enabled while testing C
language support on a Linux allmodconfig build.

Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
Link: https://github.com/llvm/llvm-project/pull/203270
Signed-off-by: NeKon69 <nobodqwe@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1afdb41..089ad3967be5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1074,11 +1074,11 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 	u32 *first_teid_ptr = first_node_teid;
 	u16 new_num_nodes = num_nodes;
 	int status = 0;
+	u32 temp;
 
 	*num_nodes_added = 0;
 	while (*num_nodes_added < num_nodes) {
 		u16 max_child_nodes, num_added = 0;
-		u32 temp;
 
 		status = ice_sched_add_nodes_to_hw_layer(pi, tc_node, parent,
 							 layer,	new_num_nodes,
-- 
2.54.0


