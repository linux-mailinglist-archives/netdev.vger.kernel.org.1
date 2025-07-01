Return-Path: <netdev+bounces-202809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB8AEF170
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4732B7AB1E9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B426AAA3;
	Tue,  1 Jul 2025 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wWZNUGIS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FD26A0DF
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359256; cv=none; b=VuS9Um5aIe/WYrHCwgcSloYAMlzos/DipYPxxeh9vBr/IKstODDLETYdLf/ENEQ1dXGuexqn+0e9qCxSt+iR2R7piSYyFQektpOysmBu0nmagwctkz+sTtAG2Rz5zRSKNFKeH0XLx8xsP7//P7GM5CbQRGvIs1OMxpVw0y0927E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359256; c=relaxed/simple;
	bh=bHvpc94HXYih2FMFgeA+sRP/r2c8MhvpzQoiO5z8z9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Amf13bGtb8qMAqfmda42kcSbztfdeCXMCEsJEh2assXS6D7FPr9p6tcQLLY+pBEtV2HurafcoJyCU5izEvmtBM3vf+ySVxjDrVgiSLVSAcA47dFsJP/fh90+60L0f1MqjXFpWRCskl0LYc8G+Vsd48R5CkVvDSseApr/f8CMkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wWZNUGIS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC2C63F71D
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359252;
	bh=isC54dUAY8UhtPmgzK1RBnnEBnnC6mxj6C9AzalU9ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=wWZNUGISf4jsOi2Acc3X4GzxRtSG0z9AAMFMpPMa3QLem2UGzFlRjBneH4c2YFbwA
	 fSUAImIzSPltHKC7EbrxONYFMvqYeCO6D+BE7APOxkZF9htRDYbCYqKQd56pKM04GK
	 DwdR+8lJqIqzOFQgf313XxIbzqUgBvSG3+SHr+Rcd89ekJGH+5jRQ0ymbs7E/T85Pk
	 aGPDhXb21mOXYDgQi9iMEVwrc9uR3ImLLyrlgMOffLkY0zftde3rQrGVFjDRq5c7df
	 cRcULDkCDpK0xeFRE9W7aYIHnQdvcdyE+CLLP9k/31liZwI0sWtJrSCqf8BD/fLgnT
	 VsLZctgOxTHdw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0d798398bso398226866b.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359252; x=1751964052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isC54dUAY8UhtPmgzK1RBnnEBnnC6mxj6C9AzalU9ag=;
        b=plSzSaT9Wdyv0Sj5qaQVJz3yFFCTkdT7tTMBRkv6MSqcOT9V2LjvdBf9dPI33qCtR5
         sblyVyJ/uaxJUwRZypL73FwfmGZ7ChT9as1j29WdG66NlGLXuop2EJrY1/NjFIpS4OzD
         lnHo1/5BtGJ8dEtqAlqAAT1y0blJ+098DQrDL41lOoHUq+vIj7bboqh67Isy1w8/Fyn3
         Kmv2yASLLuLVab8N5/lSTOg+a3tfCPasP8rrmhsYjHIWdXoxAEzyhrKxjOFlPqhvUxQV
         U/s1mqviXDHANtpGUqq37c59IcputkShRtzjxhEMvMU4lMA07gam1Lqw09+EhtGAMTtK
         Kfgw==
X-Forwarded-Encrypted: i=1; AJvYcCWTgAbDUHamjxRjAZglgbuVH+AZFgt9C/XaCHX4Z59iu+NEFVXNhbfjeF1+/dL+26g35BbTQyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdi/hhLLge/f2iCw4bYGrt0J/oCso5lbAuPjDFR7LybNBDdkFA
	TlKoRGrsGSlIxmh3NqSfUu9gAIpCTagyzc4DgqcNMThv5ads/2JrnIypSWMMEpTN3WZOKnkmOts
	pninwGOyAp2uHcBpdcT+yMI6TVrDSUtTV4cil6tVpIFgoR8wPrjMkXs0IyJRr2ucK7y7cnIntsA
	==
X-Gm-Gg: ASbGnctZtRKsoczP22dzfK5F066gH/YkFeazsAulkIf7T/mQnaFRiMkGY8Y3B/xs9sk
	ze7DBr+InGZnqXeHhk4kj9g1v4MG2bqKFGkjeoJt5YkZRriO6S9uQ3y4FKi7csqgcHkIhUoOH8o
	7RVFiTZR6wC/P7k/u/bmIeMtc/xL5dop3aivLfjmWXagOoXxNcYaG/8sUkRuEkmWsXXdo4xyBYp
	BUAah8GomanP1jr48rEg2CWgb1hT4pixq/crAfvvRagFG3cYn3WOM2wxokakJTrcdDRuTuZbP8v
	EMdVqMDcvj1qShxFHJY3rgiQgtYxgj4B59V9rmPp2Ppu5+Paeg==
X-Received: by 2002:a17:907:1c0e:b0:ae3:8c9b:bd64 with SMTP id a640c23a62f3a-ae38c9bc02cmr913627566b.29.1751359251434;
        Tue, 01 Jul 2025 01:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9IOjQfHIhysscWrtfEdQ+J9BlfvEQTu1lLk5fVoZ7wydBDYyGcWaFaf5++ub1XyOVdcY+6g==
X-Received: by 2002:a17:907:1c0e:b0:ae3:8c9b:bd64 with SMTP id a640c23a62f3a-ae38c9bc02cmr913624666b.29.1751359250996;
        Tue, 01 Jul 2025 01:40:50 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:40:50 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v2 2/6] af_unix: introduce unix_skb_to_scm helper
Date: Tue,  1 Jul 2025 10:39:13 +0200
Message-ID: <20250701083922.97928-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open-coding let's consolidate this logic in a separate
helper. This will simplify further changes.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fba50ceab42b..df2174d9904d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1955,6 +1955,12 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
+static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
+{
+	scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	unix_set_secdata(scm, skb);
+}
+
 /**
  * unix_maybe_add_creds() - Adds current task uid/gid and struct pid to skb if needed.
  * @skb: skb to attach creds to.
@@ -2565,8 +2571,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 
 	memset(&scm, 0, sizeof(scm));
 
-	scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
-	unix_set_secdata(&scm, skb);
+	unix_skb_to_scm(skb, &scm);
 
 	if (!(flags & MSG_PEEK)) {
 		if (UNIXCB(skb).fp)
@@ -2951,8 +2956,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				break;
 		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */
-			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
-			unix_set_secdata(&scm, skb);
+			unix_skb_to_scm(skb, &scm);
 			check_creds = true;
 		}
 
-- 
2.43.0


