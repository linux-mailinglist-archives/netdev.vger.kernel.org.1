Return-Path: <netdev+bounces-281171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H/NGeMl7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:49:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56446A6D3
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B198730013B2
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D208364E92;
	Sun, 26 Apr 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Pb2hy+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CB218AB9
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214940; cv=none; b=ZgsBkxSikxbOUI03dX3cQa/wT/oW0+wmK6RPUkkyUXUSaw6pn9K0LUBqO47Uuk1o5EkmDAdXZ8amNeizPBGjl4FFowXfz1oYtwNx/xrvPUYj8b3y6VaS3+JGofTzllR9dA/kV+d4I6gNKd8fEELyI5SCI3VThV9oKNMMTxi//Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214940; c=relaxed/simple;
	bh=0/ZauZOQB/NP1QcAH+PDITEaXUC773OeN19DfxcW1yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvkwpVP+oZphBZFwJMWzh47Ddc7gWCGeC+Ow+hDOYnVKRHA+3096WGCoi78/2vEV9MJcBvAyCIQqNofQXAnxM/M6TDlzG2ZqWQiLuZyu55e2jhW22JlLh8y+l0nN/nOXpq6LjlbZGYZ1hXhdeOZMW3mltxISP+Su5yScYJtYYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Pb2hy+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso103863006d6.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214937; x=1777819737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMSX8d1QgLZUoJnKt34AnkG63ZeJBVmP3ekDSJT4BDs=;
        b=j8Pb2hy+d7PpZUfwcrhGzURJ3yc5i1yFgqmIuBIPKXfnfuyojj+p3psQHT7x2/N4dL
         FIL+orvjFmJA1KfPcPmVIkCHgn9oayoX3ZoCMwHHucFNJKcw1MP5H4c/khHVwb148c2R
         ww7ElTN7ZK1VTAoPz91nnXWZIKUjrsEyhEaVe5k/GIK6rEAXT/2rFYDkY7VvwK0y1yKx
         JvtmIpXZ107zb7jKjdMKdGZdL3wmlmFb3YN2tts5mogsR3EnaLPWHhnkWerfXCABJjJ8
         iVzt/kuvHy7TINI0C+i7UmYk6WIE5EKk8hu2AUCJE97/16kzdat2tOAoDxx9noU9tISp
         R8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214937; x=1777819737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMSX8d1QgLZUoJnKt34AnkG63ZeJBVmP3ekDSJT4BDs=;
        b=A01e/lqE6+nECknJ7iExya5UHAc03owfEsGjjbn/fg3UA2mxfT0hcIwavSb9Vz4pJI
         /1Y2hStbPkhu++4gr5tkonJCMoPEvaqE9dmYNyP0PECFY1uYhJOfe/hpKOyaW932DfBU
         MG6O5rkG1GApq+kNkr6ZS3nyICgEs3dcnq+MK/PvunVm38XM5dPHKsExqtu1kywsEMAX
         KmmuxMCV+MvZE/iPC9GSQhz7PmJwSkYQynCQRqgXG5nbl1Q4qRhGFHg1yigRHVfpen3t
         CBbx4Nj+LJNyCIPbjUw4vc+T6ytO4TxW8JIlwNuYDoZbQoSCwfrdUdnLzShaLVXPEXqY
         VAOQ==
X-Gm-Message-State: AOJu0YybhqhG5piVp5fhxLUG+0r5LFid6Foc9POxE63Fqkd7Nb4sOH1E
	rd/mMr8gEn2Znc4HMlIn6sic+sy1XAI80b4Dj/VUFDPaJddg8t/94qtAddMkHg==
X-Gm-Gg: AeBDieseZucv4eOZ7QSExFhkF4af+QcKfPZEpwDmVYwRr0sgH1H+B6wfQfp4AruZ6V/
	2Srh4Kj1p7CpGsz7DQzakFbEqSjnYxOS7uy5/8yyLUl4uqIbZ+IFGvJ3fZBwKN+y9gS18IhrnJV
	tO6ja3lMtsTSJkJfR3kgXd07io7s1rUiKBr2hV+oMMtRFSWXO30CUaMWtmL/OSDCXd8BEq6nh6O
	8MRjPw+CLDS6rBNF39heMlyJYRgj64WgTXJ6mBMkNkPMwuIWs80LMjx+iARgSnJnET2DapdgBeY
	JsEsVP8ETLgWGTeJQHfabb3jjKCG3aU2V8egRRDMTpazTMZV5wRcNPnk4GcmBXJrV8oE48/oz6G
	uHvlrcKjfgfVb3AO0U1O8HkgugcprU3F8lHfD8H6D3lbnanTJzs/vU0aXSGXECwBl96iR2jY7Bq
	ndj/3N3+9F1bXIiIH+4wIHl7bdg4vAJdKKsGyK4VgZJtLyi6Hgi71FNV6Vij0PKNrxSE7Yy5N0z
	X9ufhl5kTfDuCD2+aeH64pzYChYxgrrB9j2RTNZG4y4XmpU8m+PGKf+zykYpens9c9l6ngp9kY=
X-Received: by 2002:a05:6214:d0e:b0:8ac:aa89:6bbc with SMTP id 6a1803df08f44-8b0446f0cb3mr459818986d6.16.1777214937472;
        Sun, 26 Apr 2026 07:48:57 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm232579146d6.48.2026.04.26.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:48:56 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yi Chen <yiche.cy@gmail.com>
Subject: [PATCH net v2 0/2] sctp: fix a vtag verification failure caused by stale INITs
Date: Sun, 26 Apr 2026 10:46:39 -0400
Message-ID: <cover.1777214801.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA56446A6D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281171-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Similar to Scenario B in commit 8e56b063c865 ( netfilter: handle the
connecting collision properly in nf_conntrack_proto_sctp"):

Scenario B: INIT_ACK is delayed until the peer completes its own handshake

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *

There is another case:

Scenario F: INIT is delayed until the peer completes its own handshake

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
  (OVS upcall)
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
  (delayed)
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *

In this case, the delayed INIT (e.g. due to OVS upcall) is recorded by
conntrack, which prevents vtag verification from dropping the unexpected
INIT-ACK in nf_conntrack_sctp_packet():

  vtag = ct->proto.sctp.vtag[!dir];
  if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
          goto out_unlock;

This happens because ct->proto.sctp.init[!dir] is set by the delayed INIT,
even though it is stale.

Fix this in two parts:

- In netfilter: Do not record INITs whose init_tag matches the peer vtag,
  as they carry no new handshake state in the 1st patch.

- In SCTP: Prevent endpoints from responding to such INITs with INIT-ACK,
  ensuring correctness even when middleboxes lack the netfilter fix in
  the 2nd patch.

A follow-up selftest for this scenario will be posted in a separate patch
by Yi Chen.

Xin Long (2):
  netfilter: skip recording stale or retransmitted INIT
  sctp: discard stale INIT after handshake completion

 net/netfilter/nf_conntrack_proto_sctp.c | 10 +++++++---
 net/sctp/sm_statefuns.c                 |  6 ++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.47.1


