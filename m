Return-Path: <netdev+bounces-160299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AAA192EA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865AF3AC3AF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D42135C1;
	Wed, 22 Jan 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YttRcNa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B02116FB
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553764; cv=none; b=FmqTtdBJE21PFYfFuLMHLckfnRw18NGcAlHBgHMFVxhA2CK0cU/GH0JtrQpo0fRsGMslFr5oMSvY3lR2WkK5zk6ZWTffKf+i0Z1rUhCAVrMuD0FctdNobMrHzk2ho/R0FcM1UiobWTekvVWKQ734c+QjWLJ5uysehAfzfcJrWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553764; c=relaxed/simple;
	bh=/o3/l/9afeGTYp17GP2QC2MUMdmrgWfRjZnggaQP8GY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=thWtHtLMNWkKfCPX16k5lIIY1oYR7bl5SXZPb9zmRX6UpAEVuxjDY+UdZS50GK7dqHWN+9BBcL95MXeezKs25XoOltq1AaTOK7QvXtu1HrunzOtj3FCnrUGVvCZOIamBPwP1ME+8cNstCSZnlb5T/IBKsH/VHmNNOO4+Kz0AE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YttRcNa0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3922723f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 05:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737553761; x=1738158561; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K51/6g4P9GYdkZ38G8mfX52Y5q+LxzCdwPw5czgkm70=;
        b=YttRcNa0noHwMbSsrzASNuHeMCWT2Fr6Sk06fBYAGoO40fm/2a349KQl5/05SB0XvX
         c+c5kVzd91QlMuIEkXC/fDcf/nxQLmTVXW/bOQEWG+SPzujVD1ncEqRl+5BCtsgp4Rjm
         nusRGYmd05ZPDkRXvYEmIv7g8HaNTuK3HweSxUmwzQtoEZM8apiVMaTTzeOaeAO7fUWD
         SWsD86+qJA25kstpusx/fuvhnE3WfaOsJHFF8S3kt5ERDDgfbMaw65gLYXEGv3dHKjRV
         lIIIQbtU+HKFF1X+TPZ+MUI3qR90CcBIOLD4xfTknP3d6Z1MH6WkfV5lRwJ91qyZF5Rx
         iutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553761; x=1738158561;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K51/6g4P9GYdkZ38G8mfX52Y5q+LxzCdwPw5czgkm70=;
        b=ltxVbU4YnkvSw9c8nQcRDpBjY9oB/O8c1iRezJaTe7hOcNeylQpM56PFSNAqhcX83t
         gQREvJKrQ9pIsbXIxwzF9OICMFscNPsgWRwuYdVXrB879QWAUSehT378neDN1tcKHjmI
         zzM1gWn3iAR4FGX8HwdIWPMZnmu80iGNNo0IbBDdjupfTKRwmgbYPCZ+60p6Y/oplzUc
         r4iATeEL3/swgW2AfxhJSw1d2q1Zkoc9j3k11KYYRgFAp82samYR/ScsiIP5L/ai6KZY
         qI9y6/tp2HTtLdkkqSc8FE40yLcEYzzIEJYo/9qk0+dJNPOjV8e7bzojc/BSnvaZex3J
         Ba7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVopYZVlN/3U1BX9Swtbf5tsnZSAiBSnwwGwOY4HejhH8vMLCq/MnkD87FJzWG75g3E8IVrgs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4LwJmH/sCnNehifji0jCflJn93a8an5keoDuxQOz0zWLVNyK
	ZUJPuhqH8j+1nJBLx6LtBUH7AT5v+dshcF5kTt2VUPbr5S15preXYMG9MNw9pdlMPFhb4Mld7by
	+
X-Gm-Gg: ASbGncsqHrtg8N7qwyRQK1+PnwbvVau9UQCY5Sfjc+wcVo/LpUHY3fsE8f+X1CsNV69
	Hx6Qrl5pp1lZxJHZpurxPdO3q0SbwRSW5WnQpDsKoWwgMhYu/NDu7eEIU6hIffe5xB0rRwYG/Iv
	mCTckhKEy+p7sHH9PE4AarkBSTCTd2pHm9IryWxwByLeeNW/eDgzDbkh+thmpAtokQjPAdG7gdm
	pxoyThdp/KjOGD7jQL2AB3M0li6dV2MCOyX+22IoRsCLVTAU2kRmPnYf2Sx6IP7PpsEe07Dx4it
	kJ6XPsf/Rw==
X-Google-Smtp-Source: AGHT+IE3o4b4BdauC6AlHv26it9Zg4i8+S7clf5AWO2pmyOuXXW5i8JwhMit4b//DvHU4sQvCrgQbw==
X-Received: by 2002:a5d:47cf:0:b0:38c:1270:f961 with SMTP id ffacd0b85a97d-38c1270fabemr8203304f8f.46.1737553760630;
        Wed, 22 Jan 2025 05:49:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214c5csm16346804f8f.8.2025.01.22.05.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:49:20 -0800 (PST)
Date: Wed, 22 Jan 2025 16:49:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: netlink: prevent potential integer overflow in
 nlmsg_new()
Message-ID: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "payload" variable is type size_t, however the nlmsg_total_size()
function will a few bytes to it and then truncate the result to type
int.  That means that if "payload" is more than UINT_MAX the alloc_skb()
function might allocate a buffer which is smaller than intended.

Cc: stable@vger.kernel.org
Fixes: bfa83a9e03cf ("[NETLINK]: Type-safe netlink messages/attributes interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/net/netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..ca7a8152e6d4 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1015,6 +1015,8 @@ static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
  */
 static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
 {
+	if (payload > INT_MAX)
+		return NULL;
 	return alloc_skb(nlmsg_total_size(payload), flags);
 }
 
-- 
2.45.2


