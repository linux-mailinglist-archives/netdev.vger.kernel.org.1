Return-Path: <netdev+bounces-35243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C907A8209
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0021C209B4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A3F328C5;
	Wed, 20 Sep 2023 12:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B7168A9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:54:22 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9883
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so47031857b3.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695214460; x=1695819260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y/tiUph49qfUrnIDnxV3S4RPOHR5056Z7sgaGeiW734=;
        b=tXvmry7K5sSdMZuD/DipGz8xgPJa+AGRGQs3q6P6m97BddkOTWWsm6Rh/mDVklES9D
         IHIT4H0pYY6yT6Zy7o1essIZBsmvjBZkv3n+Oc0TCCqU+3hYEshN6jkvbR2SnQhnYhCB
         +zXMkbFF6yd3DKvdERzIKTxkR5xeO/qwV+iYW8Yl391tKpz0sl5ti29pFRsduD7qjxlA
         21LprsFZzB3G9AyxRU+hPVtOqPIG8BnQGgxhCPQvRRj+IuekedRsv1ECA7zPiHngjHay
         Rejs8lJ2/CftL4jKd+DeidVMmK7qvkWWQikrYaWhmDhK5tzEhsmOcCWOHv7SRuIphfOa
         Q5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214460; x=1695819260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/tiUph49qfUrnIDnxV3S4RPOHR5056Z7sgaGeiW734=;
        b=xVIjvQYlOxvbbEcJdykVxNpQi5g/bN+tFdhtajRfH5xTBND9XF/6bLxiSebi6K8G+0
         Z0LhQxJChKwsUyYhGgKpZAhsdYihb3ZdT4uO15nok1BbneM2SFQy0++eJaPSbzkINsys
         nsoUYo63sI9SqKZ7+kxph6mARpo+ppx4ZxHX39B5YKyWp3Xqpuu4CUZc8DqNrkQHHduA
         9Z44fu4WKKeSAq8cB1pM8AKsHTpmFHKCZ/NZRSw8JDwYE1NFk0wolIPk828jW+fc4+W5
         sqPfnp4f+OxqjbUZin3jJTEjfIw3eYlUTQeGwYd/Wfu82MXQkZCPn+Qn6H/xUU6EhtHk
         vz2w==
X-Gm-Message-State: AOJu0YzQiPUC/4yGQCdEEZrAjd03EUfFlkmJahM6bxkCWVEjMhLxWJGI
	Wwzy6EFeV8T0AMWa1ENa0dOxIHBAf30KIg==
X-Google-Smtp-Source: AGHT+IE6+a0X/zflw8wFzSKcJpL+dD052bbuHPZegpzcgFXz8969q5LVJJzXhh8uizTkClP1JYWEUsiqvWk7Iw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9a08:0:b0:d85:ad61:1591 with SMTP id
 x8-20020a259a08000000b00d85ad611591mr23280ybn.11.1695214460344; Wed, 20 Sep
 2023 05:54:20 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:54:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920125418.3675569-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net_sched: sch_fq: round of improvements
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For FQ tenth anniversary, it was time for making it faster.

The FQ part (as in Fair Queue) is rather expensive, because
we have to classify packets and store them in a per-flow structure,
and add this per-flow structure in a hash table.

Most fq qdisc are almost idle. Trying to share NIC bandwidth has
no benefits, thus the qdisc could behave like a FIFO.

Eric Dumazet (4):
  net_sched: sch_fq: struct sched_data reorg
  net_sched: sch_fq: change how @inactive is tracked
  net_sched: sch_fq: add fast path for mostly idle qdisc
  net_sched: sch_fq: always garbage collect

 include/uapi/linux/pkt_sched.h |   1 +
 net/sched/sch_fq.c             | 127 ++++++++++++++++++++++++---------
 2 files changed, 96 insertions(+), 32 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog


