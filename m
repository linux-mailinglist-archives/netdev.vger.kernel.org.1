Return-Path: <netdev+bounces-252255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOVLEzXycWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:47:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B043C64C42
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41F904E6B16
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFB34C818;
	Thu, 22 Jan 2026 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cgq6e04q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7UVtJcA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3E33F8B9
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074884; cv=none; b=Ytuf8sTPsCNMUp53rsI42pwKqZTUsjlteCH1Ut2c9vJftZx2aTjBqtHLEzQhtpkjiYs7vVbGSzfZ9upWp+SQxuQWq47eTrdsZviGgw/P5AYFJMbY9tdADWX4357EGfM0xkNai7c3IClCu0XTS22PtAPex1JA9hLl82l+Isgr56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074884; c=relaxed/simple;
	bh=nyaNABROd7o7p8CvqbXZyR8TgZAtD/lO3Focy6AWrOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiQBv6+us9bOeqRhHMZeTmds8OupJxwefjZ7cPQ/iiFs+tzLiinhQ/W7NF1PztdhycmTaKhhYPM/HV/Wsm6vfg+I12QE1bInTIKB+Zd6FSMdqh/9NaSwNzyfGa4EtUI/gaDqwR3HK+V072pCS4ZCTGwmpmNBE07d0cnMIwt6tVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cgq6e04q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7UVtJcA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769074881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibHidGnmSWCLwRRmhNMKIRvOwyETyBrBfeoqUFQJa/s=;
	b=Cgq6e04qLfJbrsH2jBro8MEx4MKVNFPSxIKUkkLkZaYrIXAKB1zosR8q8T/4j3IgqkZXM3
	E1MY48Jk+g3ptxRD1wr1t0BkBrEmL+eGFNxqW5JeppC9QE1XW1U7HHzZm/k2UQtVxR/Rjm
	aNruE8TBB9bo7+kWOBfhhPWb8B5+kYQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-_Vx9EzSUOB-nx7XhQBdYdw-1; Thu, 22 Jan 2026 04:41:20 -0500
X-MC-Unique: _Vx9EzSUOB-nx7XhQBdYdw-1
X-Mimecast-MFC-AGG-ID: _Vx9EzSUOB-nx7XhQBdYdw_1769074879
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so7213195e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769074879; x=1769679679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibHidGnmSWCLwRRmhNMKIRvOwyETyBrBfeoqUFQJa/s=;
        b=H7UVtJcA5GzoUL81KJhp8NIxnnvzNoIR1PZjhSNSfa3xk2vNHxkJwpCOYrHBR+3Tvr
         QcsoznsqURxDXkkcrqM7wCMHe9tbn9pNts+pySDDPW9R39TSQbLKQ8Z8F3L/x3YEcDlv
         D+wEVwSsPfnSb7mrcgudBYEFweGfXEyAuVPBltiKGmWrF9l8iVkp7tmAZkWBYi1XVcqN
         EjmOMLG1cxw0y0lfLTTY4ri3skwVG1lRriNDwdx5KNWheEyx+biuQZLgcfR8oWyFXFFy
         dML1soICw1zn2wr0IfQsuu4WQx9JZfns1ubwz1zb8VsQVbmWu1Z3ZWvHGJitI5Yaa++y
         J6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074879; x=1769679679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibHidGnmSWCLwRRmhNMKIRvOwyETyBrBfeoqUFQJa/s=;
        b=IGoSs5oFC+Uqtcz75OJdjuBgQ0RZZpFHZ4lkjyCCtgMhqGk4BJYVfACThLPhdczMox
         XkuV0Lz4YvTIF2yVuhc0nmbBlJ1yoqzj0ao9s9J8I22+VX5WxohRjC9UuP5YZ686+F8E
         aKlQiJa6X+fw8vJb1CjW9KPJQO20CF8cLGfCCutUYZXFl5j8KnYdOSJJyhTcU6sfwIbR
         pmZBJAq2nUhyMBNlrRFaqdtjehiEZTGAARuzKlkyz87EcqHuyswMwhqtbNQ59J+K8XFs
         owpJCRaethZFHwGjMHomztVvNPkzSbMquLhBJD0l7RvB1e6H+aY2foSsh8LZXaIA5HWM
         iALA==
X-Forwarded-Encrypted: i=1; AJvYcCXjHLAS/npBP9UvUWEeVQpbAB36mUE7I9wdRl35O5h5vMuZoFhyupx7oBoO+1DldftAW8qP9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6E80lb6fe4Q6Pf1bpr3p6xOltERVptPi/TNWxOplJKCia1Ogn
	2FGmQGSgJILaAXU7RqnZFlKMScUTj/ufsuIj5aeAOo42Jlb304BeFSNecXO24PxWCNMylHZh/De
	xJI3qZa6zq3x4t7koYPDnbGvEH6MjqwRaOfYUecxRjs1GlKoxNKniS1WC2U2IKTAKBQ==
X-Gm-Gg: AZuq6aJ9DFWDTmesO0nW6qizDIFfQgWV0A0xbZ3sN66ZBKu8mShhklE2TtEWMK2zJQf
	SUdYTpb3mj0vzb+6l0/rwtJuPY/9bwAQ3+cZOEvgnLEUJFhe0UogtusiwRnCmsCiLv4eXY91hFa
	09TzGRhR2LgHhnvERB4Be/+QSKuAsswkMVH9VnxJHqZuH50JRpxf0Uy/qHutfsnNnL0ML+HznA2
	CNsAp29JH919DQetEFfR6qeH0WZg8cH23RsCGdrhiKTkeD+5RSy3vd2p9TnzbqcFRXb8wSeNXOt
	2Rv3bayQgBSP4wR2IOutezbNccWnByBR/XW5y55Q2ebitRA/5p/i1uJQnDTQwoS9QT+TpfeGh0u
	e9g+pq3oAWFPD
X-Received: by 2002:a05:600c:a11c:b0:480:1aae:676c with SMTP id 5b1f17b1804b1-4801eb0928bmr222203215e9.18.1769074878590;
        Thu, 22 Jan 2026 01:41:18 -0800 (PST)
X-Received: by 2002:a05:600c:a11c:b0:480:1aae:676c with SMTP id 5b1f17b1804b1-4801eb0928bmr222202855e9.18.1769074878143;
        Thu, 22 Jan 2026 01:41:18 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48046fba46dsm54385625e9.0.2026.01.22.01.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 01:41:17 -0800 (PST)
Message-ID: <a5b78a79-8f8a-44d3-9a1e-1019ec57f910@redhat.com>
Date: Thu, 22 Jan 2026 10:41:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/3] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>,
 David Laight <david.laight.linux@gmail.com>
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
 <20260118013019.1078847-2-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260118013019.1078847-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,linaro.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252255-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B043C64C42
X-Rspamd-Action: no action

On 1/18/26 2:30 AM, David Yang wrote:
> Reported by the following Smatch static checker warning:
> 
>   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
>   warn: was expecting a 64 bit value instead of '(~0)'
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 0b3df732c0d1..5e4e8093ba16 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -682,21 +682,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
>  		u64 *valp = &((u64 *)mib)[i];
> -		u64 val = *valp;
>  		u32 val0;
> -		u32 val1;
> +		u64 val;
>  
>  		res = yt921x_reg_read(priv, reg, &val0);
>  		if (res)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			if (val < (u32)val)
> -				/* overflow */
> -				val += (u64)U32_MAX + 1;
> -			val &= ~U32_MAX;
> -			val |= val0;
> +			u64 old_val = *valp;

Why targeting net-next here? the blamed commit is already in Linus'tree
and it looks like the above could causes functional issues, ad the wrong
value is written into the mib.

I think this should go via net.

/P


