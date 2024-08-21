Return-Path: <netdev+bounces-120529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C5959B6B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEC61C2287B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21330166F26;
	Wed, 21 Aug 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UubX1HUw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50B1531FF
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242391; cv=none; b=RC/HPRI39rpcLZ7QV3uea0oGsO4Kmahaupes3F6Ir0niR0MR3Bbk2BKSVwmJidZaziNj+R6lwUVKaO5hx8JsDOHpMf/H6j1/BPpWthwv9j/R6D8BtHRyuO4H0cUJnnv7rrBo+V6FN9dOaJd2JLksDcxFOrQ2Xt8Btb+zujlLy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242391; c=relaxed/simple;
	bh=DDWu1HqNHaS6DMEZKuJATbXl4MjOmQ8bHx+zMGTvh/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyeLE8XX+A0guqOtjQIPhjjosala4wwVm+vPLkYBDQ1VuPncHEB9jJstEwNbiYt/Uk6pc/M8FczX017Tzycd2LlfnQSBiKHIJjCCWOHrdjL2b6IVvIlSh4UWpNh/qGU5t5h99ZLwUykqWETpRQCapuioZsYfBrJoWbTlIwRBgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UubX1HUw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724242387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TSBk3tiwYk5OG97kBGDXG+0Y8CDnp1Ut323qDsoZ2kI=;
	b=UubX1HUwYa45/kCYyMuP4bMoTnXAxmkfvv9ke/B2KIaWGjgjUIHdFR6c4ur2eiUcEc0zsD
	YaxBHptZpNQ7R9us+priZQ1xU2IInkNS1T5cvFWU+s2O1HzpLzZvkZQcb9iqEo8flOxjlt
	UU+Rry0hGSs5VhDMgF5xSd/CzfeN6WQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-OBY4AhY6Oau45C1YD8IuPg-1; Wed, 21 Aug 2024 08:13:06 -0400
X-MC-Unique: OBY4AhY6Oau45C1YD8IuPg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3719cee43abso2771101f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 05:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242385; x=1724847185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSBk3tiwYk5OG97kBGDXG+0Y8CDnp1Ut323qDsoZ2kI=;
        b=guKxCtjehBqRT9AFGCTkyloExfqJeYk3zJ6Ix8J61qYqdZZHl9qZMAOXLhKugMctxO
         FFY6wnGWHhR1uAY7uXKkMfk3fes4qUJWhWGgueIdIIvF0BsDv0UXT+ONeqkgUVvNJyVx
         iJgbjQGyu4PZU0S/DR4bbYjjZR+AhdQn5v5kp99n22QavL7n/7yX2YqGoVCpXaNAj5fl
         a9dwNZKE69ZIVioI1Yj/In2BWtaI08jNY96Z4fLnMSfGvyLRifvLpnhGDnhYPahBHDxZ
         IgWYPkZvDKtnYxUdqjP50y4C8MN6fwmg6pvFn05uyrd5OPVkL89O0qKXB/Cj1rORQTBK
         1Grw==
X-Forwarded-Encrypted: i=1; AJvYcCWfK8L5S80XzNC3I3o2U9LlDo6eV9N6H841gY5SvcXsZwdSlx3tNmv3tEgNUttqQD0otYiRXfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1JUSq2Tk+n3XQscsvU9xn4q/JpUeMHyT96svqJ5BHTqzd+GI
	FDI9Dn29zbDWtfhcnErnFoGC8lLNnraWDlpP5dkpwrHeQ6b6pZpvEO/IEileYO+/a9fxw2I2oW7
	c8gReVkIfdWOHFeJBfwS4C1fnEJqPzLYPAYmTnoknq7wJmJ1O28r0dw==
X-Received: by 2002:adf:f005:0:b0:371:8a8e:bf34 with SMTP id ffacd0b85a97d-372fd92b361mr1353634f8f.62.1724242385051;
        Wed, 21 Aug 2024 05:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMB/ggUo/vRUxhw5fu4gZQwLE961KLd/t4ur3YDaHKN+uT6R+5KIUihWYpnfVR7FqX1I8YOw==
X-Received: by 2002:adf:f005:0:b0:371:8a8e:bf34 with SMTP id ffacd0b85a97d-372fd92b361mr1353594f8f.62.1724242384136;
        Wed, 21 Aug 2024 05:13:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:61f9:60b2:d178:7b81:4387])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefa20b9sm23302285e9.30.2024.08.21.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:13:03 -0700 (PDT)
Date: Wed, 21 Aug 2024 08:12:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
Message-ID: <20240821081213-mutt-send-email-mst@kernel.org>
References: <20240821071842.8591-2-pstanner@redhat.com>
 <20240821071842.8591-9-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821071842.8591-9-pstanner@redhat.com>

On Wed, Aug 21, 2024 at 09:18:40AM +0200, Philipp Stanner wrote:
> In psnet_open_pf_bar() a string later passed to pcim_iomap_regions() is
> placed on the stack. Neither pcim_iomap_regions() nor the functions it
> calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the string on the heap through
> devm_kasprintf().
> 
> Cc: stable@vger.kernel.org	# v6.3
> Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

I don't get why is this a part of a cleanup series -
looks like an unrelated bugfix?


> ---
>  drivers/vdpa/solidrun/snet_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..4d42a05d70fc 100644
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
> -- 
> 2.46.0


