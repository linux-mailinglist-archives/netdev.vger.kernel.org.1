Return-Path: <netdev+bounces-220923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F60B4978D
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CFE441D99
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF5310655;
	Mon,  8 Sep 2025 17:50:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26313C8E8;
	Mon,  8 Sep 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353848; cv=none; b=Q+M+5mlEgni6l6VPs5+G8YUrKZMAU+FmazOwYPRF1q7dGyxtV5Yk18R3LIPmQgADbJRMooRNzNMdQL4Vb0F6am93hXac7TshIj1KCtUL3YCNj3GjnRsqKd8wA7h3mVH32eR7cQ1ABwY/QYGGIX7fIoUS8iU7BS6iySw5DWJzPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353848; c=relaxed/simple;
	bh=5YY088FLsTyhrftmqQfk5sbO8FI4XvIM5JKW8bZMtq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzI/FwhJbirm0asXnaMzBatEvZ7EpKn776+0yfQvtrEs39eFVFUhxtgMM4Rc8Bs0Iof02RYRoX69h3MReuM0nr/ADv6HomycKnnTJaMpI28VLq9JjrCNR/tU2UdK41DxHx8QuUT+had8AW7nMYzc6dfg7TIsb7xoAoYF39LK1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772301f8ae2so3829365b3a.0;
        Mon, 08 Sep 2025 10:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353846; x=1757958646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3YSAFfQ0v2sBBmNLG7Qti585x+a4A5KEbS76irY4Js=;
        b=tWlLTcKM97E6UkmIdqM/bLMudF1IG45YCogDgQm18h+m++oUd7/wfPNVmrqYocW+eA
         9xsXJb2Ak6Hjqs9HItFSEB60bNBTTf96jDh47MPE2gFD7+43tj7EOSlzp3/F141+SCZo
         3A61DctViGtPnSIQiMJVM+RGjnO6BGnTDVO6yd5EFfHZFpprnOk9srKp9o6p69LzYH8A
         Mh5vH0uncW/sFUoBge635uySrvGbibhdAA05sus+y7YWfCwU97FuaLlaDdJcbKBOBeJq
         p7RD8hqiDtDRWcahDeELiKiD5abLVkbojjsfkmQ4bXt57JaJlvZ4k0pl/+GVaRSeDYjW
         Yp5w==
X-Forwarded-Encrypted: i=1; AJvYcCWehKh9yj/paA7Yy4MjlC1CZkWJnfnLaS7zAnBfPAOlLhoW2J67vmawlLP2BxjcNhwYW6GxbsbgeCkq75g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48T5v0nMhbZnK6WKzAr1qwInXGO60S/ptnoOdEfaUriNXbuWw
	M0NEa+HGtCMCBxUP/DmjZCLIJDhDFGYS0ziMr6ZfL+4z+4EOLN9O4FS39PIc
X-Gm-Gg: ASbGncvFrFLaeoHk23bJoxkW+H00+HfmpEXXCmabEm1X4nPAgB9IykhcGgAYz2yq3fZ
	0GLZe2VOIbRUHwC/ri2p9wuFQDlDV5WoNeSRZ8eEVnK3XIRqoHktZM7npHYPpQh+2blFYdVSWYe
	XJJq94V82KzgEqyQFFdiMiOg/VZyB/ZZRX4EMu5gt9IVArZBuqVwYpvayPzioUCw4+onw8QH08+
	3+UUWbmq+zlv2ltcALPy9Tz9swH5VXExrDNeOzoeUp+HJ2w5vENY00Kgosq8ttAHcao6Mtb4eqV
	T8hPtfmSsWAjid3bVIg0d/r+tOLbTdfutGHIi965MU7FHvvkaf8a+HJGtnWPeUTi0LD8OgJqo8O
	PrIWtNw3BGQ0fY1fOafgBTDuPgbfaEaPeQoe5dTZMZwtxqP8SJkatTSZZ5DTZoS5ffRjdo+jmUC
	5eGHFe9SyvKFAPXUBWWQ+1fe6eBZcu8vG553JyMRcnEl7Vx/o55VfKQcFR6vTqtEs+ZQNkxvz6t
	K/F
X-Google-Smtp-Source: AGHT+IGcxfNb22s3jr7+1Cy+2Q+z7L23H4uk3O3sxYxG7gKcFstVC/6fh4ReASuZxujTamDx3bUf7A==
X-Received: by 2002:a05:6a20:7f8a:b0:250:300f:2f32 with SMTP id adf61e73a8af0-2534547a71cmr12155131637.45.1757353846344;
        Mon, 08 Sep 2025 10:50:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4d96829a66sm25333596a12.6.2025.09.08.10.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:50:45 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
Date: Mon,  8 Sep 2025 10:50:45 -0700
Message-ID: <20250908175045.3422388-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_recvmsg_dmabuf can export the following errors:
- EFAULT when linear copy fails
- ETOOSMALL when cmsg put fails
- ENODEV if one of the frags is readable
- ENOMEM on xarray failures

But they are all ignored and replaced by EFAULT in the caller
(tcp_recvmsg_locked). Expose real error to the userspace to
add more transparency on what specifically fails.

In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
copied=-EFAULT` is ok because skb_copy_datagram_msg can return only EFAULT.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 588932c3cf1d..c56d53e32c29 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2820,7 +2820,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 							 used);
 				if (err <= 0) {
 					if (!copied)
-						copied = -EFAULT;
+						copied = err;
 
 					break;
 				}
-- 
2.51.0


