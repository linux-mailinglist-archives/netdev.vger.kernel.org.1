Return-Path: <netdev+bounces-133083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DEC994764
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89D91C2131B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF2318C34B;
	Tue,  8 Oct 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGoxvEFS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFC7603F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387572; cv=none; b=HuC6CNKT0knuZn9cTcGn/naP2V/U0AoA7NCKN/CeRfnXBMBD8REwfY7F6HuUS4Si708VYZ3E9T+nm4BbDbEomGELohwRmTlOgY1baUS59DLiK8dz3cAYM9fZAE2sxJv6HQJorGUnFgCyVcNLPqoBti7V39cnawrWnImi9xP5aac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387572; c=relaxed/simple;
	bh=vVv2HQeualJzsRiKRMlBt4GSWwOleNVZKFGNx217o9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCCzgnZFEPllrbQisR4PpSUJDyYIHKdXFXJq0iEDDhk48SmElbp1mtBpF7yKowsCVnT/0pxsXaD7zHI1EV31F5CGj3ZsYcdMp7g5gQiJRxKTb8wPm82RmiRxjk3yjZ6oxqay+qc0KQ7DlGNo4ZLKQfQL83f+lMkXlGCOuFfWU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGoxvEFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728387569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxDGgvkDT/57XpSGr5RK8tkhMx+n1nu73Cyl/CUOtxM=;
	b=WGoxvEFSp+xhlmwn0+ZePv2+yfoBYXMrqseC2TqqIuuEXWEB+1xUWJ9wbffnbV/H8F3Iy2
	g6+Jk7l0MFdEfo2mZC/raIsRujLTiT7T9NWXkNGiBP1VLPYDBLONcHyB1Fl2JgwjZvbD5t
	9MFyxlC4DxPdcGyN9Saf5BPp/1JTm5I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-UV8w9AvANtu-nkhsa9Th9w-1; Tue, 08 Oct 2024 07:39:28 -0400
X-MC-Unique: UV8w9AvANtu-nkhsa9Th9w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d325e2b47so234816f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 04:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387567; x=1728992367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxDGgvkDT/57XpSGr5RK8tkhMx+n1nu73Cyl/CUOtxM=;
        b=LPmlxA+fP48FYfSeNdPS9zWg3kAka5q9ixi6oofS0pncqyGUT9HsqXbSnzbULOemte
         T2gKX9ilMgCUAZlh97vonhb9CAPRr44kDQjKoVjR60IMJBB9FZZ/lfVr4dAcY01h2fTb
         PfVlmNTb1V2FMfEObMLfrywJ1C4ruYN0fsFn7JSti67GnjZsaOkAWziB0G16aTJepcCX
         P0OwEo0IkDEMaS3YrVVZRItVus8z7hy/Kt0ZI2/a5l/nCSa7dqj9jiIDKlguQKTrD1U9
         jQWh+RV37m/arFFZ5QRZkHNCjRSIaAbiEait52sGA9RPa2GZwbuFKH29u0N7KOdBh1j3
         t5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXda/LSawEnSor1lwjXpxpvltbncY6WG2RWg7/eH4MvPG+sWAlvneJNG5KNJEfRxrWVWYaTfWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqY3XQ9VCibBtDLDXnp13EtxsPVtG0pBE7W6y/VifJ/s+m7cpi
	luUz4dP4KQqYx2iCct2bTB+QgFrD+t5Et60Ng9+ITXR8dUhjA6gmIqihMvz60h0hA8ZiMTF05vz
	py2wpgSv9lXd2fdWycgF8d9T43idhACwSPXmMmMA0NxI3Fpa+izY3ZA==
X-Received: by 2002:a05:6000:4388:b0:37d:3735:8fe9 with SMTP id ffacd0b85a97d-37d373591d2mr358508f8f.27.1728387567161;
        Tue, 08 Oct 2024 04:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2DVqn4uMhCYJiG0NuR9jrs7EDGISRMPqzuswPK0QuRhTb3Wl5kro0l1tRlN0DgD2tl+hi+w==
X-Received: by 2002:a05:6000:4388:b0:37d:3735:8fe9 with SMTP id ffacd0b85a97d-37d373591d2mr358497f8f.27.1728387566775;
        Tue, 08 Oct 2024 04:39:26 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89624sm106260925e9.12.2024.10.08.04.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 04:39:26 -0700 (PDT)
Message-ID: <9bb97d2c-878f-479a-b092-8e74893ebb2d@redhat.com>
Date: Tue, 8 Oct 2024 13:39:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/4] rtnetlink: Add assertion helpers for
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20241004221031.77743-1-kuniyu@amazon.com>
 <20241004221031.77743-4-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004221031.77743-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/5/24 00:10, Kuniyuki Iwashima wrote:
> Once an RTNL scope is converted with rtnl_net_lock(), we will replace
> RTNL helper functions inside the scope with the following per-netns
> alternatives:
> 
>    ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
>    rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)
> 
> Note that the per-netns helpers are equivalent to the conventional
> helpers unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I guess Kuniyuki stripped the ack received on v2 due to the edit here.

@Kuniyuki: in the next iterations, please include a per patch changelog 
to simplify the review.

@Eric: would you mind acking it again? Thanks!

Paolo


