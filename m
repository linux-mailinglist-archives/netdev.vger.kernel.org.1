Return-Path: <netdev+bounces-65500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7F83AD6F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E23D1C21275
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF567A729;
	Wed, 24 Jan 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mht1A1+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CF17C67
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110504; cv=none; b=JowiiRvtifOSkeIsiwJ95Vrdrhdbos+1DSJc6+CXW4Fcj6rZ8J+EQ8pRUeebsgxpIiRnP7RaNlyURLcPDbUX389JrN7NXIXaSfdAw9RZDk7FF6l8kvlzhoJ3aMpMp2j7PELzoT4+R47fZYwKJbqdPpsj0QTMdvTxRFWM3dOtI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110504; c=relaxed/simple;
	bh=e1gmL1XNCzaWK8GEwCVIk9ts7TUvPrI3ol3v4rmO/+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMaCOCLUID8Z3MrYcAaaUj896t4w34hW7YLDUwsVqpsK5t8tqaG8dK5XZZxIeB8tCvmkiK+B4ij5jt7biqo+ZcZ9E2X9uKNGWHQDDd83Eu0PqKyx8nEKInR/oKgeyZfM9eQtqeWqOk8i/WYqptLnjZkcZCf4mNSwjUD67LYCrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mht1A1+y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71e24845aso33177105ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706110501; x=1706715301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUCpT1x5YSBfEAWia4LrOlYIR760jEAYw9MCeCt7RGU=;
        b=mht1A1+yTlloNnNc1qGUqEFn7I5Wy1j3ZEINYfcdDoek92SeXSPVK77DpWuPYwFKLA
         FRjA73T6DXlztGjYS3d0BVlgSmbDPmUTH6/9+UYu1pT5D/DKLLE/3v5uuG0fl6HUefUW
         2Jg1b+vny/eextaJ3gp93xjDr1DXdTSOKP4KL0hBqL4IkNvYJ61tMv4Sy4wokfFPVgn5
         UUe9kI6kiS1Y+aUjQQrPz+Ygq/NRfNIBmJh73VNd6WlhY/qL4cAh0vyq+mss94v971Mb
         Cooc7RvmHYR0Mrn7LbcTAslFx4ck7OX7Pb9/RznJLQfXwMeNCZADaJvT8co5r2nxUTlJ
         xdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110502; x=1706715302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUCpT1x5YSBfEAWia4LrOlYIR760jEAYw9MCeCt7RGU=;
        b=BGUDITga5MbLg7VN5iC9/TnhP1znQ+pMSeRXyYaiueE5Jp2YpKhdcJhddMw68ByqCo
         BhFZME0zeF/+u7VTi53WM0eIkwrJGg+hTK6+mgTDIJoxmApQtdN9H4UDJ/HNDiWDE9l7
         9YalMWJR9IOk/1Dt6CcUW/yPZcQ92mab1KycUEJohuzv+IM6Fl8+GFf9y7xaWjuWSg/q
         tqLq3Fr73WpkbSJmRZgYjBLVft9HC7CgBDoVvNMauLDJONFXdR6qCsNHSMAprQzQjoZY
         GoBXvJ1ClDx1/L5sUFvbNIzgSrQuHQ2DFISVnOE56IzPsDvrchOFmMyLqdYzs/38HBCf
         HEag==
X-Gm-Message-State: AOJu0Yw2O//5rUfdZ95ebVxaiXW1bqrwAr08tNoY5LeM8L/Fy/ke1UqM
	BBJFHl0dy+chzOyq7CTOcLhKdQjKuT7h/ijTKqTEfjaFc2dtY/NfD7eEnVf81LOnzzTP5oD78XA
	=
X-Google-Smtp-Source: AGHT+IEVJMIXjYvSLYbkrNYredN3g6IiEYMx6kQYhbbXNooItfr6uAwTnZtWKjXV28q7/dYN02C8+w==
X-Received: by 2002:a17:902:e5d1:b0:1d6:eb7e:3fef with SMTP id u17-20020a170902e5d100b001d6eb7e3fefmr977999plf.114.1706110501667;
        Wed, 24 Jan 2024 07:35:01 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c1:7b01:4fb3:24d0:ad57:53c9])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001d7284b9461sm7824837plb.128.2024.01.24.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:35:01 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com,
	jhs@mojatatu.com,
	kernel@mojatatu.com
Subject: [PATCH iproute2-next 0/2] tc: add NLM_F_ECHO support for actions and filters
Date: Wed, 24 Jan 2024 12:34:54 -0300
Message-ID: <20240124153456.117048-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuing on what Hangbin Liu started [1], this patch set adds support for
the NLM_F_ECHO flag for tc actions and filters. For qdiscs it will require
some kernel surgery, and we'll send it soon after this surgery is merged.

When user space configures the kernel with netlink messages, it can set
NLM_F_ECHO flag to request the kernel to send the applied configuration
back to the caller. This allows user space to receive back configuration
information that is populated by the kernel. Often because there are
parameters that can only be set by the kernel which become visible with the
echo, or because user space lets the kernel choose a default value.

To illustrate a use case where the kernel will give us a default value,
the example below shows the user not specifying the action index:

    tc -echo actions add action mirred egress mirror dev lo
  
    total acts 0
    Added action
          action order 1: mirred (Egress Mirror to device lo) pipe
          index 1 ref 1 bind 0
          not_in_hw

Note that the echoed response indicates that the kernel gave us a value
of index 1

[1] https://lore.kernel.org/netdev/20220916033428.400131-2-liuhangbin@gmail.com/

Victor Nogueira (2):
  tc: add NLM_F_ECHO support for actions
  tc: Add NLM_F_ECHO support for filters

 man/man8/tc.8  |  6 +++++-
 tc/m_action.c  | 25 ++++++++++++++++++++++---
 tc/tc.c        |  6 +++++-
 tc/tc_filter.c |  8 +++++++-
 4 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.25.1


