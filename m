Return-Path: <netdev+bounces-174930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16EA61668
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 17:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F253419C3D8A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10AD201027;
	Fri, 14 Mar 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbzXk7t9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E318B494;
	Fri, 14 Mar 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970335; cv=none; b=UoZ3rQqP4FgThJ9OpCOc2d4g2FgE+DEa3NN9XqRdKId9LV0SSCbB/WGb6uaFf3JhRWeYwE6B4+R/Ki7hMZpiQVzJ/7TXOdqrCMLdyXjSZUPsSk9Vh7XA8WV646Jn0A2fHfzeTpNBiC3fLcqbAwUsdTkYpt5MpOsD2C0UgCgfXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970335; c=relaxed/simple;
	bh=mUmGdDNy7CflPQgurDgMSe2jxfVMINCSiKslqK4V44Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOvzOzB4rwMGnbmo/66O1iKIdLdndUrD+tcOfTDM8LsbShbl6Rm35qRBMRzE+4z71B/4NKgjBX6REqCcPelaFAIThkzTddMRLSJBQ8A5yz/LdOA8ITT4OXRxfuMxkhsHu8jS6QlQY0RfYgrhftIiVQuodNYvSIlhdPZJFTyv72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbzXk7t9; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86b68e51af4so942498241.1;
        Fri, 14 Mar 2025 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741970333; x=1742575133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZeAtTBWW6NSQAJkyfYhJOSxTlP/7BOudKr/+e8Hc9g=;
        b=IbzXk7t9bjFXknQvRQ03QdU3UcZLt1C4uIXyRuqNOZTC1bDNHOZMuLKv9EvjhnEBIu
         uKVgLlHgBEeGVOAiCwT+u3uPAdU/VvvZDbuoyMqHIUMvdBi+3GOOropdATYNvazNpTV6
         2WtML9+Y54sFxk6emNSRV+TMGUtaLdTEjujdN/KCxfoMpBHdLPeEcaoBpAiPa5oSZSPp
         4WI56JUdWMt48qGXHZNCyfJgdWptMWJvc8X1b72VrPR+KIGBvFv+zEOrjrQQNCNybfV4
         8kEjyH/BBO5fz8AGUmN3dbXCiEvXybbBFrOIM7ce4+wfkH2cDuEOJGgFHihSh507h9of
         0p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970333; x=1742575133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZeAtTBWW6NSQAJkyfYhJOSxTlP/7BOudKr/+e8Hc9g=;
        b=stEuljYx57IgMHIjRBxxiprdFPsRwvRS10Kecn1+pgW6uyA6FAF3DVPbOyKBetJDvm
         qAFtdekqYNyC6zgkVG8Sn1mUbkQ+EiCpddHpZ7IQ0FEPdmbPWxGfyGUZpuher5+rWKt2
         TrVzZGn7lOLiuK85DljR0pQgFBCSJXpIjpVOJB3YhAXp1rY8OjjbDZGYNyQm4fJUFjjR
         zaUfBkPjsRlhTqIIK3MvxS2dh/22PzUNJKT5HWAt+9vFnu192oIRs+wxhhQLN5hWqRTJ
         3loMejAguBf3cYMpZ3/n5YdkXKC9KfSGfKPlCXjWKOZ+LGqFrGs5sbK/8U5MIpiRIoSW
         /5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX00aBjyzAYkBTr4aYVud6BbaZmCgFuTl4Qw3582vQGRYPkpdc1KWx09p/0OPV/mnXLdxpzVNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAU9r6FDmO87moSWEdJCJrhXrCn3U0i88WnQJ0W+B9Rrg5FJUI
	W1zTQ0FCWReqIkbJogYF5UXo4sdZZb2S8pUTUc88S14ugeSv73wA
X-Gm-Gg: ASbGncudm23FZ66yhrymrvbmRnEsy/FOSikClu+GIfKSJ5EoV7YlfRwnbKCGeY221Xo
	GNthnQj7KykJjp+pNTWhGHiEAFRA39HCCNof9tjrXbavnm+bswwIKUc+BKJlaTg3v1nQvYin+S9
	6qmk0iacR6EmoLICpbJ7w0cIrBg7MqyvIrJW+zdSrW1caqAiQiJ6S0+YX6AD/r8n8tiUu9SRYat
	HCSmjqtu+QPG1vSLVuocN6/njpkJ2MtUiGfB4T4SLKwTSe4AjVtatomfx0xuKJgP4TLodeNOPi2
	tQe7+0thEX/jaLX8lJehpoRj7SHL0/Clx8Uaj0Oo0BpQ1LX97qMoKec/PEafc65Uu3zL+FFXAXo
	Ze0/Xk6xG4iWWSXjTYe5MuTRo
X-Google-Smtp-Source: AGHT+IEehblAXKmi+T0Pq/D31/D3w5D4vNCyox/3GOl11p1JP0+j1HjqShy4WUtYsrzANc9fikjs8A==
X-Received: by 2002:a05:6102:549e:b0:4c1:a448:ac7d with SMTP id ada2fe7eead31-4c383145426mr2371110137.10.1741970332843;
        Fri, 14 Mar 2025 09:38:52 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90d68c61sm616851241.3.2025.03.14.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:38:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-03-14
Date: Fri, 14 Mar 2025 12:38:47 -0400
Message-ID: <20250314163847.110069-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2409fa66e29a2c09f26ad320735fbdfbb74420da:

  Merge tag 'nf-25-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-13 15:07:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-03-14

for you to fetch changes up to f6685a96c8c8a07e260e39bac86d4163cfb38a4d:

  Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters (2025-03-13 16:43:39 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_event: Fix connection regression between LE and non-LE adapters
 - Fix error code in chan_alloc_skb_cb()

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters

Dan Carpenter (1):
      Bluetooth: Fix error code in chan_alloc_skb_cb()

 include/net/bluetooth/hci.h | 2 +-
 net/bluetooth/6lowpan.c     | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

