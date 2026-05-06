Return-Path: <netdev+bounces-284936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJbcB3Bn+2kbawMAu9opvQ
	(envelope-from <netdev+bounces-284936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:08:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 825764DDDEC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5603016527
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A148C40F;
	Wed,  6 May 2026 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMxz76PW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1593481AA2
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083627; cv=none; b=CpyKd9ozKIaBMltlY7efiMFpkMO81CEU2BqJmMbETr0O3j5cNh9jR8NqaHjNoF/4yusTubAdEAYwb8VMLsywDr1j8Ey0V53DcQFRhIpNzHofjf326qgwcLqgvlWiJUfRIFzr228xbJTN6V19mbkeh0GeDceo0Wkg9uDek+6s4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083627; c=relaxed/simple;
	bh=ykwMHUEd0hsIyfIsVZwiYaZbec66DLJgY2YZ0eTBX1g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RDfBicAl7eIWdG/AKW/Dq6I1y3odMDNFOBA/1G71saJ41ONM16QJsvACjzfBOuaCeR2RMeYAWNriePQ8yMmxDV29rDmRIH8Ixw9JLwI3YgBBmFy/gN29tjP/9Y5o3iy2WcYbHpGSynzbLWzEUmtJQxlvN8fqieiWB1whUsbdMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMxz76PW; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4718a1723a5so9455221b6e.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778083617; x=1778688417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+4NHUHEJqF969q6P59ZGW3RHrZHMnY13I01mZVqdn1Q=;
        b=CMxz76PWKLXCtZrpelQPn+p8Lf4ATWa4EaKeJhmUq7CFMCImE+t4a86LSRRmdaQASY
         xGIGTeKPi5ftmVow6mNRgmV3mPWFBOJWALMI8cTAKLkqZ7whCjf+iROTYQqDAH3yVT6b
         kM0EysVMn1Z4viShL9JZYNdlDKu8gfRWraRhDmt/keNDmlkMn9dERuv2QEWcSnz0HxOr
         GNz0JOMBOgrldW3gb+Xo81LoYtbdKiuB13HdvvQmuIkbz2zJJYRFQ7ezmQWLFfvKUNEB
         lod+Qlyk96yIi4nzKeETjUyv4j/NPYhJDLEFy12qGX5phdY6ibAFicVkwcrVOkSin5Xe
         qOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083617; x=1778688417;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4NHUHEJqF969q6P59ZGW3RHrZHMnY13I01mZVqdn1Q=;
        b=AtAK9OvtJeWl3wioMpJpPpsLTwP/pBrXdfIgs4lhEYbXomKRd0pq+iAxYMkJKjNnsX
         Rwd95/7XR6vb2zFsd052CwGqtfdvLRq9M/SGbghLkm25NZCxJIqLXppobu5jrx8kDyQf
         rJPqh8tgdR78J2Xw2Ob81Ki2PXiIP0fr7yjfqb4+kqBTVt9xjeuhgsQcGWwCFJ4+F8Gu
         J82v4CZa4VNkBHPb6KKGVkBFEXLxgeVsm0q5vK8lip4xBDQ/R+udj2EAq/boX/mHdu7O
         OHqMwfNaaR/AfPIfvfHbO+5WpVlqSgOZVdTuQan6kuNr5lVeZG/5HIJwxccCBcuff3T9
         Y93w==
X-Forwarded-Encrypted: i=1; AFNElJ/+RuReNoP+3/MmCCAthKxgsQ6zSi7mcnALgWMRTlJW/vg9aAomNtgH7+W/is++y/DeWTWvDq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaxFFSLfGA0zpg5MLI5xlRizAruOkFEZPbjnn9rcDyLSmU0Nd
	BliyeOX8rXK2o6rczCq48VHX2E7T8OLW1FYMJMSAD5BNdQrx8oV1/8fjTL4mn8qgSUDxl2j6r+w
	vrVIZKul9SOHBCg==
X-Received: from qthg9.prod.google.com ([2002:ac8:709:0:b0:50e:5ae2:8868])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4e8e:b0:46a:d8b7:1101 with SMTP id 5614622812f47-480424aa8damr1575613b6e.41.1778083617189;
 Wed, 06 May 2026 09:06:57 -0700 (PDT)
Date: Wed,  6 May 2026 16:06:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506160656.1226077-1-edumazet@google.com>
Subject: [PATCH iproute2-next] tc/class: use rtnl_dump_request_n() in tc_class_list()
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 825764DDDEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com,mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284936-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]

strace tc -s class sh dev eth1 parent 2:

strace is fooled with rtnl_dump_request() way:

sendmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000},
        msg_namelen=12,
	msg_iov=[{iov_base={nlmsg_len=36,
			nlmsg_type=RTM_GETTCLASS,
			nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP,
			nlmsg_seq=1778082626, nlmsg_pid=0},
			iov_len=16},
		{iov_base={nlmsg_len=0, nlmsg_type=NLMSG_NOOP, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=131072},
		        iov_len=20}],
		msg_iovlen=2, msg_controllen=0, msg_flags=0}, 0) = 36

With rtnl_dump_request_n() we get instead:

sendmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000},
	msg_namelen=12,
	msg_iov=[{iov_base=[{nlmsg_len=36,
			nlmsg_type=RTM_GETTCLASS,
			nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP,
			nlmsg_seq=1778082790, nlmsg_pid=0},
		{tcm_family=AF_UNSPEC,
		 tcm_ifindex=if_nametoindex("eth1"), tcm_handle=0, tcm_parent=131072, tcm_info=0}],
		iov_len=36}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 36

This will also permit future attribute additions, like skip stats.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
---
 tc/tc_class.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tc/tc_class.c b/tc/tc_class.c
index 310514ce560ab6c1b42665cb6c75314e45b84cd6..82f0f85ee39a335bc7e1c3bea2e3ea9571ea155f 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -386,7 +386,14 @@ int print_class(struct nlmsghdr *n, void *arg)
 
 static int tc_class_list(int argc, char **argv)
 {
-	struct tcmsg t = { .tcm_family = AF_UNSPEC };
+	struct {
+		struct nlmsghdr n;
+		struct tcmsg t;
+	} req = {
+		.n.nlmsg_type = RTM_GETTCLASS,
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg)),
+		.t.tcm_family = AF_UNSPEC,
+	};
 	char d[IFNAMSIZ] = {};
 	char buf[1024] = {0};
 
@@ -412,20 +419,20 @@ static int tc_class_list(int argc, char **argv)
 			if (get_tc_classid(&filter_classid, *argv))
 				invarg("invalid class ID", *argv);
 		} else if (strcmp(*argv, "root") == 0) {
-			if (t.tcm_parent) {
+			if (req.t.tcm_parent) {
 				fprintf(stderr, "Error: \"root\" is duplicate parent ID\n");
 				return -1;
 			}
-			t.tcm_parent = TC_H_ROOT;
+			req.t.tcm_parent = TC_H_ROOT;
 		} else if (strcmp(*argv, "parent") == 0) {
 			__u32 handle;
 
-			if (t.tcm_parent)
+			if (req.t.tcm_parent)
 				duparg("parent", *argv);
 			NEXT_ARG();
 			if (get_tc_classid(&handle, *argv))
 				invarg("invalid parent ID", *argv);
-			t.tcm_parent = handle;
+			req.t.tcm_parent = handle;
 		} else if (matches(*argv, "help") == 0) {
 			usage();
 		} else {
@@ -437,13 +444,13 @@ static int tc_class_list(int argc, char **argv)
 	}
 
 	if (d[0]) {
-		t.tcm_ifindex = ll_name_to_index(d);
-		if (!t.tcm_ifindex)
+		req.t.tcm_ifindex = ll_name_to_index(d);
+		if (!req.t.tcm_ifindex)
 			return -nodev(d);
-		filter_ifindex = t.tcm_ifindex;
+		filter_ifindex = req.t.tcm_ifindex;
 	}
 
-	if (rtnl_dump_request(&rth, RTM_GETTCLASS, &t, sizeof(t)) < 0) {
+	if (rtnl_dump_request_n(&rth, &req.n) < 0) {
 		perror("Cannot send dump request");
 		return 1;
 	}
-- 
2.54.0.545.g6539524ca2-goog


