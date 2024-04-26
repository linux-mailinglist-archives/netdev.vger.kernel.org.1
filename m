Return-Path: <netdev+bounces-91743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0778B3B60
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D1328233B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0A1494A6;
	Fri, 26 Apr 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvS9pVkc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD4824B3
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145245; cv=none; b=TGl0jUrpbl77sZpOvOx39bEYz6PGwbwbtoBYgdKyiaUIoXqYdSOYTz95ezQlBhT+u23jHmdOHLcZF4IERyJ5gK5EbSI+C262caFncRDDK3ZVUVKAz3eqCPDVzEGp8FmCfEQzICNZN5d361uv3UGmOYwx3/GLwIjT4cwYlDqmqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145245; c=relaxed/simple;
	bh=nI7SOS2vPedhIDabk0VC9o7sJ6SFzCq+6Et4SXgM+IY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ox4r2QuDyJcBoIhRgOV9rjECixarJOzru0p3KhSj3Bmh8Z2EAW4M4mSRLZo9kSqCNZ54RjyCujkU4/V1fsYJ87hoh8Sx0b83mQSjivNWFTP36pClFG+fzLtVINbJRqPtoblSbiJRGKqKKOnDSNI7ytkZWxNqsRWp0smTdvUrSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvS9pVkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714145243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=80T5g8sBllHGkC642tYAcJ8hHgE0Fk8A0xJ+F6y7lyc=;
	b=fvS9pVkcCQo7o0efvJOg+Z+pJHRA4IU2vlyDxue2GKU43qO/4RWu64baT10Iqx1OC6cHeh
	XZgnEG9srUpMv5f2Bax8Q9XMU8eRiA2oIJe7JZgW7KiAgh1mhFnYbbNG+8hh1v6f8y+u24
	Ex6EY5niSx1MfH2B8Ns1slysUbjK6sY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-7v8VzUM6N2CXlp6Dt5Zg-Q-1; Fri, 26 Apr 2024 11:27:21 -0400
X-MC-Unique: 7v8VzUM6N2CXlp6Dt5Zg-Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7907267421fso286441085a.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145241; x=1714750041;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80T5g8sBllHGkC642tYAcJ8hHgE0Fk8A0xJ+F6y7lyc=;
        b=ULH6FlXytmCSkxcxOk4GV5J3ILs1Cd3cZZmE6eudOF7AD4g6N94R3NyukwS7bw3ADc
         TxYDdEFvy2zaLs9zbUvHIdFAm1IlT33XN+Rz76S4C9MUErd8eAnjHrhl0Vv/D+v3DA8w
         oRiiUOcUHTDfdJfMG0udJ7zLntVBJS/NkmWa2f9P78KNA1xDPtn2biQz5Kj6B60+vqu4
         kYAIKO0cg1IcKlpSXGdYkNoq0U+ioh9wlKWsqrwmkABEF8SmrZPBW2909j5AnHcOSkEs
         f8N4ACi5+pI6owEPJYIefJPYPOr4DjKlhTUeBosbSGqbb272L1F9Ro0x+rYT+1Y53Xft
         c3rA==
X-Gm-Message-State: AOJu0Yzx+ubR8ayw/j6wiGwPGyDqHDh+0F9CotN+MCe9Rnfm4JcBhUJ/
	gphAn8ipmF47hd8G09PfroHNs7qssP571BPTu6yHk+k3+CW1MU7h7BuONIPUxcAgImDOkM2lfC6
	Z1ZqJ+qemlEUjhxKx/5BwW354KBhevwI99a714ncr5xIaN4fi5dyh2A==
X-Received: by 2002:a05:6214:19e5:b0:69b:5c57:362 with SMTP id q5-20020a05621419e500b0069b5c570362mr3808425qvc.1.1714145240914;
        Fri, 26 Apr 2024 08:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUUuUwB7dZK/bsnxf+WEs4NbmqNozfevqhHC3Lme/+Y0GyY6zJONLKwU8muPP2yFjF9rQnmg==
X-Received: by 2002:a05:6214:19e5:b0:69b:5c57:362 with SMTP id q5-20020a05621419e500b0069b5c570362mr3808402qvc.1.1714145240621;
        Fri, 26 Apr 2024 08:27:20 -0700 (PDT)
Received: from debian (2a01cb058918ce00d9135204d7b88de9.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:d913:5204:d7b8:8de9])
        by smtp.gmail.com with ESMTPSA id g18-20020ad45152000000b006a0af6e25c2sm568983qvq.94.2024.04.26.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:27:20 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:27:15 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	stephen hemminger <shemminger@vyatta.com>
Subject: [PATCH net 0/2] vxlan: Fix vxlan counters.
Message-ID: <cover.1714144439.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Like most virtual devices, vxlan needs special care when updating its
netdevice counters. This is done in patch 1. Patch 2 just adds a
missing VNI counter update (found while working on patch 1).

Guillaume Nault (2):
  vxlan: Fix racy device stats updates.
  vxlan: Add missing VNI filter counter update in arp_reduce().

 drivers/net/vxlan/vxlan_core.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

-- 
2.39.2


