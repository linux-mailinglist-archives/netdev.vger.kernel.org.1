Return-Path: <netdev+bounces-118829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A7952E75
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096E91C21ED4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E119DF7A;
	Thu, 15 Aug 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS4AkjLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438D19DF60;
	Thu, 15 Aug 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725954; cv=none; b=Elw4jOJBFM/p83BgEMRZCZg0PbizjD6Ws7SbNAy7HSgKH7qsQKKiTFqdKtg7G6COTp8N/s8LFQQUukTRmK5Uqmz/PbMpjJhmEcRBKqzu/YIft4R3uMkyw/4rxW2eRo5+sXE1oSi7HOky0CT6dJPCX7/9rIRAqGeP78Sr4LcSTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725954; c=relaxed/simple;
	bh=OlbuseaNOvF3/Jn6P4MlwF+xvi30sjvfJ1q1ayGJ0vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lS0dK+OUYpSdNhRGYim5ZDS3zqv3XpgnpARslk7TGnAgpMvB7gQa8Ukgju2aN/uKU+AQ3RLtKd6YD65cEcmi3zW9gvv1Kyovxn2OhlHUaujOpEoQseMXs9u0yU61wgz0XRsa85hYmb+d7lDlmgBKAOffl3rrpQ6S/uiCkc2DtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS4AkjLK; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-70d2ae44790so652955b3a.2;
        Thu, 15 Aug 2024 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725952; x=1724330752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp8zeXhcEXg8Pv4LgyftvHpTpRxQnDDkErPbz0q7r2E=;
        b=jS4AkjLKLjj/+Pbi+7o0f0pk9sRftLZCUNVnbnQfOsZuLi3YS7qzGvN7TTFbsAgZ+u
         hXpS/OJvkPRFoLMWVkwDanA3o4P5yAkodNT+ydgsNqnfdUkVqnTYsfDXUhVDIqq5vjJx
         +bKCgqvPGVvx43JMJ0HVHweTf+IVQ0QeidbiJUt1hlHIJbYzkskq5S6juMH4svz87Ahs
         hsGx6h0MwFih/dID4NMacA/s3U3Sc2WhrjG1uSgJ+40S7SmQXSNhPmQTKKBbJQBRY4fq
         jnMQ2apIWz3yUKMs9TXuqxH7p0T3mDZhlwjpzPTi3HRpm5Z7rtYiMaivuJ/9OLfHzUZN
         NOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725952; x=1724330752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp8zeXhcEXg8Pv4LgyftvHpTpRxQnDDkErPbz0q7r2E=;
        b=ci3/sHj+IuAummtF6+ntQxNyZ0qjJE1lHs3ciCuXkykpPJVq5cjep0tk0BjeNinHck
         eRK7Y6wSdl75dG89/fLIKqW0FvRELe3LRqEXnqGbNdZeiyXM37lC7aVnI3quZBkO12L9
         U3fgXRBrF9Nv6eCmUQadCG46oGCW2W7qZMJgcvXDD68zLVURwh0L8XpEoqzWIgZVdWpC
         hu1nzjn/9mrzOgls1l2rjWm16eX1YX52kIAg0Z9R3tBMgLqXpTXnhZ4LDkH4zEvcJjoL
         tHiSx8sFgcDVqKZZLy04HEP9tnmBW3cdY2s1ssPnlcl2qqTZnTZn8zO8h+5RWhMUnBcj
         ym1A==
X-Forwarded-Encrypted: i=1; AJvYcCXX0rYiEBIqyG5EuDJCcN3avMw7K09z+V8vF1qJ12KF97T/i/2cJANkhRyIb1DcuiHUTDVu6I1zPIaZbB8eFYDlgKnweRkmrrKYVeYGu/Ye7GOc5j3KhQvn0onZuJAIkZWTIf3j
X-Gm-Message-State: AOJu0YxWbmaimSubRxLYqGO3CO1+L4XpivwhylaIioBg1n6bzyrbIy/L
	oZmby8L5++21zMuCPNKhRx+jIlYUop7fGcvcDsV4g5CPEIm/aauG
X-Google-Smtp-Source: AGHT+IGiVfC6+BHZXeucoMuSKYp+sYroQa+K52k3ZPcfelHi33uZ4sXWZwIeo26CXGl1WMQp6mkKEg==
X-Received: by 2002:a05:6a00:8d2:b0:705:9a28:aa04 with SMTP id d2e1a72fcca58-7126739c567mr6987357b3a.23.1723725952175;
        Thu, 15 Aug 2024 05:45:52 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:45:51 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 02/10] net: skb: add SKB_DR_RESET
Date: Thu, 15 Aug 2024 20:42:54 +0800
Message-Id: <20240815124302.982711-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the skb drop reason can be SKB_NOT_DROPPED_YET, which makes the
kfree_skb_reason call consume_skb. In some case, we need to make sure that
kfree_skb is called, which means the reason can't be SKB_NOT_DROPPED_YET.
Introduce SKB_DR_RESET() to reset the reason to NOT_SPECIFIED if it is
SKB_NOT_DROPPED_YET.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 9707ab54fdd5..8da0129d1ed6 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -445,5 +445,6 @@ enum skb_drop_reason {
 		    name == SKB_NOT_DROPPED_YET)		\
 			SKB_DR_SET(name, reason);		\
 	} while (0)
+#define SKB_DR_RESET(name) SKB_DR_OR(name, NOT_SPECIFIED)
 
 #endif
-- 
2.39.2


