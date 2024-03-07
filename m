Return-Path: <netdev+bounces-78399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A9874E84
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E6E1F23C45
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169C12A153;
	Thu,  7 Mar 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNG2NALc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB0129A60
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813028; cv=none; b=U+SjGNgUYqxB/kyIPSBH4iNel2xNO6fi+Rcq5b0YwcV1hliUHnGcv/qQhNsyCPbP2aIKR4Qfac8O8hURQpV8KncWI8/Du3i8CnKI5DKK19UDNwJdj442bC98XZq68b7O+RESsyz79xNsTK8Ykxs3LNCFhc5lVF+hjQ5PXV8/ydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813028; c=relaxed/simple;
	bh=VabsikQF0k0IQ9y/QlLTfmY6orqjAdYHABK5Gdt7a3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWQSG2gHMieTsYsVrMg/y2F6U/VhdUImvZmd9YNlAbKYJObfqbLUxwFut1n/BnpsiGxq0DoVr19B9BK5ZcZsv8pE5Y1c9M0fFPbaJiYpxnnnsLC50x9zItc9YZ1dMBbp9yfxoI9thhV0yT6VWd+UFwbc+DR78ewxhGsG8i4SH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNG2NALc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709813025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDEgj1V2cjc85YaJq6bxK4Rqtu+HuPgKUTy4qIFCidM=;
	b=ZNG2NALc7LflRWJWXa06kUGze81oeM7VZ2yuYSssb+VaY3dny5MQQZZZzTs+0JgZEW3kab
	27xX5tSpWILsCAAPshcVeJaK7G6YWQHw55Y5QLwyoTUq8vN45r/b55Merp4tPF9fLQqmbr
	oBiKJIcT07PWQTJ/V1ic4PvKZDGKerw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-RKLkecztMyi8AxpiFL_0kw-1; Thu, 07 Mar 2024 07:03:43 -0500
X-MC-Unique: RKLkecztMyi8AxpiFL_0kw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a44d0cb0596so57890166b.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 04:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813022; x=1710417822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDEgj1V2cjc85YaJq6bxK4Rqtu+HuPgKUTy4qIFCidM=;
        b=tNUqhnTvuJA5y6lV4GQyiNv8xqeMpj2m6nVxUs5nusgyUt0Ajt21Dff1p1FjZfdUqi
         JgVje7t03D6uPhizlBBRz7Qy8MJXYEMdVlkmTzuVMOLxXO4BWLA0+FF1sDh+ys+MwmXd
         aOP7KTpoDPG5i0kKfy98LyBeQ00XEWiiZ+AJGe7n0MuBPVSjWcDxOeQclkwPFdw8bAX2
         du19y3IestRQ7NcsTovVcAHQZuvAqBU20EqDl6inNBl2ppKQuCMIuJekXfBFSPEhC9aU
         WB+AeooecaeoPf4xPNZEtfmdal5dTDRA0GaoGnGsF1NSxSw4Du2E2X8SQEA19QDBRfnF
         2KUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAM/8ahSksCAtqr4u5DAolfXGNGfbgmh/m1/KxLLqt9k807gByqEnGTw1ULCuJiha9FGa2Q1BVzuPitQDNThvB1VuKDbP9
X-Gm-Message-State: AOJu0Yz9BGPddY8SzWdv05W1BRpxZsFaDYEgpU5Ji7rJHD4tBaOhiONy
	K3J6rrM58cig90QHizCysE0PZowdCuYvzXMI1xcbcvc2zK/cr7+/rjru3pW+UaFBt2AwXYDpx3w
	b+TzzCMqLj5A7z9XEE4VhJbpbraMcuCgA+931r01WXPq8u/UryUf0Jw==
X-Received: by 2002:a17:906:248b:b0:a45:ad00:eade with SMTP id e11-20020a170906248b00b00a45ad00eademr5150167ejb.57.1709813022430;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5RvWzENV6+01U16kQloAf54kfAnKlJDOtXE0Bxsl6gER15VHdJFNSFH56K9QJGhc38Na2Og==
X-Received: by 2002:a17:906:248b:b0:a45:ad00:eade with SMTP id e11-20020a170906248b00b00a45ad00eademr5150146ejb.57.1709813022167;
        Thu, 07 Mar 2024 04:03:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bx16-20020a170906a1d000b00a4588098c5esm3486946ejb.132.2024.03.07.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:03:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 780B4112F378; Thu,  7 Mar 2024 13:03:41 +0100 (CET)
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
Subject: [PATCH bpf v3 1/3] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Thu,  7 Mar 2024 13:03:35 +0100
Message-ID: <20240307120340.99577-2-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307120340.99577-1-toke@redhat.com>
References: <20240307120340.99577-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The devmap code allocates a number hash buckets equal to the next power
of two of the max_entries value provided when creating the map. When
rounding up to the next power of two, the 32-bit variable storing the
number of buckets can overflow, and the code checks for overflow by
checking if the truncated 32-bit value is equal to 0. However, on 32-bit
arches the rounding up itself can overflow mid-way through, because it
ends up doing a left-shift of 32 bits on an unsigned long value. If the
size of an unsigned long is four bytes, this is undefined behaviour, so
there is no guarantee that we'll end up with a nice and tidy 0-value at
the end.

Syzbot managed to turn this into a crash on arm32 by creating a
DEVMAP_HASH with max_entries > 0x80000000 and then trying to update it.
Fix this by moving the overflow check to before the rounding up
operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e7..4e2cdbb5629f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that first
+		 */
+		if (dtab->map.max_entries > 1UL << 31)
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


