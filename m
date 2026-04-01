Return-Path: <netdev+bounces-273983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL62MvbVzGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:23:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C0E376B61
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED4D63054B09
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2A3A9DB0;
	Wed,  1 Apr 2026 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L85HWBCT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A75CgZmW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8258399361
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031704; cv=none; b=llnFS3twMNlR30bHfheCEAspOrp0gO1Qw5KUeE2wmOtg0TwSNNvQhnEXO8tEvgZU0FuRYCdESpgi2u5+cD5a+J+JjiYGUGLTnrlFdWw21YSG9Y/yZeVQ3BziorJ35WdLGq3T7eZkp4EKuimNQzD39TybDC3lutsCWwNIUpVmLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031704; c=relaxed/simple;
	bh=mE58UPyJl/FiMLUP216GucoGkRmpDm4sFWboaotFA54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmXV8A2B1AydRo3oakMS9RiJNmNYNnqofkzvb7Xkl5Os4y/BsF114yVVDpwEfGXwF4yxvwXs+J5qJxLTEWBQLCb5RrYBuOS+fEyYTgVxB8lWN6Zyj6Xv0MQenvXwjfgTEzSWcYcC9unjoI7Iiy7iNkdS8h1bj70iejN4Ihue+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L85HWBCT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A75CgZmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775031702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFlf2MdDkifmThFJKZCcvKogFCBxiEgmNxrJgdVh+Lg=;
	b=L85HWBCTk6f5/pxyVCl7a9p+Lke1Cl2jSn7fzq8WJfBOUrCA//k5PNXOxz/O/ugm2mUFkB
	k9wYWP2R9Xr6I0EeFM+rLLbUFwfRh/qcvTHKFKaxp/GrpnUe/QEiXOB4UAiPP2KYD8pgsv
	tWu8BqzAdRQk8Nf8pg7YflDgmvLoBgY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-LF5soj0yNOmsmNLsONtVaA-1; Wed, 01 Apr 2026 04:21:41 -0400
X-MC-Unique: LF5soj0yNOmsmNLsONtVaA-1
X-Mimecast-MFC-AGG-ID: LF5soj0yNOmsmNLsONtVaA_1775031700
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso72266585e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775031700; x=1775636500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFlf2MdDkifmThFJKZCcvKogFCBxiEgmNxrJgdVh+Lg=;
        b=A75CgZmW345a1CUYbHimxiSs/IIKpO/IhFL1YDHIY+GhyUoCpeuWFOKojlJXXZ5AWl
         DYSi/RW669lMjUQmp0ZTWKgg0JFWMYmM/CalBqX8ivWIKg2AY9iUTDjeqo5rRThTCU6r
         2OkM0a+d68SBsGdcB3gYnmSQyPtFGViBDrjUN7VfgB9Qu+s1w+dQmx5gjT768VeXMtdL
         YNnueTnb9EDXKXfPgZ3XDDSuD8c+kxtTMk5T0t29BMc7n3CE0VvbuixQr01PmLC3wS2o
         8w9kQ/km/JlpGnAjgOdrV5zBxbU26oaxCLCkmmDUklN+MclHWuUOhlA/ZCnIFOeyvjg/
         qIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031700; x=1775636500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFlf2MdDkifmThFJKZCcvKogFCBxiEgmNxrJgdVh+Lg=;
        b=AwypT5hXOYFvdrEx98nNVNtR18zJ2k2QeTW5ksXuFYDhXli50eWA4qKHdLpUOXEgCH
         hTrRIV31DZIL0Vl35OEJMKrJEPtSoa1g9I8bKmusohP0y65WHAt+49qlezGZj6QQhZBq
         wgNoldCQbiIT3iIaOBqrKl7O/fXDybWf61BkcLoA2siKfLG/Q8l0scNt+MGnegoIKK4k
         HNys7XRlCM7FomhX7OsRNwCHb3zVKtsA72zz1bOMfok7j2wpHxcDuLzpS3KrAcDbZC3K
         AMmPeGOi0G7w0EYrZ/aMsCNTImjFNPb2b3YNPcDtpznGS2bO8f+wg0FNoUDhm5QxAGYO
         yhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtSgopc5MJgoM1oLcgJzxV6pX9/mQMR/v6CEdkZcyG/FvVzLxulpaXXHlYfrsQZOyiSdGIScY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvAcrvy49tIzzFOy3HASBOOqm+EYbhe9H3ihD9byNaLeHm5sI
	3ACxX6k+xojSHxV3UItY33KvFl7INu/2q2lgHAlI9bFxY/of2hE3Jv6PSCJwMzC7E2Xdv+F4c4J
	b7NeeRiqNOU8j5cI2/sz9PiTIFiQp9PE0L13ppvQMcp2JWPlaD4rIvrmGuA==
X-Gm-Gg: ATEYQzyMhVZC4MkfOlqK9krkV4DuUMEnkBMimsAt41AExo6XahhIaX/IJUaAcSM6jtl
	He52CzMygMHlWfE1Iiw5X74v89VCzVn4jgPPKUMmx52sxiSJKsAiSm4+BYyXFlnIjk40IGOqFBE
	Csz2SAKc01APYVhh0XI+Z6vfn6bh+oB7vRGWwMTaHRbIooEFUJQEz0IFfqZjBL2wRlV5/j+FLnz
	DjnCdZG5lXH7KeeRi3RbWiQNS8MZ9zknyLmtoCgY2EenEx4OG4q5A/IPjR3a2WOBc8BZsg559qy
	WTat5tcEohcGaXboHyaCroBwXAfz6tRLUM6TNXrTz91jKrn84biKYNTZelV7dSI0uSWtZXp7RWD
	N4p6plee1TQ0PYLQT
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-488835c0534mr45597835e9.31.1775031700294;
        Wed, 01 Apr 2026 01:21:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-488835c0534mr45597015e9.31.1775031699827;
        Wed, 01 Apr 2026 01:21:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e29b1sm32050464f8f.8.2026.04.01.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:21:39 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:21:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Srujana Challa <schalla@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
Message-ID: <20260401042119-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
 <20260331104737-mutt-send-email-mst@kernel.org>
 <20260331180522.64ef9886@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331180522.64ef9886@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273983-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2C0E376B61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:05:22PM -0700, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 10:48:41 -0400 Michael S. Tsirkin wrote:
> > > > Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> > > > also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> > > > I added the message to make clamping visible in that case.
> > > > I will remove the check and send the next version.    
> > > 
> > > I'm sorry, I haven't looked at the historical context when I wrote my
> > > previous reply.
> > > 
> > > IMHO the additional check does not make sense in the current net tree.
> > > On the flip side stable trees will need it. I suggest:
> > > 
> > > - dropping the check for the 'net' patch
> > > - also dropping CC: stable tag
> > > - explicitly sending to stable the fix variant including the size check.
> > > 
> > > @Michael: WDYT?
> >
> > I was the one who suggested it, the extra check is harmless, I'm
> > inclined to always have it.  Less work than maintaining two patches.
> 
> Give us an RB tag please and lets close this one? :)

Oh I thought I did. Thanks.


