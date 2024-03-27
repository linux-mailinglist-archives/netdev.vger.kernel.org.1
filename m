Return-Path: <netdev+bounces-82398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274BE88D887
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 09:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A057FB21449
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D22C6AD;
	Wed, 27 Mar 2024 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3y+B7Rw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7C2D7B8
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527259; cv=none; b=r6WMFYE++iT5IguPbhBZ3vNDyLBvToSwRbzOfHwJBqkWI0RtLNSl92d1nyntJuDxHYJikZz7uU0Fv83vLBVC0+Ynb6pBmdDanfVTl2RarSLlxJZ7F7pNvBg0Xwq1l16mn6vTkVHAptqXkly4H44RpqOBNWpZYlktQ13ZvEzkuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527259; c=relaxed/simple;
	bh=WhiU3qnAZAo+u/LLYBdBmmQwrc/f80d9VJ3lY8WekVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s60cwj4wERZuU+R9Ha+N2XzDlEd1Ep/VS818k5yCWQ1Ll04oJ0dUtPNBymt1M9PtbliHH7JwasdiDnP6Nug0uSPZVU8C7pCqZfWLHYCppG5GTKXwJhl/XZsbnYMXIeQ1uHASjLCW7PWTR/yAx7kHMbGVXOIvq30Ou/hudfQdeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3y+B7Rw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a468226e135so764288466b.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 01:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711527256; x=1712132056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GcRkpUPOOQ/1dFzwXJ0VEIZo2wYfdhTBr4MYEWh2DhU=;
        b=o3y+B7Rw68XDED0YLTb9X4L7CvIn2z7cMLGOBjNMmGiXzZqmaHiQX7fsHEg3DQ8uki
         7dTz/gb84EAY8+292ulI9zFWAXzh5LsnTPFie2eYWbHJnJKa0/+StJ4NI3uUkK8Vtl1B
         W80PRmMpYWpqllrC0k3CmNAN1ryTmVCTSHDm2PCLrJ72SBra5Sh5Vn9pYw74uMMjn1qf
         BmSVP//SeL21FTPEbeDObGwJEtdDnzHg6NMTZW1jpMdCx+TRtf6Zc+0A6K3+kAv5SOTc
         1qMTUTLLlBk7O1dMvjMrRtmSXRZngf+BFw14tno0JOc/j+mf6gvaxS51iOWl57NB13Ib
         SrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527256; x=1712132056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcRkpUPOOQ/1dFzwXJ0VEIZo2wYfdhTBr4MYEWh2DhU=;
        b=KHxpNFtY54dA5XGzJSvo7q0ES6okTI3rWpyNnx1+rwDN/+yqKy8YG0l83IN4bbLkD0
         N+Er3Z1cCHMLh1hkxL296xLf3A4R9D6KVcyqD8lErrxc/wXq88S2b78gE6I7lSomVFY/
         U5P+NXmjkP/edk34BAivJv5XoL/9Az9ddb4crdE0rx/EdiMKKJ7gNUTR6LlsSOlm5438
         vrV1c4Z9Pc/nXP1QP7yvi1sYjLSxYGdHCF18reczPI0DGVE1BkSqc4BIGtTupZOyXG9X
         5S4SnpiULdhp07yYqSOEmaapsLbMa12xiVjI+j44I3ksh23mgJf5+HN270/9WF23shjY
         96UA==
X-Forwarded-Encrypted: i=1; AJvYcCUT0B9KAHk1avzWcsczunwBQrLPvfdwSU6CN9Y1OpNApdMOV76r3YTV4nFzz7LHLavPi8aSg6xexzScA8x8e8jAdxMgNGII
X-Gm-Message-State: AOJu0Yzb3fEIE5pOtW6OQeJOncX8GylpVa/IPhIlJK5wyaX9b3Oz6X/6
	65dnodNhOcsIUDV46YyKZGmf2GyHHGpPguq+cW5byBYXg+i6ktg3yWPS+sueu90=
X-Google-Smtp-Source: AGHT+IGh2xd5TSfHmBPgltjPQESX9NhUvokEIUGX093mh0uhj59kZFKHtek7vvfaNBWl3eYW/5FuZw==
X-Received: by 2002:a17:906:4915:b0:a47:5242:ec4a with SMTP id b21-20020a170906491500b00a475242ec4amr3220824ejq.57.1711527256286;
        Wed, 27 Mar 2024 01:14:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id wg6-20020a17090705c600b00a4a3580b215sm3116973ejb.80.2024.03.27.01.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:14:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ajay Kaher <akaher@vmware.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ptp: MAINTAINERS: drop Jeff Sipek
Date: Wed, 27 Mar 2024 09:14:13 +0100
Message-Id: <20240327081413.306054-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to Jeff Sipek bounce:

  Your message to jsipek@vmware.com couldn't be delivered.
  Recipient is not authorized to accept external mail
  Status code: 550 5.7.1_ETR

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index de17c0950d83..65cafd618c9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23655,7 +23655,6 @@ F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
-M:	Jeff Sipek <jsipek@vmware.com>
 R:	Ajay Kaher <akaher@vmware.com>
 R:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
-- 
2.34.1


