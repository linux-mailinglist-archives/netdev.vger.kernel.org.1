Return-Path: <netdev+bounces-167043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825CDA3878D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AC8166BA8
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801221CA1B;
	Mon, 17 Feb 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3UhSWL3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E021CA0C
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806281; cv=none; b=a8FWIqjPEoHfcx9VG8OAyN02n7P0EvBAQrrDXUr17eG1VFOf9CEs3g56ZY1FKrHJ5aVTPeNi7chSJegiLfTFukywg46Az4/iqX9jjGEGqn7dOpCAKyzF9g3Qle+E8gaBz0IiMETMrsNqFVKzdRnmGw6bNhXLwCY0BtugO6KI9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806281; c=relaxed/simple;
	bh=f04I9HBasGoSyh4nJW1EP7PLwDyy9D4RJYTK1HfUhp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DB61LV5Y59RjM73hNht6hJXVGaltHmlpMn0Ta2NKCqqdOTvXv3D3sGkjumlxw5y7GM9ZY0gE38zxouCbiyavl8AAKxGkYs3Gv929tklorazm4fUQw2Zcex9roqGCCwk5ai0MKeB8Yd43HL/bwqxHIkZSetYxbp6MQoNwgWBjH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3UhSWL3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739806278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f04I9HBasGoSyh4nJW1EP7PLwDyy9D4RJYTK1HfUhp8=;
	b=D3UhSWL3Nbo0TdsO013v3PGwnMWTTQnjPdhoMsTogythdpeZlJ6v/rqpGdu0CUHpQ8fmub
	Pca2ps2wjgvUdRAJYeZw3xWLedQnkUQMMuO4YAO2xA+gmsGMRzeY/ThIRTE0qbl+V9sXdS
	Ley89JaSGC6yHsnXbD/4W+m029E18oU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Rx3IMbiJOkisXXddwMocUw-1; Mon, 17 Feb 2025 10:31:17 -0500
X-MC-Unique: Rx3IMbiJOkisXXddwMocUw-1
X-Mimecast-MFC-AGG-ID: Rx3IMbiJOkisXXddwMocUw_1739806276
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abbae81829fso36475166b.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 07:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806276; x=1740411076;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f04I9HBasGoSyh4nJW1EP7PLwDyy9D4RJYTK1HfUhp8=;
        b=qq9XXRO2llf7PjxE8eH4QVY6RjL4IjjSYT27z8d8eJfeU0VQ7gzsrJkqWJNuWsma/9
         TDp+vpVfiequq6j2pDfgMT8ScxB8uLlTzxhI76juvwdx+hRaiJJI8X3OAf335ku3Gd5T
         0M6PNw1ghN5oChhd+dA07NcL/r8qDgmB+GWR30rG9fC5ae0JAVbRUIJ8P+km/U81FW3a
         iQbZpyXK89VoVKEp4edAj3KZJ4Cw0+n6FvD9Nmgx9PA5RJ4R2kIfmn2aWo8e5VS7lvIa
         FLAX8WNkA9WPhVoVnJas9X7+FtNrQlZ5/UO88vn850uJX5zSa3dpf1YrxaYEZgQMMwtf
         bpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj6jWWjr6rkhs7MNHzPQmUP1SbnO1D92+L5O89+a/6rhXx9lvmHZKgem1rNdX9MVEbzFk8nUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbm2Hdq9K46iElk+F3vIbzahRGdeGFeEk+1jGDVjggI4gctoXO
	jSWm4qkb5i1g2JmRdIMTNrNC3KLZ/XaoXgr3+uaway9jEsLr/GlENUlEYOnTgGCkS/F0ztSun2B
	cDB3T2VT9biMMBG/hVd2TPtUcas+OJtxa1SHR27Hq6ACdC2clVSNKeA==
X-Gm-Gg: ASbGncuz2R/T2jzkwqwnROKqr5mYESooKgge6PQA38ry2P8PBy+8bHpDTxqZrgmTIbW
	PK8hKcwM8PcRtYFiM6yceFMgBKbVpZJymIz+fStTYslUE6YjmzVdy8aSEKPYeVXOegcQokIvnzg
	+PIyJfuGCE3iLnFBoS7+at414iFdqany+NlbjZDOgzpYt1y2qQ6zi591KzcKP7DshgPjH9Y7Rsl
	97KRRNy4mKr9opRqrorBnJ/lDE0+lX3gJ3puve7FD8eHAS2pGUrEN/YwoodWBmcCGsoRcsW4cn5
	wl9FYQsivBDQPh4YegL7R759ZomW3Q==
X-Received: by 2002:a17:907:9802:b0:ab7:e451:4834 with SMTP id a640c23a62f3a-abb70d2f6dbmr1041922866b.19.1739806275866;
        Mon, 17 Feb 2025 07:31:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVI7anGwY35O6+nhHD/POIshX4aePhIRa8bL12OVt1xG42i9g1TzakDfGCs2xMNjbSyUdjaQ==
X-Received: by 2002:a17:907:9802:b0:ab7:e451:4834 with SMTP id a640c23a62f3a-abb70d2f6dbmr1041919766b.19.1739806275489;
        Mon, 17 Feb 2025 07:31:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbabfe1d9dsm79497966b.101.2025.02.17.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:31:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 23AAA184FF54; Thu, 13 Feb 2025 17:13:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
In-Reply-To: <20250213074039.23200080@kernel.org>
References: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
 <20250213074039.23200080@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 13 Feb 2025 17:13:53 +0100
Message-ID: <87zfipom9q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 13 Feb 2025 14:45:22 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Eric suggested[0] allowing user-settable values for dev->perm_addr at
>> device creation time, instead of mucking about with netdevsim to get a
>> virtual device with a permanent address set.
>
> I vote no. Complicating the core so that its easier for someone=20
> to write a unit test is the wrong engineering trade off.
> Use a VM or netdevsim, that's what they are for.

Hmm, and you don't see any value in being able to specify a permanent
identifier for virtual devices? That bit was not just motivated
reasoning on my part... :)

-Toke


