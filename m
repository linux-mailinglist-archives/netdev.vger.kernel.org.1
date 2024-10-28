Return-Path: <netdev+bounces-139629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2E9B3AD0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926681C21B29
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B61DF74C;
	Mon, 28 Oct 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B8KVCJVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2A524C
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145179; cv=none; b=Am6oOTLdObRu9GSD55Ph7yWKCv4zybvcMKN1EahYHNi1rB60hPexNXPkbUdyEMnFGfh2UEHT/EpKeE7atzDs5dFGDi42Z5QuVRQaQ1F8na+FCfSu3OFt0KqYslNjaK1t1P96XU0oXHxQty3Y7gBO2xACOlw6QXz6ad2g6c94tPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145179; c=relaxed/simple;
	bh=dehkDJB9WQDCgvah8osMPwjYFl7T5sv+Vt2PLRrgMZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gdI+Ko70MZLqxjjQIj2IwCgIz2wCatHxGFekpv72ahbpMq+qRIm1+9LKfdDLYKryFoJ0MBFIyV/Fqz6Pr+rKkOX1MIuNgDAzsMkZOhQfgqKBuCOb1V/GHpjqnIzPLt/Wza4Bz4mOK8BTpyE+eS/yfWsAgmPfJnIFPRfdNOiuFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B8KVCJVT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e91403950dso789235a91.3
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730145177; x=1730749977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOgHVETNvwv0GrKYIJJt6UQ/Zkj1FG5o1aowTjEXfjQ=;
        b=B8KVCJVTsySsc10qLvMqAENe6aHhNoetfGlT2J8Vd+h0tUmz6to/tCHq5rtIgNEXHY
         RfA9IwqNa8s5ya+ISpkgKbXKK65ceIN9vkUIYOKCx9cPAIHM5GORvacHjPg2S3M4edYS
         Emllh1qVY2qn6HaXAY26wIa5Nh/Kn4opOTVCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145177; x=1730749977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOgHVETNvwv0GrKYIJJt6UQ/Zkj1FG5o1aowTjEXfjQ=;
        b=w49yKUgr5VKYosKekBwvqIMKpmz2ElLH9hY+FjEeHplXsJrd+tfLOfgwDlqswaXA7P
         vsDNKMdXSEeMYir0ImIOqRQ0+wE6NcUJZYQmbOPklzo29nz/N0qaaUtgqFgfKWZwfD5u
         +NH+zbufKmdjNyaIxnIiDWNH812G3r846LZtulASaMNLq5DMwRZd8MHKQTdYRNLmxbX6
         5hOb2Jzh0khNm3jDgxcKLULCFXUbtIRRFMmlb2j++Hwuc4s9aF9X+MdHqtb0azibsuUE
         y9yWsuZn+VXH77UemTis1FNbJ982UdjSaj9dAVyzBAn7axa/Nz7MIUL2SfrDLeAaiNIm
         nylw==
X-Gm-Message-State: AOJu0YyCM2T+6KHq6Z94hFYAwS4JbCRIwdQclnrDSNfWmzSJFX2pMoJz
	N9hRLmrUdsg8jn7/oPv2Olt0HiURXQ1186WsdNCcqTfCCubyLiTfjsOokagjVpj0VgPTZF4ShtJ
	jxV1WArL/OgdcroRAZTJICXH1d03T/xuuPm0atu3NTh1HdtGVX6swQIXO20Yawkm7CtFe4BfsIB
	fDROY0rfeM5qHJD0wYCqulp1E3eZDyBH3Bnw0=
X-Google-Smtp-Source: AGHT+IExbYvofPHEquOHcWrySfi2hLqRWDZWOOEDh1nkJ7OI4InzrhdBk3weEUkkN59f4LvmjpwrkA==
X-Received: by 2002:a17:90b:2d8c:b0:2e2:ca67:dade with SMTP id 98e67ed59e1d1-2e8f11b8b96mr11239428a91.32.1730145176542;
        Mon, 28 Oct 2024 12:52:56 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771e64sm7695247a91.50.2024.10.28.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:52:55 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	jacob.e.keller@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-next v5 0/2] igc: Link IRQs and queues to NAPIs
Date: Mon, 28 Oct 2024 19:52:40 +0000
Message-Id: <20241028195243.52488-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5.

See changelog below and in each patch for changes from v4 [1].

This revision was created due to a report from Vitaly [2], that my v4
was re-introducing a potential deadlock in runtime_resume which was
fixed in commit: 6f31d6b: "igc: Refactor runtime power management flow."

As you'll see, I've modified patch 2 to include a small wrapper to
either hold rtnl (or not) depending on whether runtime_resume or resume
are being called.

Overall, this series adds support for netdev-genl to igc so that
userland apps can query IRQ, queue, and NAPI instance relationships.
This is useful because developers who have igc NICs (for example, in
their Intel NUCs) who are working on epoll-based busy polling apps and
using SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back
to queues.

See the commit messages of each patch for example output I got on my igc
hardware.

Thanks to reviewers and maintainers for their comments/feedback!

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20241022215246.307821-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com/

v5:
  - Add a small wrapper to patch 2 to only hold rtnl when resume is
    called, but avoid rtnl when runtime_resume is called which would
    trigger a deadlock.

v4: https://lore.kernel.org/netdev/20241022215246.307821-1-jdamato@fastly.com/
  - Fixed a typo in Patch 1's commit message for the "other" IRQ number
  - Based on a bug report for e1000, closer scrutiny of the code
    revealed two paths where rtnl_lock / rtnl_unlock should be added in
    Patch 2: igc_resume and igc_io_error_detected. The code added to
    igc_io_error_detected is inspired by ixgbe's
    ixgbe_io_error_detected

v3: https://lore.kernel.org/netdev/20241018171343.314835-1-jdamato@fastly.com/
  - No longer an RFC
  - Patch 1: no changes
  - Patch 2:
      - Replace igc_unset_queue_napi with igc_set_queue_napi(..., NULL),
        as suggested by Vinicius Costa Gomes
      - Simplify implementation of igc_set_queue_napi as suggested by Kurt
        Kanzenbach, with a minor change to use the ring->queue_index

rfcv2: https://lore.kernel.org/netdev/20241014213012.187976-1-jdamato@fastly.com/
  - Patch 1: update line wrapping to 80 chars
  - Patch 2:
    - Update commit message to include output for IGC_FLAG_QUEUE_PAIRS
      enabled and disabled
    - Significant refactor to move queue mapping code to helpers to be
      called from multiple locations
    - Adjusted code to handle IGC_FLAG_QUEUE_PAIRS disabled as suggested
      by Kurt Kanzenbach
    - Map / unmap queues in igc_xdp_disable_pool and
      igc_xdp_enable_pool, respectively, as suggested by Vinicius Costa
      Gomes to handle the XDP case

rfcv1: https://lore.kernel.org/lkml/20241003233850.199495-1-jdamato@fastly.com/

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 55 ++++++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
 3 files changed, 52 insertions(+), 7 deletions(-)


base-commit: b8ee7a11c75436b85fa1641aa5f970de0f8a575c
-- 
2.25.1


