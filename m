Return-Path: <netdev+bounces-257563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DWDF7n9hWnUIwQAu9opvQ
	(envelope-from <netdev+bounces-257563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:42:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B237AFF1E0
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3054306814B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0D3A1CE8;
	Fri,  6 Feb 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqTlo5SY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l4OER7bc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA60262FEC
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388619; cv=none; b=C/bhhdUQjrxbEtcpREmCyIl42hSFHBvj61LvLWMo9oCe8kOO0/XeHmPQis9cYwRNem1U9ysK1IKhwEUX4Nwwv5ex2ZGHYTZowUWpPrcYXC+34KJxWPU8hPJ5ojYl42AuOOQebRLEuBC6TN2JswITyMEOVLLrY8T1ivFPuqqFP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388619; c=relaxed/simple;
	bh=SUeQbll6drnZ4qEKGlcCwZ4AtIDsfhcuxTslUXnj4DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h37cphBgrmo1FBaGKTFYvqTO9ZNa13of0HL7N2f9ZAeGHMDgFW/DrxCj0otpsQNqbdssR0x//fdeNyQ1cYIFx70boN+epWce1YV3h3iMAnGb6YdlVRkPMxFaGmqa6OYZ87mz000OqpIlnwydyztH3oGk+d2D0uSmiqoLPDDR6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqTlo5SY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l4OER7bc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770388618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtmBkkAxi119HRhr9RXwRvXaUiZ+0umVxZUeNZ28C5s=;
	b=GqTlo5SYm3S8EJoxzu6VTu788TT0Vq/duSAxg6ip9d6BNI2ui2eRr4r7W95Swyj57Kq48/
	sKYZszp6zsYEIp+C1U4FmIty3Vt4Qt0OSAuTYapaVzRG++aSDPcW9iw2jUo3xCjnYVBmJK
	SywITHhjujjJn/nPYsvKcapk+PcbQD4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-i-m3l20kPLa61KQyZwscqQ-1; Fri, 06 Feb 2026 09:36:57 -0500
X-MC-Unique: i-m3l20kPLa61KQyZwscqQ-1
X-Mimecast-MFC-AGG-ID: i-m3l20kPLa61KQyZwscqQ_1770388616
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso23264445e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 06:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770388616; x=1770993416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtmBkkAxi119HRhr9RXwRvXaUiZ+0umVxZUeNZ28C5s=;
        b=l4OER7bcb0rJOLJrSvFkrJHqk76g1JweKnYNuWP/gXCBUfXTsFMp/UM35WNdFBQDkj
         sOAWKeFdlnHCjANL6u1QaZ17EHLOasm8C2t6U+bXtRrZYifDoUSjNmY1HiLxA6AEp0cA
         GAQEhP9EU8ZuIXHzgFH6r4I7+icI8gtR1RyZFNJ97VaIk/2+rJQ0ogQKxs3bxfC5s+jx
         glu3cr4ZrMwi3cmn3tPk33gaaWyziakwh7/MC/lzi1zIS6CRnA7C1ZdKKQ5f+5D0TvX4
         T3nvG83Lqen5/VQdBRxv1qKa9IG9vfDu5Qnx2x4Azpatq9gjvK6FoPidJoCiP2Cf7QEp
         ZfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388616; x=1770993416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtmBkkAxi119HRhr9RXwRvXaUiZ+0umVxZUeNZ28C5s=;
        b=A8TKsbYoNv0PNfmhN2PHp9XFaQwoNm0Kka4263VSPix4IN7qYVhNM6TwEZtnVuvRVx
         rHMoQAut4vlNqjlJbrBEAC1No2Ot6WOpSAuh4pVNkFzhvZIZKAoU3KbZk2ZTaeQqc/JG
         8IWNmVuRQtEobX2/jUPGjpf/xhWiC2DwtzkNJfALqWLlmnNH68/1PtfJh5SEG8xyIIfL
         10Om/wkmYGzrS+jW7tEdFm5pCNMOTb6cvi9KQ1Wctp+VpEkR5r08ADIstxrF4H4nxl2q
         MI9yLqc+Sd4es1Imh7Z4bhJ9PYAPzkQC6PYeZ3wu1MrntKP8/LCEPnQ6a59QkVXZAFo6
         Y6dw==
X-Forwarded-Encrypted: i=1; AJvYcCWAgJq6hiNZs5pL1Mz7qXSOWS5E84ktq5Lb2yWD+73GofVOCw9zpnnoslaWPV7c6M4Hm7Om43o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvsHRhKOiEQzq1muYFkeef9vELFMUGYZ1+GmxL9yGEgWYK+Sk
	phs5n13Udm96X73fHVVv2oRWByWm+En1cfd4gDLIk82s8ainZ29F+VP9Civ+7pgBjGvmeSsvx+2
	CgxyHo3aLmDENZcSQxXR9ZSIjm/GbSZoLn4mo88SA+K6g+adG8F688PXzSQ==
X-Gm-Gg: AZuq6aLPAllONl+fvFa9pEjg852KId/76rBdHleL/iC/oVipWsF9dy6zW5SwlQ031Vh
	Mu351NU5n9Fi53tcB2L5NdrIufNm2JD+V3zTPhqCTkw8xpEfA925OunEYnAmOehqTixJlarOrQA
	6prAqnR+Z/7K8IYe08TaHzXRlrgrhJWHyh13MmunMmWnQ/zxLOPbh6K9qCLOiwJL7/i1M4u33rq
	wAFN2u/8zJSvWMgoqmoWIlemt3WN+Pn/oqRdAPpKrR+0GYu5pfOip8aNvS9AizVhzZeirfA2xpk
	ZTk2kP6FuwjkMRTt0Lvr0+O0HmA6EhMFw/H0wSHusa9kFtqwtJjTzKXhMhV0GfbrXg/8AkXPQqA
	mcYI9Y1+k63l/
X-Received: by 2002:a05:600c:34d1:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-483201d5ff1mr42756675e9.8.1770388615854;
        Fri, 06 Feb 2026 06:36:55 -0800 (PST)
X-Received: by 2002:a05:600c:34d1:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-483201d5ff1mr42756375e9.8.1770388615467;
        Fri, 06 Feb 2026 06:36:55 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3088485e9.7.2026.02.06.06.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 06:36:54 -0800 (PST)
Message-ID: <7bc99990-432b-418d-bbb7-fb450f9e07ee@redhat.com>
Date: Fri, 6 Feb 2026 15:36:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] xfrm: reduce struct sec_path size
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <a2552992ca2fa29754340eaa05b1a185fca7a381.1770309837.git.pabeni@redhat.com>
 <aYUxubug67eqQ6aH@strlen.de>
 <57948250-bfbe-4d36-909a-987458374423@redhat.com>
 <aYW5CHT70Q7LDoWa@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aYW5CHT70Q7LDoWa@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257563-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B237AFF1E0
X-Rspamd-Action: no action

On 2/6/26 10:48 AM, Steffen Klassert wrote:
> On Fri, Feb 06, 2026 at 10:37:51AM +0100, Paolo Abeni wrote:
>> I'm trying to understand why XFRM_MAX_OFFLOAD_DEPTH is 6 exactly, but
>> it's not obvious to me skimming over the code.
> 
> That is beause we allow 6 transformations per packet as a maximum.
> But for offloading we currently support just one transformation,
> and we probably won't support more in future. This transfomation
> bundle stuff if from the old RFC 2401. This was obsoleted by RFC
> 4301 which does not have the concept of transformation bundles.
> 
> I'm currently looking how to move our inplementation from RFC 2401
> to RFC 4301. This should remove a lot of complexity that came with
> the old RFC 2401.

Thanks for the insights! Looking forward to complexity reduction :)

BTW are you ok if I send a formal, non RFC patch directly targeting
net-next? The goal would be to keep skb_extensions under control for
6.20, countering a very recent size increase for CAN's sake.

Cheers,

Paolo


