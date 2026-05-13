Return-Path: <netdev+bounces-287750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD9KDoYNBWqBRwIAu9opvQ
	(envelope-from <netdev+bounces-287750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:47:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FAC53C1F1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B56CF302635E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38E3CE4B6;
	Wed, 13 May 2026 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cVjn7pyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83AC3CDBCF
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716019; cv=none; b=XASSFnecSkl5Ms4qHZOT8yfUqpB06Lm3y1C7aZyTUx5FhTGf3uWPJ0F/6wmwXPWXZ8Hq2TXh9Evbh/Mq/JO+VAGqiKQvqGtywV2CqZ3OIOwxJx/IehRYyVDEG90mAjv7FNLUB+NXKHm/dkQ19zSpsJHQ3S6wz/nK/BhqaqGY5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716019; c=relaxed/simple;
	bh=nABnyTVpdpjK5O3wtbrmycZjbC6IhActFaxQTKL0PH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy/WeZNwk+j/ifBXr5upa8lxwVwOpjaNq2bNrr+zmiN7lL+lFrjsoyQVj8zNubksbhLVQU+JwTBD8K6PAUXJzbSTQPD/VC3bebCIPac28H21fkd4oc6XjgliL6rLvnHeBYyc7RWNAQwKalI1AW6vFpjBps9SMK8IqKz0V1Jd1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cVjn7pyJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90d042fa745so396684085a.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778716017; x=1779320817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkTU6tjGG+nOcVlZzdhoBVAzDEp9yyRsCuO17s66584=;
        b=cVjn7pyJuevwdWBS6gPt8TLoDkrW9VAXpoE7Cl1n1yF5qQYP+tjhho9mp/KOcejhUb
         GVy8+HRmlr3ubV07o+9Tkw5Hs3+GFPmLBsbT4Zm0axwX3xT45WeEE5TxBMXgcJpCfapD
         0glamCEwT0CwmffxtXTk3rmHxpq1axM6p48A6HjJm/zYaPAFJUr8nQH5gLEiJHKAy+Ee
         5JB7EPB/JvHsbuV7J525JCN7ck5YKEwfiAW4XSHzvoTg1jcA5sNyoqlSx3Y/AjYKp0qC
         psyTvIntQ7LAIqChx2CNg5D0Q0nGLYxml5PTkqSSxpzgrpXiZ3Aro/3Jhz/fw09x8IM0
         NmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778716017; x=1779320817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkTU6tjGG+nOcVlZzdhoBVAzDEp9yyRsCuO17s66584=;
        b=blDNnnH2vXpKqvbGuMn/0zawxnotDL3CrS+l4FY/JGeUbF2N3IFCvE21Py+x/45DDg
         Y12hvcUWzONhrni8PfHW49UPsZm6f4el+u8wX3V7GL3BT5Q0loC4Br3eQJQgkkxKnKip
         F6f9j+j0myWmMYNKkJ1W1FpIsUztNNXjg9e34Fy6isdUpuz7ol8YxYrGlf3GEd0lTQuK
         EGLvVcaZ8yhm+ryg2mfWuVjDd6v4XZNQiUg7zEfMvZU7yH8wSz8koXTnI9A6uGoQozg2
         pzWgdWbjcpJrkrK94blvymKlNP/zzBF5kQ1s4JOhO1PelR3J8q0LcETgWkmqmErx6MmV
         yaCA==
X-Forwarded-Encrypted: i=1; AFNElJ9VYN5kMByAlk6qnuytj8pm+pU/jHKo3sYPiTU38T/JZKKM8GwMzmoLjkMeSTHIyzNnAR+q3z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwgIKDWd/PjpdcTOgbCH6vFx7PwX5vsan28Cc7gF53V5lGUFY
	5S+GousP0FEFDFrWcUPPamLYenWsKU0eSSgetezdEAwAj+7S2rS+WkMxbgBntEPJ1SA=
X-Gm-Gg: Acq92OEzXsbUQgMK1mRf8l8xJuTLbuHsoL0rNkACGkk2ao/7DofJ/eGDPZYuAdgFC1f
	vErQCdjA8U1DFp1lDdyt0xBXyI958FNhAR8I8LL4fur87BYaqTKH7nt/VmayKOUrl2EKqJLbdte
	WFrcJ+Err8do8WZ5pgkn25sZAXTwUAS/Z163DIuQUfmLDurVjR/L51U+O5jN+6xx0v2jJz9mpNA
	69vl5ytHGaJ/iax11Qs5+SKe31qw0U2Gmh5WMNQuaq5FXMmOjoDSgz+hYoBeqntdd78hrr9aXzk
	M4c9KA4d89b+V92PIbrHMiNtDUJNEhcbZ73ZQIyIBp/bCsg6M7uGbtum6p2n/LpvfrQrPazhPbC
	oKZa8OYCjz48OhuRquIgC1O85cpTvAyY89rv4qZHwkkLAhANNk85GsL1i4E2lnSIskyoosLN8tb
	zZim7+glDnAeUyO3qzoMuk029CocZsMUxlaNNYtoeEKOdnKNdVAw0ZK2iLchNaU3Fnv+GT2pYUt
	e3FPQ==
X-Received: by 2002:a05:620a:4409:b0:910:3078:5cf6 with SMTP id af79cd13be357-910307868dcmr532307185a.44.1778716016939;
        Wed, 13 May 2026 16:46:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae27359sm107053985a.17.2026.05.13.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:46:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNJHz-000000048gW-3syt;
	Wed, 13 May 2026 20:46:55 -0300
Date: Wed, 13 May 2026 20:46:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
	arjan@linux.intel.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, hdanton@sina.com, horms@kernel.org,
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Message-ID: <20260513234655.GW7702@ziepe.ca>
References: <tencent_611BEB4B141B1A2526BAA3BBB2335F9E9108@qq.com>
 <177869624862.2335447.16979087766093395765.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177869624862.2335447.16979087766093395765.b4-ty@kernel.org>
X-Rspamd-Queue-Id: 40FAC53C1F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,qq.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> 
> On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> > We must serialize calls to nldev_dellink() or risk a crash as syzbot
> > reported:
> > 
> > Call Trace:
> >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> >  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> >  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> >  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> >  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
>       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d

This seems like a rxe bug, I would have expected the lock to be inside
rxe to protect its racy implementation of rxe_net_del(), which looks
like it is possibly also triggered by NETDEV_UNREGISTER...

ie it should not change nldev_dellink().

Jason

