Return-Path: <netdev+bounces-239850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446BC6D13B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD22A3818E7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197153191C3;
	Wed, 19 Nov 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOX5I+PU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQT0Wi0W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2131984D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536853; cv=none; b=qRxtfhEnhTb7PuHu/90Cvi71tM85etvJsIdV+OWSezPpYX7DqhHk9wfI/MgXd30C1pdulg7y5hZ2woo8GGlg8Jh//hpg5OKL3Ouso/jhKllfKLzsc/VHRwYatjODgwCJPyRAXMunU66sGpj2SfpGXWHseqZis6bVOdq3Ng78Ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536853; c=relaxed/simple;
	bh=d5oYqbc0GgF/St+ssRaSW3VtqPJr3GgkpOW0pTSozDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2uzRbr/Yw7Jnw3THfdcO7TYYlZHce4+OoGBvqe56No2wKBbl5GthOcTTiBqslPZ0hyVLF6R7S05jYJLSif6p1s3TZi2FV+6O+QE/mM47wSxg6vAYUS2sUABZV4WWOARxbUMV0L7KsIQHXe/QWU4TDUdibs9ES8QQvsTz8XlLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOX5I+PU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQT0Wi0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763536850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbs5x7EWq0AowysP4qe5fQSEKCrLE5l2y4/OAyhVQl4=;
	b=jOX5I+PUI4dkpF7iOoIiUMjWrmsbdAYdgSY9jN5VNeV4N9E4hbmEeyEdpUYsnvMeWMqw/b
	gQQfbfIJuoUMSsOp3hVkNCdw4MlcwVo9TAX9X3yi7fxbFe/ivWxEg9xlnPqgQ/v6XlFxFm
	AvzdnLjPj0jU16lXufgn0ZafSsFFIhI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-v34mYFGHNMGv0uLUvQd-7g-1; Wed, 19 Nov 2025 02:20:48 -0500
X-MC-Unique: v34mYFGHNMGv0uLUvQd-7g-1
X-Mimecast-MFC-AGG-ID: v34mYFGHNMGv0uLUvQd-7g_1763536847
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so17276575e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763536847; x=1764141647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbs5x7EWq0AowysP4qe5fQSEKCrLE5l2y4/OAyhVQl4=;
        b=SQT0Wi0WIfMamI7TyuTD/OXnocE5hulJiXxlxjxnYd3Zy7Y7zUwkM27hbBMm2METpI
         /vfCsRc14GUmMzrZ4MERvbfSBy95qsgrocYicidrFYJU0a6xnccNm1+rL4KBVsxddhuZ
         b1tUToOC9KdFJCttMCctPRvOtdIrscG/paAxUey7z9TbYUJuJSrjMjx8SbYLsrk/TmkC
         ZVnGvgH/+MDLVz/5DVMFbgdgIqiiuffnFlTVUQ0NZDj9TNFSefIwF0XblF6124fF8EsD
         8O5yfdQNKR59DuY7uIAH9lsPZ84G9Ag2wo8/NKmMg/CTgu4no8sHj/YVE1AQ2Q5KtOjn
         jo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763536847; x=1764141647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbs5x7EWq0AowysP4qe5fQSEKCrLE5l2y4/OAyhVQl4=;
        b=DuBeVYOVbYk0xQINulWklkJdpg/KIyLbrkM1Bd9Mqme8JvSuwWnZWvXtIwMTON39F2
         /eAw8OLWDftL4KIV4dCNKXuvYrBRjqTIPk+gjUlzzoZLFKzIqLseXztlHSAc4FWhJXhw
         k+CZDheASqNtaufKLod6kVAl/0t/gkoaI/91Ubatt0N3vXF+xLUGLtMN/MhpFFxD8Mjr
         xF89Gs0rF2OpcqbW9SpgzpSruD1kMSDTpbXKejEtPUPxX6HiaMrU/P3B75b9RL/y8aaF
         eIgXbiNKLIZ+jS5L5oB4Qiy2SmZxYUTxCu4VMIW3HHnr28W+NoNVnpA4P2bzv+IKN5WE
         2qHA==
X-Gm-Message-State: AOJu0Ywk7VuVYT0eea7qWZeYyGlX6rnbYZXrg5A3qBf+zXvCxhjg6/q6
	6oR0hn4FtEPvI9R2yb5Zx7xcJxSXqySJVFw7QelLqQ9go/03NrUPCOB9fOohWdVTHfDUf07qcX2
	6E0eHaXB+yRXBHAM30PXbkbyyiS71mGcIEoQnt2MWjKHpcshAXyIkVJ/nbg==
X-Gm-Gg: ASbGncucGg02Mio/Ju9K3ECfIro8GnDTUC4E+tbIUMRkwKmR9FJs6Rl7LbfrWFLos15
	UAoCR/rvksvw0Mq7Tog/W5dOuaQeTDjDXTObURAv/ndZXzd+2FLWAd1Gm2hyaB0EQByjPwY5RL7
	mPy8zV/Sd8QmRePBMc9st96o6gacnRdX9mwSJp466DJvpfAbC00dc+kf4NnEASSeb/Y2xI162x5
	xogCJoNW8T3gghUjBu84x+xFnm0lRckD75W+trBy2znS0gPH2Q+uFj0u4d2wbOpxIVFHJPhsGwS
	Zwqj7EhnW2MOuXUwpYy5VEYYlw4foZEENLDXtJUeXL60yu8wY0ghcLIEShyZpqJrwHIdb8lDkrS
	rcJkSQfnyM2qtZKbLv/pYfIc5gzDFug==
X-Received: by 2002:a05:600c:1f1a:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-477b19ed12cmr8577665e9.32.1763536847349;
        Tue, 18 Nov 2025 23:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcCRyKAbuj6bf2L9WOClmuRroF9Z4nNGU8pZ4mhfeKrFqqwk0OsFutE0zlAxf7gESv3lyM9g==
X-Received: by 2002:a05:600c:1f1a:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-477b19ed12cmr8577485e9.32.1763536846939;
        Tue, 18 Nov 2025 23:20:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1076865sm32222375e9.13.2025.11.18.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:20:45 -0800 (PST)
Date: Wed, 19 Nov 2025 02:20:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119021926-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
 <20251119020521-mutt-send-email-mst@kernel.org>
 <e7b5bb24-0ea0-4b73-8548-3b67872a742d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b5bb24-0ea0-4b73-8548-3b67872a742d@nvidia.com>

On Wed, Nov 19, 2025 at 01:17:28AM -0600, Dan Jurgens wrote:
> On 11/19/25 1:06 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:03:36AM -0600, Dan Jurgens wrote:
> >> On 11/18/25 3:31 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
> >>>> Add support for IP_USER type rules from ethtool.
> >>>>
> >>>> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >>>> +		      const struct ethtool_rx_flow_spec *fs)
> >>>> +{
> >>>> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> >>>> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> >>>> +
> >>>> +	mask->saddr = l3_mask->ip4src;
> >>>> +	mask->daddr = l3_mask->ip4dst;
> >>>> +	key->saddr = l3_val->ip4src;
> >>>> +	key->daddr = l3_val->ip4dst;
> >>>> +
> >>>> +	if (l3_mask->proto) {
> >>>
> >>> you seem to check mask for proto here but the ethtool_usrip4_spec doc
> >>> seems to say the mask for proto must be 0. 
> >>>
> >>>
> >>> what gives?
> >>>
> >>
> >> Then for user_ip flows ethtool should provide 0 as the mask, and based
> >> on your comment below I'm verifying that.
> > 
> > but if it does then how did this patch work in your testing?
> 
> Why wouldn't it work? For IP only flows the proto field is not relevant.
> It only filters on IP address, not port.

I mean it's dead code with mask 0.

> > 
> >> I can move this hunk to the TCP/UDP patch if you prefer.
> > 
> > 
> > not sure what you mean so I can't comment on that.
> > generally it's best to add code in the same patch where
> > it's used - easier to review.
> > 
> 
> the l3_mask->proto will only be set for TCP/UDP flows.

I'd move it there in that case then.

-- 
MST


