Return-Path: <netdev+bounces-238679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE8C5D829
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB25A354A1C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090273203AE;
	Fri, 14 Nov 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VK2q8djU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD341B87EB
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129210; cv=none; b=jpRxwbEuP1sbFVuEEht2lntRCo/5nKPRn5bdWg2pZso3RO3EUqVH/LJ/TcwWJOsc3LV1OFreD+bP8Tj82nU/edlvhcFWqEXFqyN+o1gLYpzVHQaZP1Cy1IbiJ7NqHuYOzk2zZzasFM8gFRrTNQwh/oC9F4ggYqb6KAPIUAJmQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129210; c=relaxed/simple;
	bh=j0jTXqb4g9SueVfzNVCPGooYjIgL+g6Ur//C/ntwR1I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n0TJzYBBU71UQcwDIlOaURkefg6/13WmsBLxURpuqtQbZVv+LiuOEkFFDJtm5TciY1Y8B3QGhAQRci3SbI2Hza3QxPMUJ2p4/0T0p7TEwgmicI/89hpTq6yBNj4wuTSsiIO7xfPeEmkT3SJO1QYSDxrOoQmXvYdHmQOnyy3/f5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VK2q8djU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8904a9e94ebso461347385a.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763129208; x=1763734008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5DiD/6UQQlkr3+6XA/XK3aUZnLuC1pKX7arVM4EwPo=;
        b=VK2q8djUiYTBF0t/qxfj5zlA6xO79f9L3QwOKi1DLnZ6x9ZHCxVacvVTr7hml56TMi
         tdeMlRUYKpspQnFpHCUJ5Flc0jB+7Z9VMWyfEQTYqzIehYsJ6UCyEngRPMDz8AUixBb2
         vm/VXRrHcZ2DSAbZJF/45LUCA3bjtkHHOf66OHDE4V8nKxTORbskviQIw/TkRLzl/0W3
         L4Ye53j1Gnm5cfTgx9cf7IlAcnvDs3TZTJp7UiXot+ouRdiCAJMERIh1Hp9dh50zkVfr
         /HsavwMv2N/N0F7uOvFc44dDmdQF/4pxGwfIixm8NRuf062IFc++8yIHHIkMU1jk/UNO
         lzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129208; x=1763734008;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5DiD/6UQQlkr3+6XA/XK3aUZnLuC1pKX7arVM4EwPo=;
        b=PZPvZwHIjkAtrEJ4xGv3ROmBTDeRQRZK+TmynYquWUhjynYXmQ4b+BMvoFFQ6HA+ai
         CXFhhQB63oaDeqzHhwSgVY8zRlvFIXj7bE4vrKBetXtityp30FfSCXpXsZ/rHEqSoDrU
         hr3prTsFhjXxRLpQQ5iurClCHQUZ+PAzHzIqp/OwrBkHPNIxW1m5WLTRjgFt4MV6BjI3
         20t6s82roCiWUOxxE/Bx+d8Uz5wwijMUkx8KsxJCeTxU01PxDLTBPA3dpZKyfZzv04Zm
         SRF1rKGbwhqyTUJrnCL0rcSZuifgOtddfVXx6vI6EdvIaAGwR+c+B9/AafGzhYAF40Q7
         6PwA==
X-Forwarded-Encrypted: i=1; AJvYcCW92F7IZegS4Lni+r7lT1l6xNUGkCd7rex+8T3GDw7YMWLZGzroYqWubayh9C0KXvzwO+q7hDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOaHtNWanNS2kWsc+EMZKWLV8Inkr5C2edQtM/a3pkATbd0DL
	bn7+9aHVfWbt/zcSLtr86pJB+4XQ5xiDdkYJaiRWaYOE+kwNoDxMaUIXzoQs7sqJ4KCWJ5uQA9H
	O7j57p4Ed3euF+Q==
X-Google-Smtp-Source: AGHT+IFh+4nCUJuC1Lt1/PJRdEcNRc5RixEjUOu8TI5RPkTL3d+IxwY1C1YRKyw+jW8PjLVk5OFvifGCHalDww==
X-Received: from qkd15.prod.google.com ([2002:a05:620a:a00f:b0:8b2:8123:3e0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3902:b0:8b2:1f50:ca56 with SMTP id af79cd13be357-8b2c31b9d98mr373528285a.68.1763129208098;
 Fri, 14 Nov 2025 06:06:48 -0800 (PST)
Date: Fri, 14 Nov 2025 14:06:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114140646.3817319-1-edumazet@google.com>
Subject: [PATCH 0/2] rbree: inline rb_first() and rb_last()
From: Eric Dumazet <edumazet@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Inline these two small helpers, heavily used in TCP and FQ packet scheduler,
and in many other places.

This reduces kernel text size, and brings an 1.5 % improvement on network
TCP stress test.

Eric Dumazet (2):
  rbtree: inline rb_first()
  rbtree: inline rb_last()

 include/linux/rbtree.h | 32 ++++++++++++++++++++++++++++++--
 lib/rbtree.c           | 29 -----------------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


