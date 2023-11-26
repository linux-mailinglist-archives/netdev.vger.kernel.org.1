Return-Path: <netdev+bounces-51118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C97F934C
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A71C20976
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6618824;
	Sun, 26 Nov 2023 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwWCvJub"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB11F0
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701011822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m5u/ab7IuDASESlzxALPg8Iqhjs7X4s/7bijJ9wvXUc=;
	b=bwWCvJubc90DsIKtD8NVmdcj11ZTPmPRL2gCarsvPhsHWN7r68uVwRixS7dfmJpc2ZxhJ2
	noOdinp+9IS36hNx4dan3e4irokEmRtR7CJC6rIgFsr7cFMlqddFaSpADQdQoe8t4EdroR
	keKWDd/t1/5xUK35YTEpWW95a0W4Xug=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-hMMTzMRSN6m0PTYlmPOFIg-1; Sun, 26 Nov 2023 10:17:00 -0500
X-MC-Unique: hMMTzMRSN6m0PTYlmPOFIg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6b74afe92dbso4362478b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 07:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701011819; x=1701616619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5u/ab7IuDASESlzxALPg8Iqhjs7X4s/7bijJ9wvXUc=;
        b=Dm+i1USz6vedz3ptlQ31TPUAo8j+L5nDPJfttDZSLGa5N6Wb3bhavEtANS4t4rvGs5
         Fn1RntoF5LCG1M71VsR0LCHohV6pU1AeKH6BmDE7+aLpNj2wamuEb4c+QvnAlkXaEinz
         xqCsdI0ZIHYyvs6rix9zCF4stEyG/Lf6OWVq6ncT/hIdjX4++b87jt6WPkEF9s/JnOOv
         yFBGBj6s2soSlq6HkArjD7bS1+vIaZZ4KJQWfgyBSZs6tPhDQI2VIllbgIt/fDM82XH9
         mHDdagxemo5Z7J+ph67LkqTrDXfrF5ZQ5kl6JES+TwOgT53YSnB7F5MFzse3tohR0Pep
         8oMg==
X-Gm-Message-State: AOJu0YzDnkZJeBGQXy5QsEF9wHxXjSHJ1CWj7ILmyQKTKd28fmQDLb1S
	pvpg0zKej9M52kx8pVbFxCzR8rSdRUYaZNshfW+dNdeFgj6XWSe3ApUJDWmnn/mt3UU5ZiBlKr+
	0oG6V6hBXfOAYDHwr
X-Received: by 2002:a05:6a20:42a0:b0:188:973c:ef84 with SMTP id o32-20020a056a2042a000b00188973cef84mr8891712pzj.9.1701011819121;
        Sun, 26 Nov 2023 07:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5K7vaXEJtvpYYFlAtX0kbwzhVEiFkQ2rZ57uByILnB7JxHiS9pynUU99kpWfoE8eavMpE1w==
X-Received: by 2002:a05:6a20:42a0:b0:188:973c:ef84 with SMTP id o32-20020a056a2042a000b00188973cef84mr8891687pzj.9.1701011818817;
        Sun, 26 Nov 2023 07:16:58 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b006cb955dc54csm5741888pfn.58.2023.11.26.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:16:58 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
Date: Mon, 27 Nov 2023 00:16:52 +0900
Message-ID: <20231126151652.372783-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
true. For example, applications can create a malformed packet that causes
this problem with PF_PACKET.

This patch fixes the problem by dropping skb and returning from the
function if skb_pull() fails.

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/ipv4/ip_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 22a26d1d29a0..95efa97cb84b 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
 		 * to gre header.
 		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
+			goto free_skb;
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.41.0


