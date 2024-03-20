Return-Path: <netdev+bounces-80895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A488818B3
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 21:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D791F22A07
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8A3EA9C;
	Wed, 20 Mar 2024 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es5kh5gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20612B97
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967438; cv=none; b=h2WMkR4DVWUQ3NQcmnwFikOYBniF1slkOLwvXfNMGoXlOgriG/eG3g8cAqdfaPQ1W7PGsPHTG5C7PkmOa2pQAmiMQSHbX6/5pvZH4YziQOq+CoGboEraojn4QEmy2NeZwP5PYM1od7gsb/960lJPEgBAf1drvsYPj8zVqDTPlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967438; c=relaxed/simple;
	bh=5IpT84Ypj+Bl/5qM/HdQiyf+8z4/6yqWL556CXtIkZs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uL81lcD9oiXjmOtJtTYAg2WydG9Wiyb8TTdtAd/r/DuXBixokjRhQan9LVtoVvQCIH4H9MBtvhUtZYBB2HqWq8uarzrXCwPGlyZgp7gbhZKjrTY0cygaikteKqeM9WKpSUn4ZtFuc6s3KfrXC+kf4UKPyzpOlycE/jhuECjsgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es5kh5gn; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c396fec63aso177156b6e.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710967435; x=1711572235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNFbkwrOxwU+lYcm7HbrPndRgYNZrjhvZg+YJ7HJNFs=;
        b=es5kh5gno2Nuk++aTMKARoiKdqQFmTzi9WW5ghhkk/9GWnAcjf+RZDLm4lSZ9OOZbI
         Rhg7S/05OzDJxirG8seKpW5sTP80AEQR0+MKiBboJhrEZYGrL2VyhMI9I+4T2iqyZhOP
         MuFirMSVe+bG7BxXnLFpsGD5k4vxPi/VCdjxMWq7hA2j1MXyC+X/oh3zE0VgDnU5t+vN
         YnPrst83djtdzfdRijYfGAF4yvPGe6PIESPvDst9J25LZ762d8S0f+X/5JnWJmF3hut2
         WUNrrHwylaxKA6nmCdMfGumzWYS8MHBGszFYz1sJeGk34K/DGnAecun8rXjWidqRk8EX
         Yt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710967435; x=1711572235;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VNFbkwrOxwU+lYcm7HbrPndRgYNZrjhvZg+YJ7HJNFs=;
        b=IO/epzYJhTxuklMNEvt979tbC3ZbMHnap/I21UzBws4MxpFVqcET7phyh4w0J8/mcx
         +fnBYmoosnexaRBB75FpqD09vZTf2KPyukWRzfQHIsYezvpP/5pK+nj7Rm5inSYo13HU
         x6gq0it+Jc0VbR3yQqHsZbpMdOxDaLYwqaE3A96Auhr9xyNQpyWpfbGdW1pYBLmeUU7c
         YA1+uBblEwmp5Rj5EXaeq2kfLEu158leKLrh1UwDrYjewMWR9M6q6pTS8Bt6EjXWUa+t
         L8k/o1haHOu74sunZaooHm181iqva+Xze0N77OxGaJz/baxev7VDV/rNUs1be3RTa9/8
         XGNg==
X-Forwarded-Encrypted: i=1; AJvYcCVTyFkmtGy+Z43hxVcn4tJU84u7efVmWGZ7IXKLC3i1ZKFfjfT6GBdSaaBj1k70OYFoZB3EKaF097kSkPG7io2mupM70Ikv
X-Gm-Message-State: AOJu0Yx2SPo4CRxZuFPIGPNg+EbEwtDyeIIxDruBGrUAraUCFffWVdzl
	swaiEDTWXHa94G2nUINqEMhcTkNqemdBQfdBM+NosMUSKUjrDH4pimIpxbRt
X-Google-Smtp-Source: AGHT+IGgLHWiRRdOCVMm05DNsSUiw25NrMtLUmhcREh3dhou/MdPqG76el2mYGuHZEZTkzVZuZf49w==
X-Received: by 2002:a05:6808:220d:b0:3c3:88d1:644b with SMTP id bd13-20020a056808220d00b003c388d1644bmr12211914oib.8.1710967435605;
        Wed, 20 Mar 2024 13:43:55 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id fe7-20020a05622a4d4700b00430d964aacesm3371432qtb.42.2024.03.20.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 13:43:55 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:43:55 -0400
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
Message-ID: <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch>
In-Reply-To: <171094732998.5492.6523626232845873652@kwain>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-4-atenart@kernel.org>
 <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
 <171086409633.4835.11427072260403202761@kwain>
 <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
 <171094732998.5492.6523626232845873652@kwain>
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
> Quoting Willem de Bruijn (2024-03-20 14:00:48)
> > Antoine Tenart wrote:
> > > Quoting Willem de Bruijn (2024-03-19 14:38:20)
> > > > 
> > > > The original patch converted to CHECKSUM_UNNECESSARY for a reason.
> > > > The skb->csum of the main gso_skb is not valid?
> > > > 
> > > > Should instead only the csum_level be adjusted, to always keep
> > > > csum_level == 0?
> > > 
> > > The above trace is an ICMPv6 packet being tunneled and GROed at the UDP
> > > level, thus we have:
> > >   UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
> > > csum_level would need to be 1 here; but we can't know that.
> > 
> > Is this a packet looped internally? Else it is not CHECKSUM_PARTIAL.
> 
> I'm not sure to follow, CHECKSUM_NONE packets going in a tunnel will be
> encapsulated and the outer UDP header will be CHECKSUM_PARTIAL. The
> packet can be looped internally or going to a remote host.

That is on transmit. To come into contact with UDP_GRO while having
CHECKSUM_PARTIAL the packet will have to loop into the receive path,
in some way that triggers GRO. Perhaps through gro_cells, as other
GRO paths are hardware NIC drivers.
 
> > > There is another issue (no kernel trace): if a packet has partial csum
> > > and is being GROed that information is lost and the packet ends up with
> > > an invalid csum.
> > 
> > CHECKSUM_PARTIAL should be converted to CHECKSUM_UNNECESSARY for this
> > reason. CHECKSUM_PARTIAL implies the header is prepared with pseudo
> > header checksum. Similarly CHECKSUM_COMPLETE implies skb csum is valid.
> > CHECKSUM_UNNECESSARY has neither expectations.
> 
> But not if the packet is sent to a remote host. Otherwise an inner
> partial csum is never fixed by the stack/NIC before going out.

The stack will only offload a single checksum. With local checksum
offload, this can be the inner checksum and the outer can be cheaply
computed in software. udp_set_csum() handles this. It indeed sets lco
if the inner packet has CHECKSUM_PARTIAL. Otherwise it sets ip_summed
to CHECKSUM_PARTIAL, now pointing to the outer UDP header.

You're right. Regardless of whether it points to the inner or outer
checksum, a conversion of CHECKSUM_PARTIAL to CHECKSUM_UNNECESSARY
will break checksum offload in the forwarding case.

> > > Packets with CHECKSUM_UNNECESSARY should end up with the same info. My
> > > impression is this checksum conversion is at best setting the same info
> > > and otherwise is overriding valuable csum information.
> > > 
> > > Or would packets with CSUM_NONE being GROed would benefit from the
> > > CHECKSUM_UNNECESSARY conversion?
> > 
> > Definitely. If the packet has CHECKSUM_NONE and GRO checks its
> > validity in software, converting it to CHECKSUM_UNNECESSARY avoids
> > potential additional checks at later stages in the packet path.
> 
> Makes sense. The current code really looks like
> __skb_incr_checksum_unnecessary, w/o the CHECKSUM_NONE check to only
> convert those packets.
> 
> Thanks!
> Antoine



