Return-Path: <netdev+bounces-293049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEpDBZRSGWpnvAgAu9opvQ
	(envelope-from <netdev+bounces-293049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:47:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604DD5FF6BA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903753062C04
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01361340409;
	Fri, 29 May 2026 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dl+Mc6XC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pg26bVPz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD46348C4C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044038; cv=none; b=bUdFqmGWEWEH6n7xCEVFG3SXxSH4pL63nqDAcRRblmGF1jNFhA90f9PBYoz2GYlwkj+ruuHYLGF8uWK0Y9JeHAVcxcUiZmtcy9dPNDjqDAwsvail5IYbhEdnZw/rtZAEClgksumd2owVLmZ6N/RhjU7hftNsousZuBPfMVqaPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044038; c=relaxed/simple;
	bh=DWbR6E/vwDX7rj4/4Wy1ycd7hPVUc6e5Q2qPcgbZOis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLLzlwPM/Ju99UYIXC+C8k1yAxu2O9UIKE3hwtcSd5+QmcAltx0lDL3TN4k6aYc3WNWty4DfdIs+IeWEyyRPYX53Qkq3z8KfduxWak6tfXL5NAbqKE+t2s7jLGiVPJOUMb8u+3skGMwAF/3nr6KEsAz6pr2dl3SSSTIFD3LvseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dl+Mc6XC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pg26bVPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780044035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5a0+aTAcs0DOSWUfCr2mbaAPWI9oAKfxBvUlJLFiE8=;
	b=dl+Mc6XCO5vZdiBxhmBkzqdTMr1hO+5Gz8wOeun9WiYf2OdOfbPvmMEa11Lt6LtU0Y9ovl
	8Br6YHD/e3RVzKlvQiVXsgygkH+7YIzpx7RjMIZp9B2AXEeo8UdNAWJzgwEak5XbUQocOz
	AkEp2lVvwXHZD1gJL0DrG+EZDYOMxE8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-FxCy72g0PKmwUxin2O0WGw-1; Fri, 29 May 2026 04:40:34 -0400
X-MC-Unique: FxCy72g0PKmwUxin2O0WGw-1
X-Mimecast-MFC-AGG-ID: FxCy72g0PKmwUxin2O0WGw_1780044033
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49020d28986so9455215e9.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780044033; x=1780648833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E5a0+aTAcs0DOSWUfCr2mbaAPWI9oAKfxBvUlJLFiE8=;
        b=pg26bVPzSEL6upQ7+2qvthkR2ysmwFPkzCLtITjZcl/rrvQ+UWQ9fywBUO3Y71XybF
         brmNjsckSUrcJIAGd6T2Zt0ouNFNct9cj49XWbFOhzl7CAR6Dirj8rhBF/KnpD1l0QId
         BBoiY3Oi9x5FwZZcGtjDzd7p8xwD3vWQ2x2PUAWbFTgMHBLq0fuEjXDkHszrMztZFp7c
         VGhs5Z+CbOmeqhYwod4y7ub97m+rwc1wH3Mb0XxnIBk8HVm/Aw4NA8UI/umZgPo33vMx
         b6DcCaiHGk06PdibTS01YVVdQrys6YD7duvzxoazmmgBvMlq8x6GwyRX6k8vmFqk4l8f
         mxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044033; x=1780648833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5a0+aTAcs0DOSWUfCr2mbaAPWI9oAKfxBvUlJLFiE8=;
        b=L4sF4aav4TW0wpu4YRfWfpZsq4wS6FDmgzqd749URHbdPZ5WXGtwT0mWO/GkPiDM72
         wcfheb730HkM+CSW3HJALiVaPL4+yYHRKY+xDLzqeYgJj9TmdPNH105rvBz941ma08xM
         GihmBKkOzP9zc3WBe+ANPnM6HT7sOqaIOq95FaUN4S/7ysa3za5K3s5NnC3gXUT7Glbs
         rDEyJ3S59x6tzSRkaiQerR977CPfTg4D5+mbxSrsyPZ1bIo2hXz6sCS1SUtIQrtM4n8t
         RTgJXYkCDafeLMNVW9BWprOS1R6yAR0Reknmq5Fzgb2twyuSQWRgaRPB08zdlP5iZOoN
         OQTg==
X-Forwarded-Encrypted: i=1; AFNElJ8/imQ2MsbgTTGl7iKfE9LIwr2kcm5ssvsFt+O6qWFd7VmMpiOT6ex/ef8uuliyClMnZLpbEeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxToc/W8zf24POLSRhymr+SoQ1tWWJuthEndjsTvs4Hre5NPJ7K
	7FZkl69OUmOR93lSZdv7BBSm02/gFpyniBuZ/SYt4mJBco59C+n8YYIyx5X9cOcAaL3KmHt22tJ
	DQavsyTMf09m8324IsskoMD31RzIE/fb613L52FGmEUW7Lkj96WUp/dMn
X-Gm-Gg: Acq92OFfuImK2+E8NF1jKzcdxpWCpFY6qo3rw9+0l2ff9Qes8+7P6U7BJ9szqm9f/Pe
	VYx27HzAp+OaPFvygfnrcJpn7TmsLSlAdzS02mqR6/1i8dIY7BJchv9pTS9NnQvm8eY5WYen+qL
	6TqWCwgzbL3s94+D43AW42UJEvMEUK6fv3rlJKh0Tg/VOsLx15fU1KGg5MwZjnQtA4sx88vRCG6
	olIJssxCE/Qt0a7uMYaOfZzKluXJ/7QNtw7YYiZeC7mTFdIK+i5L4T8NdJOSOBJV3WhbSzHpms6
	gNij+8beJcEHrVNi69QUwop1/qBl6bCtp7y4nOvICDTfIYzjM4uGLiXIdZ5h4NACiP4r6Bhjpik
	Plzx4W+J7n8Q6KsJTwv6l4w==
X-Received: by 2002:a05:6000:4615:b0:45d:c3ad:b623 with SMTP id ffacd0b85a97d-45ef1459cc5mr1418013f8f.3.1780044032642;
        Fri, 29 May 2026 01:40:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:45d:c3ad:b623 with SMTP id ffacd0b85a97d-45ef1459cc5mr1417971f8f.3.1780044032015;
        Fri, 29 May 2026 01:40:32 -0700 (PDT)
Received: from tp ([2a02:29e1:404:f800:9fbc:ecd8:5c1a:509c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0403sm2024984f8f.6.2026.05.29.01.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:40:31 -0700 (PDT)
Date: Fri, 29 May 2026 10:40:29 +0200
From: Beniamino Galvani <bgalvani@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <ahlQ_YFS0s_8B03q@tp>
References: <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
 <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
 <20260528165320.15b90ded@elisabeth>
 <CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
 <ahhm1-XfnsWyIWDV@tp>
 <20260528192143.31c9e9ea@elisabeth>
 <ed954836-742a-44c3-8c2d-65dd06c3514e@suse.de>
 <e91507d6-cbfc-447c-8236-d9b3d91f18c5@suse.de>
 <20260528212213.4aa613f8@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528212213.4aa613f8@elisabeth>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293049-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,redhat.com,leemhuis.info,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgalvani@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 604DD5FF6BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 09:22:14PM +0200, Stefano Brivio wrote:
> > >>> about the source address selection is impacted. Indeed, the commit
> > >>> had effects on one of the selftests, which had to be modified to
> > >>> change the order of iproute2 invocations.
> > >>>  
> > >>>>>> If the fix must be in NetworkManager, we only need to parse
> > >>>>>> them in non-reverse order like IPv4, I guess.  
> > >>>>>
> > >>>>> But that would then require some form of detection, and, at
> > >>>>> least according to Fernando, isn't the most robust option
> > >>>>> anyway, as ideally NetworkManager shouldn't rely on the order
> > >>>>> at all.  
> > >>>>
> > >>>> True  
> > >>>
> > >>> Correct, if the new behavior is considered better, there should be
> > >>> a way to detect which order must be used. Otherwise userspace
> > >>> tools won't be able to maintain the same behavior with different
> > >>> kernels.  
> > >>
> > >> My remark here is about whether NetworkManager needs to detect this
> > >> at all. If it used timestamps to detect recent / older addresses, as 
> > >> Fernando mentioned, then you wouldn't need any detection at all,
> > >> right? Or is there something else we're missing?

The problem arises from how NetworkManager handles updates (e.g. after
receiving a Router Advertisement). At each update NM determines the
list of addresses to configure and checks if the addresses are already
in the right order in the kernel. If they aren't, NM removes and
re-adds them in reverse to achieve the desired order. Since kernel
7.0+, the order changed and the addresses always appear in the reverse
order.

This creates 2 negative effects. First, it breaks source preference:
if users configured a profile with addr1=A, addr2=B because they
wanted A to be preferred, now B is preferred. This is not
NetworkManager-specific, it affects also simple scripts that add two
addresses (like the selftest that had to be changed in the commit).

But most importantly, at each commit NM detects that the order is
wrong and constantly removes and re-adds the addresses. This
continuous cycle is what causes the bug that Chris reported.

BTW, NM doesn't touch the temporary addresses directly; they are
automatically removed when the corresponding SLAAC address is
removed. Since the problem is not only about temporary addresses we
can't rely on timestamps.

> > > Ohno. Now that Beniamino and Iñigo mentioned it, this will likely break
> > > many other environments. In essence, many tools relies on the previous 
> > > ordering to identify which address is the primary one.
> > > 
> > > E.g cloud tooling communicating with the metadata server via IMDS(v2) to 
> > > configure IPv6 primary and secondary addresses. They are likely relying 
> > > on the ordering for that.
> 
> I haven't seen any tool specifically relying on insertion order for
> this so far and I'm having a hard time believing this kind of tooling
> wouldn't rely explicitly on home / care-of addresses or different
> labels -- see RFC 5014 and RFC 6724 Section 5. (or, perhaps clearer,
> the examples in section 10.1, in particular rule 4. and rule 6.

I'm not familiar with home addresses, reading the RFC it seems that
setting the flag might have effect not only on source address
selection but also on other aspects?

> But I'll look for more convincing examples in a bit (maybe you have some
> at hand?)

I remember we had users reporting issues about the ordering of IPv6
addresses, I'll try to find links to them.

Beniamino


