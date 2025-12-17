Return-Path: <netdev+bounces-245223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7CCC9407
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF5E5305A63C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7410A2D7DDC;
	Wed, 17 Dec 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu7vhMYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954861F0E29
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995155; cv=none; b=mqUDxwgASuvdUCVbtGpHrj2YSf3bP/xHQcvCklcdpMvBn9wQWfI4Mp/0IpK9gbegQbPXYFFWsz5mTe+S5/Pb9oY4QUmOVpKdieiLn5nqu+E7ud7sQWQ2SfhNVXfeOobtI87rEKyVwsJtbSgi08u8+xSpqXvGnBGXMcRFQ7CqLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995155; c=relaxed/simple;
	bh=+7N+VHpTGzHKRYSzDk2OOTGyoErfwnToIvY7+I5OyWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfnMDPtnONmN3I0jNuUog89PAGrt0zRXMW63gH0VHnwuiFRacj7kEIwR2/egW1eDmJKsFgYJV+d3j89dRRzKDVNdiiQfDub0IEZtk5g+ohCxCxWsNG5YjttrEzbQ0LzfxoRvfvVwUytpQZe2lLnVDM09Y2nz08i1yvp3sXKX9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu7vhMYN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59431f57bf6so6597740e87.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995149; x=1766599949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFgy+A0O8xnRgJd7v+RUa9QU+8qq09tdOiliLPIqEb4=;
        b=Iu7vhMYNgxbF12w4HqrH0YR9nOf1UVbPkz8Nkuo+p1MRcl1gf3rUHEnA5TvhReMU7T
         N42IMGKa1/vB0ngF3/TXDsAzMDRGvN6PS925tFybHU3LqllK4S3R9yf1nVvu11McOx8o
         v2LcjzDbZEzYQTxitGVftesUc0L11eHmexMKiQbsR5yPWwLilDyEQfhAMA4h9U6LutB4
         P4PRIHmT+tGX2LAZEnouynClP+dHCHe+Q/MMKeqjzDjBZGZJPhh8qElPF7ID71D+Yrm7
         Jq8SdtBNh1FbXnrW2y3wFm8vUE9jHbPt9td/fUytFuPUnJ193vgoB3q+xN/cgtVuJz87
         YJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995149; x=1766599949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFgy+A0O8xnRgJd7v+RUa9QU+8qq09tdOiliLPIqEb4=;
        b=KY292ErAE+qy3/ZDuO+G0POT0Dfh2HtCnzzDBsAxw0PqPYH9sLEIkxjXd2cDv8hbbh
         gNiYhPGteF0YD/GsIBUfDcPGfSRQoslgSz08dxvHqiSbk2u3yfc64kQJKGWdXJWl3TFe
         3xRd54BblyI5mZ133acyu9M2fp7qNvgwIc3Ht+imNjILfYns3fZgkx/Mg7wAmZTGr2Nz
         ttUpw/V17nlKvJuLzEGyzD7MVa8H7VkP5eUg1Q7qx0OGj9W6qqoxWfOHmUIRYEwkJkvi
         kQzrDLGAw9STCW5hcdgDiBRCPLzrghb/lRKXPx38Qd/UcT0yVZfjPqOHheoZmberrMtD
         TkVA==
X-Forwarded-Encrypted: i=1; AJvYcCWeGgVqfdQdd7x95/qbsj0saXUjmyOz8EpNjKNYTcEBfL6VjtjWii0GtokHlMPY9Wm7+ncKbjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJZAVWOfLuOO7ZG/VFO/pRFEx7A2CLeQV5yevtcOtfi1ZtUO7
	9ZzmdVMj9uioVeVcekMP3pMgkeKgEk1K8m7Dnke3a3HwuDGQR9/cl/dD
X-Gm-Gg: AY/fxX7xDcbGmkTtWFE4VFJAfBZ9dXJUI9WIdWNDj17Vv360smtBkryvkI9YYthaTDD
	RhNgX5b1cWYrkFMyzChRJLoJLl79nAKN60cRvqKtTTBcPZpDtGtq+VljM6ywF7BaNkF+RtWw9EX
	14irlyGigXFB7Nf4z3ut4myWa6XiA4NgsV6x7W3jzSZ1Hy/kknM3NpN4ppeVBC0ATdt1AI0fqhY
	O3gEW2VmAyqt2/us19tFZY64aMZRkHb9+3LeP0kKmtBS4K2dxdjPhR5MFWTwKuQ7G+YUEp4wjO1
	0TCkGg4BXDriXs4Msi2kh1UhyJ2NZBVrccCg0YhVchzGYk/rivyAf14aJvY4lj+aep2Yl4ouhLT
	ezDl4Zz1eIofN98i5GnaAzuqk4eHd1Cm0Y+NIlp7x/0aHBaKKJCbCb6P/+cKvzBjDaaFaThgDof
	qIhwxESb7zGu4=
X-Google-Smtp-Source: AGHT+IFfAzzjL2doo80fXCqAexQGKSYqtRni1yb9UdVue4KNR9zAwS0Jwg1qOwIOBuF7UQ4BiHcjjQ==
X-Received: by 2002:a19:f60b:0:b0:598:ffd9:9da with SMTP id 2adb3069b0e04-598ffd90b06mr3767074e87.7.1765995148960;
        Wed, 17 Dec 2025 10:12:28 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:28 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Date: Wed, 17 Dec 2025 19:12:02 +0100
Message-Id: <20251217181206.3681159-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes TX credit handling in virtio-vsock:

Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
Patch 2: Cap TX credit to local buffer size (security hardening)
Patch 3: Fix vsock_test seqpacket bounds test
Patch 4: Add stream TX credit bounds regression test

The core issue is that a malicious guest can advertise a huge buffer
size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
excessive sk_buff memory when sending data to that guest.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process.

With this series applied, the same PoC shows only ~35 MiB increase in
Slab/SUnreclaim, no host OOM, and the guest remains responsive.
-- 
2.34.1

