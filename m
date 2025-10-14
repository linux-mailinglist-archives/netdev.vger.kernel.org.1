Return-Path: <netdev+bounces-229328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5BBDAB6A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE98C18869A9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD253043B6;
	Tue, 14 Oct 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Km2cBlTd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF41E521A
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460800; cv=none; b=ZrKlEXq+HaQkhDOsRphu1TiZkW7Yb/kgLtPfMHI/rGHPCwZghCy/HVwxaJMhOinTkjk45sIo+GBqSIkrdc2y0BW3IhX73IEy51uEMre8fIZ/9nEV3AImqyrPpaP9zk7NjOho3CTi1Ec3FbGCDaY7XNJZW8UcRZik0D53+cMtKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460800; c=relaxed/simple;
	bh=IjSEs5UDstWgk3sazx+/L1A6xCj9XyekBAS4mMZ3jPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SEQlVNhFF8ibbFFeTLYknfcrgVpH1gV0J9ar3gCrioyS2oA13Uuw7OhhydhUSPIaOT/XdAJZxZ8hNI4JUAe94owW1EjkpouFCkKVsfKh8QyQXZYlhx9Xo3B12RWscgiFOWZTT1oMlOeJihbOdCQw39IbWSHF/NUh9/4eluz7Ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Km2cBlTd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760460798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/4kVeAo0V1Wd9MyzWaBsN4+1ag8AoVte3K6v/U9rb8=;
	b=Km2cBlTdIf8CS6sgxidNOxYConk0O20p/MD7GW1/dIe4ZTKDWcNz62aZJnyH6TfmxJSyuj
	A4pnkn4mk0HSxfGvt/kuMpZb4WEiY0n7RWcuNWp13umLO46U05ogWxnfEqdfmdQ4kCDuFz
	gBxdyXX/3z2bnZF4kt/DJUSggyEB2I0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-hmp4je4-PlG3eh1BiMrESQ-1; Tue, 14 Oct 2025 12:53:15 -0400
X-MC-Unique: hmp4je4-PlG3eh1BiMrESQ-1
X-Mimecast-MFC-AGG-ID: hmp4je4-PlG3eh1BiMrESQ_1760460795
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so835519066b.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460794; x=1761065594;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/4kVeAo0V1Wd9MyzWaBsN4+1ag8AoVte3K6v/U9rb8=;
        b=PGCytCpJ3Tn4HjI8Ii+BKTFisYsv8CPq07Ii3TKcXYdbM+Z9aG6arP7YjC/+uh+LlJ
         M/8G7iUiNQer8L9D4kBDWVZPG9Cxua7yugCEZptL6eDF+VpkvHVIHyF9L7eX1WkTWhim
         tzr7fD81DKUB1qT+yADOoRBqFmt69bclJIcO9hQzodMRT2q/WQ1ABFWTuKi+QgqxWzg+
         IHsr2OLJg0LBdxdaePzhDIrc7FZXkpToWNcm3HE56rhaE0YmJY3kIQZWe9kOceFvywZq
         uO8e1o2WtuT1Fpigk4eNx0YWdi4w/NKXg1/LErzwGYVXcJ+jFXPVI9cVFR6Vty4QkRsA
         nLog==
X-Forwarded-Encrypted: i=1; AJvYcCUJnwnjr60mu9tSzHzn1QYqqb8drODOm+Xivt3Kt5kUOcJw9q0slDS5+kOwqVehEnaIEHlJkfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2g6osf/Mm3O/IUHyTPAMoJ1HBGKoIi5jk+OdK4D65IlSnkUrt
	7UsH8VYRdrb/sGvMTGlYuRm1v4dAZS0d9/yS19vH3dbvn7wMViGIftvmd8SuiKSG30P24M0/+TB
	EhyPJHf4Q6BURa5ut+9m25YMpIir8EwU0AaLH+0vrPHHzI3ZtnGqp2aS58r/4+f2ZSw==
X-Gm-Gg: ASbGncsugnhnUhPCw3n406n5bKdSypb7YlhGx/qQEaml6VMqMlSI3+MPm8qVgY5tMwk
	tAACXxiLV6pSKPqd37plTZkVR1NentP1zf6TjxUaxUjnkW9qIDJVECZPiq3ZMLhHZYXKz4lj0xN
	cVd0DXbN7NG8u24s2UeHXuQCAuhEWxZApB66kGnY/bF7eHsR4+Kuix0SqxqcUGvKj4NTGBBOmYr
	IrNzc4hX8N+TEifkKiIqnRhTlCj+3pfVN1k9ibdesCyFcbHiVu8ZlOMmf8J7r3vrBiNfUjVeLv4
	AsaDwwLEsKhM97Hs+Dj4kL6OTXWiFpMecS/odfG8RaCmtDbHNN2bEMTu7FCj4Lhy4Yw=
X-Received: by 2002:a17:907:7fa4:b0:b47:70bf:645 with SMTP id a640c23a62f3a-b50ac5d1dfbmr2897739166b.58.1760460794407;
        Tue, 14 Oct 2025 09:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72MbITs6aqq1b0ioYKB4ybW/wbW9L4R5RQuxA3PGjn0GXoyF08d49eY/9ah1CliNG8B+5Yg==
X-Received: by 2002:a17:907:7fa4:b0:b47:70bf:645 with SMTP id a640c23a62f3a-b50ac5d1dfbmr2897735866b.58.1760460793954;
        Tue, 14 Oct 2025 09:53:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd2a63b1sm18729366b.66.2025.10.14.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:53:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C30C278B98; Tue, 14 Oct 2025 18:53:12 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org, lorenzo@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, andrii@kernel.org,
 stfomichev@gmail.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
In-Reply-To: <20251013162408.76200e17@kernel.org>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
 <20251003161026.5190fcd2@kernel.org> <aOUqyXZvmxjhJnEe@boxer>
 <20251007181153.5bfa78f8@kernel.org> <aOYtUmUiplUpj2Pj@boxer>
 <aOY+4qpQ+tzIWS5Q@boxer> <20251013162408.76200e17@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 14 Oct 2025 18:53:12 +0200
Message-ID: <87v7kh4e87.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 8 Oct 2025 12:37:22 +0200 Maciej Fijalkowski wrote:
>> > > I guess we're slipping into a philosophical discussion but I'd say 
>> > > that the problem is that rxq stores part of what is de facto xdp buff
>> > > state. It is evacuated into the xdp frame when frame is constructed,
>> > > as packet is detached from driver context. We need to reconstitute it
>> > > when we convert frame (skb, or anything else) back info an xdp buff.  
>> > 
>> > So let us have mem type per xdp_buff then. Feels clunky anyways to change
>> > it on whole rxq on xdp_buff basis. Maybe then everyone will be happy?  
>> 
>> ...however would we be fine with taking a potential performance hit?
>
> I'd think the perf hit will be a blocker, supposedly it's in rxq for
> a reason. We are updating it per packet in the few places that are
> coded up correctly (cpumap) so while it is indeed kinda weird we're
> not making it any worse?
>
> Maybe others disagree. I don't feel super strongly. My gut feeling is
> what I drafted is best we can do in a fix.

I'd tend to agree, although I don't have a good intuition for how much
of a performance hit this would end up being.

-Toke


