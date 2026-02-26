Return-Path: <netdev+bounces-261402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGZROTxsoGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:52:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F191A9220
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A112631DDA2B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46940F8D1;
	Thu, 26 Feb 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnawsyIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6C3EF0A7
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120177; cv=none; b=X/gsweoQqeDpSxm1OdkGxfQ+prkjZnbZQLDx1TCa3aMawnuh3rncS3z+D2J61p9dsVfA06Hm8H7uV+b7Ip8s77r+jDpwHtHIShLcmOVoQAmacvnyL4Wlobx3/RqLS+DKp+x2pZiEJCusKrDv7152HK1gvOpQiGAgLkPBWeekzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120177; c=relaxed/simple;
	bh=nxzCbi2MzfPt3kaMaWM/lwHZ/NWVoOrFC/qoGTjHLuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLMSIUXADA/zpak81cJGF26PhAXhQDLVr1xDVUOsn/Jw1OQARyux+Lyr5wpASS0ySlYnn53TLrZ4TcGoT0fOuMn8o/9mEfJ2wQfIXRNw7CCxEFqU3+gXgShqLkRF2apWRo7SLT0jCvMMnnthZ1ioctOYV2yvg7mtHy3cAsCAbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnawsyIK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c1d2123dso1006160a34.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772120174; x=1772724974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Q27Vo37l5jke2x5kYEj3BGxv95cJSIbkx6Yir20Fc=;
        b=LnawsyIKgiuWD7bm7bj0iRAol5a7ur9FiOxJ4igx/cC7vgtcq0vKGaZF/hU8SmNYOt
         L43+MPVeCmxsc41bFlaEih6Y/V+SxC+SpiUaDO6RzESSZF0a5hjub1EDxLNxZd4sOR4/
         IldXn9hoR8q2RVF4LEkuvJJKlmCOMmE4Xob/wic19PFc67ianNHAQloigxSwrg78XJMq
         e26gvwQdyEjEo5SFVYGMxHhwUQ34/sZGYyyByD7rhv+RfL7dg68JIld0sTJ2kFRFUDnw
         NWLLQFn3zd3hNmBP0MeGlInvAXCvQIRjKop6tsk1yp0AkyFo2+h//iSVVNJV9Iw3GxUT
         J3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120174; x=1772724974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1Q27Vo37l5jke2x5kYEj3BGxv95cJSIbkx6Yir20Fc=;
        b=efH7VFZIRjUVSjC3BjQuI89HRvNkLwwC3YRIdyPYC1I2TebSQuRhZG3iB9m/J4hcK9
         qsfym41ZUGbt8UtTkMvbi6mEoFY5PR4qTQci3AZ95AzxU9z3fvrp+F7HEHAXAYMoGZkn
         X4iccumEt1Vga6jmPYoOWCH6CrxvpUSZnJgRJSZK9OTBXufwKUdSAPwY2PJSVu9A0eaq
         iJP5uHTE1ngg2UUXb779se2XgkQSljq51obqmZos29wnVb5P+C8oU9ykiOeFt02cufli
         OT8diiJAWM0AJ4iw41/7Nnp5gEV3h1bMcz+TcD8TmWZ1vjsQ1S4sTV9xt5T+wO/Qz0jP
         wqiw==
X-Forwarded-Encrypted: i=1; AJvYcCU52ykAWPLgHNTHStt7M41QuXkr91N2dM+tHgH9338Dy0x3h2XcW82RO3vhivoJFmj9DpTrgIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXVI4hjNKiz1jMPZIyEQcBgj5TTwJsP/Kw+/+2mD7TrZFAYxP
	iVox/70tbMatCFF4icj/zUHb2KehktMh4482dN4IF6qZb7Ah4yhwgvai
X-Gm-Gg: ATEYQzwUyTNShu7l4PefuDkrCEFkCr+3OQ0/Q5YOiN0lGLOO/wf13miH7UGa2Dj6enK
	63ghCIg8GEFbo61sdP2qZhh/3+foLCv0yumRE2XVZbkoyoCEU4FFSuUkqzXwEPuItEtg/mZoDxv
	J+1BNdBIJBcrf4iEzWibDgAlYeOZ0UQDk2igvZEFruFeUZQ1y0yTEjZWCh4NzODZBnPff31iUk8
	QcLCPjyfZS+GOJeUwi+VCrVAUC2/dr76HEw2X1DCDl0wQTiQUCMpMtc5o+r59PI0j2TccIQqBU2
	EC/0hyEflL6JrjJlkZCWrwVKuNsuqbAGngiVlLwZyWyrNfLSD/BXuIRTOr+n7HkQs6O256rYSCw
	StJds6AZ3xET4+tC4n/pdkFDYi47Mwp6w3jPcb98If7DTocFJenXgv3/NenKjSJ4wU+JABVnPAN
	f4k6St1uTfV1HRGxKMAiA40unoJoNZXnm8BbROF4kT89CWrh3E8lfm4CB78HVW7W+L6c+po6T4X
	HrNylX8wvuj+aLAPw==
X-Received: by 2002:a05:6830:b82:b0:7d4:becc:400e with SMTP id 46e09a7af769-7d586f6d9d8mr1461419a34.34.1772120173688;
        Thu, 26 Feb 2026 07:36:13 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d586653f81sm1939958a34.23.2026.02.26.07.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:36:13 -0800 (PST)
Message-ID: <bf293e1c-b2d9-4ef8-87c5-579e523d74de@gmail.com>
Date: Thu, 26 Feb 2026 08:36:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 8/9] bpf: fib_lookup: Allow output lookups
 for IPv6 link-local addresses
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me
References: <20260226080003.524935-1-idosch@nvidia.com>
 <20260226080003.524935-9-idosch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260226080003.524935-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 49F191A9220
X-Rspamd-Action: no action

On 2/26/26 1:00 AM, Ido Schimmel wrote:
> Currently, the bpf_fib_lookup() helper returns an error when IPv6
> link-local addresses are used. This is the correct behavior from input
> perspective as such packets should not be forwarded, but the helper can
> also be used to perform a lookup from output perspective (i.e., with
> BPF_FIB_LOOKUP_OUTPUT). In this case, passing IPv6 link-local addresses
> should be allowed and one legitimate use case is having the helper
> resolve the destination MAC for such packets.
> 
> Therefore, relax the limitation and allow IPv6 link-local addresses when
> the BPF_FIB_LOOKUP_OUTPUT flag is used.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/core/filter.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e92552b139b1..8f0d2aeffc3d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6241,8 +6241,15 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  	u32 mtu = 0;
>  
>  	/* link local addresses are never forwarded */
> -	if (rt6_need_strict(dst) || rt6_need_strict(src))
> -		return BPF_FIB_LKUP_RET_NOT_FWDED;
> +	if (rt6_need_strict(dst) || rt6_need_strict(src)) {
> +		int rej_type = IPV6_ADDR_MULTICAST | IPV6_ADDR_LOOPBACK;
> +
> +		if (!(flags & BPF_FIB_LOOKUP_OUTPUT))
> +			return BPF_FIB_LKUP_RET_NOT_FWDED;
> +		if ((ipv6_addr_type(dst) & rej_type) ||
> +		    (ipv6_addr_type(src) & rej_type))
> +			return BPF_FIB_LKUP_RET_NOT_FWDED;
> +	}
>  
>  	dev = dev_get_by_index_rcu(net, params->ifindex);
>  	if (unlikely(!dev))

Reviewed-by: David Ahern <dsahern@kernel.org>



