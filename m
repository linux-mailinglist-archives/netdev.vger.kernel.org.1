Return-Path: <netdev+bounces-100845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4698FC44C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D680FB2A41F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7295A18C337;
	Wed,  5 Jun 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBxa0nEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304F18C355
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571760; cv=none; b=XWDUs2TJKpaZ6iI3bwRAaQ7JkMBuPulMtx62ok9EeTklcOEU8H9sFOPUo/p4vM2k2W8yBThsACVpjHsWGftq54iYtot/4A6btDG/9OMqMHEsO+fhpdJiXZ5jyIotzT02yvDwwoKkggMXiZFveW1tIE+W/YVVzyqoxkFYCCGkJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571760; c=relaxed/simple;
	bh=0dRMYl1jLA3P5+K/CiSvxRg5/KLEXOS0eVkyFvSUzYs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VEhikqZT5j5pXqbuN+h2zzbsEJTt33zUkypXNouRIHQZ1jY5uvj8iN+QOoGPAD334gXIJ6b2s2gwe2bMAuaxk7acPd1Xb234rqgRIDtcOqPcIDX72/KFHBd4MWsytKDic0toKZbvpetPVUZPHYTbucRLJ/hFh3a8AHeaWOTlmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBxa0nEC; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-794aeada1faso710062085a.3
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717571758; x=1718176558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JPO6//Ua7pFqRrR++Vzqmd3/qBt7cwC/060UIprlxPQ=;
        b=wBxa0nECNdza7aKnImMaQqdkqkyeH4FRRwCn1iSfBNITPTudAF4Y9x5q/JxfVmlFp6
         y+Y8Oh6uptDQNzUxAP3CO6yj3aLK9lmhLHxfuE2hhM9a0QgapbM7Gtqmw/npYsjVTj6l
         1yDhbYfTT5ak+jJ4DVEZmOJIXinLfhAAbZQWGq/JlABDZlXYS67Vwxt2aNycbSpA0EM1
         RWcP5cLFKLjMvRCz5jjma7IDOhhtoGkvkh2TpRGl5ggbt/zgCbiMnYOIEdea3wMu617C
         dXsv+kZSgUaLblMipSQCes20Rs+oAH5k31oRtvz7Y1aQthSjiyiIMefDBXMPXGXvazXv
         8qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571758; x=1718176558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPO6//Ua7pFqRrR++Vzqmd3/qBt7cwC/060UIprlxPQ=;
        b=Z4mrg06BBOw3ogHLeN/tsy3H8ZzTSHaax3CKjfjv/5g6Ts3T84gHpKx18HSYi2fF/5
         oD43ZFROgRReEtvQbzK7xMOW5MwdLtuh8zR7LMW+oTpE/g533j4Xm7cOLLl8efn3fkPL
         IJpsveD+0sCrL4QAmSrzwPCpPs+yrwbMQuQg4bsGxiaVOOQtz31Ka1LUmWxWPzSYeW/S
         8KDEtdzXNJ/zHEzyHbPF5sRlOjna1Rwx2zQD7CVxI2Ozrw3V9ELWtfGci69cSYsL/tw2
         SEJOyRyKz2g+mw+PjGtIvtUEmGcq2XSEa3dX2T93rhd0AY5XQ4J71I3/FYjGajYJ0bem
         5Leg==
X-Gm-Message-State: AOJu0Yx5hRGPunSk0V848BsfOebPmnDOOz0jm4SoAxB8u2ItEr0g+hd8
	61xa6vmnfFwMBUsSCSTdrm5YTdEbzERXsZdlm8cgYKxTGYhrRVQ1+bkykdCQ3wpdqsRv0zraaut
	pz3jitFIdEg==
X-Google-Smtp-Source: AGHT+IFpwFTvFyPVG/YsiPuISItKsYH1lRxOKloNp5poPu0V54ccJb6aweCI+ifemQJZcaz+iDAIFohpV2DHYg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:40c9:b0:790:efaf:5bb6 with SMTP
 id af79cd13be357-79523fd26aemr426785a.15.1717571757743; Wed, 05 Jun 2024
 00:15:57 -0700 (PDT)
Date: Wed,  5 Jun 2024 07:15:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240605071553.1365557-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: small code reorg
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace a WARN_ON_ONCE() that never triggered
to DEBUG_NET_WARN_ON_ONCE() in reqsk_free().

Move inet_reqsk_alloc() and reqsk_alloc()
to inet_connection_sock.c, to unclutter
net/ipv4/tcp_input.c and include/net/request_sock.h

Eric Dumazet (3):
  tcp: small changes in reqsk_put() and reqsk_free()
  tcp: move inet_reqsk_alloc() close to inet_reqsk_clone()
  tcp: move reqsk_alloc() to inet_connection_sock.c

 include/net/request_sock.h      | 37 ++-------------------
 net/ipv4/inet_connection_sock.c | 58 +++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c            | 25 --------------
 3 files changed, 60 insertions(+), 60 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


