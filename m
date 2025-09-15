Return-Path: <netdev+bounces-222996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF073B57732
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258E03A732C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084F303A35;
	Mon, 15 Sep 2025 10:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF530277E
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933271; cv=none; b=Ai3Pqo8guW6ZvLJn++LcrB8sGBHXGxL4l2AHjCpZywSbxiPnAglApGr7hC6D2RPBdt/fXmc1ULn1PYscK/smXF+q5NlJ7Z18E8+Xi40fYBDmUTmFCsdZPhCpqEtsqmvrGE1LBpwAyV2cssp2Z6yFAbJYHWQxRCdzfnWe2vPKV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933271; c=relaxed/simple;
	bh=nh0Gd8fHJE8h5NCSVCO0qeGjEU/OiffbOrqPJ9TZRyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RG4GtTi0lEGNfdX3PkAAO1qYwL/VbqHSgX3/Mpl6bDntk23eEmEAZJX7ehGeHi0Q0wdhk5hEwFneAikgtTG76AZjm60DnVKwFNx6nhrSNWF+G9UdIl2qfVFVHw3AoAHWZIAGL1A3kRf3hRTyFOnC8Z2Sjm5THugjh4tfy6Qzyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07c38680b3so445551466b.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933268; x=1758538068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3zJ2PhZUzoN48j7NGHKfzo8+L/UqnsBZHD1sGknc0E=;
        b=wzBeFwgIKlj7pkcjKZYrWZ2UXtqHAwb96PS3jvXDYNm4GQXPxxQepg74RaeG50Qan9
         1QAHhN/4RC2C5VpgEuVOhCbaU+OR5ynWrV7b9I18TVa1/LTrKhrrweN+I9nERCj2M5KB
         XC1JQivy1YYxuJOcI72U9J8P+cEOqNNrQfpLVRv1un6yqDEsvfyAbN1/mUYam+GTOl63
         padDVvWdb1rik2jEQMPKksFJdl+FYTjrCzS/OpXO9n1xuUPwHYl+nYfLq4RWyZYdsnWa
         ctna0pIQcYhMU9TdRKJaRUt/3lXcktHllVpNBq+M96BBMuucqOb6IZEK/QgnncS93V6G
         P/Gw==
X-Gm-Message-State: AOJu0YycJm2sSeuvM5AIhx2OLE//jT2ApmdwVMlIcWDni1QYQgatW4UN
	YGyOu0DTANfzIXnpzN+hjkC8nZFntcgG4qE7hVvfVlLkgthQGps9dqkX
X-Gm-Gg: ASbGncu7CNbjuboF/K3fMaXlPakzWJPcp4PJ+uiQbuTqa/zFah9HJOdpWK8+Tyfx0/R
	kzqK8ZRHv5BC5x0yPdgpFjbmo6WJQVToE4rVHrEUWOMOGwGF54L24xmxfhCA+MvZaeEm0eHj+S1
	eNyfD/OxGiExKEer1SAxNyvAAEVo4jpy/OEKi4glxqU5dvwcNst/49N1fzF20gixpmEVfxLov5Z
	giFEp1z7QEQuyW8z6PFcvIM9txiCbsdsCisgsm01kbeKJlWHR/EHrbUWfEtMfPxi1RA03fNSUPJ
	tuR1lnLzD/U6z22X99pMqAFP7CbFiPbGn49Y2pHlQ/F26LJfCZjlgrzYkwRQAXzggMeWEfAifzc
	WGnaNnkYSuQ==
X-Google-Smtp-Source: AGHT+IF3sEMqm1u3RjCkqLLEFAQiFfukDIezE5o+I5x0VhNAfnZxolVsCu9377E+qnP4u+NgzIbE4w==
X-Received: by 2002:a17:907:7ea8:b0:b04:8358:26fe with SMTP id a640c23a62f3a-b07c381c60emr1183618266b.34.1757933267915;
        Mon, 15 Sep 2025 03:47:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd3e4sm909084366b.54.2025.09.15.03.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:47 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:31 -0700
Subject: [PATCH net-next v3 6/8] net: ethtool: update set_rxfh_indir to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-6-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=leitao@debian.org;
 h=from:subject:message-id; bh=nh0Gd8fHJE8h5NCSVCO0qeGjEU/OiffbOrqPJ9TZRyc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7H5t5pVfBWI/WsQktPWHj+w9TIY2cCP/xJ1
 v9dDjk1sneJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bdEuD/4sdZ73DY7iMb3FA2D6mkUisOHLDfmqimfLeu9VagH7Y+FXlMDlCnJzrfNEPIN986+tlM2
 RhMNMb42bteZPswQTT6GXKrEmWvDWwC+hPb+WVGzeamfM3b0ZtuDuQeza3Ib3cRUY9IT9Zgiy1e
 +hZbo2ykw9TAQrkVElljZfAoQCF86vm+TqQMPON1O12ZAWSdfDM05FJbloxs5toseGV62jN6yBr
 FfvTBbkRyUErpdSmXRZWTwq1Kn1lcIJMmm3QuGgJF3+F8szNCTCf+nW0Uh569C+GkchfnsS561Y
 Wk45Lns93prhdbcZBYLz4e2GuXJ2dj6CScVz33nfL33/4/btCk6eORwke6RfREAPI+fYRVzTpgE
 mvZ/r+D6UXGM7se+kb9K5vbUCibfbnrIfZV3t8Ir8MRduf7TwPjdTJit6PKaE7RelIs7dIm/YdJ
 uAg533xKSS6lvwGh7CPD31HQDEFZyY6CgPPZIhGE0l+dmx5ThdgpaQWJ/PbPegRPjuF/isQe/Ut
 mYNpehytpUZ96evHPN3ABuMs2SoZQv4C8038C3N6ih/cquSNjGaG207JxnsUmNHjAch81MA/Cu/
 UFzAviIt2nYQQc81LKVPLm4lvFbmqHN0Ao4ZYXIYmZmQaxXIseJVNkx/o0xpxiATUOlP486+/a/
 nGlhI6oxl6rtGrg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 2fcb11e7505f4..30932555618b0 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1374,7 +1374,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1400,20 +1400,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	if (!rxfh_dev.indir)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out;
+	}
 
 	if (user_size == 0) {
 		u32 *indir = rxfh_dev.indir;
 
 		for (i = 0; i < rxfh_dev.indir_size; i++)
-			indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+			indir[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;

-- 
2.47.3


