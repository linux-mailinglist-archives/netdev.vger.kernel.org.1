Return-Path: <netdev+bounces-78701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815B87633F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8421EB22C73
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4F56468;
	Fri,  8 Mar 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZIB/137"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2A5646D
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897116; cv=none; b=gg0tAMty0GfaztCvKGocxlBWlLf7cgxYD+2jphxCGog9MwWjwXAe8ktuEm91zeaviMZBgzF59NcoNFP7gYrXceF86/MQBBnUVN9CdlfRtChdldNFYwM+2VI+D+fCw3B1IJvNZUOiVGTlMr+uif01AXan/tKwC6lHKkuRs2CiezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897116; c=relaxed/simple;
	bh=XZ60jz/4L+dtCcaLrNLOEHxEb91G13YdPFdP6fZhVDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRyC6UjqdS+fQ5J088w5pd+mMGLw1Ft8Qd6s3uQ5s/MIOtuOY1l2f+B5Hv43O1ZfWOvXq7UHVzBQe0Vh3eju01of2MRvivgVC87I5RFhehBhnowEp1mm79xTpNKoTqZiVZAj7DV1mgkMxS2wh8ZMx3JKl9kDeNXak8KIUHakXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZIB/137; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd611d5645so9436305ad.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897114; x=1710501914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOV6rkeK+dAF2umQi90xQLCfmYrig/9c5Ifw/L4zFXA=;
        b=LZIB/137cfGnfLO2X6iOCNEP8hJtPpQAxxgv+OE6k1j5ioeKRcMh+H09aZQgx6wwdl
         Aw8g5yk9Yrg/tHdEf5cR5d5qz2Yev4+Qho9QRSGvGkLdVXD0UdpO4jnIXQYpWVRLgvK5
         NblYj1r0uLANassqNMqfbNfyyKUxI7ZAARPcWO0gRK9PmE61Ti9oGXKD98dg0HW7+PNF
         9Ket7ndywA/vvPocf/j0IgvxVtN96ZGEYubQZO42fxeQRsiWba3lloa1LEEqwqiy5VoT
         RWeR6phHusLZUED9OokbFCE7AGtrJg/d+UeUOwT6GpU/9cE+GCrv5TE0upMtW+Ra1piK
         GCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897114; x=1710501914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOV6rkeK+dAF2umQi90xQLCfmYrig/9c5Ifw/L4zFXA=;
        b=dhK8PsS807sQnoQGdAt8z+nJX8Lr29etgqG5bgcczcEaBTqJ7398Neqsx9HBpzdFpj
         a2x1U0ssOnOr4y0OPogZ16CBtFnn2Q7OBtAlA/b1hQhZ0VliA+HSs665aJGZLN1k5aUf
         VSBWrvd6VHdR/qAse5QQ/72rZzLoC60KXanh0DBDjz9AoJqSbt3m65IHfVaSfwhIGoRC
         3QedJkeX94R5gXA0LkgnlJOiz9DgheMIVO8wakvo/gTeoZ0tBzAoJMqF0r+C+4V3+mBZ
         ZKAPMvww6Edzf+mog1ejStsV4vE3KQnqB5p7oyVYv387a5vfabC+VRnW497cePDwILhn
         5KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE+a9W8LP+v2R8isLimvUF+CHlDOebteLeD61qMr/0GPQctU4oP2iYo80qQjdvFp3/FWrCNaBeceDHi8HcVHVA92hlxcUL
X-Gm-Message-State: AOJu0YxIL5YXuTBsppMyZcxqlOWbpQY36DOFFjUiEJkvV23zLVcf7ah8
	qTjM7SjBndz40BPlvERyp1C3OR4uE+gmsZzaSRkp8JTexpjW58Oc
X-Google-Smtp-Source: AGHT+IG7sno4VUVtN1IfNefGmWd6UIeSez2uZObIv68bmv/gFoj2UfKeoZdWMoXWurBSXW4afI7lvw==
X-Received: by 2002:a17:902:fa90:b0:1dc:c161:bce6 with SMTP id lc16-20020a170902fa9000b001dcc161bce6mr4888621plb.15.1709897114213;
        Fri, 08 Mar 2024 03:25:14 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm16049806plh.23.2024.03.08.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:13 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] mptcp: annotate a data-race around sysctl_tcp_wmem[0]
Date: Fri,  8 Mar 2024 19:25:03 +0800
Message-Id: <20240308112504.29099-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240308112504.29099-1-kerneljasonxing@gmail.com>
References: <20240308112504.29099-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's possible that writer and the reader can manipulate the same
sysctl knob concurrently. Using READ_ONCE() to prevent reading
an old value.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f16edef6026a..a10ebf3ee10a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -850,7 +850,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
 	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
 		return;
 
-	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
+	new_sndbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]);
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
 
-- 
2.37.3


