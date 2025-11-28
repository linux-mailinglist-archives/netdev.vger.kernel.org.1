Return-Path: <netdev+bounces-242574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC41CC922B7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B013AAC8C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E21E7C19;
	Fri, 28 Nov 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co7jCS2B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F61C84DC
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337571; cv=none; b=YfCNHOx3EqcFT+2SNk+X+XxIVNYbfuOA3Ehp4MGf0juPcBjksovlHEf9rNx5u1gq0GKBZ2ck7EWP8BoKUmRd0KU8nNS6pjEqpr+tBUzeLWfcHkvn5ljwxmGPnINIWQm7TijgBG3J2oSUiao7QAnN/rC2LEA9BfgNDQrthQstzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337571; c=relaxed/simple;
	bh=p0ADxgELml2VPbzCCTU7ZXu2bCx24MiqDSUdinmk0YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BeKFvuj4EpL1Fpy16ssxu2CaXbweHmEEaB1FT/6+Uu/Od3BS6HQfAEvQgZoutu13w/rZXB87xXuRWgpOhRUY/iBa3POS13S/FdrNriB4n3jVc3xWFBHaGbTdcgwvyeNLdgkG6tfHHHfjPjN1IHzUFF0CJWXuCut3SGHfVm2NLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co7jCS2B; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2984dfae043so16789045ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337569; x=1764942369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS0gzAbiofcFysS17aHiM5lNIPZOsMD2u3cRdekkqDw=;
        b=Co7jCS2BAkpq3tSsrMYs9QjuCYFIAy3bZiMdqW94nONQzRBHFej4OxW7ot17US7Fxq
         PNuEed2KCqdqD/rPuc7PgcapRYN9RNkb12HGo0clvvTuIRbJ6Fs9/ptK+yyrYwtE4GOV
         0z11WIojBHdAlxbzkWl4SgpWWEjTPMzvWy5pAcfHWEcrh9L6zJjRP4nbKc4TBrY3tBXC
         K7r9HCFkNqnpGkcRtwFp1EVzkXcgXXEVWY0zgTBBUUwMzPMybbZBfb/ZAE0MaLLuUkV6
         p2xfPqxEKIBhqWfftZHtg20NxmQlSQQMccHspTR9rjyQuoDyJQJ+NOlyOsJbPkJT62Nn
         J/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337569; x=1764942369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS0gzAbiofcFysS17aHiM5lNIPZOsMD2u3cRdekkqDw=;
        b=aV31/8j5d8VGlLhh+SNf2fdrEg96Pkt+Z3wYPMVb8xKA7K5I6asDINM02hCfvWCh40
         s6mWqsY/q9ViioFqpR1FrPQzcC95LMqz2KuFPdrnoG2GbkVhjk3fG/qNfXbj7bWgf3Cn
         8FYlXkT0bO+xuWp+DYR+bFD/+WZBZl7S8kbGhiJSPvWwRmk0yPaUyiE4E2YwSiHK2L31
         AatoRWapeYWah6NL6sokdLy3VSRWEH1XIdvTyH++SVyshtnmNNuhsIuvbBgoWe8JScW2
         tbnB8EQeBut8vKaDa6LhK86+HYaGsF8WhvRpviMprD9H0okpstRurZXI6P/NXZQNTxVu
         dWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4xzFNmU3xeXoCN0l+NOzupPm3blS5pxm5+AWYUKPGwa1BPcRbJ/rAdq9f3vgP6e89+xYR/Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvHDwgZ0MZvs8M8sC/qySM/puawxVCSdPleqrE6JfWli30uGw
	se0P8UubjLLisv3jps8JvXYD9OhqnNsRH06S23LVa1KpRrKzcIiaJz9v
X-Gm-Gg: ASbGnctQHHOhTM2qrhWlD512+uGLqOYpYY6U9dBgpqGeLX/o+YJGnWDlp5jRREwy++o
	b8jOrvekIhjvvLkjb4t5+ipspVqJIzi1Xfr7vY/FOPHiqbMnVy7+zwaSK/j0+1izn+ISyxCI3Yj
	UTYpZ3MjNOU+d5Hl42RGQEkojw1jQ1wFm4g6Mw8bzYto3lbiYoc5IGLX4O201N5/KaLMLO3OYF/
	VTUupVsH0LTeegH37GiboE3jg8niQOtFedUuwdg/kf7LAaflMP+dHZfa3YOWSjSPBnxA3uTcYjQ
	9yWSK4MBKTWU8ww0A/OmOfrkwDmLtBqjhquM7/FlhGbcaO8Z4wyYk+6rES21k2x01tiJhTY2vy8
	kdCqB6Rh64NBTT9vsw/2LwvwEG2uW4hOE3TVyXRaN4E5rpVNJ6K94HpvzOL0AL1ZZanR+rIGQya
	pmXd8onvHOcdn9dlWzZwy4WC++JX0CxW1yaRZemC6kLyMy1tQ1
X-Google-Smtp-Source: AGHT+IGgctN9Wd6iSyVed/+REI0U1Vd3bPRvJ8n1hCHIDY86Z3XYTmOAY81YE+Nggw5+MGqOpJ/Hjg==
X-Received: by 2002:a17:903:98d:b0:294:f1fa:9097 with SMTP id d9443c01a7336-29b6c571ba4mr304092995ad.34.1764337568765;
        Fri, 28 Nov 2025 05:46:08 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:08 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/3] xsk: introduce atomic for cq in generic path
Date: Fri, 28 Nov 2025 21:45:58 +0800
Message-Id: <20251128134601.54678-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series tries to replace cq_cached_prod_lock spin lock with atomic
operations to get better performance.

---
v3
Link: https://lore.kernel.org/all/20251125085431.4039-1-kerneljasonxing@gmail.com/
1. fix one race issue that cannot be resolved by simple seperated atomic
operations. So this revision only updates patch [2/3] and tries to use
try_cmpxchg method to avoid that problem. (paolo)
2. update commit log accordingly.

V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review


Jason Xing (3):
  xsk: add atomic cached_prod for copy mode
  xsk: use atomic operations around cached_prod for copy mode
  xsk: remove spin lock protection of cached_prod

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 23 +++++------------------
 net/xdp/xsk_buff_pool.c     |  1 -
 net/xdp/xsk_queue.h         | 23 +++++++++++++++++------
 4 files changed, 22 insertions(+), 30 deletions(-)

-- 
2.41.3


