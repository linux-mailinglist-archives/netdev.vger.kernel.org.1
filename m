Return-Path: <netdev+bounces-156518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA3A06C36
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853943A77E3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129AA19ADB0;
	Thu,  9 Jan 2025 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMU3tKUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F6198E77;
	Thu,  9 Jan 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393313; cv=none; b=lwn75JjpJ/6Ygqp+hTAeH2yMpucecuKJNSB39jLIEx8zN/6Ne5P7wGqEUOFIAN/q6YEa3g0Z62CsfOi7iI2wpS3sfNocsjAesdxz1Tn0J2J7cm/G4t4BB2GyzB3BAElBqM23QXRk/0pUQUPOBwx4QAEXfsL5zb4WMPQNUhWCSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393313; c=relaxed/simple;
	bh=CJ+Sz3VRSgzZg4XewFSs+jRIjAPqqLAeY562oCmKo9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuYQvp1+wfPPa1QQ9h2z4VcuPoKyasvOXSlSJIAKG4SYOIkcX+h5K35zxoytgvfR7C7eKY05SGa5rBk76FKAoHUlaUE//ZpXhqkWkfo1Aa7N6gzug6kfq6Y/Yrn2vur7MtvHvxNgsnkxeK0BI2I+69CuwyzMIKpOpOD2TIjbeTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMU3tKUY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f1be1daeso39886585a.0;
        Wed, 08 Jan 2025 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736393310; x=1736998110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbEbQtkPmS8Lo6Ovvd4eTHWZc9XmLg0j1ZOSK1JWbsw=;
        b=NMU3tKUY13bnBDrEp97QUHnj+2JgB3CBBBq1652MS6z7eOu1sX7sutrK/n3fd7XHoG
         P121RESpYB/Q3IFJzSxk+lF9IpDemrPzNzEaBh9PmTSSmzGD63NA0nCX89g9ViHo6WWe
         VpASj5uB7D94FZVb1SnG+T6qFdX8HKhuVL0tpWGZpM/CXvtpLOA1QHf1mwaLSdzEo5Gl
         2NAzmudA8bdTCUbG92vHW0eO6t82D5/kpUshoMzWBvxfbKZ+rZIjpUa2df33VgUpuOk9
         F7MnWbgow/xmhdXEkeaFLAHKi1wn1aexVWdu2bQzx8ytkUPv5je7Gb/mXH4LMXqBRXw3
         BW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393310; x=1736998110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbEbQtkPmS8Lo6Ovvd4eTHWZc9XmLg0j1ZOSK1JWbsw=;
        b=RjguFXTB8ioGIyFnOpdN2run64XzA1xy0NoVijD9AJFOunbXvczKjSBbVOiX4m886H
         U+TAf2Se53dbXHBX5D5bzZdhvBp+RxQ4N54+v30AKKfBNT9veFWWPa0jzxoBShfyv/0m
         W/MI0pxldIu6Fcag1nxK8/+Oh/SV0q+WRJN1gQp52FSBD9uBuTv0T/zhwZhSlrDwuIbW
         zkPShGWpmBwz7pRkLZB0dFsWlbAT8Opdnnu+3f22L5NLnwcC0FDFoflL0X0kBRRUqBCj
         Jkg26ZyDGZ4RBr5QMQFlWLRb+UBSb/emoZdLApTsGkRDdDfIMIdA1KXB1egNNcrldDd2
         xSng==
X-Forwarded-Encrypted: i=1; AJvYcCVqoJUH/AVg/Zg5E8TL3Y7cI2e6P3RQrh3MuFhUdhKvpAq4i0yrrZlByGD7Ml3M5wDgw2uN5nYeL1jguIZw7Vw=@vger.kernel.org, AJvYcCX0qs4o21m37zdESilxUo2BeCdxAcbnJW6C90AwQbQov8DtsxAz0XN60ZZKPCs4h3gZjbRU3xVh@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjX3cl+Y+qaGHAYqxDz0j6IPQwz1cNKpsLwMMxuGvZyPivFMB
	QIwEVPLJBu4AzB1s82jXmVGpUtRY8Tr8HwnzZVmQVQOMJj1K3DUkAxQkluga
X-Gm-Gg: ASbGncuDaMb796ZvAjUcebL/UA46+y+2BUOLPdiJXWjKEyF3Yjk+j8U59k8SBd0Flvm
	ExlFOfsNQH/qyqbKzMU1qXyJdq/heKbgjftngkQa7pJuxZzhtLpww/LADCGo53owexGLzrrjXlt
	+/eL1yeOZcY3MywlMXKARjMKP0Q7OHohT5lHbI1a4MzG6GG5+iKsICT3qvHJ/tC2k2hTpRsjRE9
	9fef+93B7PuNKwoZbjmComgzQyJxZKu7Ng/eZ8TL/5js9GSWjg95hfqqw==
X-Google-Smtp-Source: AGHT+IEEXg+vOUkSNTGkO+BJFxHu2+AME8iS0mDYdKrJKDRIO3CIIxB7EgiKID/209z03BDoPaiUCw==
X-Received: by 2002:a05:620a:2916:b0:7b6:c6f8:1d2a with SMTP id af79cd13be357-7bcd97158bcmr599215385a.28.1736393310275;
        Wed, 08 Jan 2025 19:28:30 -0800 (PST)
Received: from echampetier.lan ([2607:fea8:1b9f:c5b0::4c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35160c6sm25547085a.114.2025.01.08.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 19:28:30 -0800 (PST)
From: Etienne Champetier <champetier.etienne@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Etienne Champetier <champetier.etienne@gmail.com>
Subject: [PATCH net-next v2 0/2] ipvlan: Support bonding events
Date: Wed,  8 Jan 2025 22:28:17 -0500
Message-ID: <20250109032819.326528-1-champetier.etienne@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No changes for first commit.
Second commit rework bond_macvlan.sh test to add minimal
ipvlan over bond testing (asked by Jakub during v1 review).

Etienne Champetier (2):
  ipvlan: Support bonding events
  selftests: bonding: add ipvlan over bond testing

 drivers/net/ipvlan/ipvlan_main.c              |  6 ++
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 .../drivers/net/bonding/bond_macvlan.sh       | 99 -------------------
 .../net/bonding/bond_macvlan_ipvlan.sh        | 96 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 5 files changed, 104 insertions(+), 100 deletions(-)
 delete mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh

-- 
2.47.1


