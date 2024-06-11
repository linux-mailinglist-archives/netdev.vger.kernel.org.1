Return-Path: <netdev+bounces-102423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4251B902E6C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBBC1F23758
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998C16F8F6;
	Tue, 11 Jun 2024 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="XYH5hjBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1816F8F2
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073208; cv=none; b=I+V7fCwiObLf+eZcbt38QnNDhYjQiJKeq9+wbCE9TJdOo9H6oSrlOfXTUpA+Rns+Qvs90futEGZXwIOfBQxGxzGRMfeDmW5+q12cKWUrAV7NDU7iUMPNpQlNtEhdrKTXoFDXEVxTSvcq7P6FIKgLEdjwd+BcUl3dYqiEmNhNGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073208; c=relaxed/simple;
	bh=5UP0vwiIKuSKoiKJILVOPdcBmnjNo8CEeWbWndom3jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIwB2sYIwN0jsJxBEgIu25dXky/VKG5Yl7qkGNhcayP39uPqPgNSbo8eFcjO5uPCzsL/gbOr+nNue7pSkjrSF5cGX9hrLgH2xPAAs29lYMFZV5RCO2RpZ4A4pmF9GWOxJm/4O2vrhOHoglBf9jIUShPRog48s1CB27wasn4irQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=XYH5hjBn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso3792412a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718073206; x=1718678006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wgIdQ6CDFxqqcDRtB9o6TWrtl4k3imUm3pvdxy9evI=;
        b=XYH5hjBnarA+PYVmPcZPXk/yTASGvz0VAKGB2I6qkeEearuoABoD4bE9hCdDoEmbFV
         P7y4ehPwBLr6/gH6tIG9B3Niks1C2noe5Q/4tSmXqON8Yd7IU0inkPBwfEDjS0ko9Ajs
         OB5V3XWWo3XQ452tnhJ8m18dz5yYDUJlY9Y6fTY86/YQEy5kOnuVPccQrCerkGjVfVsU
         KYMAwy6R0O1Tk9T2ANRj/UUonxtnTcx6v4ImWH+pa5jpsp0j0hahYnA35uqfajBN5zhB
         CMjdxJ2x878I0nB5Tgg2B2HNqhdiSZpTUnf79HUODELkN99x2KXSMoXtCZF2wYanRVPG
         Siqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073206; x=1718678006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wgIdQ6CDFxqqcDRtB9o6TWrtl4k3imUm3pvdxy9evI=;
        b=sQzurGf9bDCbUr0irKcU5+2ghUI+0aC90OCXzGKBiqFJJxvhaHjBbNDkKe4Ljz97IA
         STzoOuCOhP2Eber51duR381yJ1E3nnyfuJF5yQ4YvpLd5fYT+tEjKdK4DANvs99t+0g4
         K1Kv1jfMZDmnFypauRNApJQ6r+ojehO9y6CKZNTZmK9G94vzGkpFNeCIN8Rf4gEXbwxq
         PXxd0OD385+EOmQ5cr6Pd2YFqVvFN1zuYQRrP1QVyOPTWM94WC+w/epSBMGMsttoZA7F
         WmgGGuAyvI0GM66Dfr5oH2PDpm/1mzRx7YPhtM7/DievgJut6Gyvw6xGW7BMtQpP93VD
         pqsA==
X-Forwarded-Encrypted: i=1; AJvYcCWvc2fHLk+8H32n3cbMTYhLbD6rEsB5IE3v/gvLKapxsaKwe5FXv6vTC3J5bFsT2kbOFl93abzA/UCom44Eww6NTQRJUdjF
X-Gm-Message-State: AOJu0Yy0s9vThPlwnpa6YNkmJWPf1cbWMa3zXXORamIYAVXBseppEQiD
	i12N0wSaVYfHaJ+58dzVxK8vA2Bbk1UKuODw1W1O5vWcwYxHJJZ8UNa7OsCn5aQ=
X-Google-Smtp-Source: AGHT+IFEgyqnzBiXO0x70ZCqTZuE6XeKtlmy73sZk2sH/Lj12/GzyfibgOqo75LLEnLWfMmN+Zyhkw==
X-Received: by 2002:a17:902:6503:b0:1f7:414:d66f with SMTP id d9443c01a7336-1f70414dcdfmr45544195ad.24.1718073206189;
        Mon, 10 Jun 2024 19:33:26 -0700 (PDT)
Received: from localhost (fwdproxy-prn-112.fbsv.net. [2a03:2880:ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e05d4sm89596015ad.191.2024.06.10.19.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 19:33:25 -0700 (PDT)
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
Subject: [PATCH net-next v1 0/3] bnxt_en: implement netdev_queue_mgmt_ops
Date: Mon, 10 Jun 2024 19:33:21 -0700
Message-ID: <20240611023324.1485426-1-dw@davidwei.uk>
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

David Wei (2):
  bnxt_en: split rx ring helpers out from ring helpers
  bnxt_en: implement queue API

Michael Chan (1):
  bnxt_en: Add support to call FW to update a VNIC

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 623 +++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h |  37 ++
 3 files changed, 555 insertions(+), 108 deletions(-)

-- 
2.43.0


