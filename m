Return-Path: <netdev+bounces-198887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419CADE298
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F017B5AA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89441F37DA;
	Wed, 18 Jun 2025 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9FXM0sJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FA10FD
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221302; cv=none; b=C0Umur2mInU0/Xx9DIMaiDwQ3MUDoETvf2BAVT87tpwZbG9ibvcQRPsIoZrKpb7SLahMby6PUDE8OBDbOKbixOrPx3DXLQ+Eq2wX313WdGXLj+N0XwUn79PkH2mcCAQAHnwskLKxpiqrOEUheD3ku22I1RxocYggj+tZwyqiSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221302; c=relaxed/simple;
	bh=26/+w7DR5bLuEZ/6KopQYzCi3dGAjrhv2bNSuNw+zq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6rqYVMMOh6hz4DPEAobCkCVXTni678avYcqmcc7YVNlu35pmOdRmvIcHgKFKr6okNE4jj4Qugi+C8xN2eVICFADR4f0awMccSJKjKx8eoSRnY8Y/RiSmkmSaZ9LWTgcDzhyCPVrh84uIoJSGLj7ZJDrb2Gj54TdpKslN+lMfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9FXM0sJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2366e5e4dbaso3026075ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750221300; x=1750826100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RtCMHn3OaTn93tWTmxxpAvxTcKLuMOyCWOMkbaVhJ0=;
        b=E9FXM0sJceN0L5k37UIN8FoLStaiQYADvfgXEN8fCg2WxPcoSd9uxYwbBBmzdFwBKS
         DmfLQPQqIU/EOMJLOtiG3PR5veuHdN0TyNa7Ej4gVIJ+5mtLtZsBZAO+XxAvl9z8XNMN
         RrjP1zN7MLMa3ZW1OHz98ClWynTZtf7xIsFTT7LxwvO/tHJJEeo99P7KOFZ5iTaYN2ad
         oNcGanbkyTn8SYCHPpwcKdoB5RorRZfp80mc9ntFlerklHI8eLA7EiOB/TlGg3ruNTq0
         BCaoja8rBgULC2cKMdjxbZrHzHeit/B2bhJ91a+QLtaD3DuO86EUTAu6uPAqDBM6sPVi
         dkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750221300; x=1750826100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RtCMHn3OaTn93tWTmxxpAvxTcKLuMOyCWOMkbaVhJ0=;
        b=EEXh9tyGyseBWQ5ZY/AnE6HMduE0dC1PtYNkQ5LAOfI31a1jWzIW3SjK6QT6OVfd19
         ESKCSEPNYAJEaWQoy/EAJdGlJ+x7BqZIHg7nnUTHPt0xZt4+Gc3SBObC2vDqCmoi6//K
         HqWKf/nrLG7LS1Z8u3qpWuCW7yv+3A70jCy4S6nglhmYeZXTMFm1YS6Yyc5wVVvkLUnd
         GTX+6LRsB0kqCkdx1z8ygInnRTfo7rItkKxL91ssBI7uLwfSu/jtD6CKMqbJvNPq9E4h
         weZo+tshQVaIz/JfC77TdKheykGRPRNosEvTYaEqbrKWjbQgM/kylFj0u6Mlfs13ERUC
         6KQg==
X-Forwarded-Encrypted: i=1; AJvYcCUlPpBpK8tYtk7CX6HfSqHRDe1qlgbFl4/rCH3hGlj3qf2Jjd47wdQ+lxE8tohzVysg8vAkF/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/2vRqWaVv35hGsSUcB+xQovjrM5MiUJXIVaH8lBGjHx9FZxS
	JkZtkfil9nlW9FuWMEPZaMGIqnikXExg0UM0EFmwlFKcXHwu6xPnMGA=
X-Gm-Gg: ASbGncsprdEiRoa+eKooCGn0vH4FE5jnPztHm9MDSbV9OD4xpPBImHv3vHHF9Fygpdh
	b7jKII6I3qNAeNDwJ4tbmYl4WhbfnlrqWoP/yEj3qgW0cRny1gFmK6bwMZYq7ymHoPFQxJ6sJhs
	arPF3nzZMtTn7KsBr07mlmUWrciciuKoLYkNN9QTrh1AT4Jj5yEbs4OHg9ndzY/aiQ2+6/G6Zxo
	qh4xHSfp5yF9b7d9Ef3NZZSP2s7Tbe/kRDHbL+H7LlGRXjMZWhRcIyMtJ94HaHmglRWAbcLQd85
	pC1ofjKVEtdwWa9yhl9Bpy/GM4XDB3oa/CCbpH4=
X-Google-Smtp-Source: AGHT+IF68qmY0H8yAUUkOgjGWENWDUZ0Htsv4Z91x6+TkrKuNikg9o1pOC1pnsyjS505Hq2cugI2Lw==
X-Received: by 2002:a17:902:f710:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-237c20e3529mr20128835ad.18.1750221300368;
        Tue, 17 Jun 2025 21:35:00 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de77610sm90072225ad.135.2025.06.17.21.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 21:34:59 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net 2/4] af_unix: Add test for consecutive consumed OOB.
Date: Tue, 17 Jun 2025 21:34:40 -0700
Message-ID: <20250618043453.281247-3-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618043453.281247-1-kuni1840@gmail.com>
References: <20250618043453.281247-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Let's add a test case where consecutive concumed OOB skbs stay
at the head of the queue.

Without the previous patch, ioctl(SIOCATMARK) assertion fails.

Before:

  #  RUN           msg_oob.no_peek.ex_oob_ex_oob_oob ...
  # msg_oob.c:305:ex_oob_ex_oob_oob:Expected answ[0] (0) == oob_head (1)
  # ex_oob_ex_oob_oob: Test terminated by assertion
  #          FAIL  msg_oob.no_peek.ex_oob_ex_oob_oob
  not ok 12 msg_oob.no_peek.ex_oob_ex_oob_oob

After:

  #  RUN           msg_oob.no_peek.ex_oob_ex_oob_oob ...
  #            OK  msg_oob.no_peek.ex_oob_ex_oob_oob
  ok 12 msg_oob.no_peek.ex_oob_ex_oob_oob

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 3ed3882a93b8..918509a3f040 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -548,6 +548,29 @@ TEST_F(msg_oob, ex_oob_oob)
 	siocatmarkpair(false);
 }
 
+TEST_F(msg_oob, ex_oob_ex_oob_oob)
+{
+	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("x", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	sendpair("y", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("y", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	sendpair("z", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+}
+
 TEST_F(msg_oob, ex_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
-- 
2.49.0


