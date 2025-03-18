Return-Path: <netdev+bounces-175736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DBA6752D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B9F16DF51
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9BE20B7ED;
	Tue, 18 Mar 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnajrIG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578771EF377;
	Tue, 18 Mar 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304748; cv=none; b=sJ7vyeO4H8CG5u2fRVcMPkCC14bs23ChHlxOu/y6o2iE05E/WlsocvLWzVJXCnILPJwSQWfbFwuP6/Zgm7dBeTzvixS/HVFNZA0CrbDC6xTbEbgh+1wTYkm/6iLhmJ+0rEWRRED5Vb67ZS3wuizDuOEbx6rri6RcrRo9iZehzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304748; c=relaxed/simple;
	bh=gMgxgRbslohhsFZuyb8dMe+FIib4ebd/RyPojhyt6Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Se0OSrQwg898OehHrYu5T7EmlOLFD6XyWmvFjEMa+6EBkcBpKzzzcugep5LPJ5mSvIfd1k/2fsTK0TkUH3t8JjUbgWrrA9Cf2Jv7lVDeMeAJ7n09Tdsk5wMpL+suzw1iH3zsvhd+BA0h9kL14dHgYW1qzu153iGJSL0RFE75nRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnajrIG2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22622ddcc35so40696115ad.2;
        Tue, 18 Mar 2025 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742304746; x=1742909546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt3h3eZFR+eRJEk19j/lLIhgGCCFMxAIOUPYw3t5xUs=;
        b=mnajrIG29ZbAQlxxMJKQbQ6se6bZOKovH43YUx7L+93oyF6+EhRYanR6+wfQ/+vwbT
         zqxuefS0Q2gkKbzLWp3oHFPP3a6EX7ZPOTqfWF8AnyaV1li8DwWDyKpTgKLuAaQ/q1M4
         30NbA+MiPOrLAtPdXW7+4dk+1cbtlVhtQOHkNCoCt8ND7GajN8lZVSmctEGUR9nyeCiv
         gjDbaOmPNYrZfHw34wQ/LukaI9kD0wvCYPv9FIpmKGx2EcfJj6kMN7RIl+KPEDquWwd9
         VfYybIn5ecv9vh90eNChyC0NktCIeR4tbyzMfJwsqSzS+PkSnAUBqGHb9v3VI82v6Y8K
         OIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304746; x=1742909546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nt3h3eZFR+eRJEk19j/lLIhgGCCFMxAIOUPYw3t5xUs=;
        b=VAkygIkxS3y/isCxINfbddKvdAIhDcqpl56jmtJyaNYnp3nqv5aQqFMaXtedEs4ttx
         UOC5zZP3KPXw3eaTnbHzi56imWMH9Z95CFTCCvvhwVnEtNfUudLmbVU8cu6ASDn3hbO9
         qMksOybnK1LnR7KkR4QCc/QZQwbOTPBJN+rzmZP1K7n1F2TfmRDNIF9SQUgTlHQPFsZR
         EsWFAI4H7NQM+b/1Sb/VhQA3CgdzJHZ4/iCMMvm9IeCH88dgUhXk6+68W9nCbpKlN30z
         4sa3+bW9JqTqMcy1k+XkF8d0ZdO7uBfAtELYstN27tO+jqv1O8txh01JN+vtHVXaGfCy
         wt9A==
X-Forwarded-Encrypted: i=1; AJvYcCXspVe9JBKoHJFNIGHhEMpSLFNLanpIgMFbTQP9H0dK0a8/mLQlm8ev9i0RfqQ99z8siIo6QNDURhneue0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TwIbxEEQmllRpbPJ6lIujRwSmMsFlBculTnElpXrGHndhvfR
	wtNs+HiZf97liF7n62D3t0oPFcdzxsTI7H98gVnO0BMSTOBNGxmpKn5sw8A=
X-Gm-Gg: ASbGnct88hro6V5d1cYH6PjFz+QaVyXu1NQK9u9ir5qEdkWWgy2vHzY4DywfZvb/ecf
	YLmJL4PEqV0KpBecixO3sVBeBCyC3XWUZFrDyTGLkfImNbgiomZA6WgfmIcb90LqMHyhrM9oXOO
	vCSg/ExFFbCNBmXkAdGzh90ucJ9ZJA5ilfBTadvFSLKGXA7/8pgIOWhIorA1UNGE5rKdeagWL9u
	7DtoC13jsLjXXAgpW2zG8AEMoEROcmygD9+AhO6RljNhKR5DCcSQA6yfhdPqGCSbvvp5na9tu2H
	tTH7tp/66UoBhe/CyOSL4sy4TsnoKcZnMieRkW3OOKIdLh++zXcG2ZzB5oFOaUEhZ8jmObPM84j
	+UwaSoGX4PhaRY67dz/giDXXy3NvuCUZYkPalLg==
X-Google-Smtp-Source: AGHT+IFrRw5q9M2JJsWfGtCnYhWqhEN152WZIUDpkfxeTaQDFCXOEY97CVF6Uw8zOja41ZFvg5hMkw==
X-Received: by 2002:a05:6a20:9f92:b0:1f5:8748:76b0 with SMTP id adf61e73a8af0-1fa45a6a3b4mr6202243637.29.1742304746327;
        Tue, 18 Mar 2025 06:32:26 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea94891sm8936161a12.67.2025.03.18.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:32:26 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
X-Google-Original-From: "Lucien.Jheng" <lucienX123@gmail.com>
To: linux-clk@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com,
	wenshin.chung@airoha.com,
	lucien.jheng@airoha.com,
	"Lucien.Jheng" <lucienX123@gmail.com>
Subject: [PATCH v5 net-next 0/1 ] net: phy: air_en8811h: Add clk provider for CKO pin 
Date: Tue, 18 Mar 2025 21:31:04 +0800
Message-Id: <20250318133105.28801-1-lucienX123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds clk provider for the CKO pin of the Airoha en8811h PHY.

Change in PATCH v5:
air_en8811h.c:
 * Add commit message
 * Rename en8811h_recalc_rate to en8811h_clk_recalc_rate
 * Rename en8811h_enable to en8811h_clk_enable
 * Rename en8811h_disable to en8811h_clk_disable
 * Rename en8811h_is_enabled to en8811h_clk_is_enabled

Lucien.Jheng (1):
  net: phy: air_en8811h: Add clk provider for CKO pin

 drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

-- 
2.34.1


