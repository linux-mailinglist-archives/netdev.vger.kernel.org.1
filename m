Return-Path: <netdev+bounces-253964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIZpK5f8eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:57:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D66698AE3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC17B3007B82
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E32DB79B;
	Tue, 27 Jan 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXCjjHDF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FD1D9A54
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536658; cv=none; b=H9mQBhLyp++ow9J4xDhUVHwnvGt62/7RE6hWHvgTcUnYcePxgQ0HDpR8rZzoakl+yB8Og5Qf3yDCP124XS/dCiIGCg/euNQn7yqyhmCDGHuHF+ZXTA3B8J8wZXQ0SjJWl3CP7uHODV0WcluKJps7vjtgvMjoganm2LMFW7ZOQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536658; c=relaxed/simple;
	bh=9OUlqTS2X1kLZb82+oJsarkX0EVt4rRcEgT8XI3WfGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hBD/t56vmOJE2au8FpmZ/Zt8A3BuTA5E4SFyisNT6+my1eVuyvAoBTS4ZKzpDnaqphsa34s7SEjGdXNptYIbHsmhUd9CGnLfarIF10TXzXU7UBWNC93Da14sMYP9qu2yD12z89gEVSVyoPAXGs9NpB4adFddrhtBv/8JtmGTznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXCjjHDF; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-432755545fcso4484363f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536656; x=1770141456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4exkZkjw/kzfcBB5LKYKNesify40qGjTmKWyi+ePtwg=;
        b=nXCjjHDFTE50i7sWVelvhzqLue8CM9XTkLtlJokXbMe3fdC6CzLjsGguer4I0LpXeZ
         o6v+xhwr2UAtENXG1ubYe8IRzUMlB43CaAnWpLLqgNqoflbuKwQOmwibKOO/JV1tQiCm
         rHI9Qy+kssE1dvmB7pJ86F12sT+EG8I7Nlz/9eGsZo0kYTmLmFMW0wJPPenSfC0MVBkd
         gpeJ3vDeRz0mW8noUJSWBO0qbkUnE3O3dFE0xHlsHxCz6wwh6iCX2ST6I8FyQFCXPRPo
         edWKj9+DNIt1FMQmq71vsTLiQdZ3tc58k2LGpkjdE5ffj6GlRByauyudORfGVDBWwZRX
         H6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536656; x=1770141456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4exkZkjw/kzfcBB5LKYKNesify40qGjTmKWyi+ePtwg=;
        b=PieYWqE8wUvQdfafvPvMiup3h9Ek4oXvNlPq+jLGvNQ85ZEwoHQ7XOSt0H37Mj9HRo
         zBI+iqMCr5VlsDuZ2RFQwkSCwsGT+JUmIh8V/vuOKYJrzXEmk0pDENabcwlB085hT1yF
         8AH2gpLEPzkdh/0dm1SoGAZ9yQRh122D/EYvBSs1HNyfa03lnj+FFKSHkPE704IKIkxs
         g+aODQyfWLGHkj9S4e8AQHvbfzN0GSdbB6QEEQyjJtATmILLzdSPFAJMyEwQyTAxQwnS
         m1RcBXtMgBbDOUweQ5HG1xNrNuVrmPdJqvaBe5p17zqCWfzxMUEN+gQchI6pujcowCYZ
         N69g==
X-Forwarded-Encrypted: i=1; AJvYcCV1g4aw58qWC6iwM+ivx29umqtBq0vZSl26YXLwL8gZ5zkMQ2uVwE1BXNLSzf7dwg4KqOhQ7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy21oIt6rhHdsww+Ff0ZqFWGsJ98WvnZHd9XJv5rcOaCg9Yy/f
	lx1gOnc1HmU/8Mud0tT+H9uU6JyTk/qF+1ARUGoYeXaLc7E4TMi83fCl
X-Gm-Gg: AZuq6aLm9MWBDnoO2FRW5eYvbyl4KCyefL0T72H2UznbucA2g60zBllIXtDp7CllacQ
	ql8i4/uN2vErbQWAMlWzmOkPFrzn2CFUlSgdJ8zAewgVxkHVM+jTwS3JIEFSe871UXvT0WfgD+/
	s1PbdCbAbHNE6ORG29XYcDxmHqgyKG+HgIGZH6qB6ou944L8BmC9b7XJcF3JZFYJM3aQcCQZAFT
	GGaqQpr/+yd72DwIeZMtHIm3r7cIWKli+XVEzZVWYCC63jTwjrC0ivawz3rmAhukL6ysYwgUXlY
	6/RphRsdvq/ulTPHC4hLxbXaISXxTnmIbn80xpbPYFz3CNvFJpmjeGpxS7Yqg4Bmlo4BVjdz+oy
	vbRFZT3ZSUZIzdeKU3speFisa7X202LUG3iouS4YS1BLIuFHbVIXvFzAA94N4Ct9lkXsV9vywep
	9yGnX/mbsRR4Ke97qmFvZfCD+7tfubUUfedYUD+gjsy+oG5CA61B8pg2EBrRTYDkoqzw==
X-Received: by 2002:a05:6000:2585:b0:435:9690:f056 with SMTP id ffacd0b85a97d-435dd1c0bb8mr3869218f8f.35.1769536655507;
        Tue, 27 Jan 2026 09:57:35 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323770sm397741f8f.32.2026.01.27.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:57:35 -0800 (PST)
Message-ID: <6ad1412d-544b-44d0-b55a-f39a2693ebcd@gmail.com>
Date: Tue, 27 Jan 2026 18:57:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/7] ipv6: Document defaults for
 max_{dst|hbh}_opts_number sysctls
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-6-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-6-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D66698AE3
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
> In the descriptions of max_dst_opts_number and max_hbh_opts_number
> sysctls add text about how a zero setting means that a packet with
> any Destination or Hop-by-Hop options is dropped.
> 
> Report the defaults for max_dst_opts_number and max_hbh_opts_number
> are 2 which means up to two options may be accepted.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   Documentation/networking/ip-sysctl.rst | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index bc9a01606daf..4f568b0e39d2 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2475,19 +2475,25 @@ mld_qrv - INTEGER
>   
>   max_dst_opts_number - INTEGER
>   	Maximum number of non-padding TLVs allowed in a Destination
> -	options extension header. If this value is less than zero
> -	then unknown options are disallowed and the number of known
> -	TLVs allowed is the absolute value of this number.
> +	options extension header. If this value is zero then receive
> +	Destination Options processing is disabled in which case packets
> +	with the Destination Options extension header are dropped. If
> +	this value is less than zero then unknown options are disallowed
> +	and the number of known TLVs allowed is the absolute value of
> +	this number.
>   
> -	Default: 8
> +        Default: 2
>   
>   max_hbh_opts_number - INTEGER
>   	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
> -	options extension header. If this value is less than zero
> -	then unknown options are disallowed and the number of known
> -	TLVs allowed is the absolute value of this number.
> -
> -	Default: 8
> +	options extension header. If this value is zero then receive
> +	Hop-by-Hop Options processing is disabled in which case packets
> +	with the Hop-by-Hop Options extension header are dropped.
> +	If this value is less than zero then unknown options are disallowed
> +	and the number of known TLVs allowed is the absolute value of this
> +	number.
> +
> +        Default: 2
>   
>   max_dst_opts_length - INTEGER
>   	Maximum length allowed for a Destination options extension

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

