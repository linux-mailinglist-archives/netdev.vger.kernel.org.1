Return-Path: <netdev+bounces-237053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF4CC43F2F
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 14:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B6834E1D3C
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D32E172D;
	Sun,  9 Nov 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpULyxSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159F2FB99D
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696016; cv=none; b=izgDfbf6txCCXCyM4dM8WyNOZu1vnx0lWCGcc3vR4k4mxUpwkU4UTijXgSNujkZDg77HpIo/mDRM/daqJ5NCYdQKnBckAbKA7mqm/3c3TyaYXZTjDZwbvLxuzmd6LApV5yNV0ZlConYg9R845wiScUzK+E7e49JTMvwwSPDpzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696016; c=relaxed/simple;
	bh=78sRp5/pEa3exZ9nnd39D16LidtkS04WArCUHi6XxZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFaUdiIhrcYq3/wnpmT1FRiyrsfoExgEhKpZaou7G2BXUEjekyfO5xZqeK25s8M+DcLCxexSJ1j0mtRbS4bkRPf+Gud5FnfVkrRz0WuTbEzAux0k1vEgZHrkcumFcuBx0E5+MRlOIPYpYJYgGXKTtfY+CLC0xY5kk88Jeno0ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpULyxSj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d402422c2so443977966b.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762696013; x=1763300813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOxOVz3OD8A8kOJ9jS3tsAyXqepvPRy5WhOjggMQTeU=;
        b=jpULyxSjrasurBovd3jqp64akl/RwadL36n1rGmyvjqM6Bd/80RLfhQGNxUOd/6RM8
         N/G8QxBCZHdYJIEULKpKXq1cra0PTbIXv/idbLh49wMaNAnjBETXPb6FnuFC6qKMxcGz
         5M0dYD7FKcE6ITAruC7kz7fO0+Hiv+5EssyBCVOr8RQSTNVvhZA31BF2oKW2A2dZxHJp
         BvbYE3nUyb5/wCEk1g9aTZKdKb/yUWCan9xehxVqepEWkVQPZ8R7WrRUfVdnCF5/uq3T
         VCqBEojf5Op2vMbZiKp3CA98O5BbIj/u9dHDqTcVAsW+4J0SF59+VyZQn8PevRKtr27t
         BsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762696013; x=1763300813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOxOVz3OD8A8kOJ9jS3tsAyXqepvPRy5WhOjggMQTeU=;
        b=Yl+DlMaaJLmFnsjEcPjzr0XLWQcpIYB2CI0ru2h47OAVD6Z9trk86p4TVYzHX8hL0+
         OIWVWW0DnBVAAI8Fq7dSwnVq3OzHWOjQsvWsODonmQVRtlPxmwEg9VQGOnBNEfsW0FUy
         85/P7RkxH263QXebhviOshpMkk8lVUSrb954+3nJPAry063rlzy2DB87VU4E09gDdqLu
         H/KRoTMnHezjjKoShIuvtn6aP3AeTNwycdVIviSMikFPIy7dKsD5YasHA0UjWUv5Aq3/
         D4iNuRjsCSrxk8i5ujbZNilqCh+BIW5b/DgGokts8gf5e8z8MbMmBYXTmRU4nnWTOD9Y
         GKCg==
X-Forwarded-Encrypted: i=1; AJvYcCVSJQGZErLVvcvYaGY7k8lqDC4SygN3ELEZPQkKMJI4tRipc2oZCGUfjVsFaVal8aSjMOUO3jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPawDsTLKHucCjBeIMBVMp+p/9YFCZb2idQP4922LRnuhti9G
	cxq6o0kKGAMMrL+NM4x8FvejU2sI9c7O1qJbbdKcxmsDNnKZT1PiQJVU
X-Gm-Gg: ASbGnctlmjzH5Q8vd7hDCZD4PYRzJNXVuuydpQEiMBV1ysWH52mebjqUAGgh6Dcpvlz
	+RaWGZ5Nc7P3EBSPXH7kkrP+xCcl2RV3Bb41MqtXzEkuxK7z8IrANAWyjJJTH7VUQWkOWVZcc/6
	TBVzR0DpsgdlGBJfhsBcTPmgJjE+L54ZAPZvhr6EHgaVqTpQHilOsNfifWK24JCx6wX7QvcwzCv
	Q+685sTdhRrE1+w4xgFmaivZprCkRanVyZZrI9xLHCjNCt1W1SRid3/3nSfljBiIMIiqlrhZj9K
	59YfiZbfA9hF75f0P5HlmhAfxtwZ961butFzBth/eZwRWToKkaFZwGV50ICYc/HU0b5nf33QvLO
	kwUA1CXdsBDFIKK26lE416ppNiGa/5Cn0S/38tJke/BVPtSP+sprnp0t2TuRjmDPVytkQlLU3go
	1yji0k+5YSMYghp+Bqmxw+G1n07iIGUMU0s3m+BFo2plY1f/7jNHMFfUO1
X-Google-Smtp-Source: AGHT+IG2hV7b23VcX9jieNe0izeHc+iQCgBkne69iwz7GrZJIKFtnUWh9WFnd5ZT0ZMVj1EktFc7Rg==
X-Received: by 2002:a17:906:f5a2:b0:b72:6f76:cf73 with SMTP id a640c23a62f3a-b72e03037c4mr554584666b.21.1762696013043;
        Sun, 09 Nov 2025 05:46:53 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d14sm804313566b.74.2025.11.09.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 05:46:52 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_brcm: do not mark link local traffic as offloaded
Date: Sun,  9 Nov 2025 14:46:35 +0100
Message-ID: <20251109134635.243951-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom switches locally terminate link local traffic and do not
forward it, so we should not mark it as offloaded.

In some situations we still want/need to flood this traffic, e.g. if STP
is disabled, or it is explicitly enabled via the group_fwd_mask. But if
the skb is marked as offloaded, the kernel will assume this was already
done in hardware, and the packets never reach other bridge ports.

So ensure that link local traffic is never marked as offloaded, so that
the kernel can forward/flood these packets in software if needed.

Since the local termination in not configurable, check the destination
MAC, and never mark packets as offloaded if it is a link local ether
address.

While modern switches set the tag reason code to BRCM_EG_RC_PROT_TERM
for trapped link local traffic, they also set it for link local traffic
that is flooded (01:80:c2:00:00:10 to 01:80:c2:00:00:2f), so we cannot
use it and need to look at the destination address for them as well.

Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
Fixes: 0e62f543bed0 ("net: dsa: Fix duplicate frames flooded by learning")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
I shortly considered changing dsa_default_offload_fwd_mark(), but
decided against it because other switches may have a working trap bit,
and would then do a needless destination mac check.

I used likely() because br_input.c uses
unlikely(is_link_local_ether_addr()), and that seemed reasonable.

 net/dsa/tag_brcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index d9c77fa553b5..eadb358179ce 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -176,7 +176,8 @@ static struct sk_buff *brcm_tag_rcv_ll(struct sk_buff *skb,
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, BRCM_TAG_LEN);
 
-	dsa_default_offload_fwd_mark(skb);
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
 
 	return skb;
 }
@@ -250,7 +251,8 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, len);
 
-	dsa_default_offload_fwd_mark(skb);
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
 
 	dsa_strip_etype_header(skb, len);
 

base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.43.0


