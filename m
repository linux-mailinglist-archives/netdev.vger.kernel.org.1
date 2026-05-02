Return-Path: <netdev+bounces-283381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO5tHmmU9Wm8MgIAu9opvQ
	(envelope-from <netdev+bounces-283381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:06:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E90844B11B7
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A7B03013A6B
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5E2ED870;
	Sat,  2 May 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="F6xKpikF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AA2DF13E
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701990; cv=none; b=mJ+Fc9JQOy2uON00F2OvfRgry0WrSDPoQ0nEGzabzcG/lVfEXvyOmggppcBaMIgi6waZ4PZyOQdKscxEKgswrpD37MEchAEzpp5mQvkPk8kbEoa4AHDYmZSKDhv7hQvIkr5jltstiMaEncc/IcYIG1+BExtWcAJ4r0Dk8qncJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701990; c=relaxed/simple;
	bh=KTOCjruETFFyA9eMpMwBg7rk2PGjXG1IZi/DfUc1peI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhokYuA6ttPvLOrsaz1krNT0gpCA+D1JxbxN4kqlnn+q9rv/b9XphLPI90HI5/5VM22tPDjPqNiTV2aB2Dpl4WTbeBSrsoNIy1uXQdAy2NTwHUjwnj78yNcXVYINcL0QWaKDgK6iDGLsd1qML1qyBqzvnPvYKRjNBzShffbhJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=F6xKpikF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so39883495e9.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701988; x=1778306788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2x13DrMgH4CKBCggYi3SP9iAtnspCOSFTNkvACPndhs=;
        b=F6xKpikFAk+3g6LdyAo7yumsTr/6onrE+Yc7H74bo4+BPJdNQfi2A0yrzAWop1MoGb
         8XKG95AL/F53xU6N66qLTL56LE9RLSZOPG9fTVDgpUL5DIfq3tzrXNOf4++K2384dluX
         c/7VCmSirqvtnCiK7oMLUf3pHgW/hz+ugn/oWWPb2zKSZ4SD6jGtgdIzBafWMeU9T5+L
         AIjJr1c2f9WnrKkm+7rTcl9DBua9HmWN+dB/r5RGC7tJSx+0t6ZF79fniJCxM7/yCqiE
         Qu6whg9HXhVCh5f1yYczbnFL4tFZBjhC0KJV+KBPNa59KXXaHZGPw8XvnoZl0/lyiLOh
         Uu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701988; x=1778306788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2x13DrMgH4CKBCggYi3SP9iAtnspCOSFTNkvACPndhs=;
        b=HqB1kSvCcBU3W7wRG8mJuNp1x7N8mJk53wtdJCGqrLyogNrk6O37pDTYOnASaIX67J
         VMuYNc0iKMRIhe9OGpZZk1Q2J7+h9MT0I4ggRbOFJINNHnneNrOWJi5rHn3JoubaMgQl
         f8hNpbnhh/5rgB45yRv2rVfff2CESdgJLh4xCrYENlpwqfFQ/tSEi97VJVNFCsDAbjz0
         01THRp1h3cDoQi2kPJanmVc8kNBTLBuuWNZKr6T6CEwQPcrNHyHdKSlctUZTHrILh4p7
         4SQsgwdAt+v4u8KB/ltihaZza88bheQ9TmdpX+GmCXWV74ZaZYQyjo6ipoemVj14i18O
         kxWw==
X-Forwarded-Encrypted: i=1; AFNElJ+jT63B9dVjaS4w3kbzQBh2iT9iNJ4eOypNGfcwOxWUlhxoWPipoSLj8Hkms0abtaS+8Gii9Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5snU7g/AyUq8MpLXvk/5XAyKpX5ckEpdf2Iyku2tKGHhVCkia
	GOG7mqpUHNERhBuALguc522lMDg3ZUpPki5RLQZPfRYULdGnNhkQKpytkix5Q9cAGzs=
X-Gm-Gg: AeBDievtE/Cu1qr14qvqSpA1KOqjrgNLFGOgejhHsFjRGb4BQVpJyKsEIzvqfFMpsmh
	SO03HPhXHWWg/2CxSZ4KVdUVWZset3DU6vguqow3/g+4Ky2kzvDaBAcnidYg4vw79LUPx/dhh+e
	dVV8IQQydj2QNhuyyBeAUmplmic2myoXxwJCjGE9k5VkQUDjocA7HhZu09PzTG4ZReDUrBPCtnD
	CBtLLYFYXIcSC+wAZ6DqdddOtAbMbYusqxXiAJa3CyzXmhBeAp1fGclJw1gUB9v1ZqIFvtuD6Sl
	W6AfQbGxPqd3c8CkQda/1ixy7OvoE3JKXzGsesBklqnis4Pb5XQfD03F87Oa3nckV0t/AA1bYEh
	/9bmeJF1KKrCri1UqTF5XT2sESurRRj89qv3NQle2Slu++Y2YcS5xJm9nWQKKcqoZUAiMdm88zn
	dA+EdXnHTe0mAWuIYyY0T3pc1cdFQfTYzxZAZJPsoxKdL0+XYJXIsDmgQQ7Cr11Xf9fL0ixK8BH
	t4=
X-Received: by 2002:a05:600c:608a:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-48a9865d2ddmr24979785e9.17.1777701987611;
        Fri, 01 May 2026 23:06:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm171888165e9.0.2026.05.01.23.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:06:27 -0700 (PDT)
Message-ID: <fc6c4143-d279-4e79-ad8b-c5c06949dcd6@blackwall.org>
Date: Sat, 2 May 2026 09:06:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] selftests: net: bridge: add MRC and QQIC
 field encoding tests
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-6-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-6-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E90844B11B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283381-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,bridge_vlan_mcast.sh:url]

On 01/05/2026 20:31, Ujjal Roy wrote:
> Enhance vlmc_query_intvl_test and vlmc_query_response_intvl_test in
> bridge_vlan_mcast.sh to validate IGMPv3/MLDv2 protocol compliance for
> MRC and QQIC field encoding across both linear and exponential ranges.
> 
> TEST: Vlan multicast snooping enable                                [ OK ]
> TEST: Vlan mcast_query_interval global option default value         [ OK ]
> TEST: Number of tagged IGMPv2 general query                         [ OK ]
> TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
> TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
> TEST: IGMPv3 QQIC non linear value 160(s)                           [ OK ]
> TEST: MLDv2 QQIC non linear value 160(s)                            [ OK ]
> TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
> TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
> TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
> TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [ OK ]
> TEST: MLDv2 MRC non linear value of 48000(ms)                       [ OK ]
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   .../net/forwarding/bridge_vlan_mcast.sh       | 140 +++++++++++++++++-
>   1 file changed, 132 insertions(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


