Return-Path: <netdev+bounces-198186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C6CADB8BF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82373A713B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA4288C04;
	Mon, 16 Jun 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM3WVkw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F615278E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098116; cv=none; b=l3JOLIaLP6H6uvzJRwKv+cBZgjynqBBzqYDbKpCCRfl/b1rgWCthrwWPjRoDA2iqyuUDW3heyHrglCDoK22iOuVmx1IMLyxuENoFZa0JtrjwddCZaFY650Uvonv4wtihraCV0gkK4eBMGMGqCwAdcecGyk5NIgZD5oyjpDGZ2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098116; c=relaxed/simple;
	bh=kuQF5p0YdaMt3LLtb0L5rOzhD4W1ySPwMt99mvfYoV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaqgGdfxT+n+ldQ/3EgiIrHQYpegF2L1QokhJaNXBt4ZALJ+IpD0490WRVOeFqVIj5ie/n7m3PSVScQ8hcSY7KeardhPcZFGKLcQ5m4M106L8gx95Qgtx3y3C5P58cuA4n9BClcQNMn71JHuPyGrpN7MtCeEn7OIA6aoY/BaRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM3WVkw8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234d3261631so32683305ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750098114; x=1750702914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LN12iFnxspZL80SiEWecRwrSN82RoiW4P1SpjIj0aTE=;
        b=kM3WVkw8SfvEUWhAuOOT6RZuLnOA0azHECigmmnm+Cgp17FmaXf7vyoKfHm7mObwbu
         DRhBN/iKYTRJwrThGBNjfKxQ6epdE0jkknSSLZ5gEK6g7hFMYAU8Gel0wZAp3Y07dLVN
         bnB0SPI5cX3tCYr+INnR4DJLU7kF4OBODzyaUPmcbBcY6XeqaRd4u72PchaaHT0xmicx
         S22RjO2FpVARwIh+gZ5F6sgTr7klJNowHxNxXOfIwe+WLDDDPn7Xk7nyjYfKomhgIe81
         7IMptGX7UGkW8TzbGoKjbHtLrWSA3ZAypdi+feFQt7AdyLwTLvZxPWVNW7M1/Fa5gjJo
         JXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750098114; x=1750702914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN12iFnxspZL80SiEWecRwrSN82RoiW4P1SpjIj0aTE=;
        b=ag9d41ICzNrcMZXMw0hed5MUAqF9J9BoPGLPRYuaGj8priqKVrxXKjJdDLYTzf2yb8
         UPgPtJcmHDq2gwiM4GGt6eavVaMRGdgMhTCXC3GL7ihFhXeNvYnGpRGhPGFHGb0fGmtR
         uAyu/MMVdtDProCxmZ7OXDggEt1R22zs6BxOPn7YcmNhABC7v/d6sXvqYWSV57DrUqHR
         f1f+dR8bBskveuXEyT3Qs2uyUIh0X91r7FPOvc9Z+oK9gVmNOgGn1lCh3IUdg8P+UxCY
         p5vswha7krwYAhpSGIIJhPU+Y5EOz/cJBSi00lwRpd8msY2XHLZ97f/4l3YPN1ZWlxM5
         WHaA==
X-Forwarded-Encrypted: i=1; AJvYcCXkp1F/jL1e6+TlG7wR2RFD+bvczvqU8lHU1sZwrP7YWqJZBZk5j3G7b/jGiypdOPqlo3SjTgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZrpy064Zmm3577HtJudpcfX0gCUvtGAnPqdG/JPKXBl6t0ex
	Nupy9xFKnRNeG/knYlVwz6A1984B3u53UsMet5O+yCMIZ87EJHoekkVtED/D/ETKYP2W
X-Gm-Gg: ASbGncu6HV40wrI0FQxA95GxSu/XnzfREto++KR2gadaakbTb1hP3B1wUHlm9Li7mHp
	YdiGLPqVfodsR0gwQWflJO1pcT1cZUAN01ATQhst59tSJ8LWWSHA//ruirArG8HmE482tTjDFyI
	v20fsDSAyIr9MxcV+nxmH2FBB4899y4vnkGlukxNUiQsJFhrE3h+rKcRX7tc8zWCXr8psbs3OMD
	T9boe+BVGn81U2se+CcCphfh9ARtuqz0PO96Xv183qd0xhwzdWT4Feu/gx6uaZg5PUyKv2pA2WO
	W9zFIwycMOkFso7UUpzmqQOR1fUpckDXQQGfL48=
X-Google-Smtp-Source: AGHT+IGE/VWjVVcrf8qyTDape1w9Mo07xd/jaTDjJdvF1Zz+WAx6xo9Z+43CDXeOBtruIGQmwrqhag==
X-Received: by 2002:a17:903:320b:b0:235:f45f:ed2b with SMTP id d9443c01a7336-2366affc3fdmr164622075ad.1.1750098114283;
        Mon, 16 Jun 2025 11:21:54 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe169205dsm7243188a12.74.2025.06.16.11.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:21:53 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net
Subject: [PATCH v2 net 0/2] atm: Fix uninit and mem accounting leak in vcc_sendmsg().
Date: Mon, 16 Jun 2025 11:21:13 -0700
Message-ID: <20250616182147.963333-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Patch 1 fixes uninit issue reported by KMSAN, and patch 2 fixes
another issue found by Simon Horman during review for v1 patch.


Changes:
  v2:
    * Add patch 2
    * Patch 1: reuse "done:" label

  v1: https://lore.kernel.org/netdev/20250613055700.415596-1-kuni1840@gmail.com/


Kuniyuki Iwashima (2):
  atm: atmtcp: Free invalid length skb in atmtcp_c_send().
  atm: Revert atm_account_tx() if copy_from_iter_full() fails.

 drivers/atm/atmtcp.c   | 4 +++-
 include/linux/atmdev.h | 6 ++++++
 net/atm/common.c       | 1 +
 net/atm/raw.c          | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.49.0


