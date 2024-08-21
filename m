Return-Path: <netdev+bounces-120678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB895A319
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858AD2834DD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B61537DD;
	Wed, 21 Aug 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OclwEOau"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3E16190B
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258686; cv=none; b=grQGbpizK2jr8yOCsX/WCcY3DGwFs8RONxCxA7d5uV/Qc915gUmh2GG6G8lYbB7xRd4yHCNdq872I7Ul/+fY5WD0r0tWatoVdEhdio9epsbzJjSygZwRhBY7aKfGnPjalTpP30BVDeAkT2TOX00xHfAUYbkUXJQ3oZDv/k0AVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258686; c=relaxed/simple;
	bh=igLeopOXXKG/WrUm1cDFc/eyUdqdZtlb0F/mFOpWYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8hzkpSqHXgCp2OzJJM8RAMGxbDM2/JvRVNX2N2Om1jB3/BGjmf9/T/lxl1I3vOUcJTVYKc2ubXCCtuFl46tVM0ou2oQsD3E0JrCm5qhmnUWs0Y/msMw5yj+Kkj4ogti/tkpLWunIuajEpKY4X08aZyZ4kTdV1ESggLf6R2WiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OclwEOau; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724258683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igLeopOXXKG/WrUm1cDFc/eyUdqdZtlb0F/mFOpWYuQ=;
	b=OclwEOau1uRiOsTLvW4VlhOnNxIr18qOHA/L2UNPekpCxX/1qEDHsw44g7VTt0B1D+ivZ4
	pLkGC7aUDf2f2LRgTPfKC3Sqo50bIRWioIDvfTGPmIDaI7SK5mEBFpP+lt1mxxh9VlXzlV
	CkypOIST6E7dQVu0NkG8uhUZRKWQanU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Mo7dyBjqOlOG6mK7tTUgjA-1; Wed, 21 Aug 2024 12:44:40 -0400
X-MC-Unique: Mo7dyBjqOlOG6mK7tTUgjA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37193ed09b2so497423f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258679; x=1724863479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igLeopOXXKG/WrUm1cDFc/eyUdqdZtlb0F/mFOpWYuQ=;
        b=gUnfiy4dB2I5y5e3EjTJ5qFOGP1RxUodkgKaeUwl9AqR2ydeuvlDvf5S4pkfWgrAKc
         YtSV5V1kN44OEacYSrn3hjCaoSUxfQXBYmV+Xqq0pglzj4+W64o2hHLKhZI9t8GzLxso
         YFNOJGEb1RCD+mWRJ9wyw+MZHV88OvQwvz8NAKDHOkEoJCdv10B1LU5YYPW1FZRERg1L
         BIZCXEXdpu1hUaKBVjs+LrXSuhOKWmpged3XN/dKDyVzrsYsnrPvkf3DZADRz84toa4J
         Cxi0kVczEmuqiWAPt6Twm3Q0k+sgHbNoEXT5xYvezHpPSL9OiELmR328pcV8fjhLXk/v
         N9lg==
X-Gm-Message-State: AOJu0Yw4pkh87jQ6jWhYyTyR/ymaGJd/H1pjJSkGA57NWeNIqAJuxpZg
	YojQdX1cpeZkoHmIIxhdPs371JqynGfoVwU0YqDgAwoclmiyM8bciZ2GC9kKdglSP9QUeHvy1Vd
	OetPOJRZ2Rtj73n5NeC4NPmFZirW2UtJy8f6XUGZuwoCw/7dzaSWkqg==
X-Received: by 2002:adf:e450:0:b0:36b:aa27:3f79 with SMTP id ffacd0b85a97d-37305252bfdmr164240f8f.4.1724258679163;
        Wed, 21 Aug 2024 09:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+AvspN3ANp8D8OkOYAf7VfX7eBe+ARUXdDV1KzYegvFDJe3qrckw5DAhMczrijJ8Nj7klQA==
X-Received: by 2002:adf:e450:0:b0:36b:aa27:3f79 with SMTP id ffacd0b85a97d-37305252bfdmr164188f8f.4.1724258678209;
        Wed, 21 Aug 2024 09:44:38 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2d7sm16226321f8f.10.2024.08.21.09.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:44:37 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:44:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 10/12] ipv4: icmp: Pass full DS field to
 ip_route_input()
Message-ID: <ZsYZc+JGy8Pu6gLP@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-11-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:49PM +0300, Ido Schimmel wrote:
> Align the ICMP code to other callers of ip_route_input() and pass the
> full DS field. In the future this will allow us to perform a route
> lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


