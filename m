Return-Path: <netdev+bounces-302353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WvZXEcU9QGoieAkAu9opvQ
	(envelope-from <netdev+bounces-302353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:16:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB656D2B03
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:16:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OhMpEmYO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302353-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 953703011783
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7D37FF46;
	Sat, 27 Jun 2026 21:16:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451262F3C37
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 21:16:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595008; cv=none; b=RQZUuwA6krNd8OC515Hon6AHqbPOPoYNsi5iEh0bp9w7Ao5QSCWGycYwZaeAhuzwt9XyO48eT72v8uJqIT0hKmb3FOWsiEMvuiydoZ0uiW/BECbT1Xx/jq44Z0CTbSTMFC8BLu2IRiliYCDyb26+94SuL6senCarYPHOB6rR2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595008; c=relaxed/simple;
	bh=3rGpUDw+ddrLG9sPceYY9ObkHQDjG5NTyD2hYg6jTzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1e67u9dAuOSyYuip8FuWgbotvnfNjSOS0AhTSmNjzEVD3tdPZpLJvCub/uRyt/1R/sUXRP1cLai5ii3Sz+hpy66Dsu14MuhCXSGPWA/x+RVdJ04K7Aqcl7uVb1QXpbszhk7UQgKK5C6tSSEChDeKEdL5FjJqxe2M5Q8g5CtZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhMpEmYO; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so15027675e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782595006; x=1783199806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s95FZx2QU/TjB5YrTYRCYxYo5MNS6NGrQ65w/N+79gc=;
        b=OhMpEmYO+A/1GPGrZ+Qmas4EUBsssEKbaynAB+sN/nVUzlVlzAhH3wMPUZOgPgrw74
         +FwC5zG6rTOaKpovy0oLxDaAlDm9/taG5HPoeRBjHXjSNmCGkbTv6UVB4AD3EGQ3kdzD
         vtJBCcYnLqb7kt94opUwU8UAusyX9jyKUg9JeMGSDe3S77JmV+fZDOoYbAYddZ68rbsg
         uWvkekzl/yC/pIIWzPPpiWhscudAIITxDR7ho6Jm6GjkN10M2cWyOi+RzrC6klrW2JYm
         OgA1fR8Goifx1dvvFKiicgcEqpNamfbPz6eB5jNHUYvi1WtRxiQYIqBDZ/nDxo3aM70P
         7DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782595006; x=1783199806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s95FZx2QU/TjB5YrTYRCYxYo5MNS6NGrQ65w/N+79gc=;
        b=DSc8/BSUK8pFNFrjSz+HGnq+T2LVcTyIHDpzTyxSPvA2YIdIbRyC0DlJslLVqJtu4R
         7w7zKFmoQtEFCjuZbVbQFthNI+GGCt7I7l1g779ojAV+wvFGCzYe/H0TFu7qlv3pPlUj
         6PgaZfS29tZnXwnkJmUzJUng5xFnhCgIwb6WdrnlXR7jd8+U6pXiHCUCz8mGILmGGxlJ
         r+PlbJg6xUrWIPPdneVBZFu9gpfTrT1FHWeWxQJCYQCLRhy9UOOVpG37qxLyvUHi6Ge4
         31d+EyFFYlv4oANVko84jSH/jdwZjvPgBdpyl77J1QFEgd0AQH+D7f1LBARg6pdwtlA9
         37BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fJOtI/C46ZXJ/jrZJLHTofLuerSCf95EtRP0VHWJ6sgkW994YNoqkS3Wpju3r/9ZYDC9VxLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7U4b6ZcXQGZXelaWOGx98vA/X0fGw+wcPosESv731R0Y9Edi
	dbpdKXb/pRObq0TqopAVy497Rj79+Inx1Q8FOYVchhpPeUCDD7GbXBMN
X-Gm-Gg: AfdE7clU9cOm6rxro6fBK5H8EocKdh6MFOxKE6Y+wlqg+CYYjMBD2ms0oimfv1ALG7O
	p4ihqZJoMyv8tcor0Stpq2NylTpWmQPAzTiaCjuBCmxMwmjU/ikCoXSWQlQhWpGJSDwhp8QWJYY
	Ve4fzDpbyJBHYCsuApI7P7wAgPVWO2rp/VlS3/KqKJDwn/6gOw2l8ygm8S3/X85ZhHziQ8qy5Uo
	Cd79hBdzXTw9W1OtqOQJBuiFpdsL82YeHAo5dC9W+lnQojBfnu7MOuE4I0xjhYnlCcRZ+QnD+uo
	kxAqM6ufyThK8lvJz+/8aOwmWXJ5GqQlCATBVtOrhYjXW1HKWoZHUHFjytxJep3FaWxjPhvCw/w
	llki1x0st17V+jqN2Pq7fcIfJXxguquH2YXwaVt0pTFeQKcF3NXrHg4hBonGxHDsFocwg27nH1T
	DX/F0ABiSRq7Odu8RBg+DPMxpNm8LrXgJkTeddhbeGOoLg4Q==
X-Received: by 2002:a05:600c:6215:b0:492:463c:48b7 with SMTP id 5b1f17b1804b1-492668985c2mr157854005e9.22.1782595005526;
        Sat, 27 Jun 2026 14:16:45 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071d05sm193434745e9.11.2026.06.27.14.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:16:45 -0700 (PDT)
Date: Sat, 27 Jun 2026 22:16:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal
 <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfilter: x_tables: replace strlcat() with snprintf()
Message-ID: <20260627221643.1e837496@pumpkin>
In-Reply-To: <aj78X4Cjqcpbb8Co@dev>
References: <aj78X4Cjqcpbb8Co@dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:icb@fastmail.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABB656D2B03

On Fri, 26 Jun 2026 17:25:35 -0500
Ian Bridges <icb@fastmail.org> wrote:

> In preparation for removing the deprecated strlcat() API[1], replace the
> strscpy()/strlcat() pairs in xt_proto_init() and xt_proto_fini() with
> snprintf(), which builds each /proc file name in a single call.
> 
> Each name is "<prefix><suffix>", where <prefix> is the address-family
> string xt_prefix[af] and <suffix> is one of the FORMAT_TABLES,
> FORMAT_MATCHES or FORMAT_TARGETS literals. snprintf() with a "%s%s"
> format produces the same NUL-terminated, length-bounded string as the
> strscpy()/strlcat() chain it replaces, so the proc entry names are
> unchanged.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
>  net/netfilter/x_tables.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
> index 4e6708c23922..56f4546be336 100644
> --- a/net/netfilter/x_tables.c
> +++ b/net/netfilter/x_tables.c
> @@ -2033,8 +2033,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
>  	root_uid = make_kuid(net->user_ns, 0);
>  	root_gid = make_kgid(net->user_ns, 0);
>  
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_TABLES, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TABLES);

If you are going to use snprintf either paste the strings together:
	snprintf(buf, sizeof(buf), "%s" FORMAT_TABLES, xt_prefix[af]);
or prepend the "%s" onto the #define of FORMAT_TABLES itself:
	snprintf(buf, sizeof(buf), FORMAT_TABLES, xt_prefix[af]);

FORMAT_TABLES should also be FORMAT_NAMES.

-- David

>  	proc = proc_create_net_data(buf, 0440, net->proc_net, &xt_table_seq_ops,
>  			sizeof(struct seq_net_private),
>  			(void *)(unsigned long)af);
> @@ -2043,8 +2042,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
>  	if (uid_valid(root_uid) && gid_valid(root_gid))
>  		proc_set_user(proc, root_uid, root_gid);
>  
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_MATCHES);
>  	proc = proc_create_seq_private(buf, 0440, net->proc_net,
>  			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
>  			(void *)(unsigned long)af);
> @@ -2053,8 +2051,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
>  	if (uid_valid(root_uid) && gid_valid(root_gid))
>  		proc_set_user(proc, root_uid, root_gid);
>  
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TARGETS);
>  	proc = proc_create_seq_private(buf, 0440, net->proc_net,
>  			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
>  			 (void *)(unsigned long)af);
> @@ -2068,13 +2065,11 @@ int xt_proto_init(struct net *net, u_int8_t af)
>  
>  #ifdef CONFIG_PROC_FS
>  out_remove_matches:
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_MATCHES);
>  	remove_proc_entry(buf, net->proc_net);
>  
>  out_remove_tables:
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_TABLES, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TABLES);
>  	remove_proc_entry(buf, net->proc_net);
>  out:
>  	return -1;
> @@ -2087,16 +2082,13 @@ void xt_proto_fini(struct net *net, u_int8_t af)
>  #ifdef CONFIG_PROC_FS
>  	char buf[XT_FUNCTION_MAXNAMELEN];
>  
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_TABLES, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TABLES);
>  	remove_proc_entry(buf, net->proc_net);
>  
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TARGETS);
>  	remove_proc_entry(buf, net->proc_net);
>  
> -	strscpy(buf, xt_prefix[af], sizeof(buf));
> -	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_MATCHES);
>  	remove_proc_entry(buf, net->proc_net);
>  #endif /*CONFIG_PROC_FS*/
>  }


