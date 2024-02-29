Return-Path: <netdev+bounces-76141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005AA86C7F6
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DB31F25108
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38A7C09D;
	Thu, 29 Feb 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uhv7hnZb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF47B3F5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205777; cv=none; b=IzXyj1z7W3vijCFpcy0V16/ftK1C91xgA6haB1LUMi6FGBHE9YzDIvtN51jgCqBsngpX1uLumBMU/IosHTjFRNesuZRcQwM6e9e0EaLrQbLhizVoprWNw0ZdUc2ev6L4xctp5xZauY9M6XGzu0qID+neeLvGLpR0qqhSGw6CM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205777; c=relaxed/simple;
	bh=RebOAeESu8vk9mDEejPUXaFtYjhqPjJVTIwioXit3Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvedxZaZK8zAZ/CV5q2R4Z0F5hUrJiKN5n9dv6FQk6554AMG+lRYecz660aEKlHQKC/dftlA5gFzaD6ZSXl5t5h8Hrio/4J1MLIwXWInHClIlSTyGeqCg188fJrgbx1OtKhetohMJyRlTtxXNiRWN/yTZBHI9JR7bDce7p0dhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uhv7hnZb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709205774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SI2LowR+dJN9TaviudqHADPmzH6GAOMcXFFwxN6WP7c=;
	b=Uhv7hnZbm4GFlcgbQqI8Hwa77WJwcY5tcuzsMXQxBNeQkxQa6tbAEPI/QUq1SJvCoMgSDW
	9ahC3N03dQX8PVJ4jcyJP2O1h5Ivv3Sea/Lfk6+tpS44imnpeA+H23A9eAwpAlx6ecHpjU
	1IeXNkU36Mwcod5T7IBFBcAXN+LqzlM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-yVle_nWyN8mLAvKs25YPbQ-1; Thu, 29 Feb 2024 06:22:53 -0500
X-MC-Unique: yVle_nWyN8mLAvKs25YPbQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-564901924f4so691794a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205772; x=1709810572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI2LowR+dJN9TaviudqHADPmzH6GAOMcXFFwxN6WP7c=;
        b=aSIeYLqRBFrBFn3wwFH1X5N9BfrbgisEQGrdYhcEeQqAEJt2GcvSZFbDFNkiUqF0cW
         7kXWLKnrZ14e1CIVSjPF6IpnAvohcINOVAVWcB9/QYw049U3wjYE7zL3xylJlnXWzuKl
         82kNFqhocaB6VixWyactfudSgGPcmznNcEILPtslneoyV/ciffAabIsXjuIjTLGtaZpz
         9xC2PsKX+h0Sdr/1NXZnJp/5dHvGA/64FIQm0V3x6FFWMGCnYGmyJZZZHNRA89VZ2GNH
         VGsTGCPuba0L8HnxI7vDBLdwY7BN8qbX6wrvOwEihf1s+mKwe7EJVsQNBDSKEms4Nmct
         Cexw==
X-Forwarded-Encrypted: i=1; AJvYcCUxrCfR8ynDcYOcVgxAwyNElViNUs83HPinWKiW0sbpjIXqhnuWAlvLKMI6nzUtnEopG/M7C3ih9VIlCknJz+S9ssiL0gr0
X-Gm-Message-State: AOJu0YzNYNKx+IBu/SNyKFy3I5de0HsLAJZL5C5r7AI7jsMR6eaq40+Z
	1AL3W8HWJ1vnSIddxFHaJLLTgecrvyLgSkCEDU4Hy6BwRlqqx+Y8xt8bqg0VntFqJRP5p2c5m7S
	zpqVB4pW0yBKNczeF77PsBhh1Orb3THEAZPhoxf/EFrCW4H+0H1V72g==
X-Received: by 2002:a50:cc03:0:b0:566:aa2:843f with SMTP id m3-20020a50cc03000000b005660aa2843fmr1338084edi.10.1709205772302;
        Thu, 29 Feb 2024 03:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn6RoEGZbrVw6NB/H98G22Hl9bIXwctY1/tC3DoZ8VQ48rw1GAkvFrnvxLiK5MXyGctUfmzA==
X-Received: by 2002:a50:cc03:0:b0:566:aa2:843f with SMTP id m3-20020a50cc03000000b005660aa2843fmr1338070edi.10.1709205772089;
        Thu, 29 Feb 2024 03:22:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ds13-20020a0564021ccd00b00564da28dfe2sm525904edb.19.2024.02.29.03.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:22:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4A842112E804; Thu, 29 Feb 2024 12:22:51 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Thu, 29 Feb 2024 12:22:47 +0100
Message-ID: <20240229112250.13723-2-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229112250.13723-1-toke@redhat.com>
References: <20240229112250.13723-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The devmap code allocates a number hash buckets equal to the next power of
two of the max_entries value provided when creating the map. When rounding
up to the next power of two, the 32-bit variable storing the number of
buckets can overflow, and the code checks for overflow by checking if the
truncated 32-bit value is equal to 0. However, on 32-bit arches the
rounding up itself can overflow mid-way through, because it ends up doing a
left-shift of 32 bits on an unsigned long value. If the size of an unsigned
long is four bytes, this is undefined behaviour, so there is no guarantee
that we'll end up with a nice and tidy 0-value at the end.

Syzbot managed to turn this into a crash on arm32 by creating a DEVMAP_HASH
with max_entries > 0x80000000 and then trying to update it. Fix this by
moving the overflow check to before the rounding up operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e7..d08888e5f994 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,11 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		if (dtab->map.max_entries > U32_MAX / 2 + 1)
 			return -EINVAL;
-	}
 
-	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-- 
2.43.2


