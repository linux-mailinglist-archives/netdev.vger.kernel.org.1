Return-Path: <netdev+bounces-81082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B41B885B3C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B400A281644
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE858565C;
	Thu, 21 Mar 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs+CFnzG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAD1E534
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033101; cv=none; b=QcrA2VsWbXfO29ZJOAnGMDiVIJpTQXIWDen8DIaSYV37w6ueyrIL9a8/BD2oLq1y3H37DuMxFbRXLqgp+L2A1QAS1DmrVjTL6YomwBAZigvI4TwrGCERubIzJntwb6Umrnjk9QDORmgbWicm/szdqkxNvO+DCKmap8XphvDrNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033101; c=relaxed/simple;
	bh=wiLhFjcQDSEayo9TQMo4W80bZ56/0D7933ZDimif2cg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Pat/P0ofq3XSssM98q750SOTgzPV56UB882jU/83hUU09EgcaqmPPcA+OQrxhwtWmaDQmkbWxUCzzFzRs1Fd1MosWbP4hytpfEFqAXmwlTIsNq45UycgohEDtFT/GVAX1MSUDVuolNzuEK6ZoGBT5SVjNGRofP76CDzmbsm8uP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs+CFnzG; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6e51d0so641383b6e.3
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711033098; x=1711637898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4mQwxlCrl/KHFuuw6h+8rhCqUSMeTOdlXcgFxRtytg=;
        b=Bs+CFnzGAZTXEfYStvVfS+zXtQw3IaOx2XjuMDKSQV0N84FoEFTywVqcQvc9LmXJiW
         BuGGsoyGk09HhbHso/xZ4OijwHs6AXokYguGECGuE1SWKVLEabAe1FfrDHHWtv9ZPBei
         a3pSyjh1caO+u7OF6B5JymW2/2jYJr2C+gKZLvUXaTxf51z+pzqxPx3O5cUNojVQ9K8h
         hmQqT+f7hniOXis7/3TzPTybrCxf7lSJ8BDvqj5sqEsVyr0g9SHpaxUoPFUcjF2ZNnlH
         WKEMipJ97zMEwGz6EHJ4G+IYmJhDl+3ze77SUNQgEfbxJvlc7OQByru26nhY8RyDCE5o
         cTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033098; x=1711637898;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V4mQwxlCrl/KHFuuw6h+8rhCqUSMeTOdlXcgFxRtytg=;
        b=bpwFRyoGxU5vku7imuUVWUjPH4wn8pEB6MWY9fkn0tTazLJlVXUv5Nf6triQS8lpbs
         X52H2jgbNk+TJtZj88We6o6G0uZw7oRMyd1V5ZN6Ch8Pm63SCc2BMvNJag5Z4UiQkFD3
         Sn1Lc+MnpMgT6gIj400fSl894oUHCh4AaOuPFMa289SwhzTzRjfYbaZhNlQkrj2HUQdO
         5/i9Lyt+mSOuyxoES1JFVjbhfqzxFG5p75D8vjjNXViITINn3FdW3jk2FIPwi/t7uhLV
         NMiMO0gRC1M+kYOLRsc28SnYsA2m9wvjaOgDbShUJflZC++a6vRjyNLmCicM0OY4JzMc
         nnIA==
X-Forwarded-Encrypted: i=1; AJvYcCUgh4qypL2VsqFjD+Yn1DbUwO5nTcfIVfeWvTllw40PPECiyIJY4L1YocdHK8pSjxiwq74/xwT97E3phasvNfVQlnJhu/3w
X-Gm-Message-State: AOJu0YxWxQUf3ISMH0ALItGKW0pQxLR1aeBw3siiW8ZCJKoYrc7DH/QI
	HxwFIcEEHZvzro7zdrRbdqFG1RDGTVZXxdv1bXEg3+NPh6DycKy5
X-Google-Smtp-Source: AGHT+IE8DQ1WepjE+wcuZUYPLygY/PEA4aBi3adUq6IyWYFTj/aHRmU8BQFF+4eQR1kSMlWcwDMESg==
X-Received: by 2002:a05:6808:198e:b0:3c3:8395:1119 with SMTP id bj14-20020a056808198e00b003c383951119mr2660337oib.26.1711033098475;
        Thu, 21 Mar 2024 07:58:18 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id s14-20020a0562140cae00b0069102f97e08sm9068572qvs.97.2024.03.21.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:58:17 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:58:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <65fc4b09a422a_2191e6294a8@willemb.c.googlers.com.notmuch>
In-Reply-To: <171101093713.5492.11530876509254833591@kwain>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-4-atenart@kernel.org>
 <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
 <171086409633.4835.11427072260403202761@kwain>
 <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
 <171094732998.5492.6523626232845873652@kwain>
 <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch>
 <171101093713.5492.11530876509254833591@kwain>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to
 unnecessary checksum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> Quoting Willem de Bruijn (2024-03-20 21:43:55)
> > Antoine Tenart wrote:
> > > Quoting Willem de Bruijn (2024-03-20 14:00:48)
> > > > Antoine Tenart wrote:
> > > > > Quoting Willem de Bruijn (2024-03-19 14:38:20)
> > > > > > 
> > > > > > The original patch converted to CHECKSUM_UNNECESSARY for a reason.
> > > > > > The skb->csum of the main gso_skb is not valid?
> > > > > > 
> > > > > > Should instead only the csum_level be adjusted, to always keep
> > > > > > csum_level == 0?
> > > > > 
> > > > > The above trace is an ICMPv6 packet being tunneled and GROed at the UDP
> > > > > level, thus we have:
> > > > >   UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
> > > > > csum_level would need to be 1 here; but we can't know that.
> > > > 
> > > > Is this a packet looped internally? Else it is not CHECKSUM_PARTIAL.
> > > 
> > > I'm not sure to follow, CHECKSUM_NONE packets going in a tunnel will be
> > > encapsulated and the outer UDP header will be CHECKSUM_PARTIAL. The
> > > packet can be looped internally or going to a remote host.
> > 
> > That is on transmit. To come into contact with UDP_GRO while having
> > CHECKSUM_PARTIAL the packet will have to loop into the receive path,
> > in some way that triggers GRO. Perhaps through gro_cells, as other
> > GRO paths are hardware NIC drivers.
> 
> I get what you meant now, thanks. Yes, those Tx packets loop into the Rx
> path. One easy way is through veth pairs, eg. packet get tunneled in a
> netns, connected to another one via a veth pair.
> 
> > > > > There is another issue (no kernel trace): if a packet has partial csum
> > > > > and is being GROed that information is lost and the packet ends up with
> > > > > an invalid csum.
> > > > 
> > > > CHECKSUM_PARTIAL should be converted to CHECKSUM_UNNECESSARY for this
> > > > reason. CHECKSUM_PARTIAL implies the header is prepared with pseudo
> > > > header checksum. Similarly CHECKSUM_COMPLETE implies skb csum is valid.
> > > > CHECKSUM_UNNECESSARY has neither expectations.
> > > 
> > > But not if the packet is sent to a remote host. Otherwise an inner
> > > partial csum is never fixed by the stack/NIC before going out.
> > 
> > The stack will only offload a single checksum. With local checksum
> > offload, this can be the inner checksum and the outer can be cheaply
> > computed in software. udp_set_csum() handles this. It indeed sets lco
> > if the inner packet has CHECKSUM_PARTIAL. Otherwise it sets ip_summed
> > to CHECKSUM_PARTIAL, now pointing to the outer UDP header.
> > 
> > You're right. Regardless of whether it points to the inner or outer
> > checksum, a conversion of CHECKSUM_PARTIAL to CHECKSUM_UNNECESSARY
> > will break checksum offload in the forwarding case.
> > 
> > > > > Packets with CHECKSUM_UNNECESSARY should end up with the same info. My
> > > > > impression is this checksum conversion is at best setting the same info
> > > > > and otherwise is overriding valuable csum information.
> > > > > 
> > > > > Or would packets with CSUM_NONE being GROed would benefit from the
> > > > > CHECKSUM_UNNECESSARY conversion?
> > > > 
> > > > Definitely. If the packet has CHECKSUM_NONE and GRO checks its
> > > > validity in software, converting it to CHECKSUM_UNNECESSARY avoids
> > > > potential additional checks at later stages in the packet path.
> > > 
> > > Makes sense. The current code really looks like
> > > __skb_incr_checksum_unnecessary, w/o the CHECKSUM_NONE check to only
> > > convert those packets.
> 
> If I sum up our discussion CHECKSUM_NONE conversion is wanted,
> CHECKSUM_UNNECESSARY conversion is a no-op and CHECKSUM_PARTIAL
> conversion breaks things. What about we just convert CHECKSUM_NONE to
> CHECKSUM_UNNECESSARY?

CHECKSUM_NONE cannot be converted to CHECKSUM_UNNECESSARY in the
receive path. Unless it is known to have been locally generated,
this means that the packet has not been verified yet.

> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index 50a8a65fad23..44779d4c538b 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -174,7 +174,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
>                 if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
>                         if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
>                                 skb->csum_level++;
> -               } else {
> +               } else if (skb->ip_summed == CHECKSUM_NONE) {
>                         skb->ip_summed = CHECKSUM_UNNECESSARY;
>                         skb->csum_level = 0;
>                 }
> 
> Or directly call __skb_incr_checksum_unnecessary.
> 
> Thanks,
> Antoine



