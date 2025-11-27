Return-Path: <netdev+bounces-242205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E359EC8D769
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5217A4E4422
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7327322A15;
	Thu, 27 Nov 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce67zZnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F14326932
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234870; cv=none; b=flVa2lIA7Sx3LnR2QJzAJkwi4fxA/mdpBemCE/JJew/UZuQTJ2l+j+UQHoS88nRpP6ammTSMtqsoS2DKbWo5yY+tgtfQzPI5QuKiWJGX2BpmZfPUt2WMwDKFB5M3vj/dAiddv+qHIyOUuMUOfIvC3FVEtxKbCdK0PW6nHt20UDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234870; c=relaxed/simple;
	bh=YJ3HSPEfCllHqCbKsegVc8sZFGTwOhhIMizrfcYMZ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6Iw686aChi6sCgDcjJWVEC+WGuFw/elIJ0jshzWhme/YRNSfJZqeIZESOVHtPtJWPNRPDHM8p8KYGGjDuazRxFUf7xuuaQ2idRrqUOvL2zZ2z7RWgMAmGh4m0tnCvQ0PpS9Zm4u6d98xKt1nPTGOUTKWVgc4+jK8dMExWbILCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce67zZnn; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-63f9fa715c6so92814d50.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764234868; x=1764839668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v775N6ojKXT88X+eue5E1XCrefNoMr6EO0iuTdtwud8=;
        b=ce67zZnn3dvDDKGo2oibbvMB1tHAcw1jvRVK5hpzFJ8Oi+Z69AER4zIFuwY1n1Omvu
         Ak2ZNgi1dOHwX9Ni23Gr7Xm/Vj8YxQQAbAl5ZhrCWwfEb5/fR3+gLmQyPTK0zezh3STd
         unRiuqiIVyFVu5NDvqCKA9Y3evJKSVt7SSNsaGGIOZERR+S5q3txw51qmR9KY8KoYNau
         8nMluPpAdkggLI3DECkiNldHzzkeoKONvjlbssq68DAbU+jirh3oxmWVGLCt+IFmeWo0
         ylJiJxyNofDPVOfKK+o/Lu3pyHGnX+qaERkwxViz5+xDG7XOogSM5sVCIZ3e5qB1qQ08
         PG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234868; x=1764839668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v775N6ojKXT88X+eue5E1XCrefNoMr6EO0iuTdtwud8=;
        b=AnKvKJDzz16y3dByp6XZbvTfPMinyGER3zSGGeR82WS9gZHnwtu6I36yqxySFlMkSb
         6MAQwSdzVUQ4vufj/vERjog2nTAuxnxVTtGoFgcj9WIKk0GV3nLnjTR0NNkYEqfHhfBm
         IP36+Mu46h/QB079ioSdoHJ5a62xWOF5amN4Py+lcCEgnN1B0SoOWQxf5BQYCvDj+2aG
         DDRW3+D6eLs9OITAHsfudPg7uXmg/0OB3xvKLyqir7Bj0WiXRg9KefIVoqzSyocYgwKi
         6y3GxM6Q97xcgE7y/aXNJwYRmJH7xGjCdesaJkBBlROURmJXMgBvkCqkRxmZdw9j7wAj
         X9GQ==
X-Gm-Message-State: AOJu0YzzFHpk1LutAKlrzGLw8/57m8eQs7FIlIfcNWSmEpxsLPuCUG2/
	quDx8T+8EJKR3FMIhLYuxqML6rbCvBednF0ljyIg9iZXIeJ3MAfNZHPG8lk7CcMt
X-Gm-Gg: ASbGncva3zAp8IMbIUarXnXxiqdVC/dwxjoVsqodVjdmvQsVAjYP77P70uzKCZOEdbQ
	7XGh60wnCyNyKp/1ovgW07mx9w7v8JoUqGv6r/i/V6AVSF6EgsTyyc9OiJZTZXDprMcfsFpTgWW
	MOTPe6ZkZa6PUxehby3e2eZvw+ttXte+UFCBJr/rUCgiAfhfUuoI9fQJYzJbbodlNm4JYL+5G3U
	lgj9lh8jKrT6BOz8SrPd4oELL3Li697eVdxQcmuN2VOYMIppxDm7O/c7816jsX8xe3PLapWAytx
	0dyAGKOrHMPtiRHX7NRd/igh+ZGvvwBDnqB4oxRRq6lMkINclfQIQqmnj0Oi1r8C5KboZ8bzF40
	GfaLMV/fT4C2r+C7mAzDbQGcLcUmvMgZ+jMmpBaJUre/WwQYA7MzqhIYv5IEd+d/Z3e4wqcOUPr
	MLpRbyJrrd
X-Google-Smtp-Source: AGHT+IFIykiof0FLUnOuxSu3WH5w7CE+tai/YzhpCAzoYOvXxHKK0tSMxmB1IRj6/hbSmzM81SBJwg==
X-Received: by 2002:a05:690e:1283:b0:63e:3211:9392 with SMTP id 956f58d0204a3-643052d017dmr12016956d50.5.1764234868101;
        Thu, 27 Nov 2025 01:14:28 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5bbsm3796167b3.7.2025.11.27.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:14:27 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 1/3] net: gso: do not include jumbogram HBH header in seglen calculation
Date: Thu, 27 Nov 2025 10:13:23 +0100
Message-ID: <20251127091325.7248-2-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127091325.7248-1-maklimek97@gmail.com>
References: <20251127091325.7248-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue in skb_gso_network_seglen where the calculated
segment length includes the HBH headers of BIG TCP jumbograms despite these
headers being removed before segmentation. These headers are added by GRO
or by ip6_xmit for BIG TCP packets and are later removed by GSO. This bug
causes MTU validation of BIG TCP jumbograms to fail.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 net/core/gso.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4d..251a49181031 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -180,6 +180,10 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
 	unsigned int hdr_len = skb_transport_header(skb) -
 			       skb_network_header(skb);
 
+	/* Jumbogram HBH header is removed upon segmentation. */
+	if (skb->protocol == htons(ETH_P_IPV6) && skb->len > IPV6_MAXPLEN)
+		hdr_len -= sizeof(struct hop_jumbo_hdr);
+
 	return hdr_len + skb_gso_transport_seglen(skb);
 }
 
-- 
2.47.3


