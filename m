Return-Path: <netdev+bounces-14806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1A743F09
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E10A28107F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335C1642A;
	Fri, 30 Jun 2023 15:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20BF1640B
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:38:20 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025BEC
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:38:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bf34588085bso1872230276.0
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688139498; x=1690731498;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jB0gv/iik4tLCV7nUD/RuA7T6OGPsZ2hxPYvxsVtzaI=;
        b=TfjGehjc13DejXYSe5xq2G6TGXIw1SZfhwB9e8oQvZTUNtC897uALGb/jXdmdcBo0D
         85SuZMufaYua8I3Mlu3WS3lvlFuuEHGiad2CjwmRElC6cE5aZw10XnAo+txND+IDO+BH
         IxoKG0ZYYEACxRP+OxQzwkYbxzH6sLHCGwGDfz3AawTL8yHYK8XPT4h14InsrL4zFpLI
         jOXW7b7IAY1oQ3c+CkRBEEZO2DQXg3JgHVkXm+PjzXqqJBmxFBGjKuJECPuy2yGmRt6G
         InMUifr2tRu6WZqOGgOPKw03UFUwHNR+ZYoBHELongd1dZphILf2Q4uZVWvTiwEoLAtF
         WT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139498; x=1690731498;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jB0gv/iik4tLCV7nUD/RuA7T6OGPsZ2hxPYvxsVtzaI=;
        b=FjXcMY8e4HOoSsS//P9FshEHTtJgLrRDr2zAywcSQZbW/9z95LdyWdN+9aOZETc+bn
         lJ3ccBhrXfrrKcg7EqCjW+Ub6VdiZj/ihtjWX9Za6JajJJyLwoABae4SbBuH02U24w3c
         YDKQk5z1psU9GkiPC5iG/m+HQcKLDt0/ekV9XgcFZ+S05Ayln0aAxBkzhlgj8mjhq1CJ
         eVJ6Z2meWMdcj+tiNnk8TOnyXlF/ACfCfKRGs7dvmt5B6ZUqDKFQQOR23+2wRJ7uhSi5
         6XaMigEXRgfaynT1BAtPvy3j/boEyrcHgiblF/fCCa7Fp8s4f3E+7v8KmnbmRqQiZGY3
         S5rQ==
X-Gm-Message-State: ABy/qLa6my0kipQdmpnQic8VZAKsiTg/dItdGYyjBOwICMXCgBPAs2Dp
	gG+q8KqS3nKdqfr5kA6OthLrF0qj
X-Google-Smtp-Source: APBJJlG51VALyqpsRg/3x8DfFY/83M3ufcJIRcf5n/8ovHknPRjrpmJSQKCKJKMd6FhIEzK0azIiRByg
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:d642:9a30:16be:45f9])
 (user=maze job=sendgmr) by 2002:a05:6902:1813:b0:bc5:2869:d735 with SMTP id
 cf19-20020a056902181300b00bc52869d735mr18470ybb.13.1688139498138; Fri, 30 Jun
 2023 08:38:18 -0700 (PDT)
Date: Fri, 30 Jun 2023 08:37:58 -0700
Message-Id: <20230630153759.3349299-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Subject: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Benedict Wong <benedictwong@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Steffan, this isn't of course a patch meant for inclusion, instead just a WARN_ON hit report.
The patch is simply what prints the following extra info:

xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->protocol:17

(note: XFRM_MODE_TUNNEL=1 IPPROTO_UDP=17)

Hit on Linux 6.4 by:
  https://cs.android.com/android/platform/superproject/+/master:kernel/tests/net/test/xfrm_test.py

likely related to line 230:
  encap_sock.setsockopt(IPPROTO_UDP, xfrm.UDP_ENCAP, xfrm.UDP_ENCAP_ESPINUDP)

I'm not the author of these tests, and I know very little about XFRM.
As such, I'm not sure if there isn't a bug in the tests themselves...
maybe we're generating invalid packets that aren't meant to be decapsulated???

Or are we missing some sort of assignment inside of the ESP in UDP decap codepath?

Somewhere in the vicinity of xfrm4_udp_encap_rcv / xfrm4_rcv_encap
(and the v6 equivalents)

$ git log --decorate --oneline --graph -n 3
* c1ae64591391 (HEAD) FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove WARN_ON hit - related to ESPinUDP
* da2779e6377a ANDROID: net: xfrm: make PF_KEY SHA256 use RFC-compliant truncation.  [trivial: .icv_truncbits = 96 -> 128 -- just ignore it]
* 6995e2de6891 (tag: remotes/linux/v6.4) Linux 6.4

Full call stack from running the Android net test suite on a 6.4 UML via:
  ARCH=um SUBARCH=x86_64 /aosp-tests/net/test/run_net_test.sh --builder all_tests.sh

*#### ./xfrm_test.py (11/24)

.........xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
------------[ cut here ]------------
WARNING: CPU: 0 PID: 326 at net/xfrm/xfrm_input.c:380 xfrm_input+0x7fc/0x115d
Modules linked in:
CPU: 0 PID: 326 Comm: xfrm_test.py Not tainted 6.4.0-gc1ae64591391 #8
Stack:
 604bc85a 605bc4ee 818ef5b0 604a3aea
 818ef650 605bc4ee 60037b59 604bc85a
 00000001 605ae79b 818ef5e0 604c3327
Call Trace:
 [<604bc85a>] ? _printk+0x0/0x94
 [<60025a79>] show_stack+0x113/0x18b
 [<604bc85a>] ? _printk+0x0/0x94
 [<604a3aea>] ? dump_stack_print_info+0xe1/0xf0
 [<60037b59>] ? um_set_signals+0x0/0x3e
 [<604bc85a>] ? _printk+0x0/0x94
 [<604c3327>] dump_stack_lvl+0x4a/0x58
 [<604c32dd>] ? dump_stack_lvl+0x0/0x58
 [<60041747>] ? check_panic_on_warn+0x0/0x6f
 [<604c334f>] dump_stack+0x1a/0x1c
 [<600419b4>] __warn+0xcd/0x118
 [<604bbc1e>] warn_slowpath_fmt+0xe4/0xf2
 [<604bbb3a>] ? warn_slowpath_fmt+0x0/0xf2
 [<604bc85a>] ? _printk+0x0/0x94
 [<603e2958>] ? esp_input+0x28f/0x2ac
 [<603fbae9>] ? xfrm_aevent_is_on+0x21/0x26
 [<603fc087>] ? xfrm_replay_advance+0xf2/0x26a
 [<603f99cf>] xfrm_input+0x7fc/0x115d
 [<6040334e>] xfrmi_input+0xa3/0xb2
 [<60403373>] xfrmi4_input+0x16/0x18
 [<603eb9f0>] xfrm4_rcv_encap+0xb5/0xea
 [<603eb102>] ? xfrm4_dst_destroy+0x67/0xeb
 [<603eb39c>] xfrm4_udp_encap_rcv+0x1c6/0x1e6
 [<603eb1d6>] ? xfrm4_udp_encap_rcv+0x0/0x1e6
 [<603b60f8>] udp_queue_rcv_one_skb+0x77/0x339
 [<603b7957>] udp_queue_rcv_skb+0x5c/0x298
 [<603b7c01>] udp_unicast_rcv_skb+0x6e/0x7c
 [<603b962a>] __udp4_lib_rcv+0x613/0x6fe
 [<603b3641>] ? raw_local_deliver+0x0/0x1c7
 [<603b9a0c>] udp_rcv+0x27/0x29
 [<603809eb>] ip_protocol_deliver_rcu+0x77/0x104
 [<60380b4c>] ip_local_deliver_finish+0xd4/0xdb
 [<60380a78>] ? ip_local_deliver_finish+0x0/0xdb
 [<6037fe91>] NF_HOOK.constprop.0+0x76/0x81
 [<60380a78>] ? ip_local_deliver_finish+0x0/0xdb
 [<6037feed>] ip_local_deliver+0x51/0x72
 [<60380371>] ? ip_rcv_finish+0x0/0x3d
 [<603803a9>] ip_rcv_finish+0x38/0x3d
 [<6037fe91>] NF_HOOK.constprop.0+0x76/0x81
 [<60380371>] ? ip_rcv_finish+0x0/0x3d
 [<60380b9e>] ip_rcv+0x4b/0x50
 [<60318d32>] __netif_receive_skb_one_core+0x46/0x4d
 [<60318da2>] __netif_receive_skb+0x55/0x5c
 [<60318df4>] netif_receive_skb+0x4b/0x4f
 [<602c9838>] tun_rx_batched+0x199/0x1b4
 [<602cf02e>] tun_get_user+0xba5/0xcd8
 [<6003a100>] ? userspace_tramp+0x1a6/0x242
 [<60039b1c>] ? do_syscall_stub+0xfa/0x24a
 [<602cf1d7>] tun_chr_write_iter+0x76/0x9a
 [<601410aa>] new_sync_write+0x8f/0x101
 [<601423d2>] vfs_write+0xe7/0x12a
 [<6016239e>] ? __fdget_pos+0x12/0x4c
 [<60142555>] ksys_write+0x79/0xb5
 [<601425a1>] sys_write+0x10/0x12
 [<60027b34>] handle_syscall+0x79/0xa7
 [<6003a9af>] userspace+0x4cf/0x60f
 [<600248bf>] fork_handler+0x92/0x94
---[ end trace 0000000000000000 ]---
xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->protocol:17
------------[ cut here ]------------
WARNING: CPU: 0 PID: 326 at net/xfrm/xfrm_input.c:352 xfrm_input+0xf2f/0x115d
...

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Benedict Wong <benedictwong@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Yan Yan <evitayan@google.com>
---
 net/xfrm/xfrm_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 815b38080401..bd10605b211d 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -348,6 +348,7 @@ xfrm_inner_mode_encap_remove(struct xfrm_state *x,
 		}
 	}
 
+	printk(KERN_WARNING "xfrm_inner_mode_encap_remove: x->props.mode: %d XFRM_MODE_SKB_SB(skb)->protocol:%d\n", x->props.mode, XFRM_MODE_SKB_CB(skb)->protocol);
 	WARN_ON_ONCE(1);
 	return -EOPNOTSUPP;
 }
@@ -375,6 +376,7 @@ static int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb)
 		skb->protocol = htons(ETH_P_IPV6);
 		break;
 	default:
+		printk(KERN_WARNING "xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: %d\n", XFRM_MODE_SKB_CB(skb)->protocol);
 		WARN_ON_ONCE(1);
 		break;
 	}
-- 
2.41.0.255.g8b1d071c50-goog


