Return-Path: <netdev+bounces-300810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1n4xErCQNmolBQcAu9opvQ
	(envelope-from <netdev+bounces-300810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772C6A8EC0
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:07:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=lChGYfWi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300810-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D564301CCF6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E4C34107F;
	Sat, 20 Jun 2026 13:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950315E97
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781960875; cv=none; b=ocwLgYyf71gSppU4vU4YZZ/wGtWsY2I8wkNyBCyCldEOO6Dk+BcKdvNmStsip1/+ObaclK9JGeYAZMie3DEq7H0b89zho5bqpUN7J9eS5Pggcn5V1VoNn/yFiiNPAY8uGtfioYVFVzOXT7AnTyXVav+CPLtIScNwRziQapfpAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781960875; c=relaxed/simple;
	bh=fv3dyEiTqS+MpU/TDGYnK1mzeXPG8ty0cJjYZELx0EM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fddjFSRAcZU5jKhSKRm5qfMce8RFfm5e2Oc9C3DQ3YDcE0xMg4n0YgcjenH4HDUlG6P9KKL7uRflJ7mP9WyEci1M1ehPCq0JEvSzBd3ZiLRC9QxBsyz6OfW204tjcYB53NruWsAfqehkwzb/9KAcryDV+XrEnH53w5ou1UNzqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=lChGYfWi; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dd74f90e3eso29910546d6.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781960873; x=1782565673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+fJUkO/Qa4HyGJmdrBBNTGP8QmLbcM8yYwzK3K7MN0=;
        b=lChGYfWinYKRbIemOn4brFcCX0AVCYnKT94aQKsc+xrpwe7rhFigA1Vi/Y9p4z55Kv
         97uu5ki1WsXL1a6T69S0Yn68hbc5BTA6bbovVI8W31yUal2M4VGvk81RrqMyfZ0B9uqC
         wewF7xJ5LxEpF5+Idyg9cTxeupycX7ImX5ft0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781960873; x=1782565673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+fJUkO/Qa4HyGJmdrBBNTGP8QmLbcM8yYwzK3K7MN0=;
        b=piY0ngxd3VDVwR4flawGJdUl6j55b89ea8uy6VSfS+/QJgtdfpwjXWkVdqGDxekAtQ
         YYTsTn5inhLYoJvK1Q1j2/iHaxM0TTpjT7ARZbwHSKIDkGG4igFig1Qrpm1GTcnDulP4
         yDtrerniizgmaICvNTwkFbowxNLEyUzloTgzRheYl66uu5UcrCMIVl/hCdfG35tBKZGi
         A71kXz/DSF3E3wrnO28HQr7U0x0SPqNyDmjZ0ThHsQcNlFt+/Jj0t0pU75l0wyZu3gTo
         DrH3yw+NFgyAbiN6yDj+SLQMHbLAhaIgJnu8Pb18b4UrbBEweFkq8Gr6QR3hh4X98wSe
         yzBA==
X-Gm-Message-State: AOJu0YzzAIYtvsFMnkJj5Pc1k4j7tVbIdhuoAsn0rnBl97k2fwR8KLoa
	rV3Pb+v5GC5vPUIftJbg7BD2ens4zuUPgYR537M2pkvpu9a/WjuxmaOTx4AtobhPoZRsLkBN1Ci
	DHKM=
X-Gm-Gg: AfdE7cmwCUjadrkSJ70Vpl3oaQg7OuX/JqADuhaA/0pFXGW6s65XeGvwvA8SdgqmmBr
	2prKK0Ro23mn/f6+YvRlI67y9qYgp0OMh1+uygPvzuDj5mfTltKpjeUnWKem3/0hzOcYrFhg9H2
	hAbDYEGA4+34j/OuDo3kS9nM/7I69LTmKGkrUYx55Vp+GnN7ONS3EAltW+wz4IwMp7rlJxGFzDf
	ap+AOdKz4nvGy0OXsMQcTJSbjuXOs0hQKmDPOPXJuYFfQ+WlD6aojNwHoyWKNe+oxJ2m+jI7aib
	RfD6ELJtApwF1HkZSfdFWNCANEl3PHr4WlWRWE5O/2UFfN+mJfKwcrrm02f21G5fLpjUeAyoxe+
	QMXzyMGFdjStEKPKz+k1LgjNR8mWsjibxx1MwWlMw36uXD2fKXocfTd/UKQK5MiRxNtIi7WXeGT
	gCDhEP2Cf9RrqcKkW+RvLKXCmLoX8MoaJ7LVx0N0o/Yl9U3BQj7vMFU20macF/SBf9RSucXEc=
X-Received: by 2002:ad4:5eca:0:b0:8cc:defa:eae0 with SMTP id 6a1803df08f44-8df91df0f6bmr70452796d6.30.1781960873479;
        Sat, 20 Jun 2026 06:07:53 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm31178356d6.41.2026.06.20.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:07:52 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	zdi-disclosures@trendmicro.c,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: [PATCH net 1/1] net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
Date: Sat, 20 Jun 2026 09:07:49 -0400
Message-Id: <20260620130749.226642-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300810-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:zdi-disclosures@trendmicro.c,m:security@kernel.org,m:jhs@mojatatu.com,m:zdi-disclosures@trendmicro.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trendmicro.com:email,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6772C6A8EC0

tcf_classify() can return TC_ACT_CONSUMED while the skb is held by the
defragmentation engine (e.g. act_ct on out-of-order fragments). When
that happens the skb is no longer owned by the caller and must not be
touched again.

tcf_qevent_handle() did not handle TC_ACT_CONSUMED: it fell through the
switch and returned the skb to the caller as if classification had
passed. The only qdisc that wires up qevents today is RED, via three call sites
(qe_mark on RED_PROB_MARK/HARD_MARK, qe_early_drop on congestion_drop)
red_enqueue() was continuing to operate on an skb it no longer owns  in this
case -- enqueueing it, dropping it, or updating statistics. Resulting in a UAF.

  tc qdisc add dev eth0 root handle 1: red ... qevent early_drop block 10
  tc filter add block 10 ... action ct

  (with ct defrag enabled and traffic that produces out-of-order
  fragments, e.g. a fragmented UDP stream)

Handle TC_ACT_CONSUMED in tcf_qevent_handle() the same way the ingress
and egress fast paths do: treat it as stolen and return NULL without
touching the skb. Unlike the TC_ACT_STOLEN case, the skb must not be
dropped/freed here, as it is no longer owned by us.

Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 20f7f9ee0b353..3e67600a4a1a1 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4049,6 +4049,9 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 		skb_do_redirect(skb);
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
+	case TC_ACT_CONSUMED:
+		*ret = __NET_XMIT_STOLEN;
+		return NULL;
 	}
 
 	return skb;
-- 
2.34.1


