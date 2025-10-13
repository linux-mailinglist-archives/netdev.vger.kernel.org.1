Return-Path: <netdev+bounces-228690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1FBD24FA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9729E1899FD6
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07D2FD7D3;
	Mon, 13 Oct 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnx1SxTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1F2FBDE2
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348103; cv=none; b=qpjRqOrosDcGod/W6uYBYAyS0C2rBPSkwbA6GEnUStVP3MMqTe7y7BOi3csHEcTLvTVartdklbv30SUb8NrdsovYe0GOuBHGPPQYVMH35LA0PxuUyx4l6yKprPGLwJKuaA4/Bn8KDQx0+12fAJEjKeRoZQVmeJCEE36xVVPwdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348103; c=relaxed/simple;
	bh=h/7JTy6TbprU+dCtnUq5sVaFosiidQqOxR/pPvZSvKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFCtYpF2WeJFqPytoiPS71BAGpgu4viaWSI1fAPRsai3crqoFwDOHY7tW+hFVMb/DEIr6nCGisCvkvTEej5qUSsVB+qSXxHlI0QU+ct4uIZ3BHk+hsEGbCmQi4zm1iSFTBNhUkTsCC6ePguYWvFX5+II+8gEKqQvCY9YT70BWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnx1SxTk; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7833765433cso5322684b3a.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760348101; x=1760952901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5bKclxFecJJ5GNJZlIb9xGDoD2UnMroqAQc+H9CWag=;
        b=mnx1SxTkrQzHYji3aeb3q4OJ91PiRt+A7UU+c/8zJExuePN2QeB0IklJwTH08iodb9
         88kDaaj4FBNqNOtBTe+OejuT3GlNCJcZwjgASUnCU4a0lR1yY7M6QZR6UMYWSiSh5+GO
         Tx9y1tJ+iZiuZITt5suiuPdQ8g+j6ane0nytRhF/zsYd6TqiinT29kbbjZ70akhtMZz1
         gFItwEi5eZMaL56EE8dNlJGvP1yNkZmlgkCw3CxS2OJ+o/H2ayhEoUVgXk9QYP8jfPEG
         9VDEIuB/nihlBX/vMp1CSrmHCqgPinTh+LVg7YqCqf5zQyg0oGEC9NUJm0Go6V+SR27i
         L8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348101; x=1760952901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5bKclxFecJJ5GNJZlIb9xGDoD2UnMroqAQc+H9CWag=;
        b=LfMpQlhJZatWVFC27X3eNuHaVgLqaJdoTNcMsI7R91Zw4nBHyqAn7nPPQ+94qo6DlE
         uV8eoNuPJOB8Me7Uq4fj6GQ9SWoY9SxeR0peHFfbLK2jd69Yy8NGjgQRSdznjxcfRLfJ
         jRP3/7XL6nzf/6jIffZp2JJVCPIZ9gk8vrqpEVV89rPub2z+69uHzrPCZlC7jxAz2EgE
         ZAITe3EouJXnrpkqU9lkAC+Ai+z+2DAZYNJc3isoRTCj/QYmeOk0tvn9nAScEuZ17CX6
         YZh70QZqfMkKaVqAIZqeCX284A20pxyW+GYqR6ZITjyyC+qbGEJ8wHskcfMMQVZCs6gA
         N5qg==
X-Forwarded-Encrypted: i=1; AJvYcCX/W2qC91X8+5qEj9El0D/fubAGfpgPs6LWnUB+93XmJer5xlKP9VXrpLOTQVyYWCQSZJ55YWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aOo+CLixItaminiN3BMSfwqVa8sv/Lr7EObWGCzdXyf+5+T6
	ZxnFPDfrvP4Eba3DALjkffh4OipkS4kRUq+CUeVzfOauSYNLIVxubBao
X-Gm-Gg: ASbGncslnc9AA1l4tpeUUxW0oIe4MZyDu5Q12tJEKCqFUpubuGbMtfD5qbxttg4P+1f
	SDyDLdrLRP06lYTU29j82dqc4X4F9DJjU5Egd7tu4B0EOYC7WnHeTB/haxW+WVqYxTcjsC3kCLP
	LvqgjC4771HS9ubznmVBzdSACm23Xe+b2kpRX2RPTQaXIyNzl8veEfxe/XRFZQklnKbSVrVQ+Nt
	D11oclTz5OM3NhBbAf+uaNgCTIJHGzi9FViXpLZ/n120J0vENjNxTAMRpETftBN5snhMKR5dQYm
	4L9PXO3yv25c11ssRKZb7vMiEYt2/+5N2sK4HLRpN2+KXOir7x65fK27JMyLn0ogzpNEUkqM1kL
	NE6K9ZIDh+Ut1Osr5uw79Lmz757Q4sA1MAibkRI9jAeg1QhfnM/KtnTdwnmzg9XQS0VutOkMfVQ
	==
X-Google-Smtp-Source: AGHT+IGPAzAetlOptAzw9GaNxbD3zKkFT2GadJ1WyMX5hnKkmmcKAsypxbC/VTf8veeCOAjENtE2yQ==
X-Received: by 2002:a05:6a20:7291:b0:2fc:a1a1:4839 with SMTP id adf61e73a8af0-32da80da6dfmr27467709637.10.1760348101035;
        Mon, 13 Oct 2025 02:35:01 -0700 (PDT)
Received: from LAPTOP-PN4ROLEJ.localdomain ([222.191.246.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df952cbsm8693944a12.45.2025.10.13.02.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:35:00 -0700 (PDT)
From: Slavin Liu <slavin452@gmail.com>
To: stable@vger.kernel.org
Cc: Slavin Liu <slavin452@gmail.com>,
	Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org
Subject: Backport request for commit 134121bfd99a ("ipvs: Defer ip_vs_ftp unregister during netns cleanup")
Date: Mon, 13 Oct 2025 17:34:49 +0800
Message-Id: <20251013093449.465-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to request backporting 134121bfd99a ("ipvs: Defer ip_vs_ftp 
unregister during netns cleanup") to all LTS kernels.

This fixes a UAF vulnerability in IPVS that was introduced since v2.6.39, and 
the patch applies cleanly to the LTS kernels.

thanks,

Slavin Liu

