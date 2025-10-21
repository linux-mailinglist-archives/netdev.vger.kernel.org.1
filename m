Return-Path: <netdev+bounces-231110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E059BF53A3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AEE18A4D3D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A9302CD0;
	Tue, 21 Oct 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmRoVhrJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E452EC0B8
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035313; cv=none; b=hTXJfwve5t0SaMc/DKhqovMct+2ZQe3FZBrOLZCHM7b8uPE/UY44jMrQgHMpHkuYm2EIrCTkUI3+K7Ee9YwB84+7mvAN1bx5i+kgrFF+OugWo3nklk/p+uwZog0u7NzsddsVOHcIlGBt4d3FBY3SLRAAqPAVgtUQvNNToG3CLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035313; c=relaxed/simple;
	bh=6b74B6VXDCdcmJHeIm2ZbabEvGQgPJOC4TiiYfNyIxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHj0HP12sGiPy5lFQFdhkaZm16S8y4DuY7lLfUXtcFU4i5Gv6FMAhWhy53WpPLDq8q1c2bbdWyixAGhTuAMbiPbrNvFNEM2wo4TkWzZ+NigpwklHvjEXiS7nZIZXag2u06vWPWGx7/9cPOlNTAwI74im/n9bZNNfXfTa4v5rGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmRoVhrJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
	b=BmRoVhrJDJOpwD/kD9mtS3FXOqsf7YOytchO8sCorKGOX6SICbHRa8tSdmuAEzXC6IbknU
	aymfRgzOVTNHR5tNeONKxZbyD4Z5Gn74vO3ggpjACJtppNBF2PREI3bBWXt99oPbRPoFW5
	qgwd0ztDyyoyDtd+zSRN+EwdPE5pBlM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-DbGx7lfFMYOk9lE8S4WfRQ-1; Tue, 21 Oct 2025 04:28:29 -0400
X-MC-Unique: DbGx7lfFMYOk9lE8S4WfRQ-1
X-Mimecast-MFC-AGG-ID: DbGx7lfFMYOk9lE8S4WfRQ_1761035308
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47113538d8cso31090335e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035308; x=1761640108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
        b=dQI1NmUvremYITN+85ITYENnlIkjjVrzoQN5AQdQIugr/pB45IJWQLVSl/KfKhLVWA
         WiM4aqJVBbEfIc3W6SRICI8WM1gM3csTufuF+ZRcotfuMpqGt+GiXoQMbzFLSCsVikqH
         rxmapC0el51pLfC6MxKDje2XSiz8xFcOBhgvku5wKIRcoPS3OUjXDkxgcLht628kyI8X
         5jEseOCy+AxtumQUXiYD2Gs36TGHwLRcM0xoa3716oaqMr6gYog210hoycpUmfRDo7zV
         O6GacHbZPZqc+BT+IMutJ5IRqc23dbTfEeDnpvkvzbYgBjlLTewzzK0zRrxd9hfisdfy
         VzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIHSNFojnAUH0fruwba5+8XWks4qQjWBMhXhrPGCiAJ4uSS2XkuKo9F1mkTUc5RMgdv6iM9yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjLLKNXFoAZ9CKeLtpuqeWo0qzZ9slGQQXs96x0ErbpyyJtHs
	ks2ynAYs0XRUYGCQLonbZlYm9Ecf/3EjShXesmQv3+ALP28ShhPMag6s8djKFB0g16jJ6jebsA5
	2Q/AAAjX4bysiIAiUU1gjaJ9JXxVvgvDUK96dn3imaw5wBtnnk3dpcHhWvA==
X-Gm-Gg: ASbGnctYtxJR5w1Mg5GcGYVsmoQzf+BJ3QKQ/aUBfNdrWSxHcjYj8V/aBeXRwv6LpWA
	9UV0uIm10ybzRCpL11/ZY4giJI1ZG0lEK/SVaedup6Kan+zGQ2sPZUYGa3w3WKi7X1dfH2vtkgB
	90keSlruC4ykA9Y27B+0PeCka7s0GtRPHg4GjshRdWM2QhfUbv1wKovE8T2yQtf3djcE6ftYO8j
	hEmntP//TDCTjNt6r62EX2fnxeBelrTyE71YaZk/tvR4SHDhnuiRmoSKRQ0si4oUeRMPoPt0pZt
	FAUNyMuVl+KIrvVjpK8eV1Ipcp3nLCtdwAJTM1fF6pY44RXueLjlhVCdFlmsRO69fRDF
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406905e9.39.1761035307822;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGRVyIsfoQR5BPGvrQHdlbSlAJgPiR7tZMRXYjTySH7Todua5vbiJ9sWTo57eh1Pa8fByUpA==
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406715e9.39.1761035307261;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm213055095e9.0.2025.10.21.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:28:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:28:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
Message-ID: <20251021042820-mutt-send-email-mst@kernel.org>
References: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021040155.47707-1-jasowang@redhat.com>

On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.
> 
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_net.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4d1780848d0e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> +        vhdr->hash_hdr.hash_value = 0;
> +        vhdr->hash_hdr.hash_report = 0;
> +        vhdr->hash_hdr.padding = 0;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> -- 
> 2.42.0


