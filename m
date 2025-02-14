Return-Path: <netdev+bounces-166586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C8A36840
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F2171370
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFF01FCCE5;
	Fri, 14 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8GTfqGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3D1FC10D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572049; cv=none; b=IQ9vDfwIztKpcQzxDid/zOgw1PgB+Fr+8rnR9uKtEAPQ+pDVfT/sxkTmSimE5HarpeqIte9KEhPnycEMq8hitum7/wTTV7ISafcCtMDhLCMM2k0sJ9M4MinoUkPpZeymFdcEQrdqfIcKE6W7TgdjO9FDkqUKSRycgac1PYFh19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572049; c=relaxed/simple;
	bh=HZ2SmNpb5Ic64Mk3MgPARGv4aL46TGDHU4gsZuZFW0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNMkgnxNSjFZh6KcWvTnBt5CzTrbmKGMRTTXugRatujLr9Ih8N0G9dmE+Kh6W1jqIPwkvhAHvGarxG/mB4BlKGPZU/4gclIxb4DaKOZGJgmIaVfrmUN63z7HIs3h7iy95SyBcIbiX7qYySJxzvUX4FIdaEkv8XbO0afdIxhcQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8GTfqGZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e451fdcae2so25055036d6.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572046; x=1740176846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p82bngmGOds2cH1UrsYPHDJelca+70JaYaP87zs2bA=;
        b=i8GTfqGZcPkVANg+7qGpKijsQY2OnYoxlYQXAiEz+gxegNuKX7+ithiJVcRaI8Tx9b
         jJATX61zGFZ6bvbfXq9iOoyjjYoAgr7SafC81ozMxWxyKFfZYn7kw97hRNkQPX0uUAPd
         BTwao2Ua+VNuzrqAey9Kgvlxxl4CCgTjOLnZ9SQc822Ea4JD35AaSY+xg7eE5BqtlY/e
         /13ZyMou03QmPO6tRY5u2fxVWkIGWnHbbIzACzYZGX1mDMYWVT7buEPlL541/hQHDURQ
         FZg7Rs2IjQU5PUazr+o1xGsNN5+5Zhjt3YQcIcF2I/sGlvotaYKQL6zo/wUgBpr4gouH
         V/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572046; x=1740176846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p82bngmGOds2cH1UrsYPHDJelca+70JaYaP87zs2bA=;
        b=ukmSSlF8XJ3Y7KifHURYHLPJCPpi0aSgq+oF53pkZBBH7jAM7fXlWMf694bu9h7nra
         JckCGi2psjq0Tt/bjDdcTa2DgRtdCXHyXns3I838GQNmCvmV90ub3bK2JLTzu0LKy2tD
         10STjSRrqkfH6M+Mifqs0K2islK2MTJpFegxT0CsY1D9RzjDWMvLkeAfl889kB/4vMtD
         vLxp2bNpz/ctr7NiyJ422EfGXWG4dx8+v14Wc7RDjPTalsqH2dLGJmrxhV2RPxtOzL67
         2kJM4HOmJYfQ9PVLVYExdcvlKEZAcraChnUdQsT11WkPOxFqiGDTudVQqIDVstYl1w7x
         qUHA==
X-Gm-Message-State: AOJu0Ywa+2nnoIQZk6MDMPZP/u0vbvtBnZ9kkBmmmouxdr/2YB3cf6Xw
	bs+mL4x82uLWXuELCJgjHLWa2+w0pAgV/s59KGYbwc37jz6Igu4w7QatHw==
X-Gm-Gg: ASbGncvVcqKwMO2xdGVtY8sLuJFrutKb2/MV1v+GbiNAz/yZSUDdI3i4dxYRMvkVAig
	EiLJy8rhXKbfPlSfkrdnBX8ISfDNNp/Khm4dAOJFZxLfmhACE/5ISfDl5DAGNV6d8bE0+NVTU2s
	+CXLtOy/wAA9uCyLHtlAmMyJDixExFebes8emmPehY3X70crhSa1WUTM9ssNOpKSMYEY+VKYOog
	swlci/77q3daPhDesWidhdhTg0r3IewEjsGdEeLZRxeuAPMiTZxYt12aHFNawNfLpIEvdMIKwQ/
	uSfHluXZbw+LgVGQeBmjRXYCBX1Sa5n8HlUaR2TWZIoVmhRMBg3MpJ5Z7HbASGo4Bqj1+o3bkSt
	pC7p5uBaDsg==
X-Google-Smtp-Source: AGHT+IGduLcldadJ3fLwazVLPhXrvYEU4N75Cp7A8hKDvv7znIkPR55TjU3VMZhCGVkj2how06YpTg==
X-Received: by 2002:ad4:5fcb:0:b0:6e6:69d9:2bc0 with SMTP id 6a1803df08f44-6e66cd0dea0mr13917456d6.37.1739572046325;
        Fri, 14 Feb 2025 14:27:26 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:25 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 1/7] tcp: only initialize sockcm tsflags field
Date: Fri, 14 Feb 2025 17:26:58 -0500
Message-ID: <20250214222720.3205500-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

TCP only reads the tsflags field. Don't bother initializing others.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5d78ab3b416e..6a8f19a10911 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1127,7 +1127,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	sockcm_init(&sockc, sk);
+	sockc = (struct sockcm_cookie) { .tsflags = READ_ONCE(sk->sk_tsflags)};
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err)) {
-- 
2.48.1.601.g30ceb7b040-goog


