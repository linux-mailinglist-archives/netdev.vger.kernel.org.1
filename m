Return-Path: <netdev+bounces-52159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47B7FDAA4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A71728293C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E0358A4;
	Wed, 29 Nov 2023 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCoAhfm/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D7BD
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701269950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI2wXYD1dHy0biP40vAHd/lkz+ijx91uo3bdYG08BTA=;
	b=jCoAhfm/JcxyGA4jvYRzFOgJyutvZi2q343EBlSB36uOLxBeW8cAm0TrD2n+Z3bp0/nyvT
	+ZKAkWYXBoF8D5jEZQqdS1QAmc7OrYyFxptsrxtnfncLF5Hws0TGO/pJuF3il8E1nJLho9
	kO7J0SWJZhrC6LQJRJLByZSRkVjmk6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-sO-JTBowNmy9EIe1_o7a_w-1; Wed, 29 Nov 2023 09:59:09 -0500
X-MC-Unique: sO-JTBowNmy9EIe1_o7a_w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332dfa77997so4698318f8f.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269948; x=1701874748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI2wXYD1dHy0biP40vAHd/lkz+ijx91uo3bdYG08BTA=;
        b=pB+zqWFa866IE0SjwXsh0wKu744P8RiPBa1vOO/4VGxGNg0OKBMzMEawMxAHyK9evc
         Irrr44uRGARMA6MpK83JNGs+fXkDOVzTw+vd4Cy2E4EbgGVipCEYQXyQrQtkepDGB5pT
         /MOYxYvSRDHcNa0qctE8FLyKUtWIrw7Bow+uRdLNUWJwKdOEWuFlUmJsLd7b+dlligf1
         Jd4p34MO9WRdzwdbeTnbzMenR0OqNmDDGKH0IToBDCRQvvgJONN4TDGhbN4fmUquHKsm
         UjnJuWj5fWTjFdNn2xr/0M91+6On2/aeEks3vFftLD4FDDjMIgyy7h1J+9MFMSsLI+qV
         aYfA==
X-Gm-Message-State: AOJu0YxONKuAMzyUivthlI5jnf+unjVCB9XvSmoS4h+DtbVJM3vW/5KI
	lV9fwtk/cCTxt+XJ2uMisezoaO98mU3t37jOI2iiDDb2zccOZiyg01dbYHwp3LjC2NPDJqThDGq
	lxMC3csYkxcjHigtm
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5590104wrn.9.1701269948084;
        Wed, 29 Nov 2023 06:59:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmMigrMbu6mymybp1KFy8Po2HEeHonkXFHl9UM+Rm947CoT67bByrDPdYVKwxNSrc1C5AKsA==
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5590083wrn.9.1701269947721;
        Wed, 29 Nov 2023 06:59:07 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b00332e7f9e2a8sm16187336wrd.68.2023.11.29.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:59:07 -0800 (PST)
Date: Wed, 29 Nov 2023 09:59:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to
 improve performance
Message-ID: <20231129095825-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>

On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
> 在 2023/5/26 13:46, Liang Chen 写道:


what made you respond to a patch from May, now?

-- 
MST


