Return-Path: <netdev+bounces-104734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E490E363
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E9CB23233
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1046BB33;
	Wed, 19 Jun 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JZ9r7dIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666F1E495
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778577; cv=none; b=ccB5a+NB5fynuBSQ5IfABbPu3Vike1c+4qS3cldKKguBIUAP14L/ZX7CCPn/Px+TH3/kZEFdhLS37Jplgih74kwxqwBC1YBNSpA0vqqycKnB9kNnvXqPkf+mXWPu8zsRl3eBxTs3nnOLiqJtNEvpHvlQr9AP0tclQQVZHOFh0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778577; c=relaxed/simple;
	bh=ZLZTv66w+cKeL/91s4DULF7j1StD0DRV8kgwL/y9Aho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqmqqaee4SrO45+uqFCQS7TaYIZKic47vNBTsPTuisi0DmPSAajmlEtYX7xLmNxDD4mVMomzjMQIWqJQmGTwghQ8b2s4ApFoOhERyW1aCi4fE3wi9tOJ3PjdW1AZN72f+z37xrv0nQznFzHUNq4iJG5mZuFujECNFpFmJe4900c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JZ9r7dIq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6fabe9da3so49952125ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718778575; x=1719383375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjVnWYC2n5Y5SM3OiLojCg8OUHqBmiAUZL1nf/D4oNI=;
        b=JZ9r7dIq/h3DPeHxOZsf7hKylemH09vT/+L+/eVFHXac8f5uMB48nIbTlO87MVJDs1
         IF7CW4t/agv9+h2NIQesoMwakllQMqP1idYmVzR2jCHfMj9kf6ylgeajt0yXCdmBxtOO
         4/kswGWUKS3XJ//TeXF7xLuuYu76auhIHFO+TA+wCq+BE/NrvTIGO6v5qpN7Y8NArTp1
         adWE5Rs3JN7Xg+4UiFUZmhq8vfm3AJIJ1HPMLTMwaA6FYN883WsTk/gUfCZcNAg4rMLn
         tohNoZwbuF/PxRq1WHPSvulJmfFPZL+8gcjcx+GUC78ZyoNheToa+8eSp+Q4VcnJJ31O
         /udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718778575; x=1719383375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjVnWYC2n5Y5SM3OiLojCg8OUHqBmiAUZL1nf/D4oNI=;
        b=kvSVmu2DVdGMXsMjwu8+NceHIeQ4KtbnL8WFM86DqAFAeqZNe+T5r4CU5HEvQUMFGM
         ZEAC4HaHHCJWF9CmyVNbIVGUZRo3jKbJyykynHhw/tjafAQ4AYWHYMgN8XCctsZXSju2
         c3jyRa7SZTzG90rl3x4LMpM2t5ZNLwdjScsW82Pauw7gajp3TrKazormB4qLBx+oLorc
         ZFtE6O1oilixh2KLEe0JQgRRKbokVWljwffwR5x0z08KXV56x51+rZ7rz4lnKMDDEdpV
         e+/Rgx2GiHXY2Kj6yKnwod8yPUpwMAPWeZw3mZGhR6HcVsqxL8chQMHQeVdSIfp4eadN
         Z0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUFcJEfp32YnjoEupGBsd4R5hO0PpJVtAYM/XWwwRx7ZU16lf2lmo6NqG108NxYc8FyTevch6YlfXWBysoXo2HBKooIiFmp
X-Gm-Message-State: AOJu0YyLylDZ9CMotWI+AsdNGXq5jY3GjLC6shyfrDe2OTZX/+aWNyfK
	+rKOvjquXfgX/r+NiyXR23jvEaYpqWg/VyYiXrn9fp4MBp6DD+ED58OUppQsTGc=
X-Google-Smtp-Source: AGHT+IG4ns0JsvozVcCCfTTZ+mdN7S8XE4vO2tdbNh0jAuOZSmWUQcuSDvws46iTxS2Cush2Oh0amw==
X-Received: by 2002:a17:902:e84a:b0:1f4:8d7b:53d3 with SMTP id d9443c01a7336-1f9aa480f4emr17752165ad.44.1718778575510;
        Tue, 18 Jun 2024 23:29:35 -0700 (PDT)
Received: from localhost (fwdproxy-prn-114.fbsv.net. [2a03:2880:ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e80eebsm108100965ad.117.2024.06.18.23.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:29:35 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] bnxt_en: implement netdev_queue_mgmt_ops
Date: Tue, 18 Jun 2024 23:29:29 -0700
Message-ID: <20240619062931.19435-1-dw@davidwei.uk>
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

Any arbitrary Rx queue can be reset without affecting other queues. V2
and prior of this patchset was thought to only support resetting queues
not in the main RSS context. Upon further testing I realised moving
queues out and calling bnxt_hwrm_vnic_update() wasn't necessary.

I didn't include the netdev core API using this netdev_queue_mgmt_ops
because Mina is adding it in his devmem TCP series [2]. But I'm happy to
include it if folks want to include a user with this series.

I tested this series on BCM957504-N1100FY4 with FW 229.1.123.0. I
manually injected failures at all the places that can return an errno
and confirmed that the device/queue is never left in a broken state.

[1]: https://lore.kernel.org/netdev/20240501232549.1327174-2-shailend@google.com/
[2]: https://lore.kernel.org/netdev/20240607005127.3078656-2-almasrymina@google.com/

---
v3:
 - tested w/o bnxt_hwrm_vnic_update() and it works on any queue
 - removed unneeded code

v2:
 - fix broken build
 - remove unused var in bnxt_init_one_rx_ring()

David Wei (2):
  bnxt_en: split rx ring helpers out from ring helpers
  bnxt_en: implement netdev_queue_mgmt_ops

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 575 ++++++++++++++++++----
 1 file changed, 468 insertions(+), 107 deletions(-)

-- 
2.43.0


