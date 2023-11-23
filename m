Return-Path: <netdev+bounces-50384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3C7F581D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9822816B4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFBCD290;
	Thu, 23 Nov 2023 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLTgayP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918F19D;
	Wed, 22 Nov 2023 22:22:10 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so355778a34.3;
        Wed, 22 Nov 2023 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700720529; x=1701325329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ72FjqGJlZojA/R0kOWZH0a5lounehg4Yevi61ow+E=;
        b=kLTgayP981vhGUfsbU9dnP+k50fMzblTQMgR86puGTHGUT3AuCZ0odKJdETCrSKNJI
         nJuzmWNPZCSq4fqc2zo3QmVjZcMt5BgwaUG5aKwHJjSN9GRdxvReyg6zczaG5yZ6i2pp
         eGJSaDyufGMkpj7kVqVWvwnfTUb/Pdj/vadku8pL4acQeKCnfUzC5gkXpVx6ScSniQej
         RRAEwv0hYb05Mu89+bQVnKWl6/WCirIJoZeM7h1QfcrCNqzyMKhR2Vy9DuoNEZwAMi/T
         ydmKybcTKgYEwfm5HZhHOD3DYT+q3GRyI38kzTttdZnT05XS+g2k0rj1XSVLS4nifW6U
         5rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700720529; x=1701325329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ72FjqGJlZojA/R0kOWZH0a5lounehg4Yevi61ow+E=;
        b=Y655RaxnhOWNOFVD+hHvjp3XxhjjJCuj+dDA7xrO84rqZypAgjGWOAevd4x761D50t
         6Q/Nh1fSXM0ZgvM7K4b5oTI3y8zwI1bjnWS3NGrNAWT6Ds3b8axKChGwV63xhWyuqFwa
         53KFfumXpxLhQ8XtJF+U0/3+lwxL7VxNFzqnnlbcHOIrJILu9Sg6+8fg47EDMsYozvst
         Fo6rlQ6r3mGxQySlC5eogz9UEEP4M1qnTVT8+vUrZnfT3BktZo3iQVDDqezGkuCaZVwh
         NIIFPj8A1G98QW8RwAgZlZEJLhBbC/xYLhUgef8qNPLWz0Gvj5T+WaIleYpv6PFc+YpQ
         4zrQ==
X-Gm-Message-State: AOJu0YxlZyws5LOJUsXhilIxhPx+oYDckLBl7XY5PFFypEy1ImNVqs9V
	PsnbmLnVjx2yJR/l+L82DAo=
X-Google-Smtp-Source: AGHT+IEiV6i+iZcCjVP/TOREJ5o96UN5n4MHpChfGzooYBCPubbyw7kOY3Z1tGDSv+Ypsz+E6XGOiA==
X-Received: by 2002:a05:6830:1e67:b0:6ca:c677:4568 with SMTP id m7-20020a0568301e6700b006cac6774568mr4948065otr.10.1700720529566;
        Wed, 22 Nov 2023 22:22:09 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a21-20020a63e855000000b00588e8421fa8sm554525pgk.84.2023.11.22.22.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:22:09 -0800 (PST)
From: xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To: tung.q.nguyen@dektech.com.au
Cc: davem@davemloft.net,
	jmaloy@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	xu.xin.sc@gmail.com,
	xu.xin16@zte.com.cn,
	ying.xue@windriver.com,
	yang.yang29@zte.com.cn
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in tipc_rcv
Date: Thu, 23 Nov 2023 06:22:05 +0000
Message-Id: <20231123062205.2038335-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB9PR05MB9078636E4D78B9F4442898B088B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078636E4D78B9F4442898B088B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>diff --git a/net/tipc/node.c b/net/tipc/node.c index 3105abe97bb9..2a036b8a7da3 100644
>>--- a/net/tipc/node.c
>>+++ b/net/tipc/node.c
>>@@ -2154,14 +2154,15 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
>> 	/* Receive packet directly if conditions permit */
>> 	tipc_node_read_lock(n);
>> 	if (likely((n->state == SELF_UP_PEER_UP) && (usr != TUNNEL_PROTOCOL))) {
>>+		tipc_node_read_unlock(n);
>> 		spin_lock_bh(&le->lock);
>> 		if (le->link) {
>> 			rc = tipc_link_rcv(le->link, skb, &xmitq);
>> 			skb = NULL;
>> 		}
>> 		spin_unlock_bh(&le->lock);
>>-	}
>>-	tipc_node_read_unlock(n);
>>+	} else
>>+		tipc_node_read_unlock(n);
>>
>> 	/* Check/update node state before receiving */
>> 	if (unlikely(skb)) {
>>@@ -2169,12 +2170,13 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
>> 			goto out_node_put;
>> 		tipc_node_write_lock(n);
>> 		if (tipc_node_check_state(n, skb, bearer_id, &xmitq)) {
>>+			tipc_node_write_unlock(n);
>> 			if (le->link) {
>> 				rc = tipc_link_rcv(le->link, skb, &xmitq);
>> 				skb = NULL;
>> 			}
>>-		}
>>-		tipc_node_write_unlock(n);
>>+		} else
>>+			tipc_node_write_unlock(n);
>> 	}
>>
>> 	if (unlikely(rc & TIPC_LINK_UP_EVT))
>>--
>>2.15.2
>>
>>
>This patch is wrong. le->link and link status must be protected by node lock. See what happens if tipc_node_timeout() is called, and the link goes down:
>tipc_node_timeout()
>   tipc_node_link_down()
>   {
>      struct tipc_link *l = le->link;
>      ...
>      if (delete) {
>         kfree(l);
>         le->link = NULL;
>      }
>      ...
>   }

Happy to see your reply. But Why? 'delete' is false from tipc_node_timeout(). Refer to:
https://elixir.bootlin.com/linux/v6.7-rc2/source/net/tipc/node.c#L844


