Return-Path: <netdev+bounces-307372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lyOuEerfVWqdugAAu9opvQ
	(envelope-from <netdev+bounces-307372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:06:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA6751BB2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:06:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=SqcYW6sB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307372-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307372-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44202300B1FD
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350F7364049;
	Tue, 14 Jul 2026 07:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37D188CC9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:06:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012776; cv=none; b=U/dU7zZSxmG30Z7rwF/wwnN7y2VX9TfUYc0aGk0M/IhnOcfUzj2WGZzn16iKCY6u5TZoa3N9Or+9MNeZBuBW1uOUoqHDKI+AyOd6x4shUIgqgOyE+7Gtz/FpsBT6Kgs27EOWMdC9WoG7EUE8a/x7BbO8lU4rv/NHN8qxVtHt1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012776; c=relaxed/simple;
	bh=dgAaCvJUgNsbJbDV3QNxqapNCHCjbfQrCWzRi8Y0MZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxdr/cumoXC52yl3D544jkG5s/FMyfygh/Ic5gZlJ12EKBoUK2FmOw+nJ3urDImqNfZZrtk787unN2ycWkIOgF6eD8i15HCEUfF/M+1hQ/h8b0bzXFGzvvfjTk08nUZtEf9oYrNqzhPNK8/k7YSUz/I3P03FuyMnFs2SKatht8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SqcYW6sB; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5d50b0dbso43211385a.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1784012774; x=1784617574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6g9ahD4oG1/R4wtuY0Np/xYwVS3jEMB1YAMnOuBleng=;
        b=SqcYW6sBj4tzygAnXs+/fT+Vj2EBTHQ9D6l2yc0m3cktWKY3gyq87LHgK/yKSydvOP
         izAEruRsv7JvZJpZ/yXwgq6H4/hVSYl01V31yf94rBQ0n2cRpFydUV2LQ0GmkNLBd+MU
         Z0VGZqZ08wCSHi8L0YqNf9R+FbcP3oFE5LSQsoIsBoccO0k37L8rmlx+clU2j8gnBLGR
         f8pwqU043nBtdv8Suc0PHD1u61GFlnZ10J67LkUR5Fy7eLs0fE8F0kVMDYbgtMBXMZOj
         isgLACVSzdNjerGmBgdf338EmYoam9dmXY9182qWsyoCa1pixclr9JmViSnu+nBKMeOK
         69ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784012774; x=1784617574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6g9ahD4oG1/R4wtuY0Np/xYwVS3jEMB1YAMnOuBleng=;
        b=SY+Nd5sscTq2H42Ha3jyv5GGUt3VFVqr6fDzcTZUFmrVthfrz0YHwCxr4XPWNqZcdk
         9sjld4fp/Go7seT3jmWGBGxBSrWZYlsWSsvS2su2aJLaNhP2nkpo14jn7jYRHa9NOjRX
         ciokzhzISjbJpkRj9g0euqSDZkjTKkFPcpQ1AlOcxmpEKYqZjoR8hSUnUiIs4JJ99a0A
         VBAXmMQbcbFYSOJ6bMoXCjYrc4wurGaPYaouuCZnFQis5MGFUqR95lHrIif+zPJTeJQ5
         w+6pYGAovliXZEodsy6baRX9LhlGmYi2BHNaixSAULlmkAqXisy2iCPDwqsEZ7s07L9A
         DZBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjOXtta1rv0TYCJfOB8MHBniXBPkomB+csq1D1oF5rEtGE30JgtYogvyYj24GmrChoWwleX+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXhar5iEHO/mazr6go1CGwjCiDQstKapyqExevql7vfGYBrp5
	hCIJMMHgUK51UahmBrnkgGGbFXleiV3ZSbuaVJIi0HEuLb6/gq/iIMxWuDBQRGC7jjw=
X-Gm-Gg: AfdE7cmc4GZ/nF8CgAsI54bcj8DFJMxej4IR61jE44PjgfP0tmyR/BP3J2WHUb1dIOQ
	v4kIqAEP9OyUILOfKbi+Y3EErIzN58IhivH78B/UyIx/nAi8J8e0kausOtAqGLdDZeo0likP91O
	zznOzd5XAlOyWz/b4q8cUskLnev+3XshD5pVXhU2SIrhNp7uBAFX/xJcyKtN+EDF6R/kbMHjId6
	Dq1rE7uqkSb4aJfI/TJc5kUlj5mknl/DvbambZRdWrsNWH5aSFpiIrc4p1S24rXbUAMXWERVnrj
	+AL0CbNu9ydkzRLfUsq5n7PYFRljQCvbSMRqDMuf4XLkglGgBQPJAd7EIBEKjXuy3VCQG7yl01F
	/rVlbohTHAyM8tgLjazbktlmNUd0gbapJsvuNKyRkMi9XkuNo8VF12du45nH8Tu0ePR6CK/13Qg
	NHFMbtW/LVOEQ4TMLFHuXiD5VLQ12C
X-Received: by 2002:a05:620a:2892:b0:930:771e:e8d0 with SMTP id af79cd13be357-930771ee8femr292906285a.25.1784012773699;
        Tue, 14 Jul 2026 00:06:13 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-92ee5d69a78sm1390950185a.44.2026.07.14.00.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 00:06:13 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Jon Maloy <jmaloy@redhat.com>
Cc: David Lee <david.lee@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Alpe <richard.alpe@ericsson.com>,
	Ying Xue <ying.xue@windriver.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: prevent node timer rearm after peer removal
Date: Tue, 14 Jul 2026 07:06:09 +0000
Message-ID: <20260714070611.1700456-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307372-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:david.lee@trailofbits.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:richard.alpe@ericsson.com,m:ying.xue@windriver.com,m:dominik.czarnota@trailofbits.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:from_mime,trailofbits.com:mid,trailofbits.com:email,trailofbits.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCEA6751BB2

TIPC node deletion removes the node from lookup tables, calls
timer_delete_sync(), and drops the timer reference.  This stops an already
running timer callback, but it does not prevent another racing path from
rearming the same timer after deletion has started.

Synthetic UDP discovery can race TIPC_NL_PEER_REMOVE and link property
updates.  When discovery recreates the first link, tipc_node_check_dest()
calls mod_timer() and retakes the timer reference.  If that happens after
tipc_node_delete() has deleted the timer, the orphaned timer can later run
after network namespace teardown has freed the per-net TIPC state and
broadcast link.

Use timer_shutdown_sync() when deleting a node.  Shutdown has the same
synchronization effect as timer_delete_sync(), and also prevents future
rearming through mod_timer().

Fixes: b34040227be7 ("tipc: add peer removal functionality")
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---
Trail of Bits has a reproducer for this bug demonstrating Kernel Panic which can be shared further if needed.

 net/tipc/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 262b39ecf5f8..5b3ee44347be 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -638,7 +638,7 @@ static void tipc_node_delete(struct tipc_node *node)
 	trace_tipc_node_delete(node, true, " ");
 	tipc_node_delete_from_list(node);
 
-	timer_delete_sync(&node->timer);
+	timer_shutdown_sync(&node->timer);
 	tipc_node_put(node);
 }
 
-- 
2.43.0


