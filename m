Return-Path: <netdev+bounces-107977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F391D5B4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D537BB20BC0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454C3FE4;
	Mon,  1 Jul 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="cn9WqS0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C78320D
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796884; cv=none; b=rIe788jP4PANokGWvc5/lRiFYcKFHCm3FiqgrtEi64Q5TvA8HuJ1Vkl/Ua/UYS4ZRsaSgQB9Ws+Z2OYOIChlpQPY0eLMNDzfOFa5LeJOYcV0pWu9a93hApI3JUi3WUpCSf4SMmw0EZRWfcQdYir468OkDO4C4Mwbb396JAb5oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796884; c=relaxed/simple;
	bh=Km15tanXkNQ7an3wayeC70gqWh66gOf8O2GPDReUn2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5pPYxDX9NLj+/9daSjHC8P7wYi0wxsAfFzw9R06hDU6nfeMr4u8DBz2pS7x2ZImiTpmDobRTa/jEVkQlhg5dk2To+A2O8x3IoFHN33SYIjh2BNW5Oy+4fheaOSm8wXO6lYM5HLkyYkj+stVOhjOIL4sKSF6sPFnzGy9aYhZBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=cn9WqS0I; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c7c61f7ee3so1321331a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796882; x=1720401682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNj/nLR9QD18Dm/6c0d6PrRWpQ51p21A2oHGimvqq6w=;
        b=cn9WqS0IAaSfpY9ZbMCi7fR6p1bc8e8GZ694C8BmO7eENdo9EVnrblAPdWPlREVDk2
         bm2xoLxOqWb5WPpkJFQnfk2HJv7Y94/olbrMeGd6MqCr6BuRCeoc5EgUFB7JJaXeJJJ9
         j3Cy+BBEVD8qaYY2TuWrIyFMm+FdjCwzqHwDqfbFUwgjIwtxm7VCZ9TWPaoczqBC5sCF
         ovCxxAkgR6DrAxkPb8J89wnfaqJAYVK3yiu755t7hT0Cd9vzs1j3yhneMTEhfVAagZ8I
         uzu2f8MffHdan+GZ0s7VCQTq2szZ+MDYLrlNO5hzBle/GcxfvhaQKwlsjuorFvUbckYn
         5lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796882; x=1720401682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNj/nLR9QD18Dm/6c0d6PrRWpQ51p21A2oHGimvqq6w=;
        b=oyMY4Ewf+7SSE3Br+4plwTxKnxMI358/gzb4ewKibR9NAumDRATlm9aNzh648tbM0x
         2dHY2JhRIMPxKqP2MHSNtZVxg36fp4msqVTQlw1oRVWeTLMAvHbghHkc/3YRUcRxLx7W
         FHNsUIqIwi3ro8Kqsh0PTO4aoxafdrGbMw436SwN8Tju4KbTuG8/uNNL6q7mTRcRpb/7
         Yjd3nKhkflblSXVQEWr6SsUQpg+DbFuHgFWGmZynPy6e6yfizN2SURa1QjgIBb8Fr2ee
         Uu8POaIiG6zsxk1XDzFyydJGsiV+RteFnIYwIkhqe04+MzFr+5e00c4pSwrRa5cth4GP
         GUvg==
X-Forwarded-Encrypted: i=1; AJvYcCVMNYshtJiNkk8lYbSQNB2mQ1OQLw2bsQ8PFqxKgnPyCsQMatpOhcoaMduMjj8wZ8mtHen6qTpfNzIXSLqRcDLc4ixauobF
X-Gm-Message-State: AOJu0YxENkhiwC6Yd0R3ieOuHV8UYUogoZUvWvywzF9mqDQUCYp4OGcX
	N8wiacnzOGb1PhcIX97Nf2To9aKe+yGnTvIwEKKN5VxSH2IH1BSPq+xtY9y+mQ==
X-Google-Smtp-Source: AGHT+IHP247gyA8fOpASplvkSBr83G98cS5ezXKJ/oRT5g0xn8t1x8kh3HPulNstqJQF0e2ugfY+WQ==
X-Received: by 2002:a17:90b:38c:b0:2c8:858:812a with SMTP id 98e67ed59e1d1-2c93d75da07mr1741860a91.38.1719796882514;
        Sun, 30 Jun 2024 18:21:22 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:22 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next 0/7] drivers: Fix drivers doing TX csum offload with EH
Date: Sun, 30 Jun 2024 18:20:54 -0700
Message-Id: <20240701012101.182784-1-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several NICs would seem to support protocol specific TX checksum offload
and allow for cases where an IPv6 packet contains extension headers.
When deciding whether to offload a packet, ipv6_skip_exthdr is called
to skip extension headers. The problem is that if a packet contains an
IPv6 Routing Header then protocol specific checksum offload can't work,
the destination IP address in the IPv6 header is not the same one that
is used in the pseudo header for TCP or UDP. The correct address is 
derived from the last segment in the routing list (which itself might
be obfuscated so that a device could even read it).

This patch set adds a new function ipv6_skip_exthdr_no_rthdr to be
called in lieu of ipv6_skip_exthdr. If a routing header is present in
a packet then ipv6_skip_exthdr_no_rthdr returns a value less than
zero, this is an indication to the driver that TX checksum offload
is not viable and it should call skb_checksum_help instead of
offloading the checksum.

The i40e, iavf, ice, idpf, hinic, and fm10k are updated accordingly
to call ipv6_skip_exthdr_no_rthdr.

Testing: The code compiles, but is otherwise untested due to lack of
NIC hardware. It would be appreciated if someone with access to the
hardware could test.

Tom Herbert (7):
  ipv6: Add ipv6_skip_exthdr_no_rthdr
  i40e: Don't do TX csum offload with routing header present
  iavf: Don't do TX csum offload with routing header present
  ice: Don't do TX csum offload with routing header present
  idpf: Don't do TX csum offload with routing header present
  hinic: Don't do TX csum offload with routing header present
  fm10k: Don't do TX csum offload with routing header present

 drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 23 +++++++++++----
 drivers/net/ethernet/intel/fm10k/fm10k_main.c |  9 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 ++++++---------
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 ++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++++---------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28 +++++++++----------
 include/net/ipv6.h                            | 17 +++++++++--
 net/ipv6/exthdrs_core.c                       | 22 +++++++++++----
 8 files changed, 96 insertions(+), 67 deletions(-)

-- 
2.34.1


