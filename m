Return-Path: <netdev+bounces-115344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC421945ECC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905F61F221B0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5861E3CB1;
	Fri,  2 Aug 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqebCF6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A081E4A6
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606036; cv=none; b=XLEDYUPv5F9xAnbhbtmqOtYf/qIV29PBDYueAHOdQJOXLJRgEpZ1nyD069Ggj5WoqZPloWGy1VkZ2xOsBR0ftDK4txseoDUB58xaCzO68vcRbQsowv3rF3+zTX/8C/z6sH5SuBuVHcH3xie/c45Sr1WBsywmWQ45mwPoC59iR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606036; c=relaxed/simple;
	bh=VOTd7XaJNFqZBUg3gAXnma/E8h8HkYH0PyAsPFPXXow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tBatVTe9igMQZiZtBpJ3HIiXbT13rF8SdkwvRJBcxx4joPSAH+/t8Bn9YhPz1UC7lzzj7/XWbhY57bLmjC4MbpCDu6pYA7ArN1L39rlq6XMAYb4DnblKM912bPunvRGOb/tocrXHavCfEDomFMj9d/48E3P5ilH2SxGVz7AJDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqebCF6N; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6698f11853aso155595767b3.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722606034; x=1723210834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Vj6WkFEq/NfNec+kYpZsPerQBcnr3RPO860BU+6j+M=;
        b=LqebCF6NCrEXhVIf6vIzotWY46WcitUI1jHrfEHstrD2/ykKQrlDwrPw8mYdzSOg42
         V0vnUYm1EnIZsVgtlHPGGH+31dk6fvCZAxyNmHQjLN4GNhdiPBCqWkMDulkeIwR3KgRV
         tSQrS6bXTezIRnJT58gnTPy9VcXAXet5/bDiAbRNQ22k8ubfGpf3+WJl3V5AS06GLPWz
         iKgPjYTwP4ePKc2cjl0d/h/qfB9UPt69RqXzZg1TlNPrkiDKwV5dE0xq5aP2s5voQHUx
         w2eEHkATzJt+3ldKOMUSIZNj21VgBloK3YzPaOqozQtDlkfD/ldy2XAmuKGpB6AAztJy
         TYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606034; x=1723210834;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Vj6WkFEq/NfNec+kYpZsPerQBcnr3RPO860BU+6j+M=;
        b=xFXKbbJxmFUJ2hBod7HBusM37Sn4D9Aa7rvLR6nQg/c1H/Cjt3p7ZYc7+u1G3NwAhL
         Zq5Ifcdjb0nCO1e8aZ4MXlMjTfTjK6lwcXi/Nm9df21hrvjvYeyjBHZPA8cES7rLBiOB
         L7zwImap1NULK77mlWBmnBnax2M3XnPOo+4i2GtRwjxmmV8syAxiZRjgq7LaWnfwan5s
         vGjn8KBmjjzd6chjXE1YEuLiyWTzTLHJyDDZhnVT1TCUr3NXSNJZF21al0Dk0/RLpInl
         6nD+ErwYNG/qKFJ8kHdW4Xf2njl3Ta7DBHQxxnxWFlyd44edB2V3GdH5FiGc+wbb9NmV
         qNlA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Q9lsfJJaal0om4jDCPyZfCbp7HQY/13wFL7dyUkE8FHG+NdNTlr1AK/GCeo6BfglUp5BO192nEC3hNU0Mgdu/OJHygPa
X-Gm-Message-State: AOJu0YzO1Ggm7VHI5X9YXsXCoNuRzDI4XpTgjWeoUrt/sv6w/VATfS5O
	cc+RpvgOKatA0ICBkmYlzzzTiuj7KyT5ACtGdVzhKHzHSHuoR7ylXACNPUjNp9QooPhFGX8dYsr
	XfRhqESjzTQ==
X-Google-Smtp-Source: AGHT+IG2BQ3SRHk0AMIVerERp2PxCBtl2unOZwcLi7Kb7LIhgE70Gn5428nNXh+igRutQhWlilcxXLyR2Ogl+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154e:b0:e0b:bcd2:b2ee with SMTP
 id 3f1490d57ef6-e0bde290b7bmr6300276.6.1722606033812; Fri, 02 Aug 2024
 06:40:33 -0700 (PDT)
Date: Fri,  2 Aug 2024 13:40:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802134029.3748005-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] net: constify 'struct net' parameter of socket lookups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should keep const qualifiers whenever possible.

This series should remove the need for Tom patch in :

Link: https://lore.kernel.org/netdev/20240731172332.683815-2-tom@herbertland.com/

Eric Dumazet (5):
  inet: constify inet_sk_bound_dev_eq() net parameter
  inet: constify 'struct net' parameter of various lookup helpers
  udp: constify 'struct net' parameter of socket lookups
  inet6: constify 'struct net' parameter of various lookup helpers
  ipv6: udp: constify 'struct net' parameter of socket lookups

 include/linux/filter.h         |  4 ++--
 include/net/inet6_hashtables.h | 14 +++++++-------
 include/net/inet_hashtables.h  | 10 +++++-----
 include/net/inet_sock.h        |  3 ++-
 include/net/ipv6_stubs.h       |  2 +-
 include/net/udp.h              | 14 ++++++++------
 net/ipv4/inet_hashtables.c     | 12 ++++++------
 net/ipv4/udp.c                 |  8 ++++----
 net/ipv6/inet6_hashtables.c    | 15 ++++++++-------
 net/ipv6/udp.c                 |  8 ++++----
 10 files changed, 47 insertions(+), 43 deletions(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog


