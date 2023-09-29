Return-Path: <netdev+bounces-37132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193107B3BBF
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 23:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BDE30283061
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A2667270;
	Fri, 29 Sep 2023 21:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3152466DF0
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 21:04:38 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFBE1AB
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:04:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690d935dbc2so3243185b3a.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021476; x=1696626276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFWy7a2C7N/DP8l8BQ/mPnz4W62DKbb8RfYmlPQjHd4=;
        b=cepC5cMSJFQ3rg04qANBPDdACC6RVWotJkvtAA0idh4zokLg3JM7MGX0guwzXP2eGO
         UJwq60OeBWcicL+yAHp+4t5ht9qgz64NeO6klDVRwAmg4cnpSWtUvu/Mc9vkBEtNdNl0
         ASzNgflIDVUo+LXwU/rFnkyISpzHTr4jYLKhkEofuCBPZZuFfyhd0srwurdgupE1OEIC
         cgphPK0WPCERZJWcyAnSkkf63YneOR+FKX9B2JoWzkg/6pd7iXZjTwm5yIcpVMfWdzko
         nofl1lLcGPyWCG4acdDkLWPasf+LZR28Mffa/c96hS82rS8xikgYN4za3Poo35vk2bmF
         fJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021476; x=1696626276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFWy7a2C7N/DP8l8BQ/mPnz4W62DKbb8RfYmlPQjHd4=;
        b=ZSV5EFzI9KErlJTnQJJwouJZAbuXXGClo/I5xmMu8d90ATDBRMzUf3pDy1Z0Jv/uih
         P9bEE/feYm5O4VL8RMTmqOnvr2OmTmST0T0bBOY57FysltcDYOKOShSISFEE7/9oousq
         ucJp+5DKNw9SPhUXzM1es2VfaMvrZgpZDtgz82hKhL4MJDbFmnVkgQt2CMwSrSwDZTvZ
         WuJ0jM0t/lMmpZej5i8WZLBf74WheGHJ3lEZr/6bhQvy+TgGnn0hLmtNaB7sopOcfkrd
         wXGh52yqzFcAWxD6ocItd7EtcnqDmYWEEAN+j61YtVfOIpeJbvIZCEt5k41M2IQwV76Y
         Vdeg==
X-Gm-Message-State: AOJu0YyH0zG9Foud3SywM+CQyp6cBcgtBLILz2MmT5uMj5xU98YEC8sV
	0nPP4gR2LhQ9nwwwhySxKvwEV9ni6OM=
X-Google-Smtp-Source: AGHT+IFdzbQvZFWl8O1FB2SK1w5KrnEkkUFxf4N++hO6tKQaFlNc/0ZbJniEdh4Vco7j1mc1cx4JHg==
X-Received: by 2002:a05:6a20:8e19:b0:15a:f7fd:dd9b with SMTP id y25-20020a056a208e1900b0015af7fddd9bmr4923294pzj.6.1696021475776;
        Fri, 29 Sep 2023 14:04:35 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b00690cd49cee2sm15431120pfo.63.2023.09.29.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:04:34 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>
Subject: [PATCH net-next v2 0/2] tcp: save flowlabel and use for receiver repathing
Date: Fri, 29 Sep 2023 21:03:50 +0000
Message-ID: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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


