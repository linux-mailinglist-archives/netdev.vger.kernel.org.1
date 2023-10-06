Return-Path: <netdev+bounces-38453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07477BB005
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 08657B209C0
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8085139B;
	Fri,  6 Oct 2023 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8JLQX2C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB6137B
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:18:49 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55463D6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:18:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-277317a0528so348395a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 18:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696555127; x=1697159927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6b+BhGnqS8QCrCX36eQi9bS0yunU0kJFrU3oS+QnLBE=;
        b=Q8JLQX2CKSFerx54nZBsRrQdf3fizZV4eLe4wx0aFpWE8TxzshncHdp8Dnhuc4n4Q5
         AplXn2F25eaau7pnrHERnhF3GyevSWr4R2cRwiuOmF/e3zOSqAjr6oiQQnh7EeLISXV9
         iVgR4GKE46NEvaiyWXCYPd8Obyd0oil9HI4wsUK32ccN4exuHEJCQ64MOaeLbh8TyQxs
         MnV8ItbrDzAccPgVxdxszqqc5UMBbedF66esG+ukB6IPYLQkxAYyl331Ouxhf3fUfli2
         KlBlmdXBT6LasfhrDkqk8BfYu4crb+mTuPIGOxrItuZeDxoodr2G1aInuomPf7GMxd7Y
         YlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696555127; x=1697159927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6b+BhGnqS8QCrCX36eQi9bS0yunU0kJFrU3oS+QnLBE=;
        b=c6Gh0OqDAF98S94UNiwmCofjZz3ng8Ekdst775fI1vM0O9ei7mhuPjAmXbeBM86OZ0
         exOQumr6gGR8Kvg3qWcsaKerG4QAs58hHzKmX43YaDHYIqWNbw4ppL2XKfTPK6yYRZtw
         YE4HIos6rkn2IfWx8dhaNsnBI1RzvVTDykfzGAoRiw1PH8Wbl7JByAC9jNOZIx6NLHP9
         cFgQyPmwFlYmp7p79nsodWH8Kl+xguBP8BFmcKVbmoFb8Z6pdUsYzrvK2yaYBqOTAICh
         hT8u5ZP/FCTwL8qxoCjOeDrQldmJaalfKiPbIiSBYE2e39Wf6ITyUmjrJiyy67ptM3iq
         mL5A==
X-Gm-Message-State: AOJu0YzjyKOhK+UphG7PpjCSYoD7VXzA41GNmhXoeyu544pHaGEbgsbG
	LSO5N6UYNKW2Tq90thzcuV4=
X-Google-Smtp-Source: AGHT+IHseGkH/AO6kyHWtAjAc9APzKBQhZGG/MKsjzvogrwj+g1HCJxB70F23H7HIi7e4EpZxGx2IQ==
X-Received: by 2002:a17:902:e74b:b0:1c7:1eed:10f2 with SMTP id p11-20020a170902e74b00b001c71eed10f2mr7281306plf.2.1696555126658;
        Thu, 05 Oct 2023 18:18:46 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001c20c608373sm2413776plf.296.2023.10.05.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 18:18:46 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>
Subject: [PATCH net-next v3 0/2] tcp: save flowlabel and use for receiver repathing
Date: Fri,  6 Oct 2023 01:18:39 +0000
Message-ID: <20231006011841.3558307-1-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Morley <morleyd@google.com>

This patch series stores the last received ipv6 flowlabel. This last
received flowlabel is then used to help decide whether a packet is
likely an RTO retransmit or the result of a TLP. This new information
is used to better inform the flowlabel change decision for data
receivers.

v2: addressed kernel bot feedback about dccp_delack_timer()
v3: addressed build error introduced by commit bbf80d713fe7 ("tcp:
derive delack_max from rto_min")

David Morley (2):
  tcp: record last received ipv6 flowlabel
  tcp: change data receiver flowlabel after one dup

 include/net/inet_connection_sock.h |  5 ++++-
 include/net/tcp.h                  |  2 ++
 net/dccp/timer.c                   |  4 ++--
 net/ipv4/tcp_input.c               | 29 ++++++++++++++++++++++++++---
 net/ipv4/tcp_timer.c               |  2 +-
 5 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog


