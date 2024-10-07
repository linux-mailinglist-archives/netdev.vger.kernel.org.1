Return-Path: <netdev+bounces-132828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEF99360B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F8286B79
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799C1DDC0C;
	Mon,  7 Oct 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3PkGWAc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E51DDA31
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325471; cv=none; b=qVqk+vFcE9JU4/UkU+WpK7STGJKkohaFP/0eE1Xy0hzo4eCLMAkBswF0/NDA2rF1q9RMUIDov/5T6FMZFQk9+BUS/9gORCIIMGOI/EmkiG4LkEWuxfb8TRx7X0hwUgmIS/r8sENyh1ArSyflRzaBhVXiJAEh6nowEehR8HtmJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325471; c=relaxed/simple;
	bh=NqN7QUv4fhtJmNTBX3EgLWupsGhVxI7c1TW7PSVr2r0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AhLC3Yy65B01RIatjLwNLEMP9pP2LFG8c+bY0PU2KZyZGf1jrvmN8IQOc6yueXcG3lhE/lKib508dhUAYfIo5J2+Nd28k2zvFLKpVweYZQrNy/57RERjlKrkxbgUChjqAukj6r1qH8at/X23KeqgKQ8U4eAp9qfvwVG4/7eWpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3PkGWAc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cFXdsvakPKEIqrrC8Ks8ZP3YiTEcolubJoo72Qc4n9s=;
	b=M3PkGWAcckecb9tBZkUXoxdhnOQYG5spyvfXR1NBFXhMZ8rUh1S7GWy+6SnaVTQRpVtZhZ
	7zK+ixh9fa/2gdaD2zW7UTA/OKxxkyyXb+nEtGDGILsSuyh51SxzrZn6J9tPfrMGLMwHPW
	kqclWTLA4IdeFeOXNjDzUcz/zcW7hyI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-8Fzupd5VNcya-oiGqe1JeQ-1; Mon, 07 Oct 2024 14:24:27 -0400
X-MC-Unique: 8Fzupd5VNcya-oiGqe1JeQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cd6655ef0so2312840f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325466; x=1728930266;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFXdsvakPKEIqrrC8Ks8ZP3YiTEcolubJoo72Qc4n9s=;
        b=SKGds92Z2On7CRnhX10WgNSULD/bZnnN6kJ/hoA0h/lwmzUMD2j8cqQvuTduU9XFw1
         tUMVFdnjIB9bUmR3GkAORDIcXxJ0i03FTXPPRdh5C7C2DUkWwgkfeGJT+th+phL+PZZ1
         TMXbJRBfPLrrc6J1bni1mgkQsS1E1RKBG3CVoXwNt9zCpJxs0Lvltd9HNcU4ScSwMfUN
         5BLgR2tiWqc9MWpGwhuFYGJtFNzQsEIJ8uaQ4zPhrbp2d9gBSL9FIMS0ZJ82DRtO3dxX
         gW63t1eBWRNX5bqKrD1tD+AWXjJt037Eaiqi4cgA8nbv9mvyMo3ua6DxQ1OLDhUssnoh
         d/5Q==
X-Gm-Message-State: AOJu0YzMqh2i6QbYr9vmYa0DK5mdzMOBs2YYZjKMzt5mRuqt33FczJvY
	KxQhbUPffflN3/eqK2zti57zMRXIox+hgSrRF5Zb/ae8INtsuGajyKgRk90CJmCeGIerJq2akhp
	Jsrp0KPNeSo16bpB8zgsUixZ4vAnRxO0RocCBJ1Moe8PSZRVIWUsedA==
X-Received: by 2002:adf:e6cb:0:b0:374:c0c9:d178 with SMTP id ffacd0b85a97d-37d0e6bd000mr6843207f8f.9.1728325465896;
        Mon, 07 Oct 2024 11:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/smIepawma3CO+tORKPelxiJFN4WRfzlYvQWa1h3jBES8VtzlAFGAiYqKsJHPZlpMETz+Pg==
X-Received: by 2002:adf:e6cb:0:b0:374:c0c9:d178 with SMTP id ffacd0b85a97d-37d0e6bd000mr6843199f8f.9.1728325465464;
        Mon, 07 Oct 2024 11:24:25 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972b2esm6233707f8f.105.2024.10.07.11.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:25 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:24:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 0/7] ipv4: Convert __fib_validate_source() and its
 callers to dscp_t.
Message-ID: <cover.1728302212.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series continues to prepare users of ->flowi4_tos to a
future conversion of this field (__u8 to dscp_t). This time, we convert
__fib_validate_source() and its call chain.

The objective is to eventually make all users of ->flowi4_tos use a
dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
regressions where ECN bits are erroneously interpreted as DSCP bits.

Guillaume Nault (7):
  ipv4: Convert ip_route_use_hint() to dscp_t.
  ipv4: Convert ip_mkroute_input() to dscp_t.
  ipv4: Convert __mkroute_input() to dscp_t.
  ipv4: Convert ip_route_input_mc() to dscp_t.
  ipv4: Convert ip_mc_validate_source() to dscp_t.
  ipv4: Convert fib_validate_source() to dscp_t.
  ipv4: Convert __fib_validate_source() to dscp_t.

 include/net/ip_fib.h    |  3 ++-
 include/net/route.h     |  7 +++---
 net/ipv4/fib_frontend.c |  9 +++----
 net/ipv4/ip_input.c     |  4 ++--
 net/ipv4/route.c        | 52 ++++++++++++++++++-----------------------
 net/ipv4/udp.c          |  4 ++--
 6 files changed, 38 insertions(+), 41 deletions(-)

-- 
2.39.2


