Return-Path: <netdev+bounces-277523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEHEHcJL2WkMoQgAu9opvQ
	(envelope-from <netdev+bounces-277523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:13:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D363DBCB1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91323301053B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4230AACB;
	Fri, 10 Apr 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgHxDIcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB326FA60
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847834; cv=none; b=FVy64k7vMb5wz+IAU9GyDgzNGBFIWytud5iTe1ydBh4A1O/5bcN+F0OX6HmicrBmngE/9r8udExgaNQDCngCaCpxyTdcegbyq539dPukZUoGonkrAXPwAfdMzFuzR9VcYvx9QrtLBEdTJxXSWbz2u8Rm54OFwHLUBssm/NQLjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847834; c=relaxed/simple;
	bh=0/ZauZOQB/NP1QcAH+PDITEaXUC773OeN19DfxcW1yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWGhV0/EajnMvpL+T477ZKRrVbqen876HsNpXtY2jkZu0AE4Lf2fCKzO9oJeZV5je0kE918BE9PfvuCvMK87GmhtAmu7SdIchL34BedwwmDAZq3hD2k4ik2YvgfQ/lEWF8HDfG5ZLIzOvCsaAuhLB8GuFjaRjnklAAjV2sKu2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgHxDIcx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6f21c2d81so178176285a.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775847832; x=1776452632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMSX8d1QgLZUoJnKt34AnkG63ZeJBVmP3ekDSJT4BDs=;
        b=RgHxDIcxGOYr5ijdsrNYCwn5BD85092DDYdqC/7CwkPtJgKSDmZOhLYci8rXuzqvgW
         gAd90GtFj20TIdlt992pYhfRDMTLxEjOmbQh1pUHLw/Gi3fqZGEeVuzv8k8pWvm3obdK
         erWR3A6dG/UFFhiApZBAU+j4YvVpIHTUFP06hHh3zCoVzT9MNxaKCbPtDcjJNkwI3eMV
         thpZX9fucFJsn2ldFAUklkoYJbro9ou8pz8/fK8ShDcJv4fTR7/1145/dKo0V52uxFOR
         gxUhzvKZvSGurqRpKhh0ap+mzyPp68rSvtblK4vwLjo1QUhP/Q++2WjrJNohF3Qif+bs
         rkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847832; x=1776452632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMSX8d1QgLZUoJnKt34AnkG63ZeJBVmP3ekDSJT4BDs=;
        b=K/M7+yd/75kSsep9Za81NplFu19gQ6tqZ7YZn0RGjFkjZiU4BNG7q/pVHrr9qgkldX
         f+Eg2kkm2wCL3JObLTxPXn1fwf4qz6LiyawygFHbljv193wimTDC+SeoBks4bMufzG05
         O0nNYKxxx/yr8zMitg0CfBhMtfkJWywXv8HTRS59vmOG/mEBO2vJyI7pFVjzdaOngpjo
         Hmquf1fY+uwtEzo8JPChKzPXxRP4dsL1VMVO/spupe7PxFjglS9cRMcHhxLmcWvv0IkI
         4xmF6yUSEgSs48L1ti/772qdwMcmfZcfq5j0ms6y9MVyIo8N1mR4xStdtfxOzBRPBxCD
         M5tw==
X-Gm-Message-State: AOJu0YwNCd5dKcE0dirdAU3jxpP4e1Hbkd/iKC0XbCC0hqXLRmjwwhQX
	0PqkZf6hyYhPkdEwFQ1WzPm1GC5E/RQWLCvzmGs4lsj4jdFk7sUHz6kQc2fBOw==
X-Gm-Gg: AeBDieskh46C3iqPC/M36WuJFI5/yC54gO5fmz9iaJRJ3KqX82IllA6qCqwCdeU6+ql
	eVtFTdV99F24Wpgcjaf8jFXuAgpPdvMuLEsv+P/Mi4vePSnexSAClORX8URzJXDh/xF4AyNQkMS
	g8Prvj/Wy4BDQAmqhkUcSWK45dngsRY6hZnzcbCxzfF16W95jEPxOMZby8kA4L3sWjYs7xl+y7B
	IryUR1VdpAz6cQAyqsYTpML0djFqWuCrDIkbK/Qar99wZyZU1KnCEu40+BeTv3nsrYc2JUZeMn9
	pu/RtPlEk8uHeseS6TdytNZ7AKA0lfSiP6eSAMFQ1WTgcmDcuyxaqah0q2xxcCEfTePvG5UP5DF
	64OArrUkRkdpll7hOf50xnhlnpRmhfhwsg76xZZYPEOpelLPmpB0OXvH3Fw7tjxKIoaWK4l/ov4
	70buh0J4m5FLIgpiMLzSnUKc7TQOtsSZH/mxpkpvEgbmUYNc1iSLe/saYaTFaHQrL1VFiYbbASA
	kn8BaAB+iSiGbJHozQXxC2pO5rHpotQesM4PoRH80qD8bAG11tK7gpk5X0AOt3x
X-Received: by 2002:a05:620a:2589:b0:8d9:5463:132b with SMTP id af79cd13be357-8ddcf6b5cadmr626066785a.49.1775847832034;
        Fri, 10 Apr 2026 12:03:52 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a47a0dsm30598726d6.22.2026.04.10.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:03:51 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: [PATCH net 0/2] sctp: fix a vtag verification failure caused by stale INITs
Date: Fri, 10 Apr 2026 14:59:15 -0400
Message-ID: <cover.1775847557.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277523-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,strlen.de];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3D363DBCB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


