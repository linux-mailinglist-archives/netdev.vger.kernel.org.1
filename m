Return-Path: <netdev+bounces-91745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC68B3B64
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE6A282E45
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29811494B8;
	Fri, 26 Apr 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKVkkb3r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81114AD26
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145248; cv=none; b=JFsoP5dFxxfGUMGQOOaH2pKN1Rz3sL3NggTWjq7Cm64sBU0hoXHOFEbtCwB2kbaDjn8u5bui7T2hQsHGOm7u081z/3kZ1W1EYyxi0Bquh6LCZOGMY4jHwVy3FUH3IQqW/8DwbTN42um0+np7joQ5W+fjT5K+eRhrzMw1LVnuFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145248; c=relaxed/simple;
	bh=JXaodUegtNTXGX4YvGAE7HGXQGEsi540gOcETWahphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txaq0TyjIIS8RUXPllYaqAdoM2lqvV79xfQn2c8550RvbYVUddUEbL0BpFIFbBHfScwSP7CSK4KOUK+E5Xf93MJPIV1r5jpsRKutEpinRgENjEcVC1w/nko4RsUpWy7O2HBdDyU8m2k9JE30q5nDs60QjxEJxrYny6b1kYxIG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKVkkb3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714145246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K3AYiuohrijx/ETTvR/seefnGOT1X10ejEbRZKf6zaM=;
	b=cKVkkb3rlRuVIoN5gQs1gxynWLNtLb8TMALsUiO592zDBF6jvKAFr9HX5ZPhnZPRNchSdN
	PoY31OWaynNVra52MjAxSHRWSkRK5Pq6fNDYuyOjQQplTEDDtKWTxa9QyxSAN6owR/1sNh
	+ZTZ+2dEe/mSVSuCCYDohdN0jIBhtcA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-AQhYEwU0MsS6bsNWy0x84g-1; Fri, 26 Apr 2024 11:27:24 -0400
X-MC-Unique: AQhYEwU0MsS6bsNWy0x84g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-439de748c5eso31693801cf.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145244; x=1714750044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3AYiuohrijx/ETTvR/seefnGOT1X10ejEbRZKf6zaM=;
        b=Upm69Yr0ME7vjpUBjqV/6HQZuTOnWgY3WBu1Xa3tGdP09I8uLDuZqfhAsP9/pYAwWE
         Z27mkqxLMXYWRUeguQrURdYvDvB5/mk86UMMAbltd9wHXJwPtNq2NAtFZIIXMvpyC7nN
         bbM3+hJATy58mUGhmOygwhjQyYZ/X2tA0KwCXmV6xG7fwpAcBEirqapmsqgC9HnPnHNl
         kE1vGBaTOYVUjMOv422VwZxKXB6BGEqz+1WXi0Q7mjgzAqlmmskxdbyNQQ+7YYSLjOsu
         HX5bDZZCgVREPsnqjeP0vb3XznHS4E99ogtgrBh/da+crPq7xzd/trsJl5UdyNWkX/iR
         Z/OQ==
X-Gm-Message-State: AOJu0Ywo7HsmQNxWjwmptBRi10rLIaT1yflRAllykQ+XcXUmO8KmNKZO
	8UC5rDpwY296qpf1/YAhm/omb/OZ84ybRGFbN6YmRs2TkiIZmWk0Z/w3Bvner4L5HFSwH1XQjw6
	y02nas3kpnBkQCqLlvBtL3X0zwfFilo2Qw6Hxo7fLGm9MRn8LVOk+QQ==
X-Received: by 2002:a05:622a:14c6:b0:43a:6d1f:19fb with SMTP id u6-20020a05622a14c600b0043a6d1f19fbmr2648651qtx.37.1714145244298;
        Fri, 26 Apr 2024 08:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6yxNPS3OpQ58X2dVmTyxkpMpUCDgUjjHdxVv1RyymWoqE5KGDokPUw0AmAAYn+XWzJojbQw==
X-Received: by 2002:a05:622a:14c6:b0:43a:6d1f:19fb with SMTP id u6-20020a05622a14c600b0043a6d1f19fbmr2648635qtx.37.1714145244031;
        Fri, 26 Apr 2024 08:27:24 -0700 (PDT)
Received: from debian (2a01cb058918ce00d9135204d7b88de9.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:d913:5204:d7b8:8de9])
        by smtp.gmail.com with ESMTPSA id f16-20020ac80690000000b00434347cda1bsm8007226qth.42.2024.04.26.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:27:23 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:27:19 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	stephen hemminger <shemminger@vyatta.com>
Subject: [PATCH net 2/2] vxlan: Add missing VNI filter counter update in
 arp_reduce().
Message-ID: <fdba6a77fb820c04c0a67f7c0c56c957ce9fa4e5.1714144439.git.gnault@redhat.com>
References: <cover.1714144439.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714144439.git.gnault@redhat.com>

VXLAN stores per-VNI statistics using vxlan_vnifilter_count().
These statistics were not updated when arp_reduce() failed its
pskb_may_pull() call.

Use vxlan_vnifilter_count() to update the VNI counter when that
happens.

Fixes: 4095e0e1328a ("drivers: vxlan: vnifilter: per vni stats")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0cd9e44c7be8..c9e4e03ad214 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1838,6 +1838,8 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
 		dev_core_stats_tx_dropped_inc(dev);
+		vxlan_vnifilter_count(vxlan, vni, NULL,
+				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
 	}
 	parp = arp_hdr(skb);
-- 
2.39.2


