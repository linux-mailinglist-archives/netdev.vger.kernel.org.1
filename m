Return-Path: <netdev+bounces-66827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAE840ED6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990DC1F26389
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C654161B59;
	Mon, 29 Jan 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeWhUdpA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA415CD68
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548354; cv=none; b=og+Vulvtk99Ux0Bm7CepvyaaiWmFHTQra6yyoHv5fBRP27pk4rrmrI8DX+p7dHHrNCaSz7DtsQ973D6TRpIyXohqspAUD398vivQfah+yGHw5aYJTfeoVWdoNuqfyMSCATdqnVuwSm47k6Fo4Hg4M+D5S4i+mrgwNiMB57lAmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548354; c=relaxed/simple;
	bh=xN7z0yKJVYS2/AX2hKKn2FEDmI//91+6xCLFTLbayKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sV8C4t8gUR9F/Gtvn6CxYvRwCYkcEm7J5eCXcwLtenmMbWX/2kYI95CpS+rE76Al9L/Fm5K2TTPJ9/jICECJg0VJiS0dkUSdI3b+YQmfbaPq05ZNaE4y41xKMmIgjkMzd+mYrI8QltrG258pjjr+sIxebmw5ajuLfAX+rRpR6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CeWhUdpA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706548351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xsce6k1bFLcIW+x8jc3gQMrtFj/bRo1gjpGuOMox5NI=;
	b=CeWhUdpAVEd3eHA/uJYbjZnkEXzNZDbxbsIqdrXMVmE1B2KAYrDIUE1JKusbkGRAEVSaCJ
	D7XdmHgMdU6Jv81Fos+aBkqFWe23vTS3ithqLNBryVSi7l1B9QLdN3e47R2Jr9t6yqQQG+
	D8ffZ9Ce5mS8KO26lxfM5j/ZgHRG7nw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-7kC1nDTCNZGli3uIgMb_dg-1; Mon, 29 Jan 2024 12:12:29 -0500
X-MC-Unique: 7kC1nDTCNZGli3uIgMb_dg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78408c4e2c2so3664285a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 09:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706548349; x=1707153149;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsce6k1bFLcIW+x8jc3gQMrtFj/bRo1gjpGuOMox5NI=;
        b=QJbPALmMo3FBhilPnWLtnEP/2/3Gv2y8Qqrt//mzNC2UdkrIyC2nuuxv4uk6a1PZNW
         eEiP9yn0GwnujzP/b62g0vOlJG8gxyxSkzrBFkMLmQg2LR4zgasAGZO6lR49/xQ1f1J3
         OYLR4HDYIE7qnnqfHfn0FMx2hu8n17ec9aDpGeNNeNkK/QfS/8khVvshGuVYhsGKGqV/
         /CCoWqtX7sX4t1cMoV624zjPaoy4l9tLoh14XCcE8McXPTKar9S6p61TAbznX5MEpZN7
         E13AwXCt+xIsEXZwIk06xoZHOWxkESmmutMjzqh/AInRLz/Nwr6WWChFG326CVdHARhC
         hf9g==
X-Gm-Message-State: AOJu0Yxr7E8tvXTRQjwt2Xi/MnCQrPniAo+hKPoqzkeH64S47zHKAJPb
	3GNWdqXsCsuEQbM1dEEFS/Yg7Zfwdve2TgDm5ePyFfCBzA+qckbBGWeejXo4To0Z5TQI4AwfT3k
	QsHb3EPuF4o+CMGHnW30JUZqAiYGDJMkR7KaTC16lOFdJ7OONe/3okQ==
X-Received: by 2002:a05:620a:909:b0:783:7775:b395 with SMTP id v9-20020a05620a090900b007837775b395mr5917722qkv.74.1706548349405;
        Mon, 29 Jan 2024 09:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElNUymv0hHq1m2C6+cST6qAHiLIvOpOWStiSVR+Syryq46JeptpoFsfRaKAcF+vcwSHf43/Q==
X-Received: by 2002:a05:620a:909:b0:783:7775:b395 with SMTP id v9-20020a05620a090900b007837775b395mr5917709qkv.74.1706548349138;
        Mon, 29 Jan 2024 09:12:29 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id e22-20020a05620a209600b00783e70cf38asm2195577qka.130.2024.01.29.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:12:28 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 29 Jan 2024 11:12:11 -0600
Subject: [PATCH] MAINTAINERS: Drop unreachable reviewer for Qualcomm ETHQOS
 ethernet driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>
X-B4-Tracking: v=1; b=H4sIAGrct2UC/x2NwQqDMBAFf0X23AWTFNT+ivQQklfdQ0zdiBbEf
 2/a4xxm5qQCFRR6NCcpdimSlwrm1lCY/TKBJVYm29p7a+zAipR3cDySD7yGnBjbvObCPxsHlI1
 3XexDZ1zvqHbeipd8/o/xeV1ffEfE9nMAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

Bhupesh's email responds indicating they've changed employers and with
no new contact information. Let's drop the line from MAINTAINERS to
avoid getting the same response over and over.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
If anyone knows how to contact Bhupesh / if they're willing to continue
being a reviewer feel free to suggest an alternative, but for the moment
this is better than nothing.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 939f6dd0ef6a..b285d9a123ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18080,7 +18080,6 @@ F:	drivers/net/ethernet/qualcomm/emac/
 
 QUALCOMM ETHQOS ETHERNET DRIVER
 M:	Vinod Koul <vkoul@kernel.org>
-R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
 L:	netdev@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained

---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20240129-remove-dwmac-qcom-ethqos-reviewer-1a37d8c71383

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


