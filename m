Return-Path: <netdev+bounces-178552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D41A778AF
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A916A15A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9F1F0989;
	Tue,  1 Apr 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEa5jlqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5681E885A;
	Tue,  1 Apr 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502691; cv=none; b=Weu20Zaq0VFHs1775STQ4r+KD/FKH3sf3jwFm4bLHQ57kv3gImxfisfUuhYg2xZheoTk5kuksJXNxfuGlX+1G2vSTQ/loERg0zLaWmgIh5uyIp42/zFKj7Y0vv61nNa5eQ2qWIq38jOGiaL9Ab/Nod/i+I7z+RtAGYULH04QSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502691; c=relaxed/simple;
	bh=5URm45iO5Dva5c5vZE938pEu4oNn53E3yXkACy1GJsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WdEdPkL71QN5h8YuMWwj5vH2W+katQk2RFUDp7pUXexFikj7RnNUt8BJy2E+IfRAdlLJwUZtzlfWlDJYZWZcKIL/AYO8uMqFeUEvBzIkgt8TUHbuk+kGEWZGGNqhdRiPlYrDm2MBbvgctL3df3LKGWdob8u5id5grboRrsNr8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEa5jlqG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so7114476a91.2;
        Tue, 01 Apr 2025 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743502689; x=1744107489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIZ3aaOK44zYE4FOewMRIfLw6B008LnAXYNyC85Qxc0=;
        b=bEa5jlqGL0xZQmJnABteV7JRIOQELjWm6cnKvJUeHI8ZBAaAzjTSJGFH6Qp5rtpS59
         eEBslAdCmsaVeoHlcR86TYX2m9grKp4pJvWFvObIuKpVMZqV7eAN+QsZxDIO6kcjSCwY
         4DEapyC7/ZH5Tj16ifIa2cL50vFJftDFy0VwWfL9KEje0Vs1IOM+U5lJvCCKfLiukngc
         iysVNEyoS6pkOcUbZW6sLRlF33kwVzINRFn6r1phU5nwOpfWlGezxOfSEgm9qmXGo8/P
         na0B6Zidb7g26ZktVkbctc3gngFHFSrgIlEgmDeQAafCalhmchIE+jHghYEm7MeUb6dU
         l43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502689; x=1744107489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIZ3aaOK44zYE4FOewMRIfLw6B008LnAXYNyC85Qxc0=;
        b=CWLqznjx1r/XKpEUkU1c9q1t00j7HAMtVq5MBm1Fl4g1sDA7tY20MkKAiz1poM3id6
         7EnqTUlzAexxHWIQa/2pdzK+lpjFPe+LsUfwhnybBk1bYOyBmPJKZWckJ0fLpmic3wXM
         YYbA1edqgTGQmpFhE9WZNX75mb+BLDE8Bo9Fk6uhYUH9NZYBCAdXgYPCN8qAIQM3xfF5
         IiJkMszNkAyuB36hYzXxIauDH5EHRz7kspD1BCY6DE4uAQ4Mxz+qupagqqy3dL+mHtjz
         JwZjYIiX05T7MF6hWYjV6QvpNG+fNk44zRx/dYUALF/oqs+ktjcjHXQPgXOnA+9Vttca
         cGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjeqk8oSn4TEIQ5RHwCk+qaXczM3B3siBVV1aqu6xW8gkTTQ0SXm+23xffDMXgekuJAC4ieXsytPJE@vger.kernel.org, AJvYcCXWlbbIFH63OTrMBkOhGNgX5fdxPOEbVo0AbrtE4ufQBfzD5L2ty4C06C5VSmWDk7upWci4l/tCnslHPEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wio25MxvTTy2fNugf8K5n/eZiPu3ccQZBGgCkSRjR/7Er2Pl
	jL2itoZ7SrSRNhGXgeg3XF53Gg2HFjjlcLXINS4vYwFDVSwb0TG8KvDMHvrB
X-Gm-Gg: ASbGncsgt/L3x4x9+Hn79gFw1t3zCAAoVrJJh0AkpGbHyd9LOq8ZJliWg305iT+8+H0
	cvhlZIrEnWBDMBs5R6lvUd0Uxe3JbjIpEsgrTirYqUD4ib2JLSiaR7r0F7yuIGcE8vwm9vHC6dD
	L1Fq++JdX3Koc3FdO5SSMp8qz6OFWB9R4Wgnd5DpwvLyG1i7a/ItN6AmpGl/cCrgsgVcUr4Qc71
	A35qU4sFWIWk9g3I5+HN0kHIZK/p2aBgf913JGTxf+NIg2xEAtVMbc/ci/eDWQltXkVGrVY9MGR
	dyQ2MjegmvTQT+3xOunxhRTM5Q/lzOEJqoNVvWVB+xRPxpaVLOLOBQw0E/vOS9pBavNo11kMwLb
	fUQc=
X-Google-Smtp-Source: AGHT+IFnPKCc9XQIbSujsDw5VVE06q5nJCsm7Hu3gBV9iap9A/VDBbz1ulnF74a0u1j5CFLLrdySVQ==
X-Received: by 2002:a17:90b:3a81:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-3053214bcdcmr19200369a91.27.1743502689074;
        Tue, 01 Apr 2025 03:18:09 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f8badsm84595835ad.246.2025.04.01.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:18:08 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luying1 <luying1@xiaomi.com>
Subject: [PATCH v1 0/1] usbnet:fix NPE during rx_complete
Date: Tue,  1 Apr 2025 18:18:00 +0800
Message-ID: <cover.1743497376.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: luying1 <luying1@xiaomi.com>

The patchset fix the issue caused by the following modifications:
commit 04e906839a053f092ef53f4fb2d610983412b904
(usbnet: fix cyclical race on disconnect with work queue)

The issue:
The usb_submit_urb function lacks a usbnet_going_away validation,
whereas __usbnet_queue_skb includes this check. This inconsistency
creates a race condition where: A URB request may succeed, but
the corresponding SKB data fails to be queued.

Subsequent processes (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer dereference (Kernel Panic).

Fix issue:
adding the usbnet_going_away check in usb_submit_urb to synchronize the validation logic.


luying1 (1):
  usbnet:fix NPE during rx_complete

 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.40.1


