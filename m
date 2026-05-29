Return-Path: <netdev+bounces-293099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO1gG2Z7GWpHxAgAu9opvQ
	(envelope-from <netdev+bounces-293099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3E601C50
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2803026325
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C173D0BE4;
	Fri, 29 May 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6WJV7lY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b363AVYR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22413C2B80
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054871; cv=none; b=OpMdBCuJ1HUo6+meU1froJAjSinIiOqREvjmKpLgu7kMt99TuPlHOdh/EDQ0R9d5ruIigA8DW50JTbuKxXTfIVOUus0hectGEylAK3Ppz3ZknV++wbDSgjRNF2l64CJ7+MnxnJxz3QQ3L5zvl5LIyyUBn9Q1fPbHTZp92uCAsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054871; c=relaxed/simple;
	bh=0S/byLTk02zpKF3rh6kvrbDDiJhPNnCcxX8SoapbmBg=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=T5Yu+vUCwlMZYx0mbGtVJGqucjFdUiDHo3r9n393bTvkfh7zdvgf9O59KdN8/MUIqGEZx1YqmQjFMk6m2d8gt9v7VitEG+59quQ7h20XppnApIZcqJABPCLW+tyxuSEA/y6ySsUpQoN4Euxib+DugsW22HMpkSEL71nZdZ9igzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6WJV7lY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b363AVYR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780054867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur887I+sgsq981FXLj8FJ8qQbEDUWR4G4r5NLvUeADU=;
	b=C6WJV7lYNqrqJBYNgVErWEfWrfKzevIo2DVoCbcEF9uOdypx73/TtvWPzUAg1dwuXzCirt
	2BVI60P7nfxI56nPFc/Ph3ms/GLSg8BE9wWoFEVwp3dRQfcmc+KHriAhy1gRxXMuGjOreY
	bK68d3GXOt/TtzUxR6Sqc11lnZzhQuA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-QJQlw6BJOOuZlTEd8KmMgQ-1; Fri, 29 May 2026 07:41:06 -0400
X-MC-Unique: QJQlw6BJOOuZlTEd8KmMgQ-1
X-Mimecast-MFC-AGG-ID: QJQlw6BJOOuZlTEd8KmMgQ_1780054865
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso86221185e9.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780054865; x=1780659665; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur887I+sgsq981FXLj8FJ8qQbEDUWR4G4r5NLvUeADU=;
        b=b363AVYRDuWhhSjvHTsByIGyLpsaeBvBXBaYwRPneGS1j8lFg2da9NPuCQOGYbG7qA
         nIdTwiQaghBym9GGqlqiMCFleSBMScqHUn8tA1XIH46FacUk49D6kuoxViY1TwJK4Va/
         d+Iq7D/sy1oMR+mndKnS8/sHwsykLPJFZeVLPhDvFXChQbXfygCCQsEhD/Pl+3mUWdmc
         27h994/ZROpEaECdaMko0p7y+c+ihJ8S7ULYdtEAo8Johb6d6+mzCwJX+xvM4tRgycM+
         axESJVtsU4jQMX1IQMKVUdVYViiAefn2aOMz0NUjkozubwj0Wtn422LkvosSMkCkTPZr
         EaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054865; x=1780659665;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur887I+sgsq981FXLj8FJ8qQbEDUWR4G4r5NLvUeADU=;
        b=DASQLVXN+N1+xrnIhH894zNSq/Up5IZRekVahQtSFlPEkdbJ9wF3yQFJ8OTBf4/0tA
         fMTcQB2XynQjEiW9/5JhbfckiE6g9aDWCQtzQ7gGnIWD9s0Hst59Se88N/7ADb2aqMqt
         xmZhEqLAmBOiBmtofBU1TjEw8O/ZeDmXnu8NWdtFvPfMywi61mosyZEgOPuYFmZvuVAg
         npBjw2n1AhLz0R+Vr+UT7lNb2lOZ+nTB4twvyBuZDsX718Bp5IUwQpJuiDDRZ0fDTQbV
         LE/n2HfIKN25QK3CVFY0LqRcLifYqRNzl8C/65iZW7aC2dno4hmeBpofiyBvrYONQdzI
         OEAg==
X-Gm-Message-State: AOJu0YxPZ3PbH6GtqyelaSDtSJ+eufPTralrmOIyb5fCnUS2fSlcfAm5
	GoYl0xuw1XDjN5vFOakr9cKbr4/bdHj6XfYSjjmEekD36y/FJajiZP5EkNMot54IY4ufC6C5xi4
	mm6ES5RuXk1ea0T2FCPKHoq1s/HTjOQCtUPw8bsdpqbaLqlta9ScA8bY1zw==
X-Gm-Gg: Acq92OGRaVT2XPDyiSHX5NWj2uNWNSmwIyY0CXk2bVLcQLd/UAzTQL1G4WYU6A7LTdB
	jm96XvxxVHR2hzFLIDWo75Q1j0v1H6fAVE4hoivZIhGvLccDjD3NXDlOe0YnnzjzBEvJVMY+6TO
	RH38zktuksRWHh0irxbIDFFEMNwQ1Nnkqg3BXXaYNXJTZlAd8B0ClpQGtOr9zdVoNS1swMesIW4
	ehmiOtYP8rtHGpteIyjPct1wMb2diW6acw1ikylvWNlSu6p2fg0QTir2nHwuKUEewdehrHb5GLN
	FzIRZ9ukaKoCJIWPxNgxoI+kH8qU8klWDUmQUlS4UDtNGyHI5l3cBff5YV9CIIEWznnCZSiV657
	wVSdNtILMRORoFbqJAwCBMvO+to2Plu7zs+jPoecjRgw=
X-Received: by 2002:a05:600c:468a:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4909c8558c2mr43911935e9.2.1780054864953;
        Fri, 29 May 2026 04:41:04 -0700 (PDT)
X-Received: by 2002:a05:600c:468a:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4909c8558c2mr43911385e9.2.1780054864473;
        Fri, 29 May 2026 04:41:04 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c12f4d0sm13336155e9.34.2026.05.29.04.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:41:03 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org, Chris Adams
 <linux@cmadams.net>, David Gibson <david@gibson.dropbear.id.au>, Beniamino
 Galvani <bgalvani@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>,
 ihuguet@redhat.com, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
Message-ID: <20260529134045.56330243@elisabeth>
In-Reply-To: <20260529112357.5079-1-fmancera@suse.de>
References: <20260529112357.5079-1-fmancera@suse.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 29 May 2026 13:41:02 +0200 (CEST)
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
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,leemhuis.info,lunn.ch,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293099-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C3B3E601C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:23:57 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> Chris Adams reported that preserving insertion order for same-scope
> addresses is causing SSH connections to be dropped after stopping a VM
> while running NetworkManager.
> 
> NetworkManager caches the IPv6 address configuration, when a RA arrives,
> it determines the list of addresses to configure and checks if the
> addresses are already in the right order in the kernel. If they aren't,
> NetworkManager removes and re-adds them to achieve the desired order.
> 
> As the order changes, NetworkManager is confused and reconfigures the
> addresses on every update. In addition, this would also affect to cloud
> tooling that relies on IPv6 addresses order to identify primary and
> secondaries addresses.

By the way, I'm still looking into this part, trying to find
"problematic" examples.

And I couldn't find any, yet, because it looks like there's always a
_single_ IPv6 address being used as a secondary for a primary IPv4
address.

> 
> This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.
> 
> Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
> Reported-by: Chris Adams <linux@cmadams.net>
> Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: updated commit description to make it more accurate
> ---
>  net/ipv6/addrconf.c                  | 2 +-
>  tools/testing/selftests/net/ioam6.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..bb84a78b80f6 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
>  	list_for_each(p, &idev->addr_list) {
>  		struct inet6_ifaddr *ifa
>  			= list_entry(p, struct inet6_ifaddr, if_list);
> -		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
> +		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
>  			break;
>  	}
>  
> diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
> index b2b99889942f..845c26dd01a9 100755
> --- a/tools/testing/selftests/net/ioam6.sh
> +++ b/tools/testing/selftests/net/ioam6.sh
> @@ -273,8 +273,8 @@ setup()
>    ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
>    ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
>  
> -  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
>    ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
> +  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
>    ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
>    ip -netns $ioam_node_alpha link set lo up &>/dev/null
>    ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \

-- 
Stefano


