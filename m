Return-Path: <netdev+bounces-109057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8B926BEA
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A3C1F22A20
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7318FC7E;
	Wed,  3 Jul 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="eQlRG9+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BE13C8EE
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047020; cv=none; b=uP/BlQjXwYB7YdBONr2HLbDxgoxzw859fo0L0o6Kzs6+NiFvxt9wsh5qm0CG2MGXkn0PmroMDNp97nAuYYbTerN7gkIKviAeizEZselCnmEv60fRfwFd+/aRP1iyQg96cV+8F8ZujbFJHLDb4gXx3w2DGcp0/gbFs0AhPQKbnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047020; c=relaxed/simple;
	bh=hoDDaXPVoZjbeje1CsYjWK+WmxWspVnVD2xXDZx5wcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sWmBoAOPSdOZIbpndq3eVPosHVQhFbc4TUuTQqnPtljT6TFY/Q3r4W8YjgA0YkIqzcLXuEvST0wYXkudqL1xK/f+r8LN7jeOlLkL102LvRkolaD2MerdMRxvNhvg8oD4vOmaDUN/lj9Hc1m+q+NL8gfIogAvpgbAGho0OvFmu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=eQlRG9+6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso3535361a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047018; x=1720651818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIu/hcRlUHyYVwLmeVvsti4oPEvdUyRxT/Ivu8JQuiE=;
        b=eQlRG9+6V7C6WLw3PyIF0XCjoCUeeCnuh5q5JzRcEahokqKXmeHndeUKCHmSLWtbG/
         WQIufJrjhBXlHYY6+Xdbxm2NSKDHpogHgqwJQtVdebHMEf9zY01MzgA/MJwPHx39v/Qf
         BOo+KrU5l/Pq8hdoNxzOrlvN7/ZmNds0SIiS5WACuc2dkNvMRAfHYSpKBU2eDLeqhn8J
         AQNRiiWIKCZlJN9icVvjhYaq/1Dj+BXQ1nJkEZ7y+BilITPRlo/jcJgpjpQMHSx4Phwl
         tOr+Sh9Rxf8HFdGyzUc3X/XiathJBd8tazqQxiU6j2ksU/N6e4h7DU3pRtGnTrCZ1fiH
         r0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047018; x=1720651818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIu/hcRlUHyYVwLmeVvsti4oPEvdUyRxT/Ivu8JQuiE=;
        b=X4aZXgujuHTXGQX8pAunloWoYZX5g/uey3gt5gYLl71HHC7+igzDxnFl4QY/u1PgN5
         pniIx7kt6ZEfGsah1P/wyU5UeY0oZ5EYtgXQI3Ov24ylU832pSYNzZA/cdtFMs0XXtyQ
         jnQ8gzgSx095IphFvaHRDK4KbQLnuGXYq81J/YsOjy2PiG0ql4ib4BO0EsbHpDY9rgmY
         GX261n7zyGh4hDLNwdrNq6jJ1OPg+Z8sTKyzYi8MUjCBPF46j81/sMmFNVOb6QV0jWNK
         gr2l1QPqnlejcuFIr00rVBQx1Z82WsIw99DIeWu9vgTQj77jldyHCn2TB3ELRiocl7oU
         pwBg==
X-Forwarded-Encrypted: i=1; AJvYcCW/wF45iP1CO64brLGKNK7y0lXmrktPKagddFbAIxUPWgG24b2NyaKmelje6RK+uo3SfeWennJlwyrx7RHvjKmv7waTzUAI
X-Gm-Message-State: AOJu0Yy/Gx02cq2uFGGudFsff79QMy05zkQbU846ZJAVp3sWQT3rDV0u
	xEa1kXZLKQKmh6SViyNJeREeUsYvX7olfnagZBQTvsCke1arFsyk77kQ5A5iMg==
X-Google-Smtp-Source: AGHT+IHXOQcNVNTZVlQWw0MzT+zhVWOzsS+QnOZltlbzAVhrP/4QmXYp8ssHRKFdcPg58XjSCL14OA==
X-Received: by 2002:a05:6a20:cf8e:b0:1be:f6c8:c909 with SMTP id adf61e73a8af0-1bef6c8c924mr16450059637.41.1720047017697;
        Wed, 03 Jul 2024 15:50:17 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:17 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 00/10] crc-offload: Split RX CRC offload from csum offload
Date: Wed,  3 Jul 2024 15:48:40 -0700
Message-Id: <20240703224850.1226697-1-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patch set we create csum_valid_crc32 flag in the skbuff.
This is used by drivers to report a valid offloaded CRC, in lieu
of setting CHECKSUM_UNNECESSARY. The benefits of this are:

1) It's compatible with checksum-complete. We can do checksum-
   complete with a validate CRC at the same time
2) Checksum-unnecessary conversion may erase the indication of
   the offloaded CRC. For instance in a SCTP/UDP packet where the
   driver reports both the non-zero UDP checksum and the CRC
   have been validate (i.e. csum_level is set to 1), then checksum-
   complete conversion erases the indication and the host has to compute
   the CRC again
3) It just seems awkward in general to be mixing fundamentally different
   verifications, and wouldn't be surprising if there are more bugs
   lurking in this area

Additionally, some helper functions are added:
   - skb_csum_crc32_unnecessary
   - skb_reset_csum_crc32_unnecessary
   - skb_set_csum_crc32_unnecessary

Changed FCOE and SCTP input to call skb_csum_crc32_unnecessary and
skb_reset_csum_crc32_unnecessary

Call the helper function skb_set_csum_crc32_unnecessary from drivers
instead of setting CHECKSUM_UNNECESSARY. This includes cavium thunder,
gve, hisilicon, hns3, idpf, ixgbe, wangxun. If I missed any please let
me know. The change was fairly simple, just need to identify that the
SCTP or FCOE CRC was validated and call the function.

Tom Herbert (10):
  skbuff: Rename csum_not_inet to csum_is_crc32
  skbuff: Add csum_valid_crc32 flag
  sctp: Call skb_csum_crc32_unnecessary
  fcoe: Call skb_csum_crc32_unnecessary
  cavium_thunder: Call skb_set_csum_crc32_unnecessary
  gve: Call skb_set_csum_crc32_unnecessary
  hisilicon: Call skb_set_csum_crc32_unnecessary
  idpf: Call skb_set_csum_crc32_unnecessary
  ixgbe: Call skb_set_csum_crc32_unnecessary
  wangxun: Call skb_set_csum_crc32_unnecessary

 .../net/ethernet/cavium/thunder/nicvf_main.c  |  5 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  4 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |  5 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 18 ++++--
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  5 +-
 drivers/scsi/fcoe/fcoe.c                      |  6 +-
 include/linux/skbuff.h                        | 58 +++++++++++++++----
 net/core/dev.c                                |  2 +-
 net/sched/act_csum.c                          |  2 +-
 net/sctp/input.c                              |  6 +-
 net/sctp/offload.c                            |  2 +-
 net/sctp/output.c                             |  2 +-
 15 files changed, 89 insertions(+), 34 deletions(-)

-- 
2.34.1


