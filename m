Return-Path: <netdev+bounces-284115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I7OJQc1+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:08:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E274C51EB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F943060D5D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA527453;
	Tue,  5 May 2026 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F6HVx3l5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF12556E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939459; cv=none; b=jkc7VWsVMXGwQBaq5w9IBSumwXE9w8nlhMQLju9AHfrSbuvB6/I00Qq6od723yMd905GOtqOuubN2gb+GBC441TdDr/BnIiwSUd10ewBRRZO7febFHvNJSLWqYOKzzsvk1qeskaSD/C421nU15BHVt9QgMt+GEpuv22dFB2cgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939459; c=relaxed/simple;
	bh=F5PuLbYT6iPpYG022JK08Pgb2hTl3m3cJmKQe79fBxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb6G64z1rmPGe7EloTH+f8JUTxQ5Oj+UpC6EfRKn1j2x4clB43LaizHotbtd+4CHa31RVpUWFrMxtaChP+1YHlFcts6ty2pauZEuHPgfY7EIV+IsP8IRPsI7aOWfOpNnnUubyxxdlZoI3LuXjxfutsEOLIndv9vbkKIllnPVB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F6HVx3l5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a5db525cso30906046d6.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 17:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777939457; x=1778544257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=buqstxuQAy8blkl3pBdcpYdtj9JX2Cyr6VfKmW1S1ho=;
        b=F6HVx3l5E5XJIUDCPezFqt1By+VbwH3d15Mgeko1dm5ctXrPAubq0kkRuhSied5Y1o
         eZ8R3c/1lqclISKUJJBx/mqQ0vwjWF88Hp1hT5jmrLGizRmYBKPCQsQxoLvztxqFroeD
         +u7zD30fltaTpxDOflGX4sb/RvXwF25YOw0Io8ZfUcVkdqzhn0LTsacWexePv/CdMhOv
         Nk+RLqqcqhjbnxj4mkZazHnEQTQCXHyyKpqSWIclHPJ6MMXw54zCj2r7YW898yOd6epz
         7NmY8E5ANYbojKMd8C6CCySUxsvcgZJdcIZVNLGemtAjX2FhkKlOZ4Qo81c48iM+f9dO
         cYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939457; x=1778544257;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buqstxuQAy8blkl3pBdcpYdtj9JX2Cyr6VfKmW1S1ho=;
        b=V5IHqH7WYsX9bL4zqj90Dt7/TYBSa69Z3NZSJWOIdGCO1eG52OZrBpLFeVYA5Ds/Jk
         i0sEKFLVkvSmqbaJihaRGQP94ulzFrczIKNQKbw5eUYqAqZyemrWKiVXg5iE9+ehb3rX
         pxi6iqT+IpPmEr6g5ypiMuPOX/FT5gSwlts0KIfH683mmZN+E8Hulnh8bB858ZZLULHb
         Fz7ojTn9MmRs3/dSaPrrS6xzsDn4aUhxQVS+AW2d16Uo05lQw1O499M2b0vC7X6N9xc7
         TWSlzonZJL5IEDV12yGQfucaZM6ONFXmTH43dvSP90iuREY5YAIX6befO95Aqg93YWEy
         16UA==
X-Gm-Message-State: AOJu0YxZQvK384XmFzf22dBKxNpwfrrPvLmR3lVTv+YlAb2k9kIfxa2B
	kAuf4MQFFkhlvD/OYffMpx0QQ6pQipYVF2daGZzr+4Y3PhNrtyBa/AO7VjHjaxiI+sqayGgiIHD
	k0johrItH6qgYgsr2Xs7SwvhzQXu5VMa63MtRtCyoQAlcfNpAcSOcaYwcNNVG7UdonaA=
X-Gm-Gg: AeBDies7qqTtZx499XO+X5ASCKnSeIRurTRS4IUSwc0cMYuVqshmdeCss9q/6OpX7Ku
	T7HeAW5UmKl8MGeYvmUksd2HRiso2JAZF7CdOUZV0Pt94ZHlt0kTR/s4eTXxz4QXxeorPhW0saV
	MSWJ61+U+i/VTSZaz8jArZFrJWWx5ipo+IwqRqPSb8p/NWYjp6fY1nnfgcx10nG7PMd/KGw72AR
	DGlqQMb3BqdCoUQgTJRrxrMD2T+Q8bQX0ygbU9awl8wN8nunpeh32Ox6YW2QFNa786cufiPpBkp
	eR3Z9qacYNUGrX0whemcfdoH8FHs3Jnaw+WD2k+f8OgKO58QILlIze4IbLxMdqziAhpVaBU+r0j
	9o8yLs+pfbV5zYnUgtLV1wZBMbz/R0piFLDhdPt14zwhx5qo2olQvFv7aaKgYjlGDQjkxzdD1lT
	wK2eBj7VdnmgIsdRqLNywYOn3lHlQhEvQYfRmnzFWZ6BCh1PA+MigQymB321CsmLWtLCPXW9Mm
X-Received: by 2002:a05:6214:5c41:b0:8ae:6835:1191 with SMTP id 6a1803df08f44-8b668c16dcbmr199704496d6.34.1777939457125;
        Mon, 04 May 2026 17:04:17 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:1d7d:7ce5:717a:133e? ([2001:67c:2fbc:1:1d7d:7ce5:717a:133e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d833sm150885946d6.10.2026.05.04.17.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 17:04:16 -0700 (PDT)
Message-ID: <33639813-1de3-4a82-966f-7a0daab25433@openvpn.net>
Date: Tue, 5 May 2026 02:04:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] ovpn: fix race between deleting interface and adding
 new peer
To: Jakub Kicinski <kuba@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com,
 Hyunwoo Kim <imv4bel@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
References: <20260504142033.2327646-1-antonio@openvpn.net>
 <20260504165450.7cc15bcd@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260504165450.7cc15bcd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F2E274C51EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284115-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mandelbit.com,gmail.com,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openvpn.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]



On 05/05/2026 01:54, Jakub Kicinski wrote:
> On Mon,  4 May 2026 16:20:33 +0200 Antonio Quartulli wrote:
>> This patch is sent as RFC to give the AI a chance to review it once
>> again, since it was able to spot a new race condition in its
>> previous version.
> 
> FWIW I think you can just ask for Sashiko to track the openvpn mailing
> list?

Yes, indeed.
I just went through this discussion for the batman-adv kernel module.

@Roman: is it possible for Sashiko to consider certain patches only? On 
the openvpn-devel mailing list there are also patches for the openvpn 
userspace program flying around.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


