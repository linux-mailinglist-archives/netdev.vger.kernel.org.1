Return-Path: <netdev+bounces-256245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKw9EwbRgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:42:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E731ED7E22
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E17893045A32
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013E1320A00;
	Tue,  3 Feb 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b85YiVfQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0v3JoeH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FF3093B6
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115293; cv=none; b=kx+btPK17VGGfw4UWget9OIK5QH6WWAplqsmgzMEB6FnCrZHPwrFlcd6C299oMgeV1oBq55H3C5CqjhTuJ2FBKr1JeQO12aWPfteEIX6d1DdXi0bQvobe/0n/bh8H/VsSAhNjVGkb30RVRJ5Y5DBt+xEInJvUyA1BN0Z6XxDubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115293; c=relaxed/simple;
	bh=4M2ilRClcxFvA1auD7FfXFVnh/EeQt2V5GMg4Eg+3ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsQbsVrfp8jbY9QWXtZXoBO+093SF54UEpL6Ii6PsdgYyKh1mV/iVhKNr5AYZ790hyjf1N324CCDP+BQhIGFvezSVq84l2JbyC1GaAjPq5cf2yRBzSjcZ4OGK5xJzgudYLZy6eoVAkvcsCUrmETmyAFQ5hOHq84XCZHdfxwXs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b85YiVfQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0v3JoeH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770115290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lcMI4p7wXmg00JJS+KNp/590bU1ijyKrvWQkkrU/bk=;
	b=b85YiVfQo2akvPMOwAaLlNZ15dezjUvzdN16td7TP0eXWc86D5N9LBCBV3aDqcIqsmiykj
	GDS+DXVv+Th2q9fy3xfvpv1RLlCdM0gzEfEC5Eyyz/azjrZbLXsbNpR6x2H1LCefLgBNzY
	qAxU8Ooe0sD0g90o2W610KyWrHpEMHs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-UXR5CJzBOmSUad0GYBOw1g-1; Tue, 03 Feb 2026 05:41:29 -0500
X-MC-Unique: UXR5CJzBOmSUad0GYBOw1g-1
X-Mimecast-MFC-AGG-ID: UXR5CJzBOmSUad0GYBOw1g_1770115288
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325aa61c6bso4403174f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770115288; x=1770720088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lcMI4p7wXmg00JJS+KNp/590bU1ijyKrvWQkkrU/bk=;
        b=M0v3JoeH5umL2//KE1lxGfyApMSm95cxTRhOqtBUj5W4eUyCwkuMWONocpT5/o6jnA
         A/cyN8WMJn7wMWVrOufOSGaOgH7UEAq5djulRE8d2DnL+Pkv7kBKZhd9UoM8PV/JZ8jl
         dqkR+Zr/Wdfpofp9sB95bXtUG20FHJhwSddumOzeA1C6nJa6tEqTJHP+9bazXTAoySyQ
         Kg5pRE5Px5PIh1vu+WOkDczQOLCZ+TpKvVyrAvxE4tKix+2vM4dFvcg0oh2DhmPbnASY
         Ua4y/cV96lJGGSl9mLbtY+zcRddS8wNgDkqiiHHJHFlYx6Xh3dRoDEn88MmXKiXQ2nip
         GcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115288; x=1770720088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lcMI4p7wXmg00JJS+KNp/590bU1ijyKrvWQkkrU/bk=;
        b=ligV8NE8WlWilzOINizKnlRUcDsAP+S+TOsu61qFbnCdsP+BmaXsNWF6OPEjOkzpc3
         XurXNfVdBV7P7svKRgmA/cxIac/q7oB+BoElquQniJogufunYRRdo3gbUQLDawt/u/Pl
         NapMp38ipaPCrFmW+8WMqbBZNXW+oojotXiiyvpVNxUkyBmzMJgC7RcKtHG3dwHvV35n
         6+dbS9URokv5TisSVQJ4fbJOre1ocn8E+zi9QOGtXlMc4Hu5tntRyG9QPA7XYvik/e/N
         na2NYZMCfv1Me3NXYttml/ozici3kvFnTgGkGQuiScUtQsGs1ZVa9SmGkeihypvCVdjG
         N9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMbZzYo9Njj4/8S2h7qRtIb6WUp9GMU9rJTisqd+x1PvhOE2IwgK7m2BHYB7IX3V2jHVAV3Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp97lvUTnyxPjzwqXRV8mTW+EntTu9K4gPCTZW1JtRgaxbS5Lo
	JKPc8riJr7pbODa6MiPNn/U7qeI/G1sj0gCcxXu1q8PeY+7Ne8C4YHam3L97jrQy+Y/DasgQtm4
	1OrZBo2BwggMVV5Ok0ewMwomYE4/SERp9hQWaZcPDtasaDOoMay6NbLVdww==
X-Gm-Gg: AZuq6aLwqeO09FhXMJ9QPVrAk0Fc3CI/dPa19v/w9scMzeFrVql9wLfOfuZgLo9GoeV
	aql71mn7aTxl7R0RYSyzdzNdnwSXJn2SWYPGr2pQKgHgdGTIXc9qFZP+EUFkI2m7AK8GslL67iV
	xQ2xydW6JpKG6/D8tfne4Z9Q5PpMdcKvGrUp9G8DccwSoaLq7wHclm4LMNvCyo18guqwMubk9Bf
	vt23QU7xfiGCpKE3DTo+nexD2QMuUwnZjjNZclbqIv8W1PIsAleYI5LHhb0FnvnOtaDi7Z1aPzU
	gNeMWD5d/E5sRj95sBPv7Y+6zwrUTCFuMuiEd1fRYBds7OGO2/nKVVMASPyJCdQ32ydlr3xPABi
	AFDTUZ43p7IQ=
X-Received: by 2002:a05:6000:1a87:b0:435:9882:2342 with SMTP id ffacd0b85a97d-435f3aa91b8mr21688072f8f.33.1770115287731;
        Tue, 03 Feb 2026 02:41:27 -0800 (PST)
X-Received: by 2002:a05:6000:1a87:b0:435:9882:2342 with SMTP id ffacd0b85a97d-435f3aa91b8mr21688039f8f.33.1770115287298;
        Tue, 03 Feb 2026 02:41:27 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm49233686f8f.34.2026.02.03.02.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:41:26 -0800 (PST)
Message-ID: <892557d1-9408-40e3-8e79-587713116b93@redhat.com>
Date: Tue, 3 Feb 2026 11:41:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] icmp: fix ip_rt_bug race in icmp_route_lookup
 reverse path
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org
References: <20260128090523.356953-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260128090523.356953-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256245-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E731ED7E22
X-Rspamd-Action: no action

On 1/28/26 10:05 AM, Jiayuan Chen wrote:
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 19c9c838967f..dc9dcc799824 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -559,6 +559,23 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  		/* steal dst entry from skb_in, don't drop refcnt */
>  		skb_dstref_steal(skb_in);
>  		skb_dstref_restore(skb_in, orefdst);
> +
> +		/*
> +		 * At this point, fl4_dec.daddr should NOT be local (we
> +		 * checked fl4_dec.saddr above). However, a race condition
> +		 * may occur if the address is added to the interface
> +		 * concurrently. In that case, ip_route_input() returns a
> +		 * LOCAL route with dst.output=ip_rt_bug, which must not
> +		 * be used for output.
> +		 */
> +		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
> +			net_warn_ratelimited("%s: detected local route for %pI4 "
> +					     "during ICMP error handling (src %pI4), "
> +					     "possible address race\n",
> +					     __func__, &fl4_dec.daddr, &fl4_dec.saddr);

The fix looks correct to me, but this patch should target the 'net' tree
and the above warning message is a bit off: the text string should not
be broken to fit the 80 chars limit - it need to be greepable - it's
probably better to not include the function name.

/P


