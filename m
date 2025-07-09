Return-Path: <netdev+bounces-205450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782DAFEBF3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186BD7A96FF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB552E62C0;
	Wed,  9 Jul 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE2DUI+3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F62E6134
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071415; cv=none; b=lQQ3jFIyPu37DefkzjI87pW6tMoqPpEirkjhCRicaEoYBQwIuOZ83Z9X1+OQ2RZ3zs/B7RaE9Yr/XtdwbDH+qG46dBlGw4CtQLVKHr4mQ9W1J1AdRy+jvtpLV3AHmIWBBWYx91EgFWHzmmf/M3OjrspmyKu517E37eChyIYcZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071415; c=relaxed/simple;
	bh=1ME9fPHsUHke/ZgVQ1NAUwv4w4hCrl6s6TeGq/ZxW74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nA0pMGxspzwQQlbbaLFYKa3LHWQgX0AmRr3tLgse70XEm8LYLdUG4nQG8bymp5nE9jcSh+QoEevFYEDs7506FheI8f5DhjJ/DbZ2UmajpkTQt3ghWSk/LRo8uijBJB7E7mbqpJJvPoev8PCfhZ7pSJwqBjJ25z+wTL0vSLe9lOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE2DUI+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752071412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nOv0TRXgxBCETD+aOrgNzVmTJDDfkK9YtmQMOoUkDFQ=;
	b=PE2DUI+35yGAB3xhdDvjN+AYTKa8Koi3MCIBWoA06eLffq3oru2K/OuSCJQzJlHSEKzPu5
	vLh9TjBaJsb9MrxVPXC56rrR14KX9J/Y67q5y8DGw/lHja9/Up66qqi75XqlAkqI/Fusg5
	qG6j76U27vwp6gyIMLjBU49SSA8rGMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-4z8mwf3KPbSw8qNx1AdjXw-1; Wed, 09 Jul 2025 10:30:09 -0400
X-MC-Unique: 4z8mwf3KPbSw8qNx1AdjXw-1
X-Mimecast-MFC-AGG-ID: 4z8mwf3KPbSw8qNx1AdjXw_1752071409
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso3774f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 07:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071409; x=1752676209;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOv0TRXgxBCETD+aOrgNzVmTJDDfkK9YtmQMOoUkDFQ=;
        b=OIfCLVO6AHAp6l5CTrbJonvOcQrYuL3AYWjW/2Mwleof8k/cq7w4z9GLLnRV+Mjisn
         w8vq4M9dpajmJ1F2KkDqzQdq+q1H0PQydlXS+C8pihWHkmzgYS0uC2sVnowVZnfFriPV
         BCAtxbnAJ3m3khpzTYLpM5PY+thdylvLzFyNrbB1k648/L3cSyuVO62NrWoaIhDisRvR
         ZVj/WBqON3ButoCz9Opzw89DrJrtlJL/JBp3iiZrCuLtjkjrua5i5mOaqKDH3m8sNAM5
         UxzBE7IuNSy+pjmmPj+fbyPE5duiWFQlV/FE6Bh53xTS389a8F5fxMUBafRqBBu/8AnO
         9hOA==
X-Gm-Message-State: AOJu0Yy8VgbMrPjLg0yzfBzZ0WlWN3CorygOPgln+GyJ1Eg58tBKLVtC
	suVKdFr8njlqNh9beHTiSDBBPzg4h1efd8/3iFedyLjHkgtYKmt6xveMhO/zv3C4XmxARwIKryD
	CtN68Q5qjv6pcPlwi1EjhfbW8NomPKdl9Xd1LLZBbzygzL1cggzFQdtC88w==
X-Gm-Gg: ASbGnctsmZPXCqbJO4MenCo2LSawTV2rhtrY7+B6FibLsboo8K5X2AnY20HR2106aFu
	YsbVTnJIFVu2yd9ELBcLucyJ7XfM1Wups/jqLLIwMrnadYlJb3oOfkB7eLyDYM9KUKOrCfImN+c
	/hpmSkHEeZnX84XqHONd2IJ+WXDgjdAJzNaxmDUmqN/n4xD2nuf8tWwJVMbzVqnRzGFrgYGGyLD
	oT+LSYfVxVadOBRmc4uhKlRp9asIImtmjk0IyfTv3CHnHT8exwzj8iKsVCSr89MHl0syZ3vJU5L
	22rVsK8sRw==
X-Received: by 2002:a05:6000:310e:b0:3a4:e56a:48c1 with SMTP id ffacd0b85a97d-3b5e453fa39mr2580691f8f.55.1752071408662;
        Wed, 09 Jul 2025 07:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOtP21tLWGIllc9dOzT2Btg9KsspkzzJbqEjiiJFpIkBHwXtuR8DPdxVuSPpR+QTmu270m4A==
X-Received: by 2002:a05:6000:310e:b0:3a4:e56a:48c1 with SMTP id ffacd0b85a97d-3b5e453fa39mr2580649f8f.55.1752071408211;
        Wed, 09 Jul 2025 07:30:08 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50527acsm25054995e9.14.2025.07.09.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:30:07 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:30:04 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Aiden Yang <ling@moedove.com>, Gary Guo <gary@kernel.org>
Subject: [PATCH net 0/2] gre: Fix default IPv6 multicast route creation.
Message-ID: <cover.1752070620.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When fixing IPv6 link-local address generation on GRE devices with
commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
generation."), I accidentally broke the default IPv6 multicast route
creation on these GRE devices.

Fix that in patch 1, making the GRE specific code yet a bit closer to
the generic code used by most other network interface types.

Then extend the selftest in patch 2 to cover this case.

Guillaume Nault (2):
  gre: Fix IPv6 multicast route creation.
  selftests: Add IPv6 multicast route generation tests for GRE devices.

 net/ipv6/addrconf.c                           |  9 ++-----
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 27 ++++++++++++-------
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.39.2


