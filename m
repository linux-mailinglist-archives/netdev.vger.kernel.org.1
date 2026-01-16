Return-Path: <netdev+bounces-250523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D586ED318FB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D04903004E03
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DADA21576E;
	Fri, 16 Jan 2026 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7YuqriS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F531F63CD
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568993; cv=none; b=V53X9jplVOUziKVZZWKTlbM4ANIAucIkYDWC8G7UmOcm0USg4+hLJdjsJSjDwyYWASXNHBIX4JtpXmzvQrVp1fdH78E7rU17GvBNym4H7oNeOsK6ZwWzNzEOtDBQ/1AKH8dnnD2Xu5tLolBn7ZVEAlNAkdp0qGy+wguRE1PnFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568993; c=relaxed/simple;
	bh=enVmKv93Aa48ECVdTDUXHkCfELiHNaDJSHi+HQvX7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6npYQpDHqyyqnArvCSF5DnibLHqKmQWSmM5nudqtJZc1VsARmdMD5YZTpc067Y1G3u4G8kPRlAkla/tyG1Njwm6dN7ZRUsTXSWpf6mMG5TLCdamDukUWT3G/AnRVT5XLrQ/oyhhiEC3ZwCCFyIGdmdDJAj+iBaEUfHQ7/+Ck9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7YuqriS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so13326505e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768568990; x=1769173790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJu4OIdI60cVjJK45I6VunybR6THP9/15aqu50JDBTI=;
        b=T7YuqriSUHygXQV6w70mTZicCpUyinhRmO12UintChts2YLbv4uLUuZljAeGl0TsNl
         Z4Mg4rLx2l7Yhwwqbj/bOQjq/FxE3hA6JLaAVvTSfT6+CUGZ29Yc6CJtlNyU5Ivf+oBk
         Ytr+iWQ7Q8KP++vYoZgtczimr8OXrWD5aQloy7B5K0IiJI7xs+e5VXuxTBsMWy2IXIZ7
         eRjLBE4dcfbM11IX3DIyzc8k1C0UG7D1DMCtamnUXr1XoRl0Uj7PKd/EEKkpxnBk2oDZ
         o8CB6HZiGxtJBMJnfe2q7MwO06GXHD9TleY6YdiElDsIevQPS4avYEQEr634S408mqW6
         4OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768568990; x=1769173790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJu4OIdI60cVjJK45I6VunybR6THP9/15aqu50JDBTI=;
        b=AYHjzSUnpCizTb7dleMrn9KZl2TQrzyw4x4lQMv5Et1MlEcy//1FRqv9o54NMzrIQ6
         +n2HqPEw2nzZCJmT08eSOGz6+jRQhbSusNcJgeCwrAkPJurfC2dunZBKM+VM6FdzJ3Mp
         3tXwluLpnWajlJU0XLkINCE3JZL7SFh/kE5mPqE3JhBdOupoZ/ErB6yftUi57jfkeWU3
         fnvaWtkdgB99LHtnO3xhrT2y9QSNLnVCi2IguhrczFX3WxvHF3Cvf+8VmsIcFhzbvnXE
         2FLA30RZJ9qSF3qoJ21UW87dRcURKzHefa5vPtmsE+wARzdlH77SRcrIW83sJDzaGX3A
         iQag==
X-Gm-Message-State: AOJu0YznfJqVqVPLGgblIJSNoEITtL19v9o2gcy2KdUln0lX6V5PPUQY
	h0+92b6FvqrQ0EgMmCeHApOg8hcO8yjNvhUkZqxqJ5QER5qncWSl61Cf
X-Gm-Gg: AY/fxX58TitXULXNlmZzoppwxPu+0Y2H69zWp/SSo/Np8qv13DK47m9j9pMSqVYZEMv
	MaGndxH1pd8ItVUX69chmmvdzjQPeYQILpPfAdxyJ1QxWT6Nx0VqomV7yMgpdtyxcqjPL8zV3FO
	AOvSYtFX6lTGf6YcnmOB9maR06glNp427kUq4DH2vR4wOA/LuY8hypVdjOa951zCZFvbPw5+OD3
	A+1Q4dNkgyjhGsb53zKZITUYiyB4K3gPPCNVBhW6tezqHk6B6IgOspq38nHCXvPRAkpFBHecMeZ
	n99mLu0yneBP6HfY1b0jSlDfZW5i9k8smskkS2shMgV2/TTY0bnRxdoX47JFKvnwfWjAp0A5wYw
	1E+j4LpC6oVunk7XUztJcMiVQ8mgNyJSvIFgfwjbvjac42BN7yyIibHoFbap/t2SERVp0a7OVJe
	woyRBhusF074xVVWac
X-Received: by 2002:a05:6000:250e:b0:431:1c7:f967 with SMTP id ffacd0b85a97d-4356955eef8mr4063803f8f.17.1768568989962;
        Fri, 16 Jan 2026 05:09:49 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:7818:c5f2:e870:3d67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699272a0sm5172610f8f.17.2026.01.16.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:09:49 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	eichest@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Convert the Micrel bindings to DT schema
Date: Fri, 16 Jan 2026 14:09:10 +0100
Message-ID: <20260116130948.79558-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the device tree bindings for the Micrel PHYs and switches to DT
schema.

Changes since v2:
 - Remove maxItems from clock-names (Rob)
 - Add Reviewd-by tag (Rob)
 - Kept the micrel,rmii-referenc-clock-select-25-mhz property in if/then
   schema to make validator happy (discussed with Rob)

Changes since v1:
 - Change ethernet to mdio node in examples (Andrew)
 - Add table with skew values instead of a description (Andrew)
 - Remove - where preserve formatting is not needed (Rob)
 - Add blank lines (Rob)
 - Drop line "supported clocks" (Rob)

Stefan Eichenberger (2):
  dt-bindings: net: micrel: Convert to DT schema
  dt-bindings: net: micrel: Convert micrel-ksz90x1.txt to DT schema

 .../bindings/net/micrel,gigabit.yaml          | 253 ++++++++++++++++++
 .../bindings/net/micrel-ksz90x1.txt           | 228 ----------------
 .../devicetree/bindings/net/micrel.txt        |  57 ----
 .../devicetree/bindings/net/micrel.yaml       | 131 +++++++++
 4 files changed, 384 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/micrel,gigabit.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml

-- 
2.51.0


