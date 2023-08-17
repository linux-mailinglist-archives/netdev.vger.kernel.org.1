Return-Path: <netdev+bounces-28594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3977FFA8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CB51C214F4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D91B7E9;
	Thu, 17 Aug 2023 21:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4671B7F7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:15:36 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDF35B1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc3d94d40fso2117595ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306934; x=1692911734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6pRzVAL1HfaFk+MrN35IOTXl1yUajrA5beAIZxFLLg=;
        b=MyltMusNWYrHHduM59ZY3KVk2F109y3Pp1ImvclhC5uVVFlNLd85wpLi5oUy/yS5VG
         ZFFcJApAMPM4nChjoYVKU7Y6Oh7sZaTnMWVh6YYIKI0/wWuJfWBrRxdnsHBmTTqccdY7
         /Ns8/4aEaQBWWwnFK+vLM7Ur9D5iHCixdohfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306934; x=1692911734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6pRzVAL1HfaFk+MrN35IOTXl1yUajrA5beAIZxFLLg=;
        b=iU4t6r7ASXMY0TRjrpzpvGAsMJK2JnfdilblGSQrU/ezXDiPz7A4NQ9jmiOSaEG0Jz
         XJGyGDcGWL8O6RYZc9eEa6mEB3JgdmUYUiaGxTiEQEuUDlCcp5QbuSKByNZDHW7miEsG
         SkzLctPGTNC5YpiXIOwYMtAnWPKDsmJkjzkkURDxyaEKuf5avOEhOrIzECLHc50Z4O+6
         9wHpnYfqsDsjRlM+37sJOz/vjU/fPfAWDGfMtKbVJRr83WGXdqNI22X+8vvvuCzaq4LX
         Uyd7Spx4q/mZbTOkqxgJrsYpc4Rz2f+q42dpP0DPvkqfe5LX5h9NA09NZk+ttCZoH11K
         vaFQ==
X-Gm-Message-State: AOJu0Ywj0mhZr9jwVc46E3Ia68/zFE6MRAVlE22vmSiy8DK2UgaV5Lwe
	9yqvFlHKcfDS0ndiLrucctF1rw==
X-Google-Smtp-Source: AGHT+IHVjuRk1web/N5CIE6G3DSroLocgLnvFFM3Lfkq6agT4XiyPHhqIHZks3sie+eRrw9Rg6gakw==
X-Received: by 2002:a17:902:be03:b0:1bd:e85f:700e with SMTP id r3-20020a170902be0300b001bde85f700emr590833pls.69.1692306934435;
        Thu, 17 Aug 2023 14:15:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001b9f7bc3e77sm208556plb.189.2023.08.17.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:32 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/7] wifi: cfg80211: Annotate struct cfg80211_pmsr_request with __counted_by
Date: Thu, 17 Aug 2023 14:15:26 -0700
Message-Id: <20230817211531.4193219-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=keescook@chromium.org;
 h=from:subject; bh=ytZuVuu89ZLCBsGHGYeK5Mrw8+wpGzwhqHz7UbWnFA8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3x/0j3Sg2xlp/sAxt3CMimE1sDR90HXUPBB
 lc5GQBuZSuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JnDCEACQDuHi5umP6pnbV1/6oqKWEuBYmNo/ZvDgqxNNQUELDL5Ta/5wtzf7XiiCeoll8eOLUCi
 P7ReHnkR5v3TpE40/l08pqvVD0Uhy7syN+4izs7Z/I2Tj6P9F7QPf1eIz9o+DGg+BoXpIz7+anZ
 deuiv+CQBw/qR3n+4ZutHmcdrJ6VXv7JPMxjVlKnPlKZ14LELqAVNYpqRb7GVT9mtCWYSUCzI/o
 q7pc8sXhIiGvqbhGEH1DHBwUsDaCJFyZU0deQ/4Wr6PjJmzm6VwT1/tCLXsJSOc/Bm0dZnJ50tF
 CrXF9Lu0muoI54sFAZ2aObdmUdx9cRs7vLwLMPMpORFSToSzsYuxcmfoe139MigExg96t0sqMjr
 15BXehaTyC/b1xov42tJ+E86o2aphkoRQy/CJfb+41Ab6Kxd881kUk5U5AQDaEzwFxO70DgRF9i
 AIBAQRxAKLNJiH/KfcqZ+dBL3eZFLiSraO9F/WymXLqEq+VLYAFI0NzWsbLSyYAxYakd3yyqocD
 rama7ffqboYN4fv1HznzYuerAjJ40SUp7OYKWNCrjOenDPT+r7wkghCV4iXQMjc7EOpL3oHq35H
 Lwq8T6EDWTvsH0OISgIGkXmXOFRctDiRJ1qka4z9zeAyOBEMvT3kscRRH+5HmFH3PAQoLms2mF6 tAQgs/hfx8leeZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfg80211_pmsr_request.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/pmsr.c    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5c7d091b3925..e9ca4726a732 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3948,7 +3948,7 @@ struct cfg80211_pmsr_request {
 
 	struct list_head list;
 
-	struct cfg80211_pmsr_request_peer peers[];
+	struct cfg80211_pmsr_request_peer peers[] __counted_by(n_peers);
 };
 
 /**
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 77000a264855..9611aa0bd051 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -291,6 +291,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	req = kzalloc(struct_size(req, peers, count), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
+	req->n_peers = count;
 
 	if (info->attrs[NL80211_ATTR_TIMEOUT])
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
@@ -321,8 +322,6 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 			goto out_err;
 		idx++;
 	}
-
-	req->n_peers = count;
 	req->cookie = cfg80211_assign_cookie(rdev);
 	req->nl_portid = info->snd_portid;
 
-- 
2.34.1


