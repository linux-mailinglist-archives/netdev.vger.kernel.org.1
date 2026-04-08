Return-Path: <netdev+bounces-276513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDXtFJBQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E903BC767
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9836300578D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635943612F6;
	Wed,  8 Apr 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud3S6nIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB192459DC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652829; cv=none; b=fYuZeUhA0fKmOXpnQaH5gnhxduIdwDjN5CpBBrqKmPw6snvckqQCOLce7RozAP6dB6jU+lQdswP96vhdBIrlLYtXmKAce9BS3f6I9iung18ZA1T5WpBRvA3396v1Cz1wZFdzxQwtPeFbflsIzWFtupWEgcI2tBORpnXSr0kUJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652829; c=relaxed/simple;
	bh=i/jWbQdpaZ8b/0gnWJEOyZFwTq28t9QPbasnuRPj8Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCgMKhLm/82qBR9TwCHRhEnircTPt5FhEaJ6hyHBID5GIPbIUOxNrxHG7hk4VZKKNGsrF+g88AY4sx4M26Kb4tGtZs6V87+HpO93+shobzBVi7S2T2UpnCY/kl6b4NR/Pmc6RDznRt6chNlLdG6bNkbVetmz8GUmDPw3P+u1Aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud3S6nIC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82ce09b61beso2752819b3a.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775652828; x=1776257628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIlOs7q64Dx26nQmV8oPXsuS8EwxbCgpyhUA7vQTilE=;
        b=Ud3S6nICIpB9oZMnQW20CzuPQNezltDZ3xtEJ7qeSVK4EinmzuEJTUhHQXkwJM2wFp
         xTNpMTqKURsAvq1Otob59OOG064OlkJjSVvOyo6LJX2eBHdGRQgGCEmWEB8vMum+aMgi
         TQCqmZ+vPOCjfd+kGV/iO6GlTlBDuShWDKdjMNFkyfAi67lAB3n7B4nSgY3JAsAvQjcZ
         kUKuHDGvZnIV5rFaqPjAyzQ/deWNjjQME1+QnmHJHy78nArRzowXu09pRGVFQFo4vVr9
         71BFdetafaDSN3w/sT76DE1cBLiu1Eg2T4QWGPiQrzMPJRVVFryd3IDQtipjc6ZALX7C
         zVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652828; x=1776257628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIlOs7q64Dx26nQmV8oPXsuS8EwxbCgpyhUA7vQTilE=;
        b=Fej0Z2x4SkxjQii8XpOKdUAktfP6JtsAbfbdQzSEjPkzi29jFIEeTiy3EJgPnxHJg2
         OFnXQ0aIfKI/d94WjEEE/ob+s2nP615XmADUVUB6C6lHF6mr9pxXX7IOPMu54q1L6JRc
         SGKfP5gMNkFKQC6YZL9ffVK5vovAk/Gdct09PtzBF4nYXxPDjFYEEonmE+51UCGSJ5QP
         NQ2hPhkrBBP4pstkI5RYZomHfpJXDy2WPcRVT+goy/6p8EvpKcPoqA9AlPf4bP83t9wu
         vEKhRUzso4lzQkYL2GkQ/B+qz969Jw5dTSZAEUpTLkXoLrNZo9QHrWr21kxhScBqzECy
         6dmA==
X-Gm-Message-State: AOJu0YwOsuXYiSRDT19HdK1n4djbDGrGYsv7Eh6Tvv385yJrPtbFrE7F
	Q6NAzbdrb8ENoCZKHONLbJ7S9J+LGeriETgBMeyy/lKB8DOJD9aSHg1q
X-Gm-Gg: AeBDieuKxiUBvUU7Oe5dfyCl9k4JJ6y5yerMuWV4uRAZ39RDj53X95Qe4xekNnMYa29
	vkDWJQbfhyDE5YCxTpmvSV9yjHFBenXhG4cVouyzzEO35oKzMpmnhsX/x5iqihm2V/XgYKuw3nz
	tBq1unSip/3m2MfFFgqMLW1n7LMDLIPVF+ujePA5D54wAgqtzsEWi499P6IWZK6oEG8MPvIq5Lb
	e+3LyZrZ/E5K+F030G+ZuIIAOVbT9g19X5laMEPh00coDcjPRXF+b/Sd+SMfzHjjGhXuIWLBiZd
	dMDQzL0kPZ+C1HjpZO2nHXhzS8r8DS+ddEk9zIetQexpxpS69CAGfKf7xXZyHLnlTPD5ffMOhGG
	CwthfmfrYn1SlwPBixSl73YxU01GoadDzf2MRMpfi3Gnldl5Bd7pS4ozRjwPDobaop3aydk+eps
	UksZZ7uIAaEpOKn8jKqA==
X-Received: by 2002:a05:6a00:6ca8:b0:82a:ea3:c16f with SMTP id d2e1a72fcca58-82d0dbe3dabmr20955636b3a.53.1775652827507;
        Wed, 08 Apr 2026 05:53:47 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm22331921b3a.11.2026.04.08.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:53:47 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	kees@kernel.org,
	thorsten.blum@linux.dev,
	arnd@arndb.de,
	sjur.brandeland@stericsson.com,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
Date: Wed,  8 Apr 2026 12:53:33 +0000
Message-ID: <20260408125333.38489-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-276513-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,davemloft.net,google.com,kernel.org,linux.dev,arndb.de,stericsson.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3E903BC767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfctrl_link_setup() copies the RFM volume name from a received control
packet into linkparam.u.rfm.volume until a '\0' is found. A malformed
packet can omit the terminator and make the copy run past the 20-byte
stack buffer.

Stop copying once the buffer is full and mark the frame as failed by
setting CFCTRL_ERR_BIT so the link setup is rejected.

Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 v5:
 - remove the Reported-by.
 - print a warn message and reject link setup by setting CFCTRL_ERR_BIT.
 - using %zu to adapt the compilation of 32-bit kernel.
 - add rate limit to error message

 net/caif/cfctrl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index c6cc2bfed65d..373ab1dc67a7 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
 		cp = (u8 *) linkparam.u.rfm.volume;
 		for (tmp = cfpkt_extr_head_u8(pkt);
 		     cfpkt_more(pkt) && tmp != '\0';
-		     tmp = cfpkt_extr_head_u8(pkt))
+		     tmp = cfpkt_extr_head_u8(pkt)) {
+			if (cp >= (u8 *)linkparam.u.rfm.volume +
+			    sizeof(linkparam.u.rfm.volume) - 1) {
+				pr_warn_ratelimited("Request reject, volume name length exceeds %zu\n",
+						    sizeof(linkparam.u.rfm.volume));
+				cmdrsp |= CFCTRL_ERR_BIT;
+				break;
+			}
 			*cp++ = tmp;
+		}
 		*cp = '\0';
 
 		if (CFCTRL_ERR_BIT & cmdrsp)
-- 
2.50.1


