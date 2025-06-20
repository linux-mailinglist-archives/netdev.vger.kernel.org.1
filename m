Return-Path: <netdev+bounces-199750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037CAE1B47
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D492E4A473C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1C28B417;
	Fri, 20 Jun 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fv6+lj1u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63727FD72
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424240; cv=none; b=Lo/mFXWJ5h97f6a++qp+V1u31NQ4l41Vz/D+BgAefYBrbK6wtQigGuM8jPDLbKHkciAPp/25OvyFxomPIUo6ACo+ARJd62cTgc2PVoacwDYjPRzhxTU8M0jBe1eggoKek50wL3Cq4ipg2+Odv/AmzghTQsxd+fkx3vmCV2qe35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424240; c=relaxed/simple;
	bh=lTPPKqsjRUZhBLRfXVcXfzKpDXjJLav32kNwPoV+o3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9zZAk43JcbxU5iuN+vFanTaHfspU0Zwr270y8AaGyZlYmBhkpSpwaidTxMgdWIXlWquh3YnbpaHG9jKPF+XgMgwPpZiEs8rW+gVnjiZQgkFlAueSsBB1JX7lSWNCkYOScsuhzDJVR1hXtmu/1rAHMwsKKqK0j9Leiq5HBGydjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fv6+lj1u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45345f1a1aaso305585e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750424236; x=1751029036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcQf6CBPY3ZD6ktFmPaCJ7ntO/vY14LwSb9xlORB7bI=;
        b=Fv6+lj1uLKWUKIqbDE2ahUKu1GR7eOpSCtb4UZi9ZhZN41HgIHxXkVC9Z+nyefvg9C
         3v8K70p3LSv9RgKCRltIiuCBMhSrh4jTyb04La5y5DaqEV4kHnck5S2vnXTllP5LR9HP
         WRfFHa5To5gs7cylnTvTbzCnXnzz9Ofkdoonmv/7k3oCEzrD2gwofT+vV2fcpPfoELqR
         vp4POE4jXpcxQE4rRQ4Tq6eWfDapm5iFIejO1gWrP2MZ1J8NNtRCCZ9GihkxawZFJfTh
         fPax852U/Wj+O9Fh7WXEEU77avkgmGUnrL97XEptL46siES1A8YdRN3NNd6sPOLsYFYg
         96sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750424236; x=1751029036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcQf6CBPY3ZD6ktFmPaCJ7ntO/vY14LwSb9xlORB7bI=;
        b=eHwI0hB95VMf1cRwc3T1tCz4tQqdNqlOepJQZ7aTCtKGXfPCBy2gXp56O9KQMfkHoy
         31UbDCUFtaxYihJVT9oMR0u0FG66sUij3Z2BdQmN0ax93H52w5OhsLrRGJJw13pUkXzL
         g/LC7rI3j4xROJ7VGOjJavrNg3SqHzr7QxvYjwC0F0ZNYI35nizPK4+9M4O5noysTcrt
         eaBWvU27F+cAI8CEjjfN/6lDySdlkWyhj4gJC/X4DPKF2UGASr4Rhu5EMMCJ1wh1U9Q1
         KvQPlnNbkT2Jtf3qLSZB19TIeuwlUEBWOM1FyN3WWUrmSFp7c7gtuoAPDz1J8PWo+kYX
         TAmA==
X-Forwarded-Encrypted: i=1; AJvYcCXddlzazH/bVFrhc4kQfAgrHEwFArMt1cTFZSeisEG7i8fxAZT47rcDIKeN4SE8NdLPORhIh6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FPVYs3DktcFhrTkgG2Y206LAUD0N7HbxViJmufCgm6HAMgAB
	mwPi6EbA6TmBYOUpGQYWQH20n/jqjwHbtLjiJNEHX7dP1jGi9rqDI5Q/ItOlAlbEKW4=
X-Gm-Gg: ASbGncuRCnTuo/Hr0u9VOHyGWPOxtrpDietL1o+1oFrY7AYlqNM6QSuoeJuLm3F2Rq8
	MmjaMxRlSoxEr3MckKaMBUtcP7NhJqLYb5G6fr5jC+ZFsCOZGETGn4LMPyXO3U68kYx4mV3Gdh8
	pn8qkuWmoY0AjYDE2gKFArtuGe0/aXN4csT9snmYAfmXa3kZ81nb5bOEtKH2sRcHL70g1jUv271
	DmVSVR9WE36qlTm1/AVCShyjfLZ8fvswJBZmMJb40/vKdUNKa0MgpIp2yGkY5VWzWMoIt780fk4
	2K2yKEp9mReNRe4Z5I8wRm2eT9z6AXbgMHnNSgGrWK02WvqQ7EZRFSBlgiH2oIMyLTt9UvmcQRc
	ElYlQ0uhQ8VWlOlnox8sjv+QvXfXQMRFhNx0GnQMerBxZknGeND+A
X-Google-Smtp-Source: AGHT+IEHbW1gi7tKLAH0rP+T2bleVijcw5AagqiUirX0zCprzVmiF7q9fNFxn6Dgee94AnNr3udkCA==
X-Received: by 2002:a05:600c:3143:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-453658bac2cmr11147335e9.3.1750424236123;
        Fri, 20 Jun 2025 05:57:16 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535eac8c16sm58113845e9.19.2025.06.20.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:57:15 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP])
Cc: David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH net v2 0/2] tcp_metrics: fix hanlding of route options
Date: Fri, 20 Jun 2025 14:56:42 +0200
Message-ID: <20250620125644.1045603-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I ran into a couple of issues while trying to tweak TCP congestion
avoidance to analyze a potential performance regression. It turns out
that overriding the parameters with ip-route(8) does not work as
expected and appears to be buggy.

Changes in v2:
- more background information in the cwnd commit message
- fix handling of initial TCP Slow Start if cwnd is clamped

Petr Tesarik (2):
  tcp_metrics: set congestion window clamp from the dst entry
  tcp_metrics: use ssthresh value from dst if there is no metrics

 net/ipv4/tcp_metrics.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.49.0


