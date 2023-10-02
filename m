Return-Path: <netdev+bounces-37411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FBC7B53C9
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D6FC4B20A7E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0B18C24;
	Mon,  2 Oct 2023 13:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F89168AC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:17:46 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F5B0
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:17:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a1eb48d346so146912637b3.3
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696252664; x=1696857464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UviE7gNHoGTjeRL3UJ2ZMftog0mp3PTguSK9JSO5txs=;
        b=cUCG3tgw6TKeIcqS9qTolRaxctCWKkVtyOGUwGKzKHxF5+Dvhs93pBB03mNjN6ldri
         TvAj84Q5TrfEDEjLdm9mgH6hMZcwKuX0dl76IwwMVOqWgtBkCE7TxdQ1G3JhOBuhpmP6
         633dkEBCpEn9/cqN/71KJGXG/WAAqOUJlN4MFC7nh/SrcfnAo1ChCHI+9KILfs80BI7L
         8yxGDCxfpr9ViuQWSYnwQx7jd86406hd5oSKVEIozNWqwsAjo55LBhpXJCJZBT7xMsn0
         XsTTnSFfiBLrfkja1WZNAGrRBt69fIbDwC+IfqlT1tJDQdVNopy/OVM3bxdLjWhvEv/9
         jpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252664; x=1696857464;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UviE7gNHoGTjeRL3UJ2ZMftog0mp3PTguSK9JSO5txs=;
        b=goKkYYWZikBCkEw9kpLV4Q6Xgi5Ztk78xnNyLMs2X1x8DDDnjK+VefWoefxWpypLjX
         +mRtMXzO9d+9H+vuWI32/ICdrx22rRhiByumPifigfnmcrQYbj879XIiC0/yf3FPqVA8
         kwMSL8IF5JPhklqDdtC5vF93fdsFYqeUFYbBVBYmLWm/OsnNwYZMHySuIdt6Wk3KTH/0
         qPK0o3u7w8+g301/3EY9yiEHxSolKhjB/EMdCjUktetg/DZLbfsrEmqYLj7x1V2llBWn
         JW/2QGYRR1onSHtr5FOrT6PMvpRI1IURuNVIO9CxjhMwvA2Q5iuYvfD48NYtWW9+yrYE
         3SSA==
X-Gm-Message-State: AOJu0YzWvBosW0b2UP1vMV8MiGLrSX1vDZZXa3PT0y0hl/rIu4a96xH1
	19P/HukkDm2BFgUIaZokh/n2fy0XWSIk9Q==
X-Google-Smtp-Source: AGHT+IH0jXgEFbqEdYfZDoeDMEnuQ5dFmYaFH5qVKUDoNQ9zWh+KdtzVczV6JLoor2NgGkZANC2nYWMMvWoNjw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ce42:0:b0:d84:e73f:6f8c with SMTP id
 x63-20020a25ce42000000b00d84e73f6f8cmr175940ybe.6.1696252664224; Mon, 02 Oct
 2023 06:17:44 -0700 (PDT)
Date: Mon,  2 Oct 2023 13:17:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002131738.1868703-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net_sched: sch_fq: add WRR scheduling and 3 bands
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As discussed in Netconf 2023 in Paris last week, this series adds
to FQ the possibility of replacing pfifo_fast for most setups.

FQ provides fairness among flows, but malicious applications
can cause problems by using thousands of sockets.

Having 3 bands like pfifo_fast can make sure that applications
using high prio packets (eg AF4) can get guaranteed throughput
even if thousands of low priority flows are competing.

Added complexity in FQ does not matter in many cases when/if
fastpath added in the prior series is used.

v2: augmented two extack messages (Toke)

Eric Dumazet (4):
  net_sched: sch_fq: remove q->ktime_cache
  net_sched: export pfifo_fast prio2band[]
  net_sched: sch_fq: add 3 bands and WRR scheduling
  net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute

 include/net/sch_generic.h      |   1 +
 include/uapi/linux/pkt_sched.h |  14 +-
 net/sched/sch_fq.c             | 265 ++++++++++++++++++++++++++-------
 net/sched/sch_generic.c        |   9 +-
 4 files changed, 228 insertions(+), 61 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog


