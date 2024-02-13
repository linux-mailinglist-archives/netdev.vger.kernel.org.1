Return-Path: <netdev+bounces-71382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F3853224
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371811F22F42
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939BA5647B;
	Tue, 13 Feb 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KblNF2r3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E175646C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831766; cv=none; b=X/dUIJRDDxjbgg0jMe4UXHb6Z7v5XxG4Iwlk+e0UD4WfpNtv5YjCNSeJFxbxkUHX5xnb/w91dbuG17Du6uk1WMvtVK4SkRA5ycusUM7hAkblmR8L88tnqEqVURau+3+sgZUQwS9OhUBJRroR9VQx95m0bWayEim/cK37wBiwPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831766; c=relaxed/simple;
	bh=yw9I8eGn8fij3hXGVhqq+QyJ/i6Xtww0dNZKPdMaFzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5iU4pZ2CgdeD/3jWlkJoblXqDpg7Cj6mfvT0aJlDnDfRUe69slZBG/HgpL4A31iRnLal1DP55UVcoOq17bOF9v7hZa2TlPLsH0oi3isXxoCjOBVgcB+JfHXIAH5143TXd64DHDjdDLmg9XvFQJY2+ieKLcN+KD2bAdZVjBCcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KblNF2r3; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59d84559ffdso315eaf.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831764; x=1708436564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCokI4QitffRE95xC4BZDly8mc3aT2cSBYL5RktaTi8=;
        b=KblNF2r3TVfjs7sHtnhe7h0mRhAPM05DrbkejkDQ5DSfdbI3lA7L9/q++OI1uxJDzz
         aVZHiUd2T3TgCQwpHA+D4qFaqE6O6wMr9+FDM5p9NmPThgIsILJd15RuuGzUQLl2+ply
         W4ckE4JeBREwiKFTlp05MzAv4/E+so95dnnPspKYg/uuHyROocAZHEKXz3Szc2xGwAOt
         J3/oOHPnGJsVpwFBbEgwLZxN9AGiIefc+krbU0IYXrLwDLVbeRFfov698hkUkskHAQTr
         GTcgcilqCGzTOu3B6sFoWEG5NHjq8JxVvn005+mUqjkvqLwVLl+KwnYZsluURTZG2pFe
         bwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831764; x=1708436564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCokI4QitffRE95xC4BZDly8mc3aT2cSBYL5RktaTi8=;
        b=eMjfXe6kuOIT3Mg6MVyOvTSvuKzTndZJBJrlaS9Xxw8VXrae9xgUN7DiiRcDDCJdtC
         41mswV2Eq1InEL2PPkEONweRkcuzSVmjcX27UWIES3XXDWlwZUSlY4x4JQC+UAIXfrvx
         +fc73VYQb18ZOLN1V4c/7JrTAERI9dPr2zHMKjQuxxowxG2kwwn1dkW3jKm21I0VYabX
         YlOW8ZVvXOkiC72Q7EzE1zETdLa007Z6beGnXz/A60e8Psfdz7o+QziY6qaTVjG5Woy/
         srh0wpF9NCQD1fzDNeEpAsbUPZLqErp/OeSMD0ERenkYNbnjJFSBJX51VxRFbFdE7VHO
         QR4g==
X-Gm-Message-State: AOJu0YxnI1SGelJdT9UKT8IwwGh/vBqPjRyMgGGi6vGkb01oDoBr1dC3
	Rs4CFtkjYR/QBual4sDQ2fy6qJZ+WMtct2CUOdzuXi1IhxsUcAjM
X-Google-Smtp-Source: AGHT+IE2IjzwVX6uCT+J9St0CuIB8KnSOoCVQcbaIR8sHteR+p8NG2GRmcByYLMA3kNGpKkAZpweZg==
X-Received: by 2002:a05:6358:5985:b0:178:76f8:e626 with SMTP id c5-20020a056358598500b0017876f8e626mr14081051rwf.6.1707831764060;
        Tue, 13 Feb 2024 05:42:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeZAt72NtoejavccIFHQJXO/Dd7snq2VWvmYhxCLTkdiMTVJLj5XK6o1/RpS4w8AI04g9AfMt41xS5oVdn/SbJjva7doZcbqiLqvMxl5ZBGakPwhaPicD4jfC1XN6B3dksggl3qB6ZVzKRBRs9Rpun+GBiO20ui3aiH8YS4JfVOe40h+6Bo31oQXZYeq/n/XvAnh+Nd82iNRCKKxzgh5mFkJ+T+dXnFKVsxSh+1K/x/S9fA/infTc9OHSrk4IBKeaT
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e042e15589sm7323041pfb.133.2024.02.13.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:43 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 3/5] tcp: use drop reasons in cookie check for ipv4
Date: Tue, 13 Feb 2024 21:42:03 +0800
Message-Id: <20240213134205.8705-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213134205.8705-1-kerneljasonxing@gmail.com>
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to use the prepared definitions to refine this part.
Four reasons used might enough for now, I think.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/syncookies.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 38f331da6677..07e201cc3d6a 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		if (IS_ERR(req))
 			goto out;
 	}
-	if (!req)
+	if (!req) {
+		SKB_DR_SET(reason, NO_REQSK_ALLOC);
 		goto out_drop;
+	}
 
 	ireq = inet_rsk(req);
 
@@ -434,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req))
+	if (security_inet_conn_request(sk, skb, req)) {
+		SKB_DR_SET(reason, SECURITY_HOOK);
 		goto out_free;
+	}
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
@@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		SKB_DR_SET(reason, IP_ROUTEOUTPUTKEY);
 		goto out_free;
+	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
-	if (ret)
+	if (ret) {
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-	else
+	} else {
+		SKB_DR_SET(reason, COOKIE_NOCHILD);
 		goto out_drop;
+	}
 out:
 	return ret;
 out_free:
-- 
2.37.3


