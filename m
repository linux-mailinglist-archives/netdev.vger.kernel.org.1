Return-Path: <netdev+bounces-234825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687AC27B42
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E04404110
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C52D47F1;
	Sat,  1 Nov 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLcbzdl9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5A2D23A3
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990486; cv=none; b=sjhOqmLF7lZMKLtC+f9KfkyGeF1jQeO0k6S9Rc9Yk5ScYqq82XwixJsYyrGUQR9iBStoYYpqwTG+w9F+9V28YZeRFCDj//yIimvv3xWHvXeRlLjnH3SjVHrh7Zr41mFDsSMWO2riN5yNETg6LWHoUJZzAyO5KsP9a34XAtpDztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990486; c=relaxed/simple;
	bh=3OG2wiKH22RCfvC+iceoRBKIWpDNYuCgxZ/0fv2vRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+J7B0rOS0CD9bbHivef8XUuYN5YL08iL1vBZmK7e5Dxz9J4/QEg9PjXmrAML35rZZDO36rMQdTyPhR0U3pxIga8tWa3ia2viEHL/E7ISFPIUHiDem/lTxa/8hTL4bryYZsNGrN0vy6QmSjUGtZ4MivKyRlQ3qgd1B5ZTRP1Gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLcbzdl9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso2854659b3a.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990483; x=1762595283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WH5O/8nAx5rVFTEi7/lXcZZ45r+c3Q9ZyuJj8snlwgs=;
        b=nLcbzdl9dR0X3krcX6dwvdW2QSYs+p3GtfBlu3l2dEIINpLVz700FoeUkEvGq/kuiM
         mk6ObxRygf8sG5V1QlH6k4Mcyvz1+hqXbgoHbLL4iSUDAsJBd3NezgbCsDNRfCO6vUam
         1gHzIn8UzOm80YSQ2UudACKO0iPJL0qltaCF35gEgjPA66GkaAwnF090QE3HHc4Owide
         rhNUk0bgSFS4z5qXDpLw4pfbqO8zWLbrTY+tZQcMttGe/jyLRHd6wHn35gMD7BsGnaXY
         hx9lfmc3PXqDRYEMexP11+x7I75c8HWOUAxYihyjjhEjoH65atsT2Ncpb+Gyhn8a9zmZ
         bhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990483; x=1762595283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WH5O/8nAx5rVFTEi7/lXcZZ45r+c3Q9ZyuJj8snlwgs=;
        b=l/78wwAv1J6zbosuqvv0itEdaTTmi6nqS4Xp7RQp9ITU5Q+6BMRB8UJx4AJr8dHOYT
         XH9dSFvXFIuuFjjP/DLD+rFkx2Q+ONzF4SN9cA0pDwrIF6FjVpVXWrAyW6mhUFXzs7ml
         slJyJpGLr42Y5ruBB6+0zewP31VCOi5z2Eks/ygWNd6CIv+GOlbAhI/DQwZjrI1iioav
         zafV4sH8qmQeUzqHABnM8hfroycyDsraZ767kXqVtHE/X8Phsf6wtvVAi3aQdHcPhtys
         aV7/Grt5bl3N7CeRQzdxbIuDXop5mgS7Wdt8pQvSVH12kEHcCPLzvvNNoUzJxZZFOS4/
         JFXg==
X-Forwarded-Encrypted: i=1; AJvYcCU2QANcK71wkUZf43lHKIu2PvFkd240Q0hrWyzDevBHmyH0543ZvJayeb+/tYvsitgG8BirXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JFBrKeTqqks5aNneGXUYfVcoFclnTEYQBlCL1ZFXzLp4GTQ5
	+9Zmyoye4D+99U6ORsllTvxbmDFU3Nn1a7QTkvO4YSJIu9WjOl3uYZyc
X-Gm-Gg: ASbGnctQiF0lOSgtUKPoOYLqrnbKvVSAS3NXI13vLEzrVet4E/jFEInMCKtJYCQ2Gj9
	CWuLWBRCYxV1d1/XjkKQBFU9cQQDVQtRF8n2M3nbwhL3kPlGun1ihg4z5qRJi1d+H/MymjiVC6A
	9gMNgh8AYzwkwsWIP4ajTW7nbeYmH3zEW7sOs8x1BtttF3A2W+Aswxed4Run3HjJXMwXLlmpmuj
	ZUQ7Y2/YVv5VuXxAy1/cs4Qm09c9MN0h0+HeB/DrCITvyBPFPuZk4WHWPWQKm7Ys3R9YdbmsIh1
	Mv13rzQ6mIcBk6bcTLv+GsVW9KwFwHGL0kSts6yFB98tBviyauS9M2gquvC8oFxU3I3qWXPM6TR
	VKxlKDserJa4/ST+7tFUHsQ7CJlqxPnUqexKMeOImTG1PDQB9moac8w20mBsOcMkjYs4o5SWaC0
	5U
X-Google-Smtp-Source: AGHT+IFkkEhMNFBtz799ZVmYFsXMsu0ozafr7JzI6vs8a+fPrI8GNOdanKuJbIbpaRMf1whMNOYWqw==
X-Received: by 2002:aa7:8883:0:b0:7a2:70f5:c83f with SMTP id d2e1a72fcca58-7a77747a497mr7159153b3a.10.1761990483399;
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d72733sm4804521b3a.21.2025.11.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5228C4209E50; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2 0/8] xfrm docs update
Date: Sat,  1 Nov 2025 16:47:36 +0700
Message-ID: <20251101094744.46932-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=bagasdotme@gmail.com; h=from:subject; bh=3OG2wiKH22RCfvC+iceoRBKIWpDNYuCgxZ/0fv2vRj4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1zJm651g7L3+4YxH5x0enzdfmeoZHySvdDr6TVHpz yZ3ETmXjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk8jQjw9QJLtFbJZYwFVpE udzYf1lR8dq8NYLW9cc3buHV4OUT9mBkuKZv0dzqV/Ji39eN699+4thtcO6Q6M1FJ1+U6PzQnLj ajBEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are xfrm documentation patches. Patches [1-6/8] are formatting polishing;
[7/8] groups the docs and [8/8] adds MAINTAINERS entries for them.

Enjoy!

Changes since v1 [1]:

  - Also polish xfrm_sync section headings (Randy)
  - Apply review trailers (Randy)

[1]: https://lore.kernel.org/lkml/20251029082615.39518-1-bagasdotme@gmail.com/

Bagas Sanjaya (8):
  Documentation: xfrm_device: Wrap iproute2 snippets in literal code
    block
  Documentation: xfrm_device: Use numbered list for offloading steps
  Documentation: xfrm_device: Separate hardware offload sublists
  Documentation: xfrm_sync: Properly reindent list text
  Documentation: xfrm_sync: Trim excess section heading characters
  Documentation: xfrm_sync: Number the fifth section
  net: Move XFRM documentation into its own subdirectory
  MAINTAINERS: Add entry for XFRM documentation

 Documentation/networking/index.rst            |  5 +-
 Documentation/networking/xfrm/index.rst       | 13 +++
 .../networking/{ => xfrm}/xfrm_device.rst     | 20 ++--
 .../networking/{ => xfrm}/xfrm_proc.rst       |  0
 .../networking/{ => xfrm}/xfrm_sync.rst       | 97 ++++++++++---------
 .../networking/{ => xfrm}/xfrm_sysctl.rst     |  0
 MAINTAINERS                                   |  1 +
 7 files changed, 77 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (64%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)


base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
-- 
An old man doll... just what I always wanted! - Clara


