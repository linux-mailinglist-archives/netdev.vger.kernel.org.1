Return-Path: <netdev+bounces-127298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966D974E69
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C226286FD0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077F154C07;
	Wed, 11 Sep 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfEjxLHX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200E14AD0A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046459; cv=none; b=BNKg7EO2EP0XcTLLC9w/Cvs22T6B6VdfYLp7dBcVTfAaUQilv+3aSjWRE45Wmox260H8FAPTKHy7enq50Kmvr7wmSFQeTvTZHj7LvXj2eC+cExiiU6vFQf9DT5rpo5MXf/oHii/wfDLU81NSmlVcPbO40dE7CPuMNyRcI8cIK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046459; c=relaxed/simple;
	bh=o3P2VUNL5gxlnpMcVtt7TjmRJCqN1RdG7yrx01VpE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnChpFFgmaQd0OjIAy3/BS9kNNOVDC+Z5PXw7BxDdUAAgf7IwAwoi29dM+Cq0zHQ8iaDLkH//GKP40eNtDOuC+6++1WBBJ4vvM/cXVW06zW8gqaXbSsSffAKq14rugyzUOG+xbT+MF3r9H6AJTsmPmfE8cvMbjoqHjGZaOFgXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfEjxLHX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Xj/OmCLHT6qXVsIJ3sv/MiIxpSvUV4rpSOEzGHtSQ1Q=;
	b=PfEjxLHXNKo4hNLuF5XPQpb3qtToD4hpRMKJaVEeUi+NYWBBb9ltCNzo3h1oCBFhcXCEsb
	5/uAAl5f/Q/rpjlwbVRLw99gdRTTn1iw6CzGyfYqvxVQvelCV0EOpp8YQDs1HiuzGW42Te
	+lVQ2zk1kKN4DEcjBxvZnTTtbR57MkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-9K025J6eMNKGJQOKZeEPXg-1; Wed, 11 Sep 2024 05:20:55 -0400
X-MC-Unique: 9K025J6eMNKGJQOKZeEPXg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb2c5d634so27792215e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046454; x=1726651254;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj/OmCLHT6qXVsIJ3sv/MiIxpSvUV4rpSOEzGHtSQ1Q=;
        b=DtJ7+TejWCJlC10YJ+7nkSGF3ToJ3QI0r3atbnNIzvtF69T7s4MViiAFu5XtQaAADZ
         xvJXCt3IcWSHucT/rf8hZrEX3i+krX2GMMKTbz7bJ55ENTlK4NPGj1BKjyISqTsoPYPq
         gQQIrrPmZjEsNbuFbBqbYpaqFyExohTRRSSS+DPJrWFNmhRl7uUL9z1t7Aa/GU0BhTCX
         SH+tcqrnK3HQB5uPwblMWoeRpt++lat0TEkUtf+U/Lq3wjifMuywX+QVbCkumRX9S89w
         14Ds3NCw8q8Ps9qoNuJjiS6w2wu/XkCYJ0ybmc0pt5KlqCgXQqRaokFwCW52l0QU+GQA
         tZbA==
X-Gm-Message-State: AOJu0YxPu8yAFEcFHjZzCVL6MslKL5yEkOJDD/3Lhak5uE0RbkUTKpf/
	SDLIHZKrMGzQbZ2oAzNP6W0gWj+ebDVFAnbFRLGNpnbIyxQyL/Oe2KUIMdCTnbnemHKCmQuD5ZE
	GIQtDbREsUDIWT+hW5Q08O2w3VzvNTAl1yHZ/2n8+0sb5TXGoNjHJJw==
X-Received: by 2002:a05:600c:3541:b0:42c:c37b:4d53 with SMTP id 5b1f17b1804b1-42cc37b501fmr33176535e9.0.1726046454251;
        Wed, 11 Sep 2024 02:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYJIYxlPJzlmNpzBABIeSawta7Ebjmfs6xDdw/jZ13VNvrPGnY40yA2AvC0ixJQ6IcHfjqvg==
X-Received: by 2002:a05:600c:3541:b0:42c:c37b:4d53 with SMTP id 5b1f17b1804b1-42cc37b501fmr33176265e9.0.1726046453674;
        Wed, 11 Sep 2024 02:20:53 -0700 (PDT)
Received: from debian (2a01cb058d23d600901e7567fb9bd901.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:901e:7567:fb9b:d901])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a73sm137090825e9.3.2024.09.11.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:20:53 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:20:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2 0/2] bareudp: Pull inner IP header on xmit/recv.
Message-ID: <cover.1726046181.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bareudp accesses the inner IP header in its xmit and recv paths.
However it doesn't ensure that this header is part of skb->head.

Both vxlan and geneve have received fixes for similar problems in the
past. This series fixes bareudp using the same approach.

Guillaume Nault (2):
  bareudp: Pull inner IP header in bareudp_udp_encap_recv().
  bareudp: Pull inner IP header on xmit.

 drivers/net/bareudp.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.39.2


