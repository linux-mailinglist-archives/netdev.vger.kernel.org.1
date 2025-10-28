Return-Path: <netdev+bounces-233633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71257C16A43
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 545B34F04AA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E583502B5;
	Tue, 28 Oct 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YbW11ZoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651A35028E
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680438; cv=none; b=DXVvHtTdE0WLM6JdaE+ByGo0feEQMgLO8WG7QYji1ucMmIdQaQYOOnppTnixHWIUWHNk3JHQSJGtLjnNFitezKlFcp9AtpK4J0tKV5uphPygnLzU+X6TRtiPXXWMzdKKJZyYrNal5CXG5DGER4FO+MbkwDxA0Bu0WUJrKehKhdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680438; c=relaxed/simple;
	bh=tgB/AZnbeuD0wFMxUomPwxahzb/dfifrJvnPy9HO5eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CL7e9hpwfV+aO+RqWaKVmhC3tVKzgd1tKCOQkTNxwdEioJxO61fYqCnGHNl10+yhaFQ3vaxVygVcmJy+AKEXrZAZcvtkCFaQAy5yIDrg4UPUgX+kNyplLKNcOwJF8x6//KaarUpa+yjR2vrE1yzqfDyT1clm0N5ntNc7zmlf65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YbW11ZoC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso162033066b.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761680434; x=1762285234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/D6hJNu9FMzxEjXTgPBSnwhz+7xG0QCIYJVHBaaoaUc=;
        b=YbW11ZoCfup9eyZrFDNTqQDf/HUBES3qwJvW9e14Y0tIrqQQXPryKaBMaOohuv3CYM
         qgl9uZQADvWvYJzM/gLAVNPjtST25oJ0OUKUvaNDqFXPZi0UbW3DJUpO6r6yztMARClo
         CXU7NbOJmV0XJiPAPBU8kMcNgvTKFho48FGA7FOj9Vx2eUfSVoKnH39AasjsUsDaw/2d
         /HFJyKolufTrEfAS8oheIrbm7kP7Jeoy6cyRHhCMyuhmTAwQ3+SEMUkXzh02f/Kpa+gV
         eRlJQXCj2AacU7EjV8raykzF88NgR4lCkb5Y9/TwwhgY0eigJ6lQyy5RukLxNp5nxWNg
         WVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680434; x=1762285234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/D6hJNu9FMzxEjXTgPBSnwhz+7xG0QCIYJVHBaaoaUc=;
        b=qzeY6WmYWlgjaonmbTlDLMPg11WtaieNkq9fnWlKSMsI4na182POciRDJKs6Rw8l9u
         yE/skScsp3vLYuyl7vKdU19It8+RjHCVIXW2J8S6C3NSh7norhzuGHYzX7ODDWhvw1Tc
         hmwPVa6SZYqhQJ7n0hMcJtjdHr3DH1tJiGT5gWpp3lia2xYcyFvPWc5jspkdchUW3H5k
         Op9jilNMNUbygd1ty7kufELREKi8jAHB24/XRgNmFuUSwbfEFDSMuoOWrCSSI1+2LX2p
         HTayUFsGwjhrlmOg2+VjrfG0Zi26lfgzuKgWEMy5Aq3+dHpxtLujvcEXyaKW0grg4X6r
         BXDA==
X-Gm-Message-State: AOJu0Yw0gM7djWHog6OfP5vEWcR9a/b2TvGlAfNSf8dPrpjKh0kgyqLO
	C6GAIZo1Flp4e2z6fytzA61pYO6qz5lKZQeVTThvAgqufMLKvcog2JUkgQDggpECDrXrQ4z4wCD
	iJ8nfFHI3chkYbnvU5huy/te2e15WEZz3R5BEnh96fI6B9GrQXMpbEOa0yRUZGm4cia+7YBRXDt
	++NIaZzc3q9NdbSeJWT/X3AmVwvhujqTcrxt08Jne21Q==
X-Gm-Gg: ASbGnctjkLF91nxXKrxJb5muDylccCv0vuG/Eo8BTfKU/qF1WA53RuhHebwJGOVqeLx
	HiPIg7VyEEFc4WCXg898uGNIvM9gfQVdRfLi9B2TYdjNHnO3eQlHz6Yy/PS871MwEshotkl7u2X
	7jbQu2MsIaK9d5iF+JjY03Zk+F1MLq3l+J0x78uSXcAljMU8s66bEC7IHF6COTm0UbeJt1FTiHT
	l8feCldgrwBnR4ljHkphFBo94vJWHwA9lJZBUu5MExsvMUnK0p7TxeD107rmgJjaKGcsuzyka2q
	/pA8iUBc9g2w8tTl9oq8umzvCwOONGssyKgXAUGU+lt4+TEaR5R7Ix2WioLF8KTdGPcvUxPqyPr
	7bv6cm7whY2OptyjaupJyI5EMsCFGdImAfU3Or50o+k4NyCUXaq8LFPmGi3JRmbmuY5v0WgyjiH
	CmAYPe1qFNkEx9XXHQzPfL+kP/fA==
X-Google-Smtp-Source: AGHT+IGcAF5fYw+9YpTALoreZeWA4Wfa6G10io23C/6dtwpUm60g55iWQ2DFLVnMuW4lWGabFGivsg==
X-Received: by 2002:a17:907:d1b:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b703d2dffb0mr20486266b.11.1761680434093;
        Tue, 28 Oct 2025 12:40:34 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b6d85308039sm1194743566b.8.2025.10.28.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:40:33 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	ashishk@purestorage.com,
	msaggi@purestorage.com,
	adailey@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 0/1] net/mlx5: query_mcia_reg fail logging at debug severity
Date: Tue, 28 Oct 2025 13:40:10 -0600
Message-ID: <20251028194011.39877-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit message pretty much has most of my thoughts on this one. We
see this message generated all the time because users are trying to
determine if there is an SFP module installed in a port or when trying
to get module info from a port that doesn't have an SFP module. This
is not really an error at all & therefore the message is undesirable.
Downgrading the log severity for this message to dbg allows users to
control it via dyndbg & therefore "up to the user to decide" if they
care about it.

Matthew W Carlis (1):
  net/mlx5: query_mcia_reg fail logging at debug severity

 drivers/net/ethernet/mellanox/mlx5/core/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.46.0


