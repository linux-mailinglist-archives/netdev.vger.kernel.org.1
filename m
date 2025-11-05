Return-Path: <netdev+bounces-235723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 038EFC34326
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 104BB4E3EF3
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E972C2345;
	Wed,  5 Nov 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csmGWJq0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mzNQI/IZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238D255E34
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327078; cv=none; b=u0FdJ9pJVQSLUSZLs8rUjljik5LJ7Rwl+j2yhu3bsJGv3HrWu/8NYxrulszNBMqCIah6hS4xQjPp1k3KGoO4KuL38hNESSQOb72CYTHc0C8maX5aQoXr6aRiJbMR1SaYI7hBNHwOJY4005c848omwIovF3TJYDFR5e9Yhh2DX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327078; c=relaxed/simple;
	bh=LXagqlSMvKmDxH5ta3oYe3mIclEopnmgdrr3vFPfBvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/2IOjAfofe+y8LyfxUsKjsjOmNZq2r391SqQaA1ngeyqbHFX6a79i58N5ui20l0TxkdZEi+qIifbBDjgNeJOBN831qhBuHgYxm4ud4tR0ZAcpbj00FpXOaYCcBeRj22b2WKzhKMIVcFsNVoCjvRYU5cuvMWFmUc8aEFrIc91uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csmGWJq0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mzNQI/IZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762327076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
	b=csmGWJq0rYnCRBS1D6nkJ6Z1D+h9tboI87rTPdNu13W+EfduQQtGnx6awHD++KIvkdXGsk
	eyyY9Mc14pySUq05PMQz2VPb/JJiEzjfIPksupU6If3ctCO4G/ZLvIqq2N2iGrocbwS2NU
	gHR1kh3XD3X/Zf/BQLuN30CxWkQw6nU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-BEs1k37RPQaEY40WXyaqow-1; Wed, 05 Nov 2025 02:17:55 -0500
X-MC-Unique: BEs1k37RPQaEY40WXyaqow-1
X-Mimecast-MFC-AGG-ID: BEs1k37RPQaEY40WXyaqow_1762327074
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c71c5892so3855378f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762327074; x=1762931874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
        b=mzNQI/IZyZlS94B69CpIpUfNlAZXhUA3bD1GHsZ39oTpRTTH3FRXaGpBRQgiWm+xDr
         D3iOzylzkQ3y3V4lUpLqB8Y71cOc/NViPIJI8el+WC65KSe8XEo0dRcXUREgr2rLWFgN
         tN0YvGPu2wfJWNku+6Dh2ImWui9imbABZbWmimc5SHgvlFUGiGghkdKDS7e0km3eL+GT
         O1woCn5nNawvTHDSfLwAuglJziuDE16QpcEKbCZER0eHCtKFxhtSUaNd3OFNLHvvhIM0
         fUak9rJePMOmY0KQ8NoqYCxeepy537fk+ma20uQj8gG8LtFinn46DmttVyu81SPD1TsW
         eFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327074; x=1762931874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1zZvaCPuzafmpZP8ufdbcI4+grNXo2mhPKgg1GgDe0=;
        b=dpEFUsXqX89E0L7uzZkrOCI2Xz9pcidwi6HyinQdMO4lbBL3KA9lAACpxShXHWseG+
         YKtLPE5cy/jY4L/KuXQ3gAkFcnnjoARYOZGo+JO97I54N6jRViVmykt/GCCTMmgiWvw8
         eelRhlu7otVpppL25Ihb32YXy2JWkBiZ0iHJe/U53y44iAqMwUWDy7L4paX9NBRRuhgM
         5fnhhrwE2ywqGAAKbt8vAwwNBSuBeqtqrTPnbbR7P5sPiiSzx6oMoMeEgVNJW7PE4UO8
         yBMtT8DowFDBD2DFCe9hzs+1ClBSvu8aY8oEzZGKCR6SgnGK8dD44EmPDBRzS96iroCM
         ruoA==
X-Forwarded-Encrypted: i=1; AJvYcCXMObv8OC9sNduephkI9EF6h5P+wZh1Yka3uA8JAisp9tKMPPXFHPswQdFIQblH7hv4hRsTFIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPyldm1i0xMbR7xG2Nc8hIbCrlCW9E00EvT195/nfFD2cUpD2
	43eN4tQ4JZnGPsvBl3mmq4mfYchbxQKQotjwkjKlhLMLkGCSDLcGjfah99TGbkFlymW4DKZZ1Ou
	n2jBghRn1niMsdXn686Bzgus/iMSR1DyBFReUZE6EAgJo74g5teF5/fBZOg==
X-Gm-Gg: ASbGnctIfF32gOhrhSLr2gm7j9YRSW2mqS8xEh9US36239cIBljAuS2tajIB0nDfhUU
	ojqrgef/rEiJlJX3zJ+sW1TxNHVYHlIcVucOw+VGIXVjgYF5lmKvFtqOQjj/KLlVJx7NR6517AZ
	zb0JWSMkqFr4OEx/MIo+vJ0XA/FbepBgu5Y/D7kNQooVVCQYuOTUaOKZlFXBt9WTfH9lHH5vrAE
	C+A+yguJMa8tGJM5b59KDxUtT6IYWnZUPM+vZtf3wxdF68H2+yBt9XdNDWMwm3IBxcp52kfffDe
	9zDJlKOwLIrsjIU8H7ZxlrwQaMZaL9d1K6k845LUt3zcyt0ARO/s+YlkqG2b6VtAcX0=
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr1745701f8f.58.1762327073615;
        Tue, 04 Nov 2025 23:17:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWIh69cXdbIz7tujC891g3OcIjbNWMGhZSBD4SjmvD0oB/WuNR9hBtdPZG5O4EQq5uitEgNw==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr1745669f8f.58.1762327073093;
        Tue, 04 Nov 2025 23:17:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdae2sm8869350f8f.41.2025.11.04.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:17:52 -0800 (PST)
Date: Wed, 5 Nov 2025 02:17:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net V2] virtio_net: fix alignment for
 virtio_net_hdr_v1_hash
Message-ID: <20251105021637-mutt-send-email-mst@kernel.org>
References: <20251031060551.126-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>

On Fri, Oct 31, 2025 at 02:05:51PM +0800, Jason Wang wrote:
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..b673c31569f3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> -        vhdr->hash_hdr.hash_value = 0;
> +	vhdr->hash_hdr.hash_value_lo = 0;
> +	vhdr->hash_hdr.hash_value_hi = 0;
>          vhdr->hash_hdr.hash_report = 0;
>          vhdr->hash_hdr.padding = 0;
>  

BTW is it just me or is old code space-indented here?
We should probably switch it to tabs.

-- 
MST


