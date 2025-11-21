Return-Path: <netdev+bounces-240726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B40C78C7E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 870702D90A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336DA348889;
	Fri, 21 Nov 2025 11:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C49335541
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724398; cv=none; b=q4hJua2orfKIYQFSGaVMfIeibRcbAjqhKW1nq3c3/uPy6HcEsZMYRRI4z3IQFFK7co3km/P5h0d9DCcgCBpfjHrywEI9AK+n6ARKfRtdxgSD7hxp/hZoLhf5otq2aVGolmRHYlbnLfq5RaJUHR5bEjH88pOkn1mWfqnpVpcfKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724398; c=relaxed/simple;
	bh=lVkterAId0pZtiHs0zzpoVow0duEjuPv9au7v95C+hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQMHWP1k1UPOu4x40mY4F/M6XAu5n20dR3OneVluHyF1l78Qs/zAyCtejdkLVMjtHqpmPuBjKQKOpJOfi5s2s2zMu1uQENWe03beEzRbUqOwtjIS39XfJiDxHV5aG2HT/b7fzDIu4pHFEGI89eI3B0qDG9adSAaHrJaI4nIA+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c77fc7c11bso1331701a34.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724395; x=1764329195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdjZB7D08cpEMTpXxqr4wUEPbtOidnkNlVo7PKpUQyg=;
        b=hrifxt0Bdvnvz1yaOUbh2gcMCNs9ck442rzZx+CGsafScFa8nOyVe5cyYSQhOBv+Ea
         PzWKgUiuk5MOUJCA//Vjld/iJtXmogElTkUECJS7WWWujeSFg3gvyCF3Dvay/0xvrHtZ
         O53QaNAxLXOL3VbG8Qwjx7lcT8tYr/f5GJgQuAIC82NUMjTwyAroPRkWTdCDHMCpQ8wT
         lFkgpf03JY3vwvedS7V133f0CYHPgi04oycPU52p8zwoQG9Zrr6a5ftQg+YaFgcP1jzO
         JVJz0/Gz4H2sGVd5zIwbjJW9ECZrYff2m0QlQ387frKaCYHKE8Ix7FW5Yn6YZ8P9J5k2
         1XRw==
X-Forwarded-Encrypted: i=1; AJvYcCWbku3+fbSVox479i1JCUWW0kRONcFOwzIVqWRVJcBQBHkzQyKEhe/x5VPU6d2SGH+GA6RIR54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6oJXHE9Tn4q5fPrgdeiqKZWEDpSlwVEjbuzc1MD/uT39Z+dQK
	21BrHvoyV1FfX5ls54Th/meq/7Etw+9Viy2Mx72eWnfEMpz6F1vU3GVg
X-Gm-Gg: ASbGncuq0Z6mPjkSJ0+PcaLvRgWwoxnW1Y2mAG11WbAuby1mId6OFhBMEQ8g2d9Dw1i
	5BbV2rDIykusugMdIvtdplYI2kpeUZlPLMHC66ybvFDiai6AbbsJfHradxMP4dpwt1JM2W3YsNM
	R3RRk0DAomhgq/t4dkhSXPNqZ3a69DMwGVDBXJkIRuY24fHuAgwxCC6yTi/wFwp6G4JooP6YDbE
	/BFLqaH/MDAnQc9u9KsBBAmuUx44/pzGosCS4wGSkrxe6iaC/FIp01xWJSbjdSLfHuDu5Ja3+LY
	57xMHoLwBnlK/CN3ZwZdBPs5g7rqfckCk7vi9SczE366dLq21f6DKQHcQ+/xaqWRE8+e8e2gG8v
	2jSQaAeDHFClXFfNKq8esE72FZtJGs6QH8e9YH8jZxKTuL2aIv14OEZny8bWC8KoA4yzjnMtI0m
	JJIQu3WyV0+C8DVg==
X-Google-Smtp-Source: AGHT+IEwjUrwzMg7kt3g2ZGackcxWJ302wAVa0D7l6yCytkbxJYXnQqTOhQNiO7tRLNJYvD3venRrw==
X-Received: by 2002:a05:6830:4108:b0:7c7:68d8:f70f with SMTP id 46e09a7af769-7c7989f089fmr1115747a34.3.1763724395410;
        Fri, 21 Nov 2025 03:26:35 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d305ccasm2094895a34.4.2025.11.21.03.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:26:35 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Nov 2025 03:26:07 -0800
Subject: [PATCH RFC net-next 1/2] netconsole: extract message fragmentation
 into write_msg_target()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-nbcon-v1-1-503d17b2b4af@debian.org>
References: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
In-Reply-To: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
To: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
 horms@kernel.org, efault@gmx.de, john.ogness@linutronix.de, 
 pmladek@suse.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, calvin@wbinvd.org, asml.silence@gmail.com, 
 kernel-team@meta.com, gustavold@gmail.com, asantostc@gmail.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=leitao@debian.org;
 h=from:subject:message-id; bh=lVkterAId0pZtiHs0zzpoVow0duEjuPv9au7v95C+hs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIExod16+IHaeSvyyS5/zJbZ2JeyEy3IOiZVzt
 oS9NdEqC4iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSBMaAAKCRA1o5Of/Hh3
 bZaCD/9sCHn7CuOXs5nhOaYQLAkb8jk5FeMhmT9BnoUmmv/PGQTX83UDsg5cyJJ5Ffn2efvM77F
 r8DQ32WPtc2qZdpDfOCFm9uLebGntqI09g0jB8qnXHbUDBksI3fGq7NKPZoKm1bTHx25SasYFPx
 yBDE++L5Jc2sJkoJx/1K1RH2mYTV/U+8R/8R6S9Yl+iUlswfxhTSorh19Rd2zN8+xuP52PIA2Pp
 Xb+z1YC2Q+PWYe9aqcNFzxZyim+/Gs4mk/4lhHzjYX3T6CnxfXMdRqCWnpXHZSjRP5TssgQJsea
 meR+1pyJYF1L0j2vkqfFZIIQSvPj05DjXVAMdrHFFcEjMTjo7dqNZEGZ6Zpj5jTf9KAJILaRLSi
 lPN9o9LmCTq+d2FeJSxZ3wWXYeIINYhq0grbYbYiqRCI3zXufmuAAE2SWaARwXCH4A/RPmOwCqW
 PUsy5rdBfNq84CkVEymagUuufxUOl6Ae+0nMTh8sweOKalDY2AfTZbbAwVGWpjtW+b+E0sVXa8i
 p+Aidz95efXIOcHQ5I9im9UM/81C213hekx6+zV+UA6ak3r5wSujCNZa7aDNs2Y+YxtsD1fMjV8
 xfL3LuuFsVtZzDAOe21vV3fskAQF7Jia2USi++ZjDOGPVngqrKdCbqJN7ZUJLTe6ON37S0OO4gg
 s1prPw4GSWTVYjA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Refactor the message fragmentation logic in write_msg() by extracting it
into a separate write_msg_target() helper function. This makes the code
more maintainable and prepares for future reuse in nbcon support for
non-extended consoles.

The helper function takes a target, message, and length, then handles
splitting the message into MAX_PRINT_CHUNK-sized fragments for sending
via send_udp().

No functional change intended.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..f4b1706fb081 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1559,6 +1559,20 @@ static void append_release(char *buf)
 	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
 }
 
+static void write_msg_target(struct netconsole_target *nt, const char *msg,
+			     unsigned int len)
+{
+	const char *tmp = msg;
+	int frag, left = len;
+
+	while (left > 0) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		send_udp(nt, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
+}
+
 static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
 				 int msgbody_len, int extradata_len)
@@ -1728,10 +1742,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
-	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
+	unsigned long flags;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1748,13 +1760,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			 * at least one target if we die inside here, instead
 			 * of unnecessarily keeping all targets in lock-step.
 			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				send_udp(nt, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
+			write_msg_target(nt, msg, len);
 		}
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);

-- 
2.47.3


