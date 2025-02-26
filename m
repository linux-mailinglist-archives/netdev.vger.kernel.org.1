Return-Path: <netdev+bounces-169715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0302CA4556D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60653A7D06
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D7267AE9;
	Wed, 26 Feb 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZn7Rjoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBF267B07
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550736; cv=none; b=p5qxYXGKU4fPHzuM9l17/ha68vUPvx8e7iQwv2YJAmTYF2Tth5JZpSLCH/Zhi0wXOrev25SJw+HilCjMrpHxg6hKKhw499Em4gEubI2eT88/NhRVh69nvj+4sO5wj7Pxiex0iexgcj6MuheT/tHZpqW54XHGxuVbxWV863CITpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550736; c=relaxed/simple;
	bh=acC03O/cG7ahO0LGdh0c9GEOC/Da5NPmXCMOgW5Ydvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eSmPIWG9snps4Z4f7PstjdzH6AxEPydHjuoco74Y5q8Y0tlj9Kqe0l0mM/CN/bIQSR8HvvlnEssVeVYIjtYM1XPVqrRsRXzJBLFZg/zRQj/SmbWkR/XrbNIiS5FjqybJ8uLw6+vOH5cs7afv1+ptPXIskTVwnMwn7IB91qODQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZn7Rjoq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2210d92292eso40815675ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740550734; x=1741155534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SavIM1rAdPDqAWsHk49jnbqINxMflZ0qHYpsMIoW+NA=;
        b=YZn7Rjoq8xkUqWMKI3BS/cw/SwBI2P/kNsba18G1xchDwC3jslyWImoLF76YNHAoE7
         MMBE+UV0XQQ32syayja4btY8rlU18i5v8TvDGdMsEpFJ9mZxr6xK1NL+4KzYjipkP5So
         Lax+YO5w7gMvx7YUG3sgph1ue7+PwrJ1DR+1Gq0+NNJGYIeAV7dp+/F/78FPe1xZ7Rc2
         v82TjozEwLYcA4Hf7AnJFNW0sOxkIisrSKPElouezYkpW7JksetJIKvqKbDJyiG50nTd
         j1fD/XX9D31o4KLT3OYjbk7MfXnL/DcjIx6vcu860ZjmpGM9PnAqgaD5pdegAuwFQJPQ
         O/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550734; x=1741155534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SavIM1rAdPDqAWsHk49jnbqINxMflZ0qHYpsMIoW+NA=;
        b=NjOjvcw+mz+WwFHysCyW7UAmh6/lPEy5ExWLQTFQahMEZLb01taRlGeBBCOLRZavt2
         OP3Vem8FyZihbHgqfqqr8ap4GQaq/p8+K1GvHBbfM/q9KEBy+kC5PRaQR13OCdowF+sT
         9Sarpvp/lsMx5XdjZywo94ZWc6wcDpM5qikBiECDxvo4/kq2/0k4LT4cQWYXV4HdfGbe
         DRiOl+OrmxtLMZkyOHV4okMW8l4NesTho0cmRAxUnMQPM4BF1U/O1pifj+Jsz4/OZAYU
         8R9K6I8tt43MAB6gt64PEQx0ChYsG/J4lcZB0rM/wx9MBhqYlKtbMGDUq/E4duZ4QZUq
         aoFg==
X-Forwarded-Encrypted: i=1; AJvYcCUljwmksdlrhNEauiAd+i6NSodxNef2/azbGcF3GYdpcSwoMV852nTFPJKgBvDx0KHeLnwZq8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyAU74IbaxTIuWN98Fz8NS3iB8LALds5szIHc60Fo+hHnzayM
	4d2MmjB9QoUqxtrVmSJGSDxPaNFWHeaFDcRxbw9fNubIvquu/4wv
X-Gm-Gg: ASbGncs1jqXMWbdjmOys+B3K6ewWoihDQ3Hiac4wwdfVYLuXIj7bMDIMcv3VQQXcF4M
	gcMrSyYdoKRTTYqOrh48TflZyttZsHTE2kKeZ6n0FRrmgVDUmNEit/6weMozVvs/8w4zkbqlBiE
	1RXHAB7auucPVEBoDir+r53IRTEgzQX+s9PePMlY6T+NUBLpA9LH39XR21ohiapTFRav8UlSFEI
	kSETD3KwahVxWqikeftYmS1I0RBzcuamGJncoYPoP1S2QiDvj5JOMSJgtyn0WeDHJEKHU7wnOo+
	pJcqfwmVDwAfL5A=
X-Google-Smtp-Source: AGHT+IHyXpp21/p1hxSedU9YP6LGcRcVGrrovuhadarU46eaWLv0IRzgrUlebVRIYWXmWCgS41zM8g==
X-Received: by 2002:a17:902:ecc4:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-223201f7ec4mr33331315ad.41.1740550733673;
        Tue, 25 Feb 2025 22:18:53 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a61fcsm24575535ad.191.2025.02.25.22.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:18:53 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org,
	ap420073@gmail.com
Subject: [PATCH net 0/3] eth: bnxt: fix several bugs in the bnxt module
Date: Wed, 26 Feb 2025 06:18:34 +0000
Message-Id: <20250226061837.1435731-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first fixes setting incorrect skb->truesize.
When xdp-mb prog returns XDP_PASS, skb is allocated and initialized.
Currently, The truesize is calculated as BNXT_RX_PAGE_SIZE *
sinfo->nr_frags, but sinfo->nr_frags is not correct at this moment.
So, it should use num_frags instead of sinfo->nr_frags.

The second fixes kernel panic in the bnxt_queue_mem_alloc().
The bnxt_queue_mem_alloc() accesses rx ring descriptor.
rx ring descriptors are allocated when the interface is up and it's
freed when the interface is down.
So, if bnxt_queue_mem_alloc() is called when the interface is down,
kernel panic occurs.
This patch makes the bnxt_queue_mem_alloc() return -ENETDOWN if rx ring
descriptors are not allocated.

The third patch fix kernel panic in the bnxt_queue_{start | stop}().
When a queue is restarted bnxt_queue_{start | stop}() are called.
These functions set MRU to 0 to stop packet flow and then to set up the
remaining things.
MRU variable is a member of vnic_info[] the first vnic_info is for
default and the second is for ntuple.
The first vnic_info is always allocated when interface is up, but the
second is allocated only when ntuple is enabled.
(ethtool -K eth0 ntuple <on | off>).
Currently, the bnxt_queue_{start | stop}() access
vnic_info[BNXT_VNIC_NTUPLE] regardless of whether ntuple is enabled or
not.
So kernel panic occurs.
This patch make the bnxt_queue_{start | stop}() use bp->nr_vnics instead
of BNXT_VNIC_NTUPLE.

Taehee Yoo (3):
  eth: bnxt: fix truesize for mb-xdp-pass case
  eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
  eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue
    restart logic

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 7 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


