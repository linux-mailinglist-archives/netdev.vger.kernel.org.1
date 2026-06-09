Return-Path: <netdev+bounces-296806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L7G2FeFgJ2oOvgIAu9opvQ
	(envelope-from <netdev+bounces-296806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:40:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC18A65B647
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b="VHR49T/a";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296806-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296806-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCB96302304B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB219244665;
	Tue,  9 Jun 2026 00:39:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA4175A84
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:39:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965598; cv=none; b=T15FqvuRbat13BuBYySAlBFqJ2MaOMFLHawV+sd/xJ5BwurlUgbrmSiRrW1ieHULI+BeUyc5jDkl1AD3BucO9/AQ/xoWFeWjAX9ZH+TEgqnmELkd3qHB6RT3gT8HPdtPkHdjavl/xHgjpaHsOm/SizRxxXS0tbEG6tAt7SZa+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965598; c=relaxed/simple;
	bh=p2uZsKrxUEOpWe7djXbdx8DpJ28EDQYdmntByMBO3MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+VNqt96BTFa9stJjxYsnKP1Tu2kJbobeVo/NiMhsYwb/pHT0Y1hfYqHd+QnTpSuIU3EoRQoTF+r+q+vxz7dMTalzox2jmbC8OJsl24DooNtrg38Ekcg5fXMGohWqnCe3ALiMTwy8nFLDrz0dNTiuAVFzYR3qDLm3tzumJoirm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VHR49T/a; arc=none smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915ab38ac14so538993885a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965596; x=1781570396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7lLYRcM+Slsi647qvlOPdQJaKxOeDZsJe3wtKNrsbE=;
        b=VHR49T/a40vOtbOiQV2Ac23wEzPv+JGw85WOXX0z0q+xw0s+gzpmNuUVsSkKnJZP+h
         K7jlztv0CrMSiNMtUy+oSJ9Lr7InShkE5VF+5ndxgSO0/YhYMiLx8gHYd+Aqf5dN0Cfl
         kPMp5o8fnaORNXgtU2yrlpoHBZbn7a4QvzlxeUX+upbmvFZYyfJH/5THPk4jMa4oMVke
         Nxi5l4jl23K/64s5iyM+9PPsHcJAczMEw82ORv+cuP/j0KsZjd9EFjP4Y2UiW3ZfvIc6
         Eps8wJEA2t/6F+6lmnuqfnU5r5ZHb8+ouzl/RifpvxJLrZT8qqsO4DE7o8GCbSv8iQdn
         ZXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965596; x=1781570396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7lLYRcM+Slsi647qvlOPdQJaKxOeDZsJe3wtKNrsbE=;
        b=TubWqLM9Q20Z53zVa2LEwLF2m+Y4p3i8wBwEDvO0alUhQI08jsVP4x8MOInQ4QRfRe
         xB7PVcyJ3EF9JHX4+SfKF1r37uTeNE3MvQVyJ4AApdxmG44CU0jJGAmWLaaXcKF8dK6n
         O5ahaatoP9NRW2o9NS76F2wMojXJh3AVhUXSClBT6WjxtjJzg4v+cJMSmugYSQkIJRl0
         AbROuSIicSpmbGAcR4FgMIqgqjpOBIAoF4vjX+EIIJpis6iJh+TEcSLG3TYssw/24f4B
         7K+gsxEpzeMrRay7oSW5jfhtiDtOwRnHRvY9U5H4PDfgDKa+DL+zo3KFCPx5hN8134d/
         gBZw==
X-Forwarded-Encrypted: i=1; AFNElJ8ajfZrFtJnVGyRvaJTZzDu5IOdaH1DtljuwpetGOcAU/ryCiiC5fWHZwSldA+5yWJ/uPVchmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2/Fudzaz08/Oa7kh6mGi4ZEGLHgpa7kP6TzOdB7crOcNZncg
	vVXfic9pAYD8YGTZ+A1lkLK7Fom8HxmxlloZ0knvDFJKD+IJdILHRaec39ssDYgdJxw=
X-Gm-Gg: Acq92OGFk19kOg6m1b9HLaIQNn/sx+m9tpBKjzjsNfNPvJZ0p7wHFoclTb6KA5wqvP6
	ZiDEhDutCTsun+rRILS2jeNLOF9QowLidHMhBJeOSnvDMrbCa/oHfIDB0kZrk6IqdXKRFFggDDb
	GS75wGbRSG+miX9kreENCPXfJRRObHnfQZi0PSBg8msB/STDUXitCWBXLYblm9pRvWUq00KWQnY
	9PixfIWyOagTNXbUDgWbvEaoOx30qhrOkNDypEtcWm5eJSGLIzWlK3JahScHKh/18LpVbJEXW+r
	eep1oT6p+K9I9y3UUu6500fl9icE42OQlh2DbaBS+qfl+u58lUef6OMXE9ayT+GM4gW6JiwExAo
	kHoOiMu6kaShkSRX8CDgCPpAGdBCY2hpVg/b4spsSeMdbLb/yGnD11rKyNe3on+5etma3yXqs+7
	0LitgaMiFZfGkObMf45/3An3xTFDnu/jm5CDoXoQ==
X-Received: by 2002:a05:620a:bc5:b0:915:5215:d90c with SMTP id af79cd13be357-915a9ddb310mr3077996485a.51.1780965596639;
        Mon, 08 Jun 2026 17:39:56 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a37bae6sm1925910285a.31.2026.06.08.17.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:39:55 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: fq: account internal fast-path enqueues against plimit
Date: Tue,  9 Jun 2026 00:39:07 +0000
Message-ID: <20260609003907.1238501.72ef81046550.fq-internal-plimit-bypass@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296806-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC18A65B647

sch_fq has an internal fast path that can enqueue packets without
applying the same packet-limit accounting as the normal path. The queue
can grow past the configured plimit through that bypass.

The packet limit must apply to all enqueue paths.

Charge internal fast-path enqueues to the same plimit checks as ordinary
enqueues.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_fq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index f2edcf872981..608ff3ecfb16 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -548,7 +548,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	u8 band;
 
 	band = fq_prio2band(q->prio2band, skb->priority & TC_PRIO_MAX);
-	if (unlikely(q->band_pkt_count[band] >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		q->stat_band_drops[band]++;
 		return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_BAND_LIMIT);
 	}
-- 
2.43.0


