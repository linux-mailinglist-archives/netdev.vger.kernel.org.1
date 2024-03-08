Return-Path: <netdev+bounces-78702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 195ED876341
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AF0B22B44
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80EC5674B;
	Fri,  8 Mar 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS/hzBYo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144156743
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897119; cv=none; b=h4uk+hUoCpfHgTWGz6PTbak6XVn6qyuJIqFA007pHPoD2gCkldj//H44mR+JjF9x4uPBL81sZv7DYMpxIhgWNs/r08r05wLyoSfP/Ny/5eD97IeVfXrwH7Ltf/QaV6vsLJEdXM5C0xt1/3psdywET02nwOT8T+FIfIJ7xL80wKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897119; c=relaxed/simple;
	bh=Luvsy+WOnkG5qwVTfDfExXvIyB7rY3PNoN5HeFz1GrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCq+OpDJ1UM17rr7aItJtNeVCkOsENX8hM7JS480VE0zv3HFh4hhkl8G9J4Th+rGjH1/uLPxhGWrWxy4LaMVYt0Uu3BzNmHxbJfnqX0lpSY4yUQMGo1w279xIXMLkWHwh46POdaAkx9envVBGN76a6CwuFDtYuTt5SZ+rUEa7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS/hzBYo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcc7f4717fso5900435ad.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897117; x=1710501917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXvQs0Wk+UfdeZ/dr1xV6h7P5P/4xSbgdWXCtbE0DXA=;
        b=HS/hzBYohxRfL4pMdHmDEytz1kvnpeIY8a1b3ageZoSOhMxaRM9XhRtpdYoXyaUeh2
         ueq6CDlEelm7ZBzMaiMEKjvHI7qOSDOnLe2F7o6c26E3NJlrqVqBKZfiBN0kk07AYxsL
         Pfw0cpzKTvzhiYlh6Szyv+wcAJkbQMfsW3/CIn8oXWlATBz10aPTTdw1zbWLNKskGbCS
         u7kLY+x6E5YpTpHA+w28+vLRjuu6zT4l17St/Myk6rzDbDJNtZ234+hSBzvQyRcIZmqF
         +Dr4WG5dHcwo3+/RUVOUUzRuIMd+73vRJTm2O4JF0d+XdkY9o8iTJTLt4rGkO96Z8vU4
         tq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897117; x=1710501917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXvQs0Wk+UfdeZ/dr1xV6h7P5P/4xSbgdWXCtbE0DXA=;
        b=qZLuiA6Z4CUQqgF4EfrTj8b3u9ORg1EJ2mSvsJIDQnYENfWSiR+Tnp+Sw6eSwt39M/
         A4j9BgIgXXxVRUwfseY0bo0lFn0zJEio+FJaAH4J139jDaKaQ3AU3kn9gXJ+ouI8O5QK
         IsWayZdfAsqlTlBiUZ273+UTzmRUfBufhTV+/6kTOLa0h3q7e+Xy8sOyMoyygKyjezK4
         gYebI5XM+Npn/eivmrlS3T4Ed2hpvw0La3WZ8MJrz0XQMADUrlbUmCMqnSVqO1QNP69D
         mN86fO9tekNHg7Fk4MTBIUU5fHyBL2CxKF24eLdfb960SofvfZVoo7GzQ6vn3+wnTUna
         1sSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuWbRYS/ItTR0DVXuAjWTWW6LeOvNs5Ed2A+9a3zd1DaPU3IFxmTvcnCr/SGJ0p9ld4NlNVlWcM6wNOizHb9NgWpDSS2aL
X-Gm-Message-State: AOJu0YzsTAExhLQWsEGvZMsHaHHwNirAnUJqMYCFYBeiK7QohQo4Xofb
	lSBQT+cAvYwThGCORVEGSoPmAt/p5GvZCmU3Fm3aecvqLDyeKjOX
X-Google-Smtp-Source: AGHT+IFFQ/0l4f/zaDEvYCTncyZ1WnhaATXM7WfOwj8dMyzIDUDLSi8bXOQb1X+6McLld5Oh6BOAEA==
X-Received: by 2002:a17:902:ce09:b0:1dd:6e47:862e with SMTP id k9-20020a170902ce0900b001dd6e47862emr614753plg.63.1709897117518;
        Fri, 08 Mar 2024 03:25:17 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm16049806plh.23.2024.03.08.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:17 -0800 (PST)
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
Subject: [PATCH net-next 2/2] tcp: annotate a data-race around sysctl_tcp_wmem[0]
Date: Fri,  8 Mar 2024 19:25:04 +0800
Message-Id: <20240308112504.29099-3-kerneljasonxing@gmail.com>
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

When reading wmem[0], it could be changed concurrently without
READ_ONCE() protection. So add one annotation here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c5b83875411a..e3904c006e63 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -975,7 +975,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
 	 * Use whatever is left in sk->sk_forward_alloc and tcp_wmem[0]
 	 * to guarantee some progress.
 	 */
-	left = sock_net(sk)->ipv4.sysctl_tcp_wmem[0] - sk->sk_wmem_queued;
+	left = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->sk_wmem_queued;
 	if (left > 0)
 		sk_forced_mem_schedule(sk, min(left, copy));
 	return min(copy, sk->sk_forward_alloc);
-- 
2.37.3


