Return-Path: <netdev+bounces-127106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC13974236
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B670B21D93
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C717A5AA;
	Tue, 10 Sep 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iie95DB5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186213B5AE
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993064; cv=none; b=OcEHarRt2OPWI2Tp3Y6zG1VxYybWojiCM+Y6e/V/esQ3rFDPavf85igUAVW+30DmO+AuIK08I/bE+pDQldYk0EBho+OvLfkx7a7HXc4IW4JEoNSooMRDk2DEVLPjcuYa/JlV/R5//xaHB9yEssu5xmXs9cW3OZETZBgiDCtU+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993064; c=relaxed/simple;
	bh=1CitkQ5sXoLSNxqMb/pgqnQKMYV8MdzKtnNS3Sxtqh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nf8KyVibolxjdAoQly+UE7y/wZNyWzYxY8kvxPz71EZcUjoXq5IXeW0AsM2Qt2soZU82St10M+w8Z+7bAytwYsVeOqgpthEJze5mMvc5sgySNQb0wZVxOYbRWWdJjzl4zPPQrf6oD2dJ2MJFd20s5clYypIZY4WCR8oulLRs244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iie95DB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725993061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=83q1JUe2gwH+jcfMY5JSqKPVrFt3GXTQnTABmmzK+Lg=;
	b=Iie95DB59r5YvAoqRvrvxxKQ2Z0umJsO6VMKCCdS4/OtUYsH4TncFIvh+7tkz0J1SwmpQU
	dy14gr5mk8/+2dBHacLpSLMw7E3qsWEDRY21AcZeC0hT/krfpDG9ppaGYxlaPfWiWaMc8j
	KY+k3N27xFUI9KpmqWOLhnRgdaEpWqk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-5MrS3OaRP_KBChevL5FLyw-1; Tue, 10 Sep 2024 14:31:00 -0400
X-MC-Unique: 5MrS3OaRP_KBChevL5FLyw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb0ed9072so29730035e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993059; x=1726597859;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83q1JUe2gwH+jcfMY5JSqKPVrFt3GXTQnTABmmzK+Lg=;
        b=nqyMnlTUJPxxsHmH8FXN8BLeWc5DVISzGjTCORaK3bg7VTAjAcaiCKgYtb4H0tZQbH
         5bwSl7ipQz4tC6yE7T1ZT5G0rD17PYtf5VxnRL0cHIzbLx5uROM7yH4XPi27UDyCVPoZ
         tfBQyI2+AR9XkgrVzvujQYj2aH4mwyZZoXE11Ms6GUXBTFAcPZ+U8uB6f5JewHqYt05C
         hshPfiBS7wzBFmHg19i1ZK0tYa32ORC+cIPHaB3pkswnKHMEJVhIdpshnXPV180RvRZ1
         EK77ZMWk5gAx8GK9uXTXFEdviT4Mz7TaBSpgjQdWApDVwQKVYT8rOOEO+/Xq46Mef8U7
         js7w==
X-Gm-Message-State: AOJu0YzDHFXgoi6uTPf7X4x0d5/f0F0xnNGckFSyjzGqFSEDdZ/tCMMR
	AsidFk7cXrgvrUe5z8mjuWeg0sb9NEzDUKLnbRHZKeR9TLM+0C9CTNIPLNv3u74SRvxNhYT9Dza
	ktXaMPT60bz3XZZbFbNEikO1JI5Zs3OOyuPKckVvjit8j9WGWSSJJjJa2weAECw==
X-Received: by 2002:a05:600c:1c9e:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-42cb50877femr83880645e9.11.1725993059259;
        Tue, 10 Sep 2024 11:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQyPAVidCDih7MQYMPdcjEcrybzTbzrNJNpfWjxJJvIzESDQixcsK0RR4yprk64BOLZ5DNmQ==
X-Received: by 2002:a05:600c:1c9e:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-42cb50877femr83880055e9.11.1725993058075;
        Tue, 10 Sep 2024 11:30:58 -0700 (PDT)
Received: from debian (2a01cb058d23d6001ef525940bfc7e6a.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1ef5:2594:bfc:7e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb2ca95a6sm103517225e9.21.2024.09.10.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 11:30:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 20:30:55 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net 0/2] bareudp: Pull inner IP header on xmit/recv.
Message-ID: <cover.1725992513.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bareudp accesses the inner IP header in its xmit and and recv paths.
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


