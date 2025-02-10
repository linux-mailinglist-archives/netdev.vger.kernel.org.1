Return-Path: <netdev+bounces-164872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196CCA2F840
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB26216826B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC3257ADB;
	Mon, 10 Feb 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HXgBC0zg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7E1F4637
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214610; cv=none; b=YmTfcC0ZspcB/zjN2fnkvFtyTgqDTYiQQWp8au8hDVCygeppST2+smHlonQajOXtluJZezmwQMoxcNl2mB9gjlQAHqdqFR7ikHXrsR+vxDl0oT2LV2eVbXYLOrZulA13Cw1tvh4S/ECZO6C4gPr10T3msCYFusGdDWmXK4FSFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214610; c=relaxed/simple;
	bh=F8TLy62eIIQSqxdl3cyaLm34fn+6NoPzRvaRWbDceDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+BfgllVnQyaG+3V38/mF8eTMmpumuA8k6jtAZ9W0beh04V6fvxcjPEn0kJ234AQABJXFC5+hzDCpAlCgkVX3StQtvSbExllPXzuNArh15rvF7+1P1S6RmFUGYaRJ5V+Oe/38R/MMDOiqvjxMKji74TShvamOocha8+Guhhf8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HXgBC0zg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f55fbb72bso55678855ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739214606; x=1739819406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4a07qAVXvekaoHoSRZDuORG6twKeZ8h2QSLVbQg/61w=;
        b=HXgBC0zgjKQlbqtgPhyEFqxIC9ZwJRIB/b/7+sguD9pWReaYErkUwEWUp05BIn0eB1
         20Elcw472YvlH94aJ+KVMyfZOuLJfaOJHI87Fk+VwrSl8qKmh9gSKt6nbqwPqQ3oKYcO
         jIwC4N4u80xphihG/B/ar9Dq7IjniQUkk2WoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214606; x=1739819406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4a07qAVXvekaoHoSRZDuORG6twKeZ8h2QSLVbQg/61w=;
        b=YdPK9Q9ERr5I/jfWLjI6qrdmddoNHpIiQm6PiU99te++CO3ooQ3OY/2VnEAaQoc2cA
         m5DJ1Wr+0f0YLu1wx4OXRjTDKf/kUfd7jpjZYZebOlMety2vOQo0FrYeeYBWJo/qrwtp
         nshRJTXYufcUvfKTLE9RBtpSQDTzaWK9bxxaeWI5iWEAI20lMnTh4MiPswcSj5S4/Z+l
         DOUQ0HoNXzK/PMC/Izu29vCPn0JDCCqXKSGYcp0Jq8HF4ZiItAaC2V+Iyg5SOtII1N2f
         HQ5Hi6gq6k/gbtjFg62PVMXLcj1Sd8GSg9L0DBcMjleamlQvdSSd+C+cwEUckXJQZ7t1
         BjtQ==
X-Gm-Message-State: AOJu0Yx03t5HqoBiO8TyrRIPHt/E0kzIfwVtGMUOB7wajKQv3QI/qe0O
	T+DTbne6xWwBKIEZNgzNaKtb6oXklL+quJ4y3Ml1CAkh7Ar9phW+DnCDHmDPvy8=
X-Gm-Gg: ASbGnct9CuGrOhh/bBjDSY4n+HbjqRh62+mYFjJPEoX/uZ8rkecsHK7QXot2zXY81Df
	l21QXc+xSO1Rep1HrIIXSpDFGALI8i7OJwxhfmUTdQEfKDUUkMkthnKs2Wg4Hsnl787vDpW85zt
	QQWlcOcePKOpQ460oELna2vto5G6KQmtHV4AXNF01PN4Pz8Po4bbyC79//esPHPOhf+lh2obBDr
	rnyXCscUOXGJKBA3r3OAdYSnoliuAMTwjI/fobSoNdCbhlnqI4ANYPutEv0+gbJJ91sgqMLCFXg
	Lg68XSadV1Uy5wZ5PPDvfHtdBY6kRf/DVUTkCNh+QHJviZoknqrWeOGdkw==
X-Google-Smtp-Source: AGHT+IGx6n3TV4jyZk7JKcd97LiZfE6lztyRoQj5NCSoNF+D22YEjkXprMsgyw+BUknJJLAM1hWE/Q==
X-Received: by 2002:a17:903:2311:b0:216:2dc5:233c with SMTP id d9443c01a7336-21f4e73fb28mr248516395ad.41.1739214605998;
        Mon, 10 Feb 2025 11:10:05 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687e0casm82672515ad.174.2025.02.10.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:10:05 -0800 (PST)
Date: Mon, 10 Feb 2025 11:10:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <Z6pPCpVvg0xOuvKJ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	horms@kernel.org, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>
References: <20250208041248.111118-1-jdamato@fastly.com>
 <20250208041248.111118-3-jdamato@fastly.com>
 <Z6gIU3bsIjsYqCN_@mini-arch>
 <Z6o_aMvoycAAJOd3@LQ3V64L9R2>
 <Z6pOmivi7Q402eGu@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6pOmivi7Q402eGu@mini-arch>

On Mon, Feb 10, 2025 at 11:08:10AM -0800, Stanislav Fomichev wrote:
> On 02/10, Joe Damato wrote:
> > On Sat, Feb 08, 2025 at 05:43:47PM -0800, Stanislav Fomichev wrote:
> > > On 02/08, Joe Damato wrote:
> > > > Expose a new per-queue nest attribute, xsk, which will be present for
> > > > queues that are being used for AF_XDP. If the queue is not being used for
> > > > AF_XDP, the nest will not be present.
> > > > 
> > > > In the future, this attribute can be extended to include more data about
> > > > XSK as it is needed.
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > ---
> > > >  v5:
> > > >    - Removed unused variable, ret, from netdev_nl_queue_fill_one.
> > > > 
> > > >  v4:
> > > >    - Updated netdev_nl_queue_fill_one to use the empty nest helper added
> > > >      in patch 1.
> > > > 
> > > >  v2:
> > > >    - Patch adjusted to include an attribute, xsk, which is an empty nest
> > > >      and exposed for queues which have a pool.
> > > > 
> > > >  Documentation/netlink/specs/netdev.yaml | 13 ++++++++++++-
> > > >  include/uapi/linux/netdev.h             |  6 ++++++
> > > >  net/core/netdev-genl.c                  | 11 +++++++++++
> > > >  tools/include/uapi/linux/netdev.h       |  6 ++++++
> > > >  4 files changed, 35 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > index 288923e965ae..85402a2e289c 100644
> > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > @@ -276,6 +276,9 @@ attribute-sets:
> > > >          doc: The timeout, in nanoseconds, of how long to suspend irq
> > > >               processing, if event polling finds events
> > > >          type: uint
> > > > +  -
> > > > +    name: xsk-info
> > > > +    attributes: []
> > > >    -
> > > >      name: queue
> > > >      attributes:
> > > > @@ -294,6 +297,9 @@ attribute-sets:
> > > >        -
> > > >          name: type
> > > >          doc: Queue type as rx, tx. Each queue type defines a separate ID space.
> > > > +             XDP TX queues allocated in the kernel are not linked to NAPIs and
> > > > +             thus not listed. AF_XDP queues will have more information set in
> > > > +             the xsk attribute.
> > > >          type: u32
> > > >          enum: queue-type
> > > >        -
> > > > @@ -309,7 +315,11 @@ attribute-sets:
> > > >          doc: io_uring memory provider information.
> > > >          type: nest
> > > >          nested-attributes: io-uring-provider-info
> > > > -
> > > > +      -
> > > > +        name: xsk
> > > > +        doc: XSK information for this queue, if any.
> > > > +        type: nest
> > > > +        nested-attributes: xsk-info
> > > >    -
> > > >      name: qstats
> > > >      doc: |
> > > > @@ -652,6 +662,7 @@ operations:
> > > >              - ifindex
> > > >              - dmabuf
> > > >              - io-uring
> > > > +            - xsk
> > > >        dump:
> > > >          request:
> > > >            attributes:
> > > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > > > index 6c6ee183802d..4e82f3871473 100644
> > > > --- a/include/uapi/linux/netdev.h
> > > > +++ b/include/uapi/linux/netdev.h
> > > > @@ -136,6 +136,11 @@ enum {
> > > >  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> > > >  };
> > > >  
> > > > +enum {
> > > > +	__NETDEV_A_XSK_INFO_MAX,
> > > > +	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
> > > > +};
> > > > +
> > > >  enum {
> > > >  	NETDEV_A_QUEUE_ID = 1,
> > > >  	NETDEV_A_QUEUE_IFINDEX,
> > > > @@ -143,6 +148,7 @@ enum {
> > > >  	NETDEV_A_QUEUE_NAPI_ID,
> > > >  	NETDEV_A_QUEUE_DMABUF,
> > > >  	NETDEV_A_QUEUE_IO_URING,
> > > > +	NETDEV_A_QUEUE_XSK,
> > > >  
> > > >  	__NETDEV_A_QUEUE_MAX,
> > > >  	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
> > > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > > index 0dcd4faefd8d..b5a93a449af9 100644
> > > > --- a/net/core/netdev-genl.c
> > > > +++ b/net/core/netdev-genl.c
> > > > @@ -400,11 +400,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> > > >  		if (params->mp_ops &&
> > > >  		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
> > > >  			goto nla_put_failure;
> > > > +
> > > > +		if (rxq->pool)
> > > > +			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
> > > > +				goto nla_put_failure;
> > > 
> > > Needs to be guarded by ifdef CONFIG_XDP_SOCKETS?
> > > 
> > > 
> > > net/core/netdev-genl.c: In function `netdev_nl_queue_fill_one´:
> > > net/core/netdev-genl.c:404:24: error: `struct netdev_rx_queue´ has no member named `pool´
> > >   404 |                 if (rxq->pool)
> > >       |                        ^~
> > > net/core/netdev-genl.c:414:24: error: `struct netdev_queue´ has no member named `pool´
> > >   414 |                 if (txq->pool)
> > >       |                        ^~
> > 
> > Ah, thanks.
> > 
> > I'm trying to decide if it'll look better factored out into helpers
> > vs just dropping the #ifdefs in netdev_nl_queue_fill_one.
> > 
> > Open to opinions so that hopefully v6 will be the last one ;)
> 
> Might be too much boilerplate for the helpers? (assuming you
> want empty helpers for #else case). The only other place that tests
> rxq->pool is devmem (net/core/devmem.c) and it uses simple ifdef
> in place.

Yea, I saw that. OK, I'll just drop the ifdefs in and see what
happens.

Thanks for the review; appreciate your time and energy.

