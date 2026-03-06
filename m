Return-Path: <netdev+bounces-264917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMyZDGxDq2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-264917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A4227C37
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C380300FEE7
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3920481AB7;
	Fri,  6 Mar 2026 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GXhVBQWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410FE3F23B3
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831542; cv=none; b=jOShDPr6A5hy4radrpGg85CgM/MyI/6ibW+QnzLHe9rrJqfzz/azU5h19tbR0r4F05Dgg3/z24W/pB2WufrxYLH3VpTXzIKJH+yJo3qRwGgcu6oKBB/ICUQQCcsinNgBtSPrRCH7hyMT41oMcLh8KRKNuhPEsA/vN3hvrPH5CJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831542; c=relaxed/simple;
	bh=Wh94xCRt7HVtbFTu1E7hVihYsRF1gk17Jl85uGP6hOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhuP9cvRSwpPdk9XGbsmYXX0BC6w/u7QtL5KbStwh9M8DlBOjPmMwLbeO19vzfeSc9Z+URtYeXCg/8fomX8+OChHB5wQKvukhswHYLkSTVdAGdLF3qlgALe1iEpGZaIR8ZAKyZi5kOqHOCCv1EwfBVaV4j2oVDv2w0pwWBuMp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GXhVBQWw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439cb5af25bso3130704f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772831540; x=1773436340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVUw8hQrGrYFzA9IDyVyoE7HtboAbMzwNI4WYaE3JE=;
        b=GXhVBQWwpETw/foijQJXVwp40wKamFTtxyyymhrAWW93iC1nCmU5vbK69SifWO12zJ
         Z5N1mHeQigIZej11J6PZL2FOQrsXEvHFMb477XKZvzu412aglLMCKbhAs97yTVOdIvbH
         pjLKtDRXZ2IdTTK7uBp4DzSPY9BjTZCFUSq8yJ9+dyQAJYNpYn0uF0ydECYn6xWcGMLE
         We8BkxLZNuAQ0Y33igjFVWUOSEfW1JUkqME3+yvByiZbeEaoMPp89h5B7pvAdBIJJcgo
         mdKajddz1yIUqIrWKHNu1VpQhQtpCLEmBs4o9u6QY3mhp1s2MN+CZDxzlFLP76yWOXJf
         h8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831540; x=1773436340;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFVUw8hQrGrYFzA9IDyVyoE7HtboAbMzwNI4WYaE3JE=;
        b=WFI2stWkvQORz1b5WohZJUqYqzOnSmSQkLkMNQ92vI17Tu2CDwikFJs8Zab/dbZjay
         w2sKqIuJhG4zDDSupIWb78JZPHw567smg4f8DRSI4dg4Zs/5Z7srdDBWGd3dvJG5bESP
         ueMnp3PpIOdb2jjfq74SMqjXOlbBCi2rPIg8Iwf30ADSzef00/UNvptzkSyPwS3J40rF
         Bm33Wp+6mut2ciU9AYtp8LReH4Udhrgy166OM9aJSRO8z75/3xxh7Setp883ldXbDpq4
         +6oC+8o2N3EeSd5lGD0jMdwYBDf+AgznNgooD3eMBVpcNDqwKRErjtA8NYe7sGhElyQ4
         b84A==
X-Gm-Message-State: AOJu0YwzC3x/TpeSZ4WFedjoAlZJMcScbkUuzjiI6plXX4YfrTmbEt12
	lUSE+E3v/T9WUoTJG3xY9WERGqMQ+o8pLJznYCt8y3kA20gBmoxenv6aNWOAlZTM8vVMZDwB02D
	MKE7P8dorJN9soy9J0mBWxqT5Pn2D+x5Nbg4O1EIdSeKx/pZHqso=
X-Gm-Gg: ATEYQzwolwhT9cjXaNfghukjKCadGypixe5bmCMxgNpNM6DNPg49LqlOrdOmJ3OBqv4
	K896rrcsJ+QY/+n40IY4vvGPp2Zp35WgqAEshNd+Px2eEbMijLUnsOJh/gtzn6iV+2y73RXR2cU
	Q8TQfwvGBZjafaORQoX6C96065qD4omOp1OGS2lQ+2pkXkyZ3NpqRlxMhwqMYMtMal6wnhsoWVI
	DhFUsUA07TF2gJIv6PYRbGv3/jNa8jZd9DMzxnH0VLjZafgelO0sdtxKKfqQk8VXR+3ry7mvut5
	QoW8L9O5RreMoRgID9+aZxVcORgfbiB9nbaFBekw8n26rU4sObk8yHbxyyjT+SxDb0gJ5d1lteE
	u15NBdPkNqZF1zntXr0iREobCt3999JaG6b+NbEHpI1jTRxoXU1XJDKAGkuLds6ivhd8tno3QsL
	NPQuOmhcX9GRvNP7jvySBjAURNIdDJnKNNqo5W/xtE1Gxm+IpHF5HnoeeSBzsuFM8bh/5VgU2R
X-Received: by 2002:a05:6000:400d:b0:439:bc89:6b18 with SMTP id ffacd0b85a97d-439da354cf0mr6733967f8f.9.1772831539605;
        Fri, 06 Mar 2026 13:12:19 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:99eb:76f9:2124:56da? ([2001:67c:2fbc:1:99eb:76f9:2124:56da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9fbsm6436076f8f.23.2026.03.06.13.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 13:12:19 -0800 (PST)
Message-ID: <8a22df80-824c-4711-9354-b0392220bbeb@openvpn.net>
Date: Fri, 6 Mar 2026 22:12:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] selftests: ovpn: add notification parsing
 and matching
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, horms@kernel.org
References: <20260304230643.1014-1-antonio@openvpn.net>
 <20260304230643.1014-6-antonio@openvpn.net>
 <20260306130130.559d844f@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260306130130.559d844f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 854A4227C37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-264917-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Action: no action

On 06/03/2026 22:01, Jakub Kicinski wrote:
> On Thu,  5 Mar 2026 00:06:23 +0100 Antonio Quartulli wrote:
>> +def check_requirements(requirements_path):
>> +    """Return dependency issues from requirements_path, or an empty list."""
>> +    issues = []
>> +    with open(requirements_path, encoding="utf-8") as f:
> 
> Semi-jokingly let me also mention that you do all this requirements
> checking here, all the dependencies seem to have been installed on
> netdev CI already.

as expected :-)

> One thing for which you don't check is ngrep,
> and that was not installed.

yeah, because the script is only checking the python deps.

> 
> IMO the requirements checking is a waste of effort, things always
> slip thru.

I am fine with dropping the dep check if you also don't find it of much 
value.
We'd have to keep it updated and it won't help much once packages have 
been installed the first time.

> But unless you have a strong reason to use ngrep maybe
> switch to a more standard tool?

Any recommendation?

ngrep is used to make sure that received packets start with a specific 
pattern (OpenVPN header with certain values in it).

I presume we can just replace ngrep with tcpdump, assuming it's "more 
standard".


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


