Return-Path: <netdev+bounces-296432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UMPwHrGLJmosYgIAu9opvQ
	(envelope-from <netdev+bounces-296432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:30:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1597E6549D1
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eUpBEhFp;
	dkim=pass header.d=redhat.com header.s=google header.b=EJTMSsyr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296432-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296432-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C588300914B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956E3314DE;
	Mon,  8 Jun 2026 09:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1177330B30
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911023; cv=none; b=t32PLhzpl4lchqxndNC0Ngyp2xAVm9Kzs6EHiBIbmSk9cxAd4tWua5lhIA6FA5QHnuXJBonVJh8FH50V864dy1gxvgH0jC/ttBgC0qeq2AlAE1Gatnq0Pb2dBo3Q4nFdt0cUqGuODbplbUpT7CxHqiRH9HC7GLNX/9utsikeWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911023; c=relaxed/simple;
	bh=FDGFp7VM1n9E00c1zxEOuRHsXkDQEmzTdngIEv398dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfoFk0nt6cvnZLJ8+81lOLGtQscF/59GdbOMorSafigyC0wy3oMRvPZdcc11P10m1AGFLxG47sqgMT4oAhvYU0JfOOt9z2ea5K0pqWpGQ0uymuAZABYZ2r/ZwFXyatCoWPqHViQGXIR0wKPJjZx65oqBD1qtJJcHOUPt81kXR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUpBEhFp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJTMSsyr; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780911020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmrI40I7iBW4u79freyI85Nz+vF4jfGPu+NMxL2IdmU=;
	b=eUpBEhFp0tDU+roEB3Qgk8YfJR9q/5ZzW3apPwf0tXg4kJ3DM4dnFsoELoT+R7qo/CXwfm
	vdIWih/e0P7EC4VP/2o7yOz3IkghB9EhPi6fOBPt9DShM+Ef2LBjWc5BNcHLBBfPg9lhZt
	/NE9s6ia4Y9VV9iHqNEzcOXWCK/p0gI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-8OnXLPZrNGy3jJCHp_Slag-1; Mon, 08 Jun 2026 05:30:19 -0400
X-MC-Unique: 8OnXLPZrNGy3jJCHp_Slag-1
X-Mimecast-MFC-AGG-ID: 8OnXLPZrNGy3jJCHp_Slag_1780911018
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490c56e2576so23314595e9.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780911018; x=1781515818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmrI40I7iBW4u79freyI85Nz+vF4jfGPu+NMxL2IdmU=;
        b=EJTMSsyrwUeGEVXrPlevgTxGRiiLSOTr/+Xrv1BRLv2s9RyAO+Zu+nxkmHJ7/gZyfS
         8juDFj15bUWrpxqt0Nz08UoEr+8B6auqAl9d1oYq/J0Y+RbmnY22av8YEJgnI1GSNmu4
         Uj3UFzXRCVZoj4akHTzUfIY8GYKLszA/R3aOUMpOgJYKs1CW1q3JRWRh/YPnbrYKi7cw
         hyrlxs6UR7McNzI4/s68k8BAY7r6mxj+ti4j06YFOYxeaWksdnZqXgzC2Uq4FDWrkrEO
         sXtNYimCVA3B28evbFeKb/pTJ9zknPw8FW0cEb5iygZTQo4XkCcB20fdWOA/g/ER99kz
         Mbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911018; x=1781515818;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmrI40I7iBW4u79freyI85Nz+vF4jfGPu+NMxL2IdmU=;
        b=YFNqmcT4RHvIogGlmlncoh8ZMuoLGxfLmMSWVgyXr/PgiGTLGxY8OURuRez7ufvb/2
         mBont649jdlIF6KIOm/mjB8eEVZMMo/RXGSQDZUqDah8NU++Rob4aPlNnxgcGtoJTGRf
         sM/psWxi02h6l2YqQnYk9GQAkI5NWl/E/qoWHhdbtOhlY4qHmsSbg9unOwQ3XRB6TFpe
         ZsR5wc0riUYUyYhPUvAYNM3vG73YrIZ4TgyM+Om7tLHgMof9aCjHw8PXMpM/evgy+bxR
         YAvHP1GdgMiIUcQcQBMbCsOAHcJycf2GhCg7FrrhNJYKSdVMMp74zN1H74fZCI/1qxwB
         O7Ww==
X-Forwarded-Encrypted: i=1; AFNElJ8Bc1SZJtOBQOM7K2oIBWMxd3+fK/fbKecxVmnHJGYqmrvWTVXopeS+PVWXITI7AQfx7OOcRj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrBc9flXE+aHR3VPTR/lJeXEUF/GK/tFImVpP+86PMbHrBp3e
	W0lshiy+PDvOVQV8LFTazBhAY0dYeMbrcTT+pzloq4pK6hHB6CZTMWIgrfS8eQ+42mKXvs7iYSc
	it4u6xe0TTfoLDppmLgvbrAD0qMJkDJSTYxIrhwtpZJyxJnW9D/4FAXNQAA==
X-Gm-Gg: Acq92OFgxj/WyoNi4evtYe354gGQQJqAyB3oOl6UsWgGztAkO0Cso9eiY/rpBXsee41
	mC8+Kqaw4iCpGm8ordIKCOr+w0rtiOE+jfJwEu7vkzu6bJ2V/+A4jNXkgsAZjq/9icE9v3VGbPa
	uc2QyteZtixpg3D/l6NyAARkZKPAn/5L/gkleP/IzsPeYZGpRY5qT/bJKTAx2EFHn6mwUtoolWQ
	DllebW8bU34IqU4ud8RO2Lq+6D5rbI66oBe5bCndd8iLOt/YGsIecvWLp3fUdSnJk33am2dLZ74
	iCnJ5jBXpLhQMdWW+iLgycqQmRcK6fBoBfzzeYoAsHdgRzTb3N+IOaVUZ7DGYDHVS51+iT6kB3Q
	oHHQ+AWiFJoMFiEOTSrD4AdP+0h+KAnSUHUjVSiXFrwVQqzkaVXx6l5toMegdv8DYqQ==
X-Received: by 2002:a05:600c:8183:b0:490:958c:46dc with SMTP id 5b1f17b1804b1-490c25b0a60mr222043615e9.17.1780911018105;
        Mon, 08 Jun 2026 02:30:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:490:958c:46dc with SMTP id 5b1f17b1804b1-490c25b0a60mr222043095e9.17.1780911017667;
        Mon, 08 Jun 2026 02:30:17 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm366496865e9.5.2026.06.08.02.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:30:16 -0700 (PDT)
Message-ID: <b2052195-0411-4fb0-a802-718e07804188@redhat.com>
Date: Mon, 8 Jun 2026 11:30:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: geneve: gate GRO completion hints on socket config
To: Kyle Zeng <kylebot@openai.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>
References: <20260607013406.7294-1-kylebot@openai.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260607013406.7294-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296432-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:netdev@vger.kernel.org,m:edumazet@google.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1597E6549D1

 6/7/26 3:34 AM, Kyle Zeng wrote:
> Geneve GRO receive only consumes the netdev GRO hint option when the
> receiving Geneve socket has gro_hint enabled.  geneve_gro_complete(),
> however, parses the hint option directly with geneve_opt_gro_hint_off()
> and therefore extends the completion offset even for sockets that did not
> enable hint processing.
> 
> That lets a packet for a normal Geneve socket carry a syntactically valid
> hint with an attacker-controlled nested_hdr_len.  GRO receive validates
> and pulls only the ordinary Geneve header/options, but completion can then
> run the inner protocol completion callback at nhoff + gh_len where gh_len
> includes the untrusted hint length.  This can make completion access beyond
> the header area validated by receive.
> 
> Use geneve_sk_gro_hint_off() in the completion path, matching receive and
> post-decap processing, so the hint is honored only for sockets that enabled
> the feature.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  drivers/net/geneve.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index c6563367d382..d62cbee6c0fe 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -948,13 +948,13 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>  	struct genevehdr *gh;
>  	struct packet_offload *ptype;
>  	__be16 type;
> -	int gh_len;
> +	unsigned int gh_len;
>  	int err = -ENOSYS;
>  
>  	gh = (struct genevehdr *)(skb->data + nhoff);
>  	gh_len = geneve_hlen(gh);
>  	type = gh->proto_type;
> -	geneve_opt_gro_hint_off(gh, &type, &gh_len);
> +	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);

Sashiko noted that `geneve_sk_gro_hint_off` could race with
geneve_quiesce() (and thus with geneve_unquiesce()): gro_complete could
observe a different hint status WRT the gro_receive step.

I think you additionally need to validate the inner(most) network header
offset as derived by `geneve_sk_gro_hint_off()` (i.e. gh_len + nhoff +
eventual mac presence) vs the one computed by gro_receive (that is:
NAPI_GRO_CB(skb)->inner_network_offset), and ev. error out in case of
mismatch.

/P


