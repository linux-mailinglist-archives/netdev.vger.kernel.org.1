Return-Path: <netdev+bounces-79566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75B879E46
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B56D1C21E84
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D0143C7C;
	Tue, 12 Mar 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DTySSMRi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D5143C4D
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281675; cv=none; b=qtZr2h8vOrWO622GH09h48VRDbTr84RfCNBHIneuO6iJRuMi2PtEhzHj7HEVEgHb154ArGOlFbMOe218zebnaofwS7BRNnbt8sPCvRH5tWjCp41rnCYBTtnHceKtOIC9Iu47+50AJM/hyuA/LDeEq/KXfbTkAn67fBDCb6ra4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281675; c=relaxed/simple;
	bh=2Yc1OAr6mqT7sNtO4XBI3qo5BBJa4i20jWBzWGdBMng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyS+VEiTMvsnxqEIUzth4JMqUIYgZjZr5MVYr7p2q7LT9XSfayzcjXXHmHhp7vjsCkwuwIa1NRWt8KVOvdO/s3cUOtweb3+gzGL/CoUPbDxE2Dqz1xFymWvN/BZel8gKgvK2//DzaU0VC9sWzzpPj1UshCGvYvxcowOf1CxQitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DTySSMRi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc29f1956cso30964065ad.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710281672; x=1710886472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nrng/1C7LlgnoxA4UaT/AkwTqWn/aRjOAZiED+a20Iw=;
        b=DTySSMRiJCPqIgQqbCXBB02EhJgWYHcxQQs3ufizXD8OpeWen9haSWMe9OSztPxF6k
         gZutFoetHY+VXeoyzvp/whfILRjP6vK7bUb95YKcTAxGcY6ldvSS2iudA+BcQo4hTpny
         D1/788JSPBEtMdxgKfl9vDMW5RDkweZzDs+k7vvEiDpNcg9AsoyHN0Me4dmOPsaEGw3Z
         GRjSGvEsAL1iX/jzREwpOMsREhTwuWiuY46naqLI1qopl36O0fXJB76rizY8eF43k7iv
         BgJ6W7aospcCKVkW69YJRQf+VjbP8Ukrdus9a0fOurv+aRTrMiEeOHZ/8INIEIr5UE9L
         8A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281672; x=1710886472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrng/1C7LlgnoxA4UaT/AkwTqWn/aRjOAZiED+a20Iw=;
        b=ORv0fYIvHMRZBP6nyKpYqs1cX7ksNBL/sQWubeY9WhaVSTxtCX+7LniBteTaQqUbef
         O11FmK83nkq5YYbBJ7iH5TMZmc6vyTFFr2fo+q38UKjQx8JLSDKG2aycEsfBBs4bi8pX
         GrCuUZHhJhkIB0DOdyQDajhbccg20X8p2KOiBxnm/5fUyxGOIyYlw8BmScp5zRjqPy4Q
         S9wU7KtqrETHSJgtQmbRDNC7DIpjgDrVlx6WnJ/usIuIP8Xhtmsj10CXQEfzZvthDCa0
         Vp7egXVQUTUm3y1v7rHnnjsh7ke5dMYoR0X42fVjqyP5s4vOZD1CHJ7pLVe6J3c8tL35
         bMNA==
X-Gm-Message-State: AOJu0YxMqWz/vAVtMIuDr1H6i/UYOLtXF8ucDR/NPsejCggMnFnmeXej
	azoh/VFhRPTtCGInUXrew+MFWfoGx973K/bLChu6vi4PRc6YX2wS+qL/4E8Pnz7CtgbhC3dRKZZ
	W
X-Google-Smtp-Source: AGHT+IGyOy5OFZBok0bKW2N5F31YkxRKMIHKYCYicpSYswZ4OR2f7oc+wIwLs8PjFJyxy1IgiMfqgg==
X-Received: by 2002:a17:903:a8c:b0:1dd:6356:8dfc with SMTP id mo12-20020a1709030a8c00b001dd63568dfcmr8270393plb.15.1710281672591;
        Tue, 12 Mar 2024 15:14:32 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902e28a00b001dcfaab3457sm7240473plc.104.2024.03.12.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:14:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/4] constify tc XXX_util structures
Date: Tue, 12 Mar 2024 15:12:38 -0700
Message-ID: <20240312221422.81253-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify the pointers to tc util struct. Only place it needs
to mutable is when discovering and linking in new util structs.

Stephen Hemminger (4):
  tc: make qdisc_util arg const
  tc: make filter_util args const
  tc: make action_util arg const
  tc: make exec_util arg const

 tc/e_bpf.c        |  2 +-
 tc/f_basic.c      |  4 ++--
 tc/f_bpf.c        |  4 ++--
 tc/f_cgroup.c     |  4 ++--
 tc/f_flow.c       |  4 ++--
 tc/f_flower.c     |  4 ++--
 tc/f_fw.c         |  4 ++--
 tc/f_matchall.c   |  4 ++--
 tc/f_route.c      |  4 ++--
 tc/f_u32.c        |  4 ++--
 tc/m_action.c     |  4 ++--
 tc/m_bpf.c        |  4 ++--
 tc/m_connmark.c   |  4 ++--
 tc/m_csum.c       |  4 ++--
 tc/m_ct.c         |  4 ++--
 tc/m_ctinfo.c     |  4 ++--
 tc/m_gact.c       |  4 ++--
 tc/m_gate.c       |  8 ++++----
 tc/m_ife.c        |  4 ++--
 tc/m_mirred.c     |  6 +++---
 tc/m_mpls.c       |  4 ++--
 tc/m_nat.c        |  4 ++--
 tc/m_pedit.c      |  4 ++--
 tc/m_police.c     |  8 ++++----
 tc/m_sample.c     |  4 ++--
 tc/m_simple.c     |  4 ++--
 tc/m_skbedit.c    |  4 ++--
 tc/m_skbmod.c     |  4 ++--
 tc/m_tunnel_key.c |  4 ++--
 tc/m_vlan.c       |  4 ++--
 tc/q_cake.c       |  6 +++---
 tc/q_cbs.c        |  4 ++--
 tc/q_choke.c      |  6 +++---
 tc/q_clsact.c     |  4 ++--
 tc/q_codel.c      |  6 +++---
 tc/q_drr.c        |  8 ++++----
 tc/q_etf.c        |  4 ++--
 tc/q_ets.c        |  8 ++++----
 tc/q_fifo.c       |  4 ++--
 tc/q_fq.c         |  6 +++---
 tc/q_fq_codel.c   |  6 +++---
 tc/q_fq_pie.c     |  6 +++---
 tc/q_gred.c       |  6 +++---
 tc/q_hfsc.c       | 10 +++++-----
 tc/q_hhf.c        |  6 +++---
 tc/q_htb.c        |  8 ++++----
 tc/q_ingress.c    |  4 ++--
 tc/q_mqprio.c     |  4 ++--
 tc/q_multiq.c     |  4 ++--
 tc/q_netem.c      |  4 ++--
 tc/q_pie.c        |  6 +++---
 tc/q_plug.c       |  4 ++--
 tc/q_prio.c       |  4 ++--
 tc/q_qfq.c        |  6 +++---
 tc/q_red.c        |  8 ++++----
 tc/q_sfb.c        |  6 +++---
 tc/q_sfq.c        |  6 +++---
 tc/q_skbprio.c    |  4 ++--
 tc/q_taprio.c     |  6 +++---
 tc/q_tbf.c        |  4 ++--
 tc/tc.c           | 12 ++++++------
 tc/tc_class.c     |  6 +++---
 tc/tc_exec.c      |  2 +-
 tc/tc_filter.c    |  6 +++---
 tc/tc_qdisc.c     |  6 +++---
 tc/tc_util.h      | 35 ++++++++++++++++++-----------------
 66 files changed, 182 insertions(+), 181 deletions(-)

-- 
2.43.0


