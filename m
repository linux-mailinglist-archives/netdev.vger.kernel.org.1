Return-Path: <netdev+bounces-201127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC34AE82A8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DBB1BC3141
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EB25F960;
	Wed, 25 Jun 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA/XoWkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D625F7AC;
	Wed, 25 Jun 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854345; cv=none; b=kGYUIW6oT1jjrnYuNlMZ/R5+xrVkbk/rDnVFmUmd/PmViHPJhIPXcBxZmKh6yMM6pjqSI2Mq+8rW4ay7wk6DFYgc+QcSwkhRyn7NpUP7dhvi4DhuiTdHdACtTbM2Uh41zYSMQpHrcT9hMNQDXu9SotRT2+erw7W0WfDQlMNAVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854345; c=relaxed/simple;
	bh=LSoiPBgnAsxfJdZ38ziF+BUpehgGUOlLZY3i6T6BgoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H/tgCRmm/+Nit8eQLkOdOKkO14QnVoprXQ5hXruaPS76c0j20ZKl++4ur6PFustOl9XiOqISJLmlsU+s5nKPCVks2vAxpgLT6Sie0J1qjF1Dhzm6ok4Opm6nPk5P5IKoQNc1k9oJWG7HeVnwwRjArdNMxEX0/nqzQLEJnz8kvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA/XoWkH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2352400344aso19289045ad.2;
        Wed, 25 Jun 2025 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750854343; x=1751459143; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g01oL0E8ykb3erePeAw2M3vY4m7Z5zlBMbJUifezxyU=;
        b=dA/XoWkHN4XmL1KgHoG+D82D4b4ddsC/LETjoGPs3/wqguo0LptKHczR+2jKS4wg/i
         s0CmnLm63Y6ksB//T+Pyzlk4m692n6t2oNbvRZOereKoF2cr9JgYRSerpAov66+XPDnV
         EDy0+O+cgZnJPX350uJ978oyt6h4CUKtFE8thOYeiHKXdnBbJGQ5njuPYHnJYI3JcZkv
         +B4J0z7PxxjQIcCHedPInYmehvh8kcTFj3+mm7mOYyVzyw+OsI7vYoRLFVPe6jJfebgu
         r7USBHOWNrW7tPctrqRH4Kxjby7iiSkMYHsFI+JQfAvStPQ0jucefMUbC+zBXHGw8yRd
         QkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854343; x=1751459143;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g01oL0E8ykb3erePeAw2M3vY4m7Z5zlBMbJUifezxyU=;
        b=F+RpA/ZjuN1SXEzPO604NZz+HS2MQ3NB+cQ242KPksRFHniAMeA/3uWv4YDng1JZPQ
         aXEi/Z92ij4Lt/fsTh09qjFEuIAuP6pmKN+nrKROOKbtaWVXQbatWTsyaR37zANGMTv2
         DB8+Mm3mHly2DbXPmcoSQEeSLnrst0vXpvy5dqcHImW9A3UzxNuoLQAZf6HtE8hGE1b7
         SgBgLNrro1P+LRHdn0/lx6OEeXOa98O4nVmuK2Ur8PlKREhRh3REluFNkq6FycnG5BfB
         4at3s1AZ9b3UBPNvLAZIjE0FK9CQAmx+XXtW6JZPrk98AWDapW841TNZaCjXeTbW6/VJ
         VAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU36sKQzUSk2YapFsK2Doxhe2ZedcfdNJwCVYFEdNIUPtVOA7LoTrGRglaI49K8sK3JfNt4sB29AUbrSNo=@vger.kernel.org, AJvYcCUHf/uxd68yzp0dJKf2C3pqEEL/U1YpaOaBJ5D7mzuIG5NPgxqqCc1+ZP7gWVWnlpwBlRdBtkDYKCBPprfdTSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMf9bhfpvauPlZnYBsmCW8tWiW9UcyXtBzN4yX+eQsD6IwEhs
	TZPkVplpf43tf+1qybuohcGyojOky/VyH0sisuuropBxrhM+JmIsFAJ/
X-Gm-Gg: ASbGncvQs6CGoXEvsJegvnbOESQ3YVhM/MZYRIYXkZCTm/LFnJSRec3PyI1FT87QEHk
	08c1VW1beng0UMMtoquadfeKGtUnMgJsUtcivSQ32pKdWWYWuIqJcmB5ho4KDm7evGJZVmwpICC
	lT3qF6ERI4XihXH1a6bu27k2lz4PPSIXRbixc8tohQcjidmfIdsp5Jft2mazCLhGF+EU0Im53wV
	33U+yc9Um1PMJ3L2LLlt2svlext7udgL5fcELoLZfK5H3ev0kSoVuBmT7nid7MdTo2vz0dIm5gj
	pVKh/Kson2B47fWq9E687WOz8+Uo7vPHnft5pmGIg5dMitXgn9CHSLjeZPiOZXzeTJTp4nENCfz
	iPJQvx93mHuxcrm39YRZfMNdhsmG5req9MLro7SRzT516qJK6cNHtRnOD
X-Google-Smtp-Source: AGHT+IEJ2eL4HOke65T2vRtfMF5yOUUedEPSFm0+Nazvfo1v5FbeBSttBpIqqNpXrDIJTS2GAbMjvw==
X-Received: by 2002:a17:903:1a0e:b0:236:9726:7264 with SMTP id d9443c01a7336-238245455demr52692375ad.5.1750854343096;
        Wed, 25 Jun 2025 05:25:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.233.106.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ea243sm137551405ad.72.2025.06.25.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:25:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH net-next v2 0/2] Clean up usage of ffi types
Date: Wed, 25 Jun 2025 05:25:37 -0700
Message-Id: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMHqW2gC/32NQQqDMBBFryKz7pRMoMZ21XsUFzIZNVATSUJQx
 Ls3eIAuH4///gFJopMEr+aAKMUlF3wFfWuA58FPgs5WBq30Q7VEyCFG4Yx5XwV5SBnJSteZ1tq
 RCepujTK67Wp+wEtGL1uGvprZpRzifp0VuvyfbiEkVC0Tj0+jjDbvaRnc985hgf48zx8L/Mjtv
 AAAAA==
X-Change-ID: 20250611-correct-type-cast-1de8876ddfc1
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1750854339; l=784;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=LSoiPBgnAsxfJdZ38ziF+BUpehgGUOlLZY3i6T6BgoE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF9RTqrg/6mntV5bG53qDJAOhKmdUAdWlp6Tlrz8tpi9sCOzbT5tQE/TBhSlVcecXdghOU3UJpa
 Y4FHDp0wfhgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Remove qualification of ffi types which are included in the prelude and
change `as` casts to target the proper ffi type alias rather than the
underlying primitive.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Use unqualified types.
- Remove Fixes tag.
- Link to v1: https://lore.kernel.org/r/20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com

---
Tamir Duberstein (2):
      Use unqualified references to ffi types
      Cast to the proper type

 rust/kernel/net/phy.rs | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)
---
base-commit: 0303584766b7bdb6564c7e8f13e0b59b6ef44984
change-id: 20250611-correct-type-cast-1de8876ddfc1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


