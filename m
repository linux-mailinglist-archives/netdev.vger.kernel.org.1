Return-Path: <netdev+bounces-18312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DB7566B3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB67E1C20A2E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DF253AA;
	Mon, 17 Jul 2023 14:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74D253A1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:44:49 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5DB2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:44:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c361777c7f7so8890556276.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689605087; x=1692197087;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BPMo0HlhyFyTA8FO5Al8xNPjluuBmMacNlBRx6aTqjE=;
        b=ni0O46vBBt2ZGNUoCCEtSz/YwFK7eLJGG/EQtXoc+4S1thO1aUNWiktmYsDCtrDtG5
         kP3S+g7oc9Hzb/jKtRoiYO//sxpVdH+ogYh21pQzckcJRITT+/9vr5WfgXh4c1642FF1
         nP6AroyrptBp2Oikl7+rgaTNiMnlDUz1MSsXif8GwLlblESzdmQra1up1zkiQA1Xtfp6
         1pXVGtE9Kj7nqdyYYp48tLKQ1Zln5RuR2qWfas0CwVqmgz0cIalAJebhIakBj8XBcNDz
         5hOBgIgmynuTVdU9hv1WQt47xwwg95o+MhjKYHRwUyhqjNI3/euSH1nTAlD4IkL3gOYq
         vWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605087; x=1692197087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPMo0HlhyFyTA8FO5Al8xNPjluuBmMacNlBRx6aTqjE=;
        b=Vk4+mbeFIBALXAY+3r85qf6yxdDtAQTVasiucK2wVhZoimkgLhpolUv0Qkak+RaaMG
         r2sYeS7rFyZAtA7CNZnu41ZLaK3zQmzU8srB/P4s74WV8DYWoDGNzjWXz/iUR8VJxHhs
         YHOicfdXWDrLQJMQILsMMlnYGHSXkiZqgm4BDId+IpbHIlkZXgNev8NxG5VBp+TVhmjg
         dmmvZe3FjDgkDxUk3n5EEYus9zafhLHKJtClS5HGunWzd8gTBbpowSG7R5WYYwFif4r4
         bPBaEPu94J8luqxwLJe/h3HG5DIQ6RkH8wFYaojnVsYpOt6ZJHgofo2XHr5Be7ZSyHVE
         U05Q==
X-Gm-Message-State: ABy/qLajIkxlAth+dez1A6kFkuQM2Hxdnjbf6lIlcPgP9Zkar2mN3dMw
	KLQKWx0pBtPy2Fkg9TtLmC2R/0mL1Vrxpg==
X-Google-Smtp-Source: APBJJlG+vPbin/TVoaVY93LYcBFOe03Y/n6SKW8D2r7xutcJGeIczXDzZ7Er/sKtG2fwwQR6iTpzHeJXhtRSDA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:11c9:b0:c2c:1b68:99b0 with SMTP
 id n9-20020a05690211c900b00c2c1b6899b0mr191401ybu.5.1689605087514; Mon, 17
 Jul 2023 07:44:47 -0700 (PDT)
Date: Mon, 17 Jul 2023 14:44:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717144445.653164-1-edumazet@google.com>
Subject: [PATCH net 0/2] tcp: annotate data-races in tcp_rsk(req)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Small series addressing two syzbot reports around tcp_rsk(req)

Eric Dumazet (2):
  tcp: annotate data-races around tcp_rsk(req)->txhash
  tcp: annotate data-races around tcp_rsk(req)->ts_recent

 net/ipv4/tcp_ipv4.c      |  5 +++--
 net/ipv4/tcp_minisocks.c | 11 +++++++----
 net/ipv4/tcp_output.c    |  6 +++---
 net/ipv6/tcp_ipv6.c      |  4 ++--
 4 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog


