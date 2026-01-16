Return-Path: <netdev+bounces-250637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E2D386C1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF5E93018EB6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D8362154;
	Fri, 16 Jan 2026 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeruIiZz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDLBvAL/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8421770A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594291; cv=none; b=szbnHvV81CV1vI/kOSBTajy8Cd6R5NJEKhlhTa9+zc7VPJ9Se4MBu5BtJML5Ah4U3VdCKiKAuAzy+q+9sGuH1EoCn6r4wpEEeYnN4XkvIJ2JqgTa/uA2LAu+OzdNNGtfiOBkRqR0PomNWC4bt3f9oizgRkKh5ueZ/AcbZpld4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594291; c=relaxed/simple;
	bh=E/KAWSg8rDPMJI39MnpZvrtFpm7kSErqc3R9EfRND7o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bfn6m5jWx1INoi8/v/dsz40M1AnzmdnEKSSyCwQpMVR3Ks/dmGQpuiaZHqAziRxBNsPT5hxPsM6vLO+nRWuIHg9mV5lvTrVRZ+dfX/bTmBKylKZmv2f7+l+SVkmnwEpZ18wB7oJzsBhOoy72R6BweHWM+x+tFv5ZUsxleSUrv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeruIiZz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDLBvAL/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oGy5kpqtC8Nz3SdV42jAbXS+si9RUu3HOAbvwL8Sc2k=;
	b=IeruIiZzRvUyHFWEYeqgd92bfxYfhDzw6boPHbyOWmQBVOLNAAtdFYsPGRX/xUAM4+WNnY
	ooPEmTb9Gfnyh53+6moGN7MCXbgw7S6m7AkCOYeekqp+D9NpiJqXQKW72eNrvvuQXaTwT+
	/otXwkcUc3VV6oj5YCqiw/vXEc8NyGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-oq7IjXaRO1q6OytO7qsRDQ-1; Fri, 16 Jan 2026 15:11:28 -0500
X-MC-Unique: oq7IjXaRO1q6OytO7qsRDQ-1
X-Mimecast-MFC-AGG-ID: oq7IjXaRO1q6OytO7qsRDQ_1768594287
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so21063105e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594286; x=1769199086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGy5kpqtC8Nz3SdV42jAbXS+si9RUu3HOAbvwL8Sc2k=;
        b=aDLBvAL/V7HlfT/MVMcELu003QkIxJ3fGvjyw2i8w/RHTHsvBZx7vWjliE8Ygzx5FB
         f2vlTYwZ/qsr/OyoYMuUwoOElTDHtw4EoQU+QXBYuLv63+G3nDZ38qUfg/EqFHdMJfqC
         zAeayxCcUfXfjSiqWCLscMJfumguAUHU+XGN4md3pP06iNmUgIzqeUP6pZwOHPLWpYpZ
         ZVcnDEbNhOi/dJ+IfQblWV57+Y4Tp/+GvZsU6HPgyNRT1SrV+tEfDPAvA4k2XfOvKHHq
         aq7f02YSTJRQwHjcUh+2sd4orB7F0Q2Q2OtwSs1IMCHQXS4e7CQzustzPhwPjRpjMwFg
         aPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594286; x=1769199086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGy5kpqtC8Nz3SdV42jAbXS+si9RUu3HOAbvwL8Sc2k=;
        b=AozNppzblppTrHejCLDXAOAp2iwOFJECSotg4kNvOIuNsPsVCyx4mAdndJGNnInqoV
         GAdPg4WobZ7oS8J/Tq55YyqdfThBMeLqpUKLjfgSyUnu0tqDwXaEzKnsfY8KxP09tMIx
         aHjZQgGzjNtg0I/4OGSwT5gCsPrS1sdz+wZ7uTjC+cFp8p8Jhr+i7/gxzQgEmA5pGh2F
         YIyavgavxWusjhrAMooYLNo3bhk6HwUZOARd0UG55j1lcHFeuOUU9lprAi+S4wfglXbQ
         luaiAJ7IkXEPO2b6Q8RcEdbUKkWP9TM0jvF8RqqkLMfvKJPUODgLMeKefGEd7xD9LnLf
         q9MA==
X-Gm-Message-State: AOJu0YwnMjoc+YvuUL+L8CwzsL0MiYlo0x7LW8DkUyHKxB2XaZ51Z5eE
	jyBBF3V344meQuTnrRU2bNLW5Hi+e4+Dfp/h1ssfFgZzlYyJUtxkVpA6ogRZ3X81rLUArcEAnkp
	H4wVEhj42nUvXz4A7VzipyWm4RGGg8Vrj9E8KG7eW56iyVtcGX1zkdVE6u/nXVk8QGfntGbYaGc
	laRNkFeTawuAWevMESyRXy86+nwlf3dOIsnrOUbuMoOw==
X-Gm-Gg: AY/fxX6y7DI322AB2NkaFFO9Fv0oWOeHtIjdyxUcRbTW82eK7L34O0JNaFQN1SMkc1F
	KxdJuXgmE+elUBLuT1x1hWX4w6BODP5z9fIms7Bx32HhLIxqneSNyWPX94POM4e6Z1Yzasc4U1k
	iXr1j14mWMMACKv3qCSY/2nRfOwyJ0/lagPpE5ve/ldw7EycC/DABCZJXebbFHC65zjX6l2sn9Q
	CjyflRdrfraqZbqD6Ws6PHuZqjgFFMitgKEfzm79ldPhxWFvqFQRgYEg0eWI+JyzwPUB7wvP2yV
	27S90nE5xV2gHdDfRRn3VYMYTj9s+e38u/osbolWNqm/mGE/WgFkACkxJlHzWHWezSaEFiMEAW8
	wW5OHrADq837n95v9tkKD739ITRecEz0VnpJHJMzTRXL6Boi6LodTUQgFi08I
X-Received: by 2002:a05:600c:528c:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-4801e2fdd1fmr41061375e9.3.1768594286307;
        Fri, 16 Jan 2026 12:11:26 -0800 (PST)
X-Received: by 2002:a05:600c:528c:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-4801e2fdd1fmr41061195e9.3.1768594285815;
        Fri, 16 Jan 2026 12:11:25 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8d77besm60526195e9.14.2026.01.16.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:11:24 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net v5 0/4] vsock/virtio: fix TX credit handling
Date: Fri, 16 Jan 2026 21:11:19 +0100
Message-ID: <20260116201123.271102-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till
v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/

Since it's a real issue and the original author seems busy, I'm sending
the v5 fixing my comments but keeping the authorship (and restoring mine
on patch 2 as reported on v4).

From Melbin K Mathew <mlbnkm1@gmail.com>:

This series fixes TX credit handling in virtio-vsock:

Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
Patch 2: Fix vsock_test seqpacket bounds test
Patch 3: Cap TX credit to local buffer size (security hardening)
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

Melbin K Mathew (3):
  vsock/virtio: fix potential underflow in virtio_transport_get_credit()
  vsock/virtio: cap TX credit to local buffer size
  vsock/test: add stream TX credit bounds test

Stefano Garzarella (1):
  vsock/test: fix seqpacket message bounds test

 net/vmw_vsock/virtio_transport_common.c |  30 +++++--
 tools/testing/vsock/vsock_test.c        | 112 ++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.52.0


