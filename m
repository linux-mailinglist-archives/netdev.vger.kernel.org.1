Return-Path: <netdev+bounces-115733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70909947A18
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3504B281F68
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0D154BFC;
	Mon,  5 Aug 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T/TOuaux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDB1311AC
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855435; cv=none; b=O12DIqYNuQSY0oKgfGhfdaYMf/LZzucntlMriZMBw3i35lOvxzGFKsNp3kDFZi+TXnHHfE/4eLf3p7++Z/6rjsqxK3cHhUTYOzY38Wc8UUh1yooDQ0JIEeuyOtkPiXctcVDuRGThOrYyRKR9yIZ7uCA51nXbZPr6pFgv9vVlC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855435; c=relaxed/simple;
	bh=c0Z0S1anIl0K69+F6MOi89jUgaugq+mo8EhGncANIoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cands0B9XIepFtAS3WwoFhETk8H3yv6ClGE3wYFDOPLFu9kOfowzvXEdUS1hmab5G4R5lVCOIEStrU1vUIjgCOhaEf1Hh+yseU3SEFGTu74ewm/xTGupXsP0lV5w9R+NXOWrlKFfw70moKVvADywU6a+D7cYF5Ho2sBIv29XlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T/TOuaux; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d0dc869bso669354185a.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722855432; x=1723460232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BMdfpqrY5tm8/jK+EFC7SH1Yd5hnsxPDDCueoCM2z4=;
        b=T/TOuauxMt7zaGZEWJ5TKs2MaTj5DlkkrSWcJYVXO8L7WlGBJepx4iV9LPvQA/r7DR
         jgfp8zqgkD1CjvKVeya9g4/nq7kPdkHf9VSSiPtd41uQtgpf5KxccfFB/xk2uIcvEkjs
         2xdRfQuSRmnrSbgEdTkmjUnksSLzghmbvCDvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855432; x=1723460232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BMdfpqrY5tm8/jK+EFC7SH1Yd5hnsxPDDCueoCM2z4=;
        b=Z4Kmziggn8vycdJMIa8JJarJtrieDzc/fMYViRdXRxHg8hOjS2bWRjyVFnWNkx0Odj
         95BP8BPbdiSHlGCBJRO2MY8LzeZGa+877EGteeg/TcEZ0sU71IO0UQht5aqRA67B6dW7
         MbxZTKc7TfFPxtG2RcdgEO3akaUr2dK/FNCyvD3amyNwqhaLe3ceR1umZIl8VQwQT8MB
         7AtY4QWysT7P0FMCBG46G/eu56l0IjpZp4lcivns0sqQL9f9s3dkOmxT4aA6dOfTinPM
         zs3cAD1YJRHA7MkWVimPjl4ibbgnBeeBVMLNfFOV1MimuAymsE1KGO1eLYkm/Uw08SaI
         tpug==
X-Gm-Message-State: AOJu0Yy+7OPO0fWzXnGwKv4eqCv20bM1Rnr15I4+fEDlRipbIZ/0nznj
	G95VtQgse5CSSZwDwf41tE7O0ZHUaHfR+IbTC+X+D7sis6aVSZ3eH2tHDEgrICq6lrt1+2qXMIz
	qnGKb61Kjk1XuxsgLu9QBZnT7HtDvO534ZMBkmN1R3eCKaljEri8L/4bFoomsPkrpV4kTQ1J4Jp
	xuncD6+MWNLt0JHyZwEaAVTM8Ad5RlapVZvWnlebD9ASlkqbGb
X-Google-Smtp-Source: AGHT+IHV0rtcwfrolMcb0zSRySPcPqnrpeSzkUB5JDGw9DzWli+CgxKTr0pg8RUZdXtB98LPsNQzLQ==
X-Received: by 2002:a05:620a:4311:b0:79e:ff18:b4f1 with SMTP id af79cd13be357-7a34efd836dmr1512439185a.51.1722855431813;
        Mon, 05 Aug 2024 03:57:11 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb785sm332890785a.56.2024.08.05.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:57:11 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] skb: export skb_vlan_flush
Date: Mon,  5 Aug 2024 13:56:47 +0300
Message-ID: <20240805105649.1944132-4-boris.sukholitko@broadcom.com>
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

Make skb_vlan_flush callable by other customers of skbuff.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 include/linux/skbuff.h | 1 +
 net/core/skbuff.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..5a9f06691c80 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4054,6 +4054,7 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len);
 int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device *dev);
 int __skb_vlan_pop(struct sk_buff *skb, u16 *vlan_tci);
 int skb_vlan_pop(struct sk_buff *skb);
+int skb_vlan_flush(struct sk_buff *skb);
 int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci);
 int skb_eth_pop(struct sk_buff *skb);
 int skb_eth_push(struct sk_buff *skb, const unsigned char *dst,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1bd817c8ddc8..e28b2c8b717d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6220,7 +6220,7 @@ int skb_vlan_pop(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(skb_vlan_pop);
 
-static int skb_vlan_flush(struct sk_buff *skb)
+int skb_vlan_flush(struct sk_buff *skb)
 {
 	int offset = skb->data - skb_mac_header(skb);
 	int err;
@@ -6241,6 +6241,7 @@ static int skb_vlan_flush(struct sk_buff *skb)
 	skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 	return 0;
 }
+EXPORT_SYMBOL(skb_vlan_flush);
 
 /* Push a vlan tag either into hwaccel or into payload (if hwaccel tag present).
  * Expects skb->data at mac header.
-- 
2.42.0


