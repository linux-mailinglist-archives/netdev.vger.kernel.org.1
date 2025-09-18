Return-Path: <netdev+bounces-224416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FAB846D2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA66461A1D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB8280023;
	Thu, 18 Sep 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8BdAqbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9642D0C68
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196362; cv=none; b=jI/TkZ764l8t3y4xL2NZhZuNIYM8OfAyEjs7oDnq9dAanvu66d24+CODtEwRk11s4ZyF+CwhQpVrORT8j66SUJvCEpjJUXxk9nMJK8Dx7ecpQL9/Oq1cka+UgVsiNVLFUbj2Qe75Ojit56v3FQ4DpjPDpymAinxvTrhAnaTqvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196362; c=relaxed/simple;
	bh=orcEWWXZedqoXAATzhchY0ZD0iMu2nnp+TaE53eAuWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S0WxVfztLo9M5x6j1m+uiaFNqE6/Vc1ykaad9w/lpeyPhDhH9mIu0I9E/l4tVes9KNnyz0FIcFEt64g7x2KFsp3uYclAb6H3UpemDH7fF6XxW+gB+Zn1ZIcgoJRpiICxlRm/HuyyPPnoNC0sT+3Awh0WNMNZhI6JIudBoJo+qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8BdAqbR; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-7946137e7c2so13374286d6.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758196360; x=1758801160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lj85ZEG/huPOcCxz/XnmQuQGQpVn4o0LUY0b/XI4CFs=;
        b=i8BdAqbRuKrtNg//WHod86M3AHgdf0apqvpZuEKgXkRfowqblWJDTWG/vH5slKEnsg
         cNziQYCuBoq63k19yU8QpssJomMgqGvgSsk6akIaj4/rlvjlX2IxlSTpwyVturMmaPZw
         4SxPjSEpcVwX2TPzo0dX4QY+ZTY51e58r6jj60j9rYJHFl8W5S5lsQgHpDTLKh9xlEmU
         fgq1LSJSzJD6iMuzhuODrogwiZSebRvd9Bl/UnBxRy29kB0HoH0eW6SMsO07dpIHC8lZ
         lZnNhXtvt2nc/JMwOIxNzKsYfUVBKoNsPIlnI7OZV6TDPlcHOMI1QirUaDARwKjx46MR
         vDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196360; x=1758801160;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj85ZEG/huPOcCxz/XnmQuQGQpVn4o0LUY0b/XI4CFs=;
        b=xHBQPKZpZMJEZuFF8yAF8gyOi6MiZpw1UVyEHeVwZlUm6h7et0KuP/MTmJdatuZZ/A
         Uese3TY4OH412gPvqNSIkZxIu8ED42xm+QAsh+7YBxqma+nwJNuTCmXOFO1eCtI2OPcJ
         fpUbdboS8N2olA+CpTLJxqo4K8iTvqwEC1QwF4t/AXTuUbmrLpW38rFU8bm3slMXq1XC
         +I8XrTyvUrIL+paUPt1nCJLj7NL3Aq18yphoTBgauNAvMtw4lCZOAlwXt95u9JVpCMF4
         d90MRZAU6Xe5HMTCR+zcaohcE83vmQnClbhHeQYOR6wl22xcPEkxMdMD5SnOnhyZH1eV
         2MZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhBbgwUUyBI3vJARTUx9NPgXGSYahvou8/PZLbiHi1VSo7W5cFIQpJD9vHFqfz2hOkak6H3WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJpSBqvnNvY42lU7azvH8BXoqr7cyRmPiJTxoQjeOAQJU5+SM
	81/c3vT21+aHRJtXsXHGtAZyuDR/ha+ZdfS3SDzBXnOmTC5ciS3iL7Sh6Rvr6My/BzvkKUzpW5A
	+/bahj9vvQ4leaA==
X-Google-Smtp-Source: AGHT+IGNtRgNKauTNhf36ZMlMuehEhv0AKFShg22+bHAViHHwyvGfi0DI2M0TTohZ3coa9qPBeWCdqqHHEr1iw==
X-Received: from qknuk8.prod.google.com ([2002:a05:620a:6cc8:b0:80b:d787:6b48])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a507:b0:835:9388:5d86 with SMTP id af79cd13be357-83593885da7mr282761785a.85.1758196360126;
 Thu, 18 Sep 2025 04:52:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:52:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918115238.237475-1-edumazet@google.com>
Subject: [PATCH net-next] psp: do not use sk_dst_get() in psp_dev_get_for_sock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Use __sk_dst_get() and dst_dev_rcu(), because dst->dev could
be changed under us.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/psp/psp_sock.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index afa966c6b69dc657a54425656131b57645c81f6f..d19e37e939672c1f8fc0ebb62e50a3fb32cc8d25 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -11,21 +11,18 @@
 
 struct psp_dev *psp_dev_get_for_sock(struct sock *sk)
 {
+	struct psp_dev *psd = NULL;
 	struct dst_entry *dst;
-	struct psp_dev *psd;
-
-	dst = sk_dst_get(sk);
-	if (!dst)
-		return NULL;
 
 	rcu_read_lock();
-	psd = rcu_dereference(dst->dev->psp_dev);
-	if (psd && !psp_dev_tryget(psd))
-		psd = NULL;
+	dst = __sk_dst_get(sk);
+	if (dst) {
+		psd = rcu_dereference(dst_dev_rcu(dst)->psp_dev);
+		if (psd && !psp_dev_tryget(psd))
+			psd = NULL;
+	}
 	rcu_read_unlock();
 
-	dst_release(dst);
-
 	return psd;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


