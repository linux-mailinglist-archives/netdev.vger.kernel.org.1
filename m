Return-Path: <netdev+bounces-149399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F09E5743
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7428C188582D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F832219A9A;
	Thu,  5 Dec 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcF7QlVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D8219A9B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405515; cv=none; b=ZZA9mZiNjcYOCcdyXjg19OSvmkqkaxjG0t4xdfB11vcsBAO8+wbGLv3X3QMuOfdW4L8AgvYQumgc/C1wJSc/Q6HGtl2XVLOTXclMYEBcLm9NtrFIZ5Rw0CpxNGooXlnd/3wzUIFLkyZ9YzEU1PxIUHm0OShIi0C+hzoNu5VGQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405515; c=relaxed/simple;
	bh=QPh03QEa0M8YEQs8GzmP3qJH+OhK905FKbbXXrN+B+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJuzR6VrQWwdwDGReOROgqRgnp3UFx7r2hDBqT6mIkB8vvTQN5RDgPpbljHApDloq1uWRwoMW/2i5IkixiCw01S7vPkczMvmPzxjsRy3dD6AvaB4nLhCxW6WrhXzh+Uu0+NF/oAXSRKwWZP+zrHNKKWBRNjQSt2zNao4LzuRKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcF7QlVJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a90fed23so6374945e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405512; x=1734010312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=bcF7QlVJKn/n5c7aIn28/mWuEZcJEKaz5EGoxfv0t1WSmLREu7U50MuqRTBFrmgeW0
         i5WAUeyWU/0ARAZNsJBzd3v+kU6/XRq323yFrZ9/F558Vrc1YnVTk/LmZg0PnRDGZvPV
         TgFbUMXFQc6+Gl6i4KGs8Cczw7MIbSMGz1A4ueAbAVdfiNu30QylK7Ha27ak1jRml3p+
         weJD7c72mCU/aSJEqTfgzW+LySaKZZJasGGxrYyp07xCfuNoDEp7Ga2gArzaVTpW7BT9
         BuAsym/1Dkb/k41pYmL2je9oBthniZg7mhtOK56T45AwSr0lRciW/kanHhDngwJRz9PL
         iHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405512; x=1734010312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=oqP/plsuwPjrjxr71KnU/8/NFUGBFB/6e4v+RalK7k5qgC8QEnq8ITmrdpkObqZvgV
         yS3DHYKJKs4W7kS/uWrzOfTP9MNW/O8QHRoLxxQB2DZ9EGAPr7EIQky3Dg05jCKKfWm6
         jn7eX3lMEvQnpxFFOTqUnihYFs2SO9yaI3LAvXh3/WT4I+/zRNIRetXrwDDIoDr0hL1O
         MFEH9Oz8hwesyPrqWEXAWm5Fk5YaTJF0Y9D5x8YEgpqd5JUW59mUaQaL0uEHyo6+eleh
         Ja2AYUTu1woVZVSq2dVbS6MmAPNSjGhzKl6yoq09aeH2bANzM4PznFcGt4UZlyO4IJ3x
         pC/w==
X-Gm-Message-State: AOJu0Yyj1pdrU9vOPoXqIZ1I5+cREjiyzTWkWsyk8/qa7bjA+w1DctGs
	dQXG6VYEwReOtO03tUtnVVjUEpUWOyW7xLk3eS/dEqlh8g3I5ApLPnY8jjCP+dA=
X-Gm-Gg: ASbGnctbdCaoCs5rQvs1rC7AU9Qy3F4fe7XuQIqAv71fx628IQTkh36Yde/ah11o0XX
	mXqhKxcjH/wLNiS/2RaHK2/cJzZmsjIe8oMrEiODXPrC5BjdZlg6K7js6romum4lIr6s35QDjyI
	7dwuB2lslKhdQKghhW/LbA3qXT8dm2xAqiIk32mIXsYyO2sEHHt3c8rdBAqMMRGIo3y3asRv/yl
	XMtQ4KUnIZb2iQFiWd+3YRkmR1gzQen9Iz7xbe1eF5y6PIGUQTigeJY8pO26BfMiwM9gylkfTfA
	DblniTmlFURZXNVgX8qvAOJuXeOfKtrdWlvkzdT/TicadfXaVXH8WIxnfA==
X-Google-Smtp-Source: AGHT+IG5Jk0INyqZQFDQugeufm7NCoe53R7jn43ojJGy2F4Iz17G1eLBOqFmunl/U6+CfIr8OJvIjA==
X-Received: by 2002:a05:600c:1f8f:b0:434:a396:9474 with SMTP id 5b1f17b1804b1-434d09cbe39mr92641505e9.18.1733405511777;
        Thu, 05 Dec 2024 05:31:51 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C700ABF575982C3B3E76.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:abf5:7598:2c3b:3e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm60852465e9.24.2024.12.05.05.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:31:51 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v5 1/4] sock: Introduce sk_set_prio_allowed helper function
Date: Thu,  5 Dec 2024 14:31:09 +0100
Message-ID: <20241205133112.17903-2-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205133112.17903-1-annaemesenyiri@gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify priority setting permissions with the 'sk_set_prio_allowed'
function, centralizing the validation logic. This change is made in
anticipation of a second caller in a following patch.
No functional changes.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 net/core/sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..9016f984d44e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -454,6 +454,13 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	return 0;
 }
 
+static bool sk_set_prio_allowed(const struct sock *sk, int val)
+{
+	return ((val >= TC_PRIO_BESTEFFORT && val <= TC_PRIO_INTERACTIVE) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN));
+}
+
 static bool sock_needs_netstamp(const struct sock *sk)
 {
 	switch (sk->sk_family) {
@@ -1193,9 +1200,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	/* handle options which do not require locking the socket. */
 	switch (optname) {
 	case SO_PRIORITY:
-		if ((val >= 0 && val <= 6) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (sk_set_prio_allowed(sk, val)) {
 			sock_set_priority(sk, val);
 			return 0;
 		}
-- 
2.43.0


