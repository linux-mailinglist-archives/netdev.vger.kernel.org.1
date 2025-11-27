Return-Path: <netdev+bounces-242150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5EC8CC09
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C834B8FE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D13201113;
	Thu, 27 Nov 2025 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkRF1lCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3389225416
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214322; cv=none; b=qo1yJmxaINouqUbg+ucUmmUiaYemjWx0py9oorL/pfOE1L0yV9DqsiLOQiI0GSOfdhQuxN/AFfilyZIMEHUQeKuMwq1Oj+3f3DOjTb4nGKJ3XPRODQ3y/5D7WeEdsozLqLULF2REHk4sfPOpEpvSpVPmvscCDdf1oiLv0aYNjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214322; c=relaxed/simple;
	bh=nT/7FpNKVxlkNX/0BE0ZS0c76peMlAFGMA7mJQm9fYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX7xjhnL9Ht9qgYuSw8zRLqQSCO8q9Myi8M7Hl9Pq4esZBiQrpe9wqv2zq3u+ijVxcK2KeBmcn7JAoX8rQzu5phULgvb6qEHBjUiZT/UWBVgko87elbuK1gulom6qFd6b58R0Ykp1BSWMj7Kh/a6oYCvExBrmvVBk2DoSNAECxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkRF1lCd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b75e366866so167052b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764214320; x=1764819120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUFNUJWqhYYw/xBj2z5KmwgDhZilUoWRmrncYuADH7U=;
        b=GkRF1lCd85guXJQrAIAVYjg1KtChOIJk+gYuuBEeVa6jyPErt0zTO3/ZKdb9J4zuxW
         QToJS8Lc1jwBZK6U3sEpUszoo/RcSVA8FiQ3IqaCHbzaJ7uYzQdmaPRPQ1GOERp45wgd
         od4E7KwsEghz5oAKM5F8BBi7f7AYDgZ0GSMabEWig+934qc7DRl32AC+ZSardcNi/2Qq
         XFel6OWJ7pivf5BMJoFir1BgK+IEfDmbtDaOSSaQkL1TJ0gVvO0CzXK3Y6IsKYUnxE3k
         /o0ZbhfrC4bVRG4NE7Ypajmcswajg+2rzeKXo01LQVi3E4SwWpMjxqUm6EpyUS/bRwhK
         A6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764214320; x=1764819120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUFNUJWqhYYw/xBj2z5KmwgDhZilUoWRmrncYuADH7U=;
        b=Cnf9qAeL6WrdHanPF8E5AREVt3QrvSUfS9ZIhre4ope1umEWc9SYUBfG/cvv0g5bHo
         XkRskMCu/8gHJlhfu9FEPgriykMNUZVISxrd/9zy5j+pZs8vSmUVfw1bKoZl+mNXPg1o
         K2wIzmOTnkSzBdWM49+kx6gda9GMK7+uekAN9rDNCOfx/uLfF3+lpiJv+11kB0isXGiU
         NUj79nmnazPGtKEGnuwpPta+GwbwTrgr8JhQJp3RimxHzWKcOFdUkxzOGE88FObNAjJh
         TzO3tDTm2Nr+3/eaNvvry35VYP9H6lyazZCSxcLjKFP0B6VT2FREXgLLFv+Hyn0lDFqw
         gREw==
X-Gm-Message-State: AOJu0Yy9aun+Ry1secfCo/G7J4nnTqBDophBEWw6zdzYDmiNaYF+SR5U
	Al+X7wjhM+H/KKnF+UmbSMbkfATkPt4xvhTHqlpv2aVDBs8tmQvEpPMy
X-Gm-Gg: ASbGncs+v6jyV+vram7IaFF3JFzIo0JEIsBmoXJuzmi37SQ7iATHac1fPUXAXz+b25+
	TgYYxLl+mqZo5Cx5XhbrSBoEXyeDH5LscgXaaw3a6hNNhJC3VG6hVbholXJRWF/qHAQk/4PuXTU
	nqcbNAhn8ZHo8xS4hyNR6I6cPu034C7chLvZcJuVhNDrtBbZiaBN/RZXYjFSIwuRSjLwrGt9EJd
	WG12/s8P6tTHHc6D0u2U3RpM4yHiGdcaw5ADpB6kRzGDKA74Y58OK5Mf8LIdothdh48dVFoSYJQ
	CeB9Ss65HRTzzWxJTq8HtgAVVGHXfQXtZkcmMnXqlWSE05d8YyD7Vd+/9zGbyt+u8Yjttpt/RZ9
	TNAMR2rhmAQMZZjDqL/ThBPDQy3fQdueyiEuTXBlliX03/8aPDOmyrTjgHM0gXdjEKd4RbFcihm
	1nps6Qo1q7klqU6IY=
X-Google-Smtp-Source: AGHT+IHPlo75bfwll7Gp40Mn24GSQvzhAn4nMBC9jRuod5hISEC66YhruUuUAH/dbGo5n4FDiU24Zw==
X-Received: by 2002:a05:6a20:3ca6:b0:35d:ce99:cc23 with SMTP id adf61e73a8af0-3637e0b49cemr10657154637.49.1764214319671;
        Wed, 26 Nov 2025 19:31:59 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c40a2sm80452b3a.32.2025.11.26.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 19:31:59 -0800 (PST)
Date: Thu, 27 Nov 2025 03:31:50 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next] netlink: specs: add big-endian byte-order for
 u32 IPv4 addresses
Message-ID: <aSfGJpUFz9A_xFtz@fedora>
References: <20251125112048.37631-1-liuhangbin@gmail.com>
 <8564b02f-18f9-4132-ab69-5ee1babeb18c@fiberby.net>
 <aSaf1D-N5ONmnys8@fedora>
 <43630b97-4dd4-423a-97e3-ca6aa3b56ad4@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43630b97-4dd4-423a-97e3-ca6aa3b56ad4@fiberby.net>

On Wed, Nov 26, 2025 at 01:32:22PM +0000, Asbjørn Sloth Tønnesen wrote:
> I prefer exact-len over min-len. The current tally is:
> 
> $ git grep 'len.*: 16' Documentation/netlink/specs/ | cut -d: -f2- | sed -e 's/^ *//' | sort | uniq -c
>       7 exact-len: 16
>       5 len: 16
>       6 min-len: 16
> (assuming that only IPv6 has a length of 16)
> 
> "len: 16" as used in ovs_flow's ipv6-src and ipv6-dst only works because they
> are struct members, not attributes.


Talking about the ovs, it's looks like that the struct members are used in
flow metadata, like in ip_tun_from_nlattr():

                case OVS_TUNNEL_KEY_ATTR_IPV6_SRC:
                        SW_FLOW_KEY_PUT(match, tun_key.u.ipv6.src,
                                        nla_get_in6_addr(a), is_mask);
                        ipv6 = true;
                        break;

While attributes are used in __ip_tun_to_nlattr():

        case AF_INET6:
                if (!ipv6_addr_any(&output->u.ipv6.src) &&
                    nla_put_in6_addr(skb, OVS_TUNNEL_KEY_ATTR_IPV6_SRC,
                                     &output->u.ipv6.src))
                        return -EMSGSIZE;

So I think we can also convert the ipv6-src/ipv6-dst using exact-len? WDYT?

Thanks
Hangbin

