Return-Path: <netdev+bounces-157079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FAA08DD0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4DF1889BD7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726220B21A;
	Fri, 10 Jan 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLF4owk8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B220B1E1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504632; cv=none; b=RtDu4eVkuC3m3Ug/VxT7ZQcWb6SPZEgc8HRNPAhpG++FeEArPF1zzi44d/QcBMGVC9xxnmxrxxGuaR6MOzcVPdX14j31VKRfHCEz1cgiINpZXsxyGPMCPzk1kc1qsQ6N9poHXDolSGCj/elg3VVtzV3Tnk9HNiLgdTlxywP4j8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504632; c=relaxed/simple;
	bh=xjzJiHVG1rcoDk2fTADzQ9apBt/E2B/VHNJo4JUJl8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoHz16JRMzd0z2njk6o8/dc/cTM4aLiBg7W3pYYf1/Ui62K0qrqyQ1JvNqKXfzhu4qRiJCTXiSSBZ61OzQLNVYGzJFztQRg023QNl1VhHyyd4kaQUrT8V5/g5qBGZ2dN7QTlBezThTjglrc11EbLgPDqo1IPOqnkCJowwpo3Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLF4owk8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736504630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp3bnJiwix2Gu1b46TgPaNYsSc3q3ZVFUH5fpD6tH7A=;
	b=fLF4owk8wLRErACyXaGl1g/X0YnCNIqRnKGo0fvlYSph58SVpg5+qwvrQtkILIWhYF52Yr
	/GkxvjAB5drOr2BSUbjzpczdtuElxBTAX8uJj8f7KN8iMpZt2by6ueDhvi5IcE7KnxX/N3
	V59fjMnevDIiD/MT4av7QXYhDPU2HA0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-5A7P4MxON76fqVrRCgueaA-1; Fri, 10 Jan 2025 05:23:46 -0500
X-MC-Unique: 5A7P4MxON76fqVrRCgueaA-1
X-Mimecast-MFC-AGG-ID: 5A7P4MxON76fqVrRCgueaA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso16676985e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504625; x=1737109425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp3bnJiwix2Gu1b46TgPaNYsSc3q3ZVFUH5fpD6tH7A=;
        b=KwpUZtE1Zq//MHFXbNPNYg0BqpV0Ctsr079x48MuojFNkZG6EIrlz5z9RcuBbGPWHF
         G6o2S5SCrXjKh2HKENIROHlwm5ts66n5fN0qBFHcPd8qPvSmvgUF67XALhU8PqXkNb/r
         JQiOc8bBi1oe1vhTZhoTAGLiOnWhgdTMbKRV7IAnYyB2tZqVWmxwuV7Qys6I31bKsQ5t
         IHjaij7oFZ8nDRM/qFce4U+h+nvqIf8wgF3RRqIQmY26kec2x6gPWuQCJElmRc7VTObh
         Oqabbw6vrPMZoBxcFC+QCpg2ybdZBho8kC1F4TfosAURIjOGmNdWaiNANM8dgMdViKYw
         FPzA==
X-Forwarded-Encrypted: i=1; AJvYcCVmlqz/1NrANzaNo8x6AumESltNgyCpXxRKh2lGhmYQp1aQ3ErWQTIbhbmgKELlSPMqyUvmelI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSD184baXFF3scFBd34uawajGMc55h/RpmJC5PoBJowHlETYw
	wkdBojf2ha0RIRJ0Juu2EfbgNVpPyRfcVUFl5TsTof0PGX8oFzG165z8IZ5KQiadk3u9Qxz3jWF
	F9+Pt2/R4lvLk+BsRJeEmWk3loULtDY8RF9nXBmwkedt4SJbehUiUkQ==
X-Gm-Gg: ASbGncvgr9P2dr2j+3eXqWAN4jGPffGK+jme3mb+FV7tJGfNhck6XpqzrWIYMYA6Vdk
	6CXzxVYic0ZXScNeMUjjceU/J5v18yNKWYSmGZzvWa3A1ebIq7a5cQxWOkwsaEXRctZeWPVunRe
	+eAPHVQpuhtofa77Rq1WVk+B3/0KHTPkcAqjl/CffNvq768jN2YGmEFpp6aPz53qFUtF6VMuavU
	V6puYovITj+bOW/BcyVfOjG67CuijUPO87o+xjvdbAuU37lw3fo
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr82747485e9.5.1736504625690;
        Fri, 10 Jan 2025 02:23:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCfvXG8JypksNxAK+IHkKlFtMebcL1LMAzRXVW08Nh57eky+TRviObBgV58/zlzJhK4cMqJA==
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id 5b1f17b1804b1-436e751e61fmr82747375e9.5.1736504625358;
        Fri, 10 Jan 2025 02:23:45 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03e5fsm47436835e9.18.2025.01.10.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:44 -0800 (PST)
Date: Fri, 10 Jan 2025 05:23:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250110052246-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>

On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > The specification says the device MUST set num_buffers to 1 if
> > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Have we agreed on how to fix the spec or not?
> 
> As I replied in the spec patch, if we just remove this "MUST", it
> looks like we are all fine?
> 
> Thanks

We should replace MUST with SHOULD but it is not all fine,
ignoring SHOULD is a quality of implementation issue.


