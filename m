Return-Path: <netdev+bounces-175092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D069EA6335A
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 03:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA60171D52
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C347F4A;
	Sun, 16 Mar 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHyLKJzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C02E3377
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742092042; cv=none; b=TvhjBS0L2fw0eOZLwD3H8lIh/+P/c2MkX78N8X9oBrjgY7zgtYnYTrHhH3tFxXM0H/A05sWIgsZlvftY2+gSmLuM7jY+2M1L143dWv5A8iJFUnW0FhMorFkkzisyJNkZYIO/3leB3BuaNANnAzZNm37qYBxpZ5flTTFde216NVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742092042; c=relaxed/simple;
	bh=p1zqwtMwUC8l2VqkUa89CUbbV12OfBw2FWu81LPjhrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZn4hdvSBjR6ucJqN1fyVLNlsZ/AHKur+nt3knC5yJ41OGUdYeCq9ynrFRmipnDUB5iPqisDgbuFJH1yFdD6xcmGXaR+D11iLmLTyhtQtBVdTohn8DHVnmFzDxDWPulR3NHLZeETbngCcDuqSJDvwumwnFyierUXRkVwvlgP89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHyLKJzg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso63246575ad.2
        for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 19:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742092040; x=1742696840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXZ7wx9r6WRYuiNIvyaV3Xqf9T/+ZIkxQpgEkkIdPKg=;
        b=eHyLKJzgSh5aQmUH/imhOzvtyVXX38qMsoVQoMJQzunD3oBqLfPg0WVbKhO85cZcim
         cW9PRTjwEi79PKrDAVMaAqZWau1cGTwpgBQX9JQQNp2s05/L6WgviAxpIK5YF7hdLGJr
         BmB7euHF+DLDE5GOVnmNK6b0kZ04w1i1FZKya8AHy1YtaOhJWIahRjK1OzFD5OVd1Ugq
         YKSW+ShvvQOUV8ROBMnAPugP8kePIfwqJflgTSPYYGevurXFNNG32CvPNRkhrD5ckdT4
         iU/GcQjpZkKnrH/yKusBf7sHLRMyj/kIvMXcNWuHgcSm/Cx7a1ZybLcr0WIzQc3sOXOH
         wu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742092040; x=1742696840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXZ7wx9r6WRYuiNIvyaV3Xqf9T/+ZIkxQpgEkkIdPKg=;
        b=LUdTfrZwRHzjxFRtln631qRfo5DxBDe+r/C9IkqwxcNlxx4eDAE6GPcb8rKrTdB0W8
         IVqk+Jwjq4jj+YTstWAtFT04sGTKkY2RyaYliZXGTmy8lA7Uy5/IutuCgesLgkW54CYX
         InGLRdR9LS3zmp5NPTNf4ubklHdx0lIHaH5LsKWFEMF4f5P4Sbc/RQjR8DbQ6Ml8QvpD
         MUhPQfWQLKZrIqYhqxV3HvlyoEYYKCd7+KzhWZs2YVptWEy1q0XAZZQYe9WEv9rlqgrh
         K4ltR6mD3Xsrw2XHFw/IBufRp2XnNARpO02eYxx6WDHo8t/6OxxLIMmPbR/1ylAhTBto
         wm7w==
X-Gm-Message-State: AOJu0Yz3vZI6zZC8O7b7LIIRrLVEmSckOllz7xq2DT8a2mccajXD8oh2
	3vJBsYYAy+7ernbNeg9o0ziv4PlDjbkOePfPNsX9+k8XeLyURr0D
X-Gm-Gg: ASbGncsnFnQ5cVIOJMkUYxEFxTozGBnh8DddScBwfj/kzy026p4IBNwGqD1xvkBNqqf
	Otq5zOLVX34Zugybwept98HJkVMAP+e6R+evgd2B8RHdzUkYWug+4EP+jLTB7VF71CMlsTlAyGu
	kBSRNpVDDcUMAbXIPpV+CG1H/YvMbH2Z9oLr4PY6AqrF6cWICk1mwCSVXTQmTRD2p7dtZdftDnj
	sLAxkDb2RPnNmtfi1wVezhz8ibeF3YQ9t0FfQRRaIOegEIn9QzEFB7esYEGctBlkTkDtvLyguXD
	WkxMjC1x92WkISzxNW4oSuNvHo4u97RGazCgHy8wXP3urptuiU+an2NVDdD/oFmfUXjIoM0nLy4
	vtgXtUTs=
X-Google-Smtp-Source: AGHT+IHx464V2jPBq/itF8hfsVGWvYkuwkwkPiVXopjxOQucEPzV1rGN8lIoPo3cHdaXqq2y47xFiA==
X-Received: by 2002:a05:6a00:b89:b0:736:450c:fa56 with SMTP id d2e1a72fcca58-7372234a883mr7853716b3a.5.1742092039871;
        Sat, 15 Mar 2025 19:27:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694b2csm5068255b3a.129.2025.03.15.19.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 19:27:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v3 2/2] tcp: support TCP_DELACK_MAX_US for set/getsockopt use
Date: Sun, 16 Mar 2025 10:27:06 +0800
Message-Id: <20250316022706.91570-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250316022706.91570-1-kerneljasonxing@gmail.com>
References: <20250316022706.91570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support adjusting delayed ack max for socket level by using setsockopt().

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/tcp.h |  1 +
 net/ipv4/tcp.c           | 16 +++++++++++++++-
 net/ipv4/tcp_output.c    |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index b2476cf7058e..2377e22f2c4b 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -138,6 +138,7 @@ enum {
 #define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 #define TCP_RTO_MIN_US		45	/* min rto time in us */
+#define TCP_DELACK_MAX_US	46	/* max delayed ack time in us */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f2249d712fcc..d12a663e13be 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3353,7 +3353,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
-	icsk->icsk_delack_max = TCP_DELACK_MAX;
+	WRITE_ONCE(icsk->icsk_delack_max, TCP_DELACK_MAX);
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
 	tp->snd_cwnd_cnt = 0;
@@ -3841,6 +3841,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
 		return 0;
 	}
+	case TCP_DELACK_MAX_US: {
+		int delack_max = usecs_to_jiffies(val);
+
+		if (delack_max > TCP_DELACK_MAX || delack_max < TCP_TIMEOUT_MIN)
+			return -EINVAL;
+		WRITE_ONCE(inet_csk(sk)->icsk_delack_max, delack_max);
+		return 0;
+	}
 	}
 
 	sockopt_lock_sock(sk);
@@ -4686,6 +4694,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = jiffies_to_usecs(rto_min);
 		break;
 	}
+	case TCP_DELACK_MAX_US: {
+		int delack_max = READ_ONCE(inet_csk(sk)->icsk_delack_max);
+
+		val = jiffies_to_usecs(delack_max);
+		break;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 24e56bf96747..65aa26d65987 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4179,7 +4179,7 @@ u32 tcp_delack_max(const struct sock *sk)
 {
 	u32 delack_from_rto_min = max(tcp_rto_min(sk), 2) - 1;
 
-	return min(inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
+	return min(READ_ONCE(inet_csk(sk)->icsk_delack_max), delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.43.5


