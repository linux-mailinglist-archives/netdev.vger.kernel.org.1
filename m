Return-Path: <netdev+bounces-210065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDBB1206E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F57B7A02AB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12F230BC3;
	Fri, 25 Jul 2025 14:58:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F61E766F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455483; cv=none; b=NdgIQRyxuWlUCAOQn5dE6BIShrjWSWyFPKpB/9zuL2HH1N0yu7Vu9NUbVgGu4MTeZJXubOTutL7+jVMIPcShT1IcTGx0QulwYVaSb4R4G0xBOJrjTd73IqIqOBVYl5oOCyJuoSQr9q6pjV+iGCezUlUNcQ2g3ej+NTYA5ynnE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455483; c=relaxed/simple;
	bh=VQtC79Jf36rnmhG2oTaadd4LmmAqcE7wQ92N1nt3tgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOhZwQ/HaX5us6GCBxrNTmVWBw31qjcGzU1zzCAq4nEW1SpA81mHs6mhcTUNA3+/Z98VQawsU7+awhSzcWmCsHqtX/VhS0K1nwDMPvAfaHOWPl0btNISBZGMUsrM6ja1iHd9Ea/e4dEqwZj4ZpVQiSbFThtIiGRAMxL7dT+GKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af2a2a54a95so351925266b.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753455480; x=1754060280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvPcJQlPXVJLfV8kVOEKCp8BQ2CqQWZe9kWv0oSE8Mw=;
        b=Q8ADQ+1e6Ifj44ksiDPDNYWM+B9fQ4PMsEE3jeIs5LAyWx2tH7vNiQoQmvlpjDqRdb
         /R041H3mcEH0T6HdofIDRZJS99gy4JfJqsYgpo364A91YJuGrp6kv2pnAbfS/scjSrsk
         O64Nm0GtrMV2lPcZtOUSUM2v5o0YKi8dUsc+8qWkvkK3lHINSn6HCByaWhQ9we5LpMVU
         R7gds3JwRT+63r6BfL4D9XKbPGN5jZ4YKQRNhOUnGjpu1OEHphBkLx1FFYUdy3A8iE8G
         rGezSgao3xHM7soXvS/r24JuI5yUnhP2Lmd84EJPQ181gebceOM3Pe0ym0UC1r42rlDy
         zy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0FtgJkpCcCkDqYXWmBpZt7Cwr/M4SHXPmsLczpFxO6nXDkf5GsLoph13DqeK0XjVqe4wRCkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbrSblnNcJnPo49oCET+PMVUceCpPUPF+8v7vqAdKDgL+xbH8
	pKyMLa+sdSvTLBTE+F/eqN8zj9EDqfpuXKrGc9HbSBhU/oNXnoXcyJ4E
X-Gm-Gg: ASbGncuYXVF5vEtS07p39SQx94OchC3GkzQBXg2wimiZUaMZD90tE2X4ELv3D9RtVuk
	gdPUoNRPlSnr6I1XMWcFZEPavS0icJ89/l6V91p+oNtQChgM3Gg2lAm0ZVeegGFdiabUFxYdDMx
	rIgwWdvpOospqIEugLbN5lWxTTfdecAd8G3BSAYeO02fZCpdb3GJ3+Eki1IGArIfnqco/Ny5Mla
	3gIwVQnP5I2IdUKE9TG5TRZPhvBeqVTmvo1ORBn0Xda9RbeB95LXEBBAPM2JRqe/nTSKohO+Jm0
	/9ReYgoupYJ5qDcn4LeKxtQv1Lu9FxmVx+0r/OpkkX6QfDdf8+gvt1gtIOtYYdTUFjOK3WSHym1
	yx9og5bRGZioWndIupwRMYxE=
X-Google-Smtp-Source: AGHT+IFlTAmCz7KBCpiLUlmMrIW6PTA5lY3+SI2Jc3e5CG3n4kfLMyxT5kR3QStihLIwwrBub6Uy7w==
X-Received: by 2002:a17:907:2dac:b0:ae3:c968:370 with SMTP id a640c23a62f3a-af61e9224d7mr241390366b.59.1753455479413;
        Fri, 25 Jul 2025 07:57:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635687ff0sm6547066b.0.2025.07.25.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:57:58 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:57:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Jason Wang <jasowang@redhat.com>, Zigit Zo <zuozhijie@bytedance.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, sdf@fomichev.me
Subject: Re: [PATCH net] netpoll: prevent hanging NAPI when netcons gets
 enabled
Message-ID: <dlzyk2xvkdqk75urljgazy7e4hxn4jwozpb3skpgitb3oihmxp@54dgi77ndjvk>
References: <20250725024454.690517-1-kuba@kernel.org>
 <837ee1c6-a7c8-490b-84ae-6c24fdd48e4e@redhat.com>
 <20250725071434.4e1611fe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725071434.4e1611fe@kernel.org>

Hello Jakub,

On Fri, Jul 25, 2025 at 07:14:34AM -0700, Jakub Kicinski wrote:
> > > +static int netconsole_setup_and_enable(struct netconsole_target *nt)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = netpoll_setup(&nt->np);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Make sure all NAPI polls which started before dev->npinfo
> > > +	 * was visible have exited before we start calling NAPI poll.
> > > +	 * NAPI skips locking if dev->npinfo is NULL.
> > > +	 */
> > > +	synchronize_rcu();  
> > 
> > I'm wondering if it would make any sense to move the above in
> > netpoll_setup(), make the exposed symbol safe.
> 
> Fair, somehow I convinced myself that the nt->enabled = true;
> is more relevant.

Why not doing it in __netpoll_setup() side instead of netconsole?

If I understand the problem clearly, this is a problem on netpoll
initialization, and netconsole is just one of the users.

I am wondering if calling synchronize_rcu() after rcu_assign_pointer()
might not be enought.

	diff --git a/net/core/netpoll.c b/net/core/netpoll.c
	index a1da97b5b30b6..a20b8cf261306 100644
	--- a/net/core/netpoll.c
	+++ b/net/core/netpoll.c
	@@ -600,6 +600,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
		/* last thing to do is link it to the net device structure */
		rcu_assign_pointer(ndev->npinfo, npinfo);

	+       synchronize_rcu();
		return 0;

	free_npinfo:

	
Thanks for investigating it, this is a fascinating bug.
--breno

