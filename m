Return-Path: <netdev+bounces-22307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35889767017
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E6D1C203A2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDF1400F;
	Fri, 28 Jul 2023 15:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096913FEA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:27 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28A2115
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d11f35a0d5cso2100820276.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556605; x=1691161405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WivKmFwTBCkD8KcanOuFIGWwOZjwU2z/l122KTLcH2o=;
        b=rYh+sVsf53IQuR5wR0FEY9SDONZVb8H2JVAO+pR3w0RK/In6dQAccd6FWfSMld3w4T
         JxiGUhyyjhlTnbESJY+19mkk+/JppLsI+VARu7h+lee5UIMW+yn7WySV3IfbY3t/nQ9o
         eshd5FMixucBgrs4fwa8Th5V/783vcqp8A/+Erf/Ia9T/7gulNqWpVC6FH5y2uwT2Y1y
         nSwENGUcE9hmifTERzUYzVJ4cBaCbrnFkQcGpBKX6GTGSmde1HEQLlB/RoEbtJtR7Wj6
         c7eawGtFgo2MxaW8iNNPov2izo30lBm08b+50hjw073F/Q7RAC5gf2icbwwVPmPthPwC
         tlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556605; x=1691161405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WivKmFwTBCkD8KcanOuFIGWwOZjwU2z/l122KTLcH2o=;
        b=fLdZbk8tjgEKo7oC+Wlt3PS/t5KZEchISZSB6u2RIR9nrdo+XzMtk7P6qD5YbOGGV7
         fawZcOyn0QFeVNq/OcQqqoglB+EhleSqSc9K/VVikHtanJsF6Syyf8I3u3OBwyrFgGcF
         1awMpax9+z90LW+2nxUpCof9xhHUrbZcP3T3RX2zp/hYbg2taV19lhfVti1oHcw/vWWK
         cC0vsRCsKS2Yy31SHOh6DcfNOhEgv+xvnyOe9VLvcPjp+8dAeJcItyJzwRwyf2wwyh28
         5j/ehhxWO4nwxavV/wdtUsJ5rjrIszFdEgCJs75DTgPMGS6qT1eSPgkn9gekLnSKJbzm
         67fQ==
X-Gm-Message-State: ABy/qLbr2NtUezjWtFwtBmdeOn+pRLAQ+4mkYSojYXeYRPJ97JS3xzaa
	mx7dHAzEp7GXNAvxtZZhypxqVuIyzMM0cQ==
X-Google-Smtp-Source: APBJJlEJiHvByn/CXi1GQhfb6+OwpMtA45sJzp4MqUK7n1x/afUZv2yhnEwEtq7TRqqjza20G/4JaP0SDX9Z/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1705:b0:cab:9746:ef0e with SMTP
 id by5-20020a056902170500b00cab9746ef0emr9361ybb.12.1690556605011; Fri, 28
 Jul 2023 08:03:25 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:09 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-3-edumazet@google.com>
Subject: [PATCH net 02/11] net: annotate data-race around sk->sk_txrehash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Akhmat Karakotov <hmukos@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_getsockopt() runs locklessly. This means sk->sk_txrehash
can be read while other threads are changing its value.

Other locations were handled in commit cb6cd2cec799
("tcp: Change SYN ACK retransmit behaviour to account for rehash")

Fixes: 26859240e4ee ("txhash: Add socket option to control TX hash rethink behavior")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Akhmat Karakotov <hmukos@yandex-team.ru>
---
 net/core/sock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index bd201d15e72aad4ea0b11941eaaa992de706634a..adec93dda56af7314f4a63c77f3848441f0d41ae 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1534,7 +1534,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		}
 		if ((u8)val == SOCK_TXREHASH_DEFAULT)
 			val = READ_ONCE(sock_net(sk)->core.sysctl_txrehash);
-		/* Paired with READ_ONCE() in tcp_rtx_synack() */
+		/* Paired with READ_ONCE() in tcp_rtx_synack()
+		 * and sk_getsockopt().
+		 */
 		WRITE_ONCE(sk->sk_txrehash, (u8)val);
 		break;
 
@@ -1978,7 +1980,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TXREHASH:
-		v.val = sk->sk_txrehash;
+		/* Paired with WRITE_ONCE() in sk_setsockopt() */
+		v.val = READ_ONCE(sk->sk_txrehash);
 		break;
 
 	default:
-- 
2.41.0.585.gd2178a4bd4-goog


