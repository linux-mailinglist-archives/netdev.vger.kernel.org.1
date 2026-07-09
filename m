Return-Path: <netdev+bounces-306117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RL4sIm1tT2owggIAu9opvQ
	(envelope-from <netdev+bounces-306117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D536D72F146
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:44:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=BE0dkKZn;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306117-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306117-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89503303814F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316C3E3DAF;
	Thu,  9 Jul 2026 09:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7E3EB818
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:34:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589683; cv=none; b=LJaprddlw3sw0Nm3g33BBHjhAfJDT3QUycAi18az2M18O54XmKMU/eR7IcUKFBMcmjn4Eqp1aijemF4sLTgPScMMka6IyqGCRs8MPPLBcfji9ogKSTAMiPCW8Cw2zzTaFinEgMorhKnJd9s0+l1gPNblfgnzqY/lyjvxvSPvLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589683; c=relaxed/simple;
	bh=BGotsO+Xy3yZ58ijoTkhB5nFmmjexia5sAeBl48H7c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5vv+3pGoFVm6ryoNpWj68EEtKuZqvtjpJwIK6htE1kksZ3VX5FOuroF5fzL4W1BIZgtqpRdA6g87DgmVkXCUZsxlXTeO6wJsLkjkTycjKuCyLgzzsaWEeJzBEJt1ggcKMT2S74g/7DC0/43aBmc5uwgU9wWUwHlWpBrhcH1uTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BE0dkKZn; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b27c7451so8754055e9.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783589680; x=1784194480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uY49nb5pN+xm+mpr8Plpnx3+y2A04Mn/N8LUEgZX3IY=;
        b=BE0dkKZn2N1r8BGYFxT2uGucnDcCVJaRXTsyv20XMbkZQHgDlCrKb9NIN9Kyl+3goI
         hgZ1ZPuN55NH53P2OuAWHwINwTbdazWiMHerIo1cw3jAaHK7GS6Z6STyL2o1v85ri6/V
         LSHhRM2QlPCPtlLn7nNQhHMszXSuF4X5TcEHLlWvaPPtAZAwLiwz7vRDBmjShjV3CYBG
         jYE9dUtcm9gg2M/dkyhga8xCi6u58Rr6uUneu3iQoXskptfnMK4f7qbnEMm4696NBdfu
         9f7HrdyMfbYw6nssOa1vwGH10aeSi2onc7QWSngQde/ZYW+EQZB3zsyEVr3l168lCD9i
         dywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783589680; x=1784194480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uY49nb5pN+xm+mpr8Plpnx3+y2A04Mn/N8LUEgZX3IY=;
        b=CZD3/uL7isCTnj3Gns9ssSP1Coa5G8RTrefP/hK6HG/iEsCXB7jkdzKdk62nlgKeVv
         zVbqAj6qXBVhoM0nu4yvHYyLd9DlBo4xzNrjUVs2exqNsQ44eaxpK9h+h6nf2IaPXb2V
         T2jV5xPpzqcVvjjEpWtDdrHtqqPbofvyz3MmJkMOBDkZ1wUw7Ppjv4ux+dNgp0A1rk9a
         nBj5OPtKsMyuIOc6xcw0L5vpSIXnTnV8TBr/yeyIrPEKdpTePi6Qgnj4UFCiXh58v2Ue
         jkSj5L4XINIg4zQSBFtp0AdEjoACVLgsvbd8GobgbkcLXqTI39RGhOFpBvDZDf7btc6V
         Mp7w==
X-Forwarded-Encrypted: i=1; AHgh+Rp58eTg/Olz06JEPRqgsbV0vJ/vgyODHdggEoBPsYhl0/iPlVyudONq2JLLHdTCuFZeAedxug8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2NMMKeJX6bs6BrJXvWPEajJAVD2lTUX0Wc1IyPc6dLZU+i6O
	7CNbx7MG1tqPwHuqebV5jwX5nx/P5TBRjkVYVnvjb488BcAVReDuYUZy2gzO/rfcpK4=
X-Gm-Gg: AfdE7cnj7i5G8Du0VODVJ5YtupE/LvN4dTh2eIGT1e2NRC2jHl8mM5nOLq4cuiuqI+4
	dx4o43FGeS7oJXSAsHHX1QFE31T2f5KTvNF/WquUu6ZLYlQ1+gJOqhu6sTipxBsuDeYOfi3Bdas
	t2PedxpP1VVeRav+ximSbMl+rOg2AondTFsiAVaQTHs/DYj8pNiYbhdjGkWA/TmrmYIEvnGIgpO
	3oxGRARf7nEQvPJWijHXxT69LsZe1VFi8bBErFgc0cpqRQvbm15VZMfKr04gmPQQUZHzkTC7roU
	g2lvuoAY8eO1WEFJ++rN5fBnRIeZPxSOxu6WxOAWDKWnyLtk1zpp2pTUSFB/N8oEw5wyk0cBRZ9
	71UMFMb/ha2qldu1dvVRqoRxc5s8JOLZG7yhRy60XiiTYjBRofxSFxcXz1xSUsKWD79gQ24b+Lf
	t2nTC+iB9uxFiXOQ7Ls2ehE9sgGIRyfrXLRNIszS8oB87rC4wKrJXbqw==
X-Received: by 2002:a05:600c:22d2:b0:48a:5f32:62c6 with SMTP id 5b1f17b1804b1-493ec7754cemr14846825e9.11.1783589679980;
        Thu, 09 Jul 2026 02:34:39 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm47893706f8f.23.2026.07.09.02.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:34:39 -0700 (PDT)
Message-ID: <b0774436-bc41-462f-820b-6a037b6082bb@blackwall.org>
Date: Thu, 9 Jul 2026 12:34:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 0/7] netfilter: Add bridge-fastpath
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <ak4culZgTe8CNSva@chamomile>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ak4culZgTe8CNSva@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:ericwouds@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[netfilter.org,gmail.com];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,nwl.cc,nvidia.com,gmail.com,uwaterloo.ca,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:from_mime,blackwall.org:dkim,blackwall.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D536D72F146

On 08/07/2026 12:47, Pablo Neira Ayuso wrote:
> Hi Eric,
> 
> On Tue, Jul 07, 2026 at 11:10:38AM +0200, Eric Woudstra wrote:
>> This patchset makes it possible to set up a software fastpath between
>> bridged interfaces. One patch adds the flow rule for the hardware
>> fastpath. This creates the possibility to have a hardware offloaded
>> fastpath between bridged interfaces. More patches are added to solve
>> issues found with the existing code.
> 
> Thanks for your series.
> 
> I posted an alternative series, including one of your patches for the
> bridge vlan filtering support (which is still untested on my side):
> 
> https://lore.kernel.org/netfilter-devel/20260708093250.1187068-1-pablo@netfilter.org/T/#m270aedab59bf39f1bc4452d1d8d739a2b1b0bc45

Hi Pablo,
I think I haven't been CCed on that posting, can't find it in my inbox.
Anyway, I know I've acked the patch but taking a second look I think there might
be a problem, specifically at patch 01:

+	if (netif_is_bridge_port(ctx->dev)) {
+		struct net_device *br_dev;
+
+		br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+		if (!br_dev)
+			return -1;

-	br = netdev_priv(ctx->dev);
+		src = br_port_get_rcu(ctx->dev);
+		br = netdev_priv(br_dev);
+	} else {
+		src = NULL;
+		br = netdev_priv(ctx->dev);
+	}

If ndo_fill_forward_path can be called while a port is being removed from the
bridge, then we might reach this call and netif_is_bridge_port() can be false
since the flag is removed before the synchronize_net() done by rx handler
unregistering. Specifically if CONFIG_BRIDGE_VLAN_FILTERING is not defined
then the previous synchronize_net/rcu are not done and I think we can observe
a port which is being dismantled in ndo_fill_forward_path without the flag and
erroneously categorized as a bridge device. I think a safer and correct approach
would be to check if the device is a bridge master:
  } else if (netif_is_bridge_master(ctx->dev)) {
...

Cheers,
  Nik


