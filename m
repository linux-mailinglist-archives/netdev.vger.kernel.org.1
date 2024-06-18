Return-Path: <netdev+bounces-104338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868990C337
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC3D1C20FDA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EC17984;
	Tue, 18 Jun 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gbSoBuWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC32CAB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689931; cv=none; b=l3IuBt6Gnek9DWE6o3fXaaNx2oOrUXzCmv46ds7uAfSzNtIBu8pH7EnTBksDkEHBLZjJyMPowTnwcriXZ/VucO/ngARj+KJhyeR3jCdTzGjDLJ0+tZ7vDgvZTc8l+wL7xZxvEDyOGYg3LXivRcPYoykwRNHNlGFlwDHiRi+ntqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689931; c=relaxed/simple;
	bh=FHCJJhHtchM6CRfWMBW3go6vNRCjDHaa1xpX5tV4Fu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7EGqizE+rcRI/4seOS2eCa/ezXe2axwR1qUsJryY/ihWANdiEUltUd8AjZSbkIKAy7gWppAEu2cSoDFG5h5mFYdmMEo+GdoUZqNFqz0fhwt7EXLng7QJmCa+Yr4sjRV2jcltE+3kvCumJyqA7lfNgMimWMcqxRxaue6O+rWZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gbSoBuWv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6fb2f398423so3048899a12.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718689929; x=1719294729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOhMUyliojig3sarzkNhgTnnCsvhuZSfY99RJsuqaUw=;
        b=gbSoBuWvIINmOYM8ABYHc6f+fhtlv3nV7MGmGWGXfkL48xiE8wSlpv+1ETg3gP1MYz
         KtZh1tS/M1hvZvb33DsI49NA6aK5DxRY77trDoNnNoBKGqo4ouexekuVaZ7kr+LXC0Y4
         ZVnpGN3o7v0UhG6fpER2BajpKyqBQEwPx5w4H50oj44Wa6CYQWJk0B1r2dF3/roH6c0G
         dUDoEblPkgHpTBswaqu6dNCQL6oGD+CJeHJrZIR6xePvtMYPHw6R+FE2U5BqOuBEsQMw
         DVd7AEwXH9VwMbpRpeOGPxM7ZAR3QMKpgV4f5YeN6P66rrI0d7TInUAVlTqcZxu4+LBc
         tvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718689929; x=1719294729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOhMUyliojig3sarzkNhgTnnCsvhuZSfY99RJsuqaUw=;
        b=ZuOezmiT+ywxfSwZE2hYT4c3UK1MnXIGvXMQutS7IIVTvdJiYXxIGwaL2tEvTfjUBW
         ihyKKCMEWhXE9YJGvg4EsFuCGaX0ySfyhLzGlPpp1+7IlS2HiAKvQ+0nJb56S0fJ3skS
         Hf87yAbFn+WGMK6Oze7dPZTWrHJF4sKrcGg1FNEodiH0HcFhgtcpJMVkGwxUWSfb+imp
         Zubv28213oGhzfMCuFUQD8wynIZl6fdsWI6aRGAzuz+POdzCMgNDG9FEXxe8LUIq2KEe
         viPpY25eah5WGRz7wQ3G2fmJRUNMX/traDC/IGKk0Ekhml/HOorEYIcjtQRqJnZ+tcWd
         mrAw==
X-Forwarded-Encrypted: i=1; AJvYcCXprvCVFGOmFd+dAfzNkIe8ip2iL9TvHHxFEBaRUuNfzO4fortU43SQ+VCns3REBYwcOrHgjfSIrGYSYeypwdygU1dL4HUo
X-Gm-Message-State: AOJu0YzWUcYZSD9rBvCem3oYowMhp3R25lRTjDdGWSvYXA3Itfh/T38x
	Z5rPxdGjPuwGVPMSqPXfeRtvnZFWZbmLthH5yTeW+vc6f/T83vU5yz3SoWzBlss=
X-Google-Smtp-Source: AGHT+IGJit6y5aY9TcZgGDhvuaUFunYO2FVb7MhiPNCGA2zW2h8khDV7c4AXM3w6hpZyld46ax8hNw==
X-Received: by 2002:a17:90a:d348:b0:2c2:d8da:b9ba with SMTP id 98e67ed59e1d1-2c4db24d3f1mr10293886a91.20.1718689929117;
        Mon, 17 Jun 2024 22:52:09 -0700 (PDT)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4f01a82c9sm7111294a91.31.2024.06.17.22.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:52:08 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] bnxt_en: implement netdev_queue_mgmt_ops
Date: Mon, 17 Jun 2024 22:51:59 -0700
Message-ID: <20240618055202.2530064-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement netdev_queue_mgmt_ops for bnxt added in [1]. This will be used
in the io_uring ZC Rx patchset to configure queues with a custom page
pool w/ a special memory provider for zero copy support.

The first two patches prep the driver, while the final patch adds the
implementation.

This implementation can only reset Rx queues that are _not_ in the main
RSS context. That is, ethtool -X must be called to reserve a number of
queues outside of the main RSS context, and only these queues work with
netdev_queue_mgmt_ops. Otherwise, EOPNOTSUPP is returned.

I didn't include the netdev core API using this netdev_queue_mgmt_ops
because Mina is adding it in his devmem TCP series [2]. But I'm happy to
include it if folks want to include a user with this series.

I tested this series on BCM957504-N1100FY4 with FW 229.1.123.0. I
manually injected failures at all the places that can return an errno
and confirmed that the device/queue is never left in a broken state.

[1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/
[2]: https://lore.kernel.org/netdev/20240607005127.3078656-2-almasrymina@google.com/

---
v2:
 - fix broken build
 - remove unused var in bnxt_init_one_rx_ring()

David Wei (2):
  bnxt_en: split rx ring helpers out from ring helpers
  bnxt_en: implement netdev_queue_mgmt_ops

Michael Chan (1):
  bnxt_en: Add support to call FW to update a VNIC

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 627 +++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h |  37 ++
 3 files changed, 559 insertions(+), 108 deletions(-)

-- 
2.43.0


