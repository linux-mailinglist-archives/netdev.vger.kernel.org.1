Return-Path: <netdev+bounces-276076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNzPOgEu1WmF2AcAu9opvQ
	(envelope-from <netdev+bounces-276076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:17:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD43B1A62
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7888304698C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A053AC0E9;
	Tue,  7 Apr 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnMQtIuv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k9cEEdOz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0A35C185
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578599; cv=none; b=l0LbmsSwj9mfmQ9OT18dHznBABJqN+6MfMoswgPPpdBvX/OozGuaE6ZWovA2JmaW1Eu1tMI09SNaqTG2P/Y/G3GjWZKyFms+xZ4TfMBcnkryxXoI+dr+son+DlbZGPP9A0oz1fqDACdlGC5bKdOKq6NUcEAlh86N8ch/hz7NmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578599; c=relaxed/simple;
	bh=L+U1IJoCmuLYVZDQUIYQpJvdtwxVa0fGgDt4MVAjdeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9uM6jFLtqmYPJToX6eeeg66VD4KrdjcZ27dGdnKNZ9GBfQm/sXoTeWNkOuNoYbnx0xQhzuivcMLy/tCfVVJLq3xZcF7mP2fQBy64GDDxIqBNoZuMH+x3Bj2u62rJgPSDpS6rMz2RDCvkEnCftffvGMo35YIFxdhkmbC+wJiVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnMQtIuv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k9cEEdOz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
	b=EnMQtIuvTjub6rdTM+0eYtk7E9RAcwhWM2RMhoUQ7xcrzBRUH+yd2ANktYyVEnopRJngVV
	KKHfqU8Nn7ENfqQ1n3HAx2DjKhAkJVBtIRjbfpxgCe6BQvfl/JXTfS2+lE4WjPhJ3ZUHwO
	EBA3mqt9v44E9gKTI5ITgxGv6oKYiRg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-qmtYJJjLNsKq4dCPh80eQw-1; Tue, 07 Apr 2026 12:16:35 -0400
X-MC-Unique: qmtYJJjLNsKq4dCPh80eQw-1
X-Mimecast-MFC-AGG-ID: qmtYJJjLNsKq4dCPh80eQw_1775578595
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4fe4ff7bso1743851cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775578595; x=1776183395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
        b=k9cEEdOzOs1WIavf2ow/HMHYZXXBNzPHMFdopet+73z8JFKHK4cpamtGvzyOizd2//
         QrNgtBhmM/xxXYrTo7qL9oRc8HzzmL/OEbXY7RBXkga+6yPDpJ41JVY5ucKoUJQ92uI/
         UObZ+vSNtIGdSd6mX6kuTZ08Y9A8gfBKCJzKZkaizR5rd4WIBpLEPiSndCDSMBWskLVD
         39ajlx9eIJDHC8oLx5oDePvUKWxVYD/M5m0QE6CHdnBoBcDqW/MwpD3hvaCQSgGerKrx
         AvDRSdH6yM8SC5gMxuiUxsChPuW/+rg2E4r0HDBuovRP1TkaOjzRxfJiVGnVMTLJoTKc
         vG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578595; x=1776183395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
        b=AoRA2LRLqMer8+IO7mov9TV2EwljqfG1SpklnKEobuy1pL1D6S2ljeRK+IQ527Jh5Z
         fgB833n2P/gZt++oWg5WfqLDNWc+jO7HNJuC5nenE/jVkSxol6dC97U7FzjO2/96WPip
         QEZMdJuGPjb6MEif4ZG6+FEr9vn/zS6Yyv7623ffY3tub4AQ51ccbIRga9MYi0wqPWsk
         3aVeHXAdkDsojtGBA0lKI9sxhrFpAaTypIXMgktMOX+nsgYlrbieEFmYYg7Lf2VplJ/1
         rxJGOLWlqMq6Aj7XBNfzXjLSn45+yyiXfKSrkvoIrMZ4MNm9uCIabP2OzYyoGpHTnW6P
         4GQA==
X-Forwarded-Encrypted: i=1; AJvYcCWZZ1vd5p85KXtRd+szr3y+X15IeDYGyITyCogZAAT3375y5dkm6OTqiQnyFHVDrezG5tY3aYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipGI/gRsslNiqYHFGyh0pm/8n5YBRUWs67xqxblnYTFVNeX2a
	Xuw8z8Z2hfV06u9+QZ2ZwYLYBoZkVrLLhAstaT5j8iLvMVvRcUHYK2ADdDEgoJPfai1QWe4xu7U
	tja3SFrxHZ1xhFacUHt3f4I+7ukOJIK4XyXf2a0zpDMKgiwe9cTOWg0pbvw==
X-Gm-Gg: AeBDieuN8ealLEs3yoF9/9WKAbK9DkJd7GxA/6GU1bfvEZbBClmV15OX3yZY7HXxTSU
	Mem3pFvzq4W6pUZayofi2CEeEYMOdfOTdwYnH2W3qSVrMozdF/yMzMmglgOEBbS2JG3mpZR2vDk
	MuloOy78AVccZ6dIKcGI2oUozl1CNqesW+2CxCpS24OPIRmjXM/mcJKK3lipycI8kQvCjsDaO4f
	hxz0X7RvYyipntJ19777sC52lotux8ZJeNJdAWsu7IggVbAvT/LMutYVhmttiCYKhnTyQN5T9fE
	Hz3z9Bg9SO2Psn/t1/6FHurizyL8hTHJ8wz9pHLs2vKQbSQ5H6IQtncOG7kPy8Y4gcYiue31Abh
	p2kKZnKjtJBQO
X-Received: by 2002:a05:622a:1e12:b0:50d:7ca3:379a with SMTP id d75a77b69052e-50d7ca33e59mr167476251cf.3.1775578594435;
        Tue, 07 Apr 2026 09:16:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:50d:7ca3:379a with SMTP id d75a77b69052e-50d7ca33e59mr167475651cf.3.1775578593759;
        Tue, 07 Apr 2026 09:16:33 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d9d449f79sm33302871cf.18.2026.04.07.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:16:33 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:16:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <20260407121515-mutt-send-email-mst@kernel.org>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99FD43B1A62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.
> 
> Remove it.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but I think we should drop the Fixes tag.


> ---
> I marked this as net-next material, but honsetly I'm not sure if I
> should have targeted net. It's not a bug after all, it's just a cleanup.
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..a152a9e208d0 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  		return false;
>  
>  	/* Check that transport can send data in zerocopy mode. */
> -	t_ops = virtio_transport_get_ops(info->vsk);
> -
>  	if (t_ops->can_msgzerocopy) {
>  		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>  
> 
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-remove_parameter-f61a3e40cf90
> 
> Best regards,
> -- 
> Luigi Leonardi <leonardi@redhat.com>


