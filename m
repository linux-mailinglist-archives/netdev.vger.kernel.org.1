Return-Path: <netdev+bounces-79424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C6879290
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FFE2816F9
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F078662;
	Tue, 12 Mar 2024 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBw2tK8X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862E3AC2B
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241006; cv=none; b=bjWFcwTji/uIsnp7eRf8cnehwJfhIw22cZLd7l2CsiIfOHZ1qrUZwmMQ6PFey2YwXprtvOXfSvZNsl9jE3hABuB70kEOtwA3G5A14TxHLS2eicegbWhgQ2O+Bc4sEbvCXmNqthPu0BdvRjDZQ+x+KqQNcejqI13PUBhQnP4FOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241006; c=relaxed/simple;
	bh=+K17EFr1oNWX967Zncpp6D38vdcx295PlLffEuv+CV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JP1nowIhHw9LViOAIi95o27UzHZkps8r5cpFOe4y3xLWElk4g4gb2+xWkpWj8/J5bW9i2oizXg5d37b1+T+2UFWhqIBGyjG9eU307MWLiDGjj0fOaZEM9fz+Ay3CTiDKJJZxrSYc8c6wifphtXdHclozzic98CcHr/YIuv5qcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBw2tK8X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710241003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7crQlJEVjGi/U3TiGpXzzn7xmT7zsE9qyLdqn/eOJL0=;
	b=TBw2tK8XY7idHweiN9hbkfE00WBIjfYJ4eCsUjuF06wEHjnuwXC4KwJ3EspEGpkhsiHyYn
	mQAL9pElD1RxhKkkbybddPa10HTUxbdQkCYbanhUcStqxeGZUi6Ugrfn9YGeyY0v7TAlZK
	mPIkffncH+ScPnsMl3WlAY+cu9urHnI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-hQw30BxuMP-rG7SsgiMRBg-1; Tue, 12 Mar 2024 06:56:42 -0400
X-MC-Unique: hQw30BxuMP-rG7SsgiMRBg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56856a14041so500456a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710241001; x=1710845801;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7crQlJEVjGi/U3TiGpXzzn7xmT7zsE9qyLdqn/eOJL0=;
        b=T60jTZt1OQ8a4Q7sqCzGcep173XWDzbXtl7jZZ9A4zuVYDuEfOYagV4v3RfKXY4Qnj
         8zYYcDYwNikfzrDmZw4VWTx0BMNhQ2Wu6nloAV5x6RYVyRzz4tIigULx0WmCOnTFax4y
         RgSqyW0yi0iZofGEpt0a1HvWupl6bY1SCTLh2yIzzq/eEN3ll0KfTvvPw6WaJXJ6oapA
         XxrMFTLFF5RgiMy6lqpO2KdyPxYiOOL4g4j/bPhHyxlNJ2VP2ouC7WfX6rMysJr1iHEa
         kLdqkqYABrx5yFgZYv3CNq2xEx0IdjgRhZ+a79jSTYEuIrvXP41Nf9JRp/4jt1Uz0wOZ
         OM+w==
X-Forwarded-Encrypted: i=1; AJvYcCX/lE42oFQvtJa1BZWIiLjA760MjHF7jhTKTED2hgiXmK0No9mkdAIxdPy1vnYo2Ok/tLt5d/UWMIng6Uduu05JMBgSVkdE
X-Gm-Message-State: AOJu0YzLprbugaV/ZEUbepY+bGPEMqCfUD618kutUexSSS6tVWVRlVaL
	t6o/ShvpTaspU3mfps2Es6gDD4e0IgvXyVcbGBAudk0lkmvsm1tpZUGJS/HfDSeewTrGhLVBEcx
	CoVd4ic98/GI74x7fBNY2OafWrsjIZDWhwzSNacH2hcR/5kAVvSmYSw==
X-Received: by 2002:a17:906:3296:b0:a45:c279:d38e with SMTP id 22-20020a170906329600b00a45c279d38emr990979ejw.7.1710241001541;
        Tue, 12 Mar 2024 03:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7E4arDxaqXMpG1fYrtKQ38Y3OybVsACggRkqgyDpMlyTEV9nxZ8gZzGJszCmPSkMVfC8r4Q==
X-Received: by 2002:a17:906:3296:b0:a45:c279:d38e with SMTP id 22-20020a170906329600b00a45c279d38emr990952ejw.7.1710241001190;
        Tue, 12 Mar 2024 03:56:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id gh16-20020a170906e09000b00a45380dfd09sm3712484ejb.105.2024.03.12.03.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:56:40 -0700 (PDT)
Message-ID: <5092d0d0c4b034e66645ffc974cf9d694f2bbb7f.camel@redhat.com>
Subject: Re: [PATCH net] vmxnet3: Fix missing reserved tailroom
From: Paolo Abeni <pabeni@redhat.com>
To: William Tu <witu@nvidia.com>, netdev@vger.kernel.org
Cc: u9012063@gmail.com, Martin Zaharinov <micron10@gmail.com>, 
	alexanderduyck@fb.com, "<alexandr.lobakin@intel.com>  <;hawk@kernel.org>"
	 <daniel@iogearbox.net>, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	pv-drivers@vmware.com, doshir@vmware.com
Date: Tue, 12 Mar 2024 11:56:39 +0100
In-Reply-To: <20240309183147.28222-1-witu@nvidia.com>
References: <20240309183147.28222-1-witu@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-09 at 20:31 +0200, William Tu wrote:
> Use rbi->len instead of rcd->len for non-dataring packet.
>=20
> Found issue:
>   XDP_WARN: xdp_update_frame_from_buff(line:278): Driver BUG: missing res=
erved tailroom
>   WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0xf/0x20
>   CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O       6.5.1 #1
>   RIP: 0010:xdp_warn+0xf/0x20
>   ...
>   ? xdp_warn+0xf/0x20
>   xdp_do_redirect+0x15f/0x1c0
>   vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
>   vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
>   ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
>   vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
>   vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
>   __napi_poll+0x20/0x180
>   net_rx_action+0x177/0x390
>=20
> Reported-by: Martin Zaharinov <micron10@gmail.com>
> Tested-by: Martin Zaharinov <micron10@gmail.com>
> Link: https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E=
@gmail.com/
> Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
> Signed-off-by: William Tu <witu@nvidia.com>
> ---
> Note: this is a while ago in 2023, I forgot to send.
> https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail=
.com/

The patch LGTM, but you omitted a quite long list of relevant
recipients, added now. Let's wait a bit more for some feedback.

Cheers,

Paolo


