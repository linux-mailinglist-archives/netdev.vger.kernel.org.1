Return-Path: <netdev+bounces-239847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D1C6D07D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0585C348609
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685952E7160;
	Wed, 19 Nov 2025 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5lAqwHx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvwcZlsy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60572BDC35
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536005; cv=none; b=Z30+XYHEfQNh/dzrnMYh3fhN9GvCKb3UBPPtBNu2EHuwWgK//dmxg08KuhjJsB1Kvc4/gIYm32vAKIAqffDFcZ3tT7bE0amVJe+rIwpPjm66SOHMLCMSkyGOnQfiKxZenlH0fXf68OlaQHd9kEV3xEYOT9onCZo9gWVMbB5upoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536005; c=relaxed/simple;
	bh=qC5kJxM9wR/6LND7jvsyFwaiNM4eVfH035BJk7NQwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI44YydMA0g417ZcHyTfXMilH0xVATpeQQ4ABA4qVOZMTvvjDSsvA47SpMUzJhecys+82GYjE/e6ivBxaDp7v37I9H4wioBqmGS4QXiFhnKGGPSgHbz/xE3CCQwuhTMh50AcEXPg+m9/FrswaPYt8hA8/q3PAAOIUgGtJ3eNa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5lAqwHx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvwcZlsy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763536002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJGx7+wTnT+9NZOuM1iW51UnHTE1oWUSxxWBxIO6mxU=;
	b=Y5lAqwHxIXfbKZUl+8oKa4VXQ8UYZhYSk0Vtx2+GEUbqzMgH+eFmI+0Xe1t6pdojxUAiph
	nwUg/kP6pLcp8syBH2k7pXNiC3QZ/EKV7I3ZYbvVQDIC4iJZGD82tQY1GW/Y2n4RlUVnLq
	Ck8VKoPsIzo5Jicc4S25p5VxVFMw+NE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-aVf-fgyKOMeOiEQQIIW04w-1; Wed, 19 Nov 2025 02:06:40 -0500
X-MC-Unique: aVf-fgyKOMeOiEQQIIW04w-1
X-Mimecast-MFC-AGG-ID: aVf-fgyKOMeOiEQQIIW04w_1763535999
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c93a28ebso4649296f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763535999; x=1764140799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJGx7+wTnT+9NZOuM1iW51UnHTE1oWUSxxWBxIO6mxU=;
        b=ZvwcZlsySqGbeg7gZKbyI8IvtYyUA3DW058U4tO3Y7SJ8L+sSq/BJwIcpLjsYBLs4V
         68FP2yZqGI29Q4IFSpW+pO9NhpPJjW4ORkzZHH+N/fK16XkYX1kpsFhUEY9KewYccf7c
         EwthIiQr5MpmX6mgYz/a3XrwEw0VS2y5fPzVWYMRWX6v7Zju8xtQBqJdIwnSziP/gqx+
         srX5tFz/VlS+C6h30GoC/JHzah0EsBFSN3gyCnNnPXTEfJhb84RRWkZiVbOPKyos2kHh
         WlT7zIm8dh9k/R4MPs4APlPbIg3WqN0Gxr1y7mH5SxVvtArhAe+/MylEszUuttWCFeec
         QAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535999; x=1764140799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJGx7+wTnT+9NZOuM1iW51UnHTE1oWUSxxWBxIO6mxU=;
        b=V1dyiHkJTPn+exDAFWcKW3ZTt9LmvBbZ77aUVTgh/UWr+PUoZaXF+doLdu42o0Azkv
         DlfVAhZMlhtFyuOlvMGG3toOvFOgXM2j0XxQNi2d2t45LO8dPjwCrQ1+YvwhlkJBlLjz
         79zLpDrMQrdsuleUmdoyvqJ/N5EdGMt8YhCEbjrqd6KA5O9TCHiUvXOY9qCViMPmrAt0
         i4diSAgs1eEl6tzkK3ijqjVlDTag8h2WLOZ4w4Io1s+wM8LjX8YHRIQgiIzyu2C50aja
         TVlUjoyhXF09+zj+SlzrQIWwzSfbnv27jlwsDnVipDH92/hFqymCagTjB5Npo8CuPGAM
         q51A==
X-Gm-Message-State: AOJu0YyVoyEchEH2aI9r3qurTj0if+2ufgS7F8/3ALh0q4jw7cOFfKQJ
	794K8GGhQriVXw51mQ2mUnoseB7TfzXPXvQFzly01DhDKNePIhwFz9wNFTzey10CclZ2S0ud0iE
	etbOTVKtIR+a5jI5AWDsdrZ+II9c+7C95nRX7FEdDrLeMBtBbQ6usNt7lvvLEFVQ0kg==
X-Gm-Gg: ASbGncudsyf9pRtC7f+naE2qtFGurrfPVNBpKoSmqgH4XBsllx84d6P6YOHsUu1erIB
	RQUKR535ecZeGTsgnXZBWZsynQN+i42Dml7oRWNzUlmPI88hOf1P+GfMz7/HB8w04d2WIRvkztN
	xHOFH0BAWmoTnsa5f5KLsACNsS0Blo6oMRFDBx//aj7oAZd3cVayxnxhiR4SUsHQT3+imLaTp4Q
	DggFga2AKC7knQGfEUAt3lbiU7gppfJ4EVxq2PK7BSN66AOJhPhMRHA7NkUFo3wRJVtCByY7co0
	THYV4rPKzyO0JwrDfi35jynCdiuK5rj7jcO+YVeuIWEZYBHUoMb+d49gr24c2/WErPmrPSStOq7
	V2ck+m3qyzWVXkXjy980vy86H2OGWuA==
X-Received: by 2002:a05:6000:4210:b0:425:73c9:7159 with SMTP id ffacd0b85a97d-42b59381bf0mr17637634f8f.33.1763535998901;
        Tue, 18 Nov 2025 23:06:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRUIIc6RK9F4rAyngAl3z3aoaf8Mdkc38zKW0SHUpdZcH4dc5Sfm+4K04fSD8lBSrGft/7xw==
X-Received: by 2002:a05:6000:4210:b0:425:73c9:7159 with SMTP id ffacd0b85a97d-42b59381bf0mr17637595f8f.33.1763535998357;
        Tue, 18 Nov 2025 23:06:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae16sm36662236f8f.3.2025.11.18.23.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:06:37 -0800 (PST)
Date: Wed, 19 Nov 2025 02:06:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119020521-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>

On Wed, Nov 19, 2025 at 01:03:36AM -0600, Dan Jurgens wrote:
> On 11/18/25 3:31 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
> >> Add support for IP_USER type rules from ethtool.
> >>
> >> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >> +		      const struct ethtool_rx_flow_spec *fs)
> >> +{
> >> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> >> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> >> +
> >> +	mask->saddr = l3_mask->ip4src;
> >> +	mask->daddr = l3_mask->ip4dst;
> >> +	key->saddr = l3_val->ip4src;
> >> +	key->daddr = l3_val->ip4dst;
> >> +
> >> +	if (l3_mask->proto) {
> > 
> > you seem to check mask for proto here but the ethtool_usrip4_spec doc
> > seems to say the mask for proto must be 0. 
> > 
> > 
> > what gives?
> > 
> 
> Then for user_ip flows ethtool should provide 0 as the mask, and based
> on your comment below I'm verifying that.

but if it does then how did this patch work in your testing?

> I can move this hunk to the TCP/UDP patch if you prefer.


not sure what you mean so I can't comment on that.
generally it's best to add code in the same patch where
it's used - easier to review.

-- 
MST


