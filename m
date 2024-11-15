Return-Path: <netdev+bounces-145306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493839CEFEE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2665B25451
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01F1D0DDF;
	Fri, 15 Nov 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N/74wbDB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA151BD018
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683773; cv=none; b=L303kLX13O7d7wPI8/2FoQ56EgbwRf9wTHxaas6AvKOSC2yyexUT+rk/aemhyCyLBRzoG9ZuzMVTeONd7ssI4cpYhhMS92AKjD8vvkoP02gPPIp/2iN0OpstORgtI5wnFsbdD0OsDl1PRW1qtZO4R0ny8MbiAxeW3AWeFDvLATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683773; c=relaxed/simple;
	bh=24ppnNYs4OFun2ZD6eIUZMpdSyA75aSa0UHIDwwgLAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMdMnpYIL1e9zwKzwDRfc7Nt8h8LB1cu6lxDlY5wy/3DBnkkx/RmfVzY7JtwFEUxiwe2owXbZqcLj+7XYJ3JntWOC3aT40mg8HAbBBpu0zs0pzmxNzk0uN9G6Uq2Bxry6oVIt8NDGZfbRjLR8lgZxm9c1upi+oklJvQBo5WTaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N/74wbDB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso1453649a12.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683771; x=1732288571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qiC7vl0hhrTY8OcTt2wJQV5929BFV/1UjVpmNRwwW7I=;
        b=N/74wbDBiu2UAZXDQ1+xtYsJhd6Mix1JK0uT1lOLNIWr9h0duUDecFyX5/JsZtKWGo
         ORBZMTGMmaPYc3fgCfcX+vtPRzw6LeiwzGXeEGG2en7TnyewG6Bv28Qgr8Qiv84hgQwC
         4hhBCFxFzU4RYbyhikF/jViJ/oV4k5qs0SDvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683771; x=1732288571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiC7vl0hhrTY8OcTt2wJQV5929BFV/1UjVpmNRwwW7I=;
        b=FMV7DhAUD4fvnrH7pgfanu+40z7VVZJkyehT4V2+KCE5oGwi6GmcXYTyDpC2DKi2gh
         CJNJHDQxVdyAIlVVAwmxVAK2z/l2ymF0kukMi2KCDayIS2sYynxdg/dH+h/ryzyN6vAt
         5yO4M3/q53MGOOjdiYAiaM8/w0vc2iDXa+BiH4pYGrOLdrryiSnDZ42uw46mr6FV25Pb
         NJq3hKh7+zHf2AUBSJdANt1+th1TejoKv3hGsZRdzCsfhKqtVE2M22MEkH4dGSoPTDrL
         stxkxu680dsZ2BHQ3O5GUbKR+ZDWVJtHMZJCUoKe5nNghspmJQESCEr0wzsMx4w0Sebs
         yl2Q==
X-Gm-Message-State: AOJu0YwOQiFOdEFZwupaY1p/Uo1D9SyBlf1aDmwbnEm5tgfGzL5VC89d
	OIpoRKJrob0Ee/967kJczlaO6Z6JqR8rDOI/tY0GGbLjZIcXR03PD/PNYjNmvg==
X-Google-Smtp-Source: AGHT+IF7Oj5BhDQUZ+z+xJjCWUzy/haHPWituQMOl3iSPrt9YQberxIIyyXPjorT7V4iMft4vgxSgg==
X-Received: by 2002:a17:903:183:b0:20c:5b80:930f with SMTP id d9443c01a7336-211d0d4bda3mr37692355ad.12.1731683770885;
        Fri, 15 Nov 2024 07:16:10 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:10 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	shruti.parab@broadcom.com,
	hongguang.gao@broadcom.com
Subject: [PATCH net-next v2 00/11] bnxt_en: Add context memory dump to coredump
Date: Fri, 15 Nov 2024 07:14:26 -0800
Message-ID: <20241115151438.550106-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently supports Live FW dump and crashed FW dump.  On
the newer chips, the driver allocates host backing store context
memory for the chip and FW to store various states.  The content of
this context memory will be useful for debugging.  This patchset
adds the context memory contents to the ethtool -w coredump using
a new dump flag.

The first patch is the FW interface update, followed by some
refactoring of the context memory logic.  Next, we add support for
some new context memory types that contain various FW debug logs.
After that, we add a new dump flag and the code to dump all the
available context memory during ethtool -w coredump.

v1:
https://lore.kernel.org/netdev/20241113053649.405407-1-michael.chan@broadcom.com/

Hongguang Gao (3):
  bnxt_en: Refactor bnxt_free_ctx_mem()
  bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()
  bnxt_en: Do not free FW log context memory

Michael Chan (2):
  bnxt_en: Update firmware interface spec to 1.10.3.85
  bnxt_en: Add a new ethtool -W dump flag

Shruti Parab (5):
  bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type
  bnxt_en: Allocate backing store memory for FW trace logs
  bnxt_en: Manage the FW trace context memory
  bnxt_en: Add 2 parameters to bnxt_fill_coredump_seg_hdr()
  bnxt_en: Add FW trace coredump segments to the coredump

Sreekanth Reddy (1):
  bnxt_en: Add functions to copy host context memory

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 316 ++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  57 +++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 160 ++++++++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  43 +++
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 173 ++++++++--
 7 files changed, 658 insertions(+), 97 deletions(-)

-- 
2.30.1


