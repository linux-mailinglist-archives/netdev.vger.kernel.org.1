Return-Path: <netdev+bounces-302237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BeuNODmuPmqnKAkAu9opvQ
	(envelope-from <netdev+bounces-302237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9A6CF444
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=JHtgD3Hf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302237-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33BD9301232C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885537F8DA;
	Fri, 26 Jun 2026 16:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BC344DA4
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:52:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492726; cv=none; b=CGGO6M50y96PBiE3vvv5lMa/R4IBHKZWwKRhwMI1x2/FzmFOgPKIfxQXDX1cKuKMVqgcO6y6qqXymMz1/t1gWO9a7z3MEfJHSknHX8ktvd8djBB3Pb5ewG7hi7iLRG1d/M1VAtHlVBgrGrHQBCqbc4SGoWmvKEdci5+oA18zM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492726; c=relaxed/simple;
	bh=S9nB4VMlAriZcGaoGUogPPb4VsgQmS8LzwAdJsq/Umc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2oCcExTBJY7VxH5aOVXtH7h++VnpM/fjk65NkBrCqwowaGsFhJ9JAqtPsevk1k9yjRZahu6HS/tkFJJxk9Bi6r5w5z2wRP1gmYK1lPoFVWjQKQZyWZbS6XUihvOEIkhmBE2nmv387sqV3VAofhgpfBCS3usLQwRRsoIgZ5LGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JHtgD3Hf; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9159da9bba5so117598485a.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782492724; x=1783097524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQzfEj3d+U9QMkss37KHvB67s0TH/WA+OjBfTOeWvrU=;
        b=JHtgD3HfNgNAZDWulKmid2PEnsMbFpE7Ef/yfCmFKJwLKcMPRpmw2peaADT3wzwLPg
         4jzhXQh4QbQuo5N/BqNdpfFNs8kFnaMiV2ItxXCWtN24Ko2GBieFwd16+2l0ekoHrKZN
         3PKWeFPZNLasHuHLeDmbBKs9+iJ24G7/9K62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492724; x=1783097524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQzfEj3d+U9QMkss37KHvB67s0TH/WA+OjBfTOeWvrU=;
        b=VWLlZNdTFxZ1SlXZTXXwxeMNRLmjm4LnzMY3bWtfJHuvoeGerpIWqu8T4UsdBsm5e9
         Dj9PpBf0D5WwYQuWzc1weoF4QMC6Y+GW6QUORRnDWv/AyF0sgUvrSFSuwayFm3xfsbNQ
         DbdNI4eZ6WVWP5IOanuTpqSCX6yi1/2LVs0i4pIsdJ2Wt7wpD05+8Sch19EdhQJhXHZ3
         GMVikVmjBuE4kDMqDrQPkaEinSBIF32t2lMzEcnk7p+KUV5U+ZvqRr++wEFgYqJvFUrI
         q97l3B3yXaB8ZWWT8cpctrwvGJ4Q49LXDO9UWlSFvYlAWLG4FQhptb8RJkzpUn9yNK4w
         P86w==
X-Gm-Message-State: AOJu0YzJnbG7U4YRcFxrf4gePmbz4D9hOQFxVD9WL//n96/EgIOtSSh8
	1E0dNZp8F0ji85eRddSjaDxYvvzkIdAeBrfBWcACf9vWJsYVuF+xsSHB9LPLkRErJ0Y8GELJN5f
	STk2/hw==
X-Gm-Gg: AfdE7cnOs8BkEaFOKaG0Cq0YwRGzuWAQx7aKgkbmg+xGBPQsaKzKVsfU5P10lhfIq7z
	aKPNjeyJH8s6h9w8Rz2Z+eRJgZ4vB6UWgKf7zntf/YgclmUIkZeT9Uhsk/8g+/h1fCl1TKbXj1D
	l6XAxPwtNkwsMPb75FQQqyJGEp8koUQUJr79UZqpAKPZb+3MbaECKb0luaZif2+0gkrW3F643U8
	8p6DUCUE612cCAS5WDzsTUb6CszuTxXP6Z+3UFH/014baBK4NMbvaIX06qqiLURHZPXU8Nl+s/e
	AIdZDmD7vFLBBXzzuEPE8+z/VUGH8putYEI2DyUME5mJsjKYtzTqJcUmm8LgrAfrfUTpU1NaVOY
	DfXMnJ7oSaQ/EjsdJHtCxuculI7pplFyniTtUHIgFcXyH0xDUOcMPf2jasyrFvZ4H82DqpGmBol
	cnLSat9w==
X-Received: by 2002:a05:620a:43a8:b0:920:bbbc:fd01 with SMTP id af79cd13be357-9293bf2a5b5mr1220351485a.23.1782492723701;
        Fri, 26 Jun 2026 09:52:03 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm1216957385a.33.2026.06.26.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:52:03 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuniyu@google.com,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	victor@mojatatu.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3] Fix broken TC_ACT_REDIRECT
Date: Fri, 26 Jun 2026 12:51:53 -0400
Message-Id: <20260626165156.169012-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302237-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:jiri@resnulli.us,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:victor@mojatatu.com,m:ast@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:daniel@iogearbox.net,m:jhs@mojatatu.com,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,toke.dk,resnulli.us,linutronix.de,goodmis.org,gmail.com,uwaterloo.ca,mojatatu.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21E9A6CF444

When sashiko-gemini[1] reviewed commit a8a02897f2b4
("net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle") it
 correctly pointed out the following:

"
This is a pre-existing issue, but does executing a redirect via a qevent
filter cause a NULL pointer dereference?
When tcf_qevent_handle() processes a TC_ACT_REDIRECT, it calls
skb_do_redirect(). This eventually calls bpf_net_ctx_get_ri() which
dereferences the task bpf_net_context:
include/linux/filter.h:bpf_net_ctx_get_ri() {
    ...
    struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
    if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
    ...
}
Since qevents are evaluated during enqueue, which runs within
__dev_queue_xmit() after sch_handle_egress() has already executed and
cleared the bpf_net_context pointer, will this dereference a NULL pointer?
"

That issue is fixed in patch 1. See the commit log for details.

Upon further investigation it turns out that TC_ACT_REDIRECT being returned
from the egress qdiscs never actually worked. When an action returns that
code we would silently loose it and the packet will never be redirected.
After all those years, if nobody complained, my gut feel is it was never
used by anyone with serious need for it.
Patch 2 fixes it by 1) putting a warning out when someone does and 2) asking
the core to drop the packet. At least this would help whoever is
misconfiguring to diagnose the issue much faster.
I had initially attempted to "fix" this and make it work, but unfortunately
it's a bit ugly so i left i didnt think it was worth fixing

Apologies for the shotgun Cc - its what get_maintainer.pl told me to use.

[1] https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com


