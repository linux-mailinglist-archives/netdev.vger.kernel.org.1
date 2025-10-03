Return-Path: <netdev+bounces-227714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FBBB5E93
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 06:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762B019C627C
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 04:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DE1F2380;
	Fri,  3 Oct 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPLD3Ddt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE0212551
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465953; cv=none; b=kUdzlKEfgveG00519HGuymxXapjXDXBgYD5C2x9THCl1ZkvyT2MJPhhv/t7J84OuWqPjYqUXccXe/UvublKszONXKEk7zc/SN2QMehPLt7mZNKCMxIOYsFKSZ4VgHOQwGK9Ymm0mTEUNm6MgovpgS5mZZteM8ahkp9hWcqVSYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465953; c=relaxed/simple;
	bh=7VMPKWz5uYNRKWr5qHgYxgxuacRdmA+VUVAZxwMcJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TupkcGVVPw9TzdSTgps5Q21kwni8TKRNbD2hDIu6V50SYNMtSIO1+TpkBGFiiJKqB8wJV6xgbfO+d+c9yypSk/Sq8ljeMhN8wM1VSgFWqSmCdtRIO9bggTI8cRrkZC9zYHiNEE014Bzj20lSeEFae0SJ9RK7GyyKsatA3K9X6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPLD3Ddt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso3174910a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465951; x=1760070751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=BPLD3DdtB8ezPycD7XV3c2ksupBMXIpPLNXQFJ4fnB4qJJGkL9lu8iUiIqg43OJCSn
         fvX/Ymv4ymYTXYEejadMn/MKhLI3GhPNwY1jYT43Y53la8sjKYvqI+IAf9LxftAnbI2U
         xP+NwaMJb6bhCYTMwFCi6q5Tnu8JO753X+Lr4ddfCraPBWOz2fYFovDUb/LClNhWxu4U
         /y70RHJl5VDQGp7CsZhi2FjF15MNtCI+UeMEzjm8XYkrGCwTOjA4r9uOXncxmQtND3K7
         vT3jkq44UdKrRkSzY/pS5mSZh6WI6wFZRW4fMyfppsdHx9Naxxhl7kicLSXNY71LUBgV
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465951; x=1760070751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z24lKsLPaefpARjOZTyt8urU57ilAGB24wkoWzevBy8=;
        b=huUb4A0O6BwFwlgHWcnthzoziTFJCjS/em8CIhcdTaAEwzemhSxEazMhpk0W/pDBBz
         dqgxIaOzimlsl7WRT1SO3sqXBrL6qGNP8RaeTBHAstL+SLPpMfWji0eh2N2430HRrhSs
         TIAagBqd+GRF5fIrljC0+U5U1YT2ax72s5x1sq/IL3SZwMfisEWfqCoyBcttJpgLeTmq
         jkPyW73V1NmamScQHwGSy8zb26vTjNlG8OGc/cvehGhWJs/v8bCrvw7rMk+b97TNaOBb
         rhDp5FYZ7hyHI3fZhxcT+SkOewUG1tFjDDh+03OMahZkuO7+goIZgsiqft9CcDnwNxTL
         lEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXreUrJuaujA6IDvHCpHFEwfjOcB8ORMJXu7OzrA9uP8wSWEwHrC+A9IBGwKtQe0uahOU+mhNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn09b4k5oUkf53MCZNXh7WJCSnV4dCycUBf3HmYPt13fEmt44y
	/7RxlvFYZkwLxyYM9KZp6VZDhqckwnZnu3IuR/Z44tO5yMlUdlh/INLn
X-Gm-Gg: ASbGncvWtRM2VJXCTdbOwsRhRPIRZbror5utwsmH3NqWnzqwzKxXPPek9PebQd5GagL
	xjtJBEwTmxqZngtOEzkfwOoQchhfLgXaRH/jUb0NpQbCj4/iiligcQEajlsyq1w2EZ7iZUY/SBi
	K1KnqKFV0ncSm6qh8E0d3p40xiKIgDxk+Yammjibd4L3JaBFDmbQAPoGuPmFAbCrv3hZ5rZ8Nyz
	h+EsQzzgBOh3tcLBF7Nczh6vXSDwUkOf0bDj999LNLvPi/jWCWE88LC8o4WltJaNc4CkpvM1ABl
	MVrtJmjMq0qK38HTi66QF9dcXkAUJWHyH11GEIzyQsOqlYt16m+fxlbWzlWSggHAAj0FytJWsNy
	xTzblCoxTvlE8J4GScAY0/GD6ANTizDVTJetz2RDMZ4CH4ZpRDrv7fgw65b8/7N1ci1R5nFpF/G
	Qo69gDb7a2kZXvBFr3jM9GOFKUM76ETnZ/EV/pl3VY5hFbxXnUbIqW
X-Google-Smtp-Source: AGHT+IGILMEf9Tw/o2u8qdi5b+EnvPskNraurbyacR0IziRkBvpz30elIe0oEPrEq1mEn5hgoKypZw==
X-Received: by 2002:a17:90b:1b12:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-339c20c099cmr2180806a91.8.1759465950687;
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/8] nvmet: Expose nvmet_stop_keep_alive_timer publically
Date: Fri,  3 Oct 2025 14:31:35 +1000
Message-ID: <20251003043140.1341958-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0dd7bd99afa3..bed1c6ebe83a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -430,6 +430,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
+EXPORT_SYMBOL_GPL(nvmet_stop_keep_alive_timer);
 
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-- 
2.51.0


