Return-Path: <netdev+bounces-152974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5B9F6779
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB341882017
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D321ACEC6;
	Wed, 18 Dec 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/7zOCqS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041661A2396
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529260; cv=none; b=GuA63rVrFtQgGiUZJWILdEDQreWa0VWLz6YkeyAfdVaMGmDm9VSz/3HYta9D7gmV/pe7wECMNiPysr6guwakadXpznkE4lQZLb6FGABdGIyU+NK4gMuX4EU5zugKDa9niHaSBJL17I27SqgjvlrMvKsOHLtDw3fVAPI+fTu9fU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529260; c=relaxed/simple;
	bh=K0zNBfbcETnxYcirA39F9HXcQ5BTEnz7zkOIyJnNNe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYcy8x6UjIf1B38XIcyf8Z3k2EylnQOR+t9nOiwATafd5mEzY03TWKsZMCf30eOoMzFBKwn38djE6krCiQ9QWgs/x6qVH4JqCfqkl8ioPCsCaB76LvPp98dAWlg/juuVeSAiNzT4x25gzj3jrwcYi6sXsHTf07PbroKva3HoeEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/7zOCqS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734529257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UKlCgrehlnF+33doHpsOgEv2HS2Nvzn1ShjGdsaFJ4=;
	b=N/7zOCqS79eO7pVIttB2rM/bODqGFxIGR1edzqb+1d2nA1x9D0mG1yc1iI8mAQhlLUdju9
	LzJJrjUCt1FATC6CWHblQpaZLrYANG6numEPhK1rmJ5QV/ng4gRo4mMH5+60qqgrTYnR60
	kio4eHw99ps1vFMuJMuqNFXfa190X28=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-vHlsk17VPoaOzkmMSb7CwA-1; Wed, 18 Dec 2024 08:40:56 -0500
X-MC-Unique: vHlsk17VPoaOzkmMSb7CwA-1
X-Mimecast-MFC-AGG-ID: vHlsk17VPoaOzkmMSb7CwA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f0b1023bso70137506d6.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 05:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734529256; x=1735134056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKlCgrehlnF+33doHpsOgEv2HS2Nvzn1ShjGdsaFJ4=;
        b=S1GD0IDPSKRxp2uSPrLzHYYV2ZDD4A21xK9tqZ0wfTieux1KDC7tZEUCybv96676O2
         zS/RkuomRqujY6tK3onjRBRSheP5OQv1ii9BdEosgsbdcqQd0GCNDnkG8dekruGlCrHL
         FlGas4sqPjs/TQnMSWO1ReLaKk7lNauyD3dntoWs3kNXn6FCbluB5BcS5KUziyTs7pec
         cOoiyBHX4WFjWB/qJHiAO2rr2GXaL5zcS6XK3d0hyFKwoUDB5yZIn/0pzjGyUlFm/MqK
         XFqpjsFaq5q5ggKgJfzVDB5+n094WWQuP+GW0eysICxQJ9YnziwTvZoaCIzGKuFv1x75
         N9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu3+OSQQmxDaCVcB5zntukfNd+cm3sXKEiLP/H8XJCZZ920F/vFf8URXXQivf6gn8yRdkssGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPGEMzGQNmAmloJERniS3RtMD/IhtDtOJTmBAluOvo07v1zLY
	6Kycznv8xQhcOUGvz59UYRRrRmyARF+KuhlXXhWiYgiEVuz0dj717WQ6njRmYK9vriTjChMLoTv
	VdwOePbKHgqZJUUMaEDT/jvP60zv1kiXR3whVT7Mk1dyBlEDBpG9enw==
X-Gm-Gg: ASbGncuEjR1G5i/0eZjmdDvaabO1a1k0AwBlaW1Onv3zx35Z2AX+TMN2YSkuzG/1gF/
	Fxf/ctKsVagx3QjsSm9JdGplYMx0RkHEqWnE5h0J5LUE30Ihn4WJuXmGWVlQm2Vkt7LOAKTT/oN
	Fvc/By3mT5pc0I8G0LA03J2Hm4RIUeVdW8bCScz18+ufiR9smUzL1SYRZZ5nscVKe3uVIeCsYeq
	4B2FJeW7Ipq1GyhLdcP/tKOIBlr+qCRlmlLvEmLuAVA+rv1t0NHoIPXN049Sbdrg1Wvf+VcVhOd
	fiE9wM3+KJec/z4N/olPJpAjJ5aCpaS3
X-Received: by 2002:a05:6214:cc5:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6dd091a11bemr55843386d6.2.1734529255997;
        Wed, 18 Dec 2024 05:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO9mHXcACDlZbDnxDKCyk44Fx1XL6dG1GpRlYM9XB/qySvxxv969FyCcdix0+v6qIEDr/4pA==
X-Received: by 2002:a05:6214:cc5:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6dd091a11bemr55842876d6.2.1734529255583;
        Wed, 18 Dec 2024 05:40:55 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd2795e9sm50346356d6.66.2024.12.18.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:40:55 -0800 (PST)
Date: Wed, 18 Dec 2024 14:40:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
>When calling connect to change the CID of a vsock, the loopback
>worker for the VIRTIO_VSOCK_OP_RST command is invoked.
>During this process, vsock_stream_has_data() calls
>vsk->transport->stream_has_data().
>However, a null-ptr-deref occurs because vsk->transport was set
>to NULL in vsock_deassign_transport().
>
>                     cpu0                                                      cpu1
>
>                                                               socket(A)
>
>                                                               bind(A, VMADDR_CID_LOCAL)
>                                                                 vsock_bind()
>
>                                                               listen(A)
>                                                                 vsock_listen()
>  socket(B)
>
>  connect(B, VMADDR_CID_LOCAL)
>
>  connect(B, VMADDR_CID_HYPERVISOR)
>    vsock_connect(B)
>      lock_sock(sk);
>      vsock_assign_transport()
>        virtio_transport_release()
>          virtio_transport_close()
>            virtio_transport_shutdown()
>              virtio_transport_send_pkt_info()
>                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                  queue_work(vsock_loopback_work)
>        vsock_deassign_transport()
>          vsk->transport = NULL;
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                                                                   virtio_transport_recv_connected()
>                                                                     virtio_transport_reset()
>                                                                       virtio_transport_send_pkt_info()
>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>                                                                           queue_work(vsock_loopback_work)
>
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>								   virtio_transport_recv_disconnecting()
>								     virtio_transport_do_close()
>								       vsock_stream_has_data()
>								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>
>To resolve this issue, add a check for vsk->transport, similar to
>functions like vsock_send_shutdown().
>
>Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
>Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>Signed-off-by: Wongi Lee <qwerty@theori.io>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5cf8109f672a..a0c008626798 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>
> s64 vsock_stream_has_data(struct vsock_sock *vsk)
> {
>+	if (!vsk->transport)
>+		return 0;
>+

I understand that this alleviates the problem, but IMO it is not the 
right solution. We should understand why we're still processing the 
packet in the context of this socket if it's no longer assigned to the 
right transport.

Maybe we can try to improve virtio_transport_recv_pkt() and check if the 
vsk->transport is what we expect, I mean something like this (untested):

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..18b91149a62e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,

         lock_sock(sk);

-       /* Check if sk has been closed before lock_sock */
-       if (sock_flag(sk, SOCK_DONE)) {
+       /* Check if sk has been closed or assigned to another transport before
+        * lock_sock
+        */
+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
                 (void)virtio_transport_reset_no_sock(t, skb);
                 release_sock(sk);
                 sock_put(sk);

BTW I'm not sure it is the best solution, we have to check that we do 
not introduce strange cases, but IMHO we have to solve the problem 
earlier in virtio_transport_recv_pkt().

Thanks,
Stefano

> 	return vsk->transport->stream_has_data(vsk);
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>-- 
>2.34.1
>


