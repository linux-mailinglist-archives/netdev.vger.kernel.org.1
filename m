Return-Path: <netdev+bounces-296164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fcE3CAeaJGrC9AEAu9opvQ
	(envelope-from <netdev+bounces-296164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 00:07:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E05764E731
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 00:07:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NxRGZRao;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296164-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 193133010929
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB1253B73;
	Sat,  6 Jun 2026 22:06:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155918871F
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 22:06:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783619; cv=none; b=AvQQ58jUVGdy6jnJQAUKdUC5UkT5Wf3Bncw6/jndgEMcRFlLgSYrfr5MZNn7ZlXVDMDVyzVpVTspPVFXmDVXyrp0Q/lGhCI9Dv9YQ9gEzusmA5PU+kdveE294eHMk5C2HTCbxrUrqo6p+XG+1lRjQDEEP9fGG3L/tDJTLtteM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783619; c=relaxed/simple;
	bh=j+6LupNriFFc/iwui+TNNQy4hJhOZ1Aymxa4sch3yOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOm6HuYqu1BRA/47cAiMqoq7H0QG1CeBZyaFdjXjL0Q23YJ1NhsxwnBFAw7NQGiluzQm7UMFNs9cnRrLl2d2KsdozsY4C9ebH/W/pjZJfmHfLxHT+4vXMHvzwHjL+C1z6gY9bb09Sjt+Y1wIaM3Xnzq2vM0pTNdgDWYJ2qhRtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxRGZRao; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1589542a91.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780783617; x=1781388417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1N0nYQpzkvCM1bmSlPcCRt+kTaQu8xIby854/Tpik0=;
        b=NxRGZRaoF0DJim91P1AvR+DJ3tzHu8eJ+isrz/iVkiPkdiwajJX8l28ntxm5w4jAgA
         EgLht+BI2wlov003heZQCELLDfHuMN6Iud2iqestsprASpWhUTWLDgLcmbXE7zS3EnRa
         KqxeuSdcHaN+1daR9u9rL2uUia6UL9QIACeFX78X1hzuZvb/6cNd6UiSk1vF02tTYi5z
         fAvZc0XGTw7wRe0N1GyZnCxmGxZndZopMNVFU1/Klok7MAIqGGv5RudnlgFPcpOGf1lR
         IDtbCqbSKp6wp8HiddOkQzmsQ60KyfIf4ViRilgTxBO6XOU3zdBzm+ofs4PP/aTuN8Mp
         IHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780783617; x=1781388417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1N0nYQpzkvCM1bmSlPcCRt+kTaQu8xIby854/Tpik0=;
        b=WQQbuH8t+ZffoQC08+XDBupSfrlHT/G966h+Ew4erk3lE24wc4wCSicCMP59XC4xNy
         AFwB6UQU4VUw6Bwbzzh0+L4levcltO9Cif+RpSVmXbME8rV3R2t/WqHU4VD9c86yOt9f
         4YO5Br9gsicYbDHvD56nhBT0FcSj+62xkgzfZg2TnLrPbrx+ARHdaAvXwGVgEK/r3i4B
         To/tkJcIsrhxGHqjTR87Sq+TO2jceu9pz5pNi6oKry9X/5QrKHZz1kdXwLMIt0sEVF7n
         E2AG4IZb15tDnXIT/HUC2nsBTVKfljQEoRvU48uqQMm5Srvw2E+SEmgN2R3nYmSc3cuy
         hqlw==
X-Forwarded-Encrypted: i=1; AFNElJ/BEYnR7w0/mpx4KAaLqL9fW+fyA2WVq4xVgBpqjxUmqYx7zv7jsCdvCUmF6ki+IAqX5WLud4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiOX2Vfx4MRnNXmCLjQQNt+Th55byakjwj0q0Pk9SUAjODUHK
	keYw1MLYMJgEWDFRBR23zhyf5+aKuf8q5Uttdn8fE4fPUyC2GZzHp3Eh
X-Gm-Gg: Acq92OGJNTwZKqxupW2r0YWpCZFEUwBpZgXbH6RBHDtB/fZadblUtdBR+J5WBhse0nn
	IrFQilmenaCogMl9a8+n7O8SBgyOy+74TC9g+g8Vh/ua62m18G7H/LSpD2aHLyn/OQHA639n01N
	QD9jvcCl3SZw3Nl02FXXeDfv6Nttf7xmbpAZY1W8v8ERJm2Jhwd6pn69pZ4+D9RuNRGs+fMRV/j
	ISFUjLUThwXhobVS51YlCup2aQvEyqZA1U1GBgTEvZR3C6hhyyQ6BKs51kO7w37ON9L3tvnQnNr
	rDZqOS6/3T3r+12z3jjUj80rBF2x7D/3Ihno4LUS58OKtIfuMzTaExmz5WorE2gAFDU9a4bEM8S
	72hkFXisO5IJ/vhuGAV0RwQmBRvzDt64p4fIXtbayai5RfF5Mvjef3aMUGoKplZlqsfkb36PC7H
	slMmSwOZdbnq11iq37sgf3zkj+TjoDDkBEiVs4KbMC6U7EgHohf8MZIVg=
X-Received: by 2002:a17:90b:2892:b0:36b:769c:c037 with SMTP id 98e67ed59e1d1-37130e4c27emr6938380a91.5.1780783617330;
        Sat, 06 Jun 2026 15:06:57 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e52b0sm11093675a91.15.2026.06.06.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 15:06:56 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:06:54 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Sashiko <sashiko-bot@kernel.org>, dw@davidwei.uk,
	daniel@iogearbox.net, razor@blackwall.org, sdf@fomichev.me,
	willemb@google.com, kaiyuanz@google.com
Subject: Re: [PATCH net] netdev: fix double-free in netdev_nl_bind_rx_doit()
Message-ID: <aiSZ/qitLjh4yb44@devvm29614.prn0.facebook.com>
References: <20260606012124.4060950-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606012124.4060950-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-296164-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:sashiko-bot@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:willemb@google.com,m:kaiyuanz@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E05764E731

On Fri, Jun 05, 2026 at 06:21:24PM -0700, Jakub Kicinski wrote:
> Sashiko flags that genlmsg_reply() always consumes the skb.
> The error path calls nlmsg_free(rsp) so we can't jump directly
> to it. Let's not unbind, just propagate the error to the user.
> This is the typical way of handling genlmsg_reply() failures.
> They shouldn't happen unless user does something silly like
> calling the kernel with an already-full rcvbuf.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: bobbyeshleman@gmail.com
> CC: dw@davidwei.uk
> CC: daniel@iogearbox.net
> CC: razor@blackwall.org
> CC: sdf@fomichev.me
> CC: willemb@google.com
> CC: kaiyuanz@google.com
> ---
>  net/core/netdev-genl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4d48f3672a5..11b0b91683d7 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1095,8 +1095,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	genlmsg_end(rsp, hdr);
>  
>  	err = genlmsg_reply(rsp, info);
> -	if (err)
> -		goto err_unbind;
>  
>  	bitmap_free(rxq_bitmap);
>  
> @@ -1104,7 +1102,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return 0;
> +	return err < 0 ? err : 0;
>  
>  err_unbind:
>  	net_devmem_unbind_dmabuf(binding);
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

