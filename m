Return-Path: <netdev+bounces-237024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1389C43A7C
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 10:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D11F54E1D88
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E8265298;
	Sun,  9 Nov 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neoiCzsx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72B34D3AA
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679629; cv=none; b=hsMQlIjeCNrehmme1IeZ37ac6UhTpiS5x8Ov2QB4dZSZNpNIQGCycD/olJ5XgAIM2xr9J4OnuEOyQwO290im62DtuvbMsmMnMUi5pu2/qfSj95t1j7zQpsj9tJ4tXt7QWgNHOHGg9XcYWRxJN0zu5HaPEsGjz/S+ctdYtjveDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679629; c=relaxed/simple;
	bh=wiudvA7pEvupsgjtg50l57If4OL8tnDZaUwr1RVfrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7HkFHmrcttLcL+spl8EXYAhUIkIuajdYonLsoDt4iDRC7y3eBcbE6gsFAFiMJ801iC7uDN72/2kFfLRgnC+MPkjF/znyubSiKjz+KhGWw0tVDQFM634FGGnT2r/Et8r6xgB2iji58D4c3lMy8HmnZrBfLSBHb5bvD3Uuxmrdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neoiCzsx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436b2dbff6so241534a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762679628; x=1763284428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfv02LK+Y+jS1NwaBEcJvt0Ah+/vQd/alXWF2KE36LM=;
        b=neoiCzsxJnSO/cbKr+Epjmj5XB0Om/sF7q7fWC4we/d3kdylSJmCMyYZfwoGVIAsrJ
         TVY7lz3RBiYIQ+9WywYY6ZVlfu1eq1He5zA99sQOcS3DzxhiQdjtbuUadybjG0fwXyaI
         xjVIKGnrtkOKV12Me1Bz0fiYEF0K9h6Z4lBoTRkQSoMJm1nWpjZESnGTqHSrn5wQXiVZ
         TBbJwt1GwnNFXnan/80IcQfJtWar3zyUo37lKP0wOajsTPErnriufwXNHCytbGw959vL
         GJAeZALYtgEeT4thxpiXFamFDRnN0D+OHfosQB57HYoKuv/qLLhD8JVwBH1QL2zLjzBG
         rwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679628; x=1763284428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfv02LK+Y+jS1NwaBEcJvt0Ah+/vQd/alXWF2KE36LM=;
        b=Syc5i/pV4eJ8N9wYnQYcjUg9tN4vbrD9uSsNosBLqIWVhVI9OJyfjY/UfvFqPpB8RW
         pVvxPmrhBIlMNE58qnsJv8sHg2RQ+6MIQY0GiG5mxBqncmXwRiK7d0B4NWsV8M2Ab7Ba
         PZDMXqEM69V9MAMjyqQ8bQU7KhDCkfwXnZ1j8XgPQRXMwzOlihmcGXS4M2PKbARzihU4
         emE04tiMWUrUol+5mBXikn8qkSxJbmRpNH/v4maqNAQcsxVp0k+2VLohE6vWUkXgf4OL
         atYQqfXHLR2Nd1BvK+czZzDWupdYXdC2Yom7DK1TOJlRJS+4pOIcRBYvgWzLyccabJal
         1wEA==
X-Forwarded-Encrypted: i=1; AJvYcCU6yd6kCvX9IqWFDR50Zbd91eHAHmFRJV52ycu5uxy13rjhhz2iQO/pReO4e+henunRFBjMbX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFVZ3KsuU4TW76ELYjq4qIJiMPmrEw1m50V2tcPTfiwGQrfs2
	5hOqNHCUqKouzTuNBeJs7emKxM9JYq26kFwtKi4w67JldzYZcedS+4VL
X-Gm-Gg: ASbGnct+K3pBFD56YIDENRYxlMkStLf1h0xBuvGH2LT7M2xByNMuq3EKbTzzhrCo9Yy
	MaKbEYcEOBQlzmdc/eO/vXczTVy1bpvPGqrUGwTlht+ap5lDzp2ioO7hy+aoAGNveOZqZyPmFkh
	YQIhNnQGqAU0B3COhQKtU2DFvD3BSAWRBIo+AU1IDVG/jL0XxyE5hcRRFHtwaOY5nf/+w+Ib6gq
	GvwB38q1dad3hPAbrr6WWx+HB7qNOQ5JwYnY9/osVPWPG+kNlOAP1kTaSGUT41SVKJnKr1FJuo4
	ubFhE5+VUNbWTnVFzsx9txBnV3aZulqASrMOqTLjoIKxFQOZfU4/PAHD+9/Hz6uyxssA52owV4n
	og1eIPuJNCLeV5wmMSQ4BncYOkMhan2tAQQff/lcQaqpTV/HcbLYTDM3vDYF4roYn3AawL9b4go
	OGuGqt2sVm40/lMLmieJ2RVKIBN9tW9SovcNyFtwbJlGfKHjodPSZ4wZBAqkZwGds=
X-Google-Smtp-Source: AGHT+IGtQ5khg9zdirBZQdIqj8QNg8agF4U9wpNQYbN3h699jYCrALiCVhoVI+BJEY9hUf8pP7qRlw==
X-Received: by 2002:a17:902:c408:b0:295:586a:764f with SMTP id d9443c01a7336-297e5743fd5mr33079525ad.11.1762679627635;
        Sun, 09 Nov 2025 01:13:47 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:bc7a:cbdc:303c:21d1:e234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm108974225ad.64.2025.11.09.01.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:13:47 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH v4 net 0/2] net: sched: initialize struct tc_ife to fix kernel-infoleak
Date: Sun,  9 Nov 2025 14:43:34 +0530
Message-ID: <20251109091336.9277-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses the uninitialization of the struct which has
2 bytes of padding. And copying this uninitialized data to userspace
can leak info from kernel memory.

This series ensures all members and padding are cleared prior to
begin copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Changes in v4:
- including net in the subject.
- added the Fixes,closes,tested-by and Reported-by tags for patch(1/2)
- Link to v3: https://lore.kernel.org/lkml/20251106195635.2438-1-vnranganath.20@gmail.com/#t

Changes in v3:
- updated the commit messages and subject.
- corrected the code misisng ";" in v2
- Link to v2: https://lore.kernel.org/r/20251101-infoleak-v2-0-01a501d41c09@gmail.com

Changes in v2:
- removed memset(&t, 0, sizeof(t)) from previous patch.
- added the new patch series to address the issue.
- Link to v1: https://lore.kernel.org/r/20251031-infoleak-v1-1-9f7250ee33aa@gmail.com

Ranganath V N (2):
  net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
  net: sched: act_ife: initialize struct tc_ife to fix KMSAN
    kernel-infoleak

 net/sched/act_connmark.c | 12 +++++++-----
 net/sched/act_ife.c      | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.43.0


