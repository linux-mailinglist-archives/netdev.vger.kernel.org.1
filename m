Return-Path: <netdev+bounces-106653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B549171F8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E281C23518
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AB17D36B;
	Tue, 25 Jun 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BypvcW+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F417D889
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345334; cv=none; b=bzAlVXVAnmMDonMpsjBc0kBtL7vSJwSKGD+rMh0Mu5zio0bmemNlgcoeugsf+u30nE2o/rkD7lKPHT+vjfs1sXo0QgMOmVXzDwixOEAuzv++gmfQ+qTMSPaLGIaa6aSTraomkXans5VDWDF2LwooBgY7uSs7Bg/IyBagXCnXZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345334; c=relaxed/simple;
	bh=RN441uSIdhSZk1BKvaekR/YPFrUoXBEZ6Ycx4yXfYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rovvy/5BJdYMNe+p8QOu11nQZ+vKGBtNzlO7/vBvwnTRlCDpwJPJ4SPL1ZvJ+vNg+OGJNP78c5BbmBZHZvqjClhn1IEmRtYYIJHfhkFn2FjX8koFtLNFI0/hc8E+ytzoy0PpozEORZy11KdaC7sZZFvtdyLNxaE4wslVtxzXRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BypvcW+I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0dso50133805ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719345332; x=1719950132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hF4EmIdG4gkAbu5lkWmWfftWcYtaslvKKyiwRUh5ozY=;
        b=BypvcW+IK5pHk7idM+XDHZnua05WHH99yQm0PjPg51/bTnK4ZY76jNdus/hvZjAZuf
         afyKH0AV9ZHd0MZEsVRpkgnlQAYHBtnyHLuZSL/ZZpPn3gNQSGntGKLvSi/6oqlhyQXS
         66ua6CdOcLgqO7V+kXRzxKbjViYegu1DAmLblHPeLXJwqSItl2VQl3lMD8xOAtrGEufW
         4QXIn4LXkLUavZsUfhSEYEzttJo8i2E5s7G07iHg97OtG8WCdYXWmCQAMi44BbscIYNP
         quwfHmTAYzi0/VjuPrNezIGq63KAJJVMLEBAYOWnT/m5OUAFgI9itgn3q6D8WRz4a0GO
         +CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345332; x=1719950132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hF4EmIdG4gkAbu5lkWmWfftWcYtaslvKKyiwRUh5ozY=;
        b=fU+XlF3EAQN0q9t2S68zb8S/s8hD1Krz09QJPNcGHvf8FvjtdBGluyPWBUYp/HdAJe
         Ss+RdeYLZfHISQrjDZFpfn8CXPsC2ZMOnZxiYKmuXQmJ864TCBSww3XyOytklxm+d3Jv
         YkcMDrPPrXuxsJ98Lyx8g5fWKXyoHh+HPedCA1U/vo0eTtvmyYszcpkRQOfvFkv42rB5
         9bTGfuD8QRp4R4X68Wxn7e2aSKVVAzHR04CiM02hrosROrad/uu86g+thfHLVJhdaZYG
         i0tCo9ORvbIVRI0pEO1X8CnXHN2cM+B7WazfOHEbIxVX34d58C+B5zUBTgPclOlFJI5f
         hNoA==
X-Forwarded-Encrypted: i=1; AJvYcCVKq2rgX9B9OBkeQ8enA8u9VZt5kQh6JGj8zOFEMW5zXHuM91DbffWF9cwNAVnIunNQzFvIQ6u7jzhhCT+DZJF+Zkz3rzp+
X-Gm-Message-State: AOJu0YyGRE3fpimUBavmVyV9T+s0Urjhgh1PPfQoe44W5FvFl6Q+/2ve
	znHzJECRmy/FYOVzRWKqMlGt5gekyKan0/JVTHNM4/RVzZPAJOjB95PVDarjnPU=
X-Google-Smtp-Source: AGHT+IEdf35o95pjKp43SjRM0z0OO25/lcolzhdTy39rLYEt7/XSGptzELNAmU3EbeeGTIcqCpAwUQ==
X-Received: by 2002:a17:903:32c4:b0:1f6:e4ab:a1f4 with SMTP id d9443c01a7336-1fa23bd1b09mr98996215ad.12.1719345332520;
        Tue, 25 Jun 2024 12:55:32 -0700 (PDT)
Received: from localhost (fwdproxy-prn-038.fbsv.net. [2a03:2880:ff:26::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f044esm85477425ad.60.2024.06.25.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:55:32 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 0/2] page_pool: bnxt_en: unlink old page pool in queue api using helper
Date: Tue, 25 Jun 2024 12:55:20 -0700
Message-ID: <20240625195522.2974466-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

56ef27e3 unexported page_pool_unlink_napi() and renamed it to
page_pool_disable_direct_recycling(). This is because there was no
in-tree user of page_pool_unlink_napi().

Since then Rx queue API and an implementation in bnxt got merged. In the
bnxt implementation, it broadly follows the following steps: allocate
new queue memory + page pool, stop old rx queue, swap, then destroy old
queue memory + page pool. The existing NAPI instance is re-used.

The page pool to be destroyed is still linked to the re-used NAPI
instance. Freeing it as-is will trigger warnings in
page_pool_disable_direct_recycling(). In my initial patches I unlinked
very directly by setting pp.napi to NULL.

Instead, bring back page_pool_unlink_napi() and use that instead of
having a driver touch a core struct directly.

David Wei (2):
  page_pool: reintroduce page_pool_unlink_napi()
  bnxt_en: unlink page pool when stopping Rx queue

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +-----
 include/net/page_pool/types.h             | 5 +++++
 net/core/page_pool.c                      | 6 ++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.43.0


