Return-Path: <netdev+bounces-237544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DDC4CEF8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D687C18884DB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD4334C11;
	Tue, 11 Nov 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8oPiluu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hhk+fUfW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81928304BD0
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856018; cv=none; b=DAVbkDzD5JRAk0RNy3tBqacIqR2nhJWnHQFVo9e4SeZj1SnNgXDmrahyqnx65FLMN2uVXy8v5N25Cc6PNO3kUnSG4Mb2vLJSQaHH95hamC7MH9hSnEokdiym18QEOFzveJq0rDqU5CcVESX8NP2MVDvRrTlyTB5Skt38XN9PYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856018; c=relaxed/simple;
	bh=WkyJ7wXlU3Y179InlLzeaIBiSRKrxBNojZPNLGg/meM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyIk0r0+sY6YgVAkINdm4eUpkU5JAV6vMFpDbBrhXdqmVjpkFBCAanQIgQwW1xjWJvbBfi4jEMrknk5QfnU7IaE41uQOsThG5EMSJAfjfFwNQFYuhfuLoumr2Td2VjOEy+il+fE1TELeGns4qx1TjzVKu8wZHBWiRrN/OQs9snY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8oPiluu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hhk+fUfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762856015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWIdabjoIl/GpEWbTxxG5QL1xcrQ2UzLO8Uh5MSiqpM=;
	b=P8oPiluujwFirZxq47Ph5F1aRuEUKMCLsIB+Jjd13TnnEAWzDb1vWdwnoCg9cVIuVYvgmj
	RLKE2TD1KcMHbXAbJsakmV/Tm98mLk+dgCmWsBRYokDrykJ/XdIvKFztYxWd4pN7QyfzIA
	96qxBSyul2syB7qEte6zAnDLTDANWm8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-wtnilTFNOB6CcE6dllAlYw-1; Tue, 11 Nov 2025 05:13:34 -0500
X-MC-Unique: wtnilTFNOB6CcE6dllAlYw-1
X-Mimecast-MFC-AGG-ID: wtnilTFNOB6CcE6dllAlYw_1762856013
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477771366cbso13974075e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762856013; x=1763460813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWIdabjoIl/GpEWbTxxG5QL1xcrQ2UzLO8Uh5MSiqpM=;
        b=Hhk+fUfWuPqsLZlVLn2tAxCbJjOjZ0OyTIwpZCpBzegKXXaVsiFnimDj3diFAyOqsr
         eRiElkPy7DDEC8uGiNVaWpgzROoPZDiUBJ5J1yT8wVPgtg9wUn2m0FKZkTT8M5J4srn0
         ujAPebkKgtUr+l/lzlnxPHLVInuGK6l+84oZY2gD+fB59i7E9WnxR96h4/0w5RoMSXtN
         yPCFEgnCNXR3o7VoGGj5TNEoJmw76DXDpwwSDajxdF9quFZ+IZRczptw4g3/XyTuNl/b
         n6QyDN6k7W5lTkm2QrKEf4X7Ob02PzCRxAVhhbxt3p/+HMNYEzr5ovbdEhPokHZDoUgm
         lg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856013; x=1763460813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWIdabjoIl/GpEWbTxxG5QL1xcrQ2UzLO8Uh5MSiqpM=;
        b=iY4gD6Hj1k616iUabT/OtCxFv/wXEGArTbZZECCEoXTvV6Wl7ASFSwIxqcKZWBU0Qf
         i/EzDmWIA6gUQsU4VNNGFRfNHwodvr5A59AvWM/1JkSR5N7CXmQBUakofIhMLvj/0wgk
         5rDhRG1SgpRJjsh8k8GpUOE/hXyM8lYPf6VQqF2RNnysX6ZPw5d1GMmtHRPD2ZCRMxeI
         KKBCS4QgLr8lwfvTlzzwGVqPVDx67ZRhWtsT4Qyo5TU7BrbJM33viQWhC8HDXf6CqS4L
         2veVov4UzHBL/E5X/uslm8oI9yVUUDC0V4eIv+mU3oeaqkYBPD2K6wfQhQEEkDFEmqfz
         3Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCXSrb4PbKDLGO3fTqlSxaYz02WLk/nlram8wcTZVcLqJvm/jE0tj5erYJUBV4Z+80K/PDzZ4nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/cHH1iDy3rzW2CMhgUHODo3GszF8s7E5KHwE0N47L3kq/Z3f
	wQZTg0I5p8PbDpul+01RdlPkp2/0APGi7hB1hh+6TqIN45IDTqQ2LCRpxWt7ZzU5BF3k3sVDsnM
	VFDm16w22HeioX1QHTRIUYRWOghBX1S/wGb/txY298hkkBNs0JCBHQQW7yw==
X-Gm-Gg: ASbGncue8lgdY2lwDd8vWREo9TSjCnJy82zOdMrYHLcgIKEcB7C/8p1hJuygEdIHX0y
	Mxd/4g0qAea5eICxdKw8g62pDvwzdTMnAKOW76ATnHBGhmrVo0mGC+2wx2mCwI06UcmdYRNuzeE
	mfpDbcf92zYw1pozB+WyTFRLzb3RAvIMF7HGXf7HWiUm6F9YBj5oM2IFo4P+6N48wvMK9ERzevG
	8+D1vhjvOA9Cq+vc9YA1SHNmOC/DMeqfMX0RvxcpK95/9yRlM9yh/WYQlT6XKDOz+gOgUH9YDAx
	j4MfdIccpckIFAZskttDmotmZeG1wuhuXqHeGqJzd8S3IAcAyQmaK8qJZoiQVPcjAN5xx5+W3Ng
	J9A==
X-Received: by 2002:a05:600c:474c:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-4777329747emr91118645e9.35.1762856012895;
        Tue, 11 Nov 2025 02:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwju2eerJqJ/sKKgP7LErOCpNGcS4xksJ9Dc99yY2BVV7WFCIJNXdq55bjtbk5k9a7KTteNg==
X-Received: by 2002:a05:600c:474c:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-4777329747emr91118435e9.35.1762856012407;
        Tue, 11 Nov 2025 02:13:32 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778289c036sm12751605e9.1.2025.11.11.02.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:13:32 -0800 (PST)
Message-ID: <a9db02a3-f774-4a81-b641-24f76290ed74@redhat.com>
Date: Tue, 11 Nov 2025 11:13:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: fix lookup for ::/0 (non-)subtree
 route
To: David Lamparter <equinox@diac24.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Lorenzo Colitti <lorenzo@google.com>, Patrick Rohr <prohr@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
References: <20251105145446.10001-1-equinox@diac24.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251105145446.10001-1-equinox@diac24.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/25 3:54 PM, David Lamparter wrote:
> Assume a scenario with something like the following routes:
> default via fe80::1 dev dummy0
> 2001:db8:1::/48 via fe80::10 dev dummy0
> 2001:db8:1::/48 from 2001:db8:1:2::/64 via fe80::12 dev dummy0
> 
> Now if a lookup happens for 2001:db8:1::2345, but with a source address
> *not* covered by the third route, the expectation is to hit the second
> one.  Unfortunately, this was broken since the code, on failing the
> lookup in the subtree, didn't consider the node itself which the subtree
> is attached to, i.e. route #2 above.
> 
> The fix is simple, check if the subtree is attached to a node that is
> itself a valid route before backtracking to less specific destination
> prefixes.
> 
> This case is somewhat rare for several reasons.  To begin with, subtree
> routes are most commonly attached to the default destination.
> Additionally, in the rare cases where a non-default destination prefix
> is host to subtree routes, the fallback on not hitting any subtree route
> is commonly a default route (or a subtree route on that).
> 
> (Note that this was working for the "::/0 from ::/0" case since the root
> node is special-cased.  The issue was discovered during RFC 6724 rule
> 5.5 testing, trying to find edge cases.)
> 
> Signed-off-by: David Lamparter <equinox@diac24.net>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Patrick Rohr <prohr@google.com>
> Cc: Maciej Żenczykowski <maze@google.com>
> ---
>  net/ipv6/ip6_fib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 02c16909f618..c18e9331770d 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1650,8 +1650,11 @@ static struct fib6_node *fib6_node_lookup_1(struct fib6_node *root,
>  					struct fib6_node *sfn;
>  					sfn = fib6_node_lookup_1(subtree,
>  								 args + 1);
> -					if (!sfn)
> +					if (!sfn) {
> +						if (fn->fn_flags & RTN_RTINFO)
> +							return fn;
>  						goto backtrack;
> +					}
>  					fn = sfn;
>  				}
>  #endif

The patch LGTM, and I agree this should go via net-next, given that it's
really a corner case and I could miss nasty side-effects.

It looks like you have some testing scenario handy: it would be great to
include it as a paired self-test; could you please add it?

Thanks,

Paolo


