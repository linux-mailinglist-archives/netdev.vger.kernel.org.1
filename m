Return-Path: <netdev+bounces-175395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FABA65A9D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7833B5AEF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F317A2EC;
	Mon, 17 Mar 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeJ+abTM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166A29CE8;
	Mon, 17 Mar 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232064; cv=none; b=RcCGsRxmGRArMvwjD+f4iF1/ohRyHHODFUL+dbDqZHHwPz3r8A0ZXP9JXr96AstTzwMZ48k5kkaAv8Ecl0t6vdXWSKN1RGCUAbFCr8nfN/3YrzJ0NVQbphgxORg8mnmP6wG4QsshZHj0Yf4UnLLXhi+lrm6GiMlOXeV7tuMAnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232064; c=relaxed/simple;
	bh=wzAkbOeVP7xqqD0XC950bR9UvHLmFAEmwQJBYHuHHr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sX91PV6kn6UyceqatUUuAeUcogzY4Ib/5XdQ0hBcVp9NuXo4+PzYWYXeQfITqu4cu8vdZ+0RIGujAo1+P8/74gtVWo7eK0EebyZpJ6uji5I5i46Lr8KUh7m/B5+7rW4NDW7AdukQ04E19EGTdW94cQenTI/hxWB4fEXTSQpWqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeJ+abTM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948021a45so25307305e9.1;
        Mon, 17 Mar 2025 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742232061; x=1742836861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdy+gIcUJozBrDyGWdtSpsvlQR5bKFNfUvrA1WQZkmk=;
        b=FeJ+abTMu7mGWnCLN6O0XMCmD7Vmir7otz2AC41e5asFlYsj2h9Lh32uogp7gJPR5S
         CeLsnb2xFJUJ1cr+r8jy/9WIB7fFfTYMvhvZTDdZdaTXzHY81gQfHw28pyAXXxgBUjzm
         vtEpFjKKmWEeLI4wu3R/surM8xK07+5nxC2c+1zt8kgRNYIR6QFmVL88GF7mRIkxDq9I
         ByrBdsG/bQVBdTRbE1WH6XCneBnZAK1PqsFQYh0Gw5WbgpSC4dEAchgfvXGvZ3unkXeQ
         bNvjmOOjwN7vjjU7j47iXFvD3/8hoWB5NRiH9sI4gfJAA9tKqyCqN48DKBbEPyWMndh7
         proA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232061; x=1742836861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pdy+gIcUJozBrDyGWdtSpsvlQR5bKFNfUvrA1WQZkmk=;
        b=TaNC2PGDe/QXeEARiLdXxe3LECBiIPdxEG9938vLHmccnQab6C09GR+WDUS0YJZRGQ
         CnqlsCmD7vxv3tOj9XUA0lNds1//9lfc+RJQQXaepT1n+7XxFG/TWQ8NbtHuQfn2/vGG
         ZCVozhx6MVoaOITgzaJUUw1vGEry7cGH0k6rGVVUjZdbFBEswD/KH6QcNUgbBKCNaQ4L
         ZsbDrvPCv8VCYl/MfD8j6sP6do9Z/jxnSbiV4jw3SV0WxCyGABzSPj95B5s3K3tZgOj+
         Eg/+iae+vTs2YfWHQC0r7dE3B60oJvw+LgtUSiUtAXcjkL+oaKZaZHwV5OZyWHrNNgFf
         T+aA==
X-Forwarded-Encrypted: i=1; AJvYcCUXyXKPha6KSwF2f9jQP4/qGSNBQeF9G1wgvtGcgAD841/gm9+iRJPBHfmmJvVPotmKsG7Cyv3LOuXy3q4=@vger.kernel.org, AJvYcCXz0y5eLgMGi0YWWzip0pkVr6xkRK/ZciTAx8LO+G3HGhiwUehePI6DYtjHLqokhVaeJOiIhLVD@vger.kernel.org
X-Gm-Message-State: AOJu0YzsrjapgfGlNMOIxyF4pElXhqn2FU9rtTOBqdVcCvGZQx9NIYMX
	eX6jb1agP7hLTFHPHGvgAF5KKOcDls4F7+yhvy25tftdyCGHnvTK
X-Gm-Gg: ASbGncsYbq70B6GQiyVAJCnjGMEDjhw/PW5hDjXpIwklZKPjtt3xgnzBvmto3ALVI8M
	PWRWughjMp87eWDe0zS4VzMiGAAn5IYgYwS1eBudLqDtN0Spl4cC6lyHM5Cc+8EP/TT8PFJFXPy
	jVvxpiikDMfh0j5nPaLG4POYaJzfhEJ18ZEsia+FyzlEofs9dRiVPVkJ+lI8SyEu0LF1qjxaWGP
	suyo/7ADfAdiMXVJrYCQD1DuN2nCi2hExJPsGtHz8xkiCbg//lro7KzJ/ESIySLKl8MRPKZk0dG
	Z4+5qdKhGZP7pMVswhcJDNZCPUwjKZEnGAJmlDizuzxKOnTBAU+3J7h2
X-Google-Smtp-Source: AGHT+IH9v1iH0ZDNn8ib73oFHv+E3KPSpU0dfOiqNhT6bKjdl8ETtAzm/796/PE1D1nATR6iMmssOg==
X-Received: by 2002:a05:600c:3399:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-43d2230311bmr123291775e9.0.1742232060997;
        Mon, 17 Mar 2025 10:21:00 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe60965sm110941615e9.25.2025.03.17.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:21:00 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] ice: make const read-only array dflt_rules static
Date: Mon, 17 Mar 2025 17:20:24 +0000
Message-ID: <20250317172024.526534-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array dflt_rules on the stack at run
time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---
V2: Remove additional changes not related to this commit.
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 1d118171de37..aceec184e89b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1605,7 +1605,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf)
  */
 int ice_fdir_create_dflt_rules(struct ice_pf *pf)
 {
-	const enum ice_fltr_ptype dflt_rules[] = {
+	static const enum ice_fltr_ptype dflt_rules[] = {
 		ICE_FLTR_PTYPE_NONF_IPV4_TCP, ICE_FLTR_PTYPE_NONF_IPV4_UDP,
 		ICE_FLTR_PTYPE_NONF_IPV6_TCP, ICE_FLTR_PTYPE_NONF_IPV6_UDP,
 	};
-- 
2.49.0


