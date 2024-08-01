Return-Path: <netdev+bounces-115028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D08944E91
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3D428386C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE61A99D8;
	Thu,  1 Aug 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV5SugVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EC1A99CA
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524107; cv=none; b=inM6OO04cqxossSaiK/gLEW+Rvnb5/6wihS3dFnCcq9m4Msucm7QZlHlXoiclZWSbLoCaDQDmV2SJknh1Tm793KK3HAc5LXqn5AEnPHeH7A9+vKuDj9QppCvFBCYf/y7QVOvpdkaQ1SZMRBOmzWxY3od9m5aYbzqDKUBT1TQafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524107; c=relaxed/simple;
	bh=iQsBHPMzej199XDiMCLFw43+eqvJaB7M6OST/YxggWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u2wIWbn97OCk1Pf/XttsOeisCijkGVA2YxBF9Ms4JvPGZalP9+cMXGbUsfsVTpwihDwKxTWLJjvyDUS/cleHhXrP0ZRtUwNyRoNMcLTWaacIicR6VEVBUNYg1AYv69/6rVMW1DR3izqwTnBPBoNwxr1H8wIHpAfwbSn9ctk9y50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV5SugVD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d162eef54so5034055b3a.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524105; x=1723128905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seZowJq8ofBZm4njTpyFIqdU4PxpR5t/1YZH579mLPs=;
        b=YV5SugVD803ckbfuJ8J5dLRjfkJNhh1BB7rAlU9vEfjgrpFxaFNUKAFuXk5E0LcBi/
         NGv52uT4ZgOXqmXU5LknRBwDPMIQQc5CbSUEr3gkPuicMD9LvJdriMgB7MLpTv9t+F7N
         1iXokPzYbKHq9mNgUlkz56OdxNioXQoSj+uXDyKm0EVFCtJoSjEq7sKk3+wyreu7KhzM
         Wm8iCKSufT1ORIBaojo96XzR+BYsVMigHiK8EsqZx4L1eOa8HO2sbsEYQ42PnE86zkQ3
         EfWrZa9Os/6fcxytMZlnPgqcbPtZE0lwvjTQbps79AKW0PBD6L+kmxo0qpt4tjzcYc1u
         QxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524105; x=1723128905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seZowJq8ofBZm4njTpyFIqdU4PxpR5t/1YZH579mLPs=;
        b=XM/kgs0wcQgHMQqEPUrC2yjuvK8gqEOtj1ajeJcG/Xsk3Yz4k5Nun+DGteQKGzcImi
         CtZMDl7d0imgR7CofY6AXzUoYCcPfPmQsQ4gAB5ZW4YGNagCTFKs2vaRhVRN4mIZPxBi
         TgNxjU7jaFB8DKtX/0e+6AuFTQKkMYebkdouLdTUbO3SzSw1w46CCdFxXWqt8J8YtC0c
         0PfOFVNysAFxNOTL2B+Gw88NV/6bdyrgFeDnzmHg8EYteCEk8h4025UWWJJVPXuYT+Xf
         z2xmuQ8oL4A/x9khQoraJv/r85J0YVatFllJNEC7mx4L3iIZCjnA6gHZiwS5232Sy69A
         biVg==
X-Gm-Message-State: AOJu0YyHl+bH8ULXcncO18OHmFMF6J8xqowT7boiUPrj3nROOLIhXEtY
	O7tIrVSNDCmWwoLPdXh8lbFcKpeilznq55BLBsv6tmqW/X3KFnAo
X-Google-Smtp-Source: AGHT+IFGND89cl8kNZyHN67YgyFDE/praYii3Hg5newbqz6TBtczxfMSl9t2BYCiA9OkdupqPSdU/A==
X-Received: by 2002:a05:6a21:4a4c:b0:1bd:253e:28e with SMTP id adf61e73a8af0-1c699559f00mr539656637.16.1722524104928;
        Thu, 01 Aug 2024 07:55:04 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:55:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 5/7] tcp: rstreason: introduce SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for active reset
Date: Thu,  1 Aug 2024 22:54:42 +0800
Message-Id: <20240801145444.22988-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240801145444.22988-1-kerneljasonxing@gmail.com>
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When we find keepalive timeout here, we should send an RST to the
other side.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20240731120955.23542-6-kerneljasonxing@gmail.com/
1. chose a better reason name (Eric)

v2
Link: https://lore.kernel.org/all/CAL+tcoB-12pUS0adK8M_=C97aXewYYmDA6rJKLXvAXEHvEsWjA@mail.gmail.com/
1. correct the comment and changelog
---
 include/net/rstreason.h | 7 +++++++
 net/ipv4/tcp_timer.c    | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index bbf20d0bbde7..9c0c46df0e73 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -21,6 +21,7 @@
 	FN(TCP_ABORT_ON_LINGER)		\
 	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(TCP_STATE)			\
+	FN(TCP_KEEPALIVE_TIMEOUT)	\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -108,6 +109,12 @@ enum sk_rst_reason {
 	 * Please see RFC 9293 for all possible reset conditions
 	 */
 	SK_RST_REASON_TCP_STATE,
+	/**
+	 * @SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT: time to timeout
+	 * When we have already run out of all the chances, which means
+	 * keepalive timeout, we have to reset the connection
+	 */
+	SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3910f6d8614e..86169127e4d1 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -807,7 +807,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT);
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.37.3


