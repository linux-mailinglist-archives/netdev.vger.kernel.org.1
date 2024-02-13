Return-Path: <netdev+bounces-71395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D285329B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ED3282039
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BE56762;
	Tue, 13 Feb 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXVwt6IR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C556766
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833166; cv=none; b=SC5KGqJHTo5ftOIZr+5VCbjJ3vam4634wd+RbK7C4V/pk3emKM0H4NRAwkfICT1igP94hNI4JRs8a4rQ433y5Kw1GpSgHswtjPIoUOvYM0Ytf857taglVEbW7FesrKFrLfH64izdCyT48A9y9FVuVpYQFkbmZMlRplcmJRFhLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833166; c=relaxed/simple;
	bh=pM03emsOdnkfRw0YpBGJfKaeWaExAlzFZjMO02xyVas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSJl2CkLYiwOb04E7c8MpO0GwA9gL/EKYl/4nSreqh4VEOG5iZvQuSxkgKTFP8pAg69Gi7LbwQzzvjjUH7iqoSCU7Bqr9siIBtbZl2UHPJUtODJIzDhmyKoAjl1aO3BGwjLkgCEsLECNCDwCHOajpuxKOBIh8nWyEkHElQmNU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXVwt6IR; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36423c819a3so588605ab.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833164; x=1708437964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+qlEv3zkbEchZFcQWVopUaH0qwicWIrROaQiuqCVLg=;
        b=lXVwt6IRaIczTIlxP0bi+ThOkqHzyqsJaw4BxACXySSl7L7rVzEkMb+HnyYJxgDLRA
         iqpvV/jXbt1+GD1O191R2qfVTdVc7RXaTRPBj+CruFuhodTqdQM7GOvLxFbBsltNQ16U
         hb1YLPO3njpAr96CSAi05jSWv5Pdk+Snvqqx8GRKzkrI10SRJ8TwtWExQXR57Q9TyQCA
         Cf8rG0beTDJMDgY8xqcldBtoUK4kjWSwLTH8FXvE2C+hlQJWEqUYjjYg80uxOlVu2Q+f
         7vI/f3+IXJPlbUq4Ncz2oMhaNvOdCddrkv6TiNhp0XDaBgTzqBlOfIcm8OT8+686dE/J
         kIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833164; x=1708437964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+qlEv3zkbEchZFcQWVopUaH0qwicWIrROaQiuqCVLg=;
        b=ny3OOBl2WOFu6cEEDAtfXXnmrF3K0gwwHe6bbS5wnkDbc1baUtVsK3H7xEBYZxLfPt
         /tm7o8lxkQcufORqqP6UbeKiSTFAw5wSTS6yjeoFEmjRo9T9fWUyo57MqbcaIWzSzxYN
         rnd962FgmK7qpkIWa/f8rq1yNCW0+BWV7mtao9EM1CDDl1ooFgmuLx6BsMBNOkFAsjYO
         Zzp4JV3PMLqhLhTuV56Z56BN0vwhCXUHyjD+tB19Sh1FrBu+xt94oPtKrGM1m47fF1Hy
         7KJjVHG1iLHi1/PQtepLB0HgR5KGlHCQ7xqSmI/uMzFbBLEZTnspqxuDnci5bW81cS/C
         tVSg==
X-Gm-Message-State: AOJu0YxG4pjVyhhbIdGZmSu3dnZFxawfBEBjB+XWthB5+xjLSwe/ProE
	0mHpkgwAPyuZzP1sBib00ZAkQBiGCigpmOgnW2nlco8XajBMrCR5
X-Google-Smtp-Source: AGHT+IEHRyLVMJYDmI98jn6B+r4bkGBdv01y5QoVcEfhfaXnlzs4vqwvMSX+NyuqBUHLAToVV1aA/A==
X-Received: by 2002:a92:c902:0:b0:363:d7c9:8189 with SMTP id t2-20020a92c902000000b00363d7c98189mr9445370ilp.20.1707833164275;
        Tue, 13 Feb 2024 06:06:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqZ64rY4u1Rc4Y2tqxfVG9jh4+kl8+NQ64A28EwGgGQ+YkOIP+czldvL4fFyUmG9x/nmkB3Pyk4z0nsKi6PEQ8m4G0ud119ObZq41gwgCk4jkfFDFVSGpXgabx9mqPJJ5M7Rqy8UpcaxmqOLApn7qKaPB9Rozq+RQZAecVPb9xm1YIt3KJnJU0hamD/AyzbM4dPoj1WYbWn6r0fNgi9PXOCG6ZiPbNJGldo06TTPwPO+vXI6qht6iKW0RU1DYG9Pxh
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:06:03 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 1/6] tcp: introduce another three dropreasons in receive path
Date: Tue, 13 Feb 2024 22:05:03 +0800
Message-Id: <20240213140508.10878-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Soon later patches can use these relatively more accurate
reasons to recognise and find out the cause.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/dropreason-core.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 065caba42b0b..19ba900eae0e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -31,6 +31,7 @@
 	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
+	FN(TCP_ABORTONDATA)			\
 	FN(TCP_ZEROWINDOW)		\
 	FN(TCP_OLD_DATA)		\
 	FN(TCP_OVERWINDOW)		\
@@ -38,6 +39,7 @@
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
+	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RESET)			\
 	FN(TCP_INVALID_SYN)		\
 	FN(TCP_CLOSE)			\
@@ -207,6 +209,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_BACKLOG,
 	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
 	SKB_DROP_REASON_TCP_FLAGS,
+	/**
+	 * @SKB_DROP_REASON_TCP_ABORTONDATA: abort on data, corresponding to
+	 * LINUX_MIB_TCPABORTONDATA
+	 */
+	SKB_DROP_REASON_TCP_ABORTONDATA,
 	/**
 	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
 	 * see LINUX_MIB_TCPZEROWINDOWDROP
@@ -231,13 +238,19 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OFOMERGE,
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
-	 * LINUX_MIB_PAWSESTABREJECTED
+	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
 	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
+	/**
+	 * @SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK SEQ
+	 * field. because of ack sequence is not in the window between snd_una
+	 * and snd_nxt
+	 */
+	SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
 	SKB_DROP_REASON_TCP_RESET,
 	/**
-- 
2.37.3


