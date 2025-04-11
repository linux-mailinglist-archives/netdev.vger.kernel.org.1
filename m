Return-Path: <netdev+bounces-181727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384ADA864DD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC02E1B84CFB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC9F23959E;
	Fri, 11 Apr 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="EAjHYXWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F05239094
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392975; cv=none; b=LHJj9lZc2yRc+lEy5nUkc7c9ClkjN8Bwb6VDfH2IVQSnx6zv7vY3L2UnZ6x5kdJ1nmx1faiP1gKaWDi7sQqmkAd1onXc8GuY0VdzkFuNZbqNUcDn9xug92Q3nCKpM345KyqA5LQWhSyn3914TRsqLfKKgdDs0BjtSjQ7J8XZRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392975; c=relaxed/simple;
	bh=4PQWKQhuFoEkUrYkIBOyAh45CPPAxPU1Y7NpU7sobEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJ8TMpf+/hwlu34kKJnwoDiXxj9twMRto+5GcvsUxAklIvHuA0IsnRC77t/G2idUlM8jtp4kRvB6UQqjfiQKqYRtZvdLKMlP1sAOioqScIaT/gyhgovdamOWfljSvW78SJBZowZIO1AyvUx7cXyLvIsHsQxpPKJtj8sgaoixxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=EAjHYXWs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225887c7265so2196175ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744392972; x=1744997772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBcBIX3JQ8GQQdeXRVl8BYiF3TsEhn82t3tctSMoA2M=;
        b=EAjHYXWsturkEu5QpXGCK9SIDzPPZendoXQpkaOjIGfq0DJhFcn9q4xQnIbdwQiWpy
         BthemN/isiZxJv6inC0OPQCo/bAX6Aj8OVp44hlkFd0sw0n0Q7lwDpQEPV+olBrUDRtC
         a/LEK9hbTDSV8h6hXaQ0FSa0sWM5lnwGneAXfwIwjjKe8Y9N6RcyNFWl7L1Ejem+J/Kk
         KQxmpPHv2s8EAoeWZU7iSoDOOJK0wzKpB8MNVgv96lldKWjXWeOzp3VWxWgyhbD13xiL
         Lh4m08z1PqGJ+deZL6wnC6zv6xUMZeLoxcmAvwb1UbKwHBoH8zy87P5010KtPaYGAWhy
         15lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392972; x=1744997772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBcBIX3JQ8GQQdeXRVl8BYiF3TsEhn82t3tctSMoA2M=;
        b=rkNs1rm3gB6m3hYNC9upFGBNcffYvPcNMtS+MqLTMlW6jnAaj17xugOpqjWeQh+tMG
         yanqzBp/M9ia/AIO3TfcvUkS8og/vqXbfjLR5O9bkg/CchUVoaRcEuqe933nax2mNEI7
         874sYy9a/5pFIqf710kkGjRbIgNtPm+Rrc6E816jN2wsnhbpvAmLVBaYVVbi5ycsxISy
         olosotEtqxG+g4IfSvU+YabiqHuUOg/9Dux2240+Dmj2EOWVpzISVJi65F8EeO4AH06B
         7dCJccYsBolWbaYdRlIoQP1gDtBaiRd7c9g9EtKI5jEJH8DjJ/PPUwlhnlN6bUJd0Rvm
         6sAw==
X-Gm-Message-State: AOJu0YwH9Mu82JpzP1lD54avcxASgh5h9h5FD3oeaUh63RiO2Agc7LYJ
	paBejDlmjAYgcblVS31vkl4nkdqKuqLDoQhZsWiYgecLuMS98EybGzY8CTpZJAvMK6aHMzO+up4
	pDtk=
X-Gm-Gg: ASbGncvJ3iW1IrdvDiBMxBwHO7aQwS9HqvEUz1jAlfmWV6Q1SCLb8fynRpOu9fLZMEd
	YxmfvjgN4GchCMrbV7SkbY/5SCkfyN5von0Ga1pYAw6Otbq+TMiaANrRhBYIZjTsEKua9feSZcr
	8fo934coPtim2zH+oHYzKkSGGT4v99K4hHlFo7X+R0xZWHQI/lyUmN+VMBpOdYUWYxE6Xk2OBb4
	gFC7BknxQkzEPsi3hfZOmzuqts8eqCb3h4UiewycJ+t6QTQPisXkdds9F9e1BQoggztOuyTAMmi
	OMhqTJKJ2qZ0n3VhyLudMQ31n4m+Og==
X-Google-Smtp-Source: AGHT+IEu4ySQucLjZTAosKj7hSH92jdMANqWvb5el3ORTT+M8uia+P8A3IX1NOAfnrQPNDtzLK7DfQ==
X-Received: by 2002:a17:902:ea01:b0:220:cddb:5918 with SMTP id d9443c01a7336-22becc4da03mr13386755ad.9.1744392972477;
        Fri, 11 Apr 2025 10:36:12 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:fd98:4c7f:39fa:a5c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6a50sm52317725ad.205.2025.04.11.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:36:12 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
Date: Fri, 11 Apr 2025 10:35:42 -0700
Message-ID: <20250411173551.772577-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411173551.772577-1-jordan@jrife.io>
References: <20250411173551.772577-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop iteration if the current bucket can't be contained in a single
batch to avoid choosing between skipping or repeating sockets. In cases
where none of the saved cookies can be found in the current bucket and
the batch isn't big enough to contain all the sockets in the bucket,
there are really only two choices, neither of which is desirable:

1. Start from the beginning, assuming we haven't seen any sockets in the
   current bucket, in which case we might repeat a socket we've already
   seen.
2. Go to the next bucket to avoid repeating a socket we may have already
   seen, in which case we may accidentally skip a socket that we didn't
   yet visit.

To avoid this tradeoff, enforce the invariant that the batch always
contains a full snapshot of the bucket from last time by returning
-ENOMEM if bpf_iter_udp_realloc_batch() can't grab enough memory to fit
all sockets in the current bucket.

To test this code path, I forced bpf_iter_udp_realloc_batch() to return
-ENOMEM when called from within bpf_iter_udp_batch() and observed that
read() fails in userspace with errno set to ENOMEM. Otherwise, it's a
bit hard to test this scenario.

Link: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 59c3281962b9..1e8ae08d24db 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3410,6 +3410,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 	unsigned int batch_sks = 0;
 	bool resized = false;
 	struct sock *sk;
+	int err = 0;
 
 	resume_bucket = state->bucket;
 	resume_offset = iter->offset;
@@ -3475,7 +3476,11 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized) {
+		err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2);
+		if (err)
+			return ERR_PTR(err);
+
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
-- 
2.43.0


