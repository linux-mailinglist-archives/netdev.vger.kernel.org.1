Return-Path: <netdev+bounces-65024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D52838E47
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1EBB23677
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27605DF01;
	Tue, 23 Jan 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnswHsrN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E414A96
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012225; cv=none; b=U7/W0AvIbVvMD7XpljN+wqgCs3GAFsNIjf6RN9l4aTadTeCe0NHdzduVWz6NRQ90+xWhArV5hVR/47LnqqwQ4Ks4F9RPJKfaoy2ee8ARLebtN3MWt2015vOYPC+tk63emiRYGNQz2fdNsnhWhhqXNXpryXkA6ducM9bd5q6OnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012225; c=relaxed/simple;
	bh=mT6QUyAOyG413H9VKL2MCXg9wJj1EwL3uwjRp/Wf/ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WxJr5oIHVzF67pbUhniURsxCfYcWJwxSEn4Rcg1KSvNWHBCVYepVS/dNFbGK0rfjC1L7DTFR37ib8bw8ZtkavzTuzfaeDeRRuAhkdtSQinb4BuYqlebouy/mR9nnmOuNnOwakyO2JmUBFD23hrk6y86znRqEyAwwhLf0BeTmSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnswHsrN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e79299da9so761365e87.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706012222; x=1706617022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VSCTc0UcZ43MRWwOvr/H+aTbltxlS14DBh9MmG7K530=;
        b=CnswHsrN1dt0N+oILKCgca8EGHU+UFQkNvPIS/Mwb8YHvld68pHYMPLRZzD/eN31nL
         U92HK+9c9UnTxCUcGa8ing63OoY5BrqSMPzl7ooGjKPxbZ58FWNHxC/bpsCl8NhWa7e/
         eS4cd4wxllByacUN6zw7FIZuAEEzgl0Eevy1r23+O8NNy/xCor88B3iJPQ8nemGenDn2
         v8tWCb2KyEQLHkqwa3/EJLqJjARJbryHSD/aJD0Bz7B3UH0TwqVfPqlr75Tb51ghk/4J
         cX6v1AxRUiD88kLpOOChYU3EDIXmuRk2GhTWGPNf859vcGQp5+3EVRo71yTuR3JK/bL5
         5L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012222; x=1706617022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSCTc0UcZ43MRWwOvr/H+aTbltxlS14DBh9MmG7K530=;
        b=YoHG6pvSCNvvXPVHLAoRVMrrjETh/HM97ey0qrlC9pPQmjTkC6Od1D9JitUVQJ4p6Q
         UczQnKPwtECWtirpTpZHsG5Yjec5Dd0Owe34dgAgq9lvj2olBO1/6IzRFjh61klxbK2r
         VSk84A8JaAQ2kYW+kAbF3fDAj2adIWlEmu6mIGOKl9nZ9BWBoYOMQbQDaBMlpE5FCiX4
         YqydeNtiQMtzfrDLDO2pl0E03DKkVqwsgDRns9NMecCqvttkia10R4HBZDmlXOd9Ipd0
         DrRNK3h5DLBwyxhEl60PM4qeiC2z9pPKDW4QETfQVbfW3xPDLttQA++jVT0kvU9iAsdB
         R2FQ==
X-Gm-Message-State: AOJu0YzN0gvYHTae/Xa2z27E+a5YTfuwtO41ifVcLC+CC0Xygs2hiqlR
	7xd5uv98sJGk09qaIyATsVK7KIWaIbcP5fEoLosVApKMErSl/aL5
X-Google-Smtp-Source: AGHT+IGWEDaJJYcF9HDBLiXmlpy1fL7Oqkb8XSN7qdGe096zKMs7fR8sJcv+u3N3v75E1XF+22Iisw==
X-Received: by 2002:a19:4f02:0:b0:510:7c7:58ff with SMTP id d2-20020a194f02000000b0051007c758ffmr1115506lfb.6.1706012221771;
        Tue, 23 Jan 2024 04:17:01 -0800 (PST)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id g11-20020a19e04b000000b0050ef9866df9sm2331976lfj.264.2024.01.23.04.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:17:01 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] rdma: fix a typo in the comment
Date: Tue, 23 Jan 2024 07:16:57 -0500
Message-Id: <20240123121657.1951-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 rdma/rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rdma/rdma.h b/rdma/rdma.h
index 1f8f8326..df1852db 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -40,7 +40,7 @@ struct filter_entry {
 	char *key;
 	char *value;
 	/*
-	 * This field means that we can try to issue .doit calback
+	 * This field means that we can try to issue .doit callback
 	 * on value above. This value can be converted to integer
 	 * with simple atoi(). Otherwise "is_doit" will be false.
 	 */
-- 
2.30.2


