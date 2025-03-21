Return-Path: <netdev+bounces-176831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6024A6C4F1
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A35446342D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950E230BF0;
	Fri, 21 Mar 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d8VKDnEH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC215230BD4
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591840; cv=none; b=oTqYVY8uHNyzMr5l9jbQq54/ENYoe3RN+S+OavG2iiNOcanEZ5GcyBbHooCfDf3VeuGfvsWrshH0rRq2onStfWICrIVeNmyp4GjT3ZfOmpeGNTW1noScVK3XDXmyfCxWLCBHuXmdHQrkLtOjW9yA+7jyqbVyIhfeYKZswKs3T7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591840; c=relaxed/simple;
	bh=6ehh6nQJ0HH3wOHdp5iMcWDQKGsXGRaX/rvVkjeFkXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv6AoBcJeRaIjZhKU+5eMvdqtoJpqH4msUYFPP4MVahBxNvhXPyFnoB7jgEnTXZ3spj3ggZt5tp/hQYMDuDHBxDh5N0Bf2nZF8vWacLATDDhnmhmysRZHZbaUBiDYqXVqtMq3ct0kw/LzJ9u8bTfJ8eCbG5nPen1snNV1IjoCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d8VKDnEH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224191d92e4so49696155ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742591836; x=1743196636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifjIB4CmHpxYEq1ppElsQ75psRIRpnmUGG2JWuW+pEo=;
        b=d8VKDnEH2LnZdRqrhaAw/rbSJZFRRp+L15HUQ6DNYiQcJh7+uMjWcjB/vFlWGQ1ITv
         OBpWIuo1ceJoqEM7kF1i8FYarsrXS+sRrhOB9/qG/eOioTi/gVm4LZkuYcOush72ucC/
         F1ARoY6nI6xmCV1wGFnwP8n0/fSa3tmWjOrPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591836; x=1743196636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifjIB4CmHpxYEq1ppElsQ75psRIRpnmUGG2JWuW+pEo=;
        b=Uzl/n10k7bBXJELpuOoRhpU6/IJONFDq3Va1dIM3lp4OtDmvc0q8orDxMYbZzaCfue
         yot6ddOyg9AGfC/1Ri6C9ZWsnAnAq63iyT5qc2dcw+ggB5zEG59CxxiD+4nAJk2ykXmf
         saGzLeM+Z85nbRhiv7/MHYyR8iZzjWWx4isUUxnnar1bGbVkKxd8KTux1QE9TGbu+FoH
         FcJMnW91xWCq119NJZlFTHa/KyVS0ji2nbsy+EL2YwcPUJydMgpd5sNvuFOlA1LKWsic
         OieUhGJqmHsQGRsromr0q4B4a1f/hldjTxOrH2ksMhPAe9flsE3Dukp/LmH1eNfxUJQY
         tgAA==
X-Gm-Message-State: AOJu0Yy1ObuEg+LSGVlVhn3KbwVLgUzkp6q3wSHBa+nUpCo/i29aQFRq
	tHwxep1xxLjYnv/TEm0xPANNyfFJLx2W/Kwbgdi4k4l7RYl8sI21p/HR3fViKQ==
X-Gm-Gg: ASbGncvTulKdijtW/mOWFi5ozNEZKVTuLYSMzqw3YPbySH52RtvtV88pBG50/02Hlxg
	LCaeEPDf6PRwpMm/lHM6N64i741X13LccL4ClwOWsrA5sg/KYt3y+a1qqGhEQgZM3l0FMobuSac
	BiBcrw8UyX9ckZKfcGohXQgbVBmRH2BoTiB3sqWuKVUOKG3TEYXABmp6Eh72JiBdJK0RM/H6jSW
	oq6IvrILIYdOnT5IFkkXCNjMyayW0WvCv6Ig2PC/m0CMnO1ENQqSCt7uH6hnnb3OINpZ7NecHsY
	sl9rV7Jakoz8W0FO73B3vB0IjNmPKdRnSZxtRfddOW461w0XJxRD0Jjvg2OBPA7jV+4ELqJFHx/
	LOlCqsFJy7Vb92hwrz84n
X-Google-Smtp-Source: AGHT+IFFE89P9IMfGDNu9cyD1GKxluF/cVa5pkZFKyRJ3+pEDo/Im4Otf97lIJtw5LbSmBaCRhtcZw==
X-Received: by 2002:a17:903:2ecb:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22780db101dmr86457705ad.22.1742591836046;
        Fri, 21 Mar 2025 14:17:16 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4a034sm22386055ad.98.2025.03.21.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:17:15 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	osk@google.com
Subject: [PATCH net 0/2] bnxt_en: Fix MAX_SKB_FRAGS > 30
Date: Fri, 21 Mar 2025 14:16:37 -0700
Message-ID: <20250321211639.3812992-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was written with the assumption that MAX_SKB_FRAGS could
not exceed what the NIC can support.  About 2 years ago,
CONFIG_MAX_SKB_FRAGS was added.  The value can exceed what the NIC
can support and it may cause TX timeout.  These 2 patches will fix
the issue.

Michael Chan (2):
  bnxt_en: Mask the bd_cnt field in the TX BD properly
  bnxt_en: Linearize TX SKB if the fragments exceed the max

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 15 +++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  3 +--
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.30.1


