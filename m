Return-Path: <netdev+bounces-222991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7540B57715
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BF7445D8F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CBA2FFDCB;
	Mon, 15 Sep 2025 10:47:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDB2FD1B2
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933263; cv=none; b=MqJGwVwZ/iCdVKMvhB+4KER6zE4UMwHqRuEPHqLgeduj12Eh71wKsQFIU+ec2/ow1NjaFzlfqQUGKMG7XDZ8pGXnenuLH9ZS7x9Yw/NnapafDMsw39m3qm0lEEp1dYAdsBQoyYDnIWRjL2Tsf/XclqhHVi8VBVzAQR5cvvKQJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933263; c=relaxed/simple;
	bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVXPu9cKnZNoncmcf+9X1b/4LbgtLPxxm8r+7z25bOJCLygGsvL0AWozBMMi/0reYqtrSco8vTbmcMFU/XEsOXPRdtw8nM/Cl4v6/XRLl4nYjbGWYdi28gRXgxoiSptE89W5ZLNSr8L0XJBFDFA7A7Ipjg/3dNhlSY9fpP4b9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c081660aso565760666b.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933260; x=1758538060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjFEyEGuqdVSCAOxsi8hLG5VAzYgCXVIet3Kae4PlkA=;
        b=todj8LLCeQQiqTfvMwaJTT+dM3LxZbY7rBubMMVWGeQBNonSPfy5sqnhiW2TtfXzwA
         kAhrtK88r+xnK7QGweeSiUWcdScKlHPLgOTbSdpBRf/c0QHD9A/Apxgtl9sI0ocUpJft
         116KhWE34BmAlZNFiX2YBwCfXF+x1GqA3THPSg1404n8BADUNMy81E/vJiz0yVrM5F1P
         Ro219tRrCCvfOzXx7Tntlrjb1+0jFmBthfsBkniEZrYyUe7LPSa1Vv9TmS0k0/Hj8AV0
         eCQYmpQIxdQZ32gbShHbn7Z7t1sES+SYVT5N3YBiU6lscBvVMmvlQGdewi6fkP0GAbo2
         QgnQ==
X-Gm-Message-State: AOJu0YwdrYg582AWINyrStxjiuolNAkPoYKSV+MhJItrE2m9UxePJHCS
	W6OeyFYz9S8QwwReTHelUGVWmdllUbWTlWb/Ge6Gg6ptAKStekkwyZi1
X-Gm-Gg: ASbGncv6aPdvo9jooreQ0kEb76dhRfPuF/CNZhWIlhaV18p28oQsuu8HlidD5QBUtXH
	zdmqz/MIVdGr2CbIsHej+IG9aoE+pz/O5f/MsQ8ZElaMmyTazC4/DGzSGj0DN9zr8BcvUow23/s
	KTVuesFqvl73DKoR3K4JPKf4dWrbSpaJx5g3vdi7yJVDe9YPuSFZIr/ZzG91Z2/2GQ9OAV0wX7x
	T7nGLvTmjjuyq2wz7DMjvKusoJRzmI0Bo6OtnNUq/tjvC338CG+YaxbT+BiOw7hWOMMhUFa79oH
	B4lwgn/QWI6YHJYMOTTe3guAszogbA4OOvnEyP+3i7O2HqX8/J6TGJwTRbdjmGE1cfveqs6QNK5
	9ngce0jUPQPS0iNzjudSmTzY=
X-Google-Smtp-Source: AGHT+IEQ9CUxEeQHE3JWeIoC8BvynW9DvSy0HF5ePZmATusnxUn9fnpDDlUTtZxfE1vunib1KQd/Pg==
X-Received: by 2002:a17:907:7ba3:b0:afe:8f0b:6c64 with SMTP id a640c23a62f3a-b07c3540a7dmr1323625466b.4.1757933259662;
        Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d6bfa591sm572756266b.15.2025.09.15.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:26 -0700
Subject: [PATCH net-next v3 1/8] net: ethtool: pass the num of RX rings
 directly to ethtool_copy_validate_indir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-1-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=leitao@debian.org;
 h=from:subject:message-id; bh=LCDHUbohxTHgzzdULwcsi+67Tz4B7J+HXNyStYI9NJM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HRQadCYc9h5GkYpniPFgfnT/0CcAEMafkT
 xuCsB2YQsuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bQfjD/4lrt/Xiz2QXAq1v5Ij3l122VUYnu57K+oaAWsTIbUswubQhe9ghZG0rlB5vBcFbKB6ifg
 h4rjFqfnxwPWw1Ya9lScsGSaUuyz4R3iBUjVcYxDzH0whPHMK4u+o+XlPNrKvA/vMu/93lfVjU7
 zuPmKBhPnqiqwv7kyA75z0SY/+ygRSDqV4Y4A8LhT0CBD1bpmMko9PHjRAznUwsfFJqmrrbQTjU
 oSjq4hxms/om1T7G93kQL3qvP/eNjEFtLQ0EyKxfHfERYKVSinEhUdRRfhQmButmHxKQKOqxVmp
 fa9yGyS2O/GmxIlU0d31loo7kOmnt/JMgcAzgjOWbzG+mewUxlhIWZo3cwfl3p6NyFAI7pnkuyx
 ouF3WNW1HTPULNnjt4Zu04Z/QfbvA+WNaYsytakafDmuCel7LNMdELoBUucOaW81PGpVtj9KX6L
 cC4j0juY+QjEwzZXZdg/P/VBkIK5FFLMwNF0ek6z+MK9cVAtmiPB3NHQGKPObQrr/shtegXW3cK
 ruSuGSdZaiC6F5DUIbpUW1EVWbNDfpIfrbSYGiXytw3SivwshUFVkvziN/q4RJoya0D4Ih/dGjp
 Ndf0Zu7KJveBQNXQ6U+f4FILMV78m68phdBBwn3BynkIEpOF0e6p39nkb2VBIRaFT9/shYVlkbq
 x5DvosIngPw6T/Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_copy_validate_indir() and callers to validate indirection
table entries against the number of RX rings as an integer instead of
accessing rx_rings->data.

This will be useful in the future, given that struct ethtool_rxnfc might
not exist for native GRXRINGS call.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b38..15627afa4424f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1246,8 +1246,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 }
 
 static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
-					struct ethtool_rxnfc *rx_rings,
-					u32 size)
+				       int num_rx_rings,
+				       u32 size)
 {
 	int i;
 
@@ -1256,7 +1256,7 @@ static int ethtool_copy_validate_indir(u32 *indir, void __user *useraddr,
 
 	/* Validate ring indices */
 	for (i = 0; i < size; i++)
-		if (indir[i] >= rx_rings->data)
+		if (indir[i] >= num_rx_rings)
 			return -EINVAL;
 
 	return 0;
@@ -1366,7 +1366,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;
@@ -1587,7 +1587,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  &rx_rings,
+						  rx_rings.data,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;

-- 
2.47.3


