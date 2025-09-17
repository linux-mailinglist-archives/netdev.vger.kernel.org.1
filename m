Return-Path: <netdev+bounces-223903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C101DB7C63B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7883C1898305
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181F308F14;
	Wed, 17 Sep 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnvEYXJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7453081D6
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097215; cv=none; b=Uh5f+L+r3kHL+Fo+XBSCE8vipzXzTtBAA6TwK+LtPEWL7Vpct3SUfcHirBAAp/OOwMEJ30MhXaysTTfj4JMBRP9fa8w0DHPUjaxKAvfUBI955sJhM/x8v9iO8BcC/ZM7ooIa7kFle074iKrGZqBx0Ieg/q0m95Yscz7FHsRxvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097215; c=relaxed/simple;
	bh=DvsldGskwe7bNZdCNM6b57h99t1SlEsl5eYl/1MgupA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UkDLLQelwvCj3IkZoQqDx3m2oJv/sqt9JQByp9J9BDqSSuX1uij/kcn5aSanYomce4Tyb2a6OFacqDe+HVSVyC1OyqKA7AqT/ZIQ5hs0/Y8XwjPpAZya83blQuQtypDhSPVfChGJqDWW4uCt54LYFfoOqTLT9ljw0ACVv/+ny8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnvEYXJj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77b91ed5546so701870b3a.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758097213; x=1758702013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plALJuwISe+CKBv7MdrVqcBAxbqlVW0Bn8MN5VSJY8w=;
        b=OnvEYXJjiKC/R6ouZzaWx2LziOUp8O1S/NAM+tsfH4HZLLAi9e39FhZV+ARyfwAk4f
         nrXCUVfaY1ANtRDscpqB3ix9cExDmeeoA9iFiyicWqRxtnO4ilSyCgAR9RXocX/RliSo
         cKlGXnaei0LMLQyehXr9sZXhv86RmwWgkoafqwdj6PMPZ80jrX6egENjHgwOeNgVQBvM
         1znvdolLigv2GhWOAAB+C+O1g1F9wrGxCJn9gE0KDJtCXvBwJXjjjTImUR6qPcA4ZKyg
         cNs35hDV5qquXkxD3kFeKbEH+j9vAtF0Hsn3KloIcuA/mMn2vy94OsrqMgkWASq4fqiP
         sENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097213; x=1758702013;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=plALJuwISe+CKBv7MdrVqcBAxbqlVW0Bn8MN5VSJY8w=;
        b=UdQZ1YvSMcmAsdguFxEObuXPl0D2IG2v9F8U3mf3jmHlTzN4B0VUqrbN6KXc76i0sP
         ALDddeAIvcToHIAEChsMgOVCy5wJp/4SurBGVZfMupmbZQrO5Tt/MCvPb4kq/Ms4C6Ed
         AXX5HawcbKPkRGjGbHpMjNZP55Sj7IxRfLHNp9pssTpE3Cv4Q20sNFjrjVreWvEHQGRD
         IGgfO2qxfBU8ii1AI7hlS58Rzr+4CtQM6Tc2bZo1xfSVa7mwHjySFASN0zzk5EUGigyz
         sfRcTPdYTnWGApBVun/vT67OYlEBhNJqHTovm0gRzLi3ayMbaypTbwxuUuuR/cfegnDC
         l7zg==
X-Gm-Message-State: AOJu0YxlV8R3ek96AtBkiZrcS3QFC3HqMnp6fmNpvbLZNfMbfiPo0DaQ
	0FGh7ahQ4D2OuKOiCvPJU4+1/rK1NSlNDK+QLnb0U2YORdlM2ac6yPPX
X-Gm-Gg: ASbGnct5MGdxaB6MolHUq1pohnq2ek7uQ/WSPYnPG0sdk+Ja48a1TzEOrQXgr+GjOC3
	LQJSq5kCbSWP5QJ8/m8P9CxG7V1i0k04CcTvo0a8o2qEmTi1RShxTj7BhHEClnq2iw6VzhZI3Am
	LkfIqg0uJa5OgFZx/WfcKKEmcN8RhkzTNZ63sKwLptfA4CzT7Q653g3VIZw6fExNJdp8Ov9YvVO
	iAzDOp4uUw39Df5eLL5Wn1OcxGSE5PIt6v33eNxD6xoftgSkHrkMfeVT3j9qAjeIGg+wPVExZ/8
	lf6sa9scYjDxlykCMCUY7yWYlxzxvLQFoe4TB60trCSRNQrAND3VEwhT7AheZzrdtte8jPfbpY9
	A8txv4qReTWCLARFtJdqjYq36pNEoEmxHht0=
X-Google-Smtp-Source: AGHT+IGXTqXi5/oKOuNJkyWQroVyhauuyjO0/0kVNO/Ok5QEBRkeeZWwJb8nEKAeBneaygeEj1Byhg==
X-Received: by 2002:a05:6a20:1594:b0:240:1ad8:1821 with SMTP id adf61e73a8af0-27a9586ba61mr1835791637.19.1758097213513;
        Wed, 17 Sep 2025 01:20:13 -0700 (PDT)
Received: from [183.173.12.7] ([183.173.12.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776158bc82fsm14818579b3a.23.2025.09.17.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:20:13 -0700 (PDT)
Message-ID: <5724b1b3-05c2-41fe-8f5c-879b3e6fd318@gmail.com>
Date: Wed, 17 Sep 2025 16:19:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tuo Li <islituo@gmail.com>
Subject: [BUG] net: plip: a possible race in plip_preempt() leading to UAF
To: andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 boehm.jakub@gmail.com
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

While analyzing Linux 6.16 with a static analysis tool, I noticed a
potential data race in plip_preempt() that may lead to a use-after-free.

Consider the following execution sequence in drivers/net/plip.c:

1. In plip_preempt(), nl->connection is checked to be not PLIP_CN_NONE and
nl->port_owner is set to 0 at Line 1184, indicating that the bus can be
released.

2. Before returning, an interrupt occurs and plip_interrupt() is invoked.

3. Inside plip_interrupt(), rcv->state is set to PLIP_PK_TRIGGER at Line
949 and nl->connection is updated to PLIP_CN_RECEIVE. Then plip_bh() is
scheduled at Line 952.

4. If plip_bh() runs and the parport bus has been preempted by another
device, the subsequent call to plip_receive_packet() at Line 376 may access
released resources, leading to a potential UAF.

One possible way to prevent this race is to hold nl->lock while updating
nl->port_owner in plip_preempt():

  static int
  plip_preempt(void *handle)
  {
    struct net_device *dev = (struct net_device *)handle;
    struct net_local *nl = netdev_priv(dev);
    unsigned long flags;

    spin_lock_irqsave (&nl->lock, flags);

    /* Stand our ground if a datagram is on the wire */
    if (nl->connection != PLIP_CN_NONE) {
        nl->should_relinquish = 1;
        spin_unlock_irqrestore(&nl->lock, flags);
        return 1;
    }

    nl->port_owner = 0; /* Remember that we released the bus */
    spin_unlock_irqrestore(&nl->lock, flags);
    return 0;
  }

Additionally, plip_receive_packet() (Line 376) may need to verify that
nl->port_owner is still valid before accessing the bus.

However, I am unsure how to proceed once nl->port_owner is found to be 0,
so I am reporting this as a possible bug.

I am also not sure whether this possible data race is real. Any feedback
would be appreciated, thanks!

Best wishes,
Tuo Li


