Return-Path: <netdev+bounces-96831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D477B8C7FBF
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D31F21F8B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637417FD;
	Fri, 17 May 2024 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMs0GACj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2C1849
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911590; cv=none; b=AwHDpD0AQ0yRCrVFRpj8xjQ7ITqj/dB+tPrlmACS9D7ptOFKrFKnLz0oXLVXc4qowq+wOXa/mX6l4AYhkHJKoPD/riI/nMLLqFBAVHh82NIDZg3JJPB9hOq4eI/PJ9A1udzL/cBWjbB2B0eA52y2x5jBoxwusizUjIri0k4IyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911590; c=relaxed/simple;
	bh=SfHVswkbrQHqpzZdDcPeh/wRZ2CUDzHmY8tYWMbsUvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3cWACAji5C9a4RVk2zUsP039wGxtHLDYOdIxm1MHOdxYSeUQTHxV2ZbeDjEDiRfE2ZBW4rSa6ngP+BFiINXlRuxw8cgWDQZ6AVXZ02KHBu/mdypGWDTI7grl3SFBd3JjpTClvJubCtCrtnLaXbjN63SOx2zsgqCBJgZzShGE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMs0GACj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715911587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2qop7DDk0mOLQghvNp8dV8z552lIH0Gw3RJVGiNIog=;
	b=BMs0GACjA0A2WaJb8jC/Ve6x/xuA3N6yZz2dSI5PYWpfyN31xW8IQ3yR9gUy+iSWSWmMkz
	DCVmTP/ymqSnth5+Dcl1qb3fSv+5njHKUQw21WX16IPGgbzLMFGU2u7ZJ+BzDbNqLLmZD4
	ZOO27/mqPB84BSxE3Elm1CfCLpvZmWk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-4BJudhNhP7Swd-lCXHZ2Jg-1; Thu, 16 May 2024 22:06:26 -0400
X-MC-Unique: 4BJudhNhP7Swd-lCXHZ2Jg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f46eb81892so8099561b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 19:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715911585; x=1716516385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2qop7DDk0mOLQghvNp8dV8z552lIH0Gw3RJVGiNIog=;
        b=gTRkTeLVrHrrnE9jJamFOfQ6ygdpnnEioR00wXp4nmH2SOBRhB088SAN2ajFqZHIL0
         SA+9Dlo1kYJvQmeGkXsCydpgWz9LVwmcOXmrwwlg3HFUUeUxafgZVZwUrQWz32MX6AmU
         NPaymUCI1w33YdsYcS8tM9t4fg60zCFhxWsKI6CUSv1+St2wcRtIlq1KYx0BKXLqXfVW
         LCt4qO3CQUZ5JVztX2MnTFp1vrdpKsuh3hq519GDOs6mZD4VlQd+kxe0/emUwV6/nRtB
         CRk+AQw2LwjaZ3/oIUqA1NSq3MW7vDd6gY3EZiNMb4sA+kc1JXgHnob3Op8Y+niV7Xte
         IimA==
X-Forwarded-Encrypted: i=1; AJvYcCV/DapYGzKdys5kRqkt7zIgkdLOGbZbjU9tLhn81dwRhVNDIHVcxeTliDqaEdIByyO5VDdOVyvuxjudGcC8NKIWjjSl2nt2
X-Gm-Message-State: AOJu0Yye6NGe+z6p0UnxcnJ4scdRggBt8D+fi/QxQE5bYeFcCTFKRy4S
	0H+ZKxk8c2KRi/fy2hB6bFUO3Vr4bytakTIvte84KmsiYWQpGggEdaYKkQXA1GjupiMQNH+43Vn
	Txler8UUcraWdWiVRuO+46jQCAO8+XIiYc57Dy9nm/lRHaWDbnhsCjw==
X-Received: by 2002:a05:6a20:729b:b0:1ab:82fe:910b with SMTP id adf61e73a8af0-1afde1df2b3mr26303599637.58.1715911584932;
        Thu, 16 May 2024 19:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/9hFAfDVvEiRxBU/C1pVa7/iAU8+CbGaa4VMLjUVVJO21sBSMQyqZTynlZzL/NTGFLkMWuA==
X-Received: by 2002:a05:6a20:729b:b0:1ab:82fe:910b with SMTP id adf61e73a8af0-1afde1df2b3mr26303585637.58.1715911584524;
        Thu, 16 May 2024 19:06:24 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b06sm13699721b3a.167.2024.05.16.19.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 19:06:24 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	syoshida@redhat.com,
	horms@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
Date: Fri, 17 May 2024 11:06:07 +0900
Message-ID: <20240517020609.476882-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nci_rx_work() receives a zero-length payload packet, it should not
discard the packet and exit the loop. Instead, it should continue
processing subsequent packets.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
v2
- Fix commit msg to be clearer to say
- Remove inappropriate Closes tag

 net/nfc/nci/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..f2ae8b0d81b9 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_plen(skb->data)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
-- 
2.44.0


