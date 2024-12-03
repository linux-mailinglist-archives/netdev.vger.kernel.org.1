Return-Path: <netdev+bounces-148451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD249E1B3F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2F5B274BF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F41E3DE5;
	Tue,  3 Dec 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS3IcHl2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9A1E0E12
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225550; cv=none; b=kcmvOIvxmD3g1uNeHmkwMgqlq9ppQMm0dFqXgkykXOzBynZYGEuPGJbakZN0AxAjkOFhEXaU/oHohhKqBTfKbhrZ764tw1WMOmk0CJOUxxJ2ixcULCT5XMEvufupSokWIddIYFyPLrGUrVZgMOYBrcOqL1LE/j3vijI15LvqOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225550; c=relaxed/simple;
	bh=iskQNfRXnzAhReoaiuqXeW9DaA4Me8mb9Bvro83dLAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTthjagrkCaUkyM38rbc/PF4kPPPS17BfGT0vCN4Cdl8TSRPiWbe9Y7ShXhCvpIOC0HpWE+N1w9UQCngFYaYrNLLU2oN8iJeMnKtxy+CE+YH/eG8Ee/+leLzcs/ZaSPh2VBMSnjk5R/sFhe5vvuHnALFzIK5cEf+MOAycpTomio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FS3IcHl2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733225545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgizlmZD+lQdqDIyZ9i+cK17Ml+pyPUyURKpHrS6zDE=;
	b=FS3IcHl2roTguLjY8VnmBR8trjmO12VfTXlGag1VlTXHc9rGevSrevnlBztcpVD+xhfTbe
	GYUrATyXj0scE2mRNadiFthKOw5f8MrVL65qaZycv+tylb3b7CsFbvH+jraInUYcOLHD+3
	bUTo1HAtJtjUGPk4p+1QUUcwUhUOpk4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-4wZBgFfuOnu4-3jpN3EdbQ-1; Tue, 03 Dec 2024 06:32:23 -0500
X-MC-Unique: 4wZBgFfuOnu4-3jpN3EdbQ-1
X-Mimecast-MFC-AGG-ID: 4wZBgFfuOnu4-3jpN3EdbQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d123aa38so2719481f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225542; x=1733830342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgizlmZD+lQdqDIyZ9i+cK17Ml+pyPUyURKpHrS6zDE=;
        b=ty7hXZSU7uohfskdhkvpA5QupTggnTyqb0U8fGh/4ZkGLnZxXKaKlJ3OVSFWRg5ChM
         dkGk2z2VPEmoeWkqulQ/bJC/1CB8ZW6/XLLB4uW4UQJjp77eN1xxrObnXiSelA8AbnbO
         yvXrtbRkj3tRlOUQh2Xh1OSimeg8zzawfSrA27YQZYHMeHwDGoCQOYcKOx9x7BDXvBNP
         HFXhAjhZROtVdKXggkF0dN7mUpeHv1r8rPh8xVoDWIzLEZEkVcxMBgYTgT0uquPKv4O9
         Mrhya4hNu+TGs501s2emvwi1EN8Bh5tQQCrVuH5YPITLXrsvbmmMhXIzupDIzDgtC58Z
         LwjA==
X-Forwarded-Encrypted: i=1; AJvYcCV6BtZd+Nj1Q/YD/xtFiGqR4NYpS7WH4p4ONOV0EMQ6xSAgAN6kNc+aVCsayaWy25clpc6l4N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpqnH1hhub3AyGP6lUxd2GHPk9alEmceui0nIYAVbfZUmdS3C
	CuVzQZIK6ABEUNh45B1FTaO8ua8pDfrbqTOgv8MhVzL2JIeWUTKU39J/nllst9+vvtu0XSsCUeR
	Bi6rmOxEQsqQvCyv1bmcC+5tTE2VOXD8FlHxlcTkWDRLOg74KSgRc2g==
X-Gm-Gg: ASbGncsamI/UqPCqiVfqR6xXs+9sKmMtz31renqCKRL8eSHtTiRQggpEAZslrazZ0LL
	nYMaIj5F7ZlC63jJnnAb09MGKZtz43YUeEv36ZH5IGaD11vsrFw+CfEN+gMbUdNVhS83wZQiJU7
	YzV8GlXxJOWNLnJl87Vlgyx49rOO6xRUDB7m4EEToDKTsBo2NEw1Hn0y+s+8wOsk7gn5e0xFoe8
	LDFj6LvjfRZq5wPA5LQliUswztKAB2Q5KR7Q5DWTXq1odBEjjEnUnkOxnG4WePy8wBRPb5CvN9P
	SagVtTytpuTG7oXO+7DcswQ7pYL1DA==
X-Received: by 2002:a5d:64cb:0:b0:385:e43a:4ded with SMTP id ffacd0b85a97d-385fd42d1b4mr1979223f8f.57.1733225542493;
        Tue, 03 Dec 2024 03:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLAKY9uK8KlOoFVtZyRznN6SreH+sP1jfvprgXofWhCVV9WpzhkM5I3s4TQDk+RUPf+J/7FA==
X-Received: by 2002:a5d:64cb:0:b0:385:e43a:4ded with SMTP id ffacd0b85a97d-385fd42d1b4mr1979209f8f.57.1733225542196;
        Tue, 03 Dec 2024 03:32:22 -0800 (PST)
Received: from debian (2a01cb058d23d600d18d33c42e57fdb0.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:d18d:33c4:2e57:fdb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe2e7sm186094095e9.11.2024.12.03.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:32:21 -0800 (PST)
Date: Tue, 3 Dec 2024 12:32:19 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] vrf: Make pcpu_dstats update functions
 available to other modules.
Message-ID: <Z07sQ8PvWQZrMQIW@debian>
References: <cover.1733175419.git.gnault@redhat.com>
 <5e97f1e54e57b0a85e34af87062dc536a28bef34.1733175419.git.gnault@redhat.com>
 <20241202195924.30affd25@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202195924.30affd25@kernel.org>

On Mon, Dec 02, 2024 at 07:59:24PM -0800, Jakub Kicinski wrote:
> On Mon, 2 Dec 2024 22:48:48 +0100 Guillaume Nault wrote:
> > -	int len = skb->len;
> >  	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
> > +	unsigned int len = skb->len;
> 
> You can't reorder skb->len init after is_ip_tx_frame().
> IDK what is_ stands for but that function xmits / frees the skb.

Yes, silly mistake. Sorry for not spotting that :/.

> You're already making this code cleaner, let's take another step
> forward and move that call out of line. Complex functions should not
> be called as part of variable init IMHO. It makes the code harder to
> read at best and error prone at worst..

Yes, fully agree. I'll post v2 tomorrow.


