Return-Path: <netdev+bounces-51499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACDE7FAF00
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FBEB20DBC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF07FE;
	Tue, 28 Nov 2023 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdONHcQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F5C1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:19 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cd856dae82so2058353b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701131239; x=1701736039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Py9o3aB/Kyc/ykPhtEZLVMxjCb2RURBa1JlSn1vBVck=;
        b=xdONHcQihXeRIDZiNLIPT++OlQhbcz1/qc0MhgCQ+fLTymJPeFCce2+W/+6dY2OGEv
         XymUynBZsLETkj5/UBQY5LvgX62IRoGDOW/09qG+97VPobxgNc9GoMUoy4Sn7Fsj2hS5
         cIIbcOxkgsaihNAyWJTmRzWlWr7RiwoSniC/DQlEoQSKd0l/irx3vCPcxXt64VhVDAma
         NgbFmSCIRh5jpc3fY+R0+ZBMNhBaUsx4DT/fMfeOeOYoSnKVjHIYSEhvRdxOYqwb/Rd3
         td3fZhshHTXwNI03hoIahRYAX57MPSCw0eyczExJL3uLFOleuxE7Q7xvQZSfwp8PpxoY
         l/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131239; x=1701736039;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Py9o3aB/Kyc/ykPhtEZLVMxjCb2RURBa1JlSn1vBVck=;
        b=mtooB+k79wstRnT6p1f4PkmeOeth+khIxEqFz2/63TkzJ18ChXaLkeCfHSnT+QmBUF
         LjH1pa7ypfWk9iJCKJlnPchORjizZi5JYEL+ZL6joTfCzVxWoEpKjX3o+8n0+Kxn6pTw
         An7E+F965zzvj5xg1UHeIpJaerarinMeFwAyUWc1hIiyCaknR4wUpA1fVUjDctCKy53B
         eYkF8VwZHjV7eLUU/6ojtAsmbnu/Wr0fEUxljb4X/vugPOXexle7fvvVGTRHGnzmKHn/
         /b+Pd2vgZquifrSl9YpKEkqsm+8SD8/z47uTfT4qEhQ7kKJxLYQlLbsaWtVg/2uaOCWA
         4Vuw==
X-Gm-Message-State: AOJu0Yxzx1DrUeZ+bXyt71yovvNNkF+15YHuXHBgPeAE3+UNIbbW7AkT
	skqJwB6im+T3XXpwANLFH7krMJf4QCxni210pRRD0M7R81tkNsIT9Zocl0bNMLKQCsINy08gvWX
	rvzmUUxJnyrcbRUhqFtE+55S5QY1lBvxYdv73ZVjXlsQiG3w1q4wuSqLfySzqkMeu
X-Google-Smtp-Source: AGHT+IH4d5GYTOdJNzmreEkpVOtCHbd4pyGDEGzhHUOrK08a8bbgXxFwEohoE7CsbpwVdyqIBDiNV6HOIur5
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:19d5:f826:3460:9345])
 (user=jfraker job=sendgmr) by 2002:a05:6a00:2d18:b0:6c0:7069:6666 with SMTP
 id fa24-20020a056a002d1800b006c070696666mr3452857pfb.4.1701131238715; Mon, 27
 Nov 2023 16:27:18 -0800 (PST)
Date: Mon, 27 Nov 2023 16:26:43 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128002648.320892-1-jfraker@google.com>
Subject: [PATCH net-next 0/5] gve: Add support for non-4k page sizes.
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds support for non-4k page sizes to the driver. Prior
to this patch series, the driver assumes a 4k page size in many small
ways, and will crash in a kernel compiled for a different page size.

This changeset aims to be a minimal changeset that unblocks certain arm
platforms with large page sizes.

John Fraker (5):
  gve: Perform adminq allocations through a dma_pool.
  gve: Deprecate adminq_pfn for pci revision 0x1.
  gve: Remove obsolete checks that rely on page size.
  gve: Add page size register to the register_page_list command.
  gve: Remove dependency on 4k page size.

 drivers/net/ethernet/google/gve/gve.h          |  8 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c   | 88 ++++++++++++++++++++++++---------------
 drivers/net/ethernet/google/gve/gve_adminq.h   |  3 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c  |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c     |  4 +-
 drivers/net/ethernet/google/gve/gve_register.h |  9 ++++
 drivers/net/ethernet/google/gve/gve_rx.c       | 17 +++-----
 drivers/net/ethernet/google/gve/gve_tx.c       |  2 +-
 8 files changed, 81 insertions(+), 52 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog


