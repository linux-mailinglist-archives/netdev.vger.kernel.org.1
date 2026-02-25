Return-Path: <netdev+bounces-260839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGSDGMvBnmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F911950C1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28B430F7274
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0338E5FA;
	Wed, 25 Feb 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBGkd68i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE638E5DB
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011526; cv=none; b=ols3l8lvfvrmMEscOA0I59FCXvh384sxYp6zHKyAkDil4BelTmw+iy1SaC5+U+w4DYAw3+xbTrTxSX8QQ8TLdsZuFp8D/mSBsfNBNNTkzMdfudMtBMerMmi0brG/OXw3Esr6Tb75ri3Y+NVBaSdIW21W8dSV9Cj31TMrk8B8U9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011526; c=relaxed/simple;
	bh=SNY7wKlCxt32Um0FCt8oDeUEABOZBms0H/s6DRK+Exg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKBoE4bb65KJvln1fbjYeFNPHqjDz38NdlnuM72XNlbd7T3vEggBWBPl9F91JXIyextdYlQFwNh+XdOAPrJwixgAN7AH2Vni+mFKqD5V+AKj2QAMknEj6YbxctOCv/88A793NyJ421b+VQVj9KBnjS9CNmTXdtqR/5bJuJ1qAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBGkd68i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48378136adcso38565095e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011523; x=1772616323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFxGd8tt1psILcxBsQnx7nL9xt0mE3Hus9OpWjd1eMY=;
        b=UBGkd68iZ7u3IO5x+WMdFi6xqr7x2Bl0SyLkZT/js7Tg2uWkIrDAusjqblk/wgL1CW
         u7P0SU7jtROsHATMeV3m9QYY3ZW8qrw8UXa+GbRUs/YIlFxA08dqdq/7Jkp7YV3dBp5D
         bjg9OXAStKavQSBbX75ECY/TifBLKdsQMjUcbX+GnVI24TthmQLlsc+xmsyJuBVxIiq1
         jOhuDiY7zh0RqdNnaAKDHpnCuDUJc9WMfK1pTgK/5nSNW+ksHJgKLTcsxpLT/Llu0nyi
         i5DBQf5S2IpBYDJIU4Av9SEeQtp7Yvepc0mOBdHwfUWXvUb3BW5UFcRSpQGB53FfAdl/
         Gnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011523; x=1772616323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFxGd8tt1psILcxBsQnx7nL9xt0mE3Hus9OpWjd1eMY=;
        b=hGd3x7KztlR9vB8ts76MJRKGD4XAXB3qHjoKm/Q9lYapC9/QnwB6Ca956ZoPFyyf2O
         2nHAymRRE5se2SN5Z7Wy2flC6tikpU4ptQzfulO8XI+0zTP5GX9qkKGFt43stghlDfIL
         8IXdCozKyi/oSvSpGGMAEU5wqAA6PkeVuejdzv501gybfN4YE06dD/MCxkaWc730OY/J
         E8L3GFD+4z1JsfX5Al3RPgx0xYkDk2nY5Q/LDuDSGUDXSQzAPPJG4C2FFN7ikbAU6o2e
         CIF/+pufCH+lmTU3NBUQ0/zjf965zEUjj9FCsDxhiTso6JVCX/73HD3M42BqIElXjdqX
         djVA==
X-Forwarded-Encrypted: i=1; AJvYcCUwJBXwgcQBv9vzsAUXDe8lHUmIl8rGf4Ofth2toHkhCRkPuOUN1Ogcp/CzvBickzFDC9Ph9tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8U5pesUusD/+86vaCH6uWB27tvPuRZRdcKlyi+r8+8zNz40mW
	v++2yL4dTmZez9kEt38V1lK33zq6s+9Uzu/nguZL36uyY/UawhrtPHfWCuz0GQ==
X-Gm-Gg: ATEYQzzi/UUi70qxv/KTR0q6zLbN7WkgTGo/JKeDzhupFzVcJbElGTWU/kvSmz0DeaH
	zgRyz4i5PnM6nMFV2V0b2QqXqqWxUpfVr09fd4g7kRvWr0vqxXMc0TY4z5Lc0atYrDgN1lLfv1U
	pQ1y9sWj/o5eT0g2Ss1jQm+UeqESZC3F+q4ceRAzXHF6dNEIddKCywy2PGE2CIEk7URu0ZQg4ET
	Dee5xIQtZcFMxnY9cn1tbUzlZWeqTEzMRZ08EnYZBiV8VG6Ve60Uu6DiGTTcBrzGazVuQWIBXpr
	DPdT9ykzYIsLic2/Qabqlxf/oO4WuuqTLF3nNGBZU6dd78D4m1opXJK464YGIooi/W9qfnAJGIG
	69n4SZd90J5StA4puds1YLIfBaWEYHGdTkuQt0Wnw/FdevGn/jo0EUdyWrsJ9vZxgjLDD8GiYO+
	ESKMrE/koo8lFq3hV5Hol+d4G+2l2P/wOD4hFc1F3nocH7Z7eTcue7V0xktxrBbM8YM0LcZertc
	RlUG8De9wmShYyg619CwYcvcJThgo4ByfzoarLZT7+NVaqOGeU74GfDznOLsrgDMgC6kHLckb4x
	Xw==
X-Received: by 2002:a05:600c:4f90:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-483bef2a427mr34570355e9.14.1772011523170;
        Wed, 25 Feb 2026 01:25:23 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd726a35sm50268215e9.9.2026.02.25.01.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 01:25:22 -0800 (PST)
Message-ID: <bad6cd67-88c4-45ee-bb51-e24331263dc2@gmail.com>
Date: Wed, 25 Feb 2026 09:25:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next] netmem: remove the pp fields from net_iov
To: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, hawk@kernel.org,
 andrew+netdev@lunn.ch, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ziy@nvidia.com,
 willy@infradead.org, toke@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 axboe@kernel.dk, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, almasrymina@google.com, sdf@fomichev.me, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com, shivajikant@google.com,
 io-uring@vger.kernel.org
References: <20260224061424.11219-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260224061424.11219-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,skhynix.com,oracle.com,kernel.org,lunn.ch,suse.cz,nvidia.com,infradead.org,redhat.com,davemloft.net,google.com,kernel.dk,fomichev.me,davidwei.uk,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F911950C1
X-Rspamd-Action: no action

On 2/24/26 06:14, Byungchul Park wrote:
> Now that the pp fields in net_iov have no users, remove them from
> net_iov and clean up.

Looks good, it's great to get rid of all this aliasing.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


