Return-Path: <netdev+bounces-77675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D8872980
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035CFB30B7A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612E12C52F;
	Tue,  5 Mar 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+wtPBUI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C312AAD1
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674307; cv=none; b=nuHPG2rB01QWuf5Sf6MdPfZUwClsEdAmXzIl0xSoOLwPYsEHGrUAd7O4mLfQAY3XNBl2d9Tx91mRh1lH4l40UMqeWsm5sarqrHxGpyTbQbyqU5PlZ79wVVGYE52KlaSgG8j8GQJL2eMv+ecy1tKNsa0KfQKuQZhkHox0i5vapwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674307; c=relaxed/simple;
	bh=c2tBWwf0cMAGCU9YX9FKO5lYX87Jxw0bh6LWR+bye8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Brc7D0m7FvzCnaPnW1Ziq+MLdSx6xK0JgXpVcn9UhPrYaAIgGuLYa6Vhu/znwguIe1NLYQ9hFm0LPV4+uY7MEztPHCXqloQi/LdlRPHXe+uCJWvgoVQD32uLZapAlzmPWbFogFpCDiurqDGrzt3EmVyKfMFSqnaoSBWUPrDSkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+wtPBUI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709674303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lVAdr6UkmCrZ9tYEoFXnHSP62RXZ64wDxSuFsnLt/kI=;
	b=Y+wtPBUI1X16ly2wt9K2DAOwGgqYva69NjYhe09Yq5l0B0a140X3QDZxkqTZqcqMdNkQfs
	QG+a+auq6JHpag5CNSRy5hLTRUGnccoPX3LYZGjzYndQ4L8OMZwyj6o4vUwrN56gMsu//r
	0nwMtDuq53mO2KzakI+ytJX+DKWgJCI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-Lrl5keEiOiuwuN90pGBFKQ-1; Tue, 05 Mar 2024 16:31:42 -0500
X-MC-Unique: Lrl5keEiOiuwuN90pGBFKQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5670ee87ca4so648837a12.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 13:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709674301; x=1710279101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVAdr6UkmCrZ9tYEoFXnHSP62RXZ64wDxSuFsnLt/kI=;
        b=mF8RuFPRNk3ZMba1E7+9b3HnU3L0CKrNoC7zXlvxikN05jqhH/xy9xIQ6RKUcdI76N
         hFIZ6apxjAkhTXFeIwAAk3Lxgz5oLrCanuSu1SZCww+uXnejL//dF1qc4ecYvJx1ZEjz
         PM4ZE7aBC5Wsqm0/9syFLmsPB9Z0lRfOppZJ23vuS/nuOsWCRhzQHOOa0G6BQxDvIiIA
         LJVmAC4vujiPyE/f/qBorYq4xULCVtoOGXFs6ir1b4nr9bnq67q5qYTFOKxm3EjqElm5
         QFDrJQkmzM9ByoYl74hMGqTVZYWwEsJvvNv62sWCSvTigC9P7cj7c2Ezt7Hff9uZJNSG
         dfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrhAGYDbLL6zYpkuEm4Bgy5FEcFd58QRVaKjTX7K6gPj0Fj1dETZNWd0bCvTAawaIx7iIDJSfggwhW4eYs3Ez74HJlTiI
X-Gm-Message-State: AOJu0YxLGLuRRHi3Ph+FWHNef6BU5B0YlaR5SMWVMxn13wx9yPjdI8qf
	T/P8Y2PBQTAwciUgXf/urdJrwA77CZo+HCxqXaYogiGcdDcs6vy765Pqw1AmZYa3wTaP5dGdn7Y
	ZZB6j6GgVAJ82Nm8FswGNbjEcWoQXfNRR2ufc0PoisHHb+GNyk2BJrw==
X-Received: by 2002:a50:8dc5:0:b0:566:ef9:30ce with SMTP id s5-20020a508dc5000000b005660ef930cemr9515115edh.3.1709674300935;
        Tue, 05 Mar 2024 13:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLH7GBGYVTttFWYaJGYWfbMpRh7A5ohYnvL8+4jmjv8lp9MDF8S9pzKHdvJZCo4Y9hcs9Aw==
X-Received: by 2002:a50:8dc5:0:b0:566:ef9:30ce with SMTP id s5-20020a508dc5000000b005660ef930cemr9515108edh.3.1709674300587;
        Tue, 05 Mar 2024 13:31:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x4-20020a056402414400b005666465520dsm6244838eda.26.2024.03.05.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 13:31:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 92621112F008; Tue,  5 Mar 2024 22:31:39 +0100 (CET)
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
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias@aibor.de>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
Date: Tue,  5 Mar 2024 22:31:32 +0100
Message-ID: <20240305213132.11955-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running an XDP program that is attached to a cpumap entry, we don't
initialise the xdp_rxq_info data structure being used in the xdp_buff
that backs the XDP program invocation. Tobias noticed that this leads to
random values being returned as the xdp_md->rx_queue_index value for XDP
programs running in a cpumap.

This means we're basically returning the contents of the uninitialised
memory, which is bad. Fix this by zero-initialising the rxq data
structure before running the XDP program.

Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
Reported-by: Tobias Böhm <tobias@aibor.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8a0bb80fe48a..ef82ffc90cbe 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -178,7 +178,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
-- 
2.43.2


