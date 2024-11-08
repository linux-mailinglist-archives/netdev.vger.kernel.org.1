Return-Path: <netdev+bounces-143343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CD9C21CE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672922818F6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA312EBE7;
	Fri,  8 Nov 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6jgmmy8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082201BD9DB
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082640; cv=none; b=dMZVn5S2iOIug2e7YiYT7F10Ao1UHBJ7nQ0BivMnLrKg3bnS07HLkeyxovR3e2IV+Vz0/qzDjJdY8BA51nYSVDuwqXudcX4QpNurDLU9IpUwBV5Bb8e54ldel2cpJpNXJBbbbeeTEvWiLD+ZziisGUtpLCjKWtSZNwKCUhoZUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082640; c=relaxed/simple;
	bh=B1zb4s6wqjsaGu3zuICvGcflH0bTY7szGMgi0nhznoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzaNm8Tr+Z9a//6KtPUC4xZP7daiI66HAY6NHRD0LNFz+n0SVLcPb6W1bf1dunkGuY69U96SQWLvP5xsWYYMxBhqkqvDqq0h9qRhor//ugZy2K3mRdMNOtR7tG2Y7xewhn9TTuqUrZ8+mHigrS2kVgsqxqf1ylrn++1q5hmNs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6jgmmy8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731082637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55SYXzHa2UmvdGOhPXnTiulxMYj6o7/RTIyRzF1sUas=;
	b=A6jgmmy8Mx3xbaQEnV5qL2iC3+CGmttdbJ56JLvkv/KFLq9Eixz19HWcspNX+wjp+6ytQC
	4mQWMiSfQgEj9+aE/+GJfc24ZZAU8jwXAWLRsLXDrul1UE0uZrqdlFbQtsltDRxQe0yRos
	HYp7+OUHXMmLRC9rXfldlXYyXf/9R4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-Sr3-ep3wNLumrZz4UcejYA-1; Fri, 08 Nov 2024 11:17:16 -0500
X-MC-Unique: Sr3-ep3wNLumrZz4UcejYA-1
X-Mimecast-MFC-AGG-ID: Sr3-ep3wNLumrZz4UcejYA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d59ad50f3so1161386f8f.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 08:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731082635; x=1731687435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55SYXzHa2UmvdGOhPXnTiulxMYj6o7/RTIyRzF1sUas=;
        b=mYX5jSCQM7SDCzNIN52AGredHHukixJ77jljSm2aRe/nghaPMZvKhiNX83dmoNYZJ9
         nrzGeQlLOn4EZVz4h5Yqoka4iw2cNy6e0eFHsRfFk1Pb8CICSQXKzplf5DlKG21klKL3
         abR0hY8vJ5XNr4xr+Vkiuj/953OMmrxHemyddoTAALL3G+A3fQP4ZCE00TK9Grx/qQXF
         ORTNyZo+i7f8jLR2vpMYNJtRQfDWGtIP4Z+u/4YJlxSVs3o2XsCzGxENpfTUhVYybwqr
         +PBU1nLzhs5nItND1WF2cNF0O8foseWWHRnsUVXGlZa55Cd642oLkcZfoMqPlYJzaWRN
         IKjA==
X-Gm-Message-State: AOJu0YydCQOLKOeza6U0MwWMJSAyJeZe4AI3755nBYQTjHJ1hEt5eXrg
	tT3p3k9TmjMyf/8YbQDRNK2R6tmoHA4TmMcmCFkFFc64hjR8LLjHX7Kf7KIic1pTxOxtuIOQpYX
	oiY4z/AXMy3deiZJ/5nOAUzBgknnGHDgLnYmsHVdOEq9lTDiklM1WiQ==
X-Received: by 2002:a5d:59a2:0:b0:37d:476e:f110 with SMTP id ffacd0b85a97d-381f186fbcbmr2982087f8f.34.1731082635249;
        Fri, 08 Nov 2024 08:17:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5c1xsqi+VlZFd6SLf2pUrRmo5UwEp/CkUWLb1XYJkNaKBKx4dRRJhLxAaO9hZslmTR+8T7g==
X-Received: by 2002:a5d:59a2:0:b0:37d:476e:f110 with SMTP id ffacd0b85a97d-381f186fbcbmr2982066f8f.34.1731082634895;
        Fri, 08 Nov 2024 08:17:14 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4f6sm5333198f8f.64.2024.11.08.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:17:14 -0800 (PST)
Date: Fri, 8 Nov 2024 17:17:12 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Emanuele Santini <emanuele.santini.88@gmail.com>
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, friedrich@oslage.de,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	dsahern@kernel.org
Subject: Re: [PATCH] net: ipv6: fix the address length for net_device on a
 GRE tunnel
Message-ID: <Zy45iLv7cL8OcYze@debian>
References: <20241108092555.5714-1-emanuele.santini.88@gmail.com>
 <Zy3/TmyK7imjT348@debian>
 <Zy4fA07kgV3o4Xmn@emanuele-al>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4fA07kgV3o4Xmn@emanuele-al>

On Fri, Nov 08, 2024 at 03:24:03PM +0100, Emanuele Santini wrote:
> I'm talking about the ip6gre. I agree that setting the hardware address to 0 is appropriate.
> However, in the ip6gre_tunnel_setup function, the perm_addr field of net_device is 
> currently assigned a random Ethernet address:
> 
>         dev->flags |= IFF_NOARP;
>        - dev->addr_len = sizeof(struct in6_addr);
>        + dev->addr_len = ETH_ALEN;
>         netif_keep_dst(dev);
>         /* This perm addr will be used as interface identifier by IPv6 */
>         dev->addr_assign_type = NET_ADDR_RANDOM;
>         eth_random_addr(dev->perm_addr);
> 
> maybe this is not a valid justification to set addr_len to ETH_ALEN.

I think that having a fake permanent address for the purpose of IPv6
interface Id. generation isn't a correct justification for setting
dev->addr_len.

If setting ->perm_addr and ->addr_assign_type have side effects on the
acceptable values of ->addr_len, then the commit description should
explain that in more details.

> I will make a review setting addr_len to 0, and will resubmit the patch after successful testing.

Thanks.


