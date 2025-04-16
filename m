Return-Path: <netdev+bounces-183499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277DDA90D8B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E84189EE73
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F420C487;
	Wed, 16 Apr 2025 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU+JAct8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13015F41F;
	Wed, 16 Apr 2025 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837291; cv=none; b=bWrlJT5e0wkNjpPRTy8+4Q31ZMgvqnGrNp8hoyYkHIKTLcFqPFmJ81jnho8tESfQMMay6+sCfwW2e42Fpi+YOepnl7X/f5WhBurs7OIIx9pV7Xmw5Mm/mqvTl4xA7L6pkAoW9eHaG4d5J94WtAGaXld9S9Sya+6PcDErJTEiS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837291; c=relaxed/simple;
	bh=jC5I5oqz7XH/41ajHpQ2HQsgm/qRsdrsgOrtAet8GkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RG2ip+wDulz/2SZzAntzqSJN6nLyQn8LTBPVt+UJS7VKp7H3SKwxqV8WeCS9y3Y9HVJqZh6M55wtD3HU4Pf6v4R2pUYZwypuTNVrCXehERKmoSJimJcfm1oRjGYEpIPzhUSooA+bUqHXwgUtDFSW2Y02uw5LbLsWqiceBdxtVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU+JAct8; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso43127e0c.3;
        Wed, 16 Apr 2025 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744837289; x=1745442089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsRW3mztoWCPw38DZt/jtkCvfKzq42W27KJSKjcXFN0=;
        b=TU+JAct8K2cQaJfKwJ6DybKRUFiZZiKHdfViLz/BHveiPpY70eDXvdBzOyuhAuCg+n
         GgLpDFADT1EcKZOshNTZW6DZabtRE5FGc1A3YGcmnsQ8PS7rCdujyJ4T+Yt4kSx3czn4
         bs/IL6uUlejzg9rH7nrh1BxUzM0yxfQ23UypjfrJu7BKSC0jnRD0s7WL/bt8/sGZ0BRW
         cn3mA+6fwviV2sL4S+Yol2+44tOX2r4xqTuo/Nv9AQNx+V9mJDQ7bOAp/Sg/inpcM2Co
         vDuVnlcD7X0+oQNB6OojIL05mAcGy7Ns8QNzn9OMvP5pdZ0pEKtMOcarb+PtaCJFsbBQ
         kqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744837289; x=1745442089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsRW3mztoWCPw38DZt/jtkCvfKzq42W27KJSKjcXFN0=;
        b=WcYM3KWj8Mr/vbWKiX6CgQrrMrCnehifTYjPopp7GY6X4C2kcFcLVkJ9qtzhlFW9TB
         G6VabD8oQx4mgHR63qiyPR4HHg8iGWjEOYRhsE5VlPFyEGBJwabBOtL1M9Z3cXjxavfB
         zC5Uz6InOTjJWoZEj7P4BhAF9PaLkFOQPpv92coeXPX9byqb2nkkgt7Y2060ElSq6PSB
         brjkEtXzmlQoPpq4KDD1WsdmQFal7JKlje2B2pTvVTxODDofUxijHoZ1rrb88yGbv8qU
         R9a6f4UjiUlbDUeGYaFkXkz9DoPN13bYSJgSzRyrMV75OCymcETnwEiqBiJ1h4yU9ykA
         9qHA==
X-Forwarded-Encrypted: i=1; AJvYcCVY9gP8hW0JKeAyiEzIGb2eca2PDIm6+GHfMMgXGLTPdTVFCQhGBOl+JsJRwsQiwT8JoHoZ/9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4sjHDnuponRtlznBBFH7qzhp3jMFau2w77xMwG2cmgGF3q++
	W0ihW7AZAyN1YUy+2vWFsI2OSDTv+AwS59n++ZOezaA8891vhsjCJIa7CQ==
X-Gm-Gg: ASbGncuMbrJHPb/D/1at8Lfd63AnO14V0hMo+B3X6puxJ8qllbV7AYoNJZz7gD1Zpvn
	MVJc2kNXLX6+mREyiflOoPFNL/GP1FfRbqZ3p9cjzhb79nRzvpPwEh5Lfulbu8Ww5oceOJ1bd1K
	tPnmj7HAgn2HjbUfH6TR41+RKXGRZUhQvwBH4Dl3sv/JM1HokuwWyNb7QwDv0S0nHSgMCOQatz4
	Sagfp3NDvltuDAlbY2R9ZG6QJWXVN+gjinofb9kC1He2+CgC9xTS58qCsUaQpo6a6jxZQRYtXqk
	X0WSfpHIVQpZAzUSjM50SCrlfXl5C7XiGI/23N//CNOCCtICo8Lh8//gzVk6eo7CjpnaV55PEz0
	OtyfF2WK4dA==
X-Google-Smtp-Source: AGHT+IEltzokz9A8PByHB1ITgyOBNRKuWg0qg0N8qNv+N1MKDD+kxxuqdxiYK8IAUZW+KnjA+CQoiQ==
X-Received: by 2002:a05:6122:32c9:b0:527:bc6b:35bb with SMTP id 71dfb90a1353d-5290de8d3eamr2916658e0c.3.1744837288935;
        Wed, 16 Apr 2025 14:01:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8755716f08fsm3230008241.18.2025.04.16.14.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:01:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-04-16
Date: Wed, 16 Apr 2025 17:01:25 -0400
Message-ID: <20250416210126.2034212-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit adf6b730fc8dc61373a6ebe527494f4f1ad6eec7:

  Merge tag 'linux-can-fixes-for-6.15-20250415' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-04-15 20:05:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-16

for you to fetch changes up to 875db86e1ec75fe633f1e85ed2f92c731cdbf760:

  Bluetooth: vhci: Avoid needless snprintf() calls (2025-04-16 16:50:47 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - l2cap: Process valid commands in too long frame
 - vhci: Avoid needless snprintf() calls

----------------------------------------------------------------
Frédéric Danis (1):
      Bluetooth: l2cap: Process valid commands in too long frame

Kees Cook (1):
      Bluetooth: vhci: Avoid needless snprintf() calls

 drivers/bluetooth/hci_vhci.c | 10 +++++-----
 net/bluetooth/l2cap_core.c   | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 6 deletions(-)

