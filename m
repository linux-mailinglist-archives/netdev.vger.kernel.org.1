Return-Path: <netdev+bounces-115732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A00947A17
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C95281D06
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208B1547C5;
	Mon,  5 Aug 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NWIznNum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4E1311AC
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855432; cv=none; b=BuwjiSLcv0WHawRdx3ruGgz9Wc6tEFPtQoB9AAsYJ8yVtJHjmlXZMhOOe4pEsKw8YTgqR0vKPgQ4TR9+KGDYKyVW27/4zNRelLfb0H9vmoW4FtqmctfdSdL3j/3+mZSqrPvIFyQfeQdZhA8YAit82y6ea9zBh1IBgYtW58cPA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855432; c=relaxed/simple;
	bh=YuT7tgOIJJfuO/twk1piOsn+GOR2DJ2NNNUzwgW9wPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0f6ppOrKlBGiWBtGEbpTEXTGYxvDiSKD756EVpTQ1GDjB9jVT3hHT1AuxGVgRlDLJ7THYyKPJd/csSaf0iPO69n+u67v/WNTlG2qO2z+EjtN4r3c9huKtdUb3BJ6r6wPhSAQOZSjcgqGgQ0zJi93VmdA2B9bRJzLWZxn4nDVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NWIznNum; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f6d01961a7so3491238e0c.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722855428; x=1723460228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbTOvAUXILro3y1EmGJyFXmNSNhQtv1tC+lWw1ig7R0=;
        b=NWIznNumvJ/FN0k7lyPSBKvldgvjrwuBWjKwMX0OXiPXbmdbY2Sjh8Wn8BYYWEOmkU
         xXALAnR7Kat4bSkRTkFiVBTihOT7fMgtRp5jVckxxLPAZAskt1kO26EA3W/a3KMuT3ID
         gl6dwh5gHQUuTk35oxWw+4A//rshBXm3VtpOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855428; x=1723460228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbTOvAUXILro3y1EmGJyFXmNSNhQtv1tC+lWw1ig7R0=;
        b=Sv33VvGrCJMb796++03GsPndu0Hzw1Yh5w86YISTVoC6Eiw0cUVQgqlCWgk+Vz4vwU
         DEyvTqcqpdk215pXWKzalT3r/qCRKpcwN8+yX/tpoC/GYs7nOOH+e3KVVr4plVUvbFG/
         EXrXSnLI1C/URbrt9icI7ey4SlDKuyDIDIzzFgTMEJsMs457lQQI8EScqOtmuJpGkPJl
         KYBf1bxKYmZrnaN3YCswVJMsfPMqWIHC1c1pMkQRFI72LXGOI3CTP7m66wm1rOCa+dQa
         fY7SN8qBN7l/THF0/Re3YyM8SNRnFqd7qTsf+Mr91aXUaXUQFNh3/DmK/QcVcXiZyxEM
         hCGQ==
X-Gm-Message-State: AOJu0YzHKjr1uNz7HVtNuvx4EJOyrsWDLh1ILSqy3h1+w+luvK+mXxuK
	B4B9SR2PwAsl/XjY4k18Yt1VogXxVJ+oXjd6X3HAibzAOKJjFnfPEFSGGBV6h2B606g1yiMFE1M
	H41pIDhGxJRmxOLX58aXhACA42Ed/FW8op5VDvpOscmpPfEcKaRoAe0A1mdDLz2dqI/fjqvZQq1
	ejJtqpnEgNm6Ed/6KmcPvX3fp89DlLgXzgjFors885QHTZJE3N
X-Google-Smtp-Source: AGHT+IHBMK6AWxi05cPzy6n9vw1rBA38IcnbKl7jLheUm2ytKSvwc37qLxM13MMD/tIsT3TKz+yyfw==
X-Received: by 2002:a05:6122:3c51:b0:4f2:e9eb:951e with SMTP id 71dfb90a1353d-4f8a000f41bmr11327752e0c.10.1722855428414;
        Mon, 05 Aug 2024 03:57:08 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb785sm332890785a.56.2024.08.05.03.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:57:08 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next 2/5] skb: move mac_len adjustment out of skb_vlan_flush
Date: Mon,  5 Aug 2024 13:56:46 +0300
Message-ID: <20240805105649.1944132-3-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let its callers worry about skb headers adjustment.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 23f0db1db048..1bd817c8ddc8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6237,7 +6237,6 @@ static int skb_vlan_flush(struct sk_buff *skb)
 		return err;
 
 	skb->protocol = skb->vlan_proto;
-	skb->mac_len += VLAN_HLEN;
 
 	skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 	return 0;
@@ -6252,6 +6251,8 @@ int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
 		int err = skb_vlan_flush(skb);
 		if (err)
 			return err;
+
+		skb->mac_len += VLAN_HLEN;
 	}
 	__vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
 	return 0;
-- 
2.42.0


