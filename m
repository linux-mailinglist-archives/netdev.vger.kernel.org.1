Return-Path: <netdev+bounces-220415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E09B45F73
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD9EA07E07
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08530B52D;
	Fri,  5 Sep 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3NDdaNo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E82271476
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091497; cv=none; b=dBWxdiiHlq3C6SFTpn0HF+pywzC6ijUxUeGZXVqfQc/o1H4UBrQhAzLDC73AWWFKhfCPQswMBpneTr1b2vkkLLjtbOY+S2wilJAG6H/DS1uRxkSVgz0115wHo/sy91iCbhL66jQ2UqMya2x0QsaI0hJ5EL9u+ZFnnddwKWZwPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091497; c=relaxed/simple;
	bh=tbB52H4CdqnwMjDDea4/qR0UBeIiS1ub9Xx4U/z5/Uo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bIN2S+qpu0qyVpfcJPRW1lSAP/yhbbFC7LvwNOORBWV0L8T1jpEGvjCfJl8X3H7QtKxpYnt17gUZMz6Q3yT1W82lG1JDTagu3gD5Y0xmwQRdVeyyv+lYuR3nQai471LBoiHOmuwqiJuUCb61lt1fRE8t+0fRVOlWtfIz34eE8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3NDdaNo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71e7181cddeso35332607b3.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091495; x=1757696295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmXIgGMHBHUiTDvtQmKV71St2+q0K6vgTJPlvNkD074=;
        b=b3NDdaNoyW0r9RNBmXLQewMaXW7ZS3NYiZKq9qdSB26AlIxpK03PxVBhlYXUMMIWf4
         4NAsvcoop/nclFKOgSv5aqu5cs1SZf69mCj0pbHZgxohBPEJuUjth0HPtahmqRGTDV+f
         8F1Z1YF+jfJfg3M0VDl+wC3MlXdTn3MrIYt/K3DDf4Fl6i1XIQzKV+5Zb1D0FmO+7fI1
         Z7iAgah9zlFO5AnLu5SFjDATbyeDosZB1GKlchaaT7yGR+IrFnuOm87bUT3nNe3bzTwV
         URD/sRQ15BYqcygKbl2nGRn7TYPXIOeHKWME6TofD6oN2vYzfRbYo/FZgid0XeEA9qKT
         R/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091495; x=1757696295;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmXIgGMHBHUiTDvtQmKV71St2+q0K6vgTJPlvNkD074=;
        b=c8o9g8wfz27ODlPDGlnC2i9bNiZd00tlYGbLWs8y3zX4r0IlBr2K5H71xqjuTCnNTP
         GZLuTOP2M1H5EMyqd9RmM3/KqlKUY8Ynk5MgmE0pivT/R2PN1l7ggEedAst1AozDvfx1
         qsNbINDbUPUfNPfY3U/sHvq05HkVAnzHNxUv/B/sre1LBQ0egQFep/Ceb7WV94AMtWLs
         3Ka5Lfo3vE2869T/BRWuOGmHlBdIUHW4J/6qAa24gA4ujAzk/Jwa0dl42+it/iHM6oxP
         uOP62w7X2pe6qnrbscdH0iGPzfvMfmmw4GTq86WalyQSwD1dXYazj+W8ccOScuetNK6n
         dffg==
X-Forwarded-Encrypted: i=1; AJvYcCUjjz2TQEGHZUHY9tpkU+gkXQJBBZeGFb/5Wuz+h+xVicgg/L98Lna5Jenz8/ucAteqSPIJuCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHg52k218TBrfFlEhEbWtfWG6zAYaSvnCLGDlA3nthFQxc1cx
	VnCBLI/pr5secdvhB86cPx/W4GnOiSZLKxPOvTSvAeYDbhsl5Ur8wigFnI81LsJ7lnLnWgu6x51
	P59E7UkIraq5cAA==
X-Google-Smtp-Source: AGHT+IEJZ5i7tziENZOy7aQk7arnZvItIbkVpIX16c0MtARvNR4eIgJl9gr2cNzAyOOlBdkCQM7OjE9B0cwtbA==
X-Received: from ywbcb9.prod.google.com ([2002:a05:690c:909:b0:721:1a44:9477])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:360a:b0:71f:ff0c:c95a with SMTP id 00721157ae682-722763ba371mr257526597b3.24.1757091495250;
 Fri, 05 Sep 2025 09:58:15 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/9] ipv6: snmp: avoid performance issue with RATELIMITHOST
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Addition of ICMP6_MIB_RATELIMITHOST in commit d0941130c9351
("icmp: Add counters for rate limits") introduced a performance
drop in case of DOS (like receiving UDP packets
to closed ports).

Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
storage and is enough, we do not need per-device and slow tracking
for this metric.

In v2 of this series, I completed the removal of SNMP_MIB_SENTINEL
in all the kernel for consistency.

v1: had an issue : https://lore.kernel.org/netdev/20250904092432.113c4940@kernel.org/

Eric Dumazet (9):
  ipv6: snmp: remove icmp6type2name[]
  ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
  ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST
  ipv4: snmp: do not use SNMP_MIB_SENTINEL anymore
  mptcp: snmp: do not use SNMP_MIB_SENTINEL anymore
  sctp: snmp: do not use SNMP_MIB_SENTINEL anymore
  tls: snmp: do not use SNMP_MIB_SENTINEL anymore
  xfrm: snmp: do not use SNMP_MIB_SENTINEL anymore
  net: snmp: remove SNMP_MIB_SENTINEL

 include/net/ip.h	  |  9 +++--
 include/net/snmp.h   |  5 ---
 net/ipv4/proc.c	  | 65 +++++++++++++++----------------
 net/ipv6/icmp.c	  |  3 +-
 net/ipv6/proc.c	  | 91 ++++++++++++++++++++++++--------------------
 net/mptcp/mib.c	  | 12 +++---
 net/sctp/proc.c	  | 12 +++---
 net/tls/tls_proc.c   | 10 +++--
 net/xfrm/xfrm_proc.c | 12 +++---
 9 files changed, 113 insertions(+), 106 deletions(-)

--
2.51.0.355.g5224444f11-goog


