Return-Path: <netdev+bounces-139031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F29AFDC9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804E61F23C00
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D881D9A6D;
	Fri, 25 Oct 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PryeeHZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7A1D63D9
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847704; cv=none; b=EnuGXstER556I0+WzJ9Vwl1lKqDER+SjqjnUpYUFEJMGjuhIGVTAFcFnlx1Kukui1VhqiD1CpBa+ItyIGlGVnG61fPvTsnPyFwHBA1nxeIc9Grzs4HLONmel7jPY/RuqN8jBznNx8lSIE+H4vr2wZnZYYNwf2xwp3vz5phAIJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847704; c=relaxed/simple;
	bh=fdzF3OOmoZvBMLXtUajHYKsI45JNjgatz8aXU4UpXD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+ptKW+EaNj4fFcmQypTUzz4jcH9GDdPtlay2vDnpOCte0VBva8lvJCeHKxXgYTdW6OM3HcA4NEaMroiomQI3tPcTVi7EhYDaKLGjhjDoKGIC93OqdP2GXDAfIHpdvHaGUIqwCiJx0UtiScXr67Nz8GDzD40jYLV9JHFyAkBsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PryeeHZj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so18025345e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847700; x=1730452500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbrFnZJaX61MB7xNUng7QgrtBfqDJUowzpqh7fH2eTs=;
        b=PryeeHZjARo1zzZzE0cIV/eOO4z+N+SkHf2RzPwtVYkzR+rgo9i4b3cJplRHVBeSz9
         oic3EL6op8cD47cRKZveFCIiBDEMurdV92gw6Hpa0HUjFO7z0fysb5FRkylbxhnmbvlJ
         53TcokLO6WqHa62ATniyBhhXWqkn73UYNOV/OVhp1CepBw3FfauCt1XYGEN9R+mX/yle
         lCz/PN+VuYjrySUHIGoxHNHHiu9Pp5uDilRyIkALgSIvjiMMm8DawwMas5qLOBqhfcmy
         YMIo+zVFvfSxoGd7j/MMkJstcLzRnydzS9y4MRn8H0SlJu6t/k1MtMFbov5R6L43hhKF
         sF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847700; x=1730452500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbrFnZJaX61MB7xNUng7QgrtBfqDJUowzpqh7fH2eTs=;
        b=olh9RH62CKwh4gZIYZHWXkMSAS9x13ZA6dnz41lHShT4eWR81/zQQG8j8ez70IaA1R
         pmKFbq4W6Znxk9qbscjhRWrIh7+xGCGIhn/HOufsNO1fNtLMRcAd/cEDmQ6BJ0nl1w6G
         C+KqFImTbVkT+xh4NGR7vl8gETZ5TQTqpptpuE6aCvd7vEz+KfvnIA+Tn9Q+gNUCx0Ej
         K0KGVfcmwxak8xBo5VoFam8xBVryI3aTzQj3X1Ji6mgrVu18ruY0Vluuf2RvpevwpX0H
         +Dg/CRTAZfPCE+EGaxOXiAah93963asFo9OTfa7awdAHP7amSgTC5hri9PcXaaiuEei2
         iDDg==
X-Gm-Message-State: AOJu0Yzt7LS/0D+3w60LtHwh9vZFhBlOplcq6UPNHorUVPnInCjdgiYU
	AgSGOouNPbUeNnLLIG6HWlI/yrozrQx25v6vEE32z6zFAEgLS+v7pMlUazLCaoY=
X-Google-Smtp-Source: AGHT+IF7iRjGzbTkwLS+wWKRiDfwudZehSA8NWXCM0eS0vWfbGZLW6rPJWKkfy7/AMB31vjamzXlMQ==
X-Received: by 2002:a05:600c:5011:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-4318c6e0175mr38442505e9.6.1729847699945;
        Fri, 25 Oct 2024 02:14:59 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:14:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:04 +0200
Subject: [PATCH net-next v10 05/23] ovpn: keep carrier always on
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-5-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=fdzF3OOmoZvBMLXtUajHYKsI45JNjgatz8aXU4UpXD0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GZzowMlND/g4SIAAeWnGmnetZeAFaBmNGYD
 2PoZnRYeg+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmQAKCRALcOU6oDjV
 hwzNB/407LPWMAIY7VWXuQvLw6PFyAdwre7KBR601n+z36it8kHgjPcywxpSofG5BpAzXg//4xV
 Qf8+lJR/3t8BeNsFmjsOR5h1vJFOkycEkyG2OBCK+hYytZSmrhLbV5KuiyAkbDveTmD936gm4c9
 SJDbJkze3qFL0Btvow29UOe8X7uysFAHpSW+6nys+z/+IQ7eM5VGeML2sIBZ8g7N8nMzwjuZtDn
 I5f681oHgjxSftlrnvAPo/Tov7SnGCYcyaJDPPzENyT/vOZIa4T6BkL15OQAcfOmBd4FkGJvVFN
 lM76mahhvDSI4xzdtXGxRPlZGbgMEGrndU4jYkLwf+biIeUN
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface will keep carrier always on and let the user
decide when an interface should be considered disconnected.

This way, even if an ovpn interface is not connected to any peer,
it can still retain all IPs and routes and thus prevent any data
leak.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	/* ovpn keeps the carrier always on to avoid losing IP or route
+	 * configuration upon disconnection. This way it can prevent leaks
+	 * of traffic outside of the VPN tunnel.
+	 * The user may override this behaviour by tearing down the interface
+	 * manually.
+	 */
+	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


