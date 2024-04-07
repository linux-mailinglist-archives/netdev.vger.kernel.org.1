Return-Path: <netdev+bounces-85486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2863B89AF69
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F631F22124
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA711173F;
	Sun,  7 Apr 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqbpjPLv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2611717
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477125; cv=none; b=M5QDC+S3cXkkFou2XBP02bbplLJ6yOlqi3CAtiG9yDPWC+Pqb8jC0T4+dpbwYYtSB39pxbe5eLA8fUpxtXu46yGw/33DKc6JUx1OxOS0R+4eifdTEusSM6assYiPCmQz8aO2R0XGA8R+9Qz218wtHJhMAsF+1T64/NbPGB1cUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477125; c=relaxed/simple;
	bh=sipUYppo/fuNUneIxzUGvGCxT1E3jMZtBO3piEFY9Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mElSH0EmCkUb82RwNs4ZdmqEZiVWxRImabIW7Rdr9lTn15SQkYm6/6aYJvwHECgfVYyaYnQG0sEVPaKY5jQpNsF7U/IF5EpBsMwAHxWLvx6ci5z3pQhh2Oyv1R0COhhCN67FIZyQjHNRDv7jmKMVvhqrKotFROrK1uSFWIV/WOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqbpjPLv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712477123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fZMY4FIR5bqHlVqLpHDKFnD9HwhABXpqUz5I1Slfl5Q=;
	b=JqbpjPLvsgF94WhbSgJ/kUxp846SAWVyqQo2wieC7exSfAzJl4IMMzf7A43Z2klf1JLLfW
	2oyI+a8F4PQgNjiK8KmyG4+IfmWIVhdEnanaq2IFQ0sZ/KioVR3GgStqCdmSnRSlEi9K5u
	bFQT/fR3gDJxNpDzOsdzKViF4LbUkmU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-KTICYUkLOAShzWQ8BlIB9A-1; Sun, 07 Apr 2024 04:05:21 -0400
X-MC-Unique: KTICYUkLOAShzWQ8BlIB9A-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e278ebfea1so32536085ad.0
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477120; x=1713081920;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZMY4FIR5bqHlVqLpHDKFnD9HwhABXpqUz5I1Slfl5Q=;
        b=pmV/iyd+5L1j12X8kE43LCZR4EzilvBpaTDW2DK2ZhmtypNhS6iOKwAFtaun2k2VdO
         ISjGZgd7w0RSSHzi73qOpFR/bP35pPlb91JCmUJ7HJWhTYRBJOLeSurlT7wAamEIoMOk
         u9doJyAyvWGZOCwc7Rb43r/lBHYxvtwIG2nW86CBAVvJhHpj77AE1axiUolkkdZSw2DY
         YtkE3SL64+XflqBPYlA34trHSMSaTgZmr5gvsrYv37WHd1rnzHZhwKY/LVRfJagyjde2
         ZaKu6Gr4pKbcORNRYY89IlJaL1DQ8afaKw2MQY4vI4GAZ5tm2kQBPv7UllJtmBtnCKoZ
         /EtA==
X-Gm-Message-State: AOJu0YzfX8dROsNrBoASJJV37lYUKiyBIT0cyPNwCM0OgEmFNo+18+9O
	UNvMt1DtcU70wE3wgd3hHBoXSeASlYeEkck5mKOGA0Dh1+rEyMmR3dy2Lee++afL+FcwijIEqaL
	F1ySKHOOBaa0uCFlwZY0QoTyLHF/BU4TAIBK8w7wlKV6VGDPoA4YrSA==
X-Received: by 2002:a17:902:6806:b0:1e3:dad5:331a with SMTP id h6-20020a170902680600b001e3dad5331amr3186998plk.59.1712477120363;
        Sun, 07 Apr 2024 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdLw+ctudtG5r+xOHndXsrdEa+rCjmOgdC2XpVPQttOj9CueVJYiAKFgBsFYW1hcW2+KHY2A==
X-Received: by 2002:a17:902:6806:b0:1e3:dad5:331a with SMTP id h6-20020a170902680600b001e3dad5331amr3186986plk.59.1712477120035;
        Sun, 07 Apr 2024 01:05:20 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902780c00b001e3c9a98429sm3735115pll.119.2024.04.07.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:05:19 -0700 (PDT)
Date: Sun, 7 Apr 2024 17:05:15 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syoshida@redhat.com
Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <ZhJTu7qmOtTs9u2c@zeus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

syzbot reported the following uninit-value access issue [1]

nci_rx_work() parses received packet from ndev->rx_q. It should be
checked skb->len is non-zero to verify if it is valid before processing
the packet. If skb->len is zero but skb->data is not, such packet is
invalid and should be silently discarded.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 net/nfc/nci/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..b7a020484131 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!skb->len || !nci_plen(skb->data)) {
 			kfree_skb(skb);
 			break;
 		}
-- 
2.44.0


