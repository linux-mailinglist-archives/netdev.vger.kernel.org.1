Return-Path: <netdev+bounces-220130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5AB4488E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BF8A46738
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428D2C0F64;
	Thu,  4 Sep 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWRsPJY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA72C032C;
	Thu,  4 Sep 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021562; cv=none; b=cf2krwfYx1Xde7/6WvNkaq+Fq7fR77dw1RN1sMgHkAESAK9WJ+8okfPdRXrXB5hsB0dwQa3KMkLdX/O2+jlrKU1lOr+wMvHhUmukYosNjYRhXMvkzHrZqvCtNAr9csMVpNqxyf463sTljJZZCYBLcSqaH+CiI04m0LKf/ecxtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021562; c=relaxed/simple;
	bh=CA9EDGEzGCJYmRbDXuxEzAFjkmDo9CGBZukFU6Qlcy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwbql9C9+lEn0xGzv4a17jF/irM6AU/9zDwfNvJ2rCpSV7aNrtxk/azA3Ed22IZkPdl9qLcu+Uf9TxF1jBS6eVeLHkuBz0T3pSWJ74SIPAoX44DtoEtxKqBSUlbliq2rUVmre13oA7X8buiJL+ydneAViq08qQaDzSME5RnnywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWRsPJY4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-80bdff6d1e4so162952085a.3;
        Thu, 04 Sep 2025 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757021559; x=1757626359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiQlGZ/C9rse9ilBfNrRdO+ytUNlHw4XOon1PrdZMm4=;
        b=fWRsPJY4vsUHbafX3/+05/GZ69kDavbILMBcjgHdVWijd+cDbUUzjpzjaj/iDLsU1m
         ymyAlpwF08A94lC4vLewImNkrf2y6Z8zlGbYo8PBL9ztFfKFDzszB7viMWf1rUKQgeqg
         qBhGnQxsT0LZWph88GOjQyUFFRVxfky+IeuuwvyTcyEARQJ99SHa3G71gLBlECChBIVr
         ImPdSTE8PXBAUiVuhxH7/ejflhxafhsVYFSIOx2GpLJ46WpqeBJBPkKsLm26sl1eayZf
         nhyEKtkvx1EiXKitBfywrj1aig/mKdfdOpyIk0RbXJ5nEVya8sVIZZ30ZQC6bt9P1Uvm
         gq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021559; x=1757626359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiQlGZ/C9rse9ilBfNrRdO+ytUNlHw4XOon1PrdZMm4=;
        b=ISXy6ro5CmNDCupsiGMRu1HPFrTCA+SEULZw4RwJ3YLUY4Yb62KzApN5L6yimB2EV3
         0FYV6znrOccg9KKKaoGZoZoddK7giEJSjXLuFZEqBUmOoirFXs0NM/XM8wAVTl4rX4L4
         uoPQIT/HK4XiaKLHeGDu7++9v8eDE7f0x/sLR/U8js6iz380mxTo/5gpTgsvjTlOACBb
         sxw/z4sGXHoLSG5w4Y1vw8WmJdkR4xp53jw0NJwEA+yUfE4npNfgh0lsNZAmzVPMnON5
         3EZgMNA7uHH4LlWPDaLbv1wFSP/R5wXNiLvXGywBxYYsXZDwZCGWSzd4nUUcQ9q2DAR+
         JsnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0R9nsZCkTi9E5Q3kyBmVUJu7KWCP+j4oDm2VG9L9KwJ5Vc8WWPrRZxSh8J+VrfILpvZfhDk0HdbLzLdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtpkMv7ir1uPSWun+UPkFQwwLD+aeT0jCyibAgYHsaELqWW74
	P85qyuXJ020D47jrVl37h1vkA8Ez2wv5qMG6FpxAq8P65LgKTveD4Sre87HKog==
X-Gm-Gg: ASbGncuyU3ZvpiCR6BRkDos7fnNiGMbCdUNy3Q8fDvMMrrkDBTsSE6jz8EannL7ed3J
	EXt29iXZZHF7T96EZw1K4RHXChuoeIYrrAeZjAZSDkBy+keP0RdTm9JfWz4V23ddNCTpNuZs+3r
	RERKUPgs+XZufM3Ngf93z9mrrcXO/5cpfMdjYj8aqp2bz79O4vqyodFX35ML7mDFDytnGxlzxkJ
	TiGib4RIPuNcr7U0Xo4r9IeS7VL1v23ADt5y1zmOytTS4PsIjGzUVa1wsDnTfI5fTBiooeP75T3
	N9cQiGZS5sSo4CZYy19xko26OoqX9caxe6kVAWjI7PoRggDcBJrYiMQ/iiR5W1e9UgyVdSH2vms
	zEqz0qKvstxbZc9VreIuNISoIBjo40QMwsqISEJXY1tgCmtBUj3ePFftDT6D77Qm9lYg7npQ=
X-Google-Smtp-Source: AGHT+IEX9DX3HrEdBrePkobi7MjVYIUxvz0xv/s17E/klLNvnS90SGZ7neelcaD/b0IshyGCidEOrg==
X-Received: by 2002:a05:620a:3189:b0:80b:4b83:5fae with SMTP id af79cd13be357-80b4b83643dmr863293385a.44.1757021559248;
        Thu, 04 Sep 2025 14:32:39 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f635cbesm35473501cf.5.2025.09.04.14.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:32:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 0/2] net: thunder_bgx: convert fwnode to OF
Date: Thu,  4 Sep 2025 14:32:26 -0700
Message-ID: <20250904213228.8866-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVMEM support addition and fwnode removals in favor of OF

v2: split up patch

Rosen Penev (2):
  net: thunder_bgx: check for MAC probe defer
  net: thunder_bgx: use OF loop instead of fwnode

 .../net/ethernet/cavium/thunder/thunder_bgx.c | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.51.0


