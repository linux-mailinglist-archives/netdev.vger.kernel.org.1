Return-Path: <netdev+bounces-307003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I+PIBaFZVGrbkwMAu9opvQ
	(envelope-from <netdev+bounces-307003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:21:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F20746E57
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:21:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BPKeyWx4;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307003-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307003-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1877830037CB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704031326A;
	Mon, 13 Jul 2026 03:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7E1F09A8
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 03:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912862; cv=none; b=nk2nTZMO6lJsZ9z9y0MzYVVOgt/poBLHKb6C0Bs1LKPZItp4lxIeoUCAoXGCNaSjn140Vz9izl6R6nn81FJr+YJo2xWFkO6jYP79uBpTTNh4ZtjvYqAEnmPty1gCIl7Ffl2xz0eRzdLCjtq2PKcCdQmXbc+iFbkNaYGZHokFzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912862; c=relaxed/simple;
	bh=f8TyvXbU4/9gqzHna/fpREB0Ol/K3yg8kGjQFZzlx1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8cTr6yZnWIyxr9HDtcKHJsnbyiCBIrnrvMQSDX8+g57dihesj0h/PcEiQ/DDC1B1W2110scw4C3dk9UagbnDRe2mCKA8kyeuX2CgGUIGg77xxgolOhlTctZYdt+/NxTDk53xrABdGWjRhFQr951I2l7xrf6mtaSLFts3lgZ0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPKeyWx4; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8612812170so251520a12.2
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783912861; x=1784517661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sWliwWscFUVTwPHBU98Th8Nx6ddb6pv8WQCFUGLmIX8=;
        b=BPKeyWx49TQajrIm4I5i8x6B7s/eVnLpMeeH6lgKphoDdE2258HsnUDkHnZxEYwmEy
         joGFrkIMUc8RogyXRsWBS4eLQ3pfnZKe1g7aNo3ei38/ngu+BZD5KgXFVdyvA6WX9f8Y
         1HX6oot/m9eib/2xNFcSQBQ2NsWFMn16LsXNevjZSeiQyCglXc/b4L3TLBRLXffxDaiX
         TN3dfn9uAckyBXwF+pqeIUOj3n0N3KnMCV0RLyGEk3rDtmhxwRtLkYP1nGVgYBW2mbu1
         YjQdOKI3tGnXOb/wi561kj6be8TZEdKewUZPCgH3sTpI0UnRty6zgItJT4WpC+/Phg4z
         +3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783912861; x=1784517661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sWliwWscFUVTwPHBU98Th8Nx6ddb6pv8WQCFUGLmIX8=;
        b=MSVms6eNdOZ2AD4qaxzq7bPDDjq1MFRheTHfGJ86w1gLbKd6p9GmLHo1hCHYTYBW8N
         bbC9SnBdqyza3mRdq960RzzU4I88UYXAVnKGjJCSbj7fIwT6kAljl+JK/WHizUsti6iK
         NeXYRjVOS4kL7zJ07dD4kZxYTpwsKQgeVgtxl0M3bMz15OCuOlGziw6FTrxqZJKaTTKb
         n5NrkxF8YDXo8WlVJZn5LTM8dVh4/DtEhoMlZYTtxS3mXmlufX4HddLMPiLwQYTzyD7l
         uxzS+MqpHVa9axmHPF/kbMtl0Tq0lMvDpvYPTcCHJ/B4baRtQjmhbGuV3IE2tQIfe1rt
         ljEg==
X-Forwarded-Encrypted: i=1; AHgh+RoLHetuHKeb2RgUWFULzx4lgcnnzD7vqa9NFvU1eC7wix4YB98hes16N6WdadPFGIfT6nDrMYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTtoBAsCjUzyiA9n9kIqQ+518UaerGTh7kxwoYlYiowW8kOsV
	lU4ccv+qnxbZfEEQiwO74XfyRjxp/5kEScmwoWyJaduyGdQxI/ciYCqg
X-Gm-Gg: AfdE7cmeVwuYxGhwn1OG6hPccbzlnTBgTAJw0429YLSpkklfkUfcIzqQvwJwJsFikCR
	LWzlQT3bha0d1Twmm22f0nm7p70sDqAy274kFFsvl+PtkgpE5l4VMKjNWjYiu//bgbXwH5xImg+
	czEsFTarhzl2Kc3DcMQwfPW5CIf8c4g99I8D3xNb05Cs/HKopQukDtcU+Wn1QwoJqV4tfTrI0XJ
	ROBHc+GbhczuMlOoYTEJIYOgkjfp/843ypVnSuKkhbJ+rjMIzBbwPjSoT3o2Gk1bkZK71z1f6Ln
	N507pAjBek4sKDcVDJqY6FBo7itRXJgeSOs7MqJRx8i7+ocEpyElJyx89vwerRTjNDO7kRPd+4/
	ydfM6ifbp1Ctvifc3w+FhMt2LUrxkHjIo/c7DfNMlC84GPJs2/nyIPFZFQo0zgPduxNlJ/Qpd9X
	pqadXXgIwUzO37YVGufah4iBDV5gIz3oHeDllxYzKVl8W1aQIZjipTiFX2ZtThuqtqSDtFgY8Oi
	7ns1/s9Cq4Prqgg9ck=
X-Received: by 2002:a05:6a00:1884:b0:848:2fbb:de48 with SMTP id d2e1a72fcca58-848897ec5b6mr4901302b3a.6.1783912860749;
        Sun, 12 Jul 2026 20:21:00 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848593a591asm5689195b3a.26.2026.07.12.20.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:21:00 -0700 (PDT)
From: "=?UTF-8?q?=E5=AF=92=E6=B3=89?=" <eilaimemedsnaimel@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E5=AF=92=E6=B3=89?= <zhoujian.zja@antgroup.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HanQuan <eilaimemedsnaimel@gmail.com>
Subject: [PATCH v2] sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid
Date: Mon, 13 Jul 2026 03:20:21 +0000
Message-ID: <20260713032021.3491702-1-zhoujian.zja@antgroup.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[eilaimemedsnaimel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307003-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eilaimemedsnaimel@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eilaimemedsnaimel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65F20746E57

From: HanQuan <eilaimemedsnaimel@gmail.com>

sctp_auth_ep_add_chunkid() uses SCTP_NUM_CHUNK_TYPES (20) as the
capacity limit for ep->auth_chunk_list, allowing it to hold up to
20 chunk entries (param_hdr.length up to 24). However, the copy
destination asoc->c.auth_chunks in struct sctp_cookie is only
SCTP_AUTH_MAX_CHUNKS (16) entries (20 bytes). When more than 16
chunks are added, sctp_association_init() memcpy overflows the
destination by up to 4 bytes.

Fix by using SCTP_AUTH_MAX_CHUNKS as the capacity limit, matching
the destination capacity.

Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
---
 net/sctp/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index be9782760f50..c901d373af80 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -672,7 +672,7 @@ int sctp_auth_ep_add_chunkid(struct sctp_endpoint *ep, __u8 chunk_id)
 	/* Check if we can add this chunk to the array */
 	param_len = ntohs(p->param_hdr.length);
 	nchunks = param_len - sizeof(struct sctp_paramhdr);
-	if (nchunks == SCTP_NUM_CHUNK_TYPES)
+	if (nchunks == SCTP_AUTH_MAX_CHUNKS)
 		return -EINVAL;
 
 	p->chunks[nchunks] = chunk_id;
-- 
2.43.0


