Return-Path: <netdev+bounces-100932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4638FC8D8
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC790B265CE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49E19149A;
	Wed,  5 Jun 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSKDDX/o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF9191483
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582848; cv=none; b=DQqeVd7gLiB6RgkypuXICtTBnQJ6iddT6LFsMoQrr+DXANqQJu32F5dpODqGGwySBPq2l4mqjdhQbRSrD+lui//l+4q7NXghmaw+o+3jSILu/bRcrqJnBPENyOWIENVzTCZYu2zO82NjEdpokn8XlceC7XNZlJAVjNiJrlLu/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582848; c=relaxed/simple;
	bh=3+/0pw4u2JaQ4V4b0wPU5b5kRPyOdE+6zuH2exjbjLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=it43f7e/7q5Qxb2+k1hXQQ41T5JTKivtiTiIBsafEI2BltlgTvPK0eK/0fK36xqQ8ij1wRFKCXIp5NcbO5YdWQScsirzDCxdgl6Xo4GqfJezAjznL8Twdc1djN5MZe53B67/3lozgj9bTjTqnOanSD1RJIFVJRKkDQ7b8YpM2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSKDDX/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717582846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+/0pw4u2JaQ4V4b0wPU5b5kRPyOdE+6zuH2exjbjLI=;
	b=JSKDDX/odrfcKPgR5CFpY85vEBQ6X3NDYuZNV2pANS9RjnGnGcHolq2FE4cyWk63UY37uO
	J6VNC3BMWGJNZjG48SGXz8yqZtB3njPjoxIg7J0BBBannvrrlmCfubeTPfM8Ygf3dbYFBW
	HAvPZySx8pheL1pdL/nImOcK0gmrbFo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-xW2XI7F_NrSMiZ5H4Mj7XQ-1; Wed, 05 Jun 2024 06:20:45 -0400
X-MC-Unique: xW2XI7F_NrSMiZ5H4Mj7XQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4212a4bb9d7so51767995e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 03:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582843; x=1718187643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+/0pw4u2JaQ4V4b0wPU5b5kRPyOdE+6zuH2exjbjLI=;
        b=BpNfEg7lw/nj2I70aOeghEZrTrSLrmSgFU6l0Jx8b88dkh4fZf7idrP6s2RAHUmPh4
         4YLqFWPuySJVusFpOktQgZMNLglJjn9Y3DGdt9OjIUf7wJN2FDWVp/+gCiptQWhJRkTJ
         cAXS+c68PIneuk+0GlnFI9cv+R34lAK62PbYEijNeAbZLKHik0EKjwNmSAWlm3NTDVk8
         sY7PcMvMI3ydWps1QabEENQHXnfY1TG7GQ8WU0v6rY5zr82SKHu3QZmEpRA8YQ2J1pA+
         b6t4Nh2seRV3jnGCtx3sJFKGBhaHQLPaOHm/xv9aFZC28hgkhEAuO9EZ/IyJMkZz5qDz
         TXxA==
X-Forwarded-Encrypted: i=1; AJvYcCU7jCFk4W2DqZf7ZthojRqVqOpSn6SJYvXwZWlChuRtQnF/2/bqSMqD9ZSV2mSy+nhbhnM9t2w9MIM+Mw3beQ7PId2VpRwO
X-Gm-Message-State: AOJu0Yx/UQ8JKhrG4j5qyUuGKUAo/mpA9H15oMB6PQ3GGlGWPTafk95V
	vTbJ5cRxVGhBXz/ORfcuWFAe1EJXPx3qeijiCZp2yhUffORr9QrEDg0vPpHLvlQ3G/lhy3+8Dh2
	lEmCUqRLN9DAcOvMNa6svcQXNOw7WHILK2h3gisp1aToZUhC0t0cJ5g==
X-Received: by 2002:a05:600c:35c1:b0:416:8efd:1645 with SMTP id 5b1f17b1804b1-421562c354emr21673385e9.7.1717582843333;
        Wed, 05 Jun 2024 03:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLwiAsKcL/M+2PwMmgmbYOgQGPx558hBVK9zwpiwuDQuK9ZU3XA/Dqu4W0NvuVGidf6++kA==
X-Received: by 2002:a05:600c:35c1:b0:416:8efd:1645 with SMTP id 5b1f17b1804b1-421562c354emr21672985e9.7.1717582842778;
        Wed, 05 Jun 2024 03:20:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b684sm14225962f8f.100.2024.06.05.03.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:20:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 903B613854FC; Wed, 05 Jun 2024 12:20:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 14/14] net: Move per-CPU flush-lists to
 bpf_net_context on PREEMPT_RT.
In-Reply-To: <20240604154425.878636-15-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-15-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jun 2024 12:20:41 +0200
Message-ID: <87cyovadxi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The per-CPU flush lists, which are accessed from within the NAPI callback
> (xdp_do_flush() for instance), are per-CPU. There are subject to the
> same problem as struct bpf_redirect_info.
>
> Add the per-CPU lists cpu_map_flush_list, dev_map_flush_list and
> xskmap_map_flush_list to struct bpf_net_context. Add wrappers for the
> access.
>
> Cc: "Bj=C3=B6rn T=C3=B6pel" <bjorn@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


