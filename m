Return-Path: <netdev+bounces-71706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE5854CD3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE53B28CDE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596705CDC9;
	Wed, 14 Feb 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWdzZKjF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016E5CDC0
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924661; cv=none; b=JNgZcuxpivlwr+HbhZXfXz8xbS1fH0QdSCwJgmX5nakWTS1jv3JTEpMyXX7EaJcr4JP2pu5lOGTLbLO0AljB4y0VgDhJPn0ZwJk3cQ+DLFK19eRZP6ZM8u+gmVeZTT6RjidrLqP8U9UYRvtXlDDi0p8edM+JVoY1Clto2iD5T3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924661; c=relaxed/simple;
	bh=imEYAaOuILDczCvFEeCOt+vcfsdZnaBpsXXGf8Fgy/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG3mlEXBEg/IlRvMvdz0++lPVt0Eqd4HY45frpqd44TWxQ0EA5IDIVk/ii8nUPiBOhXNiqx4xoO3dn1qfiVIq9GEC4w/nt4bmYWxyFkbCLke1SQgx4oIPIztaIPsDe3irQJxjtN0QDo0uYpGDM/orYzlXCPEdyL1zOAftf46XTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWdzZKjF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707924658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXtkMJiy9FSVGUapjk3HwcfAOYHMrdW7JcBdsr+ZOjo=;
	b=JWdzZKjFuqJQUfEOZ5FSyXYCvWe+YK+HUtghPn2RU1lBs41/Pa9GrywtzV1TJOMwaayR9v
	0qjyhFZ6R/PA139aq4hf0KWW5so4m1NZXg2Lonv8547SQVc4Xlhlv6QYFCskUkOYYvH3SX
	wezPtCJnqTtjeUWhaFCwJZDOznXVgzI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-9YWl4YP2MeuiF0eNAAf5tw-1; Wed, 14 Feb 2024 10:30:56 -0500
X-MC-Unique: 9YWl4YP2MeuiF0eNAAf5tw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-781d8e14fd8so276951985a.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 07:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924654; x=1708529454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXtkMJiy9FSVGUapjk3HwcfAOYHMrdW7JcBdsr+ZOjo=;
        b=n3nUMAoYUCwJjE8Ct3X7HDk3B1X4pazPj1Ps3zrsPk8cn3l1Fs3rSOeryVM8SXWY81
         aRa4Gy/LFriizOeNHQ4sjA4DJGD42CkgrCNusjjx3+DgXs4pE98bv85XMBn+uxp0EOtq
         noKG4jkDBoqFzF76O+v/eSbeAGJDbj1nj9co63I1L7/oyUY5XkqkNahZfhJgh8v9HAPQ
         YcDFCQ1VslmEQReqLMAjwSHRcrtdyYlhNgUSvSUpOwp36PKoJXOzhmxZEv5H8Nil9Lcb
         o8J8SXTxG7rqce8ndgAmn2y7lKjq4ZJg/x5fQ0aHTNy36fGKKaYDuw5t+lod7wehZzHf
         /yrg==
X-Forwarded-Encrypted: i=1; AJvYcCWfKAW13PAs7hlGcN8xR9BuMs7/ptUASMs4MbSb+FGADQXSmSkN4vn4sdy4z3bwHTQNbgTESIIUYwTaiO0YeXsJS56cBCdR
X-Gm-Message-State: AOJu0YxYVaZmj2Wr9f8F+42TqAwzjNAdqKTeTukIfPd/J29MxkMSlPRx
	rPLcolnx/EXlaCkeYMKuNDr05Cu3F6ZWEWZiwhnMgHTclIGzj9QRvzC/nszd5txXIVdzP3GSEjq
	hUS8k9/epg76MHXN8izdWgR+3d6Xo04IZQ91zKQyeJWQ+aqnuyUhAdXYCseZPYg==
X-Received: by 2002:a05:620a:1a1f:b0:787:17d9:99ee with SMTP id bk31-20020a05620a1a1f00b0078717d999eemr4022840qkb.16.1707924654627;
        Wed, 14 Feb 2024 07:30:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH88Dl2z7jLBSDjNRGeTdaIafgx/Ol4hk/y3KCPjs2fl7LXuAl/XwXG4yFI2sbiK5o2Nm0ucA==
X-Received: by 2002:a05:620a:1a1f:b0:787:17d9:99ee with SMTP id bk31-20020a05620a1a1f00b0078717d999eemr4022820qkb.16.1707924654373;
        Wed, 14 Feb 2024 07:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtPO0kTAQxC5RZDfT0VwlKpsx01C7b9CzNvzvWd6AKIHeWCr0OcCKLraDCcdxoR+SsVALOJlgHXHr5baasQMpBSwwAqMboWHTPsl/t3Ft4JCGaTkZY2RmxSZcu
Received: from localhost ([78.208.134.164])
        by smtp.gmail.com with ESMTPSA id y9-20020a37e309000000b0078731e6d47csm183867qki.116.2024.02.14.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:30:54 -0800 (PST)
Date: Wed, 14 Feb 2024 16:30:48 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	sgallagh@redhat.com
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Message-ID: <ZczcqOHwlGC1Pmzx@renaissance-vector>
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
 <20240209083533.1246ddcc@hermes.local>
 <3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
 <20240209164542.716b4d7a@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209164542.716b4d7a@hermes.local>

On Fri, Feb 09, 2024 at 04:45:42PM -0800, Stephen Hemminger wrote:
> On Fri, 9 Feb 2024 15:14:28 -0700
> David Ahern <dsahern@gmail.com> wrote:
> 
> > On 2/9/24 9:35 AM, Stephen Hemminger wrote:
> > > On Fri,  9 Feb 2024 11:24:47 +0100
> > > Andrea Claudi <aclaudi@redhat.com> wrote:
> > >   
> > >> ss.c:3244:34: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long unsigned int’} [-Wformat=]
> > >>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
> > >>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
> > >>       |                                  |    |
> > >>       |                                  |    __u64 {aka long unsigned int}
> > >>       |                                  long long unsigned int
> > >>       |                               %lu
> > >>
> > >> This happens because __u64 is defined as long unsigned on ppc64le.  As
> > >> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
> > >> if we really want to use long long unsigned in iproute2.  
> > > 
> > > Ok, this looks good.
> > > Another way to fix would be to use the macros defined in inttypes.h
> > > 
> > > 		out(" rcv_nxt:"PRIu64, s->mptcpi_rcv_nxt);
> > >   
> > 
> > since the uapi is __u64, I think this is the better approach.
> 
> NVM
> Tried it, but __u64 is not the same as uint64_t even on x86.
> __u64 is long long unsigned int
> uint64_t is long unsigned int
>

Is there anything more I can do about this?


