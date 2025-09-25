Return-Path: <netdev+bounces-226277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEDB9EBC3
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146331C2024C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0412F6573;
	Thu, 25 Sep 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSAkzDRx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE442EE27C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796553; cv=none; b=JcxRg+RmJleyTH5E1EUMYeK1WS8Z7CpmXas67cUiB/uBFG/Dj5IMDVM6C6OenH+4eDJIxDtcqCCkWbGaqxj9E5GrWtGMj6JMOYhgCev8FXrBaMBUtravwb0iAzWuNY8IxrYCxXyi6cafcOmJ0oiZuQzNV/wqiNhc4yeCgO2HQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796553; c=relaxed/simple;
	bh=xUNLHeoXDRqlz24TV5AEjntAUr9nhMODMN2h5qvvvjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSfT+85MOy9KqZzU0vsRoMOjF/jogV/SJPDaUKk0B2ucyVkXD5e0tJKGkxqjdozoN0adFFVm1fRnotNNlzesFNsxVL8yhmXoAn4Wc4NBoz7U15FgC6Rl/sxcua+JO+Uu6VF1AToBMb71EgpDVmTWsaVWq2pLoYZLXNPm3S93WHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSAkzDRx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3EH6WUwwcgnGQdg2Ar9vB2aGlwaK5xQW7oTXv4mu5E=;
	b=eSAkzDRxaKyQlg3Q+QwRoHH3FpppTSpfIgyMSDMS6idHXGcBiY3VXINHr9Cv0losdp8m9q
	kaxz8pn0hTeU0LMKl1RepZCqBo9VzjJS51EhNH9dfiA5BYs9J9BKPurm8G2wuwji7x5XSu
	J5IussXpEmhBN1rzDNcdXSKg/k+rBxk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-VO5tXS51O2yDECPcPZGiZQ-1; Thu, 25 Sep 2025 06:35:49 -0400
X-MC-Unique: VO5tXS51O2yDECPcPZGiZQ-1
X-Mimecast-MFC-AGG-ID: VO5tXS51O2yDECPcPZGiZQ_1758796548
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee888281c3so657698f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 03:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796548; x=1759401348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3EH6WUwwcgnGQdg2Ar9vB2aGlwaK5xQW7oTXv4mu5E=;
        b=Sy2/xPCbU0emhckEjoobmprAugUSX6KhHtlFVIj/oFnzi6WwEd1T2fgnO6C6OHWr1g
         FoCfo8/oFXONTKkCgBHxWHyrwxmz6bTeWbXVoJzxj+YYQfotKTyI5EvCmnF9hFut3FKU
         7eING7+6aM/Qks1wTQnsFXd7c13hQF5I9TWiZunssg2S1NDVJH/Y+vClqxZE8KrT0w1h
         sx/UeGu3fuSqA+OTA+iQKRlnTXcMKt5fzWwWPbNGM/Ef1oQOmgUdf9/dUje0zpIEZ2+9
         kwaheLSIOW+nnLNZAHYOPQKxRUVfC5ACOSZ6LAmHIAJbxo4cL5AbiAAOpycNWGHvn1qt
         zHRA==
X-Forwarded-Encrypted: i=1; AJvYcCWv7j2fFaMgIpPcgc0V+osX6xxE3JKJPkfRtJv49l1KdiLQgvt+KJnEetM5eGgI+ksC1z2btls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1Isome8YF+MJXhY0/gHovTnOsPiGdGFo4bVRAYzhV3LuEVuu
	Rm4rt+mkdFWxvBLb3yGVD+xCToyfEH2XfHaeQbUFB9s9EZDy0eKYqivnSM2610AOIE0kvmBGY62
	2WyskCpEzCp08b0WWrdCsO6xOY59uGNJeKLZQHQ/LrdUU/UA2H7cSfvQTrQ==
X-Gm-Gg: ASbGncuH4THC5mjMrXwku3yyGqsh56eQ5BqoY6NHgrs2zndy9Ia+SD8mkloe5B4VI66
	PZRefyglQWwbrEyJMbaGxSm2nqSt9c2b02YrZekWigM3kEelF59fmuDYPur9a19CcC0wLATVvSW
	OUzDXaPNEO8XEgm+G8bDW6Del56hF6nL2xbakeA3UCNVkOC9ngvrfDf7PJEvcGik/730ibCvuZO
	qbAPGvf7AxEztN0Bd10ydDV7g2lDqNArOg9QNvgYJR3YyriFaZFFhuUvnMg4rkaN/UcVhUmbG4E
	//SQ+YkXeRiwYdxjn4ali1nS/HQapP5/WQ==
X-Received: by 2002:a05:6000:2203:b0:3ee:1125:fb61 with SMTP id ffacd0b85a97d-40e46514e09mr2505868f8f.7.1758796547978;
        Thu, 25 Sep 2025 03:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkWcoaeMZPfqEXToR9d4KGUCRtGAeqcReS6VWVUDQh5w1llQDfRRLhSrQOqVg0wGLgDM00VQ==
X-Received: by 2002:a05:6000:2203:b0:3ee:1125:fb61 with SMTP id ffacd0b85a97d-40e46514e09mr2505786f8f.7.1758796546654;
        Thu, 25 Sep 2025 03:35:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm2803768f8f.0.2025.09.25.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:35:46 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:35:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925062741-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>

On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> Function pointers are there for multiple transports to implement their own
> implementation.

My understanding is that you want to use flow control admin commands 
in virtio net, without making it depend on virtio pci.
This why the callbacks are here. Is that right?

That is fair enough, but it looks like every new command then
needs a lot of boilerplate code with a callback a wrapper and
a transport implementation.


Why not just put all this code in virtio core? It looks like the
transport just needs to expose an API to find the admin vq.

-- 
MST


