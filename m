Return-Path: <netdev+bounces-249660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABAD1BF0D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B6E130080CB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91D1946BC;
	Wed, 14 Jan 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zhw04clK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4B239E6C
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354390; cv=none; b=bVVVAeQoz0x22KvKNKX2pCWgQt266QOiKhs85nCgOG00DpOb0aXuSGuAHrRUfzUrp0l4TWyniEJHkP66ThJdTawAuhKagwTDzazB/nYlBfBkJwsgGBoIZnjDJrVcCe/uUTNSGYCHTJKmizC36O+aZSYoin7qv47rV7BynrdhNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354390; c=relaxed/simple;
	bh=4/RDkIXEaC7ebb/PMZLE7DU26Loe6p+5o2aK4clc+80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6r4CuWddbKq1Y3LLru7c2zU0keTszd7cjxuYmFwWDclWN+iluHK5L5xGBq9S1qvpBapibbZw+BZrPaaWEXnXn8L5pxh5hGXsbvFNu9QShfGMV2HoUx9sJezrzdR6JWRH3L5iyOBNHadsVEMVmVLhJRJ3idZ6kfT/JAGL6NkXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zhw04clK; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f542917eeso2694637241.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768354387; x=1768959187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMo06rMlppqTMC+QmirbCY56Rr9+/7J+WMgFuIXf5II=;
        b=Zhw04clK/hXKnLUhT5VoPsYAKjEVw94Nw3IL4YelFpcX/qiQvimczI9sRiop/OEOOP
         UOXoCw2/ilaNVlUHiV4pOABhtqxDurJymaCtqx1bOI7KMzshQTZXdDQWrLsJ1QhuMnCs
         /5+ces4j2sWHZ29NTQb1L0VfmSbK2YHVrhkF21RHbvuwDgUh7fFnhlaW5JpaEOJ92maD
         IaTo91ngW8cMgIPaw6cfJmOxRByvXbha+p54efpjeLVyojwLjdXTU2bhm62TONwbHEiC
         u2z1dp4apy/scRQHYZQ4yeqvQrXD8Z7xGwCm0hZeLkeV+3O5HiZfOs5Bv6SrS1TGAWyI
         KSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768354387; x=1768959187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMo06rMlppqTMC+QmirbCY56Rr9+/7J+WMgFuIXf5II=;
        b=q/cILf2Hkx76Odzl+W6xbHPhgcWtjlMiEeJEkmmq7DQT5rC8011RsJZZ7uZYbVvEGZ
         LsZAfgG0ouxriH/DccxvQARWAKbUXy1LAwgR7PCccaKRu6zs0N8WqK7e8cEruwOTDs03
         UmG6iaWDQ1uCqKUuoM7QPjPLFCqSYMrZfEt8v1sap9k+P1G5V3UcqDHjUIxytcTPsCK0
         zozBuNZKyCa2M2p3rqZwIgWph6cfIUVVAhWT+IAOptW+t0JtsqoPA1VTRrhU19emXGrl
         zly3L9m5x5fK9GFq4SOJhRONIT/vKKnPXAGPl6ZwteK4/ofrgYWfqsoffJDWyzmTwA4I
         Q2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUORUW/D9cogKy+iD3XfScUgGCHT/yHr46RwPv8lm5ab/jJLV5QFxrFgm2wFardkh1O5eKRDus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSg18d/QT7V0MvIzMjRGuQWJXIb04Whmil2Ih6W2Qchgqx9uGS
	13Zr1rPcPGz189moah3Vmd4xVNHq1UKe/mtdQ0UZzwovrgeWFezfhUMj1BY3EzXi4pmezXPuYMl
	nkQOMU67DQngsklHw2P3hvINANim2fW3irQ==
X-Gm-Gg: AY/fxX4fE/oBB4DpuS9xOusyl9BQ5Y7qHmSa1ltk8YUXqu9X649Zds6I60hEq2yKK0y
	JN0ixDNqqmzZ85/Q4EFCXJmhYKPv1SFKGzPhS3xvBvL6pd3clJhwDrqtCIojbQ3yWCVKYBZZkMD
	+Qx/Fmc7Fiox9imy0qrmAgPZ05ax5NgC2gm7dKzKW3KEdGQYN/sMnyZzkNEjLNHuilQlLLPAnil
	48eqfapBR1aZ4PYQwSK715K2aC+gUYDg6pImlqdNwOjrJY6S7JbvlZyt8mtdpWh8Yx29ns=
X-Received: by 2002:a05:6102:cd4:b0:5db:3b75:a2aa with SMTP id
 ada2fe7eead31-5f17f4a2372mr440740137.18.1768354387341; Tue, 13 Jan 2026
 17:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122003720.16724-1-scott_mitchell@apple.com> <aWWQ-ooAmTIEhdHO@chamomile>
In-Reply-To: <aWWQ-ooAmTIEhdHO@chamomile>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 13 Jan 2026 20:32:56 -0500
X-Gm-Features: AZwV_Qj6CcCyaVBZc2cjoFwcgu1ECBdYD4c-ySqVCWBS8dJSHHzcY3XsAgj7RAA
Message-ID: <CAFn2buDeCxJp3OHDifc5yX0pQndmLCKc=PShT+6Jq3-uy8C-OA@mail.gmail.com>
Subject: Re: [PATCH v5] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +     NFQA_CFG_HASH_SIZE,             /* __u32 hash table size (rounded=
 to power of 2) */
>
> This should use the rhashtable implementation, I don't find a good
> reason why this is not used in first place for this enhancement.

Thank you for the review! I can make the changes. Before implementing,
I have a few questions to ensure I understand the preferred approach:

1. For the "perns" allocation comment - which approach did you have in mind=
:
  a) Shared rhashtable in nfnl_queue_net (initialized in
nfnl_queue_net_init) with key=3D{queue_num, packet_id}
  b) Per-instance rhashtable in nfqnl_instance, with lock refactoring
so initialization happens outside rcu_read_lock
2. The lock refactoring (GFP_ATOMIC =E2=86=92 GFP_KERNEL) is independent of
the hash structure choice, correct? We could fix that separately?
3. Can you help me understand the trade-offs you considered for
rhashtable vs hlist_head? Removing the API makes sense, and I want to
better understand how to weigh that against runtime overhead (RCU,
locks, atomic ops) for future design decisions.

I'll use a custom hashfn to preserve the current mask-based hashing
for the incrementing IDs.

