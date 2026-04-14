Return-Path: <netdev+bounces-278266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Nx/Czua3WnYgQkAu9opvQ
	(envelope-from <netdev+bounces-278266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 03:36:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7373F4D01
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 03:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3568D300C3A5
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2482282F3F;
	Tue, 14 Apr 2026 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXo+m01/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397C18A6CF
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130613; cv=none; b=AQuJRoHStXhokdL0mCP6VXPlTgBqeT1UARZtxO27rLgnRBcTbjAVXlajymukk6P6+TgI2ipKrnhPF/HWEnREW7Fnsbmi7iUmUKULsz8qmjWJ/Jx3M/GcThWDV5pxgumbKvjmC4QFlyaps+n5RoFCs9AWW+ma5iuu+S6Wm28Wxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130613; c=relaxed/simple;
	bh=d5UlmNalWCQoZ4e6uJYE5P2Zk+Z07Jv/ZTdNMzAZsyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8YaQHzR1FcHkPx90vdtmY5gZRZUkf7zMwyO43/aaPg7Mzr0+3syoUKdSI4OYw/0sCwm65BcupwVrya3ZHvN/+odZKkEmMW40mTjk3kVtmso+HTSLscd8WJY1F/Sk2Wx6P1XAKRJRuqNpPIqcVsHEhEFP1xqJySwFhE+q+NvvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rXo+m01/; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7a43424f861so45714777b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776130611; x=1776735411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiwC0nN3J/8Q3Qiu6rau93A5kKDIf24Sz7oLusSxE+4=;
        b=rXo+m01/a8nAkjYTMZ6ARGwHXizzaO8ZFLk5s4hmS2JLHoE2xLUaxqOwxk+WmeocxV
         hTj2WImOrjcsab7/ElLIKPY53HW/AIdaXWrQEamE/G7FoKfGujZ7OxMUO3+SUZTVtS9v
         y9H0g3IZlwYQVywma8f5luazS8Nopnn6yaIcYYBkS0RdAJnwU3QdejnVv2Ee2rTOlih9
         HFYntg0a/2rBOICrqzMxydw1lafhrL1iglGg8eQNFwK7zqhersNwztAIx/YrGL5UnTpv
         6hm3ML3wkhPFnsxCKbQVm4b7vZ7zr6chyVugu1zSW/wTC57Xu62QkG5piEHyqG9yEFNj
         qWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776130611; x=1776735411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiwC0nN3J/8Q3Qiu6rau93A5kKDIf24Sz7oLusSxE+4=;
        b=FyMSCLn4R5NChmPF4VS/y/gy8fkYRQykz70xwKYTeIJASMK/JOwZWUYg5xxNSZyCMY
         mblUjp+0jPUkwo6NQmyjGnt+2xDXlgZUjflnz47yNifS/NGD/D2WGeQUhusoAUVjrWqV
         AZIezI1udhWQHgWzGxIxc7xnyU+9NXNlyf4NorkuyMnlAsqUj3f6SbGaVJaQmADbjCMZ
         ew17EQ0OZjKg+GDHUaQeloh1blYapY427HnCIoz7YI4A+AUm6eWVHq4ZQUOew1V+xg16
         IcV5ou0yr3nn5y7audnNyrTu4sh7SZnvzyJgfy7Gfb4lDS034i97orRad1z5TUM9+d38
         i3og==
X-Gm-Message-State: AOJu0YwnqVQGQ3bv1uR/Xa3ceCRjkfA8NekY3oyWkCEfWdR6VIH1mZQG
	SYEWCkOpLNPwxz2uTkounwYdekCjWJm5NbUHGTiliGpuaEI6sBJxewFc
X-Gm-Gg: AeBDiestUBETRAgGczXf7YDh0Vo2CAbppDQ311cNVdmcVjzLo6jQjiXU30awYAIABmd
	N/FyQMvajdMNc+NpwCkRC4jrDdmuFfdN0D16Exvt3UySOdh5wjd6AOcLIzZTQ23dFZoT+q/X9iy
	Vn0ISZPCYNUi3hOirmF9exfzJFNzSfK3BWk0tH+TRhFigmioWXBwifjdRBQBxiqcg+SPIVKVQGg
	sAG58WP5EQUc1oYd4OkOUmkUFT5lTbSi7DafFoGWWTxfQMUjOC80sUeUKIROP2fWr3/pt/wcySL
	6qiEKRKBgdiOj8lIFbedzCQNKg480SMe3xh1EApZuBvna0BQZpCRTaoD4WqmP91bMLkLtVfyG+X
	Y8Z7YlqLLgJ7gAR0a6wkR0mkQCNd7hxKcPGg1UumaZRx3smYGVPmGDUzTBGILYhBPcAkf0wYwdz
	veGjV5oKInAaQIaVzAhS0nF5FDlg4CWnzJg+vwBhlbNu2kyPfJxP8Z
X-Received: by 2002:a53:ca4b:0:b0:651:9544:fe1b with SMTP id 956f58d0204a3-65198b46f97mr10720206d50.35.1776130611499;
        Mon, 13 Apr 2026 18:36:51 -0700 (PDT)
Received: from host.td.teradata.com ([2600:1700:7c:96e0:833a:bdf7:5b7b:e154])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-651c18f9960sm2792893d50.3.2026.04.13.18.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 18:36:51 -0700 (PDT)
From: Altan Hacigumus <ahacigu.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Enke Chen <enchen@paloaltonetworks.com>,
	Altan Hacigumus <ahacigu.linux@gmail.com>
Subject: [PATCH net] tcp: make probe0 timer handle expired user timeout
Date: Mon, 13 Apr 2026 18:36:34 -0700
Message-ID: <20260414013634.43997-1-ahacigu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,paloaltonetworks.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278266-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahacigulinux@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F7373F4D01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
using subtraction with an unsigned lvalue.  If elapsed probing time
already exceeds the configured TCP_USER_TIMEOUT, the subtraction
underflows and yields a large value.

Handle this expiration case similarly to tcp_clamp_rto_to_user_timeout().

Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero window probes")
Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
---
 net/ipv4/tcp_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 5a14a53a3c9e..4a43356a4e06 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 remaining, user_timeout;
+	u32 user_timeout;
+	s32 remaining;
 	s32 elapsed;
 
 	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
@@ -61,6 +62,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 	if (unlikely(elapsed < 0))
 		elapsed = 0;
 	remaining = msecs_to_jiffies(user_timeout) - elapsed;
+	if (remaining <= 0)
+		return 1;
 	remaining = max_t(u32, remaining, TCP_TIMEOUT_MIN);
 
 	return min_t(u32, remaining, when);
-- 
2.43.0


