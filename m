Return-Path: <netdev+bounces-89086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D58A96AA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D201F22705
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFF15AD86;
	Thu, 18 Apr 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSy8wycF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A531E489
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433870; cv=none; b=pvtkB+h+il1WytDUwCKSqxxL3dXG7B2xLHWXtB34bWX3sJKBnJNRzLOB7nEKGac1th7uZnfso5sjhtDTzBknNY8rgotumKbE5qYIJpXfyGqFhvW9a0nLeMFXN75QzyfuqZ5q96ukKz7X3ITzwiqhu+b9Q72V4kegHRDR6u38O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433870; c=relaxed/simple;
	bh=fp4jRxzH8kqlloIgDn7+4O/K/Zav4pUPNh2ChFIK3rY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L9ZcQ7j/RTLN/45o3Y+2MykNzNLL+LcrjNZWV1TC/kdGJWO7Bm9aYiW73ZEflYi3yAc6ZUkqlJDJOMqfjqs6Cz4ji8YeXcS5NpCBViccvFb+tXPIpR3QXax81wazIQ0Geg/iM8wmYJglvH5Xsard0IxxQCK2DT0W6mjDYJtvZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSy8wycF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so1392938276.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713433868; x=1714038668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vH8POpnWHSHWBwsCDGxuBIidTHCTE6Y72fU1IODbetc=;
        b=GSy8wycFweRH+aq4aa5K9t4Lnd9qxP1SCWcATxpTPLm5FgXsy2vfK78gYIM/ra9hZq
         Rk+OksjG7BeymjXZwAN7atho4iI3v9j2z6cZ0tpuG0QecQPVuI6hQVDTRbs+FX8ERaMc
         mfNzdDdloojPhwQNrY7C4oTq+PvhZYu+FBrGDJ7uiRSgmfHh+kYB/5am0LHSTzunD7tI
         9ZqSDFrNvdi2WQ49q0xiqvg+4KQj0BXVuaY/HUFSKR+N/NnsYIR+lelYI73xpFQ9kyS4
         8QqFKPl6ZJvpieLpcX80qbo45ufyUi5JF9Uo9tC6p1/8PJZQ0iZiyf8rBl6lSNpWhcwy
         NUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433868; x=1714038668;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vH8POpnWHSHWBwsCDGxuBIidTHCTE6Y72fU1IODbetc=;
        b=QyIwv6j49grYORbCs9Eh1hf48ntWZh89P/vKSK32xzDn+yMRkX7zr0VYX442ouPeen
         xR4BgWIsMGdt/w1hZtLWZyPTvwRglJbeP6WTsa3/bB356UnNuhsYrsc5P4E/TUFJrt3G
         EI4xmRrcNUgErOSUYAWSn2+CTh8PEO0vmhoCeALzQ94E2YJMQdpsljMm7FYeZ+foxVym
         waqQFOs39SR5xRrccqKIjgyHhOWUthwzPWBgFRt1ItexEUQDzSd3Zbjg0nPw0acq6Q1p
         sdcaPXpruhRNbEn6LuildTthO0SRS6moPNkylkFf6s3vP3PD6u4JLZRfWNlD5aY+KWRB
         Z74Q==
X-Gm-Message-State: AOJu0Yw0CtWPI4cVawzc3BhHAFNcdszaMBPrX+cnquoS0RbVyq+mvZ8P
	UcW90pV51jn1mh0fHJeDCCoYp2ZAKh3FB4i8+s1J/3eq8osuG2pp74LmFbvQe3vNyoJx0gFXiii
	X1b/DWMIOQA==
X-Google-Smtp-Source: AGHT+IGahTxr6taT/UnB92aHvUyx7EyuRQSv2SACdHeQt2Lwy75X1IQCWOB6yHe1dblgUPDqXzIt6ItRLipg1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1007:b0:dc7:68b5:4f21 with SMTP
 id w7-20020a056902100700b00dc768b54f21mr595821ybt.9.1713433867839; Thu, 18
 Apr 2024 02:51:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:51:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418095106.3680616-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] neighbour: convert neigh_dump_info() to RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove RTNL requirement for "ip neighbour show" command.

Eric Dumazet (3):
  neighbour: add RCU protection to neigh_tables[]
  neighbour: fix neigh_dump_info() return value
  neighbour: no longer hold RTNL in neigh_dump_info()

 net/core/neighbour.c | 68 +++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


