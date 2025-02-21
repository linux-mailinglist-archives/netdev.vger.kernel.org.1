Return-Path: <netdev+bounces-168500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30161A3F2B4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723CB3B9C87
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE220896B;
	Fri, 21 Feb 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="S8RRs5R2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121542080F8
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136186; cv=none; b=u0f4eLcEe9kDLXz9oOMrPIwRPeEq5CeASJALhCy71KAWLqDzRv3YdlYewKIbEiMQtaAr8BJJgBel55rU9Ho8kAcmede8NiAHctuS5YwxyvKH084q043+UFWOJozsOGz+YR1jAMe5bUrDN1m/HTc/Q8x3DHnKzO02ODS4v1g9Mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136186; c=relaxed/simple;
	bh=C9EOMJrheqjmd7KXDpEY28vb0N0LeMWZ0i45997zY4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7MP3Z+lPd+23/DFyTSmIGoDjo8gXzxx/ndcG1vMOB8nZWACM+NquMjlnTrICOxNSKq/lYk0HMRFmpcnVmf8VMAO4pL0IrZ8rQ+xORFeUBSLIJxIrdLJnYbVswD1BBJnC/0VX2KYUVD1iSyRVfssFhFLL0RCNPHdNEGG+wwxB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=S8RRs5R2; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-5debb4aef2eso289158a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740136183; x=1740740983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4jNY+2C7dDYPNT5/Y8+BaTO6KPD0WXSQAUegz+06is=;
        b=S8RRs5R2B/5/4mKHt+c7wBX1g9RjPN3S2lUoY2GrhgvxoTfo8PW2d7cEizRN4Y2Z7L
         0/HpyVPMNIA9Ldp3jB86P9fBuzDjTOYfMWtFzNKFO1IzqX+ug8bIN0sTIsZFuhSBoJos
         H7MrZdo5RDJ/l62LYDKgd7DCMmnjRy2vidLDs+Js7ASI+rcgUxS93Z8RwRDWjesDhyYy
         WCiiDP8B1Qikd+axAtd5pHlZatMMc/bAk0GSCXH3gJRVxUdPS6pOdS7G7sE7ly3eGKnh
         o1MPRCJi6equ5gyFgguhhV3PhVISW+LJfVxGzgALxbqt2dg0vedWRP/OoddkBPFYOfqr
         IusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136183; x=1740740983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4jNY+2C7dDYPNT5/Y8+BaTO6KPD0WXSQAUegz+06is=;
        b=Hiyekux/xNXj5A86Q+aNtHVeNFMKVvuwGzkJCVjQ/8BOs4X3+FhWbL/87wThs1reOV
         s6w5VPH+gQjwgtJucEMshu8uEsNnk6bkHO15EwP87JG5oEKMVlwhgjf05C5wIVlKzz+P
         NcLD6dhNyeYFSWVl4ZJP6P1hqdXX/gF7FLDN2OZlHqeBeB78bgbZ8hLCe+KMVGjWoZDy
         sO8feCvxd7gYN0lOcNHAr1FU3PUakH7zX2BXDFmbqyDpK4/SqqAGMi+f1wTjYtS/kG4O
         Kqfh3GuFhTQ0W7TFLlZMPjyt4yLeM9+mG4bWFdVOKKBff3DXLGmfsGFi5O1xe7iA1UU6
         0ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWx9J6de2dNVN0kAx+iVm42WgH8OsozUltWLoeW/Zxvi5Swb8PcjviX9mS+DwAocS9sx8c7DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nCFG/EHSoRFmr4SyzgufqV4oH23FPIygs+Sp4VsX21lnczxp
	AWn3qXypvG5FwWefs9fpL5rKWh5MKoRpmyNTiO6wQA++zdGSVzVJCXf+Txec+5hbWEEg3l6Qm5G
	KhnLXYXfISbeJZG14exzqTDkC4ysjFvio
X-Gm-Gg: ASbGnct54tE+oo0i7kQc5cbTRvSBbLAGjTGqUg/VnxMbQPrL/RO142wY2HDLi6HgV32
	7iAwMPDaYAGN0vEmjQpcy6U2HjG/idRGza8CbDp0hU0DdkeXKcD+PCiBdkDorU8CDWoKWg6PHo1
	JQnaDATg4brfNVSsFq1f+qYQvboP73IVbaV0TrM1RE3NoRdeqx+Z9yL96RkjCUy8t0tlKS9uvrz
	9mrTVZFux68tcVrXt5sJnofU2h9AB/fVmV2TeKmLzvF1WSIFQOryXTUSNClCWt1MRMc4UHPKUyF
	j49bR9rjrKUo2iW/kEo6SQjuAIRZ4Ef6baPGZ1Q9BIgWYqSDi7NUJqsKTuOwl+7p+2Dwaog=
X-Google-Smtp-Source: AGHT+IGim6OS1yGIyQ5zBSguuzekLdV2UPrVzVdzgfBgV4f2Ibx748ToVcUSR8VO2VV5ICghwlS11COcR1pW
X-Received: by 2002:a17:907:7f28:b0:abb:eec3:3937 with SMTP id a640c23a62f3a-abc09c0a42bmr87599066b.10.1740136183071;
        Fri, 21 Feb 2025 03:09:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-abb8d3d2502sm85282566b.24.2025.02.21.03.09.42;
        Fri, 21 Feb 2025 03:09:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D397C13DC0;
	Fri, 21 Feb 2025 12:09:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlQuc-008ZCo-I4; Fri, 21 Feb 2025 12:09:42 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v2 1/2] skbuff: kill skb_flow_get_ports()
Date: Fri, 21 Feb 2025 12:07:28 +0100
Message-ID: <20250221110941.2041629-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
References: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a815bde56b15 ("net, bonding: Refactor bond_xmit_hash for use
with xdp_buff"), this function is not used anymore.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/linux/skbuff.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..f403d43064a5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1530,12 +1530,6 @@ u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
 			    const void *data, int hlen_proto);
 
-static inline __be32 skb_flow_get_ports(const struct sk_buff *skb,
-					int thoff, u8 ip_proto)
-{
-	return __skb_flow_get_ports(skb, thoff, ip_proto, NULL, 0);
-}
-
 void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 			     const struct flow_dissector_key *key,
 			     unsigned int key_count);
-- 
2.47.1


