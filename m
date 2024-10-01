Return-Path: <netdev+bounces-131065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A3498C77D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D85F1F24E99
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95C1CDA0D;
	Tue,  1 Oct 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw4tYrNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903619C56F;
	Tue,  1 Oct 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817728; cv=none; b=S8hCcuuKFYIbxjCBzFuWem++12ZXa5Rp2g/KlxeCk/4HQG+DpBZ4iN33xY+lz2YQsbQiRHw9nGnr+H9/K/IGVrJprlxxJb+jQi9nXRN0O/OazjBHUnVOBWroMVYQOyFKuKeGWh/UYa/n1wCsswhqvAMhXMmwnoXIR12wTCd8rOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817728; c=relaxed/simple;
	bh=Xku+ewVbjAdfP5alpdNBBdLrAkTDbMgUZvHMC8NCgXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbf57VnY46Ke24YX0YjXAlogI/nhEBmA9eicgS0FsiCI8qQhCaYem3qm7zJX8vSwKhw5N+ufXYZlNxLruITeFJt70L9SyzmNZ8+/KZRhUiRwLTH3nkQnjMe3GSCWHL7CwB5D6/5lplIKbDO94/8bcbmyRKcwFnyX+4BfHhoWJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw4tYrNW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3738244a12.2;
        Tue, 01 Oct 2024 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817726; x=1728422526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnZoVBLEmxHrNT3ELKQrHX/XVKYkXpaEPC6Ll206q2U=;
        b=gw4tYrNW8srfzp5IDNbwYaarWm2qmofR6wwTEZiPlDYvomowDpYNwRCw27+bFtRggc
         8DGTLVmteX1QGfNHydQdS9Nm/7Ae/8E2Q1NpcznsJMA5m59MPBgLgQXbt6xBNcqjkCKO
         v2pmatCmLXS1X+bzb0rwfGkcgQ701hI3Q8XeFs+g+LQvhZ6qy04OMeoDILykzj3C9uNx
         ddOihitBbC3wBeDBjXZGoTdTeigrzjGwgFjCRxiUrE3E2sm4fDyUwZkxLKRotAvTWQ+g
         gKhHlJVoXlFdjqwZXQLWZt5R9c5Uixpax1H+GngKHia7tmPCGbIwJON3EII+9T8BX0SK
         oxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817726; x=1728422526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnZoVBLEmxHrNT3ELKQrHX/XVKYkXpaEPC6Ll206q2U=;
        b=a2WASAtXr6AxnbaW/W+/oHV0NssOluHbHingz9GOk1+a90gYFc6k+ZYbLTP9P/nj6i
         xVw6fd0Flt91A7iVOqUlRKm4s4tAadzKuUM9YyO4u1jk9/xkQR8AISTTvhx/L99MBn0v
         z8XBq3DzAb2um4bR1GFjSn4hDDBZx6nQ+9hg9s34MpXxXhBsAKnhaGIpoWCqnfXkd8G/
         4Zs/AXbdMwXUtQ95gzeDbpaEFdFpeWrRTtUFhAt0aet7i7/nXdmLGwiRYfqt5qwVSyaA
         x8Jhu0SNQS+5XfKpgEcw6g/MzQrgAphjD0UoaohvSeksB3M3yMLVtywneriZF6/lVgoA
         rfpA==
X-Forwarded-Encrypted: i=1; AJvYcCU6iyhFe/wTYA0DJel/KyGRadxSPfjfz8qg5AtweDpYTRitEZeEcunFwWIR7Y7x5H88E7uaIgdQ/CEGtEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOawVqZQwf4Rv4QmJtewm9Vj7Fp380M5xeW8pjl/Z6VAqvsYVD
	/022OjvfUYAE19tsQkrTK9xGUkNmbLhXgaO+cEm95b3i2z9j2dlwWh1YU/Tt
X-Google-Smtp-Source: AGHT+IHZgqukkD73SYwu4XSvqLdRQdSIe013tGvmUN4qe530b2xqW7/sQDDxsomcsBYYcaDBm4t0GA==
X-Received: by 2002:a17:90a:d502:b0:2e0:7076:8155 with SMTP id 98e67ed59e1d1-2e184531dfamr1234920a91.8.1727817726377;
        Tue, 01 Oct 2024 14:22:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 0/6] gianfar cleanups
Date: Tue,  1 Oct 2024 14:21:58 -0700
Message-ID: <20241001212204.308758-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mostly devm adjustments and bugfixes along the way.

Rosen Penev (6):
  net: gianfar: use devm_alloc_etherdev_mqs
  net: gianfar: remove free_gfar_dev
  net: gianfar: allocate queues with devm
  net: gianfar: use devm for register_netdev
  net: gianfar: use devm for request_irq
  net: gianfar: use devm for of_iomap

 drivers/net/ethernet/freescale/gianfar.c | 158 +++++------------------
 1 file changed, 35 insertions(+), 123 deletions(-)

-- 
2.46.2


