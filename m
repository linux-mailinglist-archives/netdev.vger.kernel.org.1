Return-Path: <netdev+bounces-239740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43CC6BE2B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 779EC35AE9F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC522D9ECA;
	Tue, 18 Nov 2025 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuwBmuwc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt9ciY6B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5223F429
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505601; cv=none; b=Y1nodLSumrdH1nsT8RyeFlEJqjStjlp1JSt4iTOody0y9xn1WUgrBo8VmZvhVNMWtc5wjC3XlQAKJC/BA5mRNh1vPwna/GJ0tRWmk9NthayXbLwy5gtb114dec6EWy5QpbczcuVJOIP/kPPbdlT7akBdKwEdf06e9VrEk39escE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505601; c=relaxed/simple;
	bh=pcJMnwVwfVuhAv0NrDemuQ0DXz73W8XvYi+UP7Aov6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxUELdk9b+K+8P66K7cg9XlLyWLvBJ5fdqW5fghTsMf9nXWa33Pbbl1YqyRpUtLF/oF/8moAycaIzieEHcWnzk+vSc7K+HnbLPwUQh/e8KbSZvy7jN8ncOZakr6jqaX1l/B3+vOXTh9XDIEksw5+M53MFDsNm825/Nd8Ov5IF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuwBmuwc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nt9ciY6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763505599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGwomD69lix3vazkeV/4gZbgPJ4JRm/KwTTbCvFqgvs=;
	b=AuwBmuwcjRFuSXa5QP3bX28h1VjWZVfxtNr7s4wKRqY6BN17mRJN7SX/ztqznkqPk6I0Z2
	21N7gzxQX5vFTCnVXsZiOhvQ4nSE5vI7iUtvAzovKk+53hWRgnj3GQoOBp6cdbmQVWqdwD
	flQpVm2sl29pNF8sq8R0EwN1e40eMwU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-YnOUx1Q9M66807_9xOyzZQ-1; Tue, 18 Nov 2025 17:39:57 -0500
X-MC-Unique: YnOUx1Q9M66807_9xOyzZQ-1
X-Mimecast-MFC-AGG-ID: YnOUx1Q9M66807_9xOyzZQ_1763505596
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3ed2c3e3so4241778f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763505596; x=1764110396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGwomD69lix3vazkeV/4gZbgPJ4JRm/KwTTbCvFqgvs=;
        b=Nt9ciY6BbR999TDwpqOjK4CmIOioLVbvU8mFR6Q3magIQAskQBTr6pD9pKZGWGRkq1
         Glzs/JJMvDyYpeQloxIKOPGv5IxC07kFWtX4zqpXhR6wfjnJlTo0xRSQoqFeT986tx9y
         p4SYbMJssCEBXxRcy52aliVmJ4B4+GdPoEPM+tjTtM8j9YvX6cVG+wLGI11R7lKUIHml
         JJAHf6jTt6mWSQMqUdE9fRbU0d9tl5szCQgn4Unkot1g6DuUd633vh2WhFQ9io8wzpbf
         luN2uinlzX7doLZ0TOvlkg7snR1P7pKQHFJAVgV1V7XV/qxy7xAyHYmR4q7If9DbnEiN
         2pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505596; x=1764110396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGwomD69lix3vazkeV/4gZbgPJ4JRm/KwTTbCvFqgvs=;
        b=JtIVsSEupB/SFsNtc1Ad94hxUpp/H9fH29cQk7zQuf4ZnnUU2rEMI6K+hPIZm9ES00
         k1injcest4F8sgzP+q8gsxjgxiCaZOZHm4SbTRF4EAEdCrlZmYZwMxY8kbahRFt0inmP
         KQbZfwzxhz3XX4HAcIxc0LXv7gcZOM6OiWuBbgWoewXWTSEYitvqQGQf2TMbOO00wTpr
         Nz6qcPuCh6D0cShpvpZOJYC7r2SbqmHabxTOGb7FL9qf8FT2iqnf0u+2tfZQKRwKMHDK
         3Hj7CmyezSX3TBrQ8zoRffiIUecQnJwLrH8wjEPV/hh6FjLCCVEHTekUUHR0pXx+3aqD
         wHzg==
X-Gm-Message-State: AOJu0YxW7lsgXSE8117NgpoSFXSEf0aGc+IF67j3+01P2YEsbpCFdOqU
	EMM9jlrwuiVHUrlwA3LSGhmYaqnBqXwlWCzQSDtvZ5qoiMH9c1yvhjaXWzYZcVaoiI2PwIrsrIV
	mJArsWaTh4kO5+kpTC0E57v8pFPN6OjbcFV8x2dLnzpJpZmA/gXQZTHCKr9ANgG4rrg==
X-Gm-Gg: ASbGncsWWmE/OmBfJ2GNAh1fNVbUS/makkmsiHRqw8EvMsVblDlWsapZAqyVOeb5U0i
	cWXrRVKnn8ucHPcqjtSayhq99TfJAXsLINL1+49L9RYS3VmrVf/UMcNrULGm5tUww/69F6UgwwL
	iUU4sfrQWgJbsKoeEJA2geOXDJrmp8EqRCl2c94YWo4M/bgUyC+eOJeGnS9HN38MH+kJ2+Odatj
	MBkdstmGJ8ohP1b7KFCAyANdrk22pTtmVYkgn0AtZHIYykvgNMn+Y2uNWAoAx4q6avfiaEYARzE
	jIdUHljmfz5kzsTVVtQ5BtQlA9ZTufQbjcpnfssYDFzRmzPV0V4qe3aBtFKzx+6mJIBx1Fq+1nl
	cL5vWefAUsnkI9V2nsAg44ouo/9U+pg==
X-Received: by 2002:a05:6000:2893:b0:42b:4267:83e3 with SMTP id ffacd0b85a97d-42b59328eecmr17242535f8f.5.1763505596152;
        Tue, 18 Nov 2025 14:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD1WXbpeTqGswyhHCbNu0ZoFpF+0A5MJA/2kp3FgmfFeFluN/ImIhzShp3w5/uqusP1NAnZg==
X-Received: by 2002:a05:6000:2893:b0:42b:4267:83e3 with SMTP id ffacd0b85a97d-42b59328eecmr17242508f8f.5.1763505595682;
        Tue, 18 Nov 2025 14:39:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206aasm34790802f8f.40.2025.11.18.14.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:39:55 -0800 (PST)
Date: Tue, 18 Nov 2025 17:39:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 12/12] virtio_net: Add get ethtool flow
 rules ops
Message-ID: <20251118173847-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-13-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-13-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:39:02AM -0600, Daniel Jurgens wrote:
> @@ -5665,6 +5672,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>  	return vi->curr_queue_pairs;
>  }
>  
> +static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int rc = 0;

not sure you should do this btw - it is set on all paths,
and if you do not set it here then compiler will warn if
we add a clause and forget to set rc.

> +
> +	switch (info->cmd) {
> +	case ETHTOOL_GRXCLSRLCNT:
> +		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRULE:
> +		rc = virtnet_ethtool_get_flow(&vi->ff, info);
> +		break;
> +	case ETHTOOL_GRXCLSRLALL:
> +		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +	}
> +
> +	return rc;
> +}
> +
>  static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);


