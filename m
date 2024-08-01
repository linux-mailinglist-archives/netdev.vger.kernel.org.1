Return-Path: <netdev+bounces-114987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E378F944D8F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0F1C22F50
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2621A38E3;
	Thu,  1 Aug 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvCGCirj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C516F267;
	Thu,  1 Aug 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520898; cv=none; b=qpJeeNpZqn/BS+wRjfxwlxaUBHj3ndMpo8NwL5dFL9SLLgUXxAQ1D3jclFWlw3iXfocL3xWt+Ahmw1gr5ZWkuPT6pBWWaFsoVUOCk2B4U6Dh3TcjtVZO6oDG1vwtSXcpFWvwaIr2E2HGjPErp8Q6Y5TzS8+ooN0RzROeElPZoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520898; c=relaxed/simple;
	bh=zc3fmwf7uam/V7MXE/k9UtioS2NVM6p9a5PBtxHgZ2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TG/zABroKGAlhg9YVnycp3zf0fRiwRG3/rA18pASaxGG0CNOsGuBPpwfWpUDI/suKf305SMaogwMRjwk9qLz7ktVClY4Cve8rh19IoixvfMU8rwTOsoDPOLdgEN4b7SSOt+cYUsjMfJaRAWgZvabRLurCZaMj1UEPo+v2XiPHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvCGCirj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a8caef11fso817463966b.0;
        Thu, 01 Aug 2024 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520895; x=1723125695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H10mZqEzOx4R7FeQ2dtZavYhrnIDzbwG4r7Wgi27o4w=;
        b=UvCGCirj1awxbRW8lBwp37O16QOJ7QWBUBMkk9cOUlTpyJknXuYrBTZuQbw7kksJ7a
         WWGvrJdCFwZ1oY5P/ZWGXocCav7LkO0QaGBL+IqPEij7phWWqchCSmUoRTilaPo7NNwX
         l90PPajKAWEKdhCbh5jqec4LoYqHXnyOHbMJJSBQfq36ZteDxWqCRgQLjog2r56cPBV+
         s/Vvq2uMHuDCbCiboXCLR32pKoU5mto+/5RLyEfnobJoGBGTq+RLBFOHiqgqEFKLL2M7
         TE4f1XM8FCnfF1dHD+YENFTX3Io9yUMtz2mrX5TXKU7lFyL/tdDCOeSk+Z/++pe58WwA
         r4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520895; x=1723125695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H10mZqEzOx4R7FeQ2dtZavYhrnIDzbwG4r7Wgi27o4w=;
        b=YwkttZNhaew4qT3RRjzXNKgZsVNgOTIlYR3peEODQd0fpWBnawGUCEqFI/JHoHJjAa
         CqHGJGqV2Mgjy+NuH4d0F3ruoxPCQ6O+X2e1mydEGQrCUuHXlQ+18tW/DFUgPLHtOdyN
         BXlboweKY6oP03rJDGIytPRBSUhDP8PJW8HRu55jvYD+zcZvAgVTQV/4KJdrl0L0Mdpq
         khQstmlGNomcyf6iW37el2buPjqU+VJYfvi587aZMUvcE/FaFsk8a3wACVUevFHvo8nP
         l5QnCNszLqX1TI0SulUAsemDJaSvbD4Hds+R4pbOQOPv4tju8unqyOojcwaIBSDGKIgi
         fvmA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZcHXgcGADi1/uCMPTixPCQ74hQbiHqDBOImifxc9Z4SorVTamsorBLn6C24naC63s35vrsz4LuWMNZ/YV3GqXK2l+3ETmBE3
X-Gm-Message-State: AOJu0YyUGQODKuoYq9TVsHTkXksrXh9ccSEGmoW1w8HYMWliF+OlxfBk
	r2fwnNYS/Vy0Hj3okeCfqLOJAPPXgYZw6WHHiRnuwXXzx80bDWCDSVsd47wg
X-Google-Smtp-Source: AGHT+IEoD2t9DB48Tvfk36MbHboQ5U4hDU2tMQr1NDZWvHmJWBHkumulozDgfkSYtOMGmnPhjlQSxA==
X-Received: by 2002:a17:906:fe4b:b0:a77:db34:42ca with SMTP id a640c23a62f3a-a7dc50a3777mr17724766b.49.1722520894273;
        Thu, 01 Aug 2024 07:01:34 -0700 (PDT)
Received: from ThinkStation-P340.tmt.telital.com ([2a01:7d0:4800:7:5620:85dc:e603:93e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de47sm905748366b.67.2024.08.01.07.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:01:34 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net 1/1] net: usb: qmi_wwan: fix memory leak for not ip packets
Date: Thu,  1 Aug 2024 15:55:12 +0200
Message-Id: <20240801135512.296897-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the unused skb when not ip packets arrive.

Fixes: c6adf77953bc ("net: usb: qmi_wwan: add qmap mux protocol support")
Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 386d62769ded..cfda32047cff 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -201,6 +201,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			break;
 		default:
 			/* not ip - do not know what to do */
+			kfree_skb(skbn);
 			goto skip;
 		}
 
-- 
2.37.1


