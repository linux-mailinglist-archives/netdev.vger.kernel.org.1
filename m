Return-Path: <netdev+bounces-123742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8119665DB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA11C23DA4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CAF1B5EC9;
	Fri, 30 Aug 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXxJA5Ba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF91B6524
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032283; cv=none; b=JLQzahcO+BsTEYgzIKX0WszfdKms/0uZxa+mZUMf1/pMv22ojIgj2MmVOABq9tqaKt1+nNtvEGXU/2Y5OfJWSObhM1T6pd4ZTFgKmzDvk8fS87zcyOgEE0EF6JxUORxfKdt3F+P+vrluUkrICrVR2I3r5Q66fQdrfldtDZrPpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032283; c=relaxed/simple;
	bh=crz/z3biXDcXnk0kjfzI2z+1Z1NeuPCM0xY7shKpww8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDXSHYu4sNN0Nwf0Z+iC4envT4vunLrfH411xuPqHppPKfOUuGjztpwhc5/1oO7TJHZZ3dUgzIqvIlA96k3Nt2OCUQy7HM+EbfY9M6kmAOPt2Io4Lr1k5GyQDOMLZFFkYbj0tABQev+jwxThKUB0nqLmK/H8ROacKdYEMh7vvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXxJA5Ba; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201fae21398so14297805ad.1
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725032281; x=1725637081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFV8gzZ58PlQ5cQsUKBYjkAGj4tyehudKblQq7gDkGM=;
        b=MXxJA5Baeht/JlNfmW8VbX/DJWXH3aJW/52Vl/YYC9vnmsPV6VlGl9ZQdVQgj24T2x
         mKg6wxQJbJBreOLSpWbDr52RBRe4jQnhZUG3z0vkORqZtzDvFROIouDOv9JuN/MBBhRH
         RVS7VejLUm+xUVkWYteBJtq1jDzJT6hON1eQPdDjqfzy1y4aGer4XHVKsdCYnL9Leoxy
         swdCxowoGMMJto8LeLcmKKCRCTBxmHzNN8mvwX7F+2ZL8LbmAY6CyulJGKFfSAFfZ6lx
         9k+zNhkROLtSLfCkLUDK9DzRn38+pjjE4Bhp+sjQrkmXJaDllmIrvBjtgBa5PvPAZzWw
         H74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032281; x=1725637081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFV8gzZ58PlQ5cQsUKBYjkAGj4tyehudKblQq7gDkGM=;
        b=l1B+H1/a2hBKhkeYIp31Wvv2knyslRsXAltOOGBQgODYYVp7cWd/pVUvg21yIdyorZ
         DXxm87ufkdMkeiWePIxLq/ngMwpOIXoOSOV5J2+nUrwzF15hotbTcIwtpGvDpzXBylau
         /pOvsa7FKAfr1RM9Pog6/7x41UqX9+5dT09jkIOZEl/mEx0pr8cgD5910QLwmUojnCP8
         52ZeZPdT8D4BviJYpYxwZU+N4glcFHmfiirwD91SB2xa+XSfA+fAWrxVJD+59FZn4mkA
         mXcZUiyClV7BxRU8C7zkoBcQJnauMwJssZgAIy/K+YqSsbD9R+dUWTCCQgeC3WxFZwVY
         8gjA==
X-Gm-Message-State: AOJu0YxNDX4f6D/0p2XWgtjBquTsVE31/yb6MX7PyfEDZtQjHHPw2P2W
	NZVXAErfP5SVVRrHeShDSB+zQvPWvauJ1rI9JH4gL0RESSk8ws4i/UHQ3PQS
X-Google-Smtp-Source: AGHT+IFc6gyw7HrMe7BRJG/60uODzyQmEgG9KyIsTOaO+Wcwm2Hftquvd9oKtge28kb4KVPq/PNRCg==
X-Received: by 2002:a17:903:32c1:b0:201:eb57:dfaa with SMTP id d9443c01a7336-2050c23c643mr67005105ad.17.1725032281297;
        Fri, 30 Aug 2024 08:38:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd59esm28504795ad.81.2024.08.30.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:38:00 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
Date: Fri, 30 Aug 2024 23:37:51 +0800
Message-Id: <20240830153751.86895-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240830153751.86895-1-kerneljasonxing@gmail.com>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Test when we use SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER with
SOF_TIMESTAMPING_SOFTWARE. The expected result is no rx timestamp
report.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/net/rxtimestamp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/selftests/net/rxtimestamp.c
index 9eb42570294d..f625e74663a0 100644
--- a/tools/testing/selftests/net/rxtimestamp.c
+++ b/tools/testing/selftests/net/rxtimestamp.c
@@ -97,6 +97,11 @@ static struct test_case test_cases[] = {
 			| SOF_TIMESTAMPING_RX_HARDWARE },
 		{}
 	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
+			| SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER },
+		{}
+	},
 	{
 		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
 			| SOF_TIMESTAMPING_RX_SOFTWARE },
-- 
2.37.3


