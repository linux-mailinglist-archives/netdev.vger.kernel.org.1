Return-Path: <netdev+bounces-115503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641CD946B0D
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D827F1F211FB
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C91BC44;
	Sat,  3 Aug 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5qv630I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB61CD24
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722712749; cv=none; b=YJGZDqvChyrpl+kk5ety0+iTtp5NyayJutYPbyoAsHT8aO38jRQnBYOMbaZcWMJv/n4y+a4nr8TDPxvm690LpXLkFMwVbtM2aVn8EMSG8me5oBS04w0j+AnSQJfUkM6h4OWiqLLJx0MGEXZgFhrWLbuL3j9svXwHcEzzWCeSujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722712749; c=relaxed/simple;
	bh=8CQcj0rGvcx+snA2ExuXZhaDe4Y43Ojfuxr7a+xyBPg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MOLECWrX8EDtQSqzG1Q3Keh2GF0cblras03ohvPdfMQUPgSRUK6IyqWmHFJhcfQiEFNFu7dehwUOoPfsY4LtmIAW42s8fIn7bkAnJCOQwJR40fwdokdtVpFtswMi8ID/rdXveBLiFX9sVY+pYI8OkcUgFBNRNgeOl9O91+60Fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5qv630I; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bb987d3a98so14658956d6.1
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722712747; x=1723317547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcYvevcGDIz/Ztva/3Hy0MEgYDF8geiZvP0Ldmyjzuo=;
        b=A5qv630InNCnQvq7RI/P5rRHcGSdt6yd0XspYOeS7c+5PQ3ORbF/k+4cvKt09go9HC
         3fjinPEBPYWehWTc8V3GvAPjbhy11SJbHgdDtKAGFUDrbYv1Y7T/Xtbhh58894qZ1N87
         53QnrpL1XcEPNcreV4XxknU/Z1vj8MMbqRJxF23mdSLHfdE7ZQo36R6s3K7vu1bV37Fp
         X7UGnC+py+75ySHsKTN5hEXICHJEpiXv3r7ySTOcbUW59aqbtLNEwTRJY+pChQmBMgaX
         t0rDf+IcCoT1Wyd2PYu37ffDTldD867xAw7yzGrZ8+uBEmNKG8JueSkoCucs53TQsx17
         K7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722712747; x=1723317547;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mcYvevcGDIz/Ztva/3Hy0MEgYDF8geiZvP0Ldmyjzuo=;
        b=hZN7/2be1EgUmEJYpbtkQ7OPbtVO1ICDFkWzY92wmtw6V78n+irhMYiSK5QxAl8wH8
         cnx+a0AmZvSrJAJpvODzLwl8fncLtkr6wSDNzWshjBC+Qz27P0T+4G2lfg8bZMcR6lCM
         BM7RwSa96rfjozUbcoGyrHEIumPK7xtW4tZWyVjxOuf6U1QoElHOeSsBoBAP/3kXLE3S
         Ueybf7AZORjDW3YCTKtLtgQLSTpiT0RAINl+PVDVqFpZCNdHRxL4zYw6WfnSRldYZxlc
         AJwteg3tcfObD0RmCgn/cH0DK3GKy7j62ppcRu5G3wM2Q3j/GNQLaE+S2qIBwOHXS33g
         DWew==
X-Forwarded-Encrypted: i=1; AJvYcCXFT48Q02SaY4lMzRnQMgRYqffUXnxm+7kd4pIp12XaXid2LG9IszDuP7EhzQQnebD2oiuYXDcWIPxVdN2NS58jpwjiCeVc
X-Gm-Message-State: AOJu0YyamXX9IfTMfE0rX5GqEJfBWmESnQKDGAQC6jOMSrgQXoglTBru
	zv3qqEf/J6YY7Wm33IQPwQWdcNmlFrENufv9iH/z162X5itroy8B
X-Google-Smtp-Source: AGHT+IE+VmAmEFaAXekwGDLOv0tIxvw+2SaK5DPkQs5+GgrecAhDzMyzGSWWefhT36SE1dVh8YNa1Q==
X-Received: by 2002:a05:6214:5985:b0:6b5:101d:201 with SMTP id 6a1803df08f44-6bb983d58e1mr82568236d6.39.1722712747082;
        Sat, 03 Aug 2024 12:19:07 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7972eesm19034716d6.41.2024.08.03.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 12:19:06 -0700 (PDT)
Date: Sat, 03 Aug 2024 15:19:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ae82aa32061_2a823d294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ae816115189_2a7a1f29434@willemb.c.googlers.com.notmuch>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-11-tom@herbertland.com>
 <66ae816115189_2a7a1f29434@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH 10/12] flow_dissector: Parse Geneve in UDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Tom Herbert wrote:
> > Parse Geneve in a UDP encapsulation
> > 
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
> > ---
> >  net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 3766dc4d5b23..4fff60233992 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -11,6 +11,7 @@
> >  #include <net/fou.h>
> >  #include <net/ip.h>
> >  #include <net/ipv6.h>
> > +#include <net/geneve.h>
> >  #include <net/gre.h>
> >  #include <net/pptp.h>
> >  #include <net/tipc.h>
> > @@ -808,6 +809,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb,
> >  	return FLOW_DISSECT_RET_PROTO_AGAIN;
> >  }
> >  
> > +static enum flow_dissect_ret
> > +__skb_flow_dissect_geneve(const struct sk_buff *skb,
> > +			  struct flow_dissector *flow_dissector,
> > +			  void *target_container, const void *data,
> > +			  __be16 *p_proto, int *p_nhoff, int hlen,
> > +			  unsigned int flags)
> > +{
> > +	struct genevehdr *hdr, _hdr;
> > +
> > +	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
> > +				   &_hdr);
> > +	if (!hdr)
> > +		return FLOW_DISSECT_RET_OUT_BAD;
> > +
> > +	if (hdr->ver != 0)
> > +		return FLOW_DISSECT_RET_OUT_GOOD;
> > +
> > +	*p_proto = hdr->proto_type;
> > +	*p_nhoff += sizeof(struct genevehdr) + (hdr->opt_len * 4);
> > +
> > +	return FLOW_DISSECT_RET_PROTO_AGAIN;
> 
> Do you want to return FLOW_DISSECT_RET_OUT_GOOD if IPPROTO 59.
> 
> Per your spec: "IP protocol number 59 ("No next header") may be set to
> indicate that the GUE payload does not begin with the header of an IP
> protocol."
> 
> Admittedly pendantic. No idea if any implementation actually sets
> this.

And reply to the wrong patch. I meant this for GUE.

Also not sure how useful the separate __skb_direct_ip_dissect is if
then have to catch the error special case in the caller.

