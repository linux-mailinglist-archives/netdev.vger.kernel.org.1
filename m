Return-Path: <netdev+bounces-84742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AE68983F3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A4E1C20E95
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95487442A;
	Thu,  4 Apr 2024 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVehHtaZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24D7352F
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222848; cv=none; b=qURP03vT/0j8g92Oo/t1yqw8j0g389WbYI8i4jg44vxAq/728d6cupFX7toDu0mbZdQ1Jx/rJhtAZRUfHpHiyDUMV9Jfv6zjaLFtU3U+F1Q6US1Kg5iOATZsxGuCJpzjwgfmJJ13YCiwwwgDbFHBHRDczV82tQwGzFMVOtVPADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222848; c=relaxed/simple;
	bh=PRiTw/abkrEN44tqH48yaEjrrGg6FgmrPr2DnauoEoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnYKJoozXA81S17osCbx4Y21o3MQCCk391nVQX7l7MVMWNIG1oSyA0DQM7s/eSf5v3prtostLEfbkn+tbzeJRWk75x09F4/eATnaUU18C7bC5JudUVOqXVWCuLWdrGi+hNCa17C6VAffBih8HGbSyDtkHlZ1JmS6VVm3yEIR6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVehHtaZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712222845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pVETgqL2dZj6sFWwiKY4NxrUWckLg07N5GVmbfSW0To=;
	b=dVehHtaZaTW+Mo3sRIRWLmijKhgIUtm1B2n127hxrXkk2+MRgvwmTP7NtwKJkt3inTmq/d
	DCC0DbqtGVkLKl3O7xdbseJV8HwMBHElmSLNzsee46Q2wAShCdfeFoK3yf2JJ9hJYlJWH3
	gW/P+xEfHLA2XjHwK51GIbNaXbwB510=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-ppvtVXjmNEKcbySmq5XNLQ-1; Thu, 04 Apr 2024 05:27:24 -0400
X-MC-Unique: ppvtVXjmNEKcbySmq5XNLQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4148a85775cso198265e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 02:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712222843; x=1712827643;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVETgqL2dZj6sFWwiKY4NxrUWckLg07N5GVmbfSW0To=;
        b=DJfmUksSh+j6muBBfMg7QmXQYq07yYTj1YoGd5EPQvdhVOTwmw8vzX1H1gKpUqnKFi
         9xHr7FZGV1nejVW8BKD9KUGoUI9Y+r76OiZ/Ub1vrBfpiE72cC7+TBOv/5eDICLvruNj
         BjHLm9nDz/NUEfYCholK25AkaVxZ2Iii4rR6ZV9GrnSouPqSP9asxQb/pDjbvvWXwU4d
         OdouWxUqqnjcDeWiaQGeUWwAwDsRK+TQXVaoTzowNrCM83DqqzTbAZTC8SOQ9u1gg6Nd
         YyF5h4xX1sgPuXkSV+8bI/lAOEsC2B95wvo2yt6oEjN9kAw3pUqoTA7/Yq7i2YNjvaXB
         OhDw==
X-Forwarded-Encrypted: i=1; AJvYcCVddtG+j+iaFbGa4/2kP4G+7cK6GgQCTBzmlkp8orXE6P/fCU2XuEpFhhVfCyaPISzpYxdCsPxfV9kRQksQLvDNkOTmF7nN
X-Gm-Message-State: AOJu0YzI79gqTMJoImPLNOK8OTB6Lja3n/KPxMAl17l4jX4h4TAdfL+P
	zNAs4/j/9mSbkAQaWZuVV9hLvrE9UN1H7jX9eaoW3ohx6YNl596uzgL5IOGyH77fsYRCtyB4y6a
	3aSun/98AUab+PX1KtnhbJneH6ycdueBPed1hd7rkasZdP7+YISNIYA==
X-Received: by 2002:a05:600c:1c85:b0:415:6b4c:86cd with SMTP id k5-20020a05600c1c8500b004156b4c86cdmr1575161wms.1.1712222843078;
        Thu, 04 Apr 2024 02:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG90ZF6Whd4KxZoIA7XNBVbN1V5TEBWirsbcmwhQ+e2VMgwoOy3ugUsCdn828PLF6vvKBG7w==
X-Received: by 2002:a05:600c:1c85:b0:415:6b4c:86cd with SMTP id k5-20020a05600c1c8500b004156b4c86cdmr1575145wms.1.1712222842681;
        Thu, 04 Apr 2024 02:27:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id a9-20020adff7c9000000b00343ca138924sm528906wrq.39.2024.04.04.02.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:27:21 -0700 (PDT)
Message-ID: <57fa4971e271840127a64aa2bf3e0f80720f650a.camel@redhat.com>
Subject: Re: [PATCH net-next v2 0/7] bnxt_en: Update for net-next
From: Paolo Abeni <pabeni@redhat.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, michael.chan@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, gospo@broadcom.com,
 kuba@kernel.org,  netdev@vger.kernel.org
Date: Thu, 04 Apr 2024 11:27:20 +0200
In-Reply-To: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
References: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
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

On Tue, 2024-04-02 at 02:37 -0700, Pavan Chebbi wrote:
> This patchset contains the following updates to bnxt:
>=20
> - Patch 1 supports handling Downstream Port Containment (DPC) AER
> on older chipsets
>=20
> - Patch 2 enables XPS by default on driver load
>=20
> - Patch 3 optimizes page pool allocation for numa nodes
>=20
> - Patch 4 & 5 add support for XDP metadata
>=20
> - Patch 6 updates firmware interface
>=20
> - Patch 7 adds a warning about limitations on certain transceivers
>=20
> v2: Fixed formatting issues in patch 2 and 7. Removed inlines
> from C sources in patch 5. Corrected email address in the commit
> log of patch 6.
>=20
> Pavan Chebbi (1):
>   bnxt_en: Update firmware interface to 1.10.3.39
>=20
> Somnath Kotur (4):
>   bnxt_en: Enable XPS by default on driver load
>   bnxt_en: Allocate page pool per numa node
>   bnxt_en: Change bnxt_rx_xdp function prototype
>   bnxt_en: Add XDP Metadata support
>=20
> Sreekanth Reddy (1):
>   bnxt_en: Add warning message about disallowed speed change
>=20
> Vikas Gupta (1):
>   bnxt_en: Add delay to handle Downstream Port Containment (DPC) AER
>=20
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 114 ++++++++++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 184 +++++++++++++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  30 +--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
>  4 files changed, 257 insertions(+), 73 deletions(-)

Acked-by: Paolo Abeni <pabeni@redhat.com>


