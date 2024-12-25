Return-Path: <netdev+bounces-154229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD659FC329
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 02:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD61882544
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 01:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F163A935;
	Wed, 25 Dec 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvwadUpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9DA48;
	Wed, 25 Dec 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735090544; cv=none; b=G4Jr9xOIGrL0IJnN7BlFAFBMLoSej6UHRxje/KQSyc6tQCPhHg9fu0cpkpWrtpHW+jGFkbzhdWHCwisDe0rnsAZSs3t8azJ00zsLnzzGzo3HlibsHpOja+oyvDAxYtUC+k0zpiGrzg8lASYPBO4b3RzYI6I4qUEd3p+tomL2avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735090544; c=relaxed/simple;
	bh=6pgK1KKWc7KdqD69eTI0ydyXO5b9seMydE15QQ4+2is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJwgG9CA03RWR7TeElcGoUURK+auRN2qG/MLZKk7bORADVdmO1Nu5fVRNySHdSB4dwIe5YHxx/pCoU3npd3TXN0t2IBPf2DV9vTnRlL+/y0IaPp7Nh6InS2aV0RO9r7XdslfSBmQM322yAYh5vowzXK2Wy5DSWTjV3POnFY9YSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvwadUpo; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so231929939f.2;
        Tue, 24 Dec 2024 17:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735090541; x=1735695341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhCWus2gdgFRXXbN6CQJBX9nnguZPUYLyL3J7sCfO9E=;
        b=GvwadUpofiz88op2JIzXducBWwTVXkRfEfHGbXnJ3la5zLuzmQ2xaArXgOfLetfzvC
         ayaS6wMvxMfGTeFO8nRyqr8Mi7bBBbbCnzouy6hPkuMiwkMSebcdMh1AAcUtDKPrZDJn
         NCTPsTEljEeQIwHpcbSqFmWzhy1SKXhCAirZgHK5I6E8dNccQcOmcmt7LJW00z8jWukT
         W08Ds0YjFCqbNz0A//C2sPocVvKzQCE7L1KinYRP+D6thnuRHVxzTAkedNstVSrskYka
         nIT+V/auO/TIYNvzTmdjot5PVuphqdpb++O2effHHBADlB2NKx+7CIP2OrYQyMdxtLLQ
         SfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735090541; x=1735695341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhCWus2gdgFRXXbN6CQJBX9nnguZPUYLyL3J7sCfO9E=;
        b=HSigQjOwxrk2GkMFwRTNugFQMP965fB4O/V3oNLvJjz/BIQ3ELqiIVqufjfPy38BFM
         SAUkkyE9CBBkjuoGM9RbHqlQI4wyrhTsSdVgSOeAPdA+sA06Di2dtA7MkIujPKxf3odD
         6fUaJWlogfe3yic5jJVKlvnRCWwnM26oPFSuLEY5y7uI6gDSlRyLhhdQhN/p4pRZRm/l
         /+JroClBUcEFYJ8S6YYrQZ73aLBQn90GLxoGpmyd47mWwiy3yih087v5QQqiT5qzz+jH
         kdJeu9KntEcZgM+lSsj5UfvS8PYHvNFQAkW67rjo5lBJldvZdenY/9VOZzLnzMwFs5fg
         mG6g==
X-Forwarded-Encrypted: i=1; AJvYcCVTQGnlb3Nm+8959Il7IGDt7VcNX9kzT8XXd8w50GnSE6v4VKsikHHLbglTtiWDQbqxza7ETr4QFEedDOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxdBl9RUSrcqU4nUXAz/Yphr4tj0fv/oXOXotMUC6WnaZhTzB
	0A0oo/inotthtiN5ScS0cq9DIY5Cobo6V+MNl+Afnv68/8UPQjEc
X-Gm-Gg: ASbGnctknpPd+SUT24jUf8csL6OroW1BE5Hqb6NqSVTLGYzjLkx2OcijLNTgj1Jv1l8
	azS6icN2Oq6bktdZPTOTqo7gAZW7yxGyB2eYHltPwjEtPHODrz+1prxAh/R4ZudvPGLhqmgIv9w
	9WwayN7CGsZIK+CiotbUOHc7UYq3utorpmDPGerrKPqfmvCI2fgbortbt5JAYSEiqzfMGWoqXE3
	Hkvg0juHaLDQwrxtyKdb31Rj0tb1sVes26p6Vz3DsWBzj3RQfCN7U4rfQHGkM0z67zR2dVLLMEQ
	n7yfGJfX1T9xObjcU/Ga5CLCXbZeELjYfhz4zrE1df90+HjHJYrdj7DOvQ==
X-Google-Smtp-Source: AGHT+IGsvpUhWhkdJYtYi1twdCsf80UwjhfpdKJCeSVm4EN0Hsp2x8+oDoTdmbwxaJDNJS2pd6zLIg==
X-Received: by 2002:a05:6e02:12ec:b0:3a7:e528:6edd with SMTP id e9e14a558f8ab-3c2d2881735mr165383875ab.12.1735090540915;
        Tue, 24 Dec 2024 17:35:40 -0800 (PST)
Received: from [192.168.128.127] (bras-base-toroon0335w-grc-31-174-93-21-120.dsl.bell.ca. [174.93.21.120])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0dfb32043sm32750965ab.40.2024.12.24.17.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 17:35:40 -0800 (PST)
Message-ID: <38130786-702c-4089-a518-cba7857448ca@gmail.com>
Date: Tue, 24 Dec 2024 20:35:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: llc: explicitly set skb->transport_header
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
References: <20241220142020.1131017-1-antonio.pastor@gmail.com>
 <20241223133915.2333146-1-antonio.pastor@gmail.com>
 <CANn89i+9Lt78ErDdbgVuOgvSy=UBz2Vhnp=cJYGvwuuQLp6qjg@mail.gmail.com>
 <c8145fd0-df13-4c6a-8678-fbf9547cc112@gmail.com>
 <CANn89i+jk=OWS3L1OV-aVbeO85eU6u6yK=FRoRadNEihpAOcHQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Pastor <antonio.pastor@gmail.com>
In-Reply-To: <CANn89i+jk=OWS3L1OV-aVbeO85eU6u6yK=FRoRadNEihpAOcHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-23 13:18, Eric Dumazet wrote:
> I see skb->transport_header being advanced at line 61 :
>
>      /* Pass the frame on. */
>      skb->transport_header += 5;

Same treatment as before? Reset after pull?

@@ -58,8 +58,8 @@ static int snap_rcv(struct sk_buff *skb, struct 
net_device *dev,
         proto = find_snap_client(skb_transport_header(skb));
         if (proto) {
                 /* Pass the frame on. */
-               skb->transport_header += 5;
                 skb_pull_rcsum(skb, 5);
+               skb_reset_transport_header(skb);
                 rc = proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev);
         }
         rcu_read_unlock();

I'll submit that as a separate patch.

> Note that setting the transport header (conditionally or not) in
> __netif_receive_skb()
> is probably a mistake. Only network (ipv4, ipv6) handlers can possibly
> know the concept
> of transport header.
Not too sure about that, but I don't have specifics. Non-IP stacks are 
probably all ancient, but some might care.
> Hopefully at some point we can remove this defensive code.
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c7f3dea3e0eb9eb05865e49dd7a8535afb974149..b6722e11ee4e171e6a2f379fc1d0197dfcb1a842
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5474,8 +5474,6 @@ static int __netif_receive_skb_core(struct
> sk_buff **pskb, bool pfmemalloc,
>          orig_dev = skb->dev;
>
>          skb_reset_network_header(skb);
> -       if (!skb_transport_header_was_set(skb))
> -               skb_reset_transport_header(skb);
>          skb_reset_mac_len(skb);
>
>          pt_prev = NULL;

I don't know the code well enough to identify all possible paths after 
this point to ensure all of them set transport header. I'd expect 
IPv4/IPv6 are OK and we are making LLC whole, but don't know what else 
to test beyond that. My testing is limited to SNAP... taking that out 
requires regression testing at a level I'm not comfortable running.



