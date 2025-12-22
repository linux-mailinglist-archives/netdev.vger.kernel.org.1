Return-Path: <netdev+bounces-245735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9DCD66D9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70CD73054CAD
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B74303C86;
	Mon, 22 Dec 2025 14:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA302D063C
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415152; cv=none; b=kua7SNqHz/H4AGpbBirxmGSpKyIg92kigLe7tG3TxIB7a9cUoLfbSzV0ssA9FO/MsKYqIH2vAlovwFK/zCcdxGLTYbgqpHMF90NRkRLAvT6U/ruHvWQ2QepGBvwl7pJQu5+RmMIKyWEWPuz2ooWCKd8/+hm3cSNp6tmJ6d9C7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415152; c=relaxed/simple;
	bh=JKKJn8euRQ6QnFpf+G3BcPHFGDaTAmLiEhgvLCRk5xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zbq2vCCJolgLAG9cDvARYCvmmoFksC9ZzFkisrbTLPb8U6nBT8ieIEKLvd9ESxJA3zquEpRi8Up5LTjAXaJ1cooCA/0YquHTqzC4BPmtcbmPb2BqbDImLfz36QRxKtDEF2Wq63BlJIF6RZgIbxc4JwyuGqwhHTrNs9+B9eQgwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75387bb27so1667301a34.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766415148; x=1767019948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ERsjML2moqdleOPpyHCHm9fmTJ8lit1vijzoNSe2v0=;
        b=li2Kwo81cPMSC9XsHOmBwNVEtAVgWmJi3Y1O3pB5as57buny3T2LqCZI+Ea8x7xTis
         AQLNC2tAoSG0E1JFl7a9hf+Vr1mSMUY88L1BPHM9bzYfni/9b4Sr1TlguSSg2aQp7gie
         tMfoUOgOEghDxgiZ9OVjnm398A/ZFhg8QVqggcuz4wGnwjIKxB11EJUQtLF/3Qf0+Tsp
         a9bRi0Z8ZGQD6rgW5QYR0vwlg62DG+wl9xMq/sNFiEhDSYDIgvKaqAps3ESvaaJKd7lO
         5sPi69BVrPLkZMI9QD8xjt2owUf133Mvl3UEnQzxRFcGa1FsMwW5wZZXsEGFgoqhfoDC
         z8Gg==
X-Gm-Message-State: AOJu0YyffzU5A5LBdVHGnfcPrXpBA6nEh35I118sRh35RG08qFtEBXF+
	m3imdIUnVmkDBwzyy+TYYpXmL6E7AOq7AbrbxCn4DvIkUXN1SPOftxOL
X-Gm-Gg: AY/fxX6Ogg721LegFpcwrp7tw/JefUZ1UQf31FrRWWkMM8xsZFIeR/XDVE+lP2U6hEW
	xlKuG0bqu2EY9vrInmPZ7Ogh9p/3JNpaz//BMV5uRr4EoIsYmV8iQzuRwdMxJdvERo3HkQtnOnU
	sx+x0zMUr29kxGRuHn1dmH+L/JWjqmySG8gmFK9niXNav5p/OBGNxTyXreeoztUGR74WTKdb2BT
	hmrW8HdLQ3ggj3heDL60HKO/KnDnEScsid91HwdzDWCjIOF2kQ0HyISGedc7wO+gJnm09Duf6ZS
	v7xIVa6qTxUNx4GPuUkx+6WnE1bjJMEW0hhYvGpvR7zBnMlANua6jh2LxdfxK+vDHk6UT2h7Vtb
	xGDclQrAeRrk58B2POE1BnwXRHDtoUWBMeN/bbZXD/m1GVvS0nsj33j9j+PugwP6iZXAl3M+iak
	yF69R4jPJWuFozPSiOxygKCSkv
X-Google-Smtp-Source: AGHT+IEwiw5VfvorK/Ul+TfB+9hhGgpe8qUpgC9qG0t1x5N29CqWxupoUXwVJSomNaedw5ZVlmKPMQ==
X-Received: by 2002:a05:6830:2649:b0:7c7:6bb4:1197 with SMTP id 46e09a7af769-7cc66a6f058mr4837844a34.24.1766415148286;
        Mon, 22 Dec 2025 06:52:28 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d572asm7459409a34.14.2025.12.22.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:52:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 22 Dec 2025 06:52:10 -0800
Subject: [PATCH net-next 1/2] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-nbcon-v1-1-65b43c098708@debian.org>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
In-Reply-To: <20251222-nbcon-v1-0-65b43c098708@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, kernel-team@meta.com, Petr Mladek <pmladek@suse.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=leitao@debian.org;
 h=from:subject:message-id; bh=JKKJn8euRQ6QnFpf+G3BcPHFGDaTAmLiEhgvLCRk5xA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSVsqhCotq0bJbtdcEHfYfktYBhbVmvU/M9bAh
 FbRc91XE86JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUlbKgAKCRA1o5Of/Hh3
 bWvJEACZRRAePZN5P3WDsYws8Xsy0kuoADHIaq9Zggtf9WOGRIqNVdMhZJ3ljvPMiS03IoDTv77
 hCYQycItGtZ4u7S2JlW3WHHlgpwybsTbLplRCkqndDyhgHa1sMlIgWFB05+jMmBRzTnfix5cRtr
 m8+hyAU55rCSTfeThzXN4/XPcS0F+0+9uRCGzY/pQHcBKe62VdHNppGW4NcQuBPsl7VFZwVJgaU
 KRxC0IFX+6H64BPd0eYDwcjFa9lLYMGxDXRkBO2mkaio2N5oC2TItowm+ovvpOrabj7tDOCL6gj
 9N9DmzIVWQNFrbqqa0rA5On7Qd/9qsRaEibBC8XG0LOXenDoyBbNbg3t5Ui7f29QW8wZGr8EdCC
 F6nci2zZKYpphzqmE5SQSPPDZocVvZ0nYfEuBwMEk/cwfBKE4ffIpPwbdVvcYRijqxWAOl8QPMA
 XrQhMk6Xm24cMcskxD1nPPYztOXekM36KeZMNBQ0U9vuJcqu4lhB13wgXEle+Y3ygA27JZ4MQ3M
 uS2DrylDpVn1+mkdjmXbqzRk0UMJxB2dEuPe0zsGDdtkxqQYt+JRUeIzz+HM9QQPwgL//JmGeqn
 Iyw6UUl7DNd875SfGv0hxzpGqXS0wKRERGZ1AdS3x3G75/NNzMATXXUMgXJzcnfXgz7SUXbj/Wh
 24FzuQsimNzb8Cg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the message fragmentation logic from write_msg() into a
dedicated send_msg_udp() function. This improves code readability
and prepares for future enhancements.

The new send_msg_udp() function handles splitting messages that
exceed MAX_PRINT_CHUNK into smaller fragments and sending them
sequentially. This function is placed before send_ext_msg_udp()
to maintain a logical ordering of related functions.

No functional changes - this is purely a refactoring commit.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..dc3bd7c9b049 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1725,12 +1725,24 @@ static void write_ext_msg(struct console *con, const char *msg,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
+static void send_msg_udp(struct netconsole_target *nt, const char *msg,
+			 unsigned int len)
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
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1747,13 +1759,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
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
+			send_msg_udp(nt, msg, len);
 		}
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);

-- 
2.47.3


