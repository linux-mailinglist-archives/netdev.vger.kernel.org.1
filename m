Return-Path: <netdev+bounces-195128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE24ACE294
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A4E179066
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6441F30C3;
	Wed,  4 Jun 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFcleV9T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BE1F2382
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056178; cv=none; b=qJrQM6Z59ER+A0Gp6vfU3iiDIFh26zmNTcPjfi8ek5pcyJdCOkMWXWEFFWNedf9VOlXpCbNnpi0T3jvs/UCPwH9n85jDjE9fkK5/8+9adAvVrzF23431Y1gs7TGpSN+UqR4ChbOLY52whh9NbQTETR77jRmrHZQ3/m1PK0ajy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056178; c=relaxed/simple;
	bh=W01do5wY76nWoxIg5mxKnfoZrGLR+i9S8Z7A2Dc9Ies=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fD/MQXU/ZR4S+muY53oR9KO2Cp+9Q4gXtPc06OdWkbSheer7cI3DovU6ViSLanHhoPCFCJ7hfAVIY0RUnicBkt/KFC8/EYGhosiAfGb1OpVtGAnUQERq7kNXrqdzkiIg0yF958rHuuK5ejSP3q/A812F1Et3T5xT+lwmQYYH5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFcleV9T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W01do5wY76nWoxIg5mxKnfoZrGLR+i9S8Z7A2Dc9Ies=;
	b=KFcleV9THPOFoODpY1FS7uJOmAKRULHMQNqY7BMQia4gKbuZCi3G64wxrq2R1TX1Prv9wN
	YYnHVNKZvwk1licvWCPCzmsPzO+PXJYEfBrVt3wrjKdMPflgBhE4lH8O5NcrVzM/trH0Rb
	zmKbf7+xsAySiXNpHu7pn8lty5mlCWM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-OJH5I4x6O2-aEIqds6WkfQ-1; Wed, 04 Jun 2025 12:54:50 -0400
X-MC-Unique: OJH5I4x6O2-aEIqds6WkfQ-1
X-Mimecast-MFC-AGG-ID: OJH5I4x6O2-aEIqds6WkfQ_1749056088
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acbbb00099eso3077166b.2
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056087; x=1749660887;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W01do5wY76nWoxIg5mxKnfoZrGLR+i9S8Z7A2Dc9Ies=;
        b=Z10sMad5BpvjJHkPW6p4keWO/j3chszB2rLQxGZALUEkHMAOWMrVsWR1zJkSre+WXU
         xJvlzF42qJHebJmIEHW8dTEi6CF4t/28iYkcv6vsNLBT+4NpUXN5ycX/acp1SZluFwYq
         peUxflTkRgc3ynfO8eq5twHRv5eD5KWGazVBffnwZLX4CPhzprh20IPW7zp6cGXFQsdH
         pses1GRPQTVC4tmMtdjTJmCjXesYtOezE/HOm7EPoojKVsOkgrbginBmi09oJmpCZSyR
         8ZlFcoscQU6TXy6g2YxyPML28w13xVzrdSw/nFQLQ9Pf1emqdiN80zCv9QEqlNwbWjUV
         JZaA==
X-Forwarded-Encrypted: i=1; AJvYcCV6tVr3y9WMBNZEUtlBS+ZGCwKvtAI5MhDU0l4IgbKWJO39ime1efudFDT4ILErLGM8+f+0uBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCn2HUOL30tCStVgAnaJT1Cp/3AUy11LZcRffwLss/emsehMz
	aVAPqCbQBTq4kWiDZvqX9c7Fw2T57ZSD7qQ8LV+XfUaYC8lG/QRlf59wj9H1a9wRBiiqRjZg210
	o9jVxDxmmiKONBtuuoVTelLcAdGm2t2atvqvMXTBb9VseVMfH52Y9o/9vwQ==
X-Gm-Gg: ASbGnctENNX3m0qd5Uey3kaW3Nu+WQpvWJjHw7lBNOTYHEdDBTSUzufKS8nOdH22GG0
	8yX4VDaFNGHeS9W92EuSuvSeFGo+lFT3CfNNK/m0TmuwNNAGa4+4WjMHvZtxMerFTMTfq6OchAJ
	SAsa9Z3RfnO84gT6AQWLfpRSXhZaCyJGLtshgjz3Qm4MMAZuI17+6VnBl+D8ZCl9i+w7/VTB+1P
	owF8pVVvI6I9UOm1O6ANd0jwgHvmtXUnQ4ewT7Z4dJyj7qAlSgIVB4X7tXTo4cxZHq3Fq8W6lGW
	VW7oDtEclGsBtj7J0ScaRBWxBDwMoGZ3fmb5Fxy3aj3U1Qk=
X-Received: by 2002:a17:907:60ca:b0:adb:469d:2221 with SMTP id a640c23a62f3a-addf8fb3392mr316907266b.45.1749056087038;
        Wed, 04 Jun 2025 09:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qiEZwqMaU8PlogC4zz14GcOUJ6vF7+mDiQZEwc00xgVAfFjugss6CGYBiTVHOcZyOXoQUA==
X-Received: by 2002:a17:907:60ca:b0:adb:469d:2221 with SMTP id a640c23a62f3a-addf8fb3392mr316901966b.45.1749056086612;
        Wed, 04 Jun 2025 09:54:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e7ffsm1136170866b.68.2025.06.04.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 286601AA915C; Wed, 04 Jun 2025 18:54:45 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 07/18] page_pool: use netmem put API in
 page_pool_return_netmem()
In-Reply-To: <20250604025246.61616-8-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-8-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:45 +0200
Message-ID: <87y0u7v44q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem put API, put_netmem(), instead of put_page() in
> page_pool_return_netmem().
>
> While at it, delete #include <linux/mm.h> since the last put_page() in
> page_pool.c has been just removed with this patch.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


