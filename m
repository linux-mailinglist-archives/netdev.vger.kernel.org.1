Return-Path: <netdev+bounces-23640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984676CE24
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980491C211BF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078E747C;
	Wed,  2 Aug 2023 13:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635F27475
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:05 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F82706
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d13e11bb9ecso7265317276.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982103; x=1691586903;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ily3wAWZHB5GgiUHEtf9zv3UOQl46vQVrcjbljZnTws=;
        b=m2bE+2uOeEqrpwfYqzHTWn3mb488vSCLvjmcgmrvpIQKIpXUG3eFd5007jEYlhLWOr
         nPyrEvvd3qVhKBeBTiNBPlfms3+BhJafSmyok+ZqhlHH2UfOb3mHacXWuEnDW1wYk8Rz
         hQ7bHEqfG/Qjz6x9RrbL3cTXyet0+9VBkeBnRFMZjRwoKjvDFAvUW+oaI4tI5ZgL27wn
         F2um8aETdXvKbUubiktJ1+Spp8irVSSPh5qOgi9akfX4lhik81TfTJDAaq21S33hkElu
         l0LOEvL/hqfit13MHUFPreOT4LX5X0QcD9hQkPlTyH7o/lQCs5FYx/o2/hfS2iD5iBPe
         B1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982103; x=1691586903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ily3wAWZHB5GgiUHEtf9zv3UOQl46vQVrcjbljZnTws=;
        b=RBpjx/dDahIY/sK0q94kjLu9FKVGhIV4Zo7D9DtAxx+l76ectnAWMFBtjLyozLdTVh
         aza1HpwiKFgeNf/8pHWsxzCCWsETnlPr/r+Ce9KgyseZkAC0Ld4WUgC0bj2D3+irN6aQ
         c16J1WDNBpq17AhA/BpsgF5pA0/pOLXMzvSYBE/Zu+tcrQ0oih1oaeEaZL+6qrLjlI1G
         J80guMbeyF7Ej5mV7eaLKv8AzzpZFTHbYLJ+1GomQY815S6iUxLPasG191e+5fea8q8a
         JQtprWKQjwy0Qn8mDSB7gdhOhR4U+wr+ULuCMLyzGLYNyzpQBbJyEqc5lCVwqkw31ENk
         Nr1A==
X-Gm-Message-State: ABy/qLaiPhWaPqqTWc3p6fq7wxZ2cVvqO3oaFOmfD7qVHl4a+vGuyWsO
	9+5dmxRf7LfrKsVCC+mIcLPZy0wajveY7g==
X-Google-Smtp-Source: APBJJlHVBk0Q9GuT157Vo3jKSDAxXtSn6/I0ECfWKi5sNODWDAgI6+bZdMty35RdRnRcXfutuCi8xHCsqRef/Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:23c4:0:b0:d0c:77a8:1f6d with SMTP id
 j187-20020a2523c4000000b00d0c77a81f6dmr120914ybj.10.1690982103030; Wed, 02
 Aug 2023 06:15:03 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:14:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-1-edumazet@google.com>
Subject: [PATCH net 0/6] tcp_metrics: series of fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains a fix for addr_same() and various
data-race annotations.

We still have to address races over tm->tcpm_saddr and
tm->tcpm_daddr later.

Eric Dumazet (6):
  tcp_metrics: fix addr_same() helper
  tcp_metrics: annotate data-races around tm->tcpm_stamp
  tcp_metrics: annotate data-races around tm->tcpm_lock
  tcp_metrics: annotate data-races around tm->tcpm_vals[]
  tcp_metrics: annotate data-races around tm->tcpm_net
  tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

 net/ipv4/tcp_metrics.c | 70 ++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 26 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog


