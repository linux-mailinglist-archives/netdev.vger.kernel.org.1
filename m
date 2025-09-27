Return-Path: <netdev+bounces-226895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0BBA5F1D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1CD3BB5E0
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9B2E1747;
	Sat, 27 Sep 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZjSpAQ1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DE2DF148
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976350; cv=none; b=IO8cJRitaeobXnRdi7LWxCwHHcTACcYmCmGd/z81NrEkpD7JgVJ8lvmoe9mKJNMKKgmchn0eHt88a62+wumv9OBV3UxIhfMptmDijmquKcqvPucrng3xhllr/1qUqk5a3SWs8u2lPKTU98RlNhr7dSSKVmHVHQPWZmY+e6NjJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976350; c=relaxed/simple;
	bh=QXJo14oGqcFFPaCG1vYqjTuy/Ifc9HqL82bjZYd26vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXRnvrTmuxIOPIY2WRIEwPkJWSjTuSfTvro4jSdQQaQjGVAGSJ4QekvQbx5G43fuTg81vD00ugMH1yCKFkz20k8DKxtnklKk+9Z+xJsmBPsOimUpsqSwxaxqHdbwfdomCa6gkvya4JoZsYI5JrN0mI3UtN9JMR14r021iV3RS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZjSpAQ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758976347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvwU/ByFIKVGNfDOxaWsoSUUnpO5CypDPAdcRbhjc68=;
	b=eZjSpAQ12n9oz9+25HBiyiOLEp1LbS7KiHYV7ZykggsSKZS2N1v1dCNdatBNweJSStClbm
	4zcHLfPVWtSlfQfH1mUSVzZWDpmpIXcphyBLa7o9RpINC62AcAGmMW7QJ40ji9FrlTGVwQ
	jVKGLftnswICrowm6mSv/d3vKp5/Dj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-P-01nVR1PU-VgDoao5FUFw-1; Sat, 27 Sep 2025 08:32:25 -0400
X-MC-Unique: P-01nVR1PU-VgDoao5FUFw-1
X-Mimecast-MFC-AGG-ID: P-01nVR1PU-VgDoao5FUFw_1758976344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3af78819so7751075e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758976344; x=1759581144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvwU/ByFIKVGNfDOxaWsoSUUnpO5CypDPAdcRbhjc68=;
        b=w2GGJFugBbg+N9Du062v6osNe+q57mWroaMrvpAOGh1GW1aI6LyJugn8Ifxzxy7KzK
         y6Yfz7vk8DfixRGF9QogroZ1d3SDut07+t5jaLER/J2m4adF+hChT99ogkYMqki+141p
         JVUBL9Hp9TRtfcEqRsrqWloDTHxTDOAdW15Nwi9no6yWm9KaWcC2dkZt+iv//jFuTSJw
         uFYBtIUI3tUoi8RQONLWa8LuygguCKSkSoizHcoeb+cPHde5vW5FMnM2IG9U76x34M/8
         YEQaTu8MA42sulzcsHMPOxydX32J741JZPMMg1UbnV2gUNh6x8QVUvypxRPSTQl0QZ54
         6lxg==
X-Forwarded-Encrypted: i=1; AJvYcCX6pZRJU87TIu85OBEOYNe5zTpWtYo02itFNMt5z4fcd7wU7UOx4T09yrqsmw7Ish7hYGsG6C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyRYftvZw1yeQZMG73HFK3MoIdNJ+iw6+v/wu5iql8yW8ND9q
	D94V5ZiTJficdpLa9H+M0SUrzF0nLyTJFRO0TTIYGxZ2vaIw2Qbgx6MikKohQj06npbvLwVVVCM
	muXSqdA8NqHz75kKhQQ9wC6vT6Jkf05VdSW7MY98TM58rZwbCMXq3C52T0g==
X-Gm-Gg: ASbGnct8UA680VIMWw52Ufd6yEo4lcMxtovJdO6ILWASR5VeXz0tXkW9aPA2+lyHMz2
	t+IAdJiaFUctRbicxR6w8J3InZPq1Aa2YSjv+qka4mzqdex8on8mpVr7ALpUb+o+8WQVlRF6rW9
	tkKGIbH08ZLEKBJT5Hklpy9g1wVFSF7QQG5QxZoQjF/zmpCRpqdtsBxAHi/5uo0qR4afN2E1UnI
	G/ua+GkO/EnpS2YCS/9Ru9cMZtFCCA0ChLK2TV5sjF7cfSJKr3TXGgv+Ex+H3j2MbsPGfHQPRON
	kzkelzkB7ZVlcmif3Yb3FG7X9ImtSMNfFIU=
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr61745035e9.12.1758976344225;
        Sat, 27 Sep 2025 05:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTY0fdZdgXRDviUIBptO6FxVugLlKfaDdRO18KVHiVelnbnrO1C0c8G8WlptAx2IChMWMgtw==
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr61744795e9.12.1758976343755;
        Sat, 27 Sep 2025 05:32:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b562d8sm111137435e9.0.2025.09.27.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:32:23 -0700 (PDT)
Date: Sat, 27 Sep 2025 08:32:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
Message-ID: <20250927083043-mutt-send-email-mst@kernel.org>
References: <aNfXvrK5EWIL3avR@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNfXvrK5EWIL3avR@stanley.mountain>

On Sat, Sep 27, 2025 at 03:25:34PM +0300, Dan Carpenter wrote:
> The group is supposed to be copied to the user, but it wasn't assigned
> until after the copy_to_user().  Move the "s.num = group;" earlier.
> 
> Fixes: ffc3634b6696 ("vduse: add vq group support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the kvm tree I think.


Thanks for the patch!

IIUC this was in my tree for next, but more testing
and review found issues (like this one) so I dropped it for now.

>  drivers/vhost/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6305382eacbb..25ab4d06e559 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  		group = ops->get_vq_group(vdpa, idx);
>  		if (group >= vdpa->ngroups || group > U32_MAX || group < 0)
>  			return -EIO;
> -		else if (copy_to_user(argp, &s, sizeof(s)))
> -			return -EFAULT;
>  		s.num = group;
> +		if (copy_to_user(argp, &s, sizeof(s)))
> +			return -EFAULT;
>  		return 0;
>  	}
>  	case VHOST_VDPA_GET_VRING_DESC_GROUP:
> -- 
> 2.51.0


