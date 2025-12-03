Return-Path: <netdev+bounces-243405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14646C9F256
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 14:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B23A63AC
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A92FB607;
	Wed,  3 Dec 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e516qGpz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij80MzZf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41A2FB61D
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768845; cv=none; b=kiVBoJiglr268sGSNZoediZlFopBdU947tosp9M3ySR10jKE+pfhxNTNw35iLdN7cjVmkSfQMQmb1Jga6i86cNQUaU/5cto4X+dUk7AD857OO+hMDRK+DUtRC6I4lnzXcIbqBIjiHR9VUHVrtHyCxW92wH6oUpPUDqK0nHtmmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768845; c=relaxed/simple;
	bh=Dne/Ve4P+xeZREEkkpT7miAIMUs8CpeyyxsD+TSDMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpKqIAoinbVa/U9t3LITgpnlHWGBqWcH/3Aqvozhx685ETBfG3A757yIVX5kMofj1tKtI5hRfp8vAae6SVgJfLzx6Cgu/zASm6ErQ7GW1BwOj9An2Xal939QSm0yvT9Ca6QM3PyxD+eCid3ID6xSXtsYgmLRfoP1P6cI4XBxi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e516qGpz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij80MzZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764768842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5HapGAETBejFtPtETjP5Yr93HQBxIGVef1x+VaGO9I=;
	b=e516qGpzVliVgf9Uupa6eb1E0hB9uo2dvMkkIE6PiAdGvQGcJk+u8HGdHNhsjNB88x50zW
	q/GZwx/L3cI1mxh8y/n2plRWffw0QuL6+wgFAjsdntasVV5vdjy+k/G0swaNAWIGU2MhSf
	v6m7ULNg6YCMZ2e/uVevieqG8UT/FeM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-UdalYG9DOL6amF2zIKbMEg-1; Wed, 03 Dec 2025 08:33:59 -0500
X-MC-Unique: UdalYG9DOL6amF2zIKbMEg-1
X-Mimecast-MFC-AGG-ID: UdalYG9DOL6amF2zIKbMEg_1764768838
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b763acb793fso322332166b.3
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 05:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764768838; x=1765373638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5HapGAETBejFtPtETjP5Yr93HQBxIGVef1x+VaGO9I=;
        b=Ij80MzZfJevlkBQOthgHHtH4DmuSB1sx36n5CKczGsg4zQ5TG6JirGC8LUY06/REfS
         d7P37u9XfB/bjgamqz5B0umTZKnQFKgogDU0iCWV6A9Vo9kA/M/grWWWDKpYIZiftvmq
         Pig1zPgrxRQ1XQ4PriL7RBeO7KTtT4baR3a5nRfeZMUXrfq08y2QdHUgcUrg8t8datnC
         3rhHmtORn6Pt5oRWUCYbwDGymvahinuOM3PY9k6Hinxg+7m4VPMsvkG3unpTnLEQ/ziV
         CCH7kOIu9nbXpT8mCKSW5T/PLqAEVJdhX7T/oua7vAL+65CzfQNCSeCxv/nnwzmMQGOS
         CXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764768838; x=1765373638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5HapGAETBejFtPtETjP5Yr93HQBxIGVef1x+VaGO9I=;
        b=KOciG3fvtsw8Dla0h1AUGZojkQkNrIVhw3qgwQPGVpo+vEoPiU6wgZJyta0ZQV3TVf
         4KafSpE4YeWwhcmJD/p53CB3ZRQvLKSiAfCd07UQcCz6RpjrdG4u/opCsfN5gZkcW43C
         mgoXSpPqxu2JaMTld6H5S0Jhpt4rnfQ/mjgHqoA9vo5fe8fiAwHz959Pq4r5BexQK16u
         t8g7Yqs4Gb97YGWVdmVko8Lp6FZ38slYqX/+NmIk8mcea4SbnG0zW8aXCc4CbaPwo0be
         dMZET0Pneig1d3/pcO/ux46OH7/5r8uH+Zk+3Xo4ai93BxO9+NKWQUZbdnrjxWNcJCmy
         NPKw==
X-Forwarded-Encrypted: i=1; AJvYcCVunjsH4MdJmvTbV+l9C06doCLIZPChlJjhum1d6cIhurhOlWuLGqjsLRq5eR6R5UoibiqcPWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+dVO5W/dH4/aI0eKoI7gIUytzl/VefTVykSY7tqL570+xXda
	d8AjNBiurIOzDx/yoV3LfKods+KOxxgsoaPh/6MBj3KyF0zt0srASySxYO2r0VY8l7i3+6rbBdg
	WbqIp/FHKiUTjRKvUw6jOfM9DAXaaIDlDfht8jfk/LA4wVtTuSDtIe/DMGQ==
X-Gm-Gg: ASbGnctEUEJKmCZM1uazZodPO6aZ5qME5MPqVOK5wVsgmQVoJ3t+bzOX2Cb0zbtJGJp
	cHsluMTjgL0rmiHXyGgup5JD7OJ4TeulW5dnhq20/S0oNDGd2klpIr9Ka7kZxmn9cOFAbydZbK5
	XxgpgF1WVkqVH4MbeIer7O43q7Pz7SH0TGrkqx+pBY6e8gg+8cEsntMavKGTaWRe1Fzov0UQHVj
	qi5LuC/Fo8XD3UwfyLWq2BvsFK7COkSmDwqM4rx1KtY2bGGBgCug26W0oiQsCHS279cyyPgzX44
	CiffiRru+aBNa26wtmdmL5Bgr39FMqx06ZQQUZUg1qW0T81kxUrKzYN2cJGMp6rsz4f9Lv+jpTk
	=
X-Received: by 2002:a17:907:3f9b:b0:b72:a899:169f with SMTP id a640c23a62f3a-b79dbe487cfmr252937066b.4.1764768838239;
        Wed, 03 Dec 2025 05:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRkbakFynEx+xbWrRzIqBtwAstWd7O3+OSlCU8/PG1Zhj8xJARmcIDiai4geXLID71H0TAfQ==
X-Received: by 2002:a17:907:3f9b:b0:b72:a899:169f with SMTP id a640c23a62f3a-b79dbe487cfmr252931666b.4.1764768837661;
        Wed, 03 Dec 2025 05:33:57 -0800 (PST)
Received: from redhat.com ([31.187.78.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f4d533f2sm1797209166b.0.2025.12.03.05.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:33:57 -0800 (PST)
Date: Wed, 3 Dec 2025 08:33:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251203083305-mutt-send-email-mst@kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
 <aS8L--z0ezhkywT_@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8L--z0ezhkywT_@horms.kernel.org>

On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
> On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> 
> ...
> 
> > @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >  		mask->tos = l3_mask->tos;
> >  		key->tos = l3_val->tos;
> >  	}
> > +
> > +	if (l3_mask->proto) {
> > +		mask->protocol = l3_mask->proto;
> > +		key->protocol = l3_val->proto;
> > +	}
> >  }
> 
> Hi Daniel,
> 
> Claude Code with review-prompts flags an issue here,
> which I can't convince myself is not the case.
> 
> If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> as does this function, then all is well.
> 
> However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> flows, in which case accessing .proto will overrun the mask and key which
> are actually struct ethtool_tcpip4_spec.
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10


Oh I didn't know about this one. Is there any data on how does it work?
Which model/prompt/etc?


> >  
> >  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> > @@ -6022,16 +6107,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> >  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> >  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> >  	}
> > +
> > +	if (l3_mask->l4_proto) {
> > +		mask->nexthdr = l3_mask->l4_proto;
> > +		key->nexthdr = l3_val->l4_proto;
> > +	}
> 
> Likewise here.
> 
> >  }
> 
> ...


