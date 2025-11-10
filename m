Return-Path: <netdev+bounces-237181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C71C46B02
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDA31882296
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1673A30E82E;
	Mon, 10 Nov 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="eQ4QZa0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D650223DF9
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778637; cv=none; b=rFnnAvno+vBA9/b+x4ey8KQnFQME01vcdLrt2AseV/+YcHhp7mkKRN0ua/BHZctGpyxcjK/1i40ktZ9TdKjy5ZqENJcueocAZdw4SSh8IDJ8PueeZ06ZOX58soraud+qcZw81Yt2m468nmRKuJXDEj46DFtDpD+rSkFyru2TA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778637; c=relaxed/simple;
	bh=Dqk2TNHLlYpECDsfQQqf3/nq6Wnc//qiCf3BE7O4V2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/wbk9V3IAmkH6KSni8pNejGVIojGhgOfkw+t9PiNe91h5xKVcAup3zVjCVWbdlzk8jPrb3olFXK6iDX651fjyTFTRE30iQPaAKG3E0wb279ilhyi51P8fWDk2UyPdokMpEmsDioAdyJef7LSx8jJQm8F75rI+JwwHu4qQCMWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=eQ4QZa0H; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85a4ceb4c3dso278238085a.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762778634; x=1763383434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mokE1STeYnllduXZ+33QLu6bZS1LJLoqGu+1OJ9vbsE=;
        b=eQ4QZa0HSfmvDaneX1yhRverg6HXnlIrxWyjAK7uE1jJ5BKaSe/xA8t/F7RdnWjkeX
         TgM+xZR/D1d5GZ6y0P89b/frEf3b9W/Ee1GRuWr9eA8bUJ1XMCEFeWlCgpwSpfVOIO7P
         scr74wPRw65BlG7lhr2W+Rwm43O1MqqfG6/BFTBuZ+VYSWSOGFfoX6r1qDK8zPc7saoV
         FMvP5CfLaOQsSf9sFVvwMiUPNLa1er+aKEPYSYlZn22OTzFZjVoeERwMJndSQ7V0XNcE
         P6aosstbsnwgWlFS4P8yQLxr8i5SJJtHfB+7866VaT9pKSODlblD6EPdfFNXI37AE6J0
         Fuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778634; x=1763383434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mokE1STeYnllduXZ+33QLu6bZS1LJLoqGu+1OJ9vbsE=;
        b=lN6YIeySXwboa4kSSi7CU7WQe365Xxusr/5KES58PcQTHxnEvNEoHKeXiKwzahGCBu
         qoDqjuBUIQroBH0Gmzjx+jHb0vI0Vjkb8Kvnw34U798C3W3mbmiYzpBkc+wuuikHZ/9S
         oGBLdeeG3oqRmrk5dqcfk77vG39p0TwWnPEtSivjCweWFPns5qV8dXY2oP+D7wFWjt+b
         jl+f0okNE+4+uZTzbFy0pW5FkHHjfB4fkObdXuUoMQA1+yO9dJQs5gYqUyZtcKdD8a5w
         sTQGCx745e6s7CZWOR9dxDDA6Q2T9UsrMf65x/0n38ItINqyiOV0YcksNmTJ131JGsM4
         x9nw==
X-Forwarded-Encrypted: i=1; AJvYcCXLFX4zIBHbsdKwaIy71vb/caNlp+1TX9zUUJsEvdI8bBUoQ3/+FiRbAOUYk2vHYiGZMcssysY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHbBIhohJ1kc6cjCtn4s7EFy6UIr4nVATLd5xGssnjbOIhy2Q
	Y5zKHnkeizuSvOdVS2QqBp7vRhGpcm3jwuRXH9I4U5Kprb6rW12BqKV4vIfJYSjN/9w=
X-Gm-Gg: ASbGncv4UplQE6BnLu+ypBLITyYmTlp7EGhpBqpbLBP7iT7pgF/8tHX6DrptynsfwM/
	6lSTyQjRzy8awxszCnLoTsDUGoZZnp6kWb25OT1AgwxWqur1RG5kGplH1R/a7Z0AAvLgq1WWN+C
	qI3poV1S5CH1o9sdL7ev05in3ZfcLNrgl6uhbwJZEiW8Des3sEIe58OrFTslzxlgqJWH/SEymSe
	3bClBMf3/s0twwObfr2IifKOHJG6/QOLnShdH8DEqvoCKOsAr9S9wbdyw9blC7lnvYD3Ntlgv+N
	MRbk2IEnJKrUHuceDApxVzIA80AcDYK40KCfdIDyzisGq+nP7CtDhqa/P9SMzy4t3DcO94rE+MR
	DSJLpMS6MIopOp4gn2/RWt2kuXDYeuTTk505OCYGS+nRqfmUCF0oTBA7eHZr7+RcWbMBYsuH6gh
	98DTo9LDb5AU5I8Z+x/R7k349k3ygPv5g=
X-Google-Smtp-Source: AGHT+IHzD9vQiWPhgW/CmDZ0Sh3mVAM0JnEabgV9DyCHXVHZqLCr17WfmN9Rv8GMnK6YWCsW15692w==
X-Received: by 2002:a05:620a:2982:b0:8b0:f2bd:474d with SMTP id af79cd13be357-8b257f6bb13mr863976085a.64.1762778634203;
        Mon, 10 Nov 2025 04:43:54 -0800 (PST)
Received: from fedora (cpezg-94-253-146-68-cbl.xnet.hr. [94.253.146.68])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8b2355c24f6sm1002765885a.6.2025.11.10.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:43:52 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	horatiu.vultur@microchip.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v2] net: sparx5/lan969x: populate netdev of_node
Date: Mon, 10 Nov 2025 13:42:53 +0100
Message-ID: <20251110124342.199216-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Populate of_node for the port netdevs, to make the individual ports
of_nodes available in sysfs.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Per Daniels suggestion, set it directly in sparx5_create_port()
instead of doing it in the dedicated netdev registration function.

 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 40b1bfc600a7..582145713cfd 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -395,6 +395,8 @@ static int sparx5_create_port(struct sparx5 *sparx5,
 
 	spx5_port->phylink = phylink;
 
+	spx5_port->ndev->dev.of_node = spx5_port->of_node;
+
 	return 0;
 }
 
-- 
2.51.1


