Return-Path: <netdev+bounces-123318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF980964830
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A6A1F21C86
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37341B143A;
	Thu, 29 Aug 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+QFh/6n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4241C79
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941432; cv=none; b=ISExwr/ckPScF8qyu7aa/FtWKq5es527Qb1dqq9RTUMQCIlgweOl5qe33HuM4l3HaQmYS9rQvGjJh7MU8SjlA7I+sRR+l5CpgVNMTW9vhD98Zf3wNEHfDof0xXuD1Li29af25BWSWQi4ZGqyVsyTCX17gd98u2gPbZk59GOW8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941432; c=relaxed/simple;
	bh=qPoGd42IBzZ4QGCIKQdm0vMwov6rl40Xn2loXjcYRCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV33ytpaB7hYT89Gc7gs208X+DYRz5QKsFgUS1Qzhtpy6hQ6w41gGdZgWy7D+qkmJBdP5P2YtlmUdPtekadZBhOjftO1S7VUF3sNJquqGbOU1j7OHPeKH99WI9+iTc38RuYdSBTrDV//Dz4rMavyO70PKB3EACw9pwHWeCgu1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+QFh/6n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql1Ne45LZaHMxqlqyDYKdi5gydRbYI8USnMenQZimU8=;
	b=A+QFh/6nm1ekASyxlpoQtkiRZea6F72AmAE8eqFEZxINGzHOgFIXUB6NffJVkpEAokahLr
	SVOe0d5yOJDUtRUqwpTkRP/cUZP8kE9XpHcKpIADtbmJzq3H4TwilDiEzv1OMW/uROe8jM
	w+QN4ajqw4jTErvn5QoeJwcARACxiA4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-G78KCA7QN2q6TMMU6z_lZg-1; Thu, 29 Aug 2024 10:23:46 -0400
X-MC-Unique: G78KCA7QN2q6TMMU6z_lZg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f3f61b42c2so8732581fa.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941425; x=1725546225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1Ne45LZaHMxqlqyDYKdi5gydRbYI8USnMenQZimU8=;
        b=rjHa9Xb9qKW4cQ613UOKVHIm4bihUIEKNzgJxU0Lx0x80FmAKuphho/SN2g285cgy8
         LnCMbbJf3Y4cUdHg/gXVq/YPve9sOS18o9NEu3n5L7Zt53kSngJYs7jrnZF1sbhQWi7m
         ms8my4KqhrsLaG+LyBLiObYP0L6mFAYWWSmvNcOhrbazmKmoxUhu1EkTO1RsIvZfVJD9
         c6mu7ba9Kg6enqxWWsX8wYnrL7TgZc4IGGVX7FSNEyQ5xqkRDaebqER7CwT88366lCTv
         2YhWU9h35Cnfsbv67ZpyymiakmVEoqzDvZo+fJORTCh8WZPqfy+LBZ4aaAKRGNigyg2R
         d/+w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Q8gCXREId1cqXyv2C5EDVrokH1XlN+i2OrbL6Tb31HFomWkt6cWKR3KvH8Duw8dhLR+EZkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzEW/zyXF3Vn54A17VowWUqc4ZDqEseoRFFf8/E32DU2jqdHda
	FpgClVIuJELtEpC75ZV6IM5yxpbZ8kUdIQ6laeA5JrGhS/X1IH1JHxjvnntsewap/qgE8MH9eC+
	Un7CkLjfeYR4u5jO1NSkY9vBUX6QXJxOKp6szvJEd6KGOSwtATH+nVg==
X-Received: by 2002:a05:6512:3e1b:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-5353e54320emr3380660e87.6.1724941425062;
        Thu, 29 Aug 2024 07:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFORO8WjY/vuiIa32r8sJHMtCMpPhEFpMY3fd+SrJTy3Fj3cveqXXWkkApSrWhroGzyUo6WIg==
X-Received: by 2002:a05:6512:3e1b:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-5353e54320emr3380605e87.6.1724941423996;
        Thu, 29 Aug 2024 07:23:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3e52sm84049166b.116.2024.08.29.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:23:43 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:23:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Message-ID: <20240829102320-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
 <20240829141844.39064-7-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829141844.39064-7-pstanner@redhat.com>

On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> pcim_iomap_regions() is placed on the stack. Neither
> pcim_iomap_regions() nor the functions it calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the strings on the heap through
> devm_kasprintf().
> 
> Cc: stable@vger.kernel.org	# v6.3
> Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Post this separately, so I can apply?


> ---
>  drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..c8b74980dbd1 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>  
>  static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  {
> -	char name[50];
> +	char *name;
>  	int ret, i, mask = 0;
>  	/* We don't know which BAR will be used to communicate..
>  	 * We will map every bar with len > 0.
> @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  		return -ENODEV;
>  	}
>  
> -	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>  	ret = pcim_iomap_regions(pdev, mask, name);
>  	if (ret) {
>  		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> @@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  
>  static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>  {
> -	char name[50];
> +	char *name;
>  	int ret;
>  
> -	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>  	/* Request and map BAR */
>  	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>  	if (ret) {
> -- 
> 2.46.0


