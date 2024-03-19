Return-Path: <netdev+bounces-80520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFA87FA04
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F5C281B86
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1554BCB;
	Tue, 19 Mar 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMpLcbUU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A450A6A
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837347; cv=none; b=IO4nvt+t7i9Bquo+o4nwT/r2GgT5xrQBbACsUAnPzvp5JSfFt0PCYgS8b5xOPdm9WPh6uoN2BgQyY45D+VNhoaJUrSb3O+7sS1iL2XZO4CqPId3bMgHopN4KYKqYcKSGRwM4pm3XHGUG0jJG+HKM5U81NMoJKpSE6GlcsTjXRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837347; c=relaxed/simple;
	bh=Uhw7X37ePZrOYI/rJry/tZ9rI468Mam9nGel7TLxUcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk2+41V/bZolSPw9lz5tLvvOdCV40SlNF6Q2IdNCyIwNP85jLTw/EbEP55xw0rL6Yly5Wt/ZD3XcS7TtzHJoPPVUO6GsFfrh5PioN2QvPAQRI+TD8IsUyOKfnlz6omRR0sIQRMi5ffBZ20DB5dmYlpVRwbelGPlnUfVW3Yar6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMpLcbUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710837344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bidhNprDIaXErWo++B8NK9gU1Mr0P973Tkk526SOsxc=;
	b=dMpLcbUUIBfgeXSj4eaWpIgW9DOtyRQMSUnNTkHvd9+vSzqi2Iufyok+vfY7Y4sCHVDE3a
	clM0ZuxNLAVtPswGNL7eoSR36n40HqyXQ3YfyUy69TmMsiRVriwjvoQSnQEog2qeyTwPeY
	eX54gXfpsMmSvTmp9P3k1ipc/fOuBHQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-ES30tOFWPuaHgLO2s2f74A-1; Tue, 19 Mar 2024 04:35:42 -0400
X-MC-Unique: ES30tOFWPuaHgLO2s2f74A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46852c2239so249178066b.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837341; x=1711442141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bidhNprDIaXErWo++B8NK9gU1Mr0P973Tkk526SOsxc=;
        b=h6tcgtNRVFk+Y90mI8HBtwzLUvllVrqzWyy95CgGgTb3pkubFBPYZjkU/ou9MMgfN2
         MxAmDdocjQTzGO/PSUfgufQ18S/fdz6gAShLy1YPX057YTEBOwSNfiQnwgHN2fDEleHC
         GAQhWpf44AVZDH30H+w2qTA4BHGsTH4LuJijbFC2sMXjQk3sn3dI8gCeq/YbkfkEWFZ+
         zF9NvcMQk+l1IAEeoJKYWdBBymRAv2DY659gSytFQ576yb4yXsAlujZ69S1nN8rfcq94
         DMCcWj0CXvFitqdDTzEoQh4GlJJzhYA2vCQ4jRhlUidZ09F19lvyl+Gle0ROiBNFnV/c
         Va0w==
X-Forwarded-Encrypted: i=1; AJvYcCUMQcJmqU+hv4d4d28ifBXjAISKC9bkVPw1CnhJubIZkyFOdDzH7cNIGwoKoOfj0N4x0/qKTo3w1YsvoSxemMCjsV+EoRW+
X-Gm-Message-State: AOJu0YypM1S49BvlKUpcM0F4eloKRLZ9shLKJdhlWS9o+GwNyUECTRXm
	5giORyiJiJQEgJw6u53C9/XikhiiUqdKHlwjRt+jcTP9Ozxf56+NAa8mz4fBj6bEnj3XWB0e2Uu
	6pZt80CJSqzxj1BsIAK2feJ28YuBbSqy7jY08xwfdJi5/NyKW+GAWyVsmvY3uow==
X-Received: by 2002:a17:906:a1da:b0:a46:e81e:5294 with SMTP id bx26-20020a170906a1da00b00a46e81e5294mr109032ejb.27.1710837340945;
        Tue, 19 Mar 2024 01:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2M46P0WU30p/kI4KM147xUw+jHFCsikBReD0bxprbCUbp1whXFumyfQAXLRkNAFtveWMugw==
X-Received: by 2002:a05:6512:68c:b0:513:db96:2be9 with SMTP id t12-20020a056512068c00b00513db962be9mr10460157lfe.64.1710836978279;
        Tue, 19 Mar 2024 01:29:38 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d540e000000b0033e95bf4796sm11737388wrv.27.2024.03.19.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:29:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240319042829-mutt-send-email-mst@kernel.org>
References: <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
 <20240314110649-mutt-send-email-mst@kernel.org>
 <84704.124031504335801509@us-mta-515.us.mimecast.lan>
 <20240315062839-mutt-send-email-mst@kernel.org>
 <b3fd680c675208370fc4560bb3b4d5b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fd680c675208370fc4560bb3b4d5b8@linux.ibm.com>

On Tue, Mar 19, 2024 at 09:21:06AM +0100, Tobias Huschle wrote:
> On 2024-03-15 11:31, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 09:33:49AM +0100, Tobias Huschle wrote:
> > > On Thu, Mar 14, 2024 at 11:09:25AM -0400, Michael S. Tsirkin wrote:
> > > >
> > 
> > Could you remind me pls, what is the kworker doing specifically that
> > vhost is relying on?
> 
> The kworker is handling the actual data moving in memory if I'm not
> mistaking.

I think that is the vhost process itself. Maybe you mean the
guest thread versus the vhost thread then?


