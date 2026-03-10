Return-Path: <netdev+bounces-266214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULJNBbQ0sGnRhAIAu9opvQ
	(envelope-from <netdev+bounces-266214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:11:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02F252FFA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 865773064AC1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A63101C0;
	Tue, 10 Mar 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neVo7mcU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BF30ACEE
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155338; cv=none; b=lSU/qwgMDz/IVw9yNseN7+7EbVXTdavdvzrCVdeDBg6ShjP7Miy4hIsXOoys3V8QHidtuTPXxIAd9yZv//Ie0E0xFmSzwErrXi4xv4PEli5iepEzE3aR8cmRC6jSCsgZdyb93YOz6NGTQ1R4LZ4ARCCIBeLL6H+QfE2RJL5mQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155338; c=relaxed/simple;
	bh=ZgD5MStF+xn1LMDxFS9O0OmQhAa39GXxTWNAUPE4uJk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mtHxvp2HP7cGG0fTMy/UTV4rhf0qgdI7FHDa5CD59w2f/rlHZdO3RLiXemtbFsx2trQFAEqWQvND8gmabIXyyIzLvtr0nsps1XcQ6JmgQqqOtHWTKsM9YsOxr6pZHLPwpyDAj21x+Lzs8CPa0AOJjjTmNKPJfdk2xLPwl5cqkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neVo7mcU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb5c9ba82bso2070870085a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773155336; x=1773760136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I+M+DGV2i7zEMUOxNzxG/k9Qg2/2QSO8OMx1QsElDM4=;
        b=neVo7mcUDeXZ/Et/YUC/Ns8nEkhOcF9Nt9h6awZ0eUFf/a/bx4IfApmkOUPb08n36j
         RObjWE4w5SGkMJUbW6bUFmKjlO3MklzrWlWMAh/BbLjrh83yRbpUEC9dbzYiejfM0NhO
         aIBPrwq8Zxa/WzNQkdtbARFWaG6vVcReTTyxAdYFSSs07nsNue74shsl0Uhm1bm9+2tM
         yuTfBPWDpGZxHV3Tn6ZVvTmAK8SKiKEQ0eZWeR8Epf6tkHB18TZgEtDSibJhZpooTpe/
         C4pLUTlZ+WyDUTFtM6krmSk+TNtlonQ6CMyWyFz9IAJnKLuUZ0IFZNNDeBRwpc9o/dRY
         wG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155336; x=1773760136;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+M+DGV2i7zEMUOxNzxG/k9Qg2/2QSO8OMx1QsElDM4=;
        b=f2GWM1s33YMYp77GJMVEuq2y16uqrBkNg3LdroqnSpbpWFMEu2XZ7m5xd6Mv1AHfhc
         yklxrg6I49xlhtWZuCQZdhRvxo6pJZTt4U0Sv+QoKG4Q5nnLAXDpC59D4IstyVaMHpSy
         WxO73B5auAg0R4DKkWjfEFVc78w6apYBx1cE2W6nV+iReUo0jjbTcP0iJqSH8tyvfLiq
         Lm+PnuKtszMnzAHc/9jD/iCSXmjEL8hsY4tWNUaLPuQaLKcAnJMX+zeA9lWZy6Ax5N8Y
         ou23sLvKXVicBYIlEOpltBTVlIuqMnC24FCtQoGx8hzzvW/iApnF1JV82wvtmIgbe9Ti
         vwAA==
X-Forwarded-Encrypted: i=1; AJvYcCXi76w2cj+Jre62Iu6W8zQH5d5fH118JlqNmz467uUydiiUhE9KutcjGKHM7LPBrwV11kyxKbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJuhI3l+rqHxYtHw6prUxx+FDG1ZLHQBYHvp9CyLnRU8b3M0t
	cqlA4Gz8YvyywUq+QQ6EdZeOttuzAyTk/Fymp7/Uw/cPhUOw6kJXv9QLYsqv3g==
X-Gm-Gg: ATEYQzx+ue67lTs2PwQKe+vphj7I1ZCAOdZ0bLEe4oicWj5LtXN9QMSOzRH7jdIJYKE
	f/0cxNH/iUhxkXMsqdpJCAuO29rujoLUriCjRB7iCWRo94udvrFannt/PHtAW6jfq13uSzwI2h9
	td4o5kkpGINWV9z/bTdlkhDwzeTCzTF+jEfCs6u+mQgNLgzaJsoCDAsCN9lVQ+r3N5zYL2kNgK/
	GcNkk00J2vtOrxsBGMPe81J0UojmBOF/9aZ0hGbNXQruRd5k8nB0G9A7CIyVXkDLLbp/33wPwTN
	ocgPXm87sq677B29nCfkWrQ4xJFgS/6E7M83qNL43NXCxBh83tNjkMDQ0cDXTmQyxTjJekA2YCD
	k74FU4IBUaWwp5bEQF52GIa0EoBooAeAfPa9eqlr42e4sraeFIp9BcbEcYA4dCztqCKret3ddi5
	v5IjkFnAObV7uOveuFMmrdQxIwSgIlFR2usF2A6vWRo2QT4k863G21wD2MNxbwfNw4HA==
X-Received: by 2002:ac8:5787:0:b0:509:2579:283e with SMTP id d75a77b69052e-50925792a15mr52058371cf.28.1773155336179;
        Tue, 10 Mar 2026 08:08:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:3c5c:86e0:6cbd:e5d8? ([2620:10d:c091:500::1:4b47])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c2c482sm20643576d6.42.2026.03.10.08.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:08:55 -0700 (PDT)
Message-ID: <9b7c4207-1bdd-4d56-a3fe-ea3e25e62559@gmail.com>
Date: Tue, 10 Mar 2026 11:08:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-3-weibunny.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20260309183454.2872967-3-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA02F252FFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266214-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/9/26 2:34 PM, Wei Wang wrote:
> @@ -131,8 +263,7 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
>   	struct genl_info info;
>   	struct sk_buff *ntf;
>   
> -	if (!genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev),
> -				PSP_NLGRP_MGMT))
> +	if (!psp_nl_has_listeners_any_ns(psd, PSP_NLGRP_MGMT))
>   		return;
>   
>   	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> @@ -140,13 +271,13 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd)
>   		return;
>   
>   	genl_info_init_ntf(&info, &psp_nl_family, cmd);
> +	genl_info_net_set(&info, dev_net(psd->main_netdev));
>   	if (psp_nl_dev_fill(psd, ntf, &info)) {
>   		nlmsg_free(ntf);
>   		return;
>   	}
>   
> -	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
> -				0, PSP_NLGRP_MGMT, GFP_KERNEL);
> +	psp_nl_multicast_all_ns(psd, ntf, PSP_NLGRP_MGMT);
>   }

I don't think this will work correctly when there are listeners outside 
of dev_net(psd->main_netdev). psp_nl_dev_fill() will prepare a 
notification containing the unfiltered assoc list, but then that will be 
broadcast out to all listeners regardless of netns, so those listeners 
will see peer nsids relative to a different netns.

