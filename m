Return-Path: <netdev+bounces-144986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305919C8F1C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96DD28BBE3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDE15B0EF;
	Thu, 14 Nov 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amTz5GC+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4B14E2D6
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600216; cv=none; b=J9TwDc2N2uFCimykNOAjASOtx1jGYu97HLKswiVENqf/kWy8par5PkH13vK7YPd46s9K4r/NeLl7AUZE/9KteYbklGedsLx9lJEbggU2PFE3nnplLj4bL5qOtfOZU3NSs6cJZHfzc8haBen1rWEjFaEnelD6L4/mHqkthWOhHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600216; c=relaxed/simple;
	bh=EiBG97YNblHkUXL6lTFf1fcI90D+FK3ZliHurtw57i4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AMFF0wa9NefBX+fXxAmydijDM8yKYCwiADu0UhTFIkhGcPKrGlUb4r4eoVWFDmUyCJ8bk7s9ShdtBGqSUGEbpm3rhSH4QtOzhtkR2hIdgWMnodP9kUbJ+ME6b7t2LPjvdeByozXhxUTDGEWc6FlItZvvEmk1MQ6AvfZtR0Sq1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amTz5GC+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731600213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mqDeygRmWi/kNU1a4hZLWkcZ1ztVZyaf0VsbpEiFlQI=;
	b=amTz5GC+eTPglghcelbV7RHoxIMpcXwaGIrowJEsddklEM1nifXtiGz3Ph3dqnsErwfXYb
	RfZnbKqbtS9nLkehODFe8fdWdBijOrejydLH9PwRoi/o2ES2/NCJLR5Z9/KzgM99QZzx+b
	YwlshMwXYSGaHVgw6MhqZqQ2qLDMHlE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-t-l-tX_CMWmpz6RtC_MB-A-1; Thu, 14 Nov 2024 11:03:29 -0500
X-MC-Unique: t-l-tX_CMWmpz6RtC_MB-A-1
X-Mimecast-MFC-AGG-ID: t-l-tX_CMWmpz6RtC_MB-A
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso6066845e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 08:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600208; x=1732205008;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqDeygRmWi/kNU1a4hZLWkcZ1ztVZyaf0VsbpEiFlQI=;
        b=HdEJbcDr4vp9fX+8aJIBGesHLn/I2QT7fPjFJ5XLWtgoEEbfLQKQEtOf3p8CAE9Rby
         AFTx3Uni8xhCYYIBEqRHP7SNk5e3hR9eXn83Mw4Uge3rGVxxVYXxXb4z6sN6uiwgcr8S
         mVwzKeuXdX+HF13TJznHQ+MjD9XZ5vv4rB3S9/1u/enk0NogDhHsxYJrpBMgatKfxPAy
         zGxtEeRP+/027YwD9Jk/j60uFSReQBnF5WjntoPukP3CoqavRfYsCAw1PFafXAfKrQUF
         YsG7//1CaXuqQgpayLwm0deA2/wYFkDoZFoy783lL9dLYjEGmim0ohBFnDOnNs3pYJqP
         /iMw==
X-Forwarded-Encrypted: i=1; AJvYcCVqZ8Q5vkK8D+hvVRMaeihnipGGsHou9dWFxCFMf3tumIPaz5BWAkWULrpZ7hIprW1lTmoXbeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3IdhxFkHPHDeIAexLh6d+f9GE0ca1WIDPEEDaAL2ydVoNUOc
	+1S6mk8blIfOXzybQVAnZHU6XubnVpKyMjkHOLyjUHOMxKR7whr1wX3LhpsBjuW9G+WInIgZP/u
	A4RIovoyIT3o83KzTPfY+nURctEzqdhqs1xchbO5WGZt8oXr+BupXtg==
X-Received: by 2002:a05:600c:1c09:b0:431:5522:e009 with SMTP id 5b1f17b1804b1-432b750394cmr227379835e9.12.1731600207967;
        Thu, 14 Nov 2024 08:03:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPb1+OHLtmsNZvaVnkw878qmBSxtdRGcXdFiXLwoXAHw0rchZLFpvGTZGMFu9nMowpx0edyA==
X-Received: by 2002:a05:600c:1c09:b0:431:5522:e009 with SMTP id 5b1f17b1804b1-432b750394cmr227368955e9.12.1731600198419;
        Thu, 14 Nov 2024 08:03:18 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da299dadsm27965975e9.43.2024.11.14.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:03:17 -0800 (PST)
Date: Thu, 14 Nov 2024 17:03:16 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, coreteam@netfilter.org,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH nf-next 0/5] netfilter: Prepare netfilter to future
 .flowi4_tos conversion.
Message-ID: <cover.1731599482.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are multiple occasions where Netfilter code needs to perform
route lookups and initialise struct flowi4. As we're in the process of
converting the .flowi4_tos field to dscp_t, we need to convert the
users so that they have a dscp_t value at hand, rather than a __u8.

All netfilter users get the DSCP (TOS) value from IPv4 packet headers.
So we just need to use the new ip4h_dscp() helper to get a dscp_t
variable.

Converting .flowi4_tos to dscp_t will allow to detect regressions where
ECN bits are mistakenly treated as DSCP when doing route lookups.

Guillaume Nault (5):
  netfilter: ipv4: Convert ip_route_me_harder() to dscp_t.
  netfilter: flow_offload: Convert nft_flow_route() to dscp_t.
  netfilter: rpfilter: Convert rpfilter_mt() to dscp_t.
  netfilter: nft_fib: Convert nft_fib4_eval() to dscp_t.
  netfilter: nf_dup4: Convert nf_dup_ipv4_route() to dscp_t.

 net/ipv4/netfilter.c              | 2 +-
 net/ipv4/netfilter/ipt_rpfilter.c | 2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c  | 2 +-
 net/ipv4/netfilter/nft_fib_ipv4.c | 3 ++-
 net/netfilter/nft_flow_offload.c  | 4 ++--
 5 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.39.2


