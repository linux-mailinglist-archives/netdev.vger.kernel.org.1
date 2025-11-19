Return-Path: <netdev+bounces-239859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338AC6D37F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9834FAFC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A42EFDA6;
	Wed, 19 Nov 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2+vnlxo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs6v/G7X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB42EF65A
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538300; cv=none; b=i5X9fpX/2FShGtkG2r8ea2cE1/cYmChxuQ7IFdEqH7bKLwiIkp0WBhkM7HH5qp9NZbqg4L6wgDVLlgim697DMtoXuH0IsRYQHi0I8ZYXZAVg9y6vpb89OQXmsYFJfdzbB5FfvHkUUNW0zZhMEUOxh6F75wDdnqKCvtKM0XrrMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538300; c=relaxed/simple;
	bh=iuSZl31cNfDpjFGTCAraDYIGCIdU76ltAKtrCane9BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC5rTz/rSF87btQosnuAia7p+ndvkelF4oCFhFSdzfTD4FvG33rQwmK/gAVx0rC+ZF0W9plmapNZ+Vals9i1Acd4NEMFN0Zaz3XT2XQMAFkMIyKYMqpEvaS+9Cx12L0+DGgy6XCVRapo1DQUMrvCTE2ClKCKVPvHO23wO/cD/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2+vnlxo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cs6v/G7X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0lOA/3gST8Mqd9BJA+pnAxs8ONfmdiHTJHfsZRHtys=;
	b=c2+vnlxosTDvuan0HF6jrgCJgyLnLaPEl9hgjvITGJObPLrwp6V89SEx358/6GRZnp13FK
	gbCbbT23G0spZbLE2Dgb5NbBDCvKLu7ZwGjDfo8OgR5EOwUx4rqyD26C8eTndga9sBkHXA
	HD9tZbwQjiHFiVFqD0f1zt73BqgvmZ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-HY4pqRoDOciSyI5u6RgS5g-1; Wed, 19 Nov 2025 02:44:54 -0500
X-MC-Unique: HY4pqRoDOciSyI5u6RgS5g-1
X-Mimecast-MFC-AGG-ID: HY4pqRoDOciSyI5u6RgS5g_1763538293
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b56125e77so3225739f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763538293; x=1764143093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0lOA/3gST8Mqd9BJA+pnAxs8ONfmdiHTJHfsZRHtys=;
        b=Cs6v/G7XDbGtSG5atUhUe5aUzqd4X/17IbwBpaV0iO2EC3DNYd/lUPHtw0vjapCAOI
         7ERnjSF4OpkqgOdF7mDpt8Pp0Gt51AKJvwdIyQ8qEqwjDv/jvCdlhhXvZWAeYRDw+qjX
         c2RNqM8isI+UOUuA/MTg/ArMLE3UgUYJwV0LOgqDeawV8rSpOmUcWUJ2dIU1tbGnJro4
         W1HQjAevPsq+g73Sp+AmPNQK6HHrWiEK3sCBkTG59IXaYPRzARsizTolIKsw+GwzxrZ4
         G6dpZilzKGcjgfq5MDZ3jnWgixqjzwIcO1os5T1r6otUbKwglHarhu+3S3BG7C3bpvbc
         yG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538293; x=1764143093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0lOA/3gST8Mqd9BJA+pnAxs8ONfmdiHTJHfsZRHtys=;
        b=YmAa0xbkemVTISLQtr9I6JyMTO94FLL4CUxVl1FSK7538oB9dAc8LzK5K13C2lCYnq
         C3qafBKY3clVSxsh2C6gSuB2xXOOHnfhN0gb2qmxUXCjEfu1+b6MK2ados9lxEpKVDW6
         xgMWCGNR94XgUSigjLOAQEj5qiqLAMJiKlqj1WfFj5IsChHCfuUxKGHY1vnX3/dns5fs
         e2rLn8RoB3G7SaxvIQSXYfqavnnx5rQk4lZCbBUW0GKfGxsfoyLwczRtNUZWlAXdI51s
         ZtdI+7EtaWOVGRuCDT39GvlH8mlosNm6Y+JlHGhpQTE39V1BqtRX4CZdtITM9AXudXTY
         8KDA==
X-Gm-Message-State: AOJu0YwxavlZ+04c03hH1m9+nk5Q8lWBv89NRxWI7Bn5/PnykB67fk4s
	CElA4mQ8h51rr6aB8ZiO4IfveVFxpDem5IIzkohZlYRMuaI9FxWPK/yugTHetZKareRS9AZIV0w
	fylElAcFuYEA+PPTiOMGb6ktSkEH408Ktt3JsI5SDeEH8Fkb9DDJY8gDTDQ==
X-Gm-Gg: ASbGncs6hNGgD2WlUK6O95aH7+mAaix0OmWqiaDG6F4ME6stpU2njYflVxIwIrBb8Lb
	fgHYywRF9VSMvL2l6QjCsTGAhVpJhbiAPVZDxJwve2EMyLCNJBfh/ptCahn2COYFlw3+YII3/0y
	AB4IjFEjqbbZWEZA7gGQo5pKcNq05l3TooF32zh+cPSexBt4zOJEMKI4+BWSddd8KLADDP+GTyg
	XPTT5lwUCctj/yOwlgffrv1J2Elk4HCUGrsg1eH+TfWZZSE+5hkAcAjA/a4FLaWIaSqssUvRwX/
	+FFznC0Qz7gTF8qJqqrlT/fVNuaLw+UHkLwOxxCbHNRHGgyka12lbnvi/U0P8efIZkJaoi3jL5F
	cELJMD/yHIWahfo8Cr1ee6+UMxoPyvQ==
X-Received: by 2002:a05:6000:2dca:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b5959eb99mr20019764f8f.58.1763538293220;
        Tue, 18 Nov 2025 23:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ3KY8fQWjUFd8SZEAKxtk7NCRnw14euQYQO/Wu+mrmA7H+k9ezFKlDwa1hXnBT1QcYNK6ow==
X-Received: by 2002:a05:6000:2dca:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b5959eb99mr20019727f8f.58.1763538292694;
        Tue, 18 Nov 2025 23:44:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae47sm35263724f8f.4.2025.11.18.23.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:44:52 -0800 (PST)
Date: Wed, 19 Nov 2025 02:44:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251119024442-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-11-danielj@nvidia.com>
 <20251118164400-mutt-send-email-mst@kernel.org>
 <b49d6c7b-ba39-4f9e-9e75-b3f186fe8e0c@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49d6c7b-ba39-4f9e-9e75-b3f186fe8e0c@nvidia.com>

On Wed, Nov 19, 2025 at 01:35:37AM -0600, Dan Jurgens wrote:
> On 11/18/25 3:45 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:39:00AM -0600, Daniel Jurgens wrote:
> >> Implement support for IPV6_USER_FLOW type rules.
> >>
> >> Example:
> >> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
> >> Added rule with ID 0
> >>
> >> The example rule will forward packets with the specified source and
> >> destination IP addresses to RX ring 3.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > 
> > 
> > I find it weird that this does not modify setup_eth_hdr_key_mask
> > 
> > So it still hardcodes ETH_P_IP for all IP flows?
> > For IPv6, should it not use ETH_P_IPV6 instead?
> > 
> > how does it work?
> > 
> 
> Your right, it's works because our controller use that field. Will fix it.

you mean does not use.


