Return-Path: <netdev+bounces-87636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905068A3F4A
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04BD1C20A54
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25947F45;
	Sat, 13 Apr 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lwlvt1Ws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED656B64
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045930; cv=none; b=FDm+nKT9UzmQE05WX26W0Q46cyCbTXg+kS7UWJeslAQotx+sfdwcVxhPI1+82b41PrQDU+rqZq75rF5bJf9AsvFNauZ0t2C2wsybStFxRrBSA9YL36y1YYFC9Jk3tL1lwnCxoajxBnOlVCubZwnJH750LgErbvA/0qwTVw0bmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045930; c=relaxed/simple;
	bh=L42kmqA9Jy9fgq+4uMNKDODX8LfKpUch7L2hqb0A1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7oGJe32+N5KwSrdJA+jiWZOr99AuLfdSh5M20wIVkyna0GoZxTOTyd1SQlfH0EqnQTw0DcEEG/Eabf1XZuPQ+t/Zs8RltVhadL4e5aj3ntKmr4AuYXyFSy5QdKjwAL44iGeBOJeCEP8YWxdpV7O95H8pwcIFePeUoJBan3cx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lwlvt1Ws; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1516661a12.3
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045927; x=1713650727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60YCD3zHhoJBXaaeu4LMotejehBMJW+LXnPtONJ5pR0=;
        b=lwlvt1Ws7DVQ08ILc8tfbt1W6o0+Q1piQ13rHeGgMsHGMP+Za/EVq/PA+q6vxerPVu
         GhQiYu17oKHCnUiWjHUp3bzU0+tFXAKJZjTPakjIpUrYGvnUpnmRgyAWBy0CBN/x9FxM
         /tlUxsJd0dvEJJngMRBl6lGfb16Oupp+YzjiTIJQZRllWd3pg9RmM4wVl+0dNfmoTnrY
         Ra5qCcVjDetCqIg7mOQvzkEYdVDxch8j9zxDhT1YG35moLUIOOLbiZtpm4Qj0l//mLPX
         wijUfcAzFOYEKIrAcd/VUEFIbYYueqMVE0xsElPue5t3lHnnnPvgKNjskrO6Q2XZ2emI
         1o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045927; x=1713650727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60YCD3zHhoJBXaaeu4LMotejehBMJW+LXnPtONJ5pR0=;
        b=uhwSAwT0qENQbuMjlTq4+1d9fNivyYBSpLTW87w7P3NmJ8cTz/ONafR/K4JL5sIUDk
         G8AvejqM3q4z8oRLciTllHMKRpQjbJDF6dU6HrVANNsKZ7h5IIXZME+s2NXVPtZBGkk1
         XPiegCkvwjDw0i4+hr/aadI8vqeo0iPrz4dEt4eflbdIaSiCTfbkT1pKw/CrktSRICAe
         xxXB4dBU5rKDgM28/B+1IWxC5pyYYmK9Eatfwt2O8AhXO2ob35WIcWjsFwnP1xWQXloN
         7RNhb5lVofd6fJ4VEk7As9u/ZPQcjXn/owogOgtIMNEmkA8ypSmqFJVSo0nk8N/RYnDr
         glqQ==
X-Gm-Message-State: AOJu0YyaWmCa5S8IFlvDL7Mg8tvB2JSJXvXiOUwWDt4IHYFDJcSo8504
	7xb/4OxcY6hB6HgT3SkSd0O3cdNWn8bb7E9t9LzeSuUJfpNZUNMplnkg/QOxXurjqSbsQorsqik
	K
X-Google-Smtp-Source: AGHT+IFl+HOrWs/LgZ21/LhPddFLvfdNbtqJ16Wd9Q70qf7z002rDR0jbzZm24Hbrb3ys6uOo/Myyw==
X-Received: by 2002:a17:902:c195:b0:1dc:3d5:bdcc with SMTP id d21-20020a170902c19500b001dc03d5bdccmr4904067pld.42.1713045927460;
        Sat, 13 Apr 2024 15:05:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 0/7] unused arguments 
Date: Sat, 13 Apr 2024 15:04:01 -0700
Message-ID: <20240413220516.7235-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking at finishing JSON support for TC in all places,
noticed that there was a lot of places with left over unused
arguments.

Stephen Hemminger (7):
  tc/u32: remove FILE argument
  tc/util: remove unused argument from print_tm
  tc/util: remove unused argument from print_action_control
  tc/police: remove unused argument to tc_print_police
  tc/util: remove unused argument from print_tcstats2_attr
  tc/action: remove unused args from tc_print_action
  tc/police: remove unused prototype police_print_xstats

 tc/f_basic.c      |  4 ++--
 tc/f_bpf.c        |  4 ++--
 tc/f_cgroup.c     |  4 ++--
 tc/f_flow.c       |  4 ++--
 tc/f_flower.c     |  2 +-
 tc/f_fw.c         |  4 ++--
 tc/f_matchall.c   |  2 +-
 tc/f_route.c      |  4 ++--
 tc/f_u32.c        | 18 +++++++++---------
 tc/m_action.c     | 30 ++++++++++++++++--------------
 tc/m_bpf.c        |  4 ++--
 tc/m_connmark.c   |  4 ++--
 tc/m_csum.c       |  4 ++--
 tc/m_ct.c         |  4 ++--
 tc/m_ctinfo.c     |  4 ++--
 tc/m_gact.c       |  6 +++---
 tc/m_gate.c       |  4 ++--
 tc/m_ife.c        |  4 ++--
 tc/m_mirred.c     |  4 ++--
 tc/m_mpls.c       |  4 ++--
 tc/m_nat.c        |  4 ++--
 tc/m_pedit.c      |  4 ++--
 tc/m_police.c     | 12 ++++++------
 tc/m_sample.c     |  4 ++--
 tc/m_simple.c     |  2 +-
 tc/m_skbedit.c    |  4 ++--
 tc/m_skbmod.c     |  4 ++--
 tc/m_tunnel_key.c |  4 ++--
 tc/m_vlan.c       |  4 ++--
 tc/tc_util.c      | 10 ++++------
 tc/tc_util.h      | 13 +++++--------
 31 files changed, 90 insertions(+), 93 deletions(-)

-- 
2.43.0


