Return-Path: <netdev+bounces-73620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1385D63E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39DE1F24324
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F23FE54;
	Wed, 21 Feb 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zK4qTV+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD83FE2B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513168; cv=none; b=lU34G6lHCOC1yD5nU/BQ80kdJt/1KaQ7sQ6GJez3XgjWvthnRbUTvm7ZpxvRlq66wyDHojn6aLtDwE0Tf3IAe4j/DT9tbkb+ukKY8E5x36n5j9S2B1up1WBAEphDXJZ6wMbKRbBI/GjiO64irc+7SO05n3Y8BoSGTD9Jp3I25Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513168; c=relaxed/simple;
	bh=50FSsLCtdQT36IUbIb7fJa7pTpPKrsCIdh9e2uFhczU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOOWnvZT8+0nAMdDSBkUO7tRYu02luIUoCWbyfm/nTxXJjmb5oAV2jSI8RzMogfiOD1ioy1iPJznKknhD7bzaOHrCDpzD6vJWC5TKkvezXB46XqxBGLFakiZrxbvnCuVHknb0U5uGJPrfU3s0jnof4ZviDZek3K0QXK4IKPmSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zK4qTV+8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so8265180276.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513166; x=1709117966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlnokSDHjEfyEFlKuGf7qGXhR75G4pFSMX8ID5YcrYQ=;
        b=zK4qTV+8KKpoYX1lYTjGO5/NP2WQ9i5yhAUFfSHRxi4CBI0QPfSt2uaiR0ZD4CymZM
         cnNj1I71i3kb0RmhWGQ2jNlZKbNuiMkBh3Vkuupdte211Bm5Yzrv/in9EdRJosiUOYXr
         3Ej2YPhUfR0O4dgWftGEa4IT4p4p2Y3nm1+H73tRGqPs0tqeVi/Yae8TqZP0V8+eMGzj
         RjhcwADLuP5LLQZP5SJF2m/SiABe3f8/P5aYdmW7uCRJF/hElmy57LMQQiCYFaCQXUP1
         BvpWTOJHANOsSg23o/2L8pIVzJvrsv9ZGZCnq4iGOjcs26i8UC2+o0/JerFZQ7izTxxK
         TJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513166; x=1709117966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlnokSDHjEfyEFlKuGf7qGXhR75G4pFSMX8ID5YcrYQ=;
        b=rxL2F5EFP4Do12XKv/SLb1hnvG+AVDxWdDirMHyN+UaZ1qDrxvZF3fZc6lOrPRht39
         /G/B6pf9sk9HGRxKXB41FC6vZSUf/5jjZ2KlKjAOE94jsnuE6xKrO5d67tFUAMtw8ESs
         2pCdWoHO17EBHoEscDkZ92YB7Ttm7vjB4f2AHb1Isy66fgVvHqpbUyCgPVXBnpuKCunS
         3BfPJIFU52Z/HVx4nggAJXE9se9TK85XkLayzmCYWpaRIXoPpVzu3H68qYa98rq2r99f
         /y0iMzeP0SPOC02HOBQl2KmBPgioBJOucfoVt+tbOJZQIrdE7bwG9hYv/XFMlW15NJc7
         Y1bA==
X-Gm-Message-State: AOJu0YxqGsHJhnI2cS1qfEIL3xTc6uFey3o6SpNkgtlzvlRQPQFbOK7h
	w8sk1tCGTSCYTNRoO5RqE9b7+A4+CV7MmDkR+Evb+LNK3bzr3PqRtAXdRGEZ0dv0BsN/m3gjmbs
	6ZLTNdtWX7Q==
X-Google-Smtp-Source: AGHT+IHVYIpT8SuuO/jgqQVGI7/RZc3QCVFRp2ivQalYZyGUk1jSB5mhDtIIB4yGTMyir4GP+GCl0HX6jK+YCg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1081:b0:dc6:e823:9edb with SMTP
 id v1-20020a056902108100b00dc6e8239edbmr1024288ybu.12.1708513165802; Wed, 21
 Feb 2024 02:59:25 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:07 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-6-edumazet@google.com>
Subject: [PATCH net-next 05/13] netlink: fix netlink_diag_dump() return value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__netlink_diag_dump() returns 1 if the dump is not complete,
zero if no error occurred.

If err variable is zero, this means the dump is complete:
We should not return skb->len in this case, but 0.

This allows NLMSG_DONE to be appended to the skb.
User space does not have to call us again only to get NLMSG_DONE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index e12c90d5f6ad29446ea1990c88c19bcb0ee856c3..61981e01fd6ff189dcb46a06a4d265cf6029b840 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -207,7 +207,7 @@ static int netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		err = __netlink_diag_dump(skb, cb, req->sdiag_protocol, s_num);
 	}
 
-	return err < 0 ? err : skb->len;
+	return err <= 0 ? err : skb->len;
 }
 
 static int netlink_diag_dump_done(struct netlink_callback *cb)
-- 
2.44.0.rc0.258.g7320e95886-goog


