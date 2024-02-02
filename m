Return-Path: <netdev+bounces-68529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E18384718A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3192B25AA0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833864D13B;
	Fri,  2 Feb 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/0OydVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EA1854
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882368; cv=none; b=cCGx4xaEpzRA04UgdjGGvohmMge3xGaUr49PpXj8xavmy6mzUraHmjJ6kFFCm1XE0UvgpawU9D7KL9FIL/ruPpXNW2mQQ2+bK4Nw2tKo4+iTYshToGHvlikOqgtPxjXBB+T+/OLk66wJ5P/eBQWa7920jsoEi2nCOczIBGg1UJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882368; c=relaxed/simple;
	bh=ViVx0LZEz1D8FJ1UqK2axJHX2VpK1bP17uBrmC6MRV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6qXbgzavj3BkrxAoGy8+7l1VeP9K0uOKpT0NPfIiP29DzlvMsHtYb+EULuel+yx3kgsCCp2jeroG2cT5Pl0S0fkRWvGu73UfcgrP43FL+a6KSRTJJFgrE9A3LKi+JaB6TR0CoGCIIThHlvLhag8yAUO7yR9bkR0jJqCl1f8NYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/0OydVV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so1189617f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706882365; x=1707487165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0/f1KBEDc9h9wv0Wfe6ahUXxrNRk6QVVEG3ImEAnyA=;
        b=L/0OydVVprUFTf7+bEfdaycqqLuHUwQhNAfKVx837Ito1n/vWXgoEEtvhKlCLNvGbc
         Gb03lzu7GDf36f0EI3atbYcAVz4sIiE7KAI1G8NtccA4qhFzKWL98mIA0h+AqDdky0Yi
         62e5zcNn7TktATGhqnYZu/7tbD/poWq3aAsvdKPOCVSQ83npVO5w1X4xMmGJzePRqXKa
         rF0FiImZgodf5b6BAfE75J32zhgVTxVZ1+1wtF0LK0kesWKt2SN0ypz4ZxDupZ3UKo7V
         DGUCJzP8uIODqf2kW/7hQes717csZRgAcTu4FfEx9MbPVoT6riihG9VKOKdOSB3Hp8Jy
         KEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706882365; x=1707487165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0/f1KBEDc9h9wv0Wfe6ahUXxrNRk6QVVEG3ImEAnyA=;
        b=CAuD0pfD+B73NKiUcAla7bTFscuGlbvFM03OdbSxv5ytTPHmlt5PN4flPlYX4Wt2iw
         /75QqOdnd0hdqHrSxQ0A5Jf/izEP0A/DGvx0gpe8dzbyAgHn535925CGJcHREil/fAZW
         yX9dL+DyYPG+6eTmPOkBKvTebbqfZOnHRW+shMLX27NfjfWixSQwycfhzSI0CFk/hrXI
         QsMkkerlSOJ6r1z4582a6eFBLPnNiHUoGP0eNs5131mYIprRw3YMMgMJ3Jhdq9OkIbc4
         B/7LNHFAS36V3OzjxbiAQl43J5CMrmcpj5uIjFogWzDvWlO9hN698yRiO0gOW55t+i2L
         4u7Q==
X-Gm-Message-State: AOJu0YyJ4kCvueopnYDjljg9lrpK5OsKIE2x5VmQ6AWQ89a/aDJ2Frsa
	L44O5fzbHg5ltcVDr3Sj3cCDXJ1nlJWOPdq6+PE1ZsD0KiqZ69Bp
X-Google-Smtp-Source: AGHT+IHELdy6md55+9CgmHHkbhBEC9cnB7uQ14nxvhZy0etGwNkewBITn330XBTHbEqYZl3B7ho2XA==
X-Received: by 2002:a5d:460c:0:b0:33a:fc81:49f3 with SMTP id t12-20020a5d460c000000b0033afc8149f3mr7034981wrq.59.1706882365155;
        Fri, 02 Feb 2024 05:59:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXT7+8M+kY8at5pt4dbkcxi/2XKPSiWMb3A/yejr98P3CpxPIt8DulIKfVvAjqJOvrPPHgNxWIFNl2Yo6kVGvSAtVTf4zB3yvPuNfEi7R0X4IHTS9TEwspw9n8fqiObgdRLq1WBi8eYHaI2Py3YQIs122VMEOim8A4kti6KlDQLyAMIktcIsYGp58ZBEi7ESS7MnnHH+vm/a+ODKBJ/+8Pdi426IhqVV0lqU0Oo7PXWKXjP1RbcMo4vk2P/zDkVJhGhONJ6gqiv20jnuaql7Ql/xhPmbnrgRPKpr11STol/9PSjYqbDOBQWRBQSB4c5LAEjyz50IDfw69Q7NMr+yKSfibxlL9AJkoR7
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b0033b1ab837e1sm2003952wro.71.2024.02.02.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:59:24 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v3 net-next 0/3] Add support for encoding multi-attr to ynl
Date: Fri,  2 Feb 2024 15:00:02 +0100
Message-ID: <cover.1706882196.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset add the support for encoding multi-attr attributes, making
it possible to use ynl with qdisc which have this kind of attributes
(e.g: taprio, ets).

Patch 1 corrects two docstrings in nlspec.py
Patch 2 adds the multi-attr attribute to taprio entry
Patch 3 adds the support for encoding multi-attr

v1 --> v2:
- Use SearchAttrs instead of ChainMap

v2 --> v3:
- Handle multi-attr at every level, not only in nested attributes

Alessandro Marcolini (3):
  tools: ynl: correct typo and docstring
  doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
  tools: ynl: add support for encoding multi-attr

 Documentation/netlink/specs/tc.yaml | 1 +
 tools/net/ynl/lib/nlspec.py         | 7 +++----
 tools/net/ynl/lib/ynl.py            | 5 +++++
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.43.0


