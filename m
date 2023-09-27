Return-Path: <netdev+bounces-36566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F867B0808
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0A065281516
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACE3B283;
	Wed, 27 Sep 2023 15:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CA3AC33
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 15:20:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DEC139
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695828015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EIbBjpy9O83n9qhTihg7QeV6q2TpAQGQwYAPKsUVIA=;
	b=AcSl4GSDqNEYsaKVTCbdBah5/Ycpze7ED0A7AFI3hu0rvtoVJo/WgX4zzWzgjMYdgJoPXG
	606H8IFndOa71wYUqfbfapCt2OlKzrHiZ/Yat0K2JVAqOnWphjjmLlQYkAbHTDA0jouZgb
	c22n20Fw0nsKENC/FAyg79xIIohi/+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-t5YKUTzcONWfQqfyNESP4A-1; Wed, 27 Sep 2023 11:20:14 -0400
X-MC-Unique: t5YKUTzcONWfQqfyNESP4A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fed999e27so9273928f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828011; x=1696432811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EIbBjpy9O83n9qhTihg7QeV6q2TpAQGQwYAPKsUVIA=;
        b=a3lTyzZvBFMydWFGICJo3UarHr1Ic1TpXaGCwaN7d1qV5R+r9Uo3cKoqWWDtsVM/tV
         hPCT6Qpzuz9UQvczJw0XHM3OwLCaRDDfIJNOGCufxTC5RmGg9V8W0M9FVpjfEVu0kZYi
         LLbWqo35xAOGrkcbBKHU7AVUTqeLWuOhSDzBXZjQSLwBgbfo0TiISVzzaKV3xsbBm1UN
         l/KOtYSPg0G71VC75l/9J9yQmsb0GsCkqsyA1T4FEbyn0+KwNznJpLsHDUO2k9XKNOZ/
         be5sAinXPbUBVSR2obfxnsROq6vuuK8xIq2TWBHFAy64S9uQL6jfDToMGWDp/ykT4Cei
         TP/w==
X-Gm-Message-State: AOJu0YwLNma5ywVsPPiDxGOhW0J2Y2aO1JEL3l8CjTmGhjq2IGsmKMqg
	vWXvqvt7MfwOGkZRSCaUyhF0GljITBJYvxik7EwFCg/NupGBK/iBzaF/9nEkQcPB7eCAyop51wr
	KGSvuKaJeTyqq3BKC
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id c7-20020a5d4cc7000000b003140a3f9c08mr1876006wrt.39.1695828011760;
        Wed, 27 Sep 2023 08:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdjsQhdmBlcldN4VQo0/wB1Ma3pLJGSeiqWpRsH5/5aS/zWnrBptxpvSLI02eGQaomR+j8gQ==
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id c7-20020a5d4cc7000000b003140a3f9c08mr1875993wrt.39.1695828011418;
        Wed, 27 Sep 2023 08:20:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6511000000b0031fd849e797sm17324370wru.105.2023.09.27.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:20:10 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:20:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: liming.wu@jaguarmicro.com
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 398776277@qq.com
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
Message-ID: <20230927111904-mutt-send-email-mst@kernel.org>
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926050021.717-2-liming.wu@jaguarmicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 01:00:20PM +0800, liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> Need to insmod vhost_test.ko before run virtio_test.
> Give some hints to users.
> 
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  tools/virtio/virtio_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 028f54e6854a..ce2c4d93d735 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -135,6 +135,10 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  	dev->buf = malloc(dev->buf_size);
>  	assert(dev->buf);
>  	dev->control = open("/dev/vhost-test", O_RDWR);
> +
> +	if (dev->control < 0)
> +		fprintf(stderr, "Install vhost_test module" \
> +		"(./vhost_test/vhost_test.ko) firstly\n");

Thanks!

things to improve:

firstly -> first
add space before (
End sentence with a dot
align "" on the two lines

>  	assert(dev->control >= 0);
>  	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>  	assert(r >= 0);
> -- 
> 2.34.1


