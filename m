Return-Path: <netdev+bounces-274715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHnrCZzszmn/rwYAu9opvQ
	(envelope-from <netdev+bounces-274715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:24:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DF38EC60
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08F793017B8D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE013CAE7F;
	Thu,  2 Apr 2026 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="I85pWNi8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297C3CAE82
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168661; cv=none; b=qhtlzqD81NNg7a6gPAcaNUp0VM5cIuTOzciATp1rWNuFzN4q/gjdTW5JEgvDNCNdsZc2qRlpkjFP28TQKVcPDH9Tq13D98KN822zkCnUUzDY8ui34dfcej+A1I2OeUgE+N4sxEgSwiCrA2184+b3hEXOYqwGnU41PgrRCOH3SYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168661; c=relaxed/simple;
	bh=KaIdQyAAiajAdUcfYvLJf/6t5rgcSbejP+b2y6hYqhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QE4jg1H8g5fAvsIl/M8yu6z5KnpMWWYs+DlYdWkOFcLWVEYrAsAupC5sjxkUaDZ3yXnWO7b2qCnQN3VxRxaPHOKn+wFD5h+t1X3iE/66561WhIDRkbLYqDrMpN3iNrZrilq87tssm45ia1kP8QuSP1dLa5B87a4TBVHf5c2Agug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=I85pWNi8; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-46704fbf62dso829734b6e.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1775168658; x=1775773458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFxv3Plp0PpMaMVYe8u5DkLYI9Xrg13HAUHdQ6MHJNo=;
        b=I85pWNi8AWfPCQckRPiFYW4WDy/STc6ZsvFClTb4aSMTIq6NAIbYMEC/j0Gbct6oy9
         fGhAlQaS5f+VzQpOSVtxIiUCG50HLyij9/n9sxl/nSjkPdFIJnvJ/aQue75UAN3+HCzM
         ZBx1lwyILhxVt849AdVCBdPqXCs+95rXMScfWhJUg+vhSWC9WBbmPTVHT7LJsJg6vU1U
         ugbjR4dxBB+SbP4FWZBKNt3D4Y88W9fUWJl6iZ0W9AVtbTB8n0YKIiM2wYSoJ0UcJnIr
         hJE1qwwMLta6OaSI9IYGjQjOEqhWKHObeLTC72wLksRv7nBOyrTpEAYQZA7Y+1kTN1AE
         cwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168658; x=1775773458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFxv3Plp0PpMaMVYe8u5DkLYI9Xrg13HAUHdQ6MHJNo=;
        b=oHKqgtOHk/9ZlddVUiroi4+kcS9bEV0pB2UJJ4/MOYKwWm7T6otC8TT2SJVHrCy8Q2
         0zFsznZq+fhkKPT/i8PaGIl0wwUk282uBax0+my0cRGnSa0fDvVfujb0Hyj2GNGMU92L
         7/l1TwRDMEZFsdWhtK8crL+TcBNPSLHrvN4qk77ZSzhOjNTIL2opBlRF3hrviI+0OkPT
         mj3++LGUVWw6ieIRhsCfyIXibPkSq9bAEMn7ZrMSV7NMsQPfnN9G+oDAkVzWSjS/4iG1
         QSLhclwAFN56vpw5cW3EH35mNESLe5FSRlyJOjWS11Z2OocK48xQ8kIVRaRPiNmYMaX3
         BSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUy+zfeu6TlC7MoIOEIdf64Yuvo+4KirL2CTH7er5DW/DrDaWofSKbnJPiiUxjxmnpgFYpvVrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/x1dQtrKbYT9+u/I8fiPx9IOqWxNGTDO9yLxPBp+5DuY4iYmt
	nptCl7HbWBIfBLAPv9D7AtKvblaTmgntaf4WI3pOSyEHnxL4AbrxahYsPnaT181WBOg=
X-Gm-Gg: ATEYQzx5JL36GBLLnlpum3GqXB0+WA8zRbDUt7zEw1gExhqxcyQsBiT+2LbjvOQbyNH
	sqcva3mG3ySzioFS3EmRBz1klniZDCxxOllIXtszzjdyLC17SsYw/5UOhqBT7YYkIav2Sgs5s5v
	czHhSrjoRdIEtBS8EdDBbuuEowdeS3tAXhqY3Br7AuW1352DWo8CWaaqTT7LLnn1vK6NwgqqM6s
	nWkvJWt4OUGc/tuRSvWrybzuaHx0tkNdk+DuOZaCPmJ+CHQAhXUnjGRjeYbgJScYMma0PLoof2i
	d19wQCoelgY7jn8BUzq9Fhr5cNHo98Mjj5RdPFc8eCGmzbXBvsiHeR7A1EZgpb62+k8kfHSIaDu
	69lGP4YZDz8JwaBpQSFhhAGorSwLbjORZhjV+jswJsTnpWCinq6/dAa/KVBKi1tKXHQCgz/w8wL
	qArFVWgCNWDzbNGLDlTv8D
X-Received: by 2002:a54:4e94:0:b0:463:ab56:9ed2 with SMTP id 5614622812f47-46ef60f3fcbmr457695b6e.17.1775168657779;
        Thu, 02 Apr 2026 15:24:17 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac6:bf21:2e28::499:30])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3424927fac.6.2026.04.02.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:24:16 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: pabeni@redhat.com,
	bestswngs@gmail.com
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: increase IP_TUNNEL_RECURSION_LIMIT to 5
Date: Thu,  2 Apr 2026 17:23:16 -0500
Message-ID: <20260402222401.3408368-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274715-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: 2C3DF38EC60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In configurations with multiple tunnel layers and MPLS lwtunnel routing, a
single tunnel hop can increment the counter beyond this limit. This causes
packets to be dropped with the "Dead loop on virtual device" message even
when a routing loop doesn't exist.

Increase IP_TUNNEL_RECURSION_LIMIT from 4 to 5 to handle this use-case.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Link: https://lore.kernel.org/netdev/88deb91b-ef1b-403c-8eeb-0f971f27e34f@redhat.com/
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 include/net/ip_tunnels.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1f577a4f8ce9..d708b66e55cd 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -32,7 +32,7 @@
  * recursion involves route lookups and full IP output, consuming much
  * more stack per level, so a lower limit is needed.
  */
-#define IP_TUNNEL_RECURSION_LIMIT	4
+#define IP_TUNNEL_RECURSION_LIMIT	5
 
 /* Keep error state on tunnel for 30 sec */
 #define IPTUNNEL_ERR_TIMEO	(30*HZ)
-- 
2.43.0


