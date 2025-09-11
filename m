Return-Path: <netdev+bounces-222224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4ABB539C1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A3E3BBB11
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F335CECF;
	Thu, 11 Sep 2025 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7n6Uw95"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E951DD525
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609845; cv=none; b=fXSc/PeSbV848VuzorCQfUDrdtxi4RJz4GWFWCoWMjQXQsBrKtIOhmLL1ers+xrlOisdjjb9O/bp2JSBVOXmZ5BpT1Dour4y081HZHEu3PTeUlx0eeR11ZrUWpb4o6gSGGajVmAI4f9kCu0BypQRZ+j36WB2zN4jn8wJqjPHYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609845; c=relaxed/simple;
	bh=O6HPe95NIHtq2ihfAc3XL6zSiGDm+5m5+ny6mMoYml8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8UOqVW+eTLdpPkuUTglBfQkma0ApV5jLZB3SukHcOD7STbtHuSJPomPckW8iHU8FYeY+Cwpw4Ip7H2x7iPw5pLHDLabc8bDY9TjSQzwlncXelOAtmCmmhHDQjKWEGaegx1CiLi45VPSBO6nXtdBrl2HKrECsB08VPAYIpW18tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7n6Uw95; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757609841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oNFHEb5Nel7e8bjxdQl/7q6UZJ++hB6LOdcQFAzOBI=;
	b=G7n6Uw95sAMbqsee2B5qlfcDX1qqIiiWlCcL58Ls6Tpb9gAuEggqYvazGp0q+bZbQN2sZD
	4UbK8rp8Z/dcVXS9iLbLnPagyUx7QYcCMadBpP2USrVlM/tL+pzFo+W29076DzoqEGJ4lv
	EQdrGs59RXbebLlk2qpUYjryCZo5fZo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-qw0sGuUiMYGuSXt53ikGGQ-1; Thu, 11 Sep 2025 12:57:20 -0400
X-MC-Unique: qw0sGuUiMYGuSXt53ikGGQ-1
X-Mimecast-MFC-AGG-ID: qw0sGuUiMYGuSXt53ikGGQ_1757609840
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8178135137fso244170985a.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609840; x=1758214640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oNFHEb5Nel7e8bjxdQl/7q6UZJ++hB6LOdcQFAzOBI=;
        b=BnfO89gPIOKghk0uJZ4jGwVKVOXb+tPuIgevzn9BueltP1zRzIzaOvNhVrAb3Rdmdl
         oTnpULDJ9c/H08+8HnxluDogRyGEHsjSpDFQOeX5P3H+XzAVxT5qKrnwH0R+Ispk4o5L
         hImeQQlSn17jyvrRlYzE+q/t2OHFN5Z/wy0Mn6I2oFFbD+w0qKyUpN6SI9+pi4Xvii9d
         ggsWfL3gBIz4dkKjJ85syg145s5+fmSClZTyycMrlCTsQA58qbHeV8kBzldUdzd8ICgI
         WmfK/MQiPxwb1RchJtr0ZHifwm1Pc7VY9WPP/FLQHLBBZnDEv4p46Nj9NVldOylFNrgW
         V1cw==
X-Gm-Message-State: AOJu0YyRVfewtMSIHQP3NbU3eoQwYoY7dSZiYaSjq91xJzj9XhWUsR/N
	iOIzxFVR6cftBlo22CQWZpkpWQqUxUKyfZ+5kXHb0zerL/B+78qa4HFSgaeq2QnjDc/9jt+PxPM
	imt/skuemZOUhgd2FObRl4dS+/Ty9GnozIYp69P4LFwpiNQg7UomBxgtrLg==
X-Gm-Gg: ASbGncs0CzflMwBwuXcIlDMNTS5l5SBqdQ6r5fXIxGDAIX2tE8b7UqMycPN1SVLSMOr
	7fYVFSXiXk0XvZ6BobdXfZi1SMvdTwofJriYIFnmsths1wM5TiVfH3eVjktdI32ZXgk2ek1+uo0
	MJBxTd6pIjul9qwk4Rha3JRDmNE3/mSLXY5abI4hIM3UV4D7Hc63ZlPBz+j3Im1i5R7tWtbLyJS
	bWNe5XPFBfttooIq1aaITONrZTYkaqGESpv7/E6e8j7f2+CIyHZuiXwvEVCvaEUy0wfyVGn2pYZ
	ltAX8SvYMywnpjFazWYRNZ8WbPxuluGzKNO4xyUkAvZoOVGe4e27BaYQfchZDOngAdUPPpzr4hY
	Imj9iqnUv1mN/L5qnYhsWmyBjnatVDjW0S9M=
X-Received: by 2002:ad4:5963:0:b0:72c:cc04:c3ad with SMTP id 6a1803df08f44-767c215be72mr706126d6.39.1757609839598;
        Thu, 11 Sep 2025 09:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDiyGncKVLhmPtayKQv6kFQqRdh5q3Ir0FL5lXLKFwpk5HmVNLhr+gpR/+GrXzoemxP5aCmQ==
X-Received: by 2002:ad4:5963:0:b0:72c:cc04:c3ad with SMTP id 6a1803df08f44-767c215be72mr705906d6.39.1757609839220;
        Thu, 11 Sep 2025 09:57:19 -0700 (PDT)
Received: from lima-fedora (bras-base-london1622w-grc-03-142-113-155-89.dsl.bell.ca. [142.113.155.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b3f4ab6asm13496746d6.3.2025.09.11.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:57:18 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:57:15 -0400
From: Kamal Heib <kheib@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] octeon_ep: Validate the VF ID
Message-ID: <aML_a9kUmuv48r6H@lima-fedora>
References: <20250909131020.1397422-1-kheib@redhat.com>
 <20250910192658.55383c60@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910192658.55383c60@kernel.org>

On Wed, Sep 10, 2025 at 07:26:58PM -0700, Jakub Kicinski wrote:
> On Tue,  9 Sep 2025 09:10:20 -0400 Kamal Heib wrote:
> > +static bool octep_is_vf_valid(struct octep_device *oct, int vf)
> > +{
> > +	if (vf >= CFG_GET_ACTIVE_VFS(oct->conf)) {
> > +		dev_err(&oct->pdev->dev, "Invalid VF ID %d\n", vf);
> > +		return false;
> 
> perhaps a nit, but why did you choose dev_err() over netdev_err()?
> The incoming handle is a netdev.

Thanks for your review.

I believe I saw one of the ethernet drivers using dev_err() instead of
netdev_err(), but I agree with you. I'll change it to netdev_err().


