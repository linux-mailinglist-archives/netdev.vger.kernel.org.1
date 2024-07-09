Return-Path: <netdev+bounces-110309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCF92BD07
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9661EB2599C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00619B5BB;
	Tue,  9 Jul 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGnHqwAK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49E19CCF4
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535676; cv=none; b=qvsBeTIJWFPe3vsxDgiEHS9OrDKegxwZaVNS4bahEVFuayuQb75SgT8iLFX8tCrDk3eNLDxIXvzJfRMSmNOUeGQQOnAl3Auvh5nO/ayXeRKoXoetW5gk9NQjgu3lLqMrs1nwKQITOzD9+uy8/OmfeOXh0UBVnzzS2TC5qLQGO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535676; c=relaxed/simple;
	bh=bpzhk5cfR3F+pR8M1FUWFRktJXUEzVfeuMK6fUbiyOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVCep40OWCMMREymlEezxtO3rsssLfjnp+jj5z8Q7EDIrMHBcCKnWvIJkYYjMRmTQvmV6Q9jBJFqdXq42Rx5WZr2hbBtoEInsgu8lUX4VBGrLzfx3pTuvbGOJVFzbCCLS8xmsTUgGlKFuf94ebik24v2MadF4VqlB2NKGSpOKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGnHqwAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2KSGK3LaL1Mx5upY3a+zMUsotplQxAZK6hNQur1F1ok=;
	b=gGnHqwAKKphcA+0QPrut7O4zTXH168UG9u0UYpIp+Rb4+/02XO4+VYsIhtjA5jchtuMixv
	yXdeDJcqlzRihIaWI2FriMLb0J1QbDg9KjE0nzCBINRIhmD68fk4audmfA85zUTqXmt0yf
	1DpCENdTT0glHyQ09swxtt/8EewYNrE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-OICq9yrhN1W7CQqmGUOmzA-1; Tue, 09 Jul 2024 10:34:31 -0400
X-MC-Unique: OICq9yrhN1W7CQqmGUOmzA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so651630239f.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 07:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535671; x=1721140471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KSGK3LaL1Mx5upY3a+zMUsotplQxAZK6hNQur1F1ok=;
        b=PnOLnWbLNLBABkluZeFrlShBDKzvxRylVgbcL1ndhdvVSReLivRoKTR02fQQIO52lv
         EdIv79SH1UwIGQHtsgCywFT7eMKEVxrXD3eTsIPeEfiJx64S5eaHMuNeU5HMnAaTxt+4
         MsHv63ENHZ3mvWmjNom9l+EPD9a9lJvrkipCxIl+5vgw+xBQXAMCMfvLWqytkqcAlkzL
         sVRXqrHgZdljsnJ9v7ZAtmpwLVyDauIMMqmG4LieWdf+8FMpuMhvQZYq3GqhMnOSr1zy
         68cHbGTMipYjSywpWqha48a+k/dNR4IIcWqhM9ZrS8Q24Aym5iGttba1KXOCIbjeA9z2
         zVwg==
X-Gm-Message-State: AOJu0Yw0Y70L6SS6bxzjTZBMnQMmZ2Agng29Rb9m56A8pHCRKAUXGCqL
	JOOFc1t6e5unrA8L3zpEI18vxtlCirUnQwN/tSOrFaYVPYRxNFSP1eqb0RaObIWUu4ql4KRVil7
	C2xQpWqGyhtgug6RVosxG5taUNCanKY2oXhGN8pnUqfpsxk+7GXwNgg==
X-Received: by 2002:a05:6e02:19cf:b0:374:983b:6ff2 with SMTP id e9e14a558f8ab-38a5a079b58mr31038915ab.20.1720535671188;
        Tue, 09 Jul 2024 07:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCBm/l4muSrDy7yEx0OBrZXGu/5Ywn0CQg3zoXjkv0vgrA62wtGegT+1Otz+Rekjv0zwGo3g==
X-Received: by 2002:a05:6e02:19cf:b0:374:983b:6ff2 with SMTP id e9e14a558f8ab-38a5a079b58mr31038695ab.20.1720535670921;
        Tue, 09 Jul 2024 07:34:30 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117b61sm1501424a12.22.2024.07.09.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:34:30 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Remove unused struct declaration
Date: Tue,  9 Jul 2024 23:34:10 +0900
Message-ID: <20240709143410.352006-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct tipc_name_table in core.h is not used. Remove this declaration.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tipc/core.h b/net/tipc/core.h
index 7eccd97e0609..7f3fe3401c45 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -72,7 +72,6 @@ struct tipc_node;
 struct tipc_bearer;
 struct tipc_bc_base;
 struct tipc_link;
-struct tipc_name_table;
 struct tipc_topsrv;
 struct tipc_monitor;
 #ifdef CONFIG_TIPC_CRYPTO
-- 
2.45.2


