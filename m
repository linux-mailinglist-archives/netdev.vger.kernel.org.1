Return-Path: <netdev+bounces-118895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F169995370E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3EF1F23473
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D31AED32;
	Thu, 15 Aug 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFQD0nev"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6B1AED38
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735404; cv=none; b=rpxM3wLYUihv5l8FYfhj0NypecHZ8nPz8IiglfEV7YvI6b4mUeU6ubWEBBb+gDXUY2cDWpMMHMlcKyABhf4SkClqHTFlVoDOtZUZpyGI49pPkWW68Cl688Y7BVr73hZdfDVcgH44GDwH++X2Bq40u6+lLAsMGulFe5bAdNuatB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735404; c=relaxed/simple;
	bh=Z0PZF3iT3kmG4kVxpER+Pkc+8Vs70AzAJbTnaHohF+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfEFIDhP3xAN4IWun4RLYreC8YTp6BZHSoxBWAjgM9xGr2GSnqJ+GofhO9fY3LA1jDoJ03Wsy2T3P6vRiSHweF9Sd2nZ1rqp/GAPyD2oGMl//ij1vrulPzIRKE6WtZ1dpnHNjlwi7Lxzq4Q65N0eseBNjFmFk9CCZsijliDYN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFQD0nev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723735402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0PZF3iT3kmG4kVxpER+Pkc+8Vs70AzAJbTnaHohF+Q=;
	b=eFQD0nevqfO/haJ9/Ucomfn3UuNhzfJNzpIHMP6gaeReC9MKunvTd82n7Q6rbyFvjfSjGt
	UbRXmHIsOs8rJgHMP3jfluxZ8c8tsKve0iDVN2+bG+JNm+F1SDGvi+XtRf2Wa+qBhRotq/
	G+JQckSpTu+5gCmgId2vkEZU+5babXo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Pria8jF2NH6eoI2uR-q8Nw-1; Thu, 15 Aug 2024 11:23:20 -0400
X-MC-Unique: Pria8jF2NH6eoI2uR-q8Nw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77f0eca75bso107592666b.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735400; x=1724340200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0PZF3iT3kmG4kVxpER+Pkc+8Vs70AzAJbTnaHohF+Q=;
        b=BfNny7kzF9npP8hONZ9SCGNUZNhWzVrUEWNi5xkte6pxs1Fb1C1xJ7XOv2zfPXBaBn
         OC0iS6ApqoYpOmmlimB/slUDwFeGn/ODv3vCcd86fFmwVel76JgTbnzzUBPCVMfkjTQw
         23q8E4gkUIDKa7Ur1u/vg6GARlB6Z99fS7lSK8TFHGOXb0o3BQ3sne7h6Lo1gstYKJPI
         ZcJhfZ+nZjwJgkphqwAvrhiVSUvoscvkP0PnEdbm8hnUD2TPEUuDGUCMBuhj5hhHWPcO
         a8SLFR2x34YelUnC5l4ri+ofuzsp9X4qR+jYkR13ce3kINgsL8wRzJiDKucnFtIb27NQ
         O0hw==
X-Forwarded-Encrypted: i=1; AJvYcCU3GBrfbT3Ig86Yz6eoq2SCtvzk1VtvLtCdHc9fXfl7zF2u7/rqG6V8y9pQiRJWeiYouK7V/eL10pMN6bmfQQC21aUdBNkI
X-Gm-Message-State: AOJu0YyCtYN1iabXoS3jgL1wS8e0g8gUDsZ5dgrqS4Bird30cEvGgzjs
	X3L/bkKhuzFRVUDsN+6xTppi7RR/75xpt1xS7J5E2OgXX/bk5o86SY5Q7+gKR6wX0AhJ+juuYMl
	ZN4kH4mPk38kmOPqciLjwjoHX/Uxw69Ew9VUC7okGgCeYmT7PCwd5xg==
X-Received: by 2002:a17:907:f782:b0:a7a:9f0f:ab14 with SMTP id a640c23a62f3a-a8366d7786fmr467851866b.33.1723735399596;
        Thu, 15 Aug 2024 08:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmfTaj56j9tYVD0QKL1sNvdoIgl/XRqpaSrAVLu8JRyiak502h9wKyYixOsF/EtaN1gS67Hg==
X-Received: by 2002:a17:907:f782:b0:a7a:9f0f:ab14 with SMTP id a640c23a62f3a-a8366d7786fmr467848466b.33.1723735398782;
        Thu, 15 Aug 2024 08:23:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65f2sm117028966b.29.2024.08.15.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:23:16 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:23:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240815112228-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>

On Thu, Aug 15, 2024 at 09:14:27AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> [side note: the message I have been replying to at least when downloaded
> from lore has two message-ids, one of them identical two a older
> message, which is why this looks odd in the lore archives:
> https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]

Sorry, could you clarify - which message has two message IDs?


