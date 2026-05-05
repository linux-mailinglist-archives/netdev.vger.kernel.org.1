Return-Path: <netdev+bounces-284377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHLlIO7m+Wl1FAMAu9opvQ
	(envelope-from <netdev+bounces-284377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C524CDE08
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4E13086A95
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF812DF6E9;
	Tue,  5 May 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hCeiZ+cn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0A346AE3
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985174; cv=none; b=saxrsSX7+gJJ9xOUZrYTFfqoJcNeDgpQ9qwgWu1k764uzPexrUAeUMCWdl57zY/RYRMmBGxEQH7Ykr5zCeAMkWyazhNwb2uUyEqV3gSPDmF6/HEqk4uVIoYtcEolw9caCVNnbsLZ2eaSRhp3cvlGIEwlDFGjrBP0Blkmltx61SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985174; c=relaxed/simple;
	bh=e2a4YrAbxCmDan0P1zH97mv8a+YQRuHekUCnbVbmAJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7gqVD+ABrJpM1+DeYlnaUrntk8gBLM6cAYLfGVAtxs5M/50ki/cRkFUhslMmCxcA/AGbq+/GgvVtl8/TKrZcTXu0grT60dAnAepygdR++cKg9OAMt4Y0+P00dROa9LehmpnDjd2AUKIivkIThaoyNhPCkIU5HU4UqZHDa89Tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hCeiZ+cn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so4278195e9.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1777985171; x=1778589971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qHCNJFGV1aVlC/Ds0igH5fGzBTgD6Qt0yxMMEE86LuI=;
        b=hCeiZ+cnQaw1Qlg19H7Ds4dYF2GO12dgd7rYowZIfK1fxLiASjR8T0Xf7xpmYIWF5g
         CdK99s59nSaxDknn6cmwvJwO+V88cl4zx2MPaw3MoFA4ozLjmLrdpFrETjZPXtGUhlRk
         +nVnDB+zfA+GCCvA31FVTDL8aS6Ll/+xfsDsVyxzRLvFDqof8IxSVmS6v3BEIXwwQ551
         YtwC/iLsptqdeWDEBnt9U006seYtb0jr9jGdTEMF/gSLWkkYYQy5QLRNL9l0v4I07zE9
         XbmjJ8NHZIewElKWcuQbsQiUXxDx9OWFHwbtWarp9oBvWzmBsDhXB8HBAZv6cR/a/wGF
         k8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985171; x=1778589971;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHCNJFGV1aVlC/Ds0igH5fGzBTgD6Qt0yxMMEE86LuI=;
        b=IKotHCRY0a3ziPgo5f8U58dNtgv66QRJPfAz+bRDhpUIsJGnUj6HOJ9JU7EbXH3MSf
         95ZSLsJ0hIsM4pdc0iM48v5DCTWsGIymlK5Ly094Hgj5RHHyzbaETt35EVKTSda/ghtQ
         vA//WflM77KeZs1YBs3rTkrcL3XFdNacoXnJ7pAMgat7HKdiZ4zObQ+xJ1ksopth2XCz
         XsF5DbhkIfZBYLianYBBoluL+I2ooxn8x8KAUgbcyLImikc1GVnaSMKKhf7mwFWAeXbA
         m/kJHKO+9pAF6bpaar58bT6teOLegsv8c8bCxa00agLzhihbIuNGFjQveD0ThE2t1Cv3
         /b+w==
X-Forwarded-Encrypted: i=1; AFNElJ819vwqTBjMf2BuZgsSPJwPEGjK+jwGYaoBDaAgrE/DZ39q/YdAr/BJst+x39o9iaeEqg8V90A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qT5mT5SO1xmAEye+8o7DHqbxkYl2nPmZ9Jqh5+ziJFNMvdtf
	9wi57yFyfPXFAg9YvhjILrft9Curyf6j3ncutpAdovt4IdU9FLhWP8Bf3dP3k6kBIms=
X-Gm-Gg: AeBDievN+fOQ6VCmbP/vsrP42bXBKy/u6ZKNQQupTICndbgewuRmR8CllBL/CRt2hZF
	bnoQ/iXKz8imfAKlNjbJIWIis/rm/2tYK4EJhEyBn/DOWFaQ6zlL2W3oy7aV/k4RX5rUkhLTtCY
	7QBFF4Xy0dlGdWTQ3R3N1vPP9o2kBbhtjx0mDsJRDiIEaQxF42yLt+aL9YXrevh89eo1hMhleWC
	FHSomQji2SMKfa5LEY1YYddurRn0ORjWgjcryt4qr7QB+x0nzVHmbva30gWrQO3/Lm+keh1elGu
	QRQ5JbwRT24LSBNNG6ODTUinckPQqLx3sD56wkwye4g/IoYxKruuo/hQMp2OfkJJSdeHnEX6BOw
	qkhm/i9jkLd25ed16Q4blf0DBu/Bg8REe6qQHz5ksOEjLjk9H69Ls3nU3WINe++ZosdArdzBeA9
	oWh37G7DtVv/Kt8Umi/Nef36LgP4XaY/kENWplDRZPJ41aUSeivbqcXkUMcaeMef7310aHTZiJq
	R75ymdM/cVeC0yTVjdygQYZNw==
X-Received: by 2002:a05:600c:3109:b0:486:f634:f2e with SMTP id 5b1f17b1804b1-48a9865d347mr97555025e9.4.1777985170852;
        Tue, 05 May 2026 05:46:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm372520405e9.3.2026.05.05.05.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 05:46:10 -0700 (PDT)
Message-ID: <714a61c4-1b86-4c8c-9149-499efe5de68a@6wind.com>
Date: Tue, 5 May 2026 14:46:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 2/3 net-next v3] ipv4: handle devconf post-set actions on
 netlink updates
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 idosch@nvidia.com, dsahern@kernel.org
References: <20260504123143.6284-1-fmancera@suse.de>
 <20260504123143.6284-2-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260504123143.6284-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31C524CDE08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-284377-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:mid,6wind.com:email,6wind.com:dkim,6wind.com:replyto,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Le 04/05/2026 à 14:31, Fernando Fernandez Mancera a écrit :
> When IPv4 device configuration parameters are updated via netlink, the
> kernel currently only updates the value. This bypasses several
> post-modification actions that occur when these same parameters are
> updated via sysctl, such as flushing the routing cache or emitting
> RTM_NEWNETCONF notifications.
> 
> This patch addresses the inconsistency by calling the
> devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
> required, we defer it until the netlink attribute parsing loop
> completes.
> 
> This ensures consistent behavior and side-effects for devconf changes,
> regardless of whether they are initiated via sysctl or netlink.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

