Return-Path: <netdev+bounces-183221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B9A8B6B8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8797AD6FE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8E238C2A;
	Wed, 16 Apr 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="P0oNzqa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E92253BB
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799077; cv=none; b=hIPdlMwI7uz0y3XjSVKhkrHrJIwA+5v2frB5UqSpuqUwAFRJGB6GD7mCBZu8RM+gxAMs40kulb8/mauyb+kWDkmujfJWdFd7Oq2w8mIC1XKtdHQIDUQegwtMPzUM34H0whBsngDRkUKUoN1xDhtm8/jmp8dFOVoFf1LMsHDMAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799077; c=relaxed/simple;
	bh=IFrOnSN7ZF9xNWXtvcYWTK8kYSynVU/HEIpJ3inYg1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9qQw9yJi/fEg75TXhJo6lf0joc/v7EplpMnCCqr57U/tTkWbghHC0XKy0KTqZepYfuqNufSWU3tIsGbmOlmDwsA1ZIoZNcOFVcShI0a6CjYiWclXXskV5Ni/qUO5OivSPAvo4aH+fztur1eZTMDb90CZT+FmkmdXBQ1SnXprNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=P0oNzqa8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7322589a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744799075; x=1745403875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrUmlspayn/U7Fi6UANPQ0JVAUdFI/bj9tjZ0oR09Hc=;
        b=P0oNzqa8aqsjUBmKZey+AuqLw6Eere1GcVW4kkmD7mqaf9dhW99gfQxDLVtKoeoDig
         nv9LTdKWD/l0ql2zhDBRqfUjYbT0Fm+ddIsqXmc6vulN0Lcv9u8mrEfDvqXMQcthkbSH
         2NdAEVgTX61NzvochFfom/A/e5jK2t8NQabV6Fex92AwSaWtseTcYnoYRUas6Kf2y94d
         mnFSZR3NElwoOwH2RQdwc0Wxhnv10tbtF9/JkKMxAfVxOQLqKWRnEK17FA+7e845IjSh
         t5ZVGyMocMmUW/ZKKndE07FR0WBeV6PjLYg+wpWkqQ7F1GfBdJvJ+weNcST2SvpYqAqr
         nvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799075; x=1745403875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrUmlspayn/U7Fi6UANPQ0JVAUdFI/bj9tjZ0oR09Hc=;
        b=tWT5FpUDxYcgtr3BAtFgOXkMX7WZdUfofjZ8/paAZP5K7mRK6PcyVTrPDs89w9y5z9
         z2iggDhQr0YPB9lY0kQsPojyDzN0iWdiCeDDeuIE6NUkAxJA/BoXxyFA1t9Oya4+SMdJ
         3aNhVu8o2K0QVjtZZXBrBln6GvkQfQIS6g2591/XnMMj8SDrYXBL8zy03/9r1VybUw+f
         7MkutvRnPQv5nZtP33p1RXndc61F147u1/rcShItFgErCiJy2Sk5on2RSPFiGXi4AHfY
         /GPe+jxyDDSCqru9E7iU2G4HbcSqfcisepPi1eY+6r0XLMtBl21/KGKL/IcmUG/HgR6+
         A7jg==
X-Gm-Message-State: AOJu0YzGp5nofW/b+rlWqNpA8xZyBbDN2PM3syEBHaF9b7ZC61PL2hVE
	yUzkhK13dp4SRA2qERd4KaC8JL2Gdbmm7dXenPRF2c032nyEyEyzjjLgoXtfOl2kgMtxN1G0aAI
	=
X-Gm-Gg: ASbGncvVI86992MGdi7JVQpeoELIdEq71Fa1s0pp73y5/peq9Eeax0MkWi2jLQj2yAJ
	lUrCf5klNndh1IqiNcuM7DqCMUkWhLAZHFf9OahjeKYgeQN4qKomB95MLFwTdU2lBUQfQYHN+9N
	orG7b/wJaK5IoC+ek+Tt4SgPwHHhSZRzu1cTinjte0aQD1EG4nZ6yCYK2kAzw7VY5bWRMc6fEu7
	e4ssadErSUiQt0vPopE3+iI7QreZk6rGQCkjqI7M/I1FKmDsbq5FmwJBEFuLFEVNgDM5Af0bmUN
	7piLNVG/Qpc6aITcf730OswIWo88O/Gw/pdTWhfQMclcFYY2XFV4+NWSbWYhunOPO+rgq/Zs3+M
	=
X-Google-Smtp-Source: AGHT+IFiQA1nm4yqUKbezeg3rsxL4VaChjzo8Uc/vLepPvCm2aSOGIGGjaIt6nJyWL64dKC9QjSKaA==
X-Received: by 2002:a17:90b:2751:b0:2ee:db1a:2e3c with SMTP id 98e67ed59e1d1-30863d1de40mr1947583a91.1.1744799074749;
        Wed, 16 Apr 2025 03:24:34 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cb765sm1193075a91.43.2025.04.16.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:24:34 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue cases
Date: Wed, 16 Apr 2025 07:24:22 -0300
Message-ID: <20250416102427.3219655-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are cases where netem can
make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
qfq) break whenever the enqueue callback has reentrant behaviour.
This series addresses these issues by adding extra checks that cater for
these reentrant corner cases. This series has passed all relevant test
cases in the TDC suite.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

v1 -> v2:
- Removed RFC tag
- Added Jamal's Acked-by
- Added TDC tests
- Small cleanups

Victor Nogueira (5):
  net_sched: drr: Fix double list add in class with netem as child qdisc
  net_sched: hfsc: Fix a UAF vulnerability in class with netem as child
    qdisc
  net_sched: ets: Fix double list add in class with netem as child qdisc
  net_sched: qfq: Fix double list add in class with netem as child qdisc
  selftests: tc-testing: Add TDC tests that exercise reentrant enqueue
    behaviour

 net/sched/sch_drr.c                           |   7 +-
 net/sched/sch_ets.c                           |   7 +-
 net/sched/sch_hfsc.c                          |   2 +-
 net/sched/sch_qfq.c                           |   8 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 148 ++++++++++++++++++
 5 files changed, 169 insertions(+), 3 deletions(-)

-- 
2.34.1


