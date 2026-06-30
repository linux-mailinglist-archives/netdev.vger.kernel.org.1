Return-Path: <netdev+bounces-303177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6SwGA2W/Q2qygQoAu9opvQ
	(envelope-from <netdev+bounces-303177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:06:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 667006E49E4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZDhZhyhU;
	dkim=pass header.d=redhat.com header.s=google header.b=BTkF2UMj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303177-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303177-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1FFA3028802
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E664410D26;
	Tue, 30 Jun 2026 13:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3713F2118
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:06:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824775; cv=none; b=oQEYRJ2EiPlDPhCw9uOxzJAwE0+npaOkUYdSO+VIWIRwkgfsXHpnA39RP45IfebG+Wr/9DAvVIm143FKA/1IUkuEnGlBEaqt5d9Vdjm6XlUKh5sakfM4HM4ON3h5QYwIaNRRFqVd28Z+CDLmd7MakPZJrvABD/uY0Dq7tcwJmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824775; c=relaxed/simple;
	bh=kwLoIgJ4mjBh6gocsmylxJ2gWtKi7jMK7o3NqE2cR5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr//MO79FnUJeLa6caGsSmsgtE4JiO1T15gL6x0rOVyCE8CVSMIvnRHXlMdn3TRwIGQXxnG0vs9bR9p7ksw0beDIdBOyM3p2EE49FaNM6aQsnFsxcHqTB+z8DzlkHX3JDGKmOfnWDDp4TqVkrP29xoM0sR88I1GgqwG8ZCC7mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDhZhyhU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTkF2UMj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=er/2EyZNp8d3L3Qi54fsC/81NaaUIUspqwclquc99Bk=;
	b=ZDhZhyhUCbdGwGAy9ZBhhnKYqrwI5clJEH2W5BTv8MCrS9/hzGT1FOXgfCNMuiy1dCrkKD
	fxXoy0MTUmlxtQdZVkTg8Ex8BybnhPmXsQrvlTfViXVcDTVFuvNFvKo2HE+IljiYiL3qQq
	IQCPBCITxUE8iqDbQ+gIijnCq/9Fpbo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-K0YvOHXDP1e_6vMEwDgWjw-1; Tue, 30 Jun 2026 09:06:10 -0400
X-MC-Unique: K0YvOHXDP1e_6vMEwDgWjw-1
X-Mimecast-MFC-AGG-ID: K0YvOHXDP1e_6vMEwDgWjw_1782824769
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso30966575e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782824769; x=1783429569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=er/2EyZNp8d3L3Qi54fsC/81NaaUIUspqwclquc99Bk=;
        b=BTkF2UMjgVamPj55DPh4wIf7yd/b2nZrYXQmZQjt/tpizu/SAtwFpEYfxHQSU+d7S/
         j4Mkfr87SpnmPtUlKf4F+wbQx616T/73uZEtzYvV9/U30X1kjLyxG/yGhTq1qYLoYMaf
         I4ddpzXqjteqDrD6TLlSSg3PmIEPRsCGlamU6tYdTtINszO+Nr92BJCEdDDI1aMRFE/c
         LW7GF4l6dDOip0oHmUAcUu3sUkYhigB/qhaAYaCybw6NddzsCrDecQaSrppLq8i6g9EJ
         nZHdWcVmJveq9nwl0c5ugQuEf46F8Mga5JW47QlIa8cuXJVE3PWMIuGSGsxxojoli8yg
         BGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824769; x=1783429569;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=er/2EyZNp8d3L3Qi54fsC/81NaaUIUspqwclquc99Bk=;
        b=Nezksrrh3EadciIB5GykCNMpdFE1PcbhqYjsEl6B7OtEvE97s28LzM/Yk/XyHfp2bd
         maxsWC05QgWWYBmOFCIGPpOr+XkRKeg1sfcwabEAvw4ukCMAOomJLYC2v7+GpbpQqpr3
         vGJ2eBrUgkTddnooghiLNsPgN9yXh/v2fPto3klndHpGnqZIQ/TfzlCmg+nCZA2Fan5f
         VbndF3dk1ng5jnuOFYJUdHHVB0vJ3bIR5JriNcY96nzJLIcBv2nUtmbgrHcXdtYJ76ov
         7kLJ9f4C3KjDiVP/MAhenUoGJSVFZB3MHO61Zjxvgz92p1FuknDguOBunSYy/n7cbY00
         BZCg==
X-Forwarded-Encrypted: i=1; AFNElJ+aIYvoxDp1ihXraGKdJiJKfdcUitK3CdBDpUeUn7dbtkGhwOT/zqVljeQuOe3A/ufFrIeYNhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2I3UYk+Ng01SJWkjzyyZcVPSPtrQwr+nnmbwtzHc+5HkMrAgG
	AzlFKRtkrWfruJXW40YPtq1SSaXkFRPmneW1hIa/UrI4hKqMQoK3gBuTRsJI48osoLhD324S5XX
	26zQejhODc7I8k/xlxj0yfhIAf4y+gluJUddbravY/t1kkI+n881+/SYyLw==
X-Gm-Gg: AfdE7cmiE5tOKBTlV+rmnk9x+DsdFJpQNdBhjRcBampNAVg62n8oZy9gFQ89+sDLy47
	e0PaUax3QPhh3Q2WM0nWEdIjR2Ru9bc9j95L6i7V6Ego4AuY7vutaIBKTvTJtrbVCYoixcqaIm+
	pI7clCwgbiGK0UGhBD179mI1XQgIfAuVe+1I7qaPuZDitM3AtPEvOwCKdGTD1d/OxkopUqsqFTA
	wubA9syUY+Et/bwbNskwv4YUwy/j2cHS/pQaPYvfJN27kJnlVmhzDZLAPG1ehppSUowHZiRa1Yu
	kp3ZAfIbz2gb5sF4tFuH5POkXaqxzPsrr1KDH+LVHEwKLq34DHkrV2EbyiQKJgpVIbpYp64WAGy
	04/y4aKpxlcFM3XP1Ott4/65nO1AorE8wPz9BCE9DbgmWZzj1+Uf6PLgxgs22WFx3cjswBWmRsi
	gvj4jO0+WJng==
X-Received: by 2002:a05:600c:c4a8:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-493b82b556emr51783545e9.28.1782824768505;
        Tue, 30 Jun 2026 06:06:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a8:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-493b82b556emr51782755e9.28.1782824767973;
        Tue, 30 Jun 2026 06:06:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb4f174esm30770175e9.2.2026.06.30.06.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:06:07 -0700 (PDT)
Message-ID: <f81d25c6-4b14-4e48-a230-2d41a036a065@redhat.com>
Date: Tue, 30 Jun 2026 15:06:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ppp: fix use-after-free reads in the stats ioctls.
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qingfang Deng <qingfang.deng@linux.dev>
References: <CF6F0CC7-C448-406B-8E24-2025AD585D18@doyensec.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CF6F0CC7-C448-406B-8E24-2025AD585D18@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303177-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:norbert@doyensec.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:qingfang.deng@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 667006E49E4

Adding Qingfang.

On 6/28/26 2:44 PM, Norbert Szetei wrote:
> ppp_get_stats() (SIOCGPPPSTATS) and the SIOCGPPPCSTATS handler, both
> reached from ppp_net_siocdevprivate(), dereference state that other
> ioctls free under the ppp lock, without taking it:
> 
>   - ppp_get_stats() reads ppp->vj; PPPIOCSMAXCID frees it with
>     slhc_free() under ppp_lock().
>   - SIOCGPPPCSTATS calls ->comp_stat()/->decomp_stat() on
>     ppp->xc_state / ppp->rc_state; PPPIOCSCOMPRESS and ppp_ccp_closed()
>     free those.
> 
> A concurrent stats ioctl can then read freed memory (slab-use-after-
> free), and the freed contents are copied back to userspace. This is 
> reachable by a local user who has CAP_NET_ADMIN privileges and 
> read/write access to /dev/ppp.
> 
> Take the lock the freeing path holds around each access: the receive
> lock in ppp_get_stats() (PPPIOCSMAXCID frees ppp->vj under ppp_lock(),
> which includes it) and ppp_lock() around the SIOCGPPPCSTATS callbacks.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
>  drivers/net/ppp/ppp_generic.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 57c68efa5ff8..847c5e1793c8 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -1505,10 +1505,13 @@ ppp_net_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
> 
>  	case SIOCGPPPCSTATS:
>  		memset(&cstats, 0, sizeof(cstats));
> +		/* protect against PPPIOCSCOMPRESS/ppp_ccp_closed() freeing the state */
> +		ppp_lock(ppp);
>  		if (ppp->xc_state)
>  			ppp->xcomp->comp_stat(ppp->xc_state, &cstats.c);
>  		if (ppp->rc_state)
>  			ppp->rcomp->decomp_stat(ppp->rc_state, &cstats.d);
> +		ppp_unlock(ppp);

It looks like that this fix addresses the reported races, but I don't
like stats blocking the TX and RX path. Perhaps you should consider
switching to proper RCU for the relevant structs, and likely 2 separate
patches, one for xc_state/rc_state and the other for vj.

/P


