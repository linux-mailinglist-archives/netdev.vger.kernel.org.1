Return-Path: <netdev+bounces-104455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ABF90C9A7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42831F21AA7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B216DC09;
	Tue, 18 Jun 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9RiuzsJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD616D9A7
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707172; cv=none; b=HjSBnE6nItoTSKh3iqWwTyVOAPqB0DdCSY9eRU4DWJFxAN+pOQyNmcuN6z14D91QlgPufqANqyhCfcjbGHjY68XkethhLXswdbBCWq0vgAKNzT895BRKa16Q6wNYYsaAZk/RM9EuVqnZVoS2i43Rm5bcGXw/DsycCy4+dsC853Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707172; c=relaxed/simple;
	bh=dFrRBkJl7R9hxvgTFXcfhz/5bf+uuLP1erp6wT8mbB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaBiT3ZIcWY4EZgOUKNY5FWmz/KWU1NeDqr7+6dGX3MO+8OkwsVdrCu2hjWG9Fs/PpZVzpYWJxD3XaWhrLj9oHHd5MhLq7rszIjYzmvBMxYKJm3do5ppB+5BCZ0Bme2j4YXg0j7EZ8Xx8sSpNbIOHfIuVZ93Eg80F5IitiNBQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9RiuzsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718707169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUpnx4iA/H5rFTjd+Mex3wPRNbIj26vNn+VnYBxGz0o=;
	b=T9RiuzsJvbru3HMtYBNIqxK5tPq7An01B8nF0EWX0YJntRoYUNy/DT90zDxTe/Q5gmZSFS
	4t+MlVbAdEllh9/t6QSER5yW3X/r6xbym/v9aUiC6h+0wmPkcUW6b/IdF8bJrliWg17OKB
	0mJBwVO4LLtZpxqek9StKkFnOaxOD4c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-vocYV7agO7yV-qFtNU5V8Q-1; Tue, 18 Jun 2024 06:39:28 -0400
X-MC-Unique: vocYV7agO7yV-qFtNU5V8Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c8126f372so1649930e87.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707167; x=1719311967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUpnx4iA/H5rFTjd+Mex3wPRNbIj26vNn+VnYBxGz0o=;
        b=RqJmEGd2iz1S6IPOz9sI7Bu6dS+0WUEat5d1BlyOeC6VoZPR3U1bhIYl+TUDaQn2nT
         eUjoQw9vvtnJ4i7WuTw7zRczf7qnwq7TvndPlvvywr5jMCYxVqt6HqaReHOsBkNddpar
         Xt1/iWF9If9bsgfkA+rtRNVnyw3SXqan2bHQv9ADkF8WMcpJ5Xdkz2s0cOjozt8cWb9h
         NeXrotxKTLA+G8V/LL+K2SObAcc9CHSonSCfEbqfy+8tONmdlOIlk/ivwh2FLag1FEsV
         IRQZQ7GiZGEf1iShDEphbw0SpKW+uaW7j/gUgsa6yObn9BzRzmrHJzrWBOILyyNEIxIJ
         clPA==
X-Forwarded-Encrypted: i=1; AJvYcCUEVE/HrY8XGBkpI71bzSP29tlN1l8aGhfcmmqaKdRJMkKZumqzV3OcuAp9tdnj1wqVdP2lPEpK9KT9w1FNZ08WPKt+xxkt
X-Gm-Message-State: AOJu0YwDK9ovMXR+KdFa4d6TxGCdeKezywAoYe8tgm1nsnDUszNnOB0S
	YRYzTqOCm5gfzmwh6VCl8zgFqTOTATofsDzu34gL6e3i7foIQ51aGzzJQo/HffTVEUgGbXtS3T7
	nc77PEXhFuDSSv7kkFN2+H3ouQGOpCOK3V95Ft2RaTrNJSvqMGPygkg==
X-Received: by 2002:a05:6512:10c9:b0:52c:b5ab:b6cf with SMTP id 2adb3069b0e04-52cb5abb7e6mr5463295e87.45.1718707166757;
        Tue, 18 Jun 2024 03:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFze+XHONw1pKhSFRlONo3MnV+d+IuBKNx7zowmQrnW5HIibz+c67gR1XvzUPSIqN7ibLJNTw==
X-Received: by 2002:a05:6512:10c9:b0:52c:b5ab:b6cf with SMTP id 2adb3069b0e04-52cb5abb7e6mr5463273e87.45.1718707166240;
        Tue, 18 Jun 2024 03:39:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm222635295e9.7.2024.06.18.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:39:25 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:39:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240618063613-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion>
 <20240617094314-mutt-send-email-mst@kernel.org>
 <20240617082002.3daaf9d4@kernel.org>
 <20240617121929-mutt-send-email-mst@kernel.org>
 <20240617094421.4ae387d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617094421.4ae387d7@kernel.org>

On Mon, Jun 17, 2024 at 09:44:21AM -0700, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 12:20:19 -0400 Michael S. Tsirkin wrote:
> > > But the virtio spec doesn't allow setting the MAC...
> > > I'm probably just lost in the conversation but there's hypervisor side
> > > and there is user/VM side, each of them already has an interface to set
> > > the MAC. The MAC doesn't matter, but I want to make sure my mental model
> > > matches reality in case we start duplicating too much..  
> > 
> > An obvious part of provisioning is specifying the config space
> > of the device.
> 
> Agreed, that part is obvious.
> Please go ahead, I don't really care and you clearly don't have time
> to explain.

Thanks!
Just in case Cindy who is working on it is also confused,
here is what I meant:

- an interface to provision a device, including its config
  space, makes sense to me
- default mac address is part of config space, and would thus be covered
- note how this is different from ability to tweak the mac of an existing
  device


-- 
MST


