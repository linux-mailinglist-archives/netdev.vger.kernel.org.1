Return-Path: <netdev+bounces-241284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A450C82526
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6194C347481
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98485326948;
	Mon, 24 Nov 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u41suBvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E67325483
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013468; cv=none; b=IYXZvwZdFLcE0BEZtbfYs7XoYGaGQxlXvZtxi0QqBzykotFo2nsfDDdaEHuFsghnEVynKPxI64yGbXSkVphnjSVdyMkyFECsXLtKW1rIN5Spdamvsl2bqFwx64AAi9jxta3OVZEUJ15+avp4KCgZ8lQKpeQvnVfbvy1D290Lmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013468; c=relaxed/simple;
	bh=TD+wCKKpqd/dsXbwT4zcdVvaSIweiwDw5/Z+t47jI8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PDIA04gcGeyKnDGxBPMSHfHXw9yQfBGRYcHO12eU9k5sj+jUs0cPnWKln2YbDye+qBCUOY1brqWfQOG6yw4CZMLHrgSF1F47fKfNR9xrLlyZRE9XeKzrM2Fb9mUximduJt/U2y0TcAfWJQJAEXqct/dG30OnOrE1VOIBd8VPXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u41suBvm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2958c80fcabso132371065ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764013466; x=1764618266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfHARRd6AEhA0Pn994x6kX3/X5VqAC1lN2ISti89Pp8=;
        b=u41suBvmoRhjFgk7wpTL94cLp2vAWl5APyVdVwwAYrD88oE3p/iruM6pSan0tbacJ0
         8sFKyztfC6mI3dJiWhy8f4pKvS3yYfbP/L7n0t8e8Msa2G/GPEGhkIxYYf3FQEdacOO1
         mAu8ZxgaUjXpKqwaz29NsNO3h+PHsPEOfwcJdD6j9PNaNROGMrOunXWCDYNUuRw/A7OR
         FAGWt/LjYsgdRnHTi0bMQrRKeuoDBBnrYga34aq2XWIrY3/Kif25/OeLSciOO1hT3ssr
         DAVXmWGqu64R7saqTgt4JYs6gFve1iPz+BxC090tLym2WK4jZAHdgmLutH+GleVAW/fH
         V8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764013466; x=1764618266;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfHARRd6AEhA0Pn994x6kX3/X5VqAC1lN2ISti89Pp8=;
        b=AUMN1ZbzXsd/Eh7G1D0loK2axayo4iPzsiMUry9bxfNcWbVr1O1L+QGA67pDe3i6IM
         Mtv/OKZ+KcNLLfqSgc8WtNcqE0jIItDRCkko/RdOTb6ZEQ0JMg9/qKoB9KWqk2/yTmkq
         +vujvCqIwk08ctZ9e112Qf5UMLyEWa8gwQIGt0SxiT4KbTUV3f50SC8+Vp7D10JAjDOn
         6BhXRQOTFy8IM4qofn/KPg15r1YfElUgdJ2Snh3+88GdmaBg55UzYtRci70YNFK1t4lN
         WbEdnaqY/LUzXz/0kct0xesVzFIehiNXzwlj/zuqCB1eGLM55UbqItr8y2uGLDnYw7yJ
         qINQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNC/RoA/rIgqJ3x8PgfLmbj+sxdFSL8Iq1AK4qPM6qdAX2HxrE5pSlXi71AAX3ONfybMkyNcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCxvk7LF12FbVukjLjbXDzNgwU15dfEWZFoqNkCVBlHFBTV9B
	qu4Dulbo3XbN5Qw6uPluTB9nw0RlHHge0Ia9xOL1rhunUu/kLFDvvHscGg6s09YN0f77HeJqtt6
	HJurxKA==
X-Google-Smtp-Source: AGHT+IGsCaKaycf3qBsGfES0pIvfkvOmdUIK64BFuqGFlttvbhSq6HGepuiieWrV2mbkjXgQy4O3wRWa+Xs=
X-Received: from plbiw24.prod.google.com ([2002:a17:903:458:b0:297:e59c:3f8c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b47:b0:295:8662:6a4e
 with SMTP id d9443c01a7336-29b6bf5c8d5mr148476745ad.47.1764013466410; Mon, 24
 Nov 2025 11:44:26 -0800 (PST)
Date: Mon, 24 Nov 2025 19:43:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124194424.86160-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/2] selftest: af_unix: Misc updates.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 add .gitignore under tools/testing/selftests/net/af_unix/.

Patch 2 make so_peek_off.c less flaky.


Kuniyuki Iwashima (2):
  selftest: af_unix: Create its own .gitignore.
  selftest: af_unix: Extend recv() timeout in so_peek_off.c.

 tools/testing/selftests/net/.gitignore            | 8 --------
 tools/testing/selftests/net/af_unix/.gitignore    | 8 ++++++++
 tools/testing/selftests/net/af_unix/so_peek_off.c | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/.gitignore

-- 
2.52.0.460.gd25c4c69ec-goog


