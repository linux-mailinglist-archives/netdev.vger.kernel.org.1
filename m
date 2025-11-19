Return-Path: <netdev+bounces-240086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C6C704D7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D16638799C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B529F36921A;
	Wed, 19 Nov 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMMUe6L7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="setWmwgR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914B368271
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571126; cv=none; b=Q0lhRHzQuTdWSSFQw9xujWzXkcaDTBRGpxcxkF6tVck1dHiL9PMCWKYnRwYgvJ2PAl5ySvH2qVf8udVBwYW65O9oT/WId70qZYtUI1AIf/OgmQCnJ+sBQ9MZYqSdFY18SVruEvHqtuQwytLRuJgIrdaaC7mKUkddB/iiS7oGXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571126; c=relaxed/simple;
	bh=4ioazr+rErlQAmgFmhcgugwx4ST9WMu2Co1jE6pk2p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4Yop+VOD9lgKf8X0lgI5naaJFNZY9ytwqlDu6eRoHnQidqAu1E3MuIE++YeY+KcVJTrqW1Sr0P6GHabTzxocnAsQuAPOhZwIK3Muug8iWdwUtrdiJMeyYLBbfsO4RAI1crmYhnmM1pLfL5om8hybVVoIX8aUeRp+9LUjPncLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMMUe6L7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=setWmwgR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763571123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uGDdV1wZzMygZPXUS+BFjZbrrq0xn6nPN5Vu0ZlXeto=;
	b=iMMUe6L7Z8Gt9BQpUqlpF01jO/5Ys3vXbcXJUHd8/cW1svteDkyFDOvycbEoVCf6PXQ2yL
	Aqdg2eYuemOREjUn6HSugHkE/CRMzuLBXiwVhJIMxYif/dAE2TBFiUztOCdqrN4XEdk4RM
	mzoL5p1+r/3epNgpqvMZXMv0GOgGPS0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-IV32xKBWOBuB2xqiVPqBhw-1; Wed, 19 Nov 2025 11:52:02 -0500
X-MC-Unique: IV32xKBWOBuB2xqiVPqBhw-1
X-Mimecast-MFC-AGG-ID: IV32xKBWOBuB2xqiVPqBhw_1763571121
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477212937eeso45484515e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763571121; x=1764175921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGDdV1wZzMygZPXUS+BFjZbrrq0xn6nPN5Vu0ZlXeto=;
        b=setWmwgRfLbd6EtMxx9cb3ls6vYpvAFQrlJmpJLiSVdclzUzCMKvduu/BTz0bzquJ3
         jTbPtan8ocd1y514TnC16Ibj8bYhZnXNI0wPiMY6/ZRbXYQ4eM8XmWgM3d3qHn7MYB4d
         Mq9q+dFxzVf/BOlrIO8YMe4zVKm4aRv4Z09Tpc0uRhiklfapa/ucCJa6/Lzg+ZMRN/zz
         KHxUCkqXdVNFrf+VG5B0zRt/gNEBIe1ux27JUv6iQe4y2bSmeLPCSK8vkND1UNSA1Jiv
         Pgcx0ONLivDyEmWCIy1V4oPd91t20lrME8qA1gRn1tXbnGtEC2O4p1sGPNnEikqNJETw
         chSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571121; x=1764175921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGDdV1wZzMygZPXUS+BFjZbrrq0xn6nPN5Vu0ZlXeto=;
        b=LqK2DFCVpUOUQCCEJywq1vGRT6ZaOn2+MwfAgLW8O3HmDZBCHFQ6EjFJDE49ounY9w
         XNB5OENsyqi/DealoAxD6jumJaenB+dC/05vm6JkiNSiLYkGMHXLctK8zxTqmPW13Ba+
         5zD3Qg8J3bMODvtwck3rpnvUWURZKQry9U8KdpwICQk+fLP8gvkGPy4zpmoZQIuI2m7/
         fIHsbqy0MlA1g2q+cEw/WN6YbHICunGorXvIwCmHCYzXMA0X8kxu+TG0KYU+09RURr12
         kTzJMRoPdWPAGBS9OkhQwdu5Wfz75MUEY8gw710BIWHHc8RnZeAV8/54HxYlzOFYWfFc
         KWsg==
X-Gm-Message-State: AOJu0Yy1KC02uhtktEDTM+zWMM4nwsJOw5/gLz3fpZXGYufoCOOnkHsX
	JCMjX/w8qderGv/Dpsvus8eAI5ePX98T+dRrLEakzBsV9+ZvWQZ+zhvtfWTHtu30Wg3EBJgwPAZ
	rqVkzlot36MY+L99HAOF2Cv1qFoTPlq59gvX7TL48Aorx/9eggIgFFcBZaA==
X-Gm-Gg: ASbGncu6heaaSeBT5q6/FSYPZD7nbq8CO7MMliHcWJFrTm4CnhbKdhNb8U1c3QMBglY
	H0HaDkI9KVe7d6sEZqZexdmgAZizNK0DXpKXfaHV3KLL14nNfHCknqQ/oPoaZuxwi1OL5JHPSWB
	SyLk7IOWpX4JlxqmpIOFm4o+DkUm54qHe7iwhU67FkZuqnVvPXBh45Ya48ZWZU6FHhIoGN9sDH+
	c4gx+0zh/EmL8bbzV1XgkSc7PPa7BDxM6BFROvEnaVXP6xXul6aFxOqZ2BkKJbNBGnYeLncqK+K
	2vGZIocJ1Z9zNinvzn15hHO3yclE4eyWhcPd8Bj6/j9UC2mpI/m6aRIh9es3UhLg7CGFJLJ4VsH
	JesQt+CFzVcNMiSIFBDQsx6fIXXUMVA==
X-Received: by 2002:a05:600c:1f88:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4778fea7579mr172318385e9.32.1763571120716;
        Wed, 19 Nov 2025 08:52:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkCnAWqylPnRvfnAU1+MUgF93xF234J4nNqKzo6llZD/6bIaoJV/mwKhcnyL5kC1Q0Nvad2w==
X-Received: by 2002:a05:600c:1f88:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4778fea7579mr172318205e9.32.1763571120251;
        Wed, 19 Nov 2025 08:52:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffef34sm57829355e9.2.2025.11.19.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:51:59 -0800 (PST)
Date: Wed, 19 Nov 2025 11:51:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119115113-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <20251119041745-mutt-send-email-mst@kernel.org>
 <103955ba-baa7-4b0b-8b9b-f3824ad54b4d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103955ba-baa7-4b0b-8b9b-f3824ad54b4d@nvidia.com>

On Wed, Nov 19, 2025 at 10:33:31AM -0600, Dan Jurgens wrote:
> On 11/19/25 3:18 AM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 04:31:09PM -0500, Michael S. Tsirkin wrote:
> >>> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> >>> +			     u8 *key,
> >>> +			     const struct ethtool_rx_flow_spec *fs)
> >>> +{
> >>> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> >>> +	struct iphdr *v4_k = (struct iphdr *)key;
> >>> +
> >>> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> >>> +	selector->length = sizeof(struct iphdr);
> >>> +
> >>> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> >>> +	    fs->h_u.usr_ip4_spec.tos ||
> >>> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> >>> +		return -EOPNOTSUPP;
> >>
> >> So include/uapi/linux/ethtool.h says:
> >>
> >>  * struct ethtool_usrip4_spec - general flow specification for IPv4
> >>  * @ip4src: Source host
> >>  * @ip4dst: Destination host
> >>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
> >>  * @tos: Type-of-service
> >>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
> >>  * @proto: Transport protocol number; mask must be 0
> >>
> >> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
> >> documentation? But then shouldn't you check the mask
> >> as well? and mask for proto?
> >>
> >>
> >>
> > 
> > in fact, what if e.g. tos is 0 but mask is non-zero? should not
> > this be rejected, too?
> > 
> 
> Actually the tos check should be removed, there's no guidance it should
> be 0, like the other fields. Our hardware doesn't support it, but this
> will be caught in validate_classifier_selectors.

same question for l4_4_bytes then.

-- 
MST


