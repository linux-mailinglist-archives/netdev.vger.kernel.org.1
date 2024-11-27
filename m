Return-Path: <netdev+bounces-147659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B29DAF44
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC473B21ABB
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7151946BA;
	Wed, 27 Nov 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fuKXznVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389313BC35
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747141; cv=none; b=KNpQnguCocZNpSx0e/qFMSAujLixRchGN5o+5ztMvBdhnaKsTdJB3vaik/mYD3q7AV/rjTBzONn67wJLHwhXKq4wOR/D7377lti/RHs17Qe3H/5ZcvwvfL2WrkVeqqTf4aMTHF7jU3EESAM69qlgFZFZ65nET51hoEozDO4zu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747141; c=relaxed/simple;
	bh=Qqyv4UpS+KfbuPdXlQarSH+qycM+w6eYTqufZWGtKpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Utlk8yqXwQBfYpSo9RExpbIOWn8xWYyIvbk+fN9vAfGPrGsLywvmsybtYw0ox+G2dpUgGpprZR3VpxHa2g/bOeFh6phBy4gz0HBS00eqVOg35Y16RS7/IhZBygYW7oXq5dQdI3IFrWZVznZJLq0i6Llt5+UrLU7ci5MQcTzV7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fuKXznVY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21288d3b387so1235675ad.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732747139; x=1733351939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeJzDPYVstth5+Hst/HHmqiqov45lwCN00yajqNohNg=;
        b=fuKXznVYNhLWXF32lXApGHorN11sPUlcJgE9XJgzcs3KSNyTgxVxVYQqqznTnCoG4r
         ATk5H5WXO7L1XHDPZt/lem43/HI7t94/amNRN3iF/2LbmcLOl+TMMvWx28BfGNEIgUPq
         nD8WwFBYVvmP0A8pmXjYEVMlROm+R3OcVxvwVydHBrXrtudP1Q/vYhJGa5uF/5oHmT/R
         u9z0niF/Sh0b5N+4KZg+0PURsITrjobvoq6ovneGTkNhwcBgHnRKnCYVyofrpHqn66r2
         WU14gnE3gx3kUMa/iwZBIzGuZhmGHhGeDAOj0kcpCD3eqUOCJbYymhrYlUly+B5N3tlW
         Hcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732747139; x=1733351939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeJzDPYVstth5+Hst/HHmqiqov45lwCN00yajqNohNg=;
        b=tAZZpqCmmF69Sf/bMpyE6B2UV3hSPlfvA+BDwFcCZdGhS+M30M1ticXPLzn5GCVSBH
         aGcNf5JYU9OlYRWB/h3RK/46WasBHDSWPt1hr0CXx0XEUEhvmbTvcsClqXJXmoGdn2Ro
         02qjvnbiK0VZ7btwYrpMlg3SHYHlzBC1+AyM9xw2G+gEDtz6J7Z1qRG1QQZZ8yYoedSX
         yxN4rIHELFMZoOaL0OrOf7RhIVA02prBGfSqZmv0RGJDg0Ri9BWO5oJydBQIqDZvkbGf
         0z4VL4zXEP5/S+iN8irqP7n034Ar4HpH0wi7unE4olr/mMpTHV3F/tzKR3cAe9g0wVFk
         dbdg==
X-Gm-Message-State: AOJu0YwJWRip8VB6UIlUGjxcCyKfo44yR6H3cCBQyqA5XEEZPCdPX3eB
	iJB4TaQ761FtH9pBys3SjHbpeKWaEF4PA90yweIHFq7goiCFbigmoJkdQFAZ1AEUBWrY0h9eASu
	G
X-Gm-Gg: ASbGncuob6ob0Kt6UjTHN6iwgAEMLlqykyxUnGY7kEsZPnP5kQhFUQKacpSvWGj3bAA
	rGwTK8ScX8dlxMF0WoLKf7UBEJ9AbqBUpgMk4GmSvzPqdW+rOGmRfCxzXAPG9eRjEmEAQDYcYzv
	Nt27RkuLXIM1ocIruhJpGP1bNKH5/jUi5JVjstmBTNXg+uWWJddJ+ZJO8kzkICrbZNGX9SVSUHN
	ThGjepQ0gxeg8PWnh2EtETjA6ygX2gHnA==
X-Google-Smtp-Source: AGHT+IFwMISSBO6JAB6wMJp4hCH3mb887JB3MDKgXt8Wwzt9NtevWAwqzyIzc0ic65G1DnAwz/p8hw==
X-Received: by 2002:a17:902:ecc6:b0:20c:c880:c3b0 with SMTP id d9443c01a7336-2150109db32mr52218355ad.21.1732747139647;
        Wed, 27 Nov 2024 14:38:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521967283sm668245ad.148.2024.11.27.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:38:59 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v2 0/3] bnxt_en: support header page pool in queue API
Date: Wed, 27 Nov 2024 14:38:52 -0800
Message-ID: <20241127223855.3496785-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
separate page pool for header frags. Now, frags are allocated from this
header page pool e.g. rxr->tpa_info.data.

The queue API did not properly handle rxr->tpa_info and so using the
queue API to i.e. reset any queues will result in pages being returned
to the incorrect page pool, causing inflight != 0 warnings.

Fix this bug by properly allocating/freeing tpa_info and copying/freeing
head_pool in the queue API implementation.

The 1st patch is a prep patch that refactors helpers out to be used by
the implementation patch later.

The 2nd patch is a drive-by refactor. Happy to take it out and re-send
to net-next if there are any objections.

The 3rd patch is the implementation patch that will properly alloc/free
rxr->tpa_info.

---
v2:
 - remove unneeded struct bnxt_rx_ring_info *rxr declaration
 - restore unintended removal of page_pool_disable_direct_recycling()

David Wei (3):
  bnxt_en: refactor tpa_info alloc/free into helpers
  bnxt_en: refactor bnxt_alloc_rx_rings() to call
    bnxt_alloc_rx_agg_bmap()
  bnxt_en: handle tpa_info in queue API implementation

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 203 ++++++++++++++--------
 1 file changed, 128 insertions(+), 75 deletions(-)

-- 
2.43.5


