Return-Path: <netdev+bounces-164871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3097A2F82F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA88188632A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603E1A4E77;
	Mon, 10 Feb 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY+h6uH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75925E464;
	Mon, 10 Feb 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214494; cv=none; b=D12nyM3Umqfh0a0zyLOZhJUpXMyPuPf/fu8vTRoxqfii9N4Blsu0GroqL5pupZ8Hu184Jg0IYURbUioaux8CvoBHkt9VpJCb7Adk+3xDonB8bKsZYrymuY2avDiyUIphRucllgolODc+EAJB2Cv8UKli83FXBaFkMhj8XnT9zi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214494; c=relaxed/simple;
	bh=i/VZ9bdMqXIAENHDAymtATVZ2I5h/jGKY1OCV/enYbI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auP2l9QsAkc+HECOBCiBfh9jdBK28qBTB61PizopXU6jWSpBqz3ml7yjgtjJVV1+rdvXGD7LQidy7wk4QmlmFaL52JmhGHWrMKl9NaFn0U5V+Samg4IczUu3rhjBgjOSp1ZQgarkNFHs/XL8AEEJ65gmUC2przFtvZJoeG3SZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY+h6uH0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f7f1e1194so47482395ad.2;
        Mon, 10 Feb 2025 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739214492; x=1739819292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+qoehOBRxpJgiwh7h1hyJMzgtgPmoMtJw2FRm3MjtE=;
        b=jY+h6uH0WpAVdX+wLDdV3hW0OxQXanoGx6AepnLTXu8Pu7RRufkQq7UkPoIE6q4Ild
         AKPbgNuAwJg4iBN/6t45S3RW/7/Z6MT73ndIqcEkRqNsSx4yIcugoF7h9iqxmB6yOAjT
         JSytrnFwjqN6Ht4wKwxWQ3JwaLHqvNDb0xbZkc4xq0PrDywlSbGhtoVcSwvU4We/9wSh
         M3850EemO+01zJRe6Ydjd/nAxxjd6QXMiMn0L7UbhBop1UeOXWy2a5z6/P7BhHETHFf1
         BSSPQHaQbtf+Ceq8EqtzXvVccSwcflkJlIQFK+Vb8V6xBHNS9jMrSzXfBvsZmhwUEScx
         ZZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214492; x=1739819292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+qoehOBRxpJgiwh7h1hyJMzgtgPmoMtJw2FRm3MjtE=;
        b=Lzl4i0Xh2K4V91rQknc3YaWoSrDim/AHJulDM0J6jgjNbDgLegXVSLANmEWmqcswG7
         L7qoaQQnZqbX2baIALZvtjzYG9KI4u6Fy4MB2K2jpdLa0kSdjqWq4kGVDwGCKO9pH8Fx
         wWlBo38bcjOAtho+qxUacQwYxfaxKTp4uO+1cvjS4X90hA3HOgKvBnL6DFd/ypi8oie8
         5LGsqsOO3aB7gzbWZLNw2rDw1l7+GIT2yh3SiZ+CaVWcA40QcU8q0YwUBG0+qT5ZduHi
         2N9xWT+3wYcO7/iYSDyidZ9HMm7027DXliDEKvAm3dlVh+X5VdXtwaZ/NnKG4s9viQ+A
         i7hg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/e94uRSyGeP+xPBRn7bmf2kVeaF+ZMaXB345xE5ZhLufUK7Xlr8DOMloNVhNM8IABc7jOXJ5@vger.kernel.org, AJvYcCVAWdSGnGmYsQwqUO0MXRZhDdNnLvsazxsFQVXW4lwHi5/+2sDqz6JR+LdBj1hZCqPU0OX4UviuCKVN71A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAekfZAdTTzfYQsheySr5/2+oP0tjYUG7vwBD9FloEUaa70nGC
	PeDpHqOZIsX+0ZzYqqRGoYQf4IrmxnMoYu/qX0vJbz6DyPGOdEA=
X-Gm-Gg: ASbGncuJBSGljbM3a5ntFgTb/FE3Hw/AGsMKv1g/75Cvie5nfZ2pVCdNQtX8u3/sFcQ
	wBN1CLBytJNN9c4SE8MKxvjYo+geOw2y2D7xycRA/p728lcmjzUDBcRt4n3FtzkD13VpLfM1mtm
	57e6Y55UPMB+Pe3N4wdqP4kKh1soPeYC66Oe0CAaS1isezgl6HVjE7IopWzZi1oorRCiUlz9lv8
	3TodMq/b5mD26zguKr+eW47nAeYhqb2bbqBeC+8R1Ij0SsGXeLV47PMGJdI/8QobVdMAjITOhkn
	8UGfueN5L8JiZPk=
X-Google-Smtp-Source: AGHT+IEj5ctR7w1o0M+6wq7t+lv5dWplRciuoXrBrmbU+uTTXbO1hCCVTM+LrYd/T8rvBsRuAZxsUQ==
X-Received: by 2002:a05:6a20:d49a:b0:1e1:a0b6:9872 with SMTP id adf61e73a8af0-1ee03a45e2dmr25105163637.11.1739214491583;
        Mon, 10 Feb 2025 11:08:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ad53d451222sm3776993a12.15.2025.02.10.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:08:11 -0800 (PST)
Date: Mon, 10 Feb 2025 11:08:10 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
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
Subject: Re: [PATCH net-next v5 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <Z6pOmivi7Q402eGu@mini-arch>
References: <20250208041248.111118-1-jdamato@fastly.com>
 <20250208041248.111118-3-jdamato@fastly.com>
 <Z6gIU3bsIjsYqCN_@mini-arch>
 <Z6o_aMvoycAAJOd3@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6o_aMvoycAAJOd3@LQ3V64L9R2>

On 02/10, Joe Damato wrote:
> On Sat, Feb 08, 2025 at 05:43:47PM -0800, Stanislav Fomichev wrote:
> > On 02/08, Joe Damato wrote:
> > > Expose a new per-queue nest attribute, xsk, which will be present for
> > > queues that are being used for AF_XDP. If the queue is not being used for
> > > AF_XDP, the nest will not be present.
> > > 
> > > In the future, this attribute can be extended to include more data about
> > > XSK as it is needed.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > >  v5:
> > >    - Removed unused variable, ret, from netdev_nl_queue_fill_one.
> > > 
> > >  v4:
> > >    - Updated netdev_nl_queue_fill_one to use the empty nest helper added
> > >      in patch 1.
> > > 
> > >  v2:
> > >    - Patch adjusted to include an attribute, xsk, which is an empty nest
> > >      and exposed for queues which have a pool.
> > > 
> > >  Documentation/netlink/specs/netdev.yaml | 13 ++++++++++++-
> > >  include/uapi/linux/netdev.h             |  6 ++++++
> > >  net/core/netdev-genl.c                  | 11 +++++++++++
> > >  tools/include/uapi/linux/netdev.h       |  6 ++++++
> > >  4 files changed, 35 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index 288923e965ae..85402a2e289c 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -276,6 +276,9 @@ attribute-sets:
> > >          doc: The timeout, in nanoseconds, of how long to suspend irq
> > >               processing, if event polling finds events
> > >          type: uint
> > > +  -
> > > +    name: xsk-info
> > > +    attributes: []
> > >    -
> > >      name: queue
> > >      attributes:
> > > @@ -294,6 +297,9 @@ attribute-sets:
> > >        -
> > >          name: type
> > >          doc: Queue type as rx, tx. Each queue type defines a separate ID space.
> > > +             XDP TX queues allocated in the kernel are not linked to NAPIs and
> > > +             thus not listed. AF_XDP queues will have more information set in
> > > +             the xsk attribute.
> > >          type: u32
> > >          enum: queue-type
> > >        -
> > > @@ -309,7 +315,11 @@ attribute-sets:
> > >          doc: io_uring memory provider information.
> > >          type: nest
> > >          nested-attributes: io-uring-provider-info
> > > -
> > > +      -
> > > +        name: xsk
> > > +        doc: XSK information for this queue, if any.
> > > +        type: nest
> > > +        nested-attributes: xsk-info
> > >    -
> > >      name: qstats
> > >      doc: |
> > > @@ -652,6 +662,7 @@ operations:
> > >              - ifindex
> > >              - dmabuf
> > >              - io-uring
> > > +            - xsk
> > >        dump:
> > >          request:
> > >            attributes:
> > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > > index 6c6ee183802d..4e82f3871473 100644
> > > --- a/include/uapi/linux/netdev.h
> > > +++ b/include/uapi/linux/netdev.h
> > > @@ -136,6 +136,11 @@ enum {
> > >  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> > >  };
> > >  
> > > +enum {
> > > +	__NETDEV_A_XSK_INFO_MAX,
> > > +	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
> > > +};
> > > +
> > >  enum {
> > >  	NETDEV_A_QUEUE_ID = 1,
> > >  	NETDEV_A_QUEUE_IFINDEX,
> > > @@ -143,6 +148,7 @@ enum {
> > >  	NETDEV_A_QUEUE_NAPI_ID,
> > >  	NETDEV_A_QUEUE_DMABUF,
> > >  	NETDEV_A_QUEUE_IO_URING,
> > > +	NETDEV_A_QUEUE_XSK,
> > >  
> > >  	__NETDEV_A_QUEUE_MAX,
> > >  	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index 0dcd4faefd8d..b5a93a449af9 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -400,11 +400,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> > >  		if (params->mp_ops &&
> > >  		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
> > >  			goto nla_put_failure;
> > > +
> > > +		if (rxq->pool)
> > > +			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
> > > +				goto nla_put_failure;
> > 
> > Needs to be guarded by ifdef CONFIG_XDP_SOCKETS?
> > 
> > 
> > net/core/netdev-genl.c: In function `netdev_nl_queue_fill_one´:
> > net/core/netdev-genl.c:404:24: error: `struct netdev_rx_queue´ has no member named `pool´
> >   404 |                 if (rxq->pool)
> >       |                        ^~
> > net/core/netdev-genl.c:414:24: error: `struct netdev_queue´ has no member named `pool´
> >   414 |                 if (txq->pool)
> >       |                        ^~
> 
> Ah, thanks.
> 
> I'm trying to decide if it'll look better factored out into helpers
> vs just dropping the #ifdefs in netdev_nl_queue_fill_one.
> 
> Open to opinions so that hopefully v6 will be the last one ;)

Might be too much boilerplate for the helpers? (assuming you
want empty helpers for #else case). The only other place that tests
rxq->pool is devmem (net/core/devmem.c) and it uses simple ifdef
in place.

