Return-Path: <netdev+bounces-306653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o2UGLNg2UWqFAwMAu9opvQ
	(envelope-from <netdev+bounces-306653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAF73D483
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Dk8ZRoeW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306653-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306653-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A57A30182A7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0D3793CA;
	Fri, 10 Jul 2026 18:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DB379C43
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707160; cv=none; b=plJUXTH6uI/RpnSyR2e6wyUFPANUeJ41g2l/1zWjZYHOXWiNXH/9aKqKaY29wLnxcRVmLBBmeSCnF6na/oGN9FaR8RrCLWwR8J2CjUVtBv9oliWA+W2ljEBAzYV2xH4vTH53C5l5Mj0uaDKW2sFxVMg0U71ppjm0yfnaJsHkzJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707160; c=relaxed/simple;
	bh=HmVx9/LS+hVjcUQ6NyKEX8ixmWtWS09UvwEdDjuSIww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ap3D2vF+uNJr65NZJNkgxVHEnsu+02a7YSz2LRsIPz/MRm/4ApNLWI5KKNoFnLMkAyTRcVYNryylZw/hAyoc8sWUDCfhhWtpL59Y2uV2NumV5XUsWn7bR3a6XcCisMsgBsSohr0XcrO8N/symwckhLv6OsanzRXa3AIVepVcHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk8ZRoeW; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5cb052edso92678385a.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707157; x=1784311957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bI02IT26f9J98q2x/cBgGT2CgXZdiDxxE3v83TDsdk=;
        b=Dk8ZRoeW6v3ERM2XnGhror4RHK6ia1PAHcdhn2ROc47GsS7rbrh459PKnbvgqkEpBL
         S9xQOAdGpRs0LECNlAR5b6gOzg6vbrbIIY5wHTJ2qWZjsAAIS6CL8AN0T23dgidINV+8
         fS0rpGzJSsoV6jJAuGHNQpppBtzQ/tW0No9WQls9bHnWIzDZm7mHx1dB10eAJLYgtjXM
         TTo9bNK+tww7yWYQ4+JHi+ynWzlstT59MuWR5F1nUeAvJ/uxtDkcaU9lCrWShfCkdLn3
         Gd52xGlXjsHynpMpe3mx3bX0yPIaGx6+Wmh7jIH4vyWTEQkgnRopPSAPZDeA0qbWNqh/
         Y7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707157; x=1784311957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bI02IT26f9J98q2x/cBgGT2CgXZdiDxxE3v83TDsdk=;
        b=arrWHFExY2swUofPk2ldy7JNHhTIygCTpGBEf9Qqwy5J78fhQVNqZYFsvAaL0Wekla
         LUXXigRxsa65h9GG2BIwQGzHSutArwBljb1YYZ6G7dkvH0AbAWw/pYvaT2t+Zm2NiBph
         FlN0AnJGC1u7beg/RzweypUr5qBX1Plk+WV0G1BQql9ESSAN7e+mvYsJUpLQSgbjHH/c
         CI/NvYPqV7cOB1Ps9V+dduTV2UFTVOHg4M7rmxvDZ2ForUESJHp3jjcaFdTELGTeAG7l
         F2IiUzgRamuiPBLYRk7XV0AZGlqwNcLU0iy8e2VK6aow/P80Yw9Eb99H+ausRdQgdX2J
         6mwQ==
X-Gm-Message-State: AOJu0YxbIb5MDBHrtNa1Yohb9Q4udFtZd7SgwZi6hoA6a38m4S1n2UbA
	ugWdqXG9Pd0lZHM+o4b9zj9Mj1V92qPYrH54biHWO5YbAyJdgPDv7UunxGut6d/4
X-Gm-Gg: AfdE7ckHS8NkNNS+ydw89k7Pt0RpK+HePmV7B2RglF3v1gu6iYWKZJ459M+48YOW+r8
	LGGE9hK3plqOCM0dJacv9j19lbzJtMNr4wL1/8HaErrZ0wa8ytf3IQGEgHMmmIJqOnaKKuepM/t
	hEKSr0VRmBD4ZQBRii9B4cojpBS8BZgle28S9nQctdihUr4ayN+05pel5UvYcbnnTJuBgD2tB/4
	WbwjCkWNe2skdFj6Dmd8tHAx7BQlWT7G4axUjjlTvnyTfEC80RBjz1rKGcLQgL+D+Am2QF8u7og
	FHDOvUs8SsiXy5TJyQ2HF3+yBqFmX3N2xwt4BJ5FJ4JIt/wr+z3Rcr4eIAvN1vq5a62041QMp2j
	aWAh2lGUwcGW/C6varisUGox8er6shvsoNNCMhvWtp0LUPbg6QFSLmSWp94MQ+Jy8aGUL4jP3qo
	u55gZUrcwsD/5b5QoR+FIbGHas6Otgv1qiKoMSwt3anmqsKbbyMM2g8urA8GI/a+uQVXoq52Gjb
	9jzxTkzr2rW5GWLLmEiAeaP4OEEL4QHXdhJRJ8TyRpRF7OES2XDoXY=
X-Received: by 2002:a05:620a:460c:b0:92e:e2a4:ae86 with SMTP id af79cd13be357-92ef2c6b27amr32773185a.80.1783707157195;
        Fri, 10 Jul 2026 11:12:37 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b38dsm270405185a.10.2026.07.10.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:12:36 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <dstsmallbird@foxmail.com>,
	Zihan Xi <xizh2024@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net] sctp: fix auth_hmacs array size in struct sctp_cookie
Date: Fri, 10 Jul 2026 14:12:35 -0400
Message-ID: <634a0de0d5de29532915e6d47c92a0cbc206e03f.1783707155.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306653-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:xizh2024@lzu.edu.cn,m:enjou1224z@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,foxmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14DAF73D483

The auth_hmacs array in struct sctp_cookie is supposed to store a complete
SCTP_AUTH_HMAC_ALGO parameter, which consists of a struct sctp_paramhdr
followed by N HMAC identifiers.

However, the array size was calculated using an extra 2 bytes instead of
sizeof(struct sctp_paramhdr), which is 4 bytes. When four HMAC identifiers
are configured, the HMAC-ALGO parameter stored in the endpoint is larger
than the auth_hmacs buffer in the cookie.

As a result, sctp_association_init() copies beyond the end of auth_hmacs
when initializing the association, corrupting the adjacent auth_chunks
field. This can lead to an invalid HMAC identifier being accepted and later
cause an out-of-bounds read in sctp_auth_get_hmac().

Fix the array size calculation by including the full SCTP parameter header
size.

Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Reported-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reported-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/sctp/structs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index affee44bd38e..cccc662561aa 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -312,7 +312,8 @@ struct sctp_cookie {
 
 	__u8 auth_random[sizeof(struct sctp_paramhdr) +
 			 SCTP_AUTH_RANDOM_LENGTH];
-	__u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2];
+	__u8 auth_hmacs[sizeof(struct sctp_paramhdr) +
+			SCTP_AUTH_NUM_HMACS * sizeof(__u16)];
 	__u8 auth_chunks[sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNKS];
 
 	/* This is a shim for my peer's INIT packet, followed by
-- 
2.47.1


