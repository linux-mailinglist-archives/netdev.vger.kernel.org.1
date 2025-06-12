Return-Path: <netdev+bounces-197110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB03AD783E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE521883CB2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667DD29AB11;
	Thu, 12 Jun 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD78xn+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95450230BD0;
	Thu, 12 Jun 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745803; cv=none; b=AWt2D/zA/YDhK4lggrG9bjrfw6pjK1HSUA2cOqpf9MvdInTiAWmPSJKDcm3uIRpleURK7JTqfJBwTJs8pyErgpcTdDBmvQnpsOcE4pCHmlClCsEyAhDwM9BJibhWa54u7IgeXBMvcZLuXj5JGf4BpR30JCuNmBNJzro5MM+Oaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745803; c=relaxed/simple;
	bh=xRD0XNGv85aotVRbw16G5ZDTuKLAnScw55C18SauZnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rUeNldODlVA2tYotxLX8kx5ZZW0zWuHtPtKjn8ThrzG0wBJjmZTDF1t2uWPtmYcQYigBJa/8y0WdqYkv4ibtGslzV6goQJFxNtzA9P4N5DIIsOwNqg1/0++ISBbc/ahfwlSziljwSr53UbAS66WrZkXaK3Cmobh/9sxw3hnleb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD78xn+D; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4519dd6523dso1284615e9.1;
        Thu, 12 Jun 2025 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749745800; x=1750350600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYmM7ROZwgjsxl7AbAUfvpwIGRcnutttpIUnWXsbTAo=;
        b=jD78xn+DpZWZESjkbGvEF4DXDuyRLccHfuCPiqplUbLhl9zFilL6d8Z+yh430yLQ3m
         TMMwTEv2gkarNrxy8ee0zcaQ5j0D7Yc/tTX2+oEgtkrMYCxYrFosd1F3SPhI+mRbTJgI
         YXaqg1GSpFvTOEyqWQ4TCfGFL70NO183mriavhLIN/omlQgWP1j3ylrpY4nvoFeFiNUt
         Jv6Zl64nBl4DOhw2XrlbzLGFU6nbizobWFouRvUZ8dLxzz6fCvxKuId2vf0leoJSrdMG
         jDpdxMihcR/S3pkx/EcyDcMA9ZPjg/8uGfPb7M8FhTbM9i3hH7a5CFg80/8EpZRlMijY
         /ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749745800; x=1750350600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYmM7ROZwgjsxl7AbAUfvpwIGRcnutttpIUnWXsbTAo=;
        b=a3LCRZGaN8XMU4pMa5/QYDO5JCCQwlM2A87sLM67bSAk81z4TZ4D5HLY2Q68kgyTOY
         eC52yjf6jQeQjiYXiE121q4yKCaXuTJnze5v2IgR9rdit7bUrBunLH6bmeRm0Ht6gcQZ
         YIWqxwE4rtALB8QrgyiKgXsPFWkVy8WnkF0rmvgXabTJd+FaDh2z+HQPRhMQNEANoa9O
         DMd7zaN0kzgOYV6kukhg386CFLenkBJy+CWBzdB6KFFBVkQWlKZz25kU5vRWYJV1sHUt
         76U5d3x+a6phYdB4olw1Cg14dWlRd69wKyRnPyEvAP9SFwh8WtPzXQBx/cO+10S6QUtE
         yevw==
X-Forwarded-Encrypted: i=1; AJvYcCUa0H2Sm3Ctr6/EVeKc6wE1P3Ib6fYFa60sCchItaYgo1Q3LMrKAV9PDUh1JGbe2pAeiCQqYoN8jkE=@vger.kernel.org, AJvYcCVUkAtBYG7/uYIw2ABBNGleOfKa0qdtRl68eHozFtv7omAg23mtXBu5nPO8A354TSmgCuScXk5oYrQgPgSY@vger.kernel.org
X-Gm-Message-State: AOJu0YzTenJ9+VBZWAw2UA238qF+p677gnsaZfXBXCK3RjzEGqG2eECM
	XkhDDighqoAmzdwUOiq3xNlSEdkkhHTRLlFgISZlU4MOj45yhfifSphJ
X-Gm-Gg: ASbGncuiVQn1AgcuEKZoUBe5RVDIiCCl/NV14/IBW2sD3juHsDP94zinQZ4Qpx4yUYy
	fG+FM5k3a4sIDmDMhFiDLdpWCmSZoXt22adxKMxRLURrpipKIqcSsx+J8QsswABptCIAyaQBUSv
	UjLxDc/8h1nYNzOVPlOnl6k/b2WX4HCCGWUgOc5DLv+F5D/r5CgXvsUBE4O+XPD2arC23AyUibJ
	1XReGAARjOr95e5Qo/uTioWwRfdTMhYHjInBpy6go3qv0D6MwvW2B7GMqNIE6oDsNTbiCJMqS64
	36XwE19D1FbhjN2OH5ZYRtjAvlaFJVfMfiOfBmhrtNcfwq3RaZSh2KwnLFODmDw4IFT9x+Y6P07
	NbQEVRtRtLIJQAk4ZZXrlXA==
X-Google-Smtp-Source: AGHT+IH5CI6D1Rw9skPRSC6U0LsDjDtb7KLoh0huZys7vIw7B/GeKXl1l+08G9QXCebLxe4jzAvwpQ==
X-Received: by 2002:a05:600d:5:b0:441:c1ae:3340 with SMTP id 5b1f17b1804b1-45324875827mr21240375e9.1.1749745799735;
        Thu, 12 Jun 2025 09:29:59 -0700 (PDT)
Received: from localhost.localdomain ([102.40.66.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e24b0c8sm24872135e9.24.2025.06.12.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 09:29:59 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.com,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH 0/2] docs: net: sysctl documentation improvements
Date: Thu, 12 Jun 2025 19:29:52 +0300
Message-Id: <20250612162954.55843-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up and clarifies networking sysctl documentation,
specially the boolean parameters:

Patch 1: Fixes typos, adds missing defaults, and standardizes 
	boolean representation.
         
Patch 2: Adds value constraint clarifications for parameters with u8
	implementation details , fixes typos.


Abdelrahman Fekry (2):
  docs: net: sysctl documentation cleanup
  docs: net: clarify sysctl value constraints

 Documentation/networking/ip-sysctl.rst | 87 ++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 11 deletions(-)

-- 
2.25.1


