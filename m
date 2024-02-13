Return-Path: <netdev+bounces-71186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A636F85290A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97D91C23294
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4114A96;
	Tue, 13 Feb 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsRab5lj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA900179AC
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805989; cv=none; b=ZBQqcVGHSill2LxHNuoGWqSML8obPHbhUX9q/1f7sc+aIkpZEBe8kf+fglcR7Pv1CJzZ9X3YUb2DT1GPiUbuQCWp8ExeKTDr+bMTwb68rd2JDvkVHhfjUXXdkJxhEfNNm4oaSiNSTHi9QVcRGv2Lvj7hxtGcPmmbP3aP/MjJUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805989; c=relaxed/simple;
	bh=Cp/AN9/HGGXoAPiTYJogFYMkfFcAC2rlQPrKzKguFQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i+vyMLniDrtTDrvMDwXdloC+eKXdQXmcNgvfOV+L4FAY6k1nY129CBtfhnqRa/lHEcweAnavnsjnUrwmkXRR7JFaJX1+JLBo2mXmRh62Nb0aypsTx13EAdgNJBVRLV2yByxqQftgCiphVDY3wzuPvmUF3prKuLP9Q+FgaMbyBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsRab5lj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so4779370276.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805986; x=1708410786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wQ7ycFTq+UkWN04lv4Q9eRhEGXWS4c+3KCfqAqIE6M=;
        b=CsRab5ljRHW4haOKGBDwlqYZ6ThxqHi/ZZqRTq//xhn9U2R3fkIBYisCQmA0Zp8x8c
         ZFA7W5G2y37aC4G9QUgTD5rFk7WlFaQNVOtG0kcQKkVnECBCQCPlSNHrd8hV6bjXgdpO
         ZSTcY41l2PnLFAVpLCd01sjuskyDUrojxFx/QcZw5Es1cCDp8uzXApFigHibkhcW5kkx
         cHoW+Xdt18LOP02mjGhTfoLzyfT8Tv42lVQn9bY8x5D4ZP/hCH4mpuTnNGqRt38NxRc2
         ifXGt1M9oxl/qdUH0Avm4izrgBl1zB0j9wDMW6tiDCaNggMl/JC19g3/IKA61xM3A0Ey
         voHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805986; x=1708410786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wQ7ycFTq+UkWN04lv4Q9eRhEGXWS4c+3KCfqAqIE6M=;
        b=RhehUzc779rDELCepZ1m6hHUXbogYVZ7EUR9XVk2UP1OKB1nVNaBXkD1lpGrrMwUSK
         Y+3GMjSK5rBKpUHQbLED1VeQGo/uSl48NaW5mIPVIosAhdCBx33/+8MQGV4NadFOiodl
         msyOAEtYkM8JzG8q3prHG5qttgOkakr6I5VPUe0y+9+xYD9Od1C54EWf5LftEdxbV2hi
         3h5gJt20aLo9R+s81XjrXA3ewYXlpD59uK03YONUY/b+rPfdzmpErsvK/JVwsKxSvgF9
         HWJ7ZoaVVbz762MnIwYTyRqE/XviVl/0HyWam+U2fYqtedkJgRMOCuybNiADOerZZ4+a
         0VRA==
X-Gm-Message-State: AOJu0Yw8nj95iuPC50fBWnuGMmH3mjDo4CmUoaddELQoI0KvwGbdg1AC
	r6GOQDgFPqJLbwUMSOd+ZlkxSrAOnvQU3/501VQP0U6EJZMFUONlicmXmdvVlmwflrqFv+aM9N7
	dtDG+OO+CEw==
X-Google-Smtp-Source: AGHT+IHcW4FaFhITQCalzqcjFC6r43dOqyiKSRsxy6pmiXEVZ+/RpYKD5hEb8zoKj9e2I+B9GH3bhyYPvaBPbA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1d2:b0:dcc:6bf0:2eb6 with SMTP
 id u18-20020a05690201d200b00dcc6bf02eb6mr36915ybh.6.1707805986655; Mon, 12
 Feb 2024 22:33:06 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:43 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-12-edumazet@google.com>
Subject: [PATCH v4 net-next 11/13] net: remove dev_base_lock from do_setlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We hold RTNL here, and dev->link_mode readers already
are using READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 16634c6b1f2b9c0d818bb757c8428039c3f3320f..c2e3d8db8b013585dea62d8fbb0728a85ccac952 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2979,11 +2979,9 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_LINKMODE]) {
 		unsigned char value = nla_get_u8(tb[IFLA_LINKMODE]);
 
-		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
 		WRITE_ONCE(dev->link_mode, value);
-		write_unlock(&dev_base_lock);
 	}
 
 	if (tb[IFLA_VFINFO_LIST]) {
-- 
2.43.0.687.g38aa6559b0-goog


