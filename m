Return-Path: <netdev+bounces-130826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F598BB00
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292E7283A51
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765411BF801;
	Tue,  1 Oct 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdKWp1Ty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5691BF325;
	Tue,  1 Oct 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782045; cv=none; b=Kwge3dMq5GduvKKzj8Kj8MB4s9r6+LXqRAMllXzZxNJMFEKIGXEtFx93vEJ+z1FngfwSvYcy9gxmuCibbkIvNK3S0VoWfbKP+FilPzZZCstwrgkDBkgNvoAFwQasDwP5qF0UOnwnolw4daF8drgQge4wdYzm3j/9UKnLlxAUxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782045; c=relaxed/simple;
	bh=9NQ+0TZWjiquXsQOOr1sHMZpc9dpUk2gGrXi/p0eLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPA8BwIHlE6xqBWti/ploNdL7Yj9JvyszvCNogzbkvFC6/cJeWt12avkAeoMao1WMIhDU5DpLlT5UYjjPgeYrERG0cPvBRp6ZsjIpFqvOPlLGL25rSVElmhtnmWgEYu6R/QeBjL17uCdZR52oxtio/FGWrU/1J3SaTTdMUNLOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdKWp1Ty; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b93887decso16012065ad.3;
        Tue, 01 Oct 2024 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727782043; x=1728386843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNaj6hMBwRPew2E8TSTXWkEgqsF9LJOIrV1CoqnoYBA=;
        b=bdKWp1TyhZ4OP7Np4OkC+/p4eVlfAwpTpv8WVPQZVdun4j3ytUYjvKc8+AShosD3Zu
         7G/r134ezbdtmCG9J9tsxrIYFlCG01Nk/NBiBJDxxvEjTMt/BFJAf6n+jy13XHSzGfFn
         dP5uFy1lRyyYPSz7EQVfom0RRf1gLqGNSe8MSXJzsyfz3ul9IUdmQ3Y4Ry37IuT/qfGv
         z0g6ieIdDKymwSaTHoMraw4+/jIRssXfitGbUlw/Z+cknRQ7x1asRJ6WAQTAZlVQpFX6
         eDhr9J/NKJMVTR89yre+BQ8P7kFGhOFqEWbrUtcaGJjqb3h7N9GN1ShP9sYMKVpYhPU+
         wBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782043; x=1728386843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNaj6hMBwRPew2E8TSTXWkEgqsF9LJOIrV1CoqnoYBA=;
        b=ZjZivlzwPsiJbZoD9PbZu9/cNbWp+shCiIAT5L0bWEj6Pu6ONroojhU7yR+lc3ZWt6
         Yh7q+QxxZkIGUR+HALzfEWsuAhdhq8Ba8y72x8wpATh41nibXGNE2mBgwYjajXbxsLlN
         i/THlqH0QztAXISmAcy2Cb3sLX7jZHlgBvJr7dldYHPwaXv0gwVTJycmwIVF0EgRxaxD
         09MsOghOVnfo5zGP6lCRqmHN4M6KknunlFeICzuex/5aiHSFC20CX8y2t1MvBwdkGFJn
         O4jzbHve/krjpHm89iKJzE2tIodfxeP0T2+MQqcxBoQNn1rpmtstMDNKDX0agh6oEDeH
         ZfHg==
X-Gm-Message-State: AOJu0Yx2crR4cUPx+QtBnMsnghRzAAu9Je10LcZQ7NPXx5xMwnORm+TX
	g7CUggzV/zJ7gyRNpsXYXRYX6c+m6qAxgXEEx5QYKFVzNe5VapCT++OmvKHR
X-Google-Smtp-Source: AGHT+IEPG+Md67DfNbLD6PrRqcsr9T6hA5w7O2SiAchPFUzCZBO8II2nlbi0ualF+/7vBwYsSfz1Cg==
X-Received: by 2002:a17:903:228f:b0:206:a935:2f8 with SMTP id d9443c01a7336-20b367d00a7mr192716755ad.2.1727782042998;
        Tue, 01 Oct 2024 04:27:22 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e51330sm67893655ad.254.2024.10.01.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:27:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Subject: [PATCH net-next v1 0/2] add delay abstraction (sleep functions)
Date: Tue,  1 Oct 2024 11:25:10 +0000
Message-ID: <20241001112512.4861-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an abstraction for sleep functions in `include/linux/delay.h` for
dealing with hardware delays. `delay.h` supports sleep and delay (busy
wait). This adds support for sleep functions used by QT2025 PHY driver
to sleep until a PHY becomes ready.

The old rust branch has the delay abstraction which supports msleep()
with a helper function which rounds a `Duration` up to the nearest
milliseconds.

This adds fsleep() support instead of msleep(). fsleep() can handle
various lengths of delay by internally calling an appropriate sleep
function including msleep().


FUJITA Tomonori (2):
  rust: add delay abstraction
  net: phy: qt2025: wait until PHY becomes ready

 drivers/net/phy/qt2025.rs       | 11 +++++++++--
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/delay.c            |  8 ++++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/delay.rs            | 18 ++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 6 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 rust/helpers/delay.c
 create mode 100644 rust/kernel/delay.rs


base-commit: c824deb1a89755f70156b5cdaf569fca80698719
-- 
2.34.1


