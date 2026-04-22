Return-Path: <netdev+bounces-280278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH8PBiwR6Gm2EgIAu9opvQ
	(envelope-from <netdev+bounces-280278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B082440CA1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE0E3025721
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AAB40DFAC;
	Wed, 22 Apr 2026 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFWvnhUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF271FC7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816425; cv=none; b=EE4GtMSuEEGFMsoYCiwn6lVltTF46EYyXp3axkzUXdqRzWY5ekow3iSEDuiq5B+ddjkL4k36xaVz39tSk7zGmaia2ql4mUKj5a7z98bMPh9LC1Cw8vLpZ4jINHcitMXWMzE2OcBEYzg0KxhgwLFHYe03uO8CHP0BtkOiWgjJ4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816425; c=relaxed/simple;
	bh=wVF1iBXhpMscFx2tY5O3cc38r3BrEeXQDR9XcKj4S5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eo4S1x+0YFAKSI1JaFjzhAgmYzw4tmaplMujTuX6Z4HRJnwdX8ndJuIzMbHIexF6o9I7n963X92AejyjVU8Qp7N+fNVOXGaTy0dk/e9OkendRwg8U6QgzgmwUBYGr9XZwwHum5/V5ZTwRsqEdHiafG0J/JUYRn/99kUoymS+r8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFWvnhUP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ee63e91acfso95013285a.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776816423; x=1777421223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmKKE5FYITyhTGVg5YFLJddC5/jrSBVncuDRBnt19M8=;
        b=JFWvnhUPv5PUZsM4AINv3lpn/PV/yYDsw1O33Nl5jCcOP45saPnHwD02awFwkdHtUK
         P+ySZzl12XL7bSONNgpRQzte5YuxA1HiwU76082A0QKjcENJZXI5husb1WL/6DNS2avG
         bUAZg4GUv/TiWneJuEd594fvQJkQS8GAce2dpf0ePUyWdPEnYRbl69PwR0N/bFPX9zHD
         YqwQigMRBUGZ0Fgj0fO5oBTFUEQTuS2Lz6V2CLlVZk+j9pQDvEvzol3/e3m217HX9S/U
         sU3304ncqE8U2LgBzuTa//EbugoJt4v/5NG0BQcYYk3DyOp5I0I9kN4Q1Pz4dqfV38ew
         KpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776816423; x=1777421223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmKKE5FYITyhTGVg5YFLJddC5/jrSBVncuDRBnt19M8=;
        b=XrJ/XA1V3oxgLTNETbKF4IVsqMhTLLoKI8yXEzAZWTMak2XLLkV/l8Jve+QBBx0ODJ
         gSXlE7dO9pL1U28GCkqHXFSFoamCkln+u195oao4qJChVXyir3jOSoiZB4dMkEnmS1wq
         mFx0TrD/RNAG0m0IlWXzFdJnvE9oCIOenNmA4K2U4y/xt6TNMub8hGDrBjk3S2060eMO
         lTwR3A8DjNpNcpsXA6ELWsjgNNYtcCpJIbUp7tIAEAmtNqDGSSWo1dxjnKNKW/wWUsHd
         UA+PmeFD/6ePJcgCShxlC1xQug9IJcvRRhuDW5M+B32Bt34Kdp252Yxx4VuN7MtrtG6s
         38QA==
X-Forwarded-Encrypted: i=1; AFNElJ9BElFQ9QhbTp7KnJbBUrbOSzRS2dLO9SDrp/QFjq84xiRIwsEHyo/bkCqAqxYnrnMlwtwD/88=@vger.kernel.org
X-Gm-Message-State: AOJu0YysESShNzVDPVRwzPJudljF+ZRnOd5okngbq5zDR0GS8Tfs1mOl
	II8Mv4Pr4eAFqp28BamVvrSbFERc/dI+edBhViHUSnnAIlzfEIv0aTn5
X-Gm-Gg: AeBDietlrgWl/c5hyXgYoWgqLqyhRfuutt9b6Q1U6AWiyQ9HZ9Q+41nODTM5+5/6nIL
	3FaL+eBc48DcIKxo2Jq1k87lKzhFzK4FzPN6m8W+Eo1x1/9EWfgq8ukihmp5xTzoBq+sO0dWxqh
	pjIq4tpfpIvOC/lyEfc7doQ/4FhCeg84F/skkCkBrtLy9cRXWQVgVS8b57eoN+ckxxUXykNxxhw
	9BL1O2YmpC48iUU2thfNLud5EUqPnBm7zgU5Ga2D3M2YFCfjjId2N9AvTUhC1JVoB6LD13+oSfF
	rBx5N61oheO/SZ+iXkp7xbRPRKzVsF5ojMPHRz7G9aWNSWW0simWjrchIarQEGV2Xc6j0SyKz4q
	VXVcCJ0bvpcVl+SSjTPM5kufmUznu4zJ5qDUFEEanHLkMRLpIFNrVK2cKcwmztoqt0mFZsrBbJe
	VtSogqMu6l9XFWcWlZFhU0x3erTTd9i1jfMv1LqbU8FMQWrkPmyxaJMgJyGKQJIigPqRPKmacXr
	CJsUqY2py8HaSGKTeEnmsGLhSUpzkQ=
X-Received: by 2002:a05:620a:17a3:b0:8d0:27b8:fb7 with SMTP id af79cd13be357-8e79246cd79mr2879505585a.46.1776816423026;
        Tue, 21 Apr 2026 17:07:03 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1177984585a.11.2026.04.21.17.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:07:02 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH] wifi: mac80211: check ieee80211_rx_data_set_link return in pubsta MLO path
Date: Tue, 21 Apr 2026 20:06:51 -0400
Message-ID: <20260422000651.4184602-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280278-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B082440CA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__ieee80211_rx_handle_packet() resolves the link via
ieee80211_rx_data_set_link() on the pubsta->mlo path but ignores the
helper's return value.  Inside the helper,
  rx->link = rcu_dereference(rx->sdata->link[link_id]);
can leave rx->link NULL if link_id references a slot already cleared
by ieee80211_vif_set_links() during station-initiated ML
reconfiguration (see mlme.c's ieee80211_ml_reconfiguration(), which
invalidates sdata->link[] before the matching
ieee80211_sta_remove_link() loop walks the link-sta hash).  RX dispatch
still resolves a link_sta from the hash and then drops into
ieee80211_prepare_and_rx_handle(), which dereferences link->conf->addr.

Every other user site of ieee80211_rx_data_set_link() checks the return
and bails on failure; only this branch did not.  Mirror the safe
pattern.

Fixes: e66b7920aa5a ("wifi: mac80211: fix initialization of rx->link and rx->link_sta")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

Notes for reviewers (not part of the commit):

Found by static audit of unchecked return values on
ieee80211_rx_data_set_link() call sites.  The non-pubsta
arm was already fixed upstream by commit 32d340ae6758 ("wifi:
mac80211: fix receiving MLO frames in the non-fast-path"); the
pubsta arm was missed, and this patch mirrors the same shape.

Runtime evidence:

 - Synthetic kernel-side A/B: on parent commit e66b7920aa5a..
   (pre-fix) forcing sdata->link[1] == NULL while sta->link[1]
   stays live causes ieee80211_rx_data_set_link() to return 0
   and ieee80211_prepare_and_rx_handle() to NULL-deref
   link->conf->addr; with the patch applied the guard drops
   the frame instead.

 - Source-level race window confirmed observationally: an
   instrumented pre-fix UML run with real hostapd + wpa_supplicant
   MLO and station-initiated SETUP_LINK_RECONFIG hits
   "sdata->link[1] == NULL while sta_valid_links still carries
   bit 1" on every reconfiguration attempt, inside
   ieee80211_setup_link_reconfig() between ieee80211_vif_set_links()
   and the per-link ieee80211_sta_remove_link() loop.

 - That same instrumented run does not itself crash, for two
   reasons independent of this bug: mac80211_hwsim feeds RX via
   ieee80211_rx_napi(hw, NULL, skb), so the pubsta arm at
   rx.c:5335 is unreachable from hwsim (frames take the
   already-fixed non-pubsta for_each_sta_info arm), and UML is
   single-CPU so RX softirq cannot interleave with the mlme
   reconfig sequence.  Real MLO-capable drivers (iwlwifi, mt76)
   do populate pubsta on their fast RX paths, and SMP hardware
   gives the race the micro-window it needs.

Benjamin Berg's 2026-02 RFC v2 "wifi: mac80211: refactor RX
link_id and station handling"
(20260223133818.9f5550ab445f.I...@changeid) touches the same
code and may supersede or subsume this patch; happy to fold /
rebase / drop.

 net/mac80211/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..e0ab4852c0c6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5332,7 +5332,9 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 				if (!link_sta)
 					goto out;
 
-				ieee80211_rx_data_set_link(&rx, link_sta->link_id);
+				if (!ieee80211_rx_data_set_link(&rx,
+								link_sta->link_id))
+					goto out;
 			}
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
-- 
2.53.0


