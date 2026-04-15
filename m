Return-Path: <netdev+bounces-278836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EyFM5G732mOYQAAu9opvQ
	(envelope-from <netdev+bounces-278836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:23:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A364065A0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B45F303799C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447E3DC4C7;
	Wed, 15 Apr 2026 16:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A43CF030
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270126; cv=none; b=oNRlgHKJm6469KwDBckqcpGFzib/juR0pJlibQZ/OCMisPbu1NGjDY4XXMpSh9+NOGldFCHcaCzZtQJOEfgff2B1IeAMjV6MXRDggd9AJhavs2srMesEiXFid54ylp0iFBoHDdL8WhZGjiT3lbUwG6Ezred/5cCcrP8q3PRQEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270126; c=relaxed/simple;
	bh=60BWNQow8KA/1jCwUkssd2INilh9p6HszbZr5hYNB/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=et/UDK59hV/8WVB54ZXectnCnWWO8lUl6WM+3wipJE4R25hAyiaAnBPbadhF8w5E7RNlpKb+dslgAe9enV3+W3f/4vwBV0Am3dvlmTz3mOTrgOTmSfzVo6fkD0Ht/ie0zjFISYyyNSV5JqS8s2TIi1iBde/FamVMzOKASDFKUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-40ea48ccbd2so6050550fac.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270124; x=1776874924;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60BWNQow8KA/1jCwUkssd2INilh9p6HszbZr5hYNB/w=;
        b=o4XKbnsMpBaaS7SLYs4jFh//bGcX+AeD2oEgHuKbMZq9k0TSaSHMl9pTSsvphsTUzo
         YvL06hiE02r+nXvXSuTt1CBceAougc3ly21+rffdGpWU9Lj6MGHkHOGnaK0tUyXz9+C3
         BjJd8nZNq7ONNP8UD8ULPu8iCTwpvP4iNr+is5ulH8k+OsOvzzmicdCcJ7Qop2EFvrth
         hD2tDNgNQWwvrmHcvK0OOpUJOJ6kO2v/ife3xdIeXlDG0T8dLMZpR8LvVyU0/N/zm8y0
         UWVkwCjer3lFH3lVVwSU782R+lDwOJyyvzmzVJlLqrDHdnB8sT1L1s6wWatPQdEWhwBS
         WeTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xECZ5DDJalAfqFkXCUgdInf4aBK6Cw9hE4P7tlbV12mMAsyvwRNZUl0jTGog3nwQJN9HfMpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmP1l9zFcdASPPOpbqedQce6qoo2paiLpPOMsWCHloGR9tV60c
	F894JiKTm/HJyxd9F6RV+OXyc5/9F+e8tsn8jxtPZuVyB9DgcAYmjWLblSwoljdhbUQgaaYlWFB
	APJmiNnUgA7MJ/Xqlt4Meu1Vfx9pPCDkev8nrOyYdi0qpkiXrzGL/APrx6zM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f024:b0:67d:f523:5bde with SMTP id
 006d021491bc7-68be596a99dmr11083641eaf.7.1776270123982; Wed, 15 Apr 2026
 09:22:03 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:22:03 -0700
In-Reply-To: <20260415130533.849053-1-nogikh@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dfbb2b.a70a0220.259bc5.000c.GAE@google.com>
Subject: [syzbot ci] Re: veth: add Byte Queue Limits (BQL) support
From: syzbot ci <syzbot+ciebb51dbf2354d2fd@syzkaller.appspotmail.com>
To: nogikh@google.com, hawk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278836-lists,netdev=lfdr.de,ciebb51dbf2354d2fd];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzbot.org:url]
X-Rspamd-Queue-Id: 40A364065A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the suggested fix patch on top of the following series:

[v2] veth: add Byte Queue Limits (BQL) support
https://lore.kernel.org/all/20260413094442.1376022-1-hawk@kernel.org

Patch: https://ci.syzbot.org/jobs/4a19c4e7-8505-49e5-b80f-6107406612b0/patch

The patch testing request could not be completed:
Testing failed due to an infrastructure error.
Testing results:
* [build 0] Build Patched: error

Full report is available here:
https://ci.syzbot.org/session/67022682-86d9-4483-a528-4d95990f8038

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

