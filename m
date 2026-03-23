Return-Path: <netdev+bounces-270660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHONF12MwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:54:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79A2FBA8F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D54D53072DFC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD443CBE9E;
	Mon, 23 Mar 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6BhqKuv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40663CCFBE
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290317; cv=none; b=qutgzVX7YPXLP9O+BazHA3FWZBi1WdXuLt6XVgOjCLtNrGHAX3dYCTKGmM5YFoS25X2PSRSWGeEBv8HfEezVNjo5DecW1sYDfzh6TyV2S3mMH9IuspC6eZ12wlKpr56YU8aD8dXF7UHv1TphG9bNcNZMC6GpAxqO41VMa6DgsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290317; c=relaxed/simple;
	bh=n2Px9KvrBSca+8wbbFZSgIYdPNKBUj7GDb8kCwrntFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Un0e3px9/UFarDWgnAwASNgSMuf8UTtD2fo6SE2K498OUhIlVscUL52LeYo4BMT/HpFKE8WKe9yESD5r99gIgd1vXusj7UCMV3lGNvAvDphlQqtASBAqx2EaS2fUTdi3nn4bZxMePtUb3Bjk3pvj1ghJCXXymuAx0wnXYSfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6BhqKuv; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271195d2a7so870709c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290311; x=1774895111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+l2i6CJ0UesVmQ48tC67wDfEsqc0p6X8zxC51ds3A4=;
        b=C6BhqKuvTpMhqlgVXLg6kGG0gezlJsDbJftPaxV/tEZBZA6D9EC2wRDTvqtCMVxwz4
         /8ZOvMrwAa3W5fYzMgFaX3I6Ptx0VKBRK4Lgpt8ILJokWwtxMfTBzc3/PzPXg70Oj4np
         jpl5Jmo0t7/5kzqB3fsutAMjgJ1YqE19eixjvR7p/ri4XkpXb+LFuk8M8KLyDG6+2rqI
         tb8Hveoxujn0S2XUx8RQ18UNQBRNT7oS0go8XLXN5G5pAoMBFsg952vDwr6+W4olLNAq
         zg9N/rTnW/muM4oDXZA9ksnKerCiBQ8d0Y181a4ort6rAdjU48nIksLnZXq4bqI32XqA
         3OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290311; x=1774895111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+l2i6CJ0UesVmQ48tC67wDfEsqc0p6X8zxC51ds3A4=;
        b=NsoI/kIdMrCzCbTQKrM/zbAIJ82x8vvPoRU78oy+HBjnSXfh2h/qqzMHee3uvH6iVJ
         bggpSYIyBk3p5OeiKEJoTYW8YUPlQGlO1wLsNxIUl+NFUf4c/237eOC70ad08Ms47+II
         HiwXe7fP2FAh5cQMntiDZhSrhbjtwl4FWpkaBFIR5iwx6LTutq9gIkIKgMFZKkqce9i+
         qVXkrMEzMDnsnHqPwbdI10pPHEj3dZ06niE9+gsJ4Ie7geMoJBG7TwMIH0a0upf9mLGU
         z4J7N8tYAIY7mgF3BiqU3zXzPYkQvDMUGemEOjbYsXcWmepbKC5S1BRTTpdn9oiHXEZG
         MD3A==
X-Forwarded-Encrypted: i=1; AJvYcCVx48OGS8E7mJpfZ9wGkUpkamcb9oJ/uaJjHFk8XidJ1e04k4tMV9MpdKUtf/H0EJ9h1Jozm8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljV0gaHgQyVjTQm320NEsVHaTDEW+keC182TpDy9WtcYFIwWl
	ViYrQ1D9ZToniMVyI6xuhnHaVaURFxQZC3iV02Sz8wWxk/ZNjRNh6v7Q
X-Gm-Gg: ATEYQzyUNdVPoimwAAH17kiS7H6efAveCkS47PHuUiZzEVFDUDukfuW7kKlMyoB5Sua
	IdY0sUyB72zZO2KxnUavxMtxTqZdz1npOFqSNo9JJhYKoeTxHBtVxsPDlYfKDeLb2NabSCbPXEY
	nZUCwX6MYFYT1xZUDq+uD2YuvLIAT58wCEZnrsCakJj9AMFFltxUsTAw8hGHLAKTe8R6QraDHZm
	gb1qhDM/jGXvdVE9jbRxY2R01wh3Gf/ggsAmFzy29gXTwuFLacJk6EL+rWBCmaJus3zUoEHpklM
	+uw8YjtS1ROKEPQcdCKmP9qDl4SjkhrtkYd1lfe40VGHKrSkSuNSoDVS48JkInyNkpxRtIzxYHX
	6nOYVh7hnxTiarVUXnn7ueWaaDgMV+f9cm+sad+5YvHpK70ucu9H6v0StHpE718bw0H9CnNtQ3G
	5XbLGBpdwToGGF0XM33TruoJ/DX3wwB/+sColJQ/qK1pIzM25JfWwyoeWs+TTYBR5ZRIEFGtHNd
	U8=
X-Received: by 2002:a05:7023:b14:b0:128:e2a9:d97b with SMTP id a92af1059eb24-12a726dd9b5mr6179340c88.42.1774290310889;
        Mon, 23 Mar 2026 11:25:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm16253302eec.26.2026.03.23.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:25:10 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:25:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 03/10] spi: switch to using class_find_device_by_fwnode()
Message-ID: <acGEk-63oVK_fBeh@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-3-b72eb22a1215@gmail.com>
 <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e1856-feee-4f4b-8059-85a53967f6b3@sirena.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C79A2FBA8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 05:16:04PM +0000, Mark Brown wrote:
> On Sun, Mar 22, 2026 at 06:54:21PM -0700, Dmitry Torokhov wrote:
> > In preparation to class_find_device_by_of_node() going away switch to
> > using class_find_device_by_fwnode().
> 
> >  struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
> >  {
> > +	struct fwnode_handle *fwnode = of_fwnode_handle(node);
> >  	struct device *dev;
> >  
> > -	dev = class_find_device_by_of_node(&spi_controller_class, node);
> > +	dev = class_find_device_by_fwnode(&spi_controller_class, fwnode);
> >  	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
> > -		dev = class_find_device_by_of_node(&spi_target_class, node);
> > +		dev = class_find_device_by_fwnode(&spi_target_class, fwnode);
> >  	if (!dev)
> >  		return NULL;
> 
> Actually, no - this just looks weird.  We're in the middle of an OF
> specific function but we're having to jump up to fwnode for no apparent
> reason.  If we actually decide to get rid of the OF specific function
> then I guess but I'm really not convinced this is an improvement in
> isolation.

Yes, I want to remove OF-specific APIs from the driver core. I also have
drafts for bus_find_device_by_fwnode and others.

I can make a followup series introducing spi_find_controller_by_fwnode()
and removing this OF-specific variant.

Thanks.

-- 
Dmitry

