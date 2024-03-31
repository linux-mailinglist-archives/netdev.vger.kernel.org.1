Return-Path: <netdev+bounces-83570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF4893105
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CE01F21B52
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CF2AD32;
	Sun, 31 Mar 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKkf22qL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF221C0DE5
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711875932; cv=none; b=GDhHN3nG0FkJgI6y9tXlRu27sho7aNbzAHqupl053nkeTb8QRWLHUvqc2nDfN53kmbWXRZ1WAysRS7taYilklhCoPuGOv0WCOQ5nJOfU/MmoE1CFfPo5baFsrsVOJWpspEajucoZS5jRsgvHKG5A7XDLdzQ/hhmBLSkl6vTo1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711875932; c=relaxed/simple;
	bh=T3TbQ221nO1Il/6EQXBBuyWZkfJXamANSLShzFjxjWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdfWMF55XziBhD+DNMysSDlVyUCAz5KKOUUk7sR8+jG1KH7BFclbr/Hkd/nGNKGpjai2SBgDsSrn5oU/KBd4A7ucQm3cRgJ729FXtmdoFs9WHHX2izACU7bqWyURayAXk21nZGc6q13ZusrA7ieRtA/+4GFZJbHzbfzXJP6nA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKkf22qL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a4b35ff84eso2034384eaf.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711875930; x=1712480730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky119Wmn9lN3itBVAspC/BbZzZjapLFOG2bFm8WtvRY=;
        b=JKkf22qLc7bL34IrBvR7/FSZC3Ds6Kt8UzyqtExXUJsPHYXmGrY9R+vge8j+s23979
         XMc1Vd084a1R3GXiMWpKYr+8bXNaOKA6sQpsPyXhOH8sZ01XgD3bM5tTDongEqe/vjMc
         B8+lH4p3a5gRlyoX1zeJmh+h7qaYGOutERR3yXEtWMiOj1z+uxrk+5foMzbodHtPSAuR
         BuW63xaz3kqlbe+Q0NNITSOvShWClbFRfcUck7vrulMHE3Qa3CXloYk5bXFuqgTsdGWs
         JUymIbQJYcpRb445A58u2pwIZ5KKQXL1v3nB+mDIRmm0hbtcvPJ9Qg1sQBp52PBjx0Zp
         mYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711875930; x=1712480730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky119Wmn9lN3itBVAspC/BbZzZjapLFOG2bFm8WtvRY=;
        b=OYM02JA5QIrLohjsYuYvoUS0cAFmAuneRZTC2WF2CfJcKLOAOmtMLnb/kMGwHack4k
         TPitosh/VAMXSSR4QKDn73A/selJTRQNQlfkbKmp72f9dpsRy/dMNddyEh1mQUZwdfIm
         gHqsak+Q/SwLu9EGkFTZvyCJoge/vMCZyGSuXNmJQw+6EH4uotZGysvk6k7GBtBVFNX6
         C/oQKpT52wsKdJRkgZMVCEjCKFTzmFMpUPGvrS63wgJeLv9jD6h5XnoE8EOlBDdot/qI
         CsQLHpa9ea0K0VFvuVAm6zpfqg4O7+eWxQZyO8ZvStwqCLzUC0d6VARQ7GzJFvmiE3pS
         s2AQ==
X-Gm-Message-State: AOJu0YxEy35JhiDHQKvk1MIhdY+zOx5jTzhq4PiKTY50sBhoi5IWYqkN
	/rrXx6PN4v/N+joQqKxCmuFDQh9rQbMOM+7GLFBUKTGDX6t/ddET
X-Google-Smtp-Source: AGHT+IGWJlzjzT5DVCzi9/z73tCArAcJ7nYGcahi/w09HQ/aa5Kl9BT1U3gr+kB4vbHocoeCPjsw4w==
X-Received: by 2002:a05:6358:70cc:b0:17e:8b66:a983 with SMTP id h12-20020a05635870cc00b0017e8b66a983mr7934504rwh.21.1711875929568;
        Sun, 31 Mar 2024 02:05:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([60.209.131.72])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a00214300b006e6288ef4besm5695333pfk.54.2024.03.31.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 02:05:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
Date: Sun, 31 Mar 2024 17:05:21 +0800
Message-Id: <20240331090521.71965-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since commit 099ecf59f05b ("net: annotate lockless accesses to
sk->sk_max_ack_backlog") decided to handle the sk_max_ack_backlog
locklessly, there is one more function mostly called in TCP/DCCP
cases. So this patch completes it:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/inet_connection_sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ccf171f7eb60..d94f787fdf40 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -284,7 +284,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
+	return inet_csk_reqsk_queue_len(sk) >= READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
-- 
2.37.3


