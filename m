Return-Path: <netdev+bounces-149138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF779E4750
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A7118802EC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06F191F6C;
	Wed,  4 Dec 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KmthNSfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C3187849
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349610; cv=none; b=tsDkyKxuxvgapeXkOX6OBDX4Xe3VnTu8ZNRbj5nh46V6SIEmKAxHyi0r99Rv4+nhNRoBHhIi2vh+FHXDob+vKo4ewLpusB5L1QOs0ppVcTBEOp+5XcAR7bZXxFw6cdEfQzicu+2qEMURu7Jxg37/F+kWFDXQL+9tZ0/HQJRtpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349610; c=relaxed/simple;
	bh=p/4lR3ShHIbDZNeS9HvYKUh0l3qK59rt/PwWNUmB/wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOjyEBXIJVlZAkGLTyy+NtFjAUGOnYIluFWyFwPJ3W11PstFwMCsIW0yNusQTpe+/hdHLpi0wSQQqNWT04IU4L8mJM1eyjnMpWYthGtmhtQk+HDAvd5k/6FwoPxFStXRMWmRMMIzFuJe1nxMj8DlK7TIo5dCHLWimykYrzYN6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KmthNSfh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so250962a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733349608; x=1733954408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfQ6EPqmSlgxwMd++vr7Mv84CofDG90w1Rgb2C5xzsk=;
        b=KmthNSfh/g7XFi223XKlMhegaAH51EBimLgWW9xDzpy+EsTZQ5Yf4aWglZZgdZcswz
         /a+tlb02qqDaZO1YpPeQlQEXcGVjj871mX4PzHqx10ryR6UGIy/mKiD/Md+GryWnn8W+
         LsDoBjjln1QlfyP8j0ZeMvJ0xA23eauLSvBZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733349608; x=1733954408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfQ6EPqmSlgxwMd++vr7Mv84CofDG90w1Rgb2C5xzsk=;
        b=OSjw3WLO6lZL65O83hQR6pyGlWjh/1J9PkWOAiwUVki4K6UwHjFfDGfiex8aAcUghB
         keWidRvcWHbC8rHIjcgzqLSYHqiagsYnAZBx/lxbnsrkh2iU6Y5QcFH4DjB9pnS4Mn3F
         oq2TemtcIj0f+f+GzRBeWf7ngznO6GG5+UQHIn1/o1A8kxWt5XxMMc0K+k/bGMr/5TUe
         TB1begU5Z6rVXYzMUd0alnDEThjdovEewSmmxRFO7YhpwaAtzr1V6fVOBfQTDFv0F0T5
         PHmzk2XoqxPIeEDATeyLQiaOKD6zXZM2k+Tx+6oH8159+dL4oH9Rgm9N8l3+2fb+ghB2
         Mr2Q==
X-Gm-Message-State: AOJu0YyaEvycJn0TlYL3j0091bY5wJvwYPaUUVhdEGgjw1VTpN4e0jsg
	OxrKvnZZ4Z+dCpLj2sudYfl4b1pbOVx3EpzvC4WVAUDWDnTjzrgD+De8sXMg4A==
X-Gm-Gg: ASbGnctcXLYKg0i7C2y/shAH+8EZRu1jmbN/hujmWjogIkjzTE/xPsE04AR25S3RA7x
	X+6tsmBnNIJJX0BeQmVJAiKfn9tRDCXKtEpgswkPN02bRwUF/iHbJrymlgYM8w92vW3kkv78584
	BRaTucLaUXdngBFaWMeVcD30CupZY99jRp9pWWE5KTwEl/UQMyU+o84ximA2TzAjgnUoqJGJSMx
	DkfmaODreB0da8NjbLZ3WccxU0o26pSqOhifkz4ujzIGuyvul5uQkuvaaqHjMWB3YW0hSjoAoJi
	UrNSm0R2sdN+2b1cLpsUXfe9Ww==
X-Google-Smtp-Source: AGHT+IEDJhHG9cTcJfVHFKDYeZmsW6xfzxcw8NyAcAPz8HmS74TUk69+6TNBm+5TtJNAoefgK4WfKA==
X-Received: by 2002:a05:6a21:6da5:b0:1e0:c6a8:f8d3 with SMTP id adf61e73a8af0-1e165412810mr11886955637.38.1733349608028;
        Wed, 04 Dec 2024 14:00:08 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814873sm12897937b3a.153.2024.12.04.14.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:00:07 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/2] bnxt_en: Bug fixes
Date: Wed,  4 Dec 2024 13:59:16 -0800
Message-ID: <20241204215918.1692597-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 bug fixes in this series.  This first one fixes the issue
of setting the gso_type incorrectly for HW GRO packets on 5750X (Thor)
chips.  This can cause HW GRO packets to be dropped by the stack if
they are re-segmented.  The second one fixes a potential division by
zero crash when dumping FW log coredump.

Hongguang Gao (1):
  bnxt_en: Fix potential crash when dumping FW log coredump

Michael Chan (1):
  bnxt_en: Fix GSO type for HW GRO packets on 5750X chips

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +++
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.30.1


