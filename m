Return-Path: <netdev+bounces-287186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGdeE8o/A2rO2AEAu9opvQ
	(envelope-from <netdev+bounces-287186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96E52317A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AEEF3211DA7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFB3A599C;
	Tue, 12 May 2026 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM1ZpHVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69A3A599E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594542; cv=none; b=aZElKEdvzUg8G+Ayu4o2RAEXgTq2liTt4v0VlwBuynoFY/AGMIttj7iuDsdmlGyg0+eYqpevckWCP5kGTSAcY3WyJdrwjT4JLfLsXdZUa8M2mfusYcx32Fg2aXJIKodS+tww+2JIRCGk8mAdz0I65Tr4dyIvIU46RxgSvOT1UJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594542; c=relaxed/simple;
	bh=5WlhEMQh9X34pszkCamo0PzCnz+T6O0Wx6dkjqd2UpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B2sKcNk88q5IH3gIUPvNHYs2aYKsb2mvjNNVzAFcqy7nFEPwPj6g90Ff/lMmpzAbOWuVzYtWkSO1arPquqNH71MDFmDrQj+gQH/gfOdHuVsepxod2dHmlmZCsJl5LamixbPjkpGzv0m9AVojNnUX2sy2LZGlFH+TRJwFx/pkDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sM1ZpHVo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so3465e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778594539; x=1779199339; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ail+SStMh4bLPlZ1kUt87DuDvaaI1f9S+0ECKZGp8xA=;
        b=sM1ZpHVozQRQLIQypok2xQUjDek/o4mK9iW1DmoN979vrW9WYcPC74KEyHzzmt8EVW
         qYelecM2t3rg2+AgfjYOKNYPgpjYxCQ0c2UP803uS27H0EGCvtFusqpvtrDfiAeVRimk
         nvReGYQvaPpjmMpn7+hvKzviqKKej02OzotAsCC4jQQJn4FjoVEkxFJ+3PXc+e/R2655
         D0vr0E1mvynYgW4wRznNjh0HHL0p8FZwcDnIgi/gl7u3F1khtCeVRfmE/8rCpoaavRxf
         o3nWYzoGBEG/Z11MJOx7c/tR5y58VoI3q+pYQxxUtzirOauOEO09YGq8H3hcVpo1JpFV
         d9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594539; x=1779199339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ail+SStMh4bLPlZ1kUt87DuDvaaI1f9S+0ECKZGp8xA=;
        b=QbJUJ9Is2dZzBCnLi+5Tc/M6vtct96kPNrftz3h6YbaGYiwPlCyzxXr6Csrj92w+PH
         Hll3F94vewD6OF/OpeFYhvLRcVuPqO46WjQqeYfSUsxqBA7uLZU+Yx1/qFAWi3gVhhmj
         wQVbvJ7jNb7zRy8judJWxPUaEA8eLZgD55gH1M0y4b7lQESjZzjEwYkUlemOXUSDJiF0
         Uhq9x78+gtskqK93uYgmWiQTuwIUseIvG+5IKiWXWnT0E781ozKjPN/+Ev3NZGwcVSSx
         TBK3krLsyrr6c3/038YSiXMS5hEnrnMl6yU8kubZjEwzk5jwjGrHKmOg3GlTuojThiGj
         LAJA==
X-Forwarded-Encrypted: i=1; AFNElJ/B838iqcd3l6EvIUYCp/t2PJkzBGbIoCTTvlMhv+LXAWJD9ku6vju4qwJjeroPZl99ARsiUyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUxStIUzzBeoDMNqfPc9VxyLG7Ps7k6UQi1Wb1XqxRF6XXgTC
	Cf6481Ge3B3lAhnVtj8xGGvwgiQmWR4DmJLS6Gj0yPYiPfyS19WfHCA0yS8nNNSDNQ==
X-Gm-Gg: Acq92OFg/3JLG8Fyg2ImLo3TVEeU0BDBEmLOJSDzp2g2430V4nSZBzFMNXDACNysZvw
	AmpVqy8rmh7IzJFu7Lq79Tz8djDCwQvJiLQpdcAPhlTBKPXylTZY+wVTcWzdD4VdP2z4b/DTWIJ
	PBeoxAqOqyiG2Vk55UepCHB+yHD0LeIojrHS7HV60DFYyrQs2uKoAkLIO40PkgHoTotZUYJWga7
	CLJCq+b1fqrareWXmu8DjQOyvvC7DY0gb8mO2dwgtR0biYnqRM3zbMyO5jD6/ViDUAkbUl16M93
	3mK4jLvottA99rimKcfxBWzHsUdroNGBqY7UqtYnyGqZXzEEbEwHzeUBSvOYP91fitFx5al6AqT
	1KJbACw2umSYNPOW8GzsMlYtz9sPFsh6ioqDYRmQXew/3VyCLyHhdUcNPWjjMrYu5i/zqZVrgv9
	nGGmTM997YKJ4AYTMwhO5UITzY20FKadw52KcAu+cD3/vywegym0PTnWIs5gHdJElxbqao//er
X-Received: by 2002:a05:600c:696:b0:48a:56fa:36dd with SMTP id 5b1f17b1804b1-48e906a0e5bmr424205e9.11.1778594538445;
        Tue, 12 May 2026 07:02:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:118e:a0ac:896b:9240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e62944bsm20059215e9.8.2026.05.12.07.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:02:17 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 12 May 2026 16:02:03 +0200
Subject: [PATCH] net: block MSG_NO_SHARED_FRAGS in sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-msg_no_shared_frags-v1-1-55ea46760331@google.com>
X-B4-Tracking: v=1; b=H4sIANoyA2oC/x3MQQqAIBBA0avErBMyMqOrRIjlaLPIYgYiiO6et
 HyL/x8QZEKBsXqA8SKhIxfouoJ18zmholAMbdP2jdFa7ZJcPpxsnjG4yD6JCsbYVXfYDXaBUp6
 Mke7/Os3v+wF5JhmLZQAAAA==
X-Change-ID: 20260511-msg_no_shared_frags-d557c14e487b
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778594532; l=1721;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=5WlhEMQh9X34pszkCamo0PzCnz+T6O0Wx6dkjqd2UpA=;
 b=hUvaf76umJyRj59Fwa2jB8xSKsjTfjBkUeptCHuX3J0V2Hz7Cd+v3xVeUNVm1PJxb9bGOLjNA
 NJW18y4oxIIAXYkktGx+WbpnWDtzDL7dM+XtIiwPWD2SAmvQP8a7s+/
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: DA96E52317A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-287186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This change should cause no difference in behavior; it just cleans up some
hazardous code that could have become a problem in the future.

MSG_NO_SHARED_FRAGS is a kernel-internal flag that cancels the effect of
MSG_SPLICE_PAGES, another kernel-internal flag that influences the
data-sharing semantics of SKBs.

Prevent passing this flag in from userspace via sendmsg() by adding it to
MSG_INTERNAL_SENDMSG_FLAGS.

This is not currently an observable problem because MSG_NO_SHARED_FRAGS
only has an effect if kernel code adds MSG_SPLICE_PAGES to it.
The only codepath that adds MSG_SPLICE_PAGES to user-supplied flags from
which MSG_NO_SHARED_FRAGS hasn't been cleared is the path
tcp_bpf_sendmsg -> tcp_bpf_send_verdict -> tcp_bpf_push, and that is not a
problem because tcp_bpf_sendmsg always intentionally sets
MSG_NO_SHARED_FRAGS anyway.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index ec4a0a025793..1a4d0d128a13 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -357,7 +357,7 @@ struct ucred {
 
 /* Flags to be cleared on entry by sendmsg and sendmmsg syscalls */
 #define MSG_INTERNAL_SENDMSG_FLAGS \
-	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_DECRYPTED)
+	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_DECRYPTED | MSG_NO_SHARED_FRAGS)
 
 /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
 #define SOL_IP		0

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260511-msg_no_shared_frags-d557c14e487b

--  
Jann Horn <jannh@google.com>


