Return-Path: <netdev+bounces-63001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4A082AB40
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6218BB233AA
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985511737;
	Thu, 11 Jan 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R2jrJVbE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/IsAC9Kk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R2jrJVbE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/IsAC9Kk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9811727
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7608522119;
	Thu, 11 Jan 2024 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704966587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JytHxARXy0r9VrhHqph8a4GdqTwaDDDxAgVQaMBuTQ4=;
	b=R2jrJVbE+hYRrLc1e0c34dvSLR4RlqXdXTf08LiHZlEtZQXI/Is/YmubIgvQwgAMtTa+wE
	L5f+UvGcZdbI5SGTCPrYYi2tMYrxJLbxaexAbQEtXde1oHtHu7O9Tgzd8K2hEP8aNiJi38
	65cSgb3ga7JyRdAHxylMf/Nqv/FIsu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704966587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JytHxARXy0r9VrhHqph8a4GdqTwaDDDxAgVQaMBuTQ4=;
	b=/IsAC9KkVMf67JJJMg26J7d0ihOpCcL86+VtmqGUpzheb1kNBf1VYyrxQkM49mFy+JQAib
	TkBUPn11BtVvP4DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704966587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JytHxARXy0r9VrhHqph8a4GdqTwaDDDxAgVQaMBuTQ4=;
	b=R2jrJVbE+hYRrLc1e0c34dvSLR4RlqXdXTf08LiHZlEtZQXI/Is/YmubIgvQwgAMtTa+wE
	L5f+UvGcZdbI5SGTCPrYYi2tMYrxJLbxaexAbQEtXde1oHtHu7O9Tgzd8K2hEP8aNiJi38
	65cSgb3ga7JyRdAHxylMf/Nqv/FIsu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704966587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JytHxARXy0r9VrhHqph8a4GdqTwaDDDxAgVQaMBuTQ4=;
	b=/IsAC9KkVMf67JJJMg26J7d0ihOpCcL86+VtmqGUpzheb1kNBf1VYyrxQkM49mFy+JQAib
	TkBUPn11BtVvP4DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CC587138E5;
	Thu, 11 Jan 2024 09:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /ALILm65n2VXMgAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Thu, 11 Jan 2024 09:48:30 +0000
Message-ID: <a0ae5d06-30d6-4a0c-b844-9dc34cf193e3@suse.de>
Date: Thu, 11 Jan 2024 12:49:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ifstat: Add NULL pointer check for argument of strdup()
Content-Language: en-US
To: Maks Mishin <maks.mishinfz@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20240110205252.20870-1-maks.mishinFZ@gmail.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240110205252.20870-1-maks.mishinFZ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.00)[27.16%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com,networkplumber.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO



On 1/10/24 23:52, Maks Mishin wrote:
> When calling a strdup() function its argument do not being checked
> for NULL pointer.
> Added NULL pointer checks in body of get_nlmsg_extended(), get_nlmsg() and
> load_raw_data() functions.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  misc/ifstat.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index f6f9ba50..ee301799 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -129,7 +129,12 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
>  		abort();
>  
>  	n->ifindex = ifsm->ifindex;
> -	n->name = strdup(ll_index_to_name(ifsm->ifindex));
> +	const char *name = ll_index_to_name(ifsm->ifindex);
> +
> +	if (name == NULL)
> +		return -1;
> +
> +	n->name = strdup(name);
>  
>  	if (sub_type == NO_SUB_TYPE) {
>  		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
> @@ -175,7 +180,12 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
>  	if (!n)
>  		abort();
>  	n->ifindex = ifi->ifi_index;
> -	n->name = strdup(RTA_DATA(tb[IFLA_IFNAME]));
> +	const char *name = RTA_DATA(tb[IFLA_IFNAME]);
> +
> +	if (name == NULL)
> +		return -1;
> +
> +	n->name = strdup(name);
>  	memcpy(&n->ival, RTA_DATA(tb[IFLA_STATS]), sizeof(n->ival));
>  	memset(&n->rate, 0, sizeof(n->rate));
>  	for (i = 0; i < MAXS; i++)

In the above cases it makes more sense to adjust errno to EINVAL in the case of the invalid argument
for strdup. 

> @@ -263,6 +273,9 @@ static void load_raw_table(FILE *fp)
>  			abort();
>  		*next++ = 0;
>  
> +		if (p == NULL)
> +			abort();
> +
>  		n->name = strdup(p);
>  		p = next;
>  

