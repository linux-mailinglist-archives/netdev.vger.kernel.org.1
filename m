Return-Path: <netdev+bounces-188545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F1AAD47F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA43AB5AC
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0971D5AB7;
	Wed,  7 May 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdtMtQNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4012CD88
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592579; cv=none; b=AQ84OrQiMh/EuWnumPTNA35V7pngXmOvr8osAJGDOxt8RAcN5JhlRCCP2Y4BKHxRPEVa8atfOn+mQxPpGFPAGRx8Ps2aHloEx0EtgJdRWpzd6kB+TCAI72jaFY6gTEM00BbZWIDVJkeN7PuM6zZDADtmhcw3FPn35t7VNjaY0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592579; c=relaxed/simple;
	bh=GFw58BffRB5sxeR4n81Jt1eT5Lur+AIZCaWxUzWIGUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H/lneEwyYLYYaJ6ErFwHgrF2lzSATu0Q1X27Ez0eVimz8bG9leE8tZ024Tlvei1F89GQd/oq3O8aGIv7/+Yh+YjZX9SSwqQU3EiCTFZTwhzPn1g0Xv88urKjEi7y1ymy/lWyqy41IQQA2ODFT9/coy9/5QjwwB+QDTMngIs/3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdtMtQNd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73712952e1cso6419263b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746592577; x=1747197377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0UDBJaqMIujdoVxqIhUJlm3XTwQ5B/rxADwWVjkuLQ=;
        b=QdtMtQNdnLbhjmEbJo0u3LVgDFXto1vkF5WO/8kCIyG82DFbIpWCZOORx9gttALPUr
         s0ps1pu1YFH33aJrcUenN4+mO75cgkWsXqBspKr5qY65a2NO8nDWoIzg10WVf5vqDc/j
         WUmkEC/Wr9fvNO8b8JSn7lIXqfqJBSzPpUG4M2pKePNmzuz144MMWteqvzI1sUmB7zzm
         rP86ikgCDTMjwjd8yxsg1uNGpd+349FWP8Y4tzH+/m3I9JG8McFs5J8WDoqVT+OpMPeh
         LmJWkE17qnfZ8u7DHuBzw6sz0xj7RQiUpdgLK6xfE3nO1+AQXTQ2d+0Rs5fMmuLg7LC4
         AkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746592577; x=1747197377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0UDBJaqMIujdoVxqIhUJlm3XTwQ5B/rxADwWVjkuLQ=;
        b=OMwY8LOVnH76MhuL9c6d5qXlTal6Z/Qc2A2vqVIEzK8l1L0IqZCzcAKorK/6OoS5eY
         2nTTsP3m3wcd7uWlYxlA7u6PbDiQlShVDzmxl7BECL+Vkk3Ca6ZfK0GensRtCOsq9TJK
         0p4bBTrmG2wZqS+Lgr/xan1roGO+ywtgmzsoOWZx75b3w7zTxVTbhlzIDS3g08v6aJ0x
         +I97+ABVvGiZ90vtLaaRN1L2l6Mm7FVxh6EzF2ywJ5o1ogUd/HxJiE1wPCmmxrtMlZmT
         ejn30Oe73vTA3DfF+2ElYKqPFOtxVanoCES9akUqRbkqCXsH4ewcZXuENVdAXK9PFbSk
         7Vcg==
X-Gm-Message-State: AOJu0YxuRY9tr4nLXf1J3g/AuRleqdwGzVs/as5NMhTp7DB9ataoUvj5
	lvfHBU+v7/YuZqG8KAxCDAfxhVQtkXn+GUv3NX7Zc4LdkHfwaY/Foe8o0Qwf
X-Gm-Gg: ASbGncty25rv7S4mrCZ2WYdpWllJ1IAYEXsMECID7bKdI/YPF/Tt29Jdnx2R/kgzN6y
	h2DKde7MMw8bqQ3Lr6cUh9o44wRpB+meSFiZDSzS0MrdEA+YuIMfWBLvtjAl07BQdEqk8r+QJe4
	B1i8l95kht/GyX6XNADgHB9vG6H4OmuKrhiSIPu7j8fpC6ClM2dCavewCiUQnC0jXKYNgBMfvD0
	YvWFx6hZuyubqylDvKfMBnU8dl8qmZjUL5VP/ZKWUiW1P+yEWkGx/mMCtGt4QuT/1m+cLaByxbR
	rmzgopI5k2dxVoA1/nlIprKPKDPnxuq2JcfipB4hl+KiDQ==
X-Google-Smtp-Source: AGHT+IHn2wC+DfEzTNs8hxCnL2kH2iWlCpNNHvvRlUTBd1NDmxxNm7UWurJhSRER00Fz0eeK5r6RxQ==
X-Received: by 2002:aa7:9a84:0:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-7409cefc52fmr2255291b3a.9.1746592576889;
        Tue, 06 May 2025 21:36:16 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:734b:a7b9:d649:5d9e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902109dsm10350720b3a.106.2025.05.06.21.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 21:36:16 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	willsroot@protonmail.com,
	savy@syst3mfailure.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 0/2] net_sched: Fix gso_skb flushing during qdisc change
Date: Tue,  6 May 2025 21:35:57 -0700
Message-Id: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains a bug fix and its test cases, please check each
patch description for more details. To keep the bug fix minimum, I
intentionally limit the code changes to the cases reported here.

---
v2: added a missing qlen--
    fixed the new boolean parameter for two qdiscs

Cong Wang (2):
  net_sched: Flush gso_skb list too during ->change()
  selftests/tc-testing: Add qdisc limit trimming tests

 include/net/sch_generic.h                     | 15 ++++++++++++
 net/sched/sch_codel.c                         |  2 +-
 net/sched/sch_fq.c                            |  2 +-
 net/sched/sch_fq_codel.c                      |  2 +-
 net/sched/sch_fq_pie.c                        |  2 +-
 net/sched/sch_hhf.c                           |  2 +-
 net/sched/sch_pie.c                           |  2 +-
 .../tc-testing/tc-tests/qdiscs/codel.json     | 24 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq.json        | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_codel.json  | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/hhf.json       | 22 +++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/pie.json       | 24 +++++++++++++++++++
 13 files changed, 157 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json

-- 
2.34.1


