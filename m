Return-Path: <netdev+bounces-287224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCscKbVNA2r63gEAu9opvQ
	(envelope-from <netdev+bounces-287224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:56:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BE5242BC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F388303F542
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8B3B8139;
	Tue, 12 May 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtGUEZVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366533B440E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601167; cv=none; b=gWVPMcRThzGU/Q2tsFc9lI2Zkef2KeMUuC/fLIvq3pqc2S6gecvU2A23wVtUVWVvxpshyIH1aK8G+AjqEeS4akPV0tp7btWV20jQ+Zrlw0GeqDelZluopo2AdSNy8j7pIziaST7zY3tYTY+9b9cj4Wn9ZCsg5PfXUTFs7ToZzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601167; c=relaxed/simple;
	bh=C6rjWr8gpAVtsmvbG/OGXeJAFdVJsxnAkPSkLDVNQbI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cjD4jdU90lrYum5EmF2XLk7hUkfDF7h0FCWsiUkKspIln7kBnlkzWVpM1fhIODCUOKL+5zjMZY2XKwPruf91c/s3M60G8rBYMyeLqx+O+f0JnwM40vWDL58I6rrtcA7GgW8qKjI/A49EL7mNGcS0aBBCRG6ymuNyNAl52M8blPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtGUEZVX; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90c991bfc92so268297085a.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778601165; x=1779205965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V5ewSQV6TmjW19dbKUL2ioh/mEw0LWfnAG+rUEp/X0I=;
        b=HtGUEZVXrCLEYSdqqW6K8M7fPxasd6iVEQeJ1lcbXy1W9NRmEJqaYNlmVy4kU+B9YZ
         PVTNV+f0fryWRMh8dsgJi3XNuXRR80o+0+cKDZhVe9Y5XfsQJ89roTCyleaWhBTi9gVB
         nnXclxKiqmx9JDsbQ/R51X3H+QEeGERb+X6AmoZQKPOqBqzoOWn6tbZNylko9Dv2pVfu
         TuKiRMtSjcrcc1uwNroypcLvoRSxPP7GxWzy/ybqUKuKL1V33IeKCJUuM47CK30G87kc
         oNaYZ9T6thOwdtaJQRwjNOsmaIMtafrXJ9aL3xh9kHOuheoQ2erNZMQtnqHLuPyaAjTo
         ROUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601165; x=1779205965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5ewSQV6TmjW19dbKUL2ioh/mEw0LWfnAG+rUEp/X0I=;
        b=pfe33ZE6n0ujA9AYDJNHEJGySFLP/oVXMcjEa5Hnx9J0A4alsY0wIOyf0Qpf6EVba/
         Zgm4Mcyjikij92mRTKlEVtIgCcKxthI8cpQa63e6GTDjVV29autlXD2e2ev4i4wxCW51
         xVMOEw8e8LWCStYFqf5pdHFttfaVW+PtVVebDatNHEt+QliONrqdcm28qztUs/e6l+1u
         LCiMOSPJMLT7Xkj/nabO1uQXbcMJ5xtKtqy8nr2PQiPHqvQnSdNVrL0e4aMtbDMh8XZl
         3aHKM+/4d+YShUz1WywycXZ0UPj3OTA1RAsYGBWofevyRvOfzvT9UK4YdsNFDebGjJQJ
         fwNw==
X-Forwarded-Encrypted: i=1; AFNElJ8WQdyMA1Jp9XUOP6jNnWNXbLxhJO6Yk8xb/In5aB+RC4gHwnlK6Gjg1St57wvEpd8lk9N09sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYOsRhJCi05DG1i+aomryNc/0VpiV/dj/S663qacnKssuLvej
	XKVENydlbVWpXxbrSkdpDAtNc1J8itngj1bPnNGomUK5MwOTnpVf+b6z8uiQv/7q8E+CYYC3t/w
	/ZdGy1W1GJMno9Q==
X-Received: from qkkh15.prod.google.com ([2002:a05:620a:10af:b0:8cf:c902:6c60])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:468b:b0:8db:f83f:6d91 with SMTP id af79cd13be357-904d0b9dd15mr4256448985a.0.1778601164854;
 Tue, 12 May 2026 08:52:44 -0700 (PDT)
Date: Tue, 12 May 2026 15:52:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512155244.4137851-1-edumazet@google.com>
Subject: [PATCH net-next] netlink: add one debug check in nla_nest_end()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 502BE5242BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287224-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX)
to warn if the kernel sends corrupted nested attribute
to user space.

Offenders can be converted to nla_nest_end_safe().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netlink.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 546d10586576e7b1c44348ac48762667ebb00f61..b5048dd1d5115dc94e9ea18b3b6d1822c878a75d 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -2260,7 +2260,10 @@ static inline struct nlattr *nla_nest_start(struct sk_buff *skb, int attrtype)
  */
 static inline int nla_nest_end(struct sk_buff *skb, struct nlattr *start)
 {
-	start->nla_len = skb_tail_pointer(skb) - (unsigned char *)start;
+	unsigned long diff = skb_tail_pointer(skb) - (unsigned char *)start;
+
+	DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX);
+	start->nla_len = diff;
 	return skb->len;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog


