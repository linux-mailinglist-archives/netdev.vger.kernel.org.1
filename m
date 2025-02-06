Return-Path: <netdev+bounces-163649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3DA2B25C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04393A29E7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249C1AA795;
	Thu,  6 Feb 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzZjyQqf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4C1A9B3E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870532; cv=none; b=OGVfxTE65u1iAvcIPUnmbFlGjcTyXRPMevWE5RKectUCjFpFo8nyOycnP1GmjlgCk/H4Gap2t+/X1HwjiYCeCU0RiBgY9tadQ8C6kHeBlsL/6TmTDJPtIdLSaw86yBj2qv/2KRGdS9Tm8MkCKPeoWyGgVkUL/xIciXl11nHVC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870532; c=relaxed/simple;
	bh=SkWuNN//hqCQwzfB//aMR160tSPQ136kOB1bhGfamIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4tRAbjXt+9MwEC5wHKyV2AIXawVGorc/98sO6cZggklcjgbcjHOoPgJCHAA88xwE/8NK5d0/ir/T1xnChQjiNP856dLm2PJ1RVoWlgqoY4nsqibs/oTUJALBfiyJaoPc9Mb9scdWzmMRVG3UQW7wZk4mFyirdpl1iRGoNaCm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzZjyQqf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46fcbb96ba9so15314931cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870530; x=1739475330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGfnLk9Q/lPUAqX3HfpstjMkR3lqRXGKEgckMFPRZUc=;
        b=mzZjyQqfgO9eOkGlrBtYWSstTU7YGLYF3y2vQoYMaPisw1CG7W5LiS4gnQaxs+fzgq
         tTj7j72+NjTiGU7z15HqFsYU+u+JL1JQEdtFF9SLFNsNAfDWyn2eFRTBv1eHfST+d8sU
         L2NHU2EEpUF5CeNUohErIZ3gqT65m/yRwO8sqW4Hx8pFxl1Rtqg2s3rwu+7b87sUcpCv
         mubr7CSvZ/C5la02MWdQc4mEEoQwzlCdpKRX88BtAA30FW0JJWyzxb0xXRN29L0ik4UH
         Ci+8caEs4LFkzz1C1eWf8uCAbhfBJUOOT6BnkLeEMOQOdLrtrq22gdYQNEmb5TbzI+F5
         LqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870530; x=1739475330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGfnLk9Q/lPUAqX3HfpstjMkR3lqRXGKEgckMFPRZUc=;
        b=S7QSx2IYDGhxqPjSy6uFRhq2Z+r2kod8fmxEFaRxAZS2xRV8+6hvoGO2nAXtGAg1A5
         nbpN0KoNwoM7U7P+MddhAmd/lgaMsLQjpIBHZvxNsvO1WdpZ2iQ+Ni6eib3Hf5jefDed
         QBlgvFCq9xju3VkqlRLCvXO0OaLh6UNulO/XiVPT2HL2pUhPNqRV4dEDbdiyvqVyQ/jz
         7Q9j/Ok5fhriD1fpU+AgO79PAC81JQjpnNtQyuOvCcSCvXoOQlhQ1SSPKKPT03BvbwjA
         JU0pdUOgQLpf8BIJEURHYX4ssd5ww+ob6B2k4Bhypxzn3cK3+0EVds8eeWBlf3UOQ2nZ
         5+Qg==
X-Gm-Message-State: AOJu0YyILOZkzJRiacSknsWHKSUHiXORDw2GSQczbAeI4Qc5EHVqFKDS
	e52gmmncWQmhzZ8qJmSnxvD7qB5TT737AOvp8CWBBqcOqOHcOKldyTH00w==
X-Gm-Gg: ASbGnctTTWhWWTqw+3FF6LO3ps7K8euRGQ67AiVa6DkVde72UrH30vnUj9jGm+iWUlQ
	SJI/dBxnKS0OCVNr92yanMNudVyRqkt7ADvVxKGnnJ4QVlixtvl1L+uQ/xWLmEoZ8TE5SZdEsVw
	BZiSNSO3Xf+zhoGJ7NLEXqPIBkfrv+tDaBJceSThWDJeqEzHmklTsOr0MkxNsoSnalZYBHt/9Zx
	djVIXfB5ee8QLls/MUC4Dhb07YvUmDW4ihpuHjbDoeApJkxIqO0l31nbA9mX31K7mXIhKDxDKOA
	foG9uugUcaZKdETXjggvQLCLQtNZNdhVMZRdK5bGricihIqc9ZdImmVrDjDA68EWhjVDTO9veoy
	R0o2sBI6yaw==
X-Google-Smtp-Source: AGHT+IG2CK08zhNFS5SVonb47j/lurSsrXHRtw3mAbNWuPhpnQq/04zIa7Rhay6Seg/1+mC+LmCWjg==
X-Received: by 2002:a05:622a:392:b0:466:8c53:7758 with SMTP id d75a77b69052e-471679b2fb2mr8916591cf.5.1738870529922;
        Thu, 06 Feb 2025 11:35:29 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:29 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 4/7] ipv4: remove get_rttos
Date: Thu,  6 Feb 2025 14:34:51 -0500
Message-ID: <20250206193521.2285488-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Initialize the ip cookie tos field when initializing the cookie, in
ipcm_init_sk.

The existing code inverts the standard pattern for initializing cookie
fields. Default is to initialize the field from the sk, then possibly
overwrite that when parsing cmsgs (the unlikely case).

This field inverts that, setting the field to an illegal value and
after cmsg parsing checking whether the value is still illegal and
thus should be overridden.

Be careful to always apply mask INET_DSCP_MASK, as before.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ip.h       | 11 +++--------
 net/ipv4/ip_sockglue.c |  4 ++--
 net/ipv4/ping.c        |  1 -
 net/ipv4/raw.c         |  1 -
 net/ipv4/udp.c         |  1 -
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6af16545b3e3..6819704e2642 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -92,7 +92,9 @@ static inline void ipcm_init(struct ipcm_cookie *ipcm)
 static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 				const struct inet_sock *inet)
 {
-	ipcm_init(ipcm);
+	*ipcm = (struct ipcm_cookie) {
+		.tos = READ_ONCE(inet->tos) & INET_DSCP_MASK,
+	};
 
 	sockcm_init(&ipcm->sockc, &inet->sk);
 
@@ -256,13 +258,6 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
 	return RT_SCOPE_UNIVERSE;
 }
 
-static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
-{
-	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
-
-	return dsfield & INET_DSCP_MASK;
-}
-
 /* datagram.c */
 int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6d9c5c20b1c4..98b1e4a8b72e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -314,8 +314,8 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 				return -EINVAL;
 			if (val < 0 || val > 255)
 				return -EINVAL;
-			ipc->tos = val;
-			ipc->sockc.priority = rt_tos2priority(ipc->tos);
+			ipc->sockc.priority = rt_tos2priority(val);
+			ipc->tos = val & INET_DSCP_MASK;
 			break;
 		case IP_PROTOCOL:
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 619ddc087957..0215885c6df5 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -768,7 +768,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		faddr = ipc.opt->opt.faddr;
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
 	if (ipv4_is_multicast(daddr)) {
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4304a68d1db0..b1f3fe7962bf 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -581,7 +581,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			daddr = ipc.opt->opt.faddr;
 		}
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
 	uc_index = READ_ONCE(inet->uc_index);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c472c9a57cf6..97ded5f0ae6c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1405,7 +1405,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		faddr = ipc.opt->opt.faddr;
 		connected = 0;
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 	if (scope == RT_SCOPE_LINK)
 		connected = 0;
-- 
2.48.1.502.g6dc24dfdaf-goog


