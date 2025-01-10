Return-Path: <netdev+bounces-157101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B198FA08EA9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3AC1639E8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC420C002;
	Fri, 10 Jan 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/4irTWI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48E20B21C
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506598; cv=none; b=aF/H5LMjYaeQDt5Z5EHCitAHYi2XJYUXgsljlQROp4w4+MGL9GMIKSLtUWDS9obcCRygUcQ/XcEwpYI0pagGNKZJSYDlaSv9cKWkdPmiTg1UcSb4qUgqlCUViU1Yx+impy2OMM8cWivLNm8++3A/Lu/NLYcJcdSmzrEYmMsiJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506598; c=relaxed/simple;
	bh=VpaS8bAQyw3p7i5yPlKdG6wr5isGrSmLsdJlLMostJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI4m20AAC3cMAYHiQ7Cw/c+RnfBfj1NtfXcVpFXd8WwbxkpkYsbV3G3+o1LxmNAzYyY3eF0ckQoYOPiLxLSrf2xdaoyED5eZKFHmpeP3yvnAlSyF2cReLj5wnyTa2aG+JMskynUcDWjpaI738M0Q0PsvLu2L6i8h0GgkstTMStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/4irTWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736506594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wp2/Dl1jDgRS4MRZ7ZCAJJFdKOiZ0bWzlPWkS/TsPH8=;
	b=d/4irTWIVSPvAVByje1jQ7AfLj4XVcgCocZPZpCRKXcZTiqea2K9CadMryRTaxgYrZ+iX9
	1/kYjiHwwjPrc0vWD6V9jY2JKMFwiLPWn2PpKeptbj4pTxRZBt0s+OS/Z7zuUyuCg9tmSO
	9cuhr+3hV/lkV05WFTG9CnnDv9ZDxng=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Z8S2mVtNOLSNmPWNp9dwtw-1; Fri, 10 Jan 2025 05:56:33 -0500
X-MC-Unique: Z8S2mVtNOLSNmPWNp9dwtw-1
X-Mimecast-MFC-AGG-ID: Z8S2mVtNOLSNmPWNp9dwtw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3ff30b566so1970929a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506592; x=1737111392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp2/Dl1jDgRS4MRZ7ZCAJJFdKOiZ0bWzlPWkS/TsPH8=;
        b=IePVIfeFc3r4/slg+5sHGq26xAwQ6t8RgV5xHHbtri1iwOP4Ump5M+4AkqH8z1nm0D
         FPX8MRqjfx6aiLwlKjCGbvyZY86w3cYIu4V/u0kTCX8Oklx8gmoHDWKQMWhrg1axdPW5
         KJHtO5YxUHfZVp9YiQytYD770MDBuniLERZ0nuw6REZIxOC8jwKv7Ow1MpE/2zsf7W4g
         Avd37Eg7e3okankFlCJKPAvY55l06hru1c6q9X26iHPRaRdPvaPlBzOPy+Kb4NFKh1mg
         hk/rqdtalXpedpHuUcz5lvkt1W/Ak59ajZSFPJCv9KgfaUfOQEhjA5tCbNWfm9IKZSAf
         i0nA==
X-Gm-Message-State: AOJu0YzZ6065DpsUEH4faY73ZGISRha4U7850LNxiANVJm3KanPs8Wwt
	a4PhjXQrn2t7usvMpaDV3ngeNdoDIuIqOx3+qFcdk7gnITcp3mW1vYze6w4328xU06NIXd08mb+
	P2Zciz3HaRNZ4YxanJAo0KRhrAaEfo+PULByheJFH68UA8BbOCmsNvQ==
X-Gm-Gg: ASbGnctoXJLvcTEeI4K/fo3qhPEhXJgl0sEPOTt6aHKZCx7vgAwgiDjOK1XbQfKAlhe
	ZtzFiEXUdTmpIQUzypbRbOwqp17IrJpHBZXHkOoKuOhSl14xMTgAZoURzFpxd0puczo4rGDLONC
	/b3pupb3pbsh6XDhcdzm+4M2g1rQvqtnE/DzmN7HHiFPg5wZO3tPbVoIZ2Cmz/nWiKMOIXk/ICi
	eSl7suSviSvWTgp6YNLcPE/2N1preuC0ajtOeoXZJERezERo4jDtY0Us1TD
X-Received: by 2002:a17:906:c153:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab2ab6a64fcmr802390666b.14.1736506591796;
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3RAnhLiLE0Ufj7mjhyCOMtKbT/PK9cbWY0n89eBu/2UqooguiKKCOcaocF+kmmlz9Ef1oVA==
X-Received: by 2002:a17:906:c153:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab2ab6a64fcmr802388666b.14.1736506591351;
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm156141666b.93.2025.01.10.02.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:56:31 -0800 (PST)
Date: Fri, 10 Jan 2025 11:56:28 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 4/5] vsock: reset socket state when de-assigning
 the transport
Message-ID: <esoasx64en34ixiylalt2hldqi5duvvzrpt65xq7nioro7gbbb@rhp6lth5grj4>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-5-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:10AM +0100, Stefano Garzarella wrote:
>Transport's release() and destruct() are called when de-assigning the
>vsock transport. These callbacks can touch some socket state like
>sock flags, sk_state, and peer_shutdown.
>
>Since we are reassigning the socket to a new transport during
>vsock_connect(), let's reset these fields to have a clean state with
>the new transport.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5cf8109f672a..74d35a871644 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		 */
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
>+
>+		/* transport's release() and destruct() can touch some socket
>+		 * state, since we are reassigning the socket to a new transport
>+		 * during vsock_connect(), let's reset these fields to have a
>+		 * clean state.
>+		 */
>+		sock_reset_flag(sk, SOCK_DONE);
>+		sk->sk_state = TCP_CLOSE;
>+		vsk->peer_shutdown = 0;
> 	}
>
> 	/* We increase the module refcnt to prevent the transport unloading
>-- 
>2.47.1
>

Hi Stefano,
I spent some time investigating what would happen if the scheduled work
ran before `virtio_transport_cancel_close_work`. IIUC that should do no 
harm and all the fields are reset correctly.

Thank you,
Luigi

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


