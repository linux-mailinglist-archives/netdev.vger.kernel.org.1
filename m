Return-Path: <netdev+bounces-18135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69175574D
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 23:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2481C209B5
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 21:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFBF945A;
	Sun, 16 Jul 2023 21:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AE9448
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 21:09:26 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F9E63
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:24 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9c90527a0so1003633a34.1
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689541764; x=1692133764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U3lPBoNQjayaS/DivUlToHQ86EUNtyyOsS93ieyNc4=;
        b=V+DLU8QkExlQtpa7W/xekYpUU4Cw+cbP5zbw7AsvXjcmZ0EgCuaj6WPlVI7D7BKvld
         WU/6UsQ6uFUy32P0WCFKyyR/1GzWIDJDZvTtU6RyvOrcniCRcWlQcm9Gh0HGScUnOcIw
         9iuM9g62IEQjLuezVcxGroHyghWd7jz2MibzqPjdvXTIB/Uhpb+v5km0vYN4eq+6XoBX
         cjFYhpJcOtpykfMbWOemj6Rwt9JXIv9xNZA9FiW9M59darVZx8ji0iKME9cza6xDutm/
         uFS3sR1FHme1eCV+1PxrbEmEcCQcmudgDXsZeswUdQGw+/Q2mZDjDfP6/WwNbq06Z52a
         4KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541764; x=1692133764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U3lPBoNQjayaS/DivUlToHQ86EUNtyyOsS93ieyNc4=;
        b=VEj5naDM5Z7QdzTT8ePg12j6kFyhV45HEqgZ8TrRG+75Z81VGGaABEzR7A0ti81r2j
         059zsip+BknlLvyz3hK+yhP4Qi1x+YAnml44sCNxZvs/tnsn1D9+lQHX0O4qt5EHf86g
         ykQthxCBYnjv/PnuSYNuwtDIgjo2ZQw0V3Gxjl3bqfLrTCWuTzVLvxkrp786VGXfK5Tc
         /wUEUZyj+gwZOcqa9zwTvNVbb5IL3+wc4N+QGxTPPLhz+XvbPBzzhocoNcQyf/ETtsF3
         k8ABqJdRtEB9VXwlARKeMDI23102jwMhztWNhW5LvIFBodR0p8pTplyIlgZyP+keAWvS
         Ifig==
X-Gm-Message-State: ABy/qLaM0bhz9ToQ6XNYvro4PEFVtr8nQHbfK60PBXT5bCactDZAQZfo
	sJ+owlYfnElE9Oe8HFaRSzWUwTOmhIiBbw==
X-Google-Smtp-Source: APBJJlGqDyLJX6ISrwxeuAXWP6pIpwukzp8JbjFHJX6Ft+YE6M6X0TAaQi9PUsXwcSwL2qPziq0dQw==
X-Received: by 2002:a05:6358:7f18:b0:133:e1e:f0b5 with SMTP id p24-20020a0563587f1800b001330e1ef0b5mr9100381rwn.12.1689541763575;
        Sun, 16 Jul 2023 14:09:23 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cdf05000000b0062635bd22aesm4654745qvl.109.2023.07.16.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 14:09:23 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	dev@openvswitch.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH net-next 2/3] net: sched: set IPS_CONFIRMED in tmpl status only when commit is set in act_ct
Date: Sun, 16 Jul 2023 17:09:18 -0400
Message-Id: <4ffd82b3acc34ebd09855a26eb148fcd59fa872c.1689541664.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1689541664.git.lucien.xin@gmail.com>
References: <cover.1689541664.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the following flows, the packets will be dropped if OVS TC offload is
enabled.

  'ip,ct_state=-trk,in_port=1 actions=ct(zone=1)'
  'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=1)'
  'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=2),normal'

In the 1st flow, it finds the exp from the hashtable and removes it then
creates the ct with this exp in act_ct. However, in the 2nd flow it goes
to the OVS upcall at the 1st time. When the skb comes back from userspace,
it has to create the ct again without exp(the exp was removed last time).
With no 'rel' set in the ct, the 3rd flow can never get matched.

In OVS conntrack, it works around it by adding its own exp lookup function
ovs_ct_expect_find() where it doesn't remove the exp. Instead of creating
a real ct, it only updates its keys with the exp and its master info. So
when the skb comes back, the exp is still in the hashtable.

However, we can't do this trick in act_ct, as tc flower match is using a
real ct, and passing the exp and its master info to flower parsing via
tc_skb_cb is also not possible (tc_skb_cb size is not big enough).

The simple and clear fix is to not remove the exp at the 1st flow, namely,
not set IPS_CONFIRMED in tmpl when commit is not set in act_ct.

Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sched/act_ct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index abc71a06d634..7c652d14528b 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1238,7 +1238,8 @@ static int tcf_ct_fill_params(struct net *net,
 		}
 	}
 
-	__set_bit(IPS_CONFIRMED_BIT, &tmpl->status);
+	if (p->ct_action & TCA_CT_ACT_COMMIT)
+		__set_bit(IPS_CONFIRMED_BIT, &tmpl->status);
 	return 0;
 err:
 	nf_ct_put(p->tmpl);
-- 
2.39.1


