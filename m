Return-Path: <netdev+bounces-276895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPv4CBFp12myNggAu9opvQ
	(envelope-from <netdev+bounces-276895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:53:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAE3C8023
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88612300FA2B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C138A29A;
	Thu,  9 Apr 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sd0w0//a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4037DE97
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724765; cv=none; b=BDUEqgyTZBaOLgPOsI4ZeDu40ksjvJGANcCMirxs2g6DaeXUBso5n4/6ubxAEMZHGMX/TYz6SLo6Hd1NFCsZ3xBPXpEg1XYgK5mlrI7/Kj2kFPjyR98wCTU2Iao0Y7iVmTbJlq3B5pCY0JR4WH8zl50XTVVBZY1zLmg0CCgD8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724765; c=relaxed/simple;
	bh=r5zNSdzw43N7FhkDyTOcOde1b7pbjd2xXpWWnsiYP0Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hqa1rFV1tfFcuwoOenDEnSYsJC5iIFa1gtVwpU/gLdgm4gvcMSrBQTWhAyVj5090Un5h6/TCsj0mZpsW+XWjIgVPkSTNKhlnkwSYh2u6R23zlU+fgU0O0TeQwvLBVWlD+UGAcXdtAHGJfxlWZ9zmaj2TYtEQCoEIkDlZdX6+uzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sd0w0//a; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d63962d83so19648871cf.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775724763; x=1776329563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4TuPBj/BkFSIX9SY3sqbeog51Zq39yZDNGk3F2F68vw=;
        b=sd0w0//aa+MTT33RTU0zqW0kvPoKE+4Ot0PsKz3DAAk+HBjOfHbHXr+gHL60zV2Qcu
         Q6wcP8/GOw0SVJN3K2+w0VHblXjKWkcZctfwMt9MG2xxdgNR/UagYaIOtaZLLJALu8AT
         T2aqxL/TW6MtIG/jkEkTZJb+fIfb2NmuXaLkiljhF+4mQIcsGB8jp8E434lxRJ17NbAX
         b5vrKHy2RMAmzm2+/vFmCYMvZPXcEft3MRm94jmHIFTJDH2SrwL5MckZ9d5j6pPo/Q7/
         rjPmId4QYTBuyf63zGY7M0UfmbfHFY55uQYO1b6fsEHqNoh8afhBIFnWeDvaMF7TbgkO
         c7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724763; x=1776329563;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TuPBj/BkFSIX9SY3sqbeog51Zq39yZDNGk3F2F68vw=;
        b=THUIJpsJHzd7u3N2KXTdv0sTHugwU/GYgLQXDp8TCAi/iJVtxOjqxdqGbPYTz0S8T4
         +ckP/6hy1mT1CiF1thSqacaCJNgbLmF6VZUTW0Mw7vvYbrb4cuL7onxo/MPvpKLHwWIz
         51I1t9Lsb6jP+8s8z/k0vjTeh3hMKmsGCly/Ux10GBLWwU6j9PnwWE7B7CxvXthqi7UT
         YaxtdVctYb4xyTBlvwIr3QaNK0TiXkbJccUeERyIJ/kQuu8c5LX2GWsoV6o5EoDGBxwf
         WEYmLkQ0Mig8D2eWDq1OnoBYuQmH5K04JDKk1f/5Eal/qd+Sp0u/1JaNt91y/ZouRTsL
         g2cg==
X-Forwarded-Encrypted: i=1; AJvYcCXHaRsEaZ/zd+HPv5GabDfPdNd4rObvW5FeRypNfbuEVJdlkTaauTXIMPnwEKlDp04TMqxk2Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8SL3RfT6ZtBe/oEiGClA3Exu+ZMAp0bdEmZpIO7Dj0Fo1irb
	KzhvSlygcOW3kBIT3XyHzNO7Cn3HT5RghgEg7NGa5NIazqzURQmP/N9em/xI2yTIBchaZXH6V11
	Bp4WSCHVe/begdA==
X-Received: from qkoa23.prod.google.com ([2002:a05:620a:2f7:b0:8cf:b210:15d2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7ef:b0:8d6:8b41:3bc8 with SMTP id af79cd13be357-8d68b413faamr2008915585a.66.1775724762622;
 Thu, 09 Apr 2026 01:52:42 -0700 (PDT)
Date: Thu,  9 Apr 2026 08:52:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409085238.1122947-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] ipvlan: multicast delivery changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1AAE3C8023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As we did recently for macvlan, this series adds some relief
when ipvlan is under multicast storms.

Eric Dumazet (2):
  ipvlan: ipvlan_handle_mode_l2() refactoring
  ipvlan: avoid spinlock contention in ipvlan_multicast_enqueue()

 drivers/net/ipvlan/ipvlan_core.c | 42 +++++++++++++++++---------------
 1 file changed, 23 insertions(+), 19 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


