Return-Path: <netdev+bounces-227896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0155BBCBED
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 22:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B1118946DF
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A031A9F93;
	Sun,  5 Oct 2025 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHKitjBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663C15278E
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697391; cv=none; b=S4J2YLVLcBac9xo24byJXt4gGN/6aQHqStiVr6UNBacBgwyZLa43pfpumQSHYY+hlvuJ1ultYSQbdRzHDTd0NjMMZdq4lXBshNUYCB4zCFQ/PqXU5PKQL65jVzhaPl+1BioV8E+l22R7SF7gNnCUlmFq15qREYsDN+VLLV1QPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697391; c=relaxed/simple;
	bh=q3b4i0PeI0taQDA7cc4aVwnt8iKN3AG6gvBR+oPZagI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsknVYyPDprzb3k/cF1fEnzf08EK450ZB2NHDPGWKbiuF0hY4DoIg54gXPTz2VfS5Wfzdexl+VWSQEloRu9JZ8zu8yYuJycivzO5LIfW/r8McSRqgC3i9LVbfA09gNI/s0tM2LwkuM9Jg4eEBSTemfmbKZMgLPB812A6edSs2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHKitjBw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so2836774f8f.3
        for <netdev@vger.kernel.org>; Sun, 05 Oct 2025 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759697388; x=1760302188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7CvBUAk5AnBnmUZiWP8cMWfhtaw1VF+GFYXF3xaPWk=;
        b=NHKitjBwPzoJPzqxfXncA0sAL7qxxkvWhA/Vf+Sm1yxd5YRn9hegcUaiRWY6Aur8Am
         qxHf8nGoLN/rCGACxYoo8miIcm7A9Btpb7cOqxXgzn1SfHchN5u7LqSEfF026/h/yVTe
         kZRjUES0wtB6VpzBRtfOtuyS2W+bvlkK0du/+X97D1XojmQGgcESEPuWWlAtgtOJ8s3z
         lYEKGWHTbL+/TbVKW1mQ+a+/uq6LZQwKK+oA07DJrYb3HJzdFDcf37bQ680CV0c/+lWx
         oMG3rwHFSiYc7HcZNnt4NpFQ1l/zGRtGW+YFycVX+O1qhW3OUruGj0/MZs8L+uKTnZ/p
         ewWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759697388; x=1760302188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7CvBUAk5AnBnmUZiWP8cMWfhtaw1VF+GFYXF3xaPWk=;
        b=qiO0+23mcYSjH8UUfYJ35MIdZOwbTgODsSvKe0qFPmrZhX3eFcnyHy24oa9klO5XYx
         JdOQ2Y73UhumXpIiNpT2XNPKDKghi8OdeOweHAXKfaP1oUvQEXk+dxjk030STS5cS1vy
         ul8sfw/grqhlYgsN1iLU5Z35XZ08HUkVSiBMowBZhGEHKAELG09wfOLo8iK+R0FShs9r
         gFT3zprBTpwJMZDJlxrbq9bJ6yrcp6ajlwtdmpzMwVF1NCM1WUPwoGCSmlILoBbZA4SV
         hwqA6YEzAtkloXaRjbjXlLiolWIMW89XbArfmJdF94YBKtZaB6joqfelf2S2QvrSA/KM
         8prQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG0A22/tY2P0Q7gx4rqqAnEDftg+N827+ZZdJ+N1e67UhSx8PCqkzUiHnWZGWnUSq1g8coNKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdLupHreG3diHm/eTWm3xHdktqFayfBxOoxG1o0WKhK33OIkf
	+Ne9fWjdkFyzunhkAdo9UAMcmupIuyGycW5WGA9CHBr7ntmluLJVmc+T
X-Gm-Gg: ASbGncvnetj1wF4zCAsEZi59PtwiVD/jOYDfMgouAGbq8xis3s9MI+mBazWRwLfc7wI
	BYkswyEq8agUZESfVzjXtgfj9bLENzer0GdTpkzAfjlyonR3W7KiD/VHjHeu5CnNa3ppLYOOvNC
	jnkCtSGZAOYekkxSK9fqdI5HjOte51eFc4XeG3S/w/OpSxc9vGi8J9V80PZfe1eqm1bLO0lLAEe
	ed8wD6mBLMCK6WzE5ZNK7aBWE/jr8QIHg81pKEBo5NQDd21w1j96Zv7FD5SDBt4n3U8zFzQCR9f
	BJ4ihR/YNoML7/q0UVakgEipdMSzsG+mZ5G1LyFqjriq8YQjpNEFNrRWbsCdeX5oJ9Fk1QMR818
	7bUXjEkHq0JW0GG1nwGRTj8V8iJrkQsZNzPet9gx6y8G4KpiWUvIWYdLxrGsn8UcZ/FVxPzUAK2
	/BcYX/8b//GHsHEXXTukpg2NXf7cNeJ+h8fDXw5M2V25T/tlJYIxSP4giixH3exF3B48SgAtdFj
	rAACOcNHzGtN6XvZ0BmoB9G0/3mZeKCzvIwIs7qOVVfJfVpTZ+JffvVUpH1NxP8Bf2UHqM=
X-Google-Smtp-Source: AGHT+IHufP1m2PwurJ/6VPLDwPmK0oLH3v2BsaqXmTxhJ1vMTXQF68Q18RUu3HtSziD7yZhnUYLjrw==
X-Received: by 2002:a05:6000:1a8d:b0:3e5:6dbd:2114 with SMTP id ffacd0b85a97d-425671c3807mr6895394f8f.59.1759697388226;
        Sun, 05 Oct 2025 13:49:48 -0700 (PDT)
Received: from cypher.home.roving-it.com (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:e9:f8b:31b:f797])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4255d8ac750sm17897231f8f.24.2025.10.05.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 13:49:47 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] ptp: netc: Add dependency on NXP_ENETC4
Date: Sun,  5 Oct 2025 21:49:42 +0100
Message-ID: <20251005204946.2150340-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NETC V4 Timer PTP IP works with the associated NIC
so depend on it, plus compile test, and default it on if
the NIC is enabled similar to the other PTP modules.

Fixes: 87a201d59963e ("ptp: netc: add NETC V4 Timer PTP driver support")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/ptp/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 5f8ea34d11d6d..a5542751216d6 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -255,6 +255,8 @@ config PTP_S390
 
 config PTP_NETC_V4_TIMER
 	tristate "NXP NETC V4 Timer PTP Driver"
+	depends on NXP_ENETC4 || COMPILE_TEST
+	default y if NXP_ENETC4
 	depends on PTP_1588_CLOCK
 	depends on PCI_MSI
 	help
-- 
2.51.0


