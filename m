Return-Path: <netdev+bounces-118465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E0951B5D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E938C1C21385
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B041B0128;
	Wed, 14 Aug 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QzbIXfDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3C1109
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640806; cv=none; b=u+UDo2ZCCw45WXWyB/Gn+zERGt0iJ1bJgVqcLbTa8ZFGV2z1Fo2BkMcglJitnyGzFIcLG8YJWqaOdCCVi4zpEd3S7RakkTGJXjNFYo6D+94/8i5LuyCF1V/Do08/nGIQYTfOdniQOrDgl9L5C2J5HOcmzUVrTSfSEASCzA0aIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640806; c=relaxed/simple;
	bh=YuT7tgOIJJfuO/twk1piOsn+GOR2DJ2NNNUzwgW9wPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmSXFcLoDMRpMNuf2hr7HRJfsCuj3fl4rw8q6kttDDhhUfyi9GBOh9UZm6Y2bk/Z9fd9yIBF+3rJg1JkjA/Zo1XA9ljTDjRwUbbkl8nds3JyPReEaE2IOM3wY/P/Oo8AcHfub5yD3wAl8gJKxupWkarfh8ZoAJBzkOnOVVLxZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QzbIXfDt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so4688462b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640804; x=1724245604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbTOvAUXILro3y1EmGJyFXmNSNhQtv1tC+lWw1ig7R0=;
        b=QzbIXfDtmZ8SOLRCNX4afhAb5SX6q5Cifkmuu579vZqNOkHp/2wqtkZf6njdZ/NTIz
         OILccKz8edDwIKI+2HOxSUlCh+tVthZMfEk3JWJ4zh3J1/IU1xSc2gebOak4VA8Hp3Qo
         maAtscwis+/C28M+QOGqzgVmT+nYw8WGhFwwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640804; x=1724245604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbTOvAUXILro3y1EmGJyFXmNSNhQtv1tC+lWw1ig7R0=;
        b=THS/HR/Nx5shflbvQUY74H4JsGr/eG9gVPvPDiiRbNxG0B+MvtHd3aSiFc3Jp3QN9y
         MlgHvTp3BUtRIBgLnIus9g4LNfzUDzIxOD81RJcPvC+Q/444gcUubPdAiQRfLxYeW5Dn
         GLC1+QrTf3OuJU1V1+KLXk2qJdsI+B/cABtKKyCZspTMdoyKIXHoMqVEw+eI+gMNvaAQ
         k3Ivr+0BoFdAGNUPdn3LsUfbhHYSle7EfWtnO/D5NOv/AXh7u8camLxScoTk9lqPuYe2
         +/s+TukfhU/rhCnLhB6avJak39xka1Tf8ZUlUWTTeBGkskgOCWj9cuvtKcaw2OW8wAN4
         9PTg==
X-Gm-Message-State: AOJu0Yx0tASExvof0Jgd2rGDnkoxAFVbaFqnekqBEbuGQG/8rnxl/eEg
	ho9paVTTjza9E7ghPA7WWPjpXsKLv6WLh68bXU42pLqU+qNXfuiRyuWqgX7uOCXinTvCEb8xKJT
	1AygWONJXAmOUH9WGdWwAkbEJHnqXSVV8k+RSFEu7w5dHCDgAPaKPaDTFN/ZflbgrRNmSosUPKw
	XApKuRvxz6gSZFxiwEiaFcd0UsbEtfQaqsXrR4PaE3PVdQBSFz
X-Google-Smtp-Source: AGHT+IFl9foKY9Yinyk+5LmC8WJCLj1BfV1CYr0rIE6L83nn5qKDxB0bDZtB9fzKNn0fqUMJEh2s2g==
X-Received: by 2002:a05:6a20:c78e:b0:1c6:fc56:744 with SMTP id adf61e73a8af0-1c8eae97a21mr3241638637.31.1723640803518;
        Wed, 14 Aug 2024 06:06:43 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:06:43 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/6] skb: move mac_len adjustment out of skb_vlan_flush
Date: Wed, 14 Aug 2024 16:06:14 +0300
Message-ID: <20240814130618.2885431-3-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
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


