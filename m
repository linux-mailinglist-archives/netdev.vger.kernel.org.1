Return-Path: <netdev+bounces-249409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D8D1814E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C57302FA0C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6021B3314DE;
	Tue, 13 Jan 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLxVIXLS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/BldoKD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF1279DC2
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300502; cv=none; b=pZ2JlJzE2wmyWxhs2re6tGe5lemyConiAzSlgAehBRGBL39vh5soVd3JWx/HMeViorfASnx7orfeyRcKNJaDNtAAcHcj7GSsjxI/uZ88BQuPU/bSYK3nmJrBOoK/37a/X6f7b1pfG51/M58eeHPRQPhbita0hUo77gNE307ZC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300502; c=relaxed/simple;
	bh=Ce/nJEZGmO6L0kVT9kwF9kuqtSrijP123A9vTXnzjo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfoxHolF1oTDgzE3KdRf60wlCLu+vtqnwsBOyZOrkTrRi4+/oLA0xnxW7DW+bjzhnc/26VOkyZAM/4AKut1scgg55bxXdKbImKou16tbAaTDrPg0RvNy9UJvOiyLWD0lSB8NWMyEBd69UOO3WpsDi06glv3jpPw++QwfeduBf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLxVIXLS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/BldoKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
	b=hLxVIXLSIx82KCrBqxVHv7uGcuTpw5x0BoTbOcaQUtxgJXD4szDVENDVmSLj3INUxbszTt
	Mn7NeN8Yks00K2rEH5rveW2iLZrGVNuc78gWxhMzKLU7jilp5O3mJRKuQTBD6szadNM72j
	C1z1GgF6hSlxBrJMnuFu9this8jKumw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-k2OnODcENO-kw7vLTeCJFg-1; Tue, 13 Jan 2026 05:34:57 -0500
X-MC-Unique: k2OnODcENO-kw7vLTeCJFg-1
X-Mimecast-MFC-AGG-ID: k2OnODcENO-kw7vLTeCJFg_1768300496
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso57717425e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300496; x=1768905296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
        b=I/BldoKDFrmM/AO6uquFDiuDV89YIRCDuCy+/EISJHa8n3W7Qy3XKx+h3cpF55rgS/
         3k+/857zy66cTkNp3ajj5M/k+57No+J/t52KsY4k4Iw3mQEZtktNa86w2HRePSs4k3nW
         StyJVv/a1fHz6n6EerUaD/TTE7fuh+2LWUIAaV9eHAeDPrOMpSQpOtdnqvchwMTj+336
         F5acjg1VpS1qdlOO1Dw/hPb4EDd6Vn6o4Yg3JJTWmhmFlgFfIwp7TVWD4y4fCbd9jzD6
         +YyUsQO2gj2pfTcxoTNfNbTWaTrHXS6OLvHKnRS+onyFaE+me9f2MWkFkaI4ROJjdule
         QOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300496; x=1768905296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
        b=v5fNMG3cXJKGLPIE4qBWZbZi2D38FsssUDnZObOUUat53+xVDnUsMGdQIDsSvyumZT
         Ze98L3fw1SrLhk6SVi7D75tM9CYxXHXSXhf6GGRxcmZbNyRdZQKOMiaIcw7y5CtC4NTx
         Wvs0SKBuKKiVx7wJLbC9TdQ9HbCmHMl9fNwUxQOXVaVmAYtq0jNIR8qm6S9IQVuz1bOg
         DW1P5oMXCnb7hTYR009N9JdFuFl0i69HYGRYWxbIIpuYe5Jcn1cBFP7TjbCbzjvJFGgz
         R4bW5zas0RA/yV7jAXsmBpyAXxlARJPHMHNKZO4DO9lQWfepJxHEL6InYZI+bIaEKrkr
         xvqg==
X-Forwarded-Encrypted: i=1; AJvYcCXwhkjjuWNpwWay8cMAWWlJZAGOi7Jaw7vgNjPQL4VroL1frUOyceGBe6/mAJS2suRzsNGAo7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaSWa2ysbc26duiaWhm0FzD9cjzDF1skFimjW0F2o5PJ97j+A
	9FuWKjw1MkxXud1EqOiYA3WJA05TSRnxgMU3SVPP2Mo83VQcJWR3CW52sT5VwidBdZaVieva69M
	9XyyoalfdwSs52cr1XwHGDQg6M+isnpvWKfP2Y8RqPn44YvWS8NUJt1bpjA==
X-Gm-Gg: AY/fxX6kGzycXOJ2N16bdwgIKyJIQ0O60Av6R5/wJ2nDvYcfQAKL2R72GZiqEhumdw7
	wSmrzuLXBXW/22VuEC+vOBD1KZoh0o1zpSl9rqRQnNzrnzFL1ZQt1OekNbZ29eOX3HdybLO/np6
	5XQ6WvclPfyw0KI7cR/y7FvPlI/8m/1HhT6Jw9iDfVaqXjGv1GwxrxP75Wno6OiGixYN9WguucR
	3wwGU6BGD/jQ6lDRotk0uCIB5DXlT5xc/6PCXDBRfF5I9Jnc4yaio7OQSjltrMjncLV1rZbdc3U
	YeSz6u+wn8dQfaAvUD9n4evxkzhs+8fezeSz7xqHD/4+uHyCmLjbA0mm16s+4AXvd4sqW9zX7ha
	0mTdhFDFdYvEz
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr217868105e9.34.1768300496021;
        Tue, 13 Jan 2026 02:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH39g2T92Y4/kmCEQ96bzsNq0jo0zpd85gtHjgmQsLxOO+v0ajp2k6EhijDpMlzAG7BPPZlZA==
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr217867695e9.34.1768300495534;
        Tue, 13 Jan 2026 02:34:55 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm414015045e9.7.2026.01.13.02.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:34:54 -0800 (PST)
Message-ID: <6d4941fd-9807-4288-a385-28b699972637@redhat.com>
Date: Tue, 13 Jan 2026 11:34:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 8/9] selftests: iou-zcrx: test large chunk
 sizes
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/26 12:28 PM, Pavel Begunkov wrote:
> @@ -65,6 +83,8 @@ static bool cfg_oneshot;
>  static int cfg_oneshot_recvs;
>  static int cfg_send_size = SEND_SIZE;
>  static struct sockaddr_in6 cfg_addr;
> +static unsigned cfg_rx_buf_len;

Checkpatch prefers 'unsigned int' above

> @@ -132,6 +133,42 @@ def test_zcrx_rss(cfg) -> None:
>          cmd(tx_cmd, host=cfg.remote)
>  
>  
> +def test_zcrx_large_chunks(cfg) -> None:

pylint laments the lack of docstring. Perhaps explicitly silencing the
warning?

/P


