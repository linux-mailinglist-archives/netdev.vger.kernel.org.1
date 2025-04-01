Return-Path: <netdev+bounces-178578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADFA77A22
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FFE7A131F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98D1FAC4A;
	Tue,  1 Apr 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP18LBcH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F21E766E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508592; cv=none; b=uN/rJuUJfdc4o5sdbifSNHEgiZWFyf5BKxHJaVrAjFbrIgDCLTpSQ69/ayHtfmGTud8ck8N5kTWzIk+rzHLVtcDyd12TtWBgY9jKTAoL75ihSs+J6a5sOJnzU+hEIzwrTU06tmOOL+MIMmIu4XO2007bGVgUIxdlOk1fz9dDvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508592; c=relaxed/simple;
	bh=x7czy4UI9IbqMfgh6Sv6bpB4w4cV0fLNV/AFpcTrzek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcXORHcrbFUv6s59wgb4OuzYWZyCw0tJaOM5lnu0gs9YQ+zAcob9FsI0oPV2qsIhO9MF3nT6PY48ZnEBgezNs/Ex7kPiTdzbjKorH/kkD6etiJjI+Y3O5o4AKVXoeOE/jbNi1r5Kykms4VQow0GlzI/1kOvd7Or2U07xD6Mpl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EP18LBcH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743508589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9OKWbJaDtqVih7gFwHKrfvK0bj/Hx7MnBlxug/FBXA=;
	b=EP18LBcHRXouzB8xmt9iBK23m6tpVhTpk0SWzoRoL/shlOhG/VCMDpJSp5Hwz13aLeYaBe
	bWh629vm6LYZzrQXqQjuLlaqg/5AhICebqidWZJf2f86vaztuVk3zan/9x2uBvlslH+voT
	FkAONCeCxGJxlSjLqh3eNjLqRJw1BJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-_Z6hxN1nNd2Ermf_-OyXTw-1; Tue, 01 Apr 2025 07:56:28 -0400
X-MC-Unique: _Z6hxN1nNd2Ermf_-OyXTw-1
X-Mimecast-MFC-AGG-ID: _Z6hxN1nNd2Ermf_-OyXTw_1743508587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aea90b4so2237554f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508587; x=1744113387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9OKWbJaDtqVih7gFwHKrfvK0bj/Hx7MnBlxug/FBXA=;
        b=JtAoxzeWON4H9FSsBGaLZU1oAxFGJifZvRzzbJdGGqz87IOx6pqZd92g6M6V1bpRkv
         FE5n4YZ2P/jIMELUvurRcdIzLd0czVkEWRp9i5xCPwIq2DXijBxePReewNuL5SbD3K3m
         1npAmTeq7SZlX0xiZzXnPbbMQ4EdPasZIfIWY/1rWMo65pA7fFqrheyUHu5D7APJ2swS
         wvB0gHyxHAROTgHYWEzynOLzbz5OWt3B6QxBN31m1PmIh5VAyReRuv8OYJ7S/6rv/jiC
         LBhRZ1foxjiJYtBnzwljX9sqP74n8n0Bk/SKUK6FsyM2gM2oLHsemogyV3BPsPe/pWEc
         AZZg==
X-Forwarded-Encrypted: i=1; AJvYcCWD16pDgN9qogwP35NAe4o5pDuUX8E3AJE57nPF83bgDgY15eMqgiIJZHnCP2zbCQ0Cmpp4PSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qXf0l8Oh9oWv3ye5F6QX+dO6+/5QwWhuz+veVcfzcDPQACGd
	3Zj6CLJ03AXRO5pdMOXl0lPPAByhejcovxngCRAqFJHNpVx5rsxs6Kysg8UgoYArsC9Tth3OCji
	N7My+acE09nCzhySYdE8xsIaLSEpgeMyEyuk7OGGSz3QcZtw8ga6ujA==
X-Gm-Gg: ASbGnctpVCvUkY6wg7lu9mvxbf6AujIa8jOqnsvSVQUByXT9lFk5SkokVtOOmwG3rhf
	XxC6kyDLLq4INnEZPIU5y78kUr3SO59TT7DnOOwOpXJMuix2iDdcsSHAG654m0PstCC0+jL0SxW
	seI2vicvHTesKLB9FmGJn3mdIWi25x6fl/X4iH9K4Gw78yFmHE0VFWI5Cb+GNlQmNy0dV7NcE7F
	hvR2pN/q/qc66Rqem/PKO+IjTi2rsQRj7EN6iaWycViviKcXtb9/BN1dOPx7J3AGnW6wR1jAM7W
	tPVhlLUYDKd9gZSlR8luujr9eDdH7OV4NlEgebYIjm0ITQ==
X-Received: by 2002:a5d:59ae:0:b0:391:4389:f36a with SMTP id ffacd0b85a97d-39c1211cf8dmr9667231f8f.48.1743508587403;
        Tue, 01 Apr 2025 04:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI0izcLrOFWsXGtZJ0/0M5K+6Lci6R57w6rsNHjR4GKFA4ajpQUp1BsvVdzZaWhFVqaYV58Q==
X-Received: by 2002:a5d:59ae:0:b0:391:4389:f36a with SMTP id ffacd0b85a97d-39c1211cf8dmr9667213f8f.48.1743508586985;
        Tue, 01 Apr 2025 04:56:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66363fsm14402167f8f.36.2025.04.01.04.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:56:26 -0700 (PDT)
Message-ID: <0a240ac2-3280-4831-8db2-214cb6e45f0b@redhat.com>
Date: Tue, 1 Apr 2025 13:56:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: avoid timeout during connect() if the socket
 is closing
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: Michal Luczaj <mhal@rbox.co>, George Zhang <georgezhang@vmware.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andy King <acking@vmware.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Dmitry Torokhov <dtor@vmware.com>, Simon Horman <horms@kernel.org>,
 Luigi Leonardi <leonardi@redhat.com>
References: <20250328141528.420719-1-sgarzare@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250328141528.420719-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/25 3:15 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a peer attempts to establish a connection, vsock_connect() contains
> a loop that waits for the state to be TCP_ESTABLISHED. However, the
> other peer can be fast enough to accept the connection and close it
> immediately, thus moving the state to TCP_CLOSING.
> 
> When this happens, the peer in the vsock_connect() is properly woken up,
> but since the state is not TCP_ESTABLISHED, it goes back to sleep
> until the timeout expires, returning -ETIMEDOUT.
> 
> If the socket state is TCP_CLOSING, waiting for the timeout is pointless.
> vsock_connect() can return immediately without errors or delay since the
> connection actually happened. The socket will be in a closing state,
> but this is not an issue, and subsequent calls will fail as expected.
> 
> We discovered this issue while developing a test that accepts and
> immediately closes connections to stress the transport switch between
> two connect() calls, where the first one was interrupted by a signal
> (see Closes link).
> 
> Reported-by: Luigi Leonardi <leonardi@redhat.com>
> Closes: https://lore.kernel.org/virtualization/bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn/
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


