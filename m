Return-Path: <netdev+bounces-283902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMDIGpWz+GmWzAIAu9opvQ
	(envelope-from <netdev+bounces-283902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:56:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 291244C03B7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A654E300F5D6
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C93DF00A;
	Mon,  4 May 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UBO/3QyM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A013DF017
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906418; cv=none; b=kgTU5GjUj7X5fPiNzB/40DmhIVxN4nxIaIYvw3dkOpLPbJpcf0UID/p9sfiaEiL2BykYckFQyaBArBhajriA3K+jP+4bLJOcWK0EwgvuN/WIV0m9uJ/6++PaRZApHU63X1EOL+rBJgLIYPsxUbvYusbsvLlwNbc9Bc2UFzmBYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906418; c=relaxed/simple;
	bh=Q2URSNx8B/upwfVANDhtXGow03GK4tWmrRjookPjOBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTvhNN17N85jqekMtp7Q33WsSKiyu4840t6z+fN1wfpukitThwYGMiWU2wrwmOyniGjb0wNVaB+XwdE4QHuH+09zmxHuj15zspgUIwXXbwAtHr4L/h+UVEjmlXplCShr/NH4OXsi3wXl/kY7E0LAgJQWLFs1LaInBy0A9h0JTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UBO/3QyM; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-364e640dea8so857554a91.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906417; x=1778511217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhl1El7Ec0BsiUHbTpDBR+jiTk0km6h08mEdzxE8DPs=;
        b=pOnRyFtjuGsbFjuJ71PxbO/wV90JcYGqvbWdchPTPYJKxz3FoOwFrEhQ3HYwy+Vnt7
         CDHO1bmQMIjYDak4yOJB4oZTYwGE9oNByA7nqM0AKVoIsH/W//hjB8W5Pal4itVsA+H7
         2t6D9OXu5T8AsrKIu4jfqwTTGIvA0By7pgcNynrObHH6IF/eNfRAxJw5zPCfa2EsPsUN
         icmv3IPkE6e8ThnNBXdaIwEhJsL9VrRxZj24bj8uljUStk5rxuNY9pFCXbaUKuQLCcaE
         ILTng6yiWgny419ll7ZRzzA9H/PLJpkOnvx6GI3iMZpB1r942NXcDFMKl+HB7doCAvZz
         Amog==
X-Forwarded-Encrypted: i=1; AFNElJ+8PcoxKxRTxOjzE4BwRgeEgieuXdTu9EKmXCB9fPJBll0f6scj8UC0+4MQ2mOhYikdyEQNP8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNH6JGjPWkRh3hv3MbesarsaK1lKLUjLY8m6ArVJXPyILnl10z
	KVsHCrjjUZqMIXyDP1NT0bunFB17bF7+7PLCPjDVep0iia2BAfAYy6YYb0iC5l86ZUR+EMa4d8G
	DFLMzf/Mr7mgYa0QHG6pkdpWYBxYVg7tF6rGGuE2SdcrRncJbKTzcO1vxd56Y2baDcugvyQeNaH
	Z6rBbqdDIER+oyTJZ8ZAmtawDM0O1SNc0MfJQeHn9yOS1JK3kFqweg5NAhpeoqYxfhJRvDdpJwK
	YrvC5xYzCB5
X-Gm-Gg: AeBDieunpJNBPQwCQxCeoKJcunq0HTW8FhJQgnQ6NOnoDnKIibeL6QqiqgM8K9HBHsy
	gcN/IHoN98AFxVjQyV4HGo67tAuw2dqpXb/+5Fbeujw7UwjitNvpAQmeP24rYrJnoUmwDnHJC3w
	i/6q15wDbN2f+dYAViPma4O1+65EsL2qz3+FRet5uaZGdQ69xL6Vorjz4kJRH5wIafV/CRq7ejh
	FnnsgEAgVTWZHiVn6j1Las3MXA+8/bC8RYXXkhvSnu6QuYv/k35X4N7fDDwLQ52JUOTXxEbGJGI
	x3w8wJ6hdxLWKuxjvW6EzefeokAdoGwUjNz98iuDIb+u4fmwXcPiy4I9QwSnk/gkuRDNZnCMIBD
	8N/Di9osw5dN+fqWTHXCRIlTAQ8kRNA7PZeBzaQDZNlxdDvCNYEu0TmNr0q5Vij/Aqx1AzA5b5e
	IzNCuOLmSqMTHiUH5wCBMBQf2zinme4ccToJV/uZYjnFSB3KahHWqOc3+CCP9hJgzLIbcRzy8=
X-Received: by 2002:a17:903:4b28:b0:2ba:1e94:d03b with SMTP id d9443c01a7336-2ba1e94d316mr21826235ad.6.1777906416566;
        Mon, 04 May 2026 07:53:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b9ca9cf042sm5899175ad.14.2026.05.04.07.53.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 07:53:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d45ebdbc9fso113885085a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777906415; x=1778511215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhl1El7Ec0BsiUHbTpDBR+jiTk0km6h08mEdzxE8DPs=;
        b=UBO/3QyMV85iRhm3tz5bk/CMpTWJIyU0+KT4fJQmfohU+NH7Is0t91gHR343ROZj8I
         BWanBRmtA45FutDlK+SS7nt45O7VLi6gwW2RsK2rtm8rBTfM+XgFKQD5RJfeAipv2osK
         3dUtHibrzahhBYOEPAta3oZpDGLN7fSoCY2is=
X-Forwarded-Encrypted: i=1; AFNElJ9RpZI13f+Yezcz6vIUZvkiIZ6eGhBltMHpzoWXQEiniXJGUm17guZ/OnRcM/IoQIf48zKaW6c=@vger.kernel.org
X-Received: by 2002:a05:620a:31a2:b0:8ee:f43a:bb63 with SMTP id af79cd13be357-8fd128ac3b1mr984116885a.0.1777906415191;
        Mon, 04 May 2026 07:53:35 -0700 (PDT)
X-Received: by 2002:a05:620a:31a2:b0:8ee:f43a:bb63 with SMTP id af79cd13be357-8fd128ac3b1mr984112285a.0.1777906414615;
        Mon, 04 May 2026 07:53:34 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1046315985a.41.2026.05.04.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:53:34 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH net v2 0/2] tcp: protect locked SO_RCVBUF from Silly Window Syndrome
Date: Mon,  4 May 2026 14:49:43 +0000
Message-ID: <20260504144945.13477-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 291244C03B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283902-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

This series fixes a regression where locked SO_RCVBUF sockets suffer from
Silly Window Syndrome (SWS).

Recent memory fragmentation optimizations apply truesize penalties to the
scaling_ratio. For applications locking SO_RCVBUF (like Java/Tomcat) and
processing small packets, this drops the scaling_ratio to 1. This
collapses the advertised window and causes 504 Gateway Timeouts.

Patch 1 bypasses this penalty for locked buffers unless skb->len > advmss.
Patch 2 adds a packetdrill test.

Link to v1:
https://lore.kernel.org/all/20260427152756.1205-1-ankit-aj.jain@broadcom.com/

v1 -> v2:
 - Shifted protection from window_clamp to scaling_ratio based on Jakub
   Kicinski's feedback.
 - Added skb->len > advmss check to ensure large aggregate payloads (GRO)
   are still penalized. This allows tcp_rcv_neg_window.pkt to pass.
 - Added a new packetdrill test (Patch 2/2).

Testing:
 - Verified fix in a live Java/Tomcat environment (504 timeouts resolved).
 - Verified deadlock prevention via the new tcp_locked_rcvbuf_sws.pkt.
 - Passed upstream regression tests: tcp_rcv_neg_window.pkt,
   tcp_rcv_wnd_shrink_allowed.pkt, tcp_rcv_wnd_shrink_nomem.pkt,
   tcp_rcv_zero_wnd_fin.pkt, and tcp_rcv_big_endseq.pkt.

Ankit Jain (2):
  tcp: protect locked SO_RCVBUF from Silly Window Syndrome
  selftests/net: add packetdrill test for locked SO_RCVBUF SWS

 net/ipv4/tcp_input.c                          |  8 ++++-
 .../net/packetdrill/tcp_locked_rcvbuf_sws.pkt | 34 +++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt

--
2.53.0


