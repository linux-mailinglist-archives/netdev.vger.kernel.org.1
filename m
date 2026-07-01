Return-Path: <netdev+bounces-303442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KM6qFyV7RGocvgoAu9opvQ
	(envelope-from <netdev+bounces-303442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:27:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04C6E93FF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:27:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mbFt8Rad;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303442-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303442-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B144730254FB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255032B132;
	Wed,  1 Jul 2026 02:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE438DD3
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872866; cv=none; b=pLgII+7W85hTVKrxIG7ur547i1x6KvCJklWyvu227ns3LHcJPES6lb1sKVh2jQjy94LT+Sxl1v5+5hyu99ziZV/caPbHfjmEXwlWRFqhPXFQhnCuh5vsozg0o13K7+igZfgOwSvQJTzPrGmGwCuAUZ/NQ3WcdQvwz16n29kihFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872866; c=relaxed/simple;
	bh=ASJbbeteDzLgU0XexrpY74NzlPC6v7TblQzX6hnha+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkSnqQzpWRtxsxG2E/aPThzrX9NFBNnywEkVBfuYWraa55Ke8GGF9MabX0+6mRpdycpCMj9h8c70vVUkUpnXVnDhufVnaJWX9gIsfMSzIfb8LfdLqIZlX2UM1POXxpWc3/zP1F9s/fBHoCEeuW+jn1c9uDia98xgj1eKg21auv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbFt8Rad; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84537d04408so44897b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782872865; x=1783477665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pjv7ncS/ZvY549eEPTpAyU1eZ5j+inDjH3QZwj+bDo0=;
        b=mbFt8RadNzGlUyX9feduPY38ULRLk4EIE2qwbWSpfBhQZEIoE4ZAZ+wZH2vyhB3syy
         Bhp28gITZE3kng4qy3QeimNYD3yrISXoRiT6sg35BV0xnDuMNNu3I+0xyQug8ET9OvOq
         vRUpI9+xA2zv0Kwi8Ypv8Ra4ExntIBOewzNFkLhsk1glxxU/3ROiE6+d4mt2k9I4lhOY
         0nC8h88PObXysYrkSqNyBlNiVnPLFdgB20OcFm1BpwIaCebEPibFOOkbj/a+FzVq4HU6
         jCWeYKJHl1kdluWI6Gm8nvb5iTt7LwbBjfpM35kKTAlCFxSDanqGGmwET313XkD0j1wJ
         Fsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782872865; x=1783477665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pjv7ncS/ZvY549eEPTpAyU1eZ5j+inDjH3QZwj+bDo0=;
        b=KnO/038TGNZCmxQs1Jrm0SOtwyoqgxSGrL1ndKbJziEOBXH/NssXid4Qhfk6mrKjF5
         xPfwSnxWh0gHcuAqSM8FVM0fjzcYXJfZ116XDNBsWRfPLQa0A/B2y4d7IL+Tk56SldL5
         LWUruYTRWhkwv8LzMx/CD48Z9OylQNEZg/FT5XprXTwKv32gx7JiObEbrhHSEV+DgFn9
         nLGSwp8ZLDIgElf0g2e41EEhx0pcKTGUvCoaRpTucbNFG/vGIHMSz1wjpxnsAs3AsyRZ
         862A6FIogIUXepEeAeNCx+tuUJjrjVxfxIQRGT9ykZSxvrxpmMlwocln1nLG4YYtTOr7
         tWAg==
X-Gm-Message-State: AOJu0Yzei0Y5ZtGWs8Qy3JWU0EgWOTN36bvMPvWatolVxzx8UhDZNZRL
	4vu24C8zOhO6Z4d9glFd3hzFsgytCT2F2cfisoIsJZ0WbJDhG9NayG++06tRnNSB
X-Gm-Gg: AfdE7ck3Fp96btwfZoaSqhmQUg1lX28n989m4W8736hzwrk7f84/Xv0zrUYXYGq2Cnk
	X09m1xU0JgAy/YTRzKGCyvZfwP+sLnHnU6LuifcWGE5aCSCOo+FYVOmHstpvRcr1JjRLwi7u/ox
	CcwaudOzDqKtffAIC0h0EiCeJ6LuJNVFANDQ5GqaSL+DMrERZzkFaEZEzE3zZe6TBi/F4rWg1ns
	UrPwHdDl6RP5l6E7N9QEIwklSob5/A/r3hWpGyCgRRlmMAUdCSy0IQW+ANlcqR6KKjKyAxPyqeK
	lcJyRTgRUA1LBoJjUzLn99u0M16gXcQaO36fjwHdkY+jdEVcbZn+20jAtN1acXKkI1jz+wl0Q7L
	3xklMuwaW+NxDxDRi0GET33Hnf5STf7bU/LSXZAhXMvglKJxfvyEmGECqFIiX9jYBfLV+Osh1Ag
	qitqJGzDy62e/2CcP7/r6x65rsocWS0cTMSnGVveW5e8E=
X-Received: by 2002:a05:6a21:600f:b0:3b4:6681:3d51 with SMTP id adf61e73a8af0-3bfc4c32f57mr3563777637.0.1782872864933;
        Tue, 30 Jun 2026 19:27:44 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a005af85sm3066940b3a.25.2026.06.30.19.27.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 19:27:44 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net] gue: validate REMCSUM private option length
Date: Wed,  1 Jul 2026 10:26:17 +0800
Message-ID: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-303442-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:q.h.hack.winter@gmail.com,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,davemloft.net,redhat.com,gmail.com];
	FORGED_SENDER(0.00)[qhhackwinter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qhhackwinter@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF04C6E93FF

GUE private flags can indicate that remote checksum offload metadata is
present. The private flags field itself is accounted for by
guehdr_flags_len(), but guehdr_priv_flags_len() currently returns 0 even
when GUE_PFLAG_REMCSUM is set.

This lets a packet with only the private flags field pass
validate_gue_flags(), after which gue_remcsum() and gue_gro_remcsum()
read the missing REMCSUM start/offset fields from the following bytes.

Account for GUE_PLEN_REMCSUM when GUE_PFLAG_REMCSUM is present so that
malformed packets are rejected during option validation.

Fixes: c1aa8347e73e ("gue: Protocol constants for remote checksum offload")
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 include/net/gue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/gue.h b/include/net/gue.h
index dfca298bec9c..caefd6da8693 100644
--- a/include/net/gue.h
+++ b/include/net/gue.h
@@ -80,7 +80,7 @@ static inline size_t guehdr_flags_len(__be16 flags)
 
 static inline size_t guehdr_priv_flags_len(__be32 flags)
 {
-	return 0;
+	return (flags & GUE_PFLAG_REMCSUM) ? GUE_PLEN_REMCSUM : 0;
 }
 
 /* Validate standard and private flags. Returns non-zero (meaning invalid)
-- 
2.50.1 (Apple Git-155)


