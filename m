Return-Path: <netdev+bounces-305070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V5grFgXOS2pragEAu9opvQ
	(envelope-from <netdev+bounces-305070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:47:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A2712C93
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:47:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F4dt0qQZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305070-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305070-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A90333FB941
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED207305682;
	Mon,  6 Jul 2026 13:46:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290F30DEB2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:46:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345603; cv=none; b=PHjnbJeMTVDntflmYxHYMkuocLeGqwpmp3g4GsMWaQ+00dHlfXvPTgzCmF33JgBicsr+QgCwYYemJet+hDV1/Voq71twdkBPy/9In6Nb5K18vEq3m9NEGYkbRlvuek4MydrhLNZ7wTi9bnapRWPN+1Zp2gli1hO3W18i80h9sUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345603; c=relaxed/simple;
	bh=TUmRlO+AbpgAfi9o5IOSVpzcEDMF68wOS3eK2ACYgWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMCEElaPZPPRblP7h/5YPL1PDA0q419ILnofGuR4KhAx1qN6bJFAzMykgGuysGKQBtmOKTVMY1/hVTSqO+axm2sb+bDU44NLMyqvjbugEswDv/c1XrtfLyMINSpCDOB904wzX1bF2UTRe2e8HBzQjQEXd6C/qYZXJZws3YeyMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4dt0qQZ; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0c68aa31so18179051cf.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345601; x=1783950401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCa1Sw7nmZcTObya2YqeINBUf27MeVq0Ha0ay3otiUE=;
        b=F4dt0qQZx6AzySqFZX8pYqxXei4yPUN9ZIy52RJNkM4fOxb1tgzKztTxNXEhGeSNG+
         MLF7ctKv7TybHQA5lCdqbYU9kg/5M6ZgkAmzTF1sEAuCEYdQ5wyryngj2pIhOsg5lkxu
         oOhQRq7N4dyx3gff4PjWzVYBDEv2aAvm0UNBKtttOrPaFdgg00vrIuAks2gHt26mSxue
         tjNv5T29ccVyEOYhjTmTomdHzOu8orZQmtObZDTg8tOstAGpyVRfTNitF2NNyITqEIRM
         /vw9o04Mt5scULTFnra4DqaDbVA6t364uH8OS4dteO5/hLuX+xK9R1LJ2GPAXOC2LSln
         rY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345601; x=1783950401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCa1Sw7nmZcTObya2YqeINBUf27MeVq0Ha0ay3otiUE=;
        b=NbaFGzVpHoDEW2wYIx9BQcRJK6eaDXdYqTuhZa9a6ikLcFSWhreO0GjGBz9JLan6k6
         ZX9U2Id7evQJaQJObHVOGsCxylk217i3Ggvt0w+1/v9cINGUZ8FxC5GEmbmcgIxTqMVZ
         BEDDma95x8fKle+pxIFgqBZbppod5JH0JUlHXCcOVSjL/LM1B/AU8oXHZ17oR7X51mn4
         PkhjYwhshSwJO3EXPgsHUReQjLAAF1zks/KM5XDC/LoDLUVUeFlV4Zx+5kZbEvRncHKS
         rM8iNZV+cpzp7C7mBzW+nyA1HFBlOdalpg3GLo8IqfmNH5Lzqg/Kr1j4G9ycQkQZEfAg
         CTFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBGZZU4fagm+01EHUQae4ZYiaG12T6PNYyXKVo+hnKZOO7tke6CK17DDxIHZPK4KuKp4HeiUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+RG4yBrPluVdf66HcZDiyWpnNCUwifTrySTsrIeQh+MXk+U8
	PP23SjHrSCBG3+sQQ2EQ3/WrIpeiNJ2GCQEGRgybxkbHBsQSbb+Qqgl2
X-Gm-Gg: AfdE7cnUs1sKiB3mWjZ2xwFUoKdFfsyKJliQh/8X3glv4o65jGcv7IY5p/22Av6WLLl
	JppYP93mzxxZcONFwp2ZCMbBKZcjCctrcHIPiPOVPCCIeHWfu3wpOPRL1cAr+sacHeKL4cwArbD
	Xdt4OR88JtjGLhKcwi62dsf0jpBPvo2yxArhwjVgVVxl/nQD/ZgSZcl1AEEPzhl8zYCaFc24cy0
	CGzNEvYAO9jo/JgfEdzJcWkH3g6cIuzqknwylZpTffpwbpyRyxN0Vd6PYjNBojzSNprYbS9kxSu
	5vqrzwgGdU7gPBP/TN1WjNCZezUE2aXhF4e7RVptbVfNgvzWc3AOq0N4uQzAWcgMdzUTIZDP4Om
	hqTgsOZBGQY82rQEqPrvR3MEUDklBL14MmhWrOZjIvFlD5qMYbPdZGCFlyR1Tr+Hok3XCx98I06
	Y2hEYW95yx8tGe1oFogsyfn935Wg==
X-Received: by 2002:ac8:5953:0:b0:51c:167d:b345 with SMTP id d75a77b69052e-51c747a1330mr6801971cf.24.1783345601043;
        Mon, 06 Jul 2026 06:46:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c9::1088? ([2620:10d:c091:400::5:30c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2cf18sm98895181cf.14.2026.07.06.06.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:46:40 -0700 (PDT)
Message-ID: <c2f1e433-99bf-4712-a31b-6b2360f8fb6e@gmail.com>
Date: Mon, 6 Jul 2026 09:46:39 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] psp: fix NULL genl_sock deref race with concurrent
 netns teardown
To: Kiran Kella <kiran.kella@broadcom.com>, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, weibunny@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>
References: <20260703112431.2860506-1-kiran.kella@broadcom.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260703112431.2860506-1-kiran.kella@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kiran.kella@broadcom.com,m:kuba@kernel.org,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jayakrishnan.udayavarma@broadcom.com,m:ajit.khaparde@broadcom.com,m:akhilesh.samineni@broadcom.com,m:vikas.gupta@broadcom.com,m:bhargava.marreddy@broadcom.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[broadcom.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 890A2712C93


On 7/3/26 7:24 AM, Kiran Kella wrote:
> The race occurs between network namespace removal and PSP device
> unregistration.  When a netns is deleted while a PSP device associated
> with that netns is concurrently being removed, psp_dev_unregister()
> triggers psp_nl_notify_dev() to send a device change notification.
> Concurrently, cleanup_net() running in the netns workqueue calls
> genl_pernet_exit(), which sets net->genl_sock to NULL. If
> genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
> then dereference the NULL socket and crash:
>
> CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
> ======================       =============================
> cleanup_net [workqueue]
>    genl_pernet_exit()         psp_dev_unregister()
>      net->genl_sock = NULL      psp_nl_notify_dev()
>                                   psp_nl_multicast_per_ns()
>                                     build_ntf()
>                                       -> netlink_has_listeners(NULL)
>                                       /* crash */
>                                     genlmsg_multicast_netns()
>                                       -> nlmsg_multicast_filtered(NULL)
>                                       /* crash */
>
> Both the main_net path (derived from psd->main_netdev) and each
> assoc_net entry in psd->assoc_dev_list are affected.
>
> Fix by replacing the bare dev_net() calls with maybe_get_net().
> maybe_get_net() returns NULL if the namespace is already dying.
> Holding the reference ensures genl_sock remains valid across both the
> build_ntf() and genlmsg_multicast_netns() calls.
>
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
> Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>


Thanks. I was able to repro myself by inserting a delay after the old:

main_net = dev_net(psd->main_netdev);

and then executing nsim_psp_rereg_write() in parallel with destroying 
the netns that I placed a netdevsim dev into.

Tested-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

> ---
>   net/psp/psp_nl.c | 33 +++++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 9610d8c456ff..24ab626a9e8a 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -62,36 +62,45 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
>   	struct net *main_net;
>   	struct sk_buff *ntf;
>   
> -	main_net = dev_net(psd->main_netdev);
> +	main_net = maybe_get_net(dev_net(psd->main_netdev));
> +	if (!main_net)
> +		return;
> +
>   	xa_init(&sent_nets);
>   
>   	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
>   		struct net *assoc_net = dev_net(entry->assoc_dev);
> +		struct net *net;
>   		int ret;
>   
>   		if (net_eq(assoc_net, main_net))
>   			continue;
>   
> -		ret = xa_insert(&sent_nets, (unsigned long)assoc_net, assoc_net,
> -				GFP_KERNEL);
> -		if (ret == -EBUSY)
> +		net = maybe_get_net(assoc_net);
> +		if (!net)
>   			continue;
>   
> -		ntf = build_ntf(psd, assoc_net, ctx);
> -		if (!ntf)
> +		ret = xa_insert(&sent_nets, (unsigned long)assoc_net, assoc_net,
> +				GFP_KERNEL);
> +		if (ret == -EBUSY) {
> +			put_net(net);
>   			continue;
> +		}
>   
> -		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
> -					group, GFP_KERNEL);
> +		ntf = build_ntf(psd, net, ctx);
> +		if (ntf)
> +			genlmsg_multicast_netns(&psp_nl_family, net, ntf, 0,
> +						group, GFP_KERNEL);
> +		put_net(net);
>   	}

some optional nits if you wanted to respin:

You could eliminate the extra struct net *net, by just doing something 
like if (!maybe_get_net(assoc_net)) directly.

You could get away with a single put_net(net); call site, if you reorder 
the ops that could fail so that maybe_get_net(assoc_net) happens last 
before the build_ntf(psd, net, ctx)

>   	xa_destroy(&sent_nets);
>   
>   	/* Send to main device netns */
>   	ntf = build_ntf(psd, main_net, ctx);
> -	if (!ntf)
> -		return;
> -	genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> -				GFP_KERNEL);
> +	if (ntf)
> +		genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> +					GFP_KERNEL);
> +	put_net(main_net);
>   }
>   
>   static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct net *net,

