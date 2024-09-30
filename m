Return-Path: <netdev+bounces-130479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4698AAD5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D580F288A68
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83E1957F4;
	Mon, 30 Sep 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mRj66Vx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC11946AA
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716427; cv=none; b=KI6CRkV10AVpdfC0FpHqWO4L40cFJfvRcHLG/dE/NMx/JLSX+iyMjecB+Cayh9PdQ3vw0szNqbEuZt46cSY7Q4p/RD2sIiyqj//r8RrNfVwK/MFTiYgm+/D65+dHdZZJPDb26WFvv+on9QB/vY9dCCLpTV9cPp5d++SHQU6YEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716427; c=relaxed/simple;
	bh=bdG4X0N4swejiY1Pr7tnHehXnBBeKEJcMObCF3RNAZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvMSnJZ5CquW0bVNwAEPvuFnE8YMmHGIyhHe+RNS+EQ7kVRd8YppvW+KhH+qp8b9iUGf0kkD4ObUWYlu+Oyi2vmPNkRsx7zmE/huxpnzy5AlazwcapcFeu1Xfo3T/ZIOWw8AlxWRt7atRqwtnQK9RdJQwCNKeYZd2a5XT0PwZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mRj66Vx5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e07ad50a03so3450784a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727716424; x=1728321224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewHkEs/55CbQPJSd8p1HVc2KzJ7wL8ZKdD4xY+nRkAo=;
        b=mRj66Vx5d1K1Amd+p/C9r8DEeKf+OHRazdCiD/noZsu+WHgvyCQtri8VRQ+N8owEjI
         pBlsBlJ9O65kmBtXCYzlnAcgHzDHR1E4FFaA+63A1tiRbkYUSRcOM3muvN1MyzGN78nD
         aJXJt22GwUybBtigqg8Ci+Jv6oaRn3Dg/E5OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716424; x=1728321224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewHkEs/55CbQPJSd8p1HVc2KzJ7wL8ZKdD4xY+nRkAo=;
        b=KQCHhDi0ftaAbui1FI45f8XSF/e0XMaTkToLQKDaRse/Bdbc9cEqhIqSAXXC9MTlZn
         bYKdzkaCDVh60O/r6qkt3zpwo/M4319k/gOMyfQ9/8JtlKaZ1BL4C8RfZwjCGj9+9Kls
         Bs7xKDe/hCZ3Aye5/oJAcenQzwnxhBq8SskirwwljQoRT/D4JOYzxYPwTyeEAHRWTq1O
         GfOyB9y0+RDnEJYrDcXUpUfc4/RX6ZG9aurcVUjvLe9/y9zC2SZfddQyJHs+F+1HmYNO
         hkh2SWPMnGl4dNpRU5zLYOtnZaCwdyzDOuc7D9zJQNtkI2RwfXMV8td+uD7b7iv9N8Ng
         6wLw==
X-Gm-Message-State: AOJu0Yzb4vZLWyr0qlAbGbLmhkbNaSWizZOejVRhhBtNSPBMB2q31cxG
	qJXtwp9FsTPTT8T5Sy66hij9wAZorqTH5qix0whfrJd56tifiQ05J2RjjClLaatOn098ZhGIeJA
	aUo9+Q9q52OT4nO+WK5V6rfL9J9ESVs7DDszQUsL1wmVFNl9CSfbVNonXwkBOt0+ai6bTfjFeNP
	qPB6HEV8yc4VD0Fsbo1jtyVN4ybt1Sa7czYSI=
X-Google-Smtp-Source: AGHT+IEkPF98OsudfOg4QDza1DHSAho2n5XtlIzq7fEFmYgNWM+YoG1Qp5V4gfN/U4f54o3cVbNMWQ==
X-Received: by 2002:a17:90a:898f:b0:2d3:db53:5577 with SMTP id 98e67ed59e1d1-2e0b8ec65a9mr13926058a91.36.1727716423996;
        Mon, 30 Sep 2024 10:13:43 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e15976sm8188364a91.41.2024.09.30.10.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:13:43 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v3 0/2] e1000/e1000e: Link IRQs, NAPIs, and queues
Date: Mon, 30 Sep 2024 17:12:30 +0000
Message-Id: <20240930171232.1668-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3.

v1 was an RFC [1] for just e1000e, v2 was an RFC [2] for both e1000e and
e1000.

This series adds support for netdev-genl to e1000e and e1000.

Supporting this API in these drivers is very useful as commonly used
virtualization software, like VMWare Fusion and VirtualBox, expose e1000e
and e1000 NICs to VMs.

Developers who work on user apps in VMs may find themselves in need of
access to this API to build, test, or run CI on their apps. This is
especially true for apps which use epoll based busy poll and rely on
userland mapping NAPI IDs to queues.

I've tested both patches; please see the commit messages for more details.

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20240918135726.1330-1-jdamato@fastly.com/T/
[2]: https://lore.kernel.org/lkml/20240925162937.2218-1-jdamato@fastly.com/

 v3:
   - No longer an RFC
   - Updated commit messages
   - No functional or code changes at all

 rfcv2:
    - Include patch for e1000
 
Joe Damato (2):
  e1000e: Link NAPI instances to queues and IRQs
  e1000: Link NAPI instances to queues and IRQs

 drivers/net/ethernet/intel/e1000/e1000_main.c |  5 +++++
 drivers/net/ethernet/intel/e1000e/netdev.c    | 11 +++++++++++
 2 files changed, 16 insertions(+)

-- 
2.34.1


