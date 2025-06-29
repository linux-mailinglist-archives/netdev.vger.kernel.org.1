Return-Path: <netdev+bounces-202296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BDAED153
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DEC1744EC
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7F24166A;
	Sun, 29 Jun 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iIROGsxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918A244699
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233246; cv=none; b=StQwVieZU6doP/fxGeZHYNTY4k1+uJVoEIVeU+P5U5wcpLVcBDThsyiOAyXtA1Y0g600PpUtd+6DPTQcJA/aJLiFUAtxENfyyppDu5Yh6247V2OM+sWylykZCyosJXm5qXNOoC5e2zKPXF2A4F09HINIKokHvRgTQrYZKnqZUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233246; c=relaxed/simple;
	bh=HDrnBzNT9sqw61xhXF1ulsb7GjHFsKMwkldBN6Mty4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etmmDk7kmvAIcP4sPGvr+sCBAclb+DHTjS1ohtdiSX9RVFOcpUL8SsYy2cfOb4Ju3M3/829x/0iPNl/vs5IKTxAjW4UoIszIFcjTn6IWuoSyiaokgnchIC9XyxVmRdPq4DUMQba8/L6QK7UVD86IO8+ry8+abC3HukrhIc6eiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iIROGsxv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DBF203F920
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233239;
	bh=tvyEgsiRIsWy5+9Pkt7fEE3jkj7QgFDygIBIFRyaq88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=iIROGsxvT86S2eu7cl96Oyl5yCcM/eh3jMASxIc5sIwk9Uz4NUtUAmVpX/P3GvtuJ
	 TM1LXBYQuzSlIwilUL/BcsomVM7yvSbj8LVonIbeQ+CETo+SkGvfBoWWQeGp7jrCPG
	 JATSxuP7f9qKPWtZsB3Q6N+EkxCXZ+eRo70uGjhijYxeMubjYp7Z9xiLGOJ7B13jaM
	 NNhsuA4lNOMmfLPFAscAj26M6tJgL1yim7YK433uOJaxC7Uk3k2R+oYzGaOXW5TRFA
	 wdbGiWJwRKZyDNDt7vR0tOeg20J9fVpRavWYGDfsIlbviJylPsUKrPbRZ1ttwfR13t
	 5MQcyz3vviAWg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0a0683d6dso127664066b.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233237; x=1751838037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvyEgsiRIsWy5+9Pkt7fEE3jkj7QgFDygIBIFRyaq88=;
        b=Sm9i+Ntd9rdUSE24W7amqDEVF7I3No7+UVgudeF9aQy+B5BSt8TycnCMNkPyvDS0he
         Q1vejZzk0IrKcWSOlrZ58HD/Q4QifgWcYW7KqapubLnoQGceF4vI5kb3d5xW4Ua+Wzyz
         jzkP/KWDPyWXcH6CfIpNmRDxfq0wtWWA7hW6sXAPU14AJHXdosjAq3SwIZUCx134tW9V
         mZ3E2YEj/bgsMBLFj9oHKABB417Vqj2Qg7ifIu5nlm2LlIAbZbs/qHYSoeyB5yoCuyh8
         aC4HwfgWvMGuEcb8+lqfLTyy6bdFWeNk5Htf91XABoYSyFO1/OcMAUeZjGZUKHniuqA+
         X3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Y2Yk5vla+1Cp2hb2ounZAv2lJDyoFWsElfsOh3Yhv+jgJIOBlwBb+eU0WswxSg5wSFOGO18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVxZnD3s5qLjgd8Jlh7CrsSLeVUA4nYGj075lPuKWQjLoFls4
	KMobGjLO1solHHJKhOy4yjUllI+oPxy+xXQhGbPXaymoEe1GM0Y74LnDJ8xl90dLgc4HyV5j0F2
	W/UXqXFbOTNh8rlrJRyTIl3OmIZwcpEQSsqeuTYK5sfzhOApuUhsQTaHkcpTM1NLQlyW2IX1MUA
	==
X-Gm-Gg: ASbGnctM4KDSJGEy00pv5EAJc/8oypGjXfSjG6BtORZkWxbFoazGGTMBA9R10H1zu25
	X/m/yBKzaVho6k18KDhVxqjFzWEmdMpY8uVdMJCfOqTRLust7id/UrCXxnxzVUZElxVYdTYZXLX
	zugnj0IHooELMSrEMFmUGqdD9nsOGS33nACLLpxAprTQ8uGL0isyBKEMFkFf+HknQK/BUi6v+uC
	0SWXdpoUV67eZWRmtg8Jm3dsEfYYSV1Oy1I9Oov+/w89qe+6rncGp0KuXaywka7P74EyXxY09PF
	ujtRQRSkAJUisk1dBvDTD7UcwpWfj5/mYJ2DD6c8XryAc/31Rg==
X-Received: by 2002:a17:907:3d8c:b0:adf:f82f:fe0a with SMTP id a640c23a62f3a-ae34fd729f7mr1138531366b.16.1751233237566;
        Sun, 29 Jun 2025 14:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKwXxCz9pE3Brid5b7t2MI0/k++PiuT/Gs+VG0QU8yP+Mj+j5hphzeOjffLrTX6bnFkf0tdA==
X-Received: by 2002:a17:907:3d8c:b0:adf:f82f:fe0a with SMTP id a640c23a62f3a-ae34fd729f7mr1138529166b.16.1751233237127;
        Sun, 29 Jun 2025 14:40:37 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a754sm557263366b.62.2025.06.29.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:40:36 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next 5/6] af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
Date: Sun, 29 Jun 2025 23:39:57 +0200
Message-ID: <20250629214004.13100-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now everything is ready to pass PIDFD_STALE to pidfd_prepare().
This will allow opening pidfd for reaped tasks.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h | 1 +
 net/core/scm.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index d1ae0704f230..1960c2b4f0b1 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/pid.h>
+#include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
diff --git a/net/core/scm.c b/net/core/scm.c
index 0e71d5a249a1..022d5035d146 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -464,7 +464,7 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 	if (!scm->pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+	pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
-- 
2.43.0


