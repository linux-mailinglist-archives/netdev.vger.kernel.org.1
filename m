Return-Path: <netdev+bounces-137288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321309A54A9
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED781C20996
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE2198E76;
	Sun, 20 Oct 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYJhwIcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EE198A07
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435843; cv=none; b=erJfNScwXKPGJyPS/UO7WHQ0+IJAKN9TWrJyHTumEpZLqlG8JMxyzAhER9+LaqmmGfhffLfzgqH0bpdSxYRePCafNSWSidVEor/reCynsYL+01lQI/Dy0ezqyrwev11dDG/zO2Tt23GtpExeLLISbhSn7AY3iGQAv1JnD4ubWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435843; c=relaxed/simple;
	bh=6VfnXJnOt1Ckm7l9DjVdn33kV5ZQZTS1tLykZrl3LVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvneKLkSf6GanrToszseb1UnnURe6FNLD6xbd2ny/eXxwygNQunrNG2i0zym46HK8BP/6kZydAhwDSSfXPYxb8tEuvj0OV3KHLOHqxNDQXgSks5hMCNui4UHSWPfSouuAPt360tJyRQiFU5QO20mHNJ+DK5ENXl5wE1T6a6aEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYJhwIcd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso2528145b3a.0
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729435841; x=1730040641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWOajaF2VVWKWSA0X3Ls0JcnYwJuqrgLXc05L7hqJQI=;
        b=VYJhwIcd4JFMmWG7wL+Uw52lC7K7isbYfZ8ZVolnm3mjNduQuczfUN66TarSVVmx4I
         A+Z8ueVv0+a0zatO6NV3NBleUDR7gzqjY728POjqKHSIjg7YjR4f1+Sz4DjM2HChr3Xv
         FoW4P1jDe/MYDYFHwOIxfjQjTRHpbhIUQ3Zi4o1g88GOOggtghRH/Y9swM0bIwyaeIFg
         JfKdOHiQyc+hmvJTb4eMcC87exq6eZ7e/rYnPJbL67LWmRYdTkO3YK+2x0MJU70q1P8J
         JBohV3+WzKGfuvh9rNK7127mzrHErEjQ5SGtaaq5+hWn2Hb3xEh03UCfWgqnJqFkVGcm
         SaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729435841; x=1730040641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWOajaF2VVWKWSA0X3Ls0JcnYwJuqrgLXc05L7hqJQI=;
        b=PBqlzD4hwfhi9J4jDC+PzU46Q47efHhTMSpb4ejGgkRf+9Scyxx+p1bLd2P1M7BuOd
         7WMqFoIX9habCc8bRKZNc7PmqC42/VQbjOedmCLojNRTMTnyzqXipImlpvYFKgNHMjOM
         OBmY9A64elIVUvW8Vb8mE/73TzaUFMRDNjAWL+bpr0Swe/Cf6DReKsq0e0SVNzIXk+h5
         WIE+/IB3r91PDk0A+LplbrHvnBd61iF1otFoLI2u0+5TO18mcVcxm2ZUB6r/9CzrMuAB
         13e+60XYUkBLluGST5tJgQscQx9I1n4Sr7zNDMYBVH8rkEP4MZrdrFDh3hVs3Ro8ZsK4
         PnqA==
X-Gm-Message-State: AOJu0YyLD026wN0j3TvIKAedD9mtFA53ftz5X2vYi+RX04BaYmb4o9rC
	VXZXIOTy2uZ/hFC1xQWA1jfU7A5WUNEfuHf0gjHoV82J/ZyopX1N
X-Google-Smtp-Source: AGHT+IGcc4dOujrbZVb7578zVC3pX2K3Vk/3LVrwm09mcXixFqp9CRa+ehh+ibZFWrrxsnekqxT6kQ==
X-Received: by 2002:a05:6a00:1495:b0:71e:4ba:f389 with SMTP id d2e1a72fcca58-71ea314ee9cmr12223059b3a.10.1729435840991;
        Sun, 20 Oct 2024 07:50:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415066sm1243979b3a.198.2024.10.20.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 07:50:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] tcp: add a common helper to debug the underlying issue
Date: Sun, 20 Oct 2024 22:50:28 +0800
Message-Id: <20241020145029.27725-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241020145029.27725-1-kerneljasonxing@gmail.com>
References: <20241020145029.27725-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Following the commit c8770db2d544 ("tcp: check skb is non-NULL
in tcp_rto_delta_us()"), we decided to add a helper so that it's
easier to get verbose warning on either cases.

Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 include/net/tcp.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..cac7bbff61ce 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2430,6 +2430,22 @@ void tcp_plb_update_state(const struct sock *sk, struct tcp_plb_state *plb,
 void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
 void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
 
+static inline void tcp_warn_once(const struct sock *sk, bool cond, const char *str)
+{
+	WARN_ONCE(cond,
+		  "%s"
+		  "out:%u sacked:%u lost:%u retrans:%u "
+		  "tlp_high_seq:%u sk_state:%u ca_state:%u "
+		  "advmss:%u mss_cache:%u pmtu:%u\n",
+		  str,
+		  tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
+		  tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
+		  tcp_sk(sk)->tlp_high_seq, sk->sk_state,
+		  inet_csk(sk)->icsk_ca_state,
+		  tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
+		  inet_csk(sk)->icsk_pmtu_cookie);
+}
+
 /* At how many usecs into the future should the RTO fire? */
 static inline s64 tcp_rto_delta_us(const struct sock *sk)
 {
@@ -2441,17 +2457,7 @@ static inline s64 tcp_rto_delta_us(const struct sock *sk)
 
 		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
 	} else {
-		WARN_ONCE(1,
-			"rtx queue empty: "
-			"out:%u sacked:%u lost:%u retrans:%u "
-			"tlp_high_seq:%u sk_state:%u ca_state:%u "
-			"advmss:%u mss_cache:%u pmtu:%u\n",
-			tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
-			tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
-			tcp_sk(sk)->tlp_high_seq, sk->sk_state,
-			inet_csk(sk)->icsk_ca_state,
-			tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
-			inet_csk(sk)->icsk_pmtu_cookie);
+		tcp_warn_once(sk, 1, "rtx queue empty: ");
 		return jiffies_to_usecs(rto);
 	}
 
-- 
2.37.3


