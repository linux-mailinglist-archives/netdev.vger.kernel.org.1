Return-Path: <netdev+bounces-134350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DF998E8A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302601C2147C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378C81C244C;
	Thu, 10 Oct 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpYKOLUm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31E19CD19
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582196; cv=none; b=OTvjC3Kbp5T+li1tP2IjjGXFLLeIVyJ06Iw7aT6/GTrSbMh2/Rd8BcN+IcXnXEOnrmhcdGc/T/2KS+5tJ4fgqgGRRm59KDt52Yxu0Z/3dViQfZUXd21enOhnDRyx/g4SW+w7kmIsEfGBt+XSsNbeb/V8+cWGAdooj7XzpNQmxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582196; c=relaxed/simple;
	bh=YXdfXiuy338Q996EzueGEmiCzwm5chK0zlMbGYwxsB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F06rg40jEvmY8dYeONVrelfnHfZNC6UXep+L94wLzyJWibaEPHlL6BgZQDU979Fj73IAf3n+Qv5W+moCFuc+9V8zplFVDXyBJOyZp6DqrplE2kgYTSj9gR6Q4SqVty3v9CelgXo7gbXLPP5RQe5sFw3abI7PzODuLMIlxU/HKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpYKOLUm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728582193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okv2RKybuCagmoTr+5nQR2nTb+IA1DURK3Hada+1xdc=;
	b=YpYKOLUmqOB+YK034/pi8xZBPerNF7gy1L4UpjEZHVvTE2sLew8rG+zUowhKhebDXb1XMI
	XDg59dEK8Md3ofeu2TV6j0U5S8FEq9BHjzU5AqpfQQZkFi5bPvtWqn2qsBdUBLMLPXKG95
	fpm5Riq0r/hP6sWchRJlNVsHahPllVM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-1ubDTLQMMiyaRFXmBBJ3QQ-1; Thu, 10 Oct 2024 13:43:09 -0400
X-MC-Unique: 1ubDTLQMMiyaRFXmBBJ3QQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8353bd6481fso16604439f.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582189; x=1729186989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okv2RKybuCagmoTr+5nQR2nTb+IA1DURK3Hada+1xdc=;
        b=DbxfpnPDOBUfGZh4GwUcUoCgGe9iw3H9D5EyrJHRPE9fNmEYX6k2SSPafc1nvGit01
         kZwuKPSnOPsAAZ+/1AbKQySPs4fx65Jiv6KXys9Je7O7y/cr8/Rwn1DpadCTrMfqqRST
         fGH9lZ6nK8tjTXaGNhB7HjMor8xFt+7WeQWUmIVePNKTpXBI1XE0ldVU4jdHXWceWVuh
         xV9A/NFo4H/CTAeBUsP4XAIW1QhteyW9agHIghVkSwKwR4vnKmmm/2igMwaSF1Hj++ps
         O2txv/dV0hI0dQLZD52OIQQ68Xbpu5df7XZVF4WGnaTRqpLhCnOznydHCHUJN7z6pL9z
         /0iA==
X-Forwarded-Encrypted: i=1; AJvYcCU5GU9W1oMAjJ107X9JK5xfKP2jBQxk/H4EHva8c4XwJnzULf2iTdLJL/hFFgZTXMs8wW+gAQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywye4ZAP6wJP/B5u1kCl+JiXIQkvd7Ff8q8O8WpAp4zPcWPwd4S
	219gPHe94luMlk98SIHMaRZ7/IdPRMyqWOH3ArphO4VVsJ8OqdOspAWwq5P9PcFTUjSIrhyFV5V
	B5G+kMwq4A+1G/+uYeYeuIwHhviqqNNy8A0VZn4nGf5avwXNMidcYgg==
X-Received: by 2002:a05:6e02:1f0b:b0:3a3:a5c5:3914 with SMTP id e9e14a558f8ab-3a3a5c53b23mr8780415ab.7.1728582188944;
        Thu, 10 Oct 2024 10:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX4wPODz5d2oXE9aKocFeCuVGB9sHsZCElsoW8M99wIhH/mdFxCjREgEp2wTOzqiP6m0FOTw==
X-Received: by 2002:a05:6e02:1f0b:b0:3a3:a5c5:3914 with SMTP id e9e14a558f8ab-3a3a5c53b23mr8780315ab.7.1728582188363;
        Thu, 10 Oct 2024 10:43:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9d47d4sm324603173.64.2024.10.10.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:43:07 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:43:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?UTF-8?B?TWFyY3p5a293c2tpLUfDs3JlY2tp?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-staging@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH 01/13] PCI: Prepare removing devres from pci_intx()
Message-ID: <20241010114304.064f5d3d.alex.williamson@redhat.com>
In-Reply-To: <20241009083519.10088-2-pstanner@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	<20241009083519.10088-2-pstanner@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 10:35:07 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> pci_intx() is a hybrid function which sometimes performs devres
> operations, depending on whether pcim_enable_device() has been used to
> enable the pci_dev. This sometimes-managed nature of the function is
> problematic. Notably, it causes the function to allocate under some
> circumstances which makes it unusable from interrupt context.
> 
> To, ultimately, remove the hybrid nature from pci_intx(), it is first
> necessary to provide an always-managed and a never-managed version
> of that function. Then, all callers of pci_intx() can be ported to the
> version they need, depending whether they use pci_enable_device() or
> pcim_enable_device().
> 
> An always-managed function exists, namely pcim_intx(), for which
> __pcim_intx(), a never-managed version of pci_intx() had been
> implemented.
> 
> Make __pcim_intx() a public function under the name
> pci_intx_unmanaged(). Make pcim_intx() a public function.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 24 +++---------------------
>  drivers/pci/pci.c    | 26 ++++++++++++++++++++++++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index b133967faef8..475a3ae5c33f 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -411,31 +411,12 @@ static inline bool mask_contains_bar(int mask, int bar)
>  	return mask & BIT(bar);
>  }
>  
> -/*
> - * This is a copy of pci_intx() used to bypass the problem of recursive
> - * function calls due to the hybrid nature of pci_intx().
> - */
> -static void __pcim_intx(struct pci_dev *pdev, int enable)
> -{
> -	u16 pci_command, new;
> -
> -	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> -
> -	if (enable)
> -		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
> -	else
> -		new = pci_command | PCI_COMMAND_INTX_DISABLE;
> -
> -	if (new != pci_command)
> -		pci_write_config_word(pdev, PCI_COMMAND, new);
> -}
> -
>  static void pcim_intx_restore(struct device *dev, void *data)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct pcim_intx_devres *res = data;
>  
> -	__pcim_intx(pdev, res->orig_intx);
> +	pci_intx_unmanaged(pdev, res->orig_intx);
>  }
>  
>  static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
> @@ -472,10 +453,11 @@ int pcim_intx(struct pci_dev *pdev, int enable)
>  		return -ENOMEM;
>  
>  	res->orig_intx = !enable;
> -	__pcim_intx(pdev, enable);
> +	pci_intx_unmanaged(pdev, enable);
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(pcim_intx);

What precludes this from _GPL?  Also note that this is now calling a
GPL symbol, so by default I'd assume it should also be GPL.  Thanks,

Alex

>  
>  static void pcim_disable_device(void *pdev_raw)
>  {
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..318cfb5b5e15 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4476,6 +4476,32 @@ void pci_disable_parity(struct pci_dev *dev)
>  	}
>  }
>  
> +/**
> + * pci_intx - enables/disables PCI INTx for device dev, unmanaged version
> + * @pdev: the PCI device to operate on
> + * @enable: boolean: whether to enable or disable PCI INTx
> + *
> + * Enables/disables PCI INTx for device @pdev
> + *
> + * This function behavios identically to pci_intx(), but is never managed with
> + * devres.
> + */
> +void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
> +{
> +	u16 pci_command, new;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> +
> +	if (enable)
> +		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
> +	else
> +		new = pci_command | PCI_COMMAND_INTX_DISABLE;
> +
> +	if (new != pci_command)
> +		pci_write_config_word(pdev, PCI_COMMAND, new);
> +}
> +EXPORT_SYMBOL_GPL(pci_intx_unmanaged);
> +
>  /**
>   * pci_intx - enables/disables PCI INTx for device dev
>   * @pdev: the PCI device to operate on
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..6b8cde76d564 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1353,6 +1353,7 @@ int __must_check pcim_set_mwi(struct pci_dev *dev);
>  int pci_try_set_mwi(struct pci_dev *dev);
>  void pci_clear_mwi(struct pci_dev *dev);
>  void pci_disable_parity(struct pci_dev *dev);
> +void pci_intx_unmanaged(struct pci_dev *pdev, int enable);
>  void pci_intx(struct pci_dev *dev, int enable);
>  bool pci_check_and_mask_intx(struct pci_dev *dev);
>  bool pci_check_and_unmask_intx(struct pci_dev *dev);
> @@ -2293,6 +2294,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
>  				    struct pci_dev *dev) { }
>  #endif
>  
> +int pcim_intx(struct pci_dev *pdev, int enabled);
>  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
>  void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
>  				const char *name);


