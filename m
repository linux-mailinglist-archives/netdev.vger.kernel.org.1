Return-Path: <netdev+bounces-152697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCE9F56B2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918151885A0B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA01F75AD;
	Tue, 17 Dec 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkLLra06"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA40166F3A
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462649; cv=none; b=nvuWCC68PkaRQW2UccBTZcLYtoxEz9AvR2K7lpWhqyp/zdkD+C240KXyyCpN2FAndiUupaFeE7BFE+JJz+hJ+ufqG1ZQkyLo82JxTiRMwE6K+biJkQyYTI8MSrjDMSp/aDxjkcDw9TIqI8a3sNHzacqOHR3Qntfl9OW+soXHwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462649; c=relaxed/simple;
	bh=sL4LfdBamfJJvS1HPuujof1ve0POoNT47VAAvOLx77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmRZQle7cI9uQxNbGEJsQuoRgKYtLyF5t+S+bsy/anYcdvq2cT/6unC0lP7V0hcevArjFnr9AcGmXTJ/kGSNbm4B7XGnT7ZLlM3ok/usInVnccMilCMBTzcdDx/9YOV3U4bbhIbibzL5MplpcCA/Apvkjp2UFE6eBHQ+VvINXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkLLra06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734462646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnE3yk/8uEAXi75hxn6xSkHvlyQMp8dpPjApkVRqHnY=;
	b=WkLLra06mJPh6HFDI1aD2vGL0Bs7wtx5lpgo/ve0TGZ/Zs2ImGoUexuXw/kgFgGiHMpNG5
	Vka583JaOITX0T+nxGowSa/7frST854IAqR0l0j613IQFRqHpDUqZBbAg7iFyQ5IzAYIxO
	ej39ZESIXrJLjDyyd1+JeN2uNEmoH/w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-18QR8CXAM6iZMzol4SEdIQ-1; Tue, 17 Dec 2024 14:10:43 -0500
X-MC-Unique: 18QR8CXAM6iZMzol4SEdIQ-1
X-Mimecast-MFC-AGG-ID: 18QR8CXAM6iZMzol4SEdIQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so3793676f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734462642; x=1735067442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnE3yk/8uEAXi75hxn6xSkHvlyQMp8dpPjApkVRqHnY=;
        b=XchrXYojAfwYJxe0gss7eW3GQqY7uao3Ol5bTdTrk89DlyJ00RWIoMGJAhs5aHcbOa
         24xMuEThZeq2foRET3WtBKC8NvfhHAHDlmFUNRnS8rXLVnzkOEacSkPLAlyCkr9ijclT
         PheuP+XSNQu/ld+VkXAcbayMfow3YvyhgX3XROBed70cs+HGmzhh/x5gaTJ5NltwErkh
         oTNFt0ni4Kc5OV6qi5ud7I0QPG7JWI1E/G9eA0hzpHdO8GuoYy79HGzjBWEgkG9sNoQb
         xvN3Ya0gAGuizLqFYKXIB2snvvKJcrRLufahI/EyXNIpXNZP19xacp+JCllivAld3dhe
         +RBA==
X-Gm-Message-State: AOJu0Yy7094fbkoQ7Xy8/sUYDSdmALqi31saYTGQzRHV9zDEU28cx03K
	k1weU9LISa7UJUiPNPGuhwe9f64GcunOyEKPz+AAcCJxX+qaB56KnfY+XxuMcUTw8kAH+m0q3Tt
	QRm+UAoegjFoZr0a9AEIM27dA74l/BzpnY4EQtNtVjWrTOaUbEISJtQ==
X-Gm-Gg: ASbGnctyuy2wwdzg5Rk5R/PnUsshuwvHtU36CaNRMYHKTOXl4I2d74aCy4nVEGsrUSM
	NBDxNSiGUpVwAUEN9dz/iqiXW+PBzZJEkwADHla7T5yxChdxiuVStoxNsVBeWlKvDD/b9qxKZFW
	mvuLoMaBHXxeIV3ggdTgWK/A0mdj63MeghaQEWuPzBPEf++UzTF6TNI3PWrRiYdctAI01kRKDBI
	RBn/iYBmYtoxsRAckPeJz/zFi2PZ9GiGotkdlFOBG2LN/ZcOEtbW0DZMvCD0TEXOuFGVSkpx0y0
	7x3M/I6hNIC6Kb7bMHJ6SOkgRL8XhxvMDewC
X-Received: by 2002:a05:6000:1542:b0:386:3327:9d07 with SMTP id ffacd0b85a97d-388e4d9caf8mr7263f8f.54.1734462642468;
        Tue, 17 Dec 2024 11:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxVyjKEi1OOmqfCbP7mCG2Ze4gzCZa+iRxHFGAXEud5CwElcEF3OKDOSxOGmU0DXbGmQE1Gg==
X-Received: by 2002:a05:6000:1542:b0:386:3327:9d07 with SMTP id ffacd0b85a97d-388e4d9caf8mr7245f8f.54.1734462642102;
        Tue, 17 Dec 2024 11:10:42 -0800 (PST)
Received: from debian (2a01cb058d23d600bcb97cb9ff1f3496.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:bcb9:7cb9:ff1f:3496])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060566sm11798393f8f.102.2024.12.17.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:10:41 -0800 (PST)
Date: Tue, 17 Dec 2024 20:10:39 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 3/9] ipv6: fib_rules: Add flow label support
Message-ID: <Z2HMr//V3CvIMwxb@debian>
References: <20241216171201.274644-1-idosch@nvidia.com>
 <20241216171201.274644-4-idosch@nvidia.com>
 <Z2GDt+5piTRsumVd@debian>
 <Z2GXsiHPjUDGl6TU@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2GXsiHPjUDGl6TU@shredder>

On Tue, Dec 17, 2024 at 05:24:34PM +0200, Ido Schimmel wrote:
> On Tue, Dec 17, 2024 at 02:59:19PM +0100, Guillaume Nault wrote:
> > On Mon, Dec 16, 2024 at 07:11:55PM +0200, Ido Schimmel wrote:
> > > @@ -332,6 +334,9 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
> > >  	if (r->dscp && r->dscp != ip6_dscp(fl6->flowlabel))
> > >  		return 0;
> > >  
> > > +	if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
> > > +		return 0;
> > > +
> > 
> > Personally, I'd find the following form easier to read:
> > +	if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
> > +		return 0;
> 
> The FIB rule code already uses the XOR form for other masked matches
> ('fwmark' for example), so I used it here to be consistent.
> 
> > Does GCC produce better code with the xor form?
> 
> No big difference.

Ok, thanks. I didn't realise fwmark used the xor form too.

> 
> Original:
> 
> static inline __be32 flowi6_get_flowlabel(const struct flowi6 *fl6)
> {
>         return fl6->flowlabel & IPV6_FLOWLABEL_MASK;
>      b85:       81 e2 00 0f ff ff       and    $0xffff0f00,%edx
>         if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
>      b8b:       33 90 c0 00 00 00       xor    0xc0(%rax),%edx
>      b91:       23 90 c4 00 00 00       and    0xc4(%rax),%edx
>                 return 0;
>      b97:       41 b8 00 00 00 00       mov    $0x0,%r8d
>         if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
>      b9d:       0f 85 31 ff ff ff       jne    ad4 <fib6_rule_match+0x34>
> 
> Modified:
> 
>         if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
>      b85:       23 90 c4 00 00 00       and    0xc4(%rax),%edx
>                 return 0;
>      b8b:       45 31 c0                xor    %r8d,%r8d
>         if ((flowi6_get_flowlabel(fl6) & r->flowlabel_mask) != r->flowlabel)
>      b8e:       81 e2 00 0f ff ff       and    $0xffff0f00,%edx
>      b94:       3b 90 c0 00 00 00       cmp    0xc0(%rax),%edx
>      b9a:       0f 85 34 ff ff ff       jne    ad4 <fib6_rule_match+0x34>
> 


