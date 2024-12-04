Return-Path: <netdev+bounces-148776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A749E31CC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CFC2847BF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51A13C682;
	Wed,  4 Dec 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Z5UJcQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C6126C10
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281548; cv=none; b=qonZf5ch2RsipHfjAQkX84RfEeRFj3nGpA73xfoXVj9+JexmwTF0+fyzDA1LIC2M/zoSQWEde4V0AqXXlgkiZMvsZpDMOjK00bxrelCeyU3PX5zBU2qbcohrIXx58MN/Bn6mgv16vtbkylUfLrCI8t/GpZL5sWSameA1KgEalX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281548; c=relaxed/simple;
	bh=cPTzjKoi9QmmS0uazqJk1jTziGAjNbEuOH/8RCAKg5E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JremQPMqsEnP8+NNNRdsxxO/OWTzA+eOURie2GTwPAswcdm/YdF7gj5ywQH46u2FEuhPhLDA31TqXCn12lWAxIlelQU1eIjb6aNiJKaHMp7C8DfPV3Ut+5qv9hazBVuuQ9pkXoPpOcnUkdVOm10eHLXUtZxzKam7cmx28QCA2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Z5UJcQH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-215772c7bc3so26208935ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733281546; x=1733886346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r789tNdbpPstIDUxqYH1CkFmfWhy6gdjYYz6Y7krhFU=;
        b=0Z5UJcQHW55J9kBxVCyKOP4mAEwDWK57QmqxJHoCwv8pdT4xUBtF/nDoxBdfpb3Qy+
         I+tO8Tzqg4S7xkbnADdtGvZ2mpDG+twlbeJ6j+XeJvlcNZHtvQeNDmtPnUjzf/xMjOhn
         5Qi4q40irHcoY/JV3byLS90gFPOp2J5Bsml0Va4NZdN9ioMbWY9Q+U8+ylDHIsIt5Qvv
         j2LTdbG13gK2GIbaOUzeiFm4r8CPl1n9jsIv6IsU3VFQx7cJ/snUQO+wIRwBX1jRkQzJ
         3edXtSK0MBnGasBAuwJo/l4EO5q4zaJFNxZ7kzyVMqF6hJh/1NjX1DEoGGMGe7MMGC5u
         M3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281546; x=1733886346;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r789tNdbpPstIDUxqYH1CkFmfWhy6gdjYYz6Y7krhFU=;
        b=Y+ha0z0Pk9Y/q4+mSkhvAwhid902udYWASdiiWEdp+SVON02v3zFS6AB3WuoPhGIqs
         1jx+ilQmBlKQiXiRo8Q0G+sqtffR2ed0wXUoZXRM7L3+9hBvzUDIJCXKMlZCvB2Gx+nG
         D3qbl642kLty4MjClgC2ieD9ixRpvSGvsSCe+VcCDbERo/v9/gB5/mPJWhZE9vQwe/V7
         JZtOgtgBLU2KyMZrG85yfcLU2K3lHoxrID6wytyik/FP97/QGemLE+sI6kRq081JIi8s
         zrr3ctSs2Ck0AJmNLX4mu2mqk5iNADgBGdHuu/0FBPJp9NiLf+8XZlcTw7i8va8zAO+D
         /Qlg==
X-Forwarded-Encrypted: i=1; AJvYcCW39Ovib2l75zDOuVxzsOMdyoUSUkqY6kg+v2wlgPGB7ubKk7U89Mu8OPceFgiLZoOtuVsPDgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnATGLwxsQlZ+SwOw9enHymTBgplRa15nPOAcFWUYdNMIHWAF
	6dga9szuKHMYi/DJhg+VhS1BDjQZIVl3+U53BHh1WbV4zsSFFFRRkJU21y3BK+D5hHIpuaNvuQ=
	=
X-Google-Smtp-Source: AGHT+IGd7US4MeQmN5a1Z69UVZDuOHqY4COPDruuGqeXPDYSe7HbjFJeTBD7NKudl0tB94ISpA2Xo8xW7Q==
X-Received: from pfbcj7.prod.google.com ([2002:a05:6a00:2987:b0:71e:6f0e:472])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc84:b0:215:9ec2:8c81
 with SMTP id d9443c01a7336-215bcea1262mr81992235ad.11.1733281546076; Tue, 03
 Dec 2024 19:05:46 -0800 (PST)
Date: Tue,  3 Dec 2024 19:05:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204030520.2084663-1-tavip@google.com>
Subject: [PATCH net-next 0/2] net_sched: sch_sfq: reject limit of 1
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

The implementation does not properly support limits of 1. Add an
in-kernel check, in addition to existing iproute2 check, since other
tools may be used for configuration.

This patch set also adds a selfcheck to test that a limit of 1 is
rejected.

An alternative (or in addition) we could fix the implementation by
setting q->tail to NULL in sfq_drop if this is the last slot we marked
empty, e.g.:

  --- a/net/sched/sch_sfq.c
  +++ b/net/sched/sch_sfq.c
  @@ -317,8 +317,11 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
                  /* It is difficult to believe, but ALL THE SLOTS HAVE LENGTH 1. */
                  x = q->tail->next;
                  slot = &q->slots[x];
  -               q->tail->next = slot->next;
                  q->ht[slot->hash] = SFQ_EMPTY_SLOT;
  +               if (x == slot->next)
  +                       q->tail = NULL; /* no more active slots */
  +               else
  +                       q->tail->next = slot->next;
                  goto drop;
          }

Octavian Purdila (2):
  net_sched: sch_sfq: don't allow 1 packet limit
  selftests/tc-testing: sfq: test that kernel rejects limit of 1

 net/sched/sch_sfq.c                           |  4 ++++
 .../tc-testing/scripts/sfq_rejects_limit_1.py | 21 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 20 ++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100755 tools/testing/selftests/tc-testing/scripts/sfq_rejects_limit_1.py

-- 
2.47.0.338.g60cca15819-goog


