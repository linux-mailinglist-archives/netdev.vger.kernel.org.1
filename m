Return-Path: <netdev+bounces-234292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEDC1EE5E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F9BD34AA9C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571002EF646;
	Thu, 30 Oct 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnWYRW95"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6737A3DF
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811388; cv=none; b=jCFKXnnFqQmheeJixoWxKXbz9PAErE8OQvSj+ffx9nJXYEO4CMUhy17ciCCZW31TTlfR/l0/BDXRpztlQsQMdpCiMUTCcagGbfz+7xNjDcyfH5626xYU/HWZKE6UVILPl6i+bWVf4ZZipEhM8o5NBqc/85eQB3Y7WnuWDienWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811388; c=relaxed/simple;
	bh=+v9TYg0I32wj9TIv39/8XJR+K77d8shcdZ4JpLtQeWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX99aC7mXFWPV53JRntyS0DiGzxMQHoggZcQ3FMVHm1hxH6c4WV/ChxWN9h0gMNg5HVvpGToeIy8pf4KulGNUEAjw51j+dE3IHdolHqtODxy5+NmEktxP/4UUsXuzNv2rOVMCxtzuCMX+zw5lZjIHoevMB6425Uoy+sRD75pzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnWYRW95; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761811384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OGlXAC9k2Rj+4zSzAHyi3VogDCtRFy8S0qEf2+An3Yc=;
	b=DnWYRW95TGGnVhgDOCyJUJ9ArdTBk72R5Nd0toBX3DIG/d5Qrlyu5Kwn+AHZYm1PqCo/9q
	HOAiO+/G+vDlwRB/EIWha1s9FtE4zruNrPbIjjurh7ianaG7Y15L8GcMbMCJcn9EzdxPz7
	aTIYo+OsIZhvEX0WfTbFcCCkdawoqa0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-L5R-6jqxON6vb37Pn_xMpg-1; Thu, 30 Oct 2025 04:03:02 -0400
X-MC-Unique: L5R-6jqxON6vb37Pn_xMpg-1
X-Mimecast-MFC-AGG-ID: L5R-6jqxON6vb37Pn_xMpg_1761811381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4770eded72cso6956525e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811381; x=1762416181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGlXAC9k2Rj+4zSzAHyi3VogDCtRFy8S0qEf2+An3Yc=;
        b=pe39PYDnKRZm0O04Pjlf+fstLhOair/Sj4A9P/csTeOAHZP8VKpCFIRuW/Th8muuF/
         EqlY0ux3YbUX8V4V9gAs3eqAbKVacxf4CHwNVk898W9WteLHGnjSBvzjkm4E4hJQvTVJ
         KVG5JwtqFlA1do4rKYjMemzbUuK7sHsxZQSDkjpMOt3Kp7FBITjU64DSr9gNNTHtn6Au
         ujbSBZzUt5SE90nklEJ13tNSQLfOCHoqGCTCQyOg6YiwIokji7j6GmhDFyL7IucaIpVP
         ZWoF13IH48dv232+bQQcpRuvIPaZsUt4rWTDC3u/8ATieZBCVvMpj4eqwxmeoNkwm3Gl
         wLbQ==
X-Gm-Message-State: AOJu0YxXrQ25uTlt8DksDc+jMHaoTTsGj+Wi3lXxlVKdjhCwB04Y7W2p
	3N1PfpfOurh0jepV+8IX08cy7Ffm/RuX2GfsThjSsgQedmo4SDNe8My42YwhCK80ZRxLwkSJIfu
	+6jJv8roX19+fd5ObF5FdkTfK8huqvRrfME6zTpQ4D/CbW09fMrbHXFBLpw==
X-Gm-Gg: ASbGnctCEVRtQ0GgJHnDjW+C2m2TBSXwhvNpMKVkdJM1BZgEvxl3qj1w46N2RgEe91j
	o7BhXrDV8FFVsKm32nIzsGBguxWk2UcwVQjxhEsub0CkG3b/+tSuhsIF6YkbxpZng4xpCfaDTUo
	KmmhpHcf39oPFRqXH1wD3O15DDB8Fv3Hc1nHIilHF2UoUQam7is08BVXJdtiwZZXYzlv567Ac+o
	4dB+hxKnKFjPxj4tlvGpakd18itpoj8oOoP23gr6xDAFP1zQ+NLgTgC1Jkf4jtz95KeGKyutdqI
	6dunBy7gfIY7ElmBVdAJtNQz4wZL8WrDY1acivfWnUrEyy4C+F6GUWAp9DhmG4ePdLGN
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr15795895e9.3.1761811381061;
        Thu, 30 Oct 2025 01:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIk/aVFQrnT9Hu3ayvn/eJjBsnEhmM/97mhlhQ2wqghUOS1OPCyVarI+Iir3/xbIPyjDpwIw==
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr15795425e9.3.1761811380513;
        Thu, 30 Oct 2025 01:03:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:9d00:de90:c0da:d265:6f70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728999a4bsm24950915e9.2.2025.10.30.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:03:00 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:02:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 0/4] fixes two virtio-net related bugs.
Message-ID: <20251030033025-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>

On Wed, Oct 29, 2025 at 11:09:09AM +0800, Xuan Zhuo wrote:
> As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
> Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
> small amount of code duplication.
> 
> Commit #3 is new to fix the hdr len in tunnel gso feature.



I think these are completely independent right?

When there is no dependency it is best to send
patches separately, this way they do not block each other.


> 
> Thanks.
> 
> v4:
>    1. add commit "virtio-net: Ensure hdr_len is not set unless the header is forwarded to the device." @Jason
> 
> v3:
>    1. recode the #3 for tunnel gso, and test it
> 
> 
> 
> Xuan Zhuo (4):
>   virtio-net: fix incorrect flags recording in big mode
>   virtio-net: Ensure hdr_len is not set unless the header is forwarded
>     to the device.
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
> 
>  drivers/net/virtio_net.c   | 16 +++++++++----
>  include/linux/virtio_net.h | 48 ++++++++++++++++++++++++++++++--------
>  2 files changed, 49 insertions(+), 15 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


