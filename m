Return-Path: <netdev+bounces-85206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AF4899C13
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33041C20CCD
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A216C696;
	Fri,  5 Apr 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPRoWWkm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEE33993
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317783; cv=none; b=XFndR5JcFhPJ0e9MNyC0AHjwTRuXTpWjQXx3WyVVOZw/t0Ip1gWIB3vvo5ba2KYXuHOp5h43L0tidAsmdUgtXainNTP3G1a5VjFI65BZLy85sbmuzpr9NupJJtCZic8m2RcrNyVQn5yS6caMWc6UkGsy620xbNY+H1vVVVws7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317783; c=relaxed/simple;
	bh=q4JfT2kThFRxewf9gXNVimEbkM6i5AMrnDOuFCPOgRs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KaeTyKlB5UbLTlktGNPE4C4bW7bXLTi5Ob4J7DlxYPOm0u4sKa2orxkMJ2Ia2XI/OaHOujeXmLFfU4uiVnPPcbU4fRcnq1bkNu/RBn3Xwy2NJvsjyH6cwIcUYPaUL3MDjmJ+tVLzB1E55OiwaKKa1RprKq2/+GdrkCl7swrI55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VPRoWWkm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so3057570276.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712317781; x=1712922581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iudd8hj+xYw3nWMYjIeY4VfF65OfL/XPlIxi/Dq5P44=;
        b=VPRoWWkmRUnH96ZSBn1oiZf+P7qyc+cASHKgFMUBpJds4hDpdWJD8vhiMAuV+BbzJ5
         f+wJcONozcgKFN0Tog1zxPdBoPM2fbbSEYZESfPlGQt5N36ZavA2ONHVE6nqu6VzoV7C
         ZwJ5yxEO+IMNXhxlfoP0V/llxCm4jCoiDRruGkdtyqlcJ+WzmmXbvO+YPSsIE7Sv5xiF
         kIcCgnwoYeG05dyfcvECxr0M0DxBzGH7LlKk4AIQyS3Y2yzGOCUESoMdbi0Zi1v96BEa
         o7QYspKwMyWh9rM6OnIqck+qnB7JDeB/7QNKx5f4ykYp5u0wtBW1DyiGIQymJkopyr20
         M3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317781; x=1712922581;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iudd8hj+xYw3nWMYjIeY4VfF65OfL/XPlIxi/Dq5P44=;
        b=ujXP6weeWk7Zvc5fDdrxSHkEEaE29KXoS6FymSMUYEBYx5ZmIJC/j8kY9I/vGgEcu1
         SDKjPAP+OkAzDoXsYm1W1xiB0tdfpxAJ3UdgLqGr6CoMQSvrm0AyuuVNSv8eaTuTx5p+
         CrHU9GFlCmgZLLyUHyQoNrAbm/DFE7qH6c53Hd7uDIDn5ezGGNN33s6QRQnTLyUTh/LC
         7uB+uIeFCkU0oJRg2H63eDtbVtXc1XJYMYhRwKedMCsqvNWYy51rG2y+93h+wSvXnyTd
         B+7CKgUJarOrn571qbhphCa+q2/krM4oGxcuAV/DyMfbW/vBvFPM3y6XeqLQKco9L9Ci
         TVPw==
X-Gm-Message-State: AOJu0Yw6qeUFcDmMwX3tQQ6gNQ2P9bFTjnSta6f8WY8tozGKLZh4IPrQ
	qxkXw2hcdYeXwZvAugz0Yute7uuRoQLJgyyXEULV3cMnVwJ5cCWid0LwLt4ethkUnwIW88tUqyt
	3O1+7zE6PNA==
X-Google-Smtp-Source: AGHT+IGIMEKjJNDrlYAPXT0cCpfE/osLByl5I/XPhkvyWCeeA2B+tdUhO+CcDFXTRLAS0CVh8NXR2PLP9mZMgQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100a:b0:dc6:c94e:fb85 with SMTP
 id w10-20020a056902100a00b00dc6c94efb85mr49981ybt.2.1712317780997; Fri, 05
 Apr 2024 04:49:40 -0700 (PDT)
Date: Fri,  5 Apr 2024 11:49:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405114939.188821-1-edumazet@google.com>
Subject: [PATCH net-next] af_packet: avoid a false positive warning in packet_setsockopt()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kees Cook <keescook@chromium.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Although the code is correct, the following line

	copy_from_sockptr(&req_u.req, optval, len));

triggers this warning :

memcpy: detected field-spanning write (size 28) of single field "dst" at include/linux/sockptr.h:49 (size 16)

Refactor the code to be more explicit.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/packet/af_packet.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 18f616f487eaad0f7b31fb074e194c0479f30d77..8c6d3fbb4ed87f17c2e365810106a05fe9b8ff0c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3800,28 +3800,30 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 	case PACKET_TX_RING:
 	{
 		union tpacket_req_u req_u;
-		int len;
 
+		ret = -EINVAL;
 		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
-			len = sizeof(req_u.req);
+			if (optlen < sizeof(req_u.req))
+				break;
+			ret = copy_from_sockptr(&req_u.req, optval,
+						sizeof(req_u.req)) ?
+						-EINVAL : 0;
 			break;
 		case TPACKET_V3:
 		default:
-			len = sizeof(req_u.req3);
+			if (optlen < sizeof(req_u.req3))
+				break;
+			ret = copy_from_sockptr(&req_u.req3, optval,
+						sizeof(req_u.req3)) ?
+						-EINVAL : 0;
 			break;
 		}
-		if (optlen < len) {
-			ret = -EINVAL;
-		} else {
-			if (copy_from_sockptr(&req_u.req, optval, len))
-				ret = -EFAULT;
-			else
-				ret = packet_set_ring(sk, &req_u, 0,
-						    optname == PACKET_TX_RING);
-		}
+		if (!ret)
+			ret = packet_set_ring(sk, &req_u, 0,
+					      optname == PACKET_TX_RING);
 		release_sock(sk);
 		return ret;
 	}
-- 
2.44.0.478.gd926399ef9-goog


