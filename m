Return-Path: <netdev+bounces-69570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0446484BB30
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068DF1C24BF7
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673215A4;
	Tue,  6 Feb 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2biQxHB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6283446A2
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237733; cv=none; b=AyTI1ow1Ph8zG8y6RM4ldKFkvdh4Da8TZXScUIKrrTPwOcMQIxMVuggY8dO3Qh/4ZfaPZr2a6l0KkRyR1X2I+KkT9Z+aDi/b6BJN1kYD2wC7tJuXpOumPLcbKO+FG3REHMUHsFmYwfFYhG8mloVzvZHMdW8FukGiRyyz3SfwhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237733; c=relaxed/simple;
	bh=z3qNh55Ci1qT92NuREESK3s6R8Zvn6g7iP9hM+eOcps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgpX9tr/DF+fBtsl8M9rJ7zf0otUSivpe8JpcMyFBGdfbPjjepmeZuVNRVNySiPGy4UTFQ6E5drMRI+3g1C6pZJTuA9A9psJa6/1qZF42enb43eLQiJmRYCVqJb1iXAxpumznjXIWly+G7A0nOr5IOfsoiYBFCpRyjMZ/DMUf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2biQxHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707237730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t+ziwiAXv1MK610pwiNfiMUsIpxu55IRk7DaOj/Q90=;
	b=X2biQxHBfzufR46n5o3DhOBtdOp476LBl9pGNmKyWAcrGuJ0crfl9Wn8amvyiXLglw6GYj
	6WqSgYslY/2G6bvrsYnwwNoIDT1w3XRHspfnpnH+2Xm3UDGtZc5+HFiHcD6swxBleSelmq
	fj1nJLfGrsbBX0EURcJRu9AyMqHxX1g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-lG49mzGqMd2ErnXumRU3qA-1; Tue, 06 Feb 2024 11:42:09 -0500
X-MC-Unique: lG49mzGqMd2ErnXumRU3qA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6805f615543so99372186d6.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237728; x=1707842528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t+ziwiAXv1MK610pwiNfiMUsIpxu55IRk7DaOj/Q90=;
        b=t3JqaiPkLWUyJFTh8zAK9yrCJWV3K/NRfQGHTCplHKfzqIEknpnAl/PT1wLqHA12Cf
         Eo6nmrm6tVmkX82faMQehSDLwTN+MMow1JrPmIBWylAQdmbuJXLyCjDNhh+kWSg8qlLs
         IuIVhRVFU1DSwrKrlNtQ/LciA4ylqmnXhaC6EURxmsjufXKn7UKSqT3LIyzuZNm1nUBH
         TAkosvNT0irN6mOH6WHtDxArddWjxNDrm13aITXcwMXRPMegW8zr9uvPpYQmk5KvEGo5
         FGqj6yrf+Wkt2a55KjQO4ZCu/9Ko/EdubJ3RZfGpu5GQ9RuC4MPsR5gvCk9hJ/RCC7jC
         zLAA==
X-Gm-Message-State: AOJu0YyNtNY+dRRwZUTWTAcLfmRJyhevPGLGvYlIPjfp0xX4AfHKTUAa
	v6aC2ARsr3j3a/rY4wb8qWi2QicOnI9774eNB7JwBidwSzPOgGsQxWOLrxHJj/XY9A2aYmqM6n9
	tRza24nODjZeO6L/E54YSFdrttz9IQEdZ2mX2TkxJrkCLMtoYC7ZmJg==
X-Received: by 2002:a05:6214:410e:b0:68c:9839:2d92 with SMTP id kc14-20020a056214410e00b0068c98392d92mr2713161qvb.45.1707237728573;
        Tue, 06 Feb 2024 08:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWzlRP34nEq93eRJ1m027Z04RkI4N87N2jEQGkLwDumhXBGqQEEa9a47NP8Nr899HDm2Ekeg==
X-Received: by 2002:a05:6214:410e:b0:68c:9839:2d92 with SMTP id kc14-20020a056214410e00b0068c98392d92mr2713145qvb.45.1707237728345;
        Tue, 06 Feb 2024 08:42:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwgLrNcLnuzwjdvfMmjzxU/e5br48ICw475bMqgHYTos1NPpTydq2InJ+RH332jfbQ5PIqxQQ8O/6raDo9U/242CKCn4SQK/uw0SW/zCqrSImkwCyxKB2P1qXaRy5Y5GMUgAbBqRiPTdpmrtfa55ZN7r+rox5t9XrsqVO9o4BatEjPVF8Xi7Ef5i1SBPI8+Y4AKqItpgDP7bK2r3bd14ZAARHglIAfW5w7jp5k6l5qzHd7AWf0TjZ26DDYvnpQsikUE0CNUbQdSYvCjXgu
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
        by smtp.gmail.com with ESMTPSA id er4-20020a056214190400b0068c524a70fbsm1148431qvb.66.2024.02.06.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:42:07 -0800 (PST)
Date: Tue, 6 Feb 2024 17:42:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, 
	Shannon Nelson <shannon.nelson@amd.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain
 conditions
Message-ID: <rcdyxrwfvjncasnqiygeudfix2ma6hpkeyavbq3owjuj6lmp2i@ildcakftxmy2>
References: <20240206145154.118044-1-sgarzare@redhat.com>
 <20240206105558-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240206105558-mutt-send-email-mst@kernel.org>

On Tue, Feb 06, 2024 at 10:56:50AM -0500, Michael S. Tsirkin wrote:
>better @subj: try late vq enable only if negotiated

I rewrote it 3/4 times, and before sending it I was not happy with the 
result.

Thank you, much better! I'll change it in v2.

Stefano


