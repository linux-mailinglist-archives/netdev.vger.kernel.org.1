Return-Path: <netdev+bounces-140376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ADE9B640D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33E11C2033E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB61EABD4;
	Wed, 30 Oct 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKPblJBm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244F1EABDE
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294847; cv=none; b=piJzDu2UZPnuwlMFWNfeL8XqfmnrD7HggUMVPoktz2ns79N16y4C6mUG4XVVPu9PWkYnkxO1R77p4Z0w4F35qIxc8c6PExLFVI9NGlZ1yyxFd/uz71w7TbJUtkKKjwnTSveTCl2+vUfLHKmhUI6VYS7GF3xJVmJpsZQGkaQepH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294847; c=relaxed/simple;
	bh=FZoghOOfxgzV3kg8wUlFJdRRmoQ+6Tt4YmUr9UoViQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J2wKaHjUZJBgoV88qV9cC39goHCudrdxiI1Jqm489GL0D8gfyX7GvxPj4wQTBpbVWAE7faOtg4NjWCFh/N37q7EyfoIaE2crrtZxF5qaNvKS0hjVJj8B21idZ9BX8enepsyFR/+aTX3qkxgS/iarWWF0ACwNw8+aEaXoLZVzMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKPblJBm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730294844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZwRFNIU3S/3yfl93KVGKjq7w2zfBvzCzL/AqAlwaYNg=;
	b=hKPblJBm6/tgS3b/bHY/sD1OLIUc1aU7qfh+qP94GCU4Z9eujAcnu7j7r/sBA+Q5SE3pKN
	z8uOVF60bD90ZIFM2/TDIP61OwujQ3rzknCjPMEbRLUpwpSzEIH2WqdPFWhKs4cirmaRzD
	SPnlU9hjkMnscwsuVb7g26DkGzFl4y8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-l1wVdpTUOEOfyblw1oz1XQ-1; Wed, 30 Oct 2024 09:27:23 -0400
X-MC-Unique: l1wVdpTUOEOfyblw1oz1XQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d462b64e3so3234349f8f.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 06:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294842; x=1730899642;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwRFNIU3S/3yfl93KVGKjq7w2zfBvzCzL/AqAlwaYNg=;
        b=VKod8+6mgvEr/kVCM2Fmu0po2ohn9UJICWOvt1KgGNgtb44qvqPBu5PBo+JLwLUee9
         cmSI5MmdUUPnD7UVCwpsnMgkyhW1Fc+P2wyfdLU0NklrQdF6cw5AV9g8AOmMS7qiPBGH
         QU9WE2+eudl2bWevhtZFmkRwPcdGzY30+rwJjycLO3IBR/EdtjSmRknMPu0yVfFFaOTD
         Lp6uCKjHaIgVqWrqJXcsi47F3liv4DmQ4/VMYMWwApGvmqbu1DiSJgv7na0Ad4NXxv/i
         tjUsZCPmLUo62ZY13A7fZi5IVZCbyrtl9sJqllye8/jAZakUbop2674YuhrSEfhLvD44
         EpYQ==
X-Gm-Message-State: AOJu0YwMMfu4SDKFg4+XL0pXJtTbgEUSCda1WlyPc0gKrdPci2wceOK8
	pvCnPdSbXToSBoAoFDAST0a6QqA7pfjaNHBChqN6ICLsaLVf8vHKWYBECEsPaTwVfxGyPhT95Vs
	4aeLId0I3NV3jAeW0rxMsv7gApGDDQpX5TfXmIyvXDdZX0GxcizKDtg==
X-Received: by 2002:a5d:4d43:0:b0:37c:d121:e841 with SMTP id ffacd0b85a97d-380611e73b9mr11711336f8f.40.1730294841897;
        Wed, 30 Oct 2024 06:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Pi0EmGKJC0o95sfekszbeRrRNIEHgeJrSJCboCX5q0zF/3gmefY5Hb7KWepXRuSh/ncDNg==
X-Received: by 2002:a5d:4d43:0:b0:37c:d121:e841 with SMTP id ffacd0b85a97d-380611e73b9mr11711316f8f.40.1730294841551;
        Wed, 30 Oct 2024 06:27:21 -0700 (PDT)
Received: from debian (2a01cb058d23d600438d14b4ec9f14b9.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:438d:14b4:ec9f:14b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4ad08sm15339090f8f.64.2024.10.30.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:27:20 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:27:19 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next] vrf: Prepare vrf_process_v4_outbound() to future
 .flowi4_tos conversion.
Message-ID: <6be084229008dcfa7a4e2758befccfd2217a331e.1730294788.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vrf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 4087f72f0d2b..67d25f4f94ef 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -521,7 +521,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 	/* needed to match OIF rule */
 	fl4.flowi4_l3mdev = vrf_dev->ifindex;
 	fl4.flowi4_iif = LOOPBACK_IFINDEX;
-	fl4.flowi4_tos = ip4h->tos & INET_DSCP_MASK;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
 	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 	fl4.flowi4_proto = ip4h->protocol;
 	fl4.daddr = ip4h->daddr;
-- 
2.39.2


