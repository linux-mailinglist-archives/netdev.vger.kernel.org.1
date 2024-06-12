Return-Path: <netdev+bounces-102800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45E904C81
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC9A1F22372
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033040856;
	Wed, 12 Jun 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9z9+NAH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E93D388
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176554; cv=none; b=eAd9I3nOJ52h7yNEZv1+LKnHssnQil0TWLGs7GqwibZxtwKYwSiWca7HHdtk4OovDbFYuSf4oYfkc86ThIF0cjZl2Z68gr3cXJOD16Rac/uD6PZxwT5qALzP8RnhNUuopactfeopBJx+SuQQo3dhPhGZc9eGJ+wA7v0jBwHnyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176554; c=relaxed/simple;
	bh=+ykbfSP9QE6LjsxeHl6HZt6oWo4XQ54KD3PrDqCfUic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1cs2ltpKJAIJ9wQdCTC/PyBErVpeMN1qreaAY+jDeKT1ooRtTFY6N7Y2z7E+W7xH4Pzns3mvzpKoNWwgMQqWlzIYCM387Qv8MBwwhup5OJLRAmXfdQxFP/BgDwyiR+37nKroGBawJVYwuBv+L0CVGT0VqBD7yv/urdDsWaoL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9z9+NAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718176551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRPQpXge3I0Vcd7b2iojqZfH1RINuN+3D+5eFcM1E+A=;
	b=W9z9+NAHI9LKpS5GHjbZk0Dp/mPERJvoH5aLRjqr8a7yiatqMQnvgbxNEi64CPIdcaj0GO
	rLOlJNJC06O1E/S6KdCmv8/CsgTghWCfClUk+D4i1SiDVatG42ypg2sUf1aiSYVhw19f4R
	HeNdwOrazYWsgrseMLWX+auV9YzM2TM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-8MliE8uRMd6sezTBeO09VA-1; Wed, 12 Jun 2024 03:15:50 -0400
X-MC-Unique: 8MliE8uRMd6sezTBeO09VA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f8d48b3so1749170f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176549; x=1718781349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRPQpXge3I0Vcd7b2iojqZfH1RINuN+3D+5eFcM1E+A=;
        b=SPaR8P+Gf1KvV3x9MfuvE5DM3z8JJx6wlqcbuq1UhhpS089ZIxWrkFeR8HA6iSa3/0
         tX2ERD1kiIDp6tRjCcMMfUiBJQzC6Kvqt6CqAp6tvsqt0H86DCLgl53PXpEQiHgJwH55
         ugcp5X3mkB26DiZcchYT4hziwBLxqdDEuhzUKbGm9kVYUvo71pauONQWkGhB+TOU3gzb
         0IhpVM4LWZfaPze+GYtEEDRA4gNM3VEhIIAi/72XezXDM2gMejnbc72qh5ew9abq8NZ+
         w0H/G8aTwugjmnVDB6M1DAzuuX+bnG38YfhfODskZ1Nt8ipHiMD0IcHu3Ap2o/cbkVSK
         sjhg==
X-Forwarded-Encrypted: i=1; AJvYcCVifDZZFQXbqnSO9c93pbmhk6sOeCWTmvhcDMgFzEe1Oyrpfj5V+mzg0taohROAsvsUU0CVzcN8tYfBBrUAWbdxWAFbvnNc
X-Gm-Message-State: AOJu0Yzacv8MHOJbfb/+j9FeNyfEp+3Zqg+9ftc7rAgCS0HZTYoXPbiS
	wcgGPt/rwnCtL83qfR3IBOSKvR0ZICoUIhmHVg3OKCStUjkrkAaKh36KoveB+P0/0N9zKNfKz9K
	ATqp5XCV2nYj1BrHIdfZ3painQ6FinE4R+4MyQxJb2sccP1SVs2x0IA==
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id ffacd0b85a97d-35fe1bfda3fmr603602f8f.35.1718176548889;
        Wed, 12 Jun 2024 00:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuQ+XjKBy6z8bjJ/5ejaRe3tBk9OjBlBGeQH9fUUBsA31Sgruib/67gZGeejF7RYzsndo1w==
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id ffacd0b85a97d-35fe1bfda3fmr603573f8f.35.1718176548189;
        Wed, 12 Jun 2024 00:15:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:39eb:4161:d39d:43e6:41f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23a651d4sm7641411f8f.50.2024.06.12.00.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:15:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 03:15:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240612031356-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>

On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> Add new UAPI to support the mac address from vdpa tool
> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> MAC address from the vdpa tool and then set it to the device.
> >> 
> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> >Why don't you use devlink?
> 
> Fair question. Why does vdpa-specific uapi even exist? To have
> driver-specific uapi Does not make any sense to me :/

I am not sure which uapi do you refer to? The one this patch proposes or
the existing one?



-- 
MST


