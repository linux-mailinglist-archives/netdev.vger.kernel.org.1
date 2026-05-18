Return-Path: <netdev+bounces-289027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OGDF8QCC2q3/QQAu9opvQ
	(envelope-from <netdev+bounces-289027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE256C653
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12AC300B1A2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6F3FE34D;
	Mon, 18 May 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="j0pL599a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01E3FDC10
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106462; cv=none; b=qV7WxYeGAWIjN9xJSMANdWiZuGP7uYkYp/ZZM1+q4Et7wHP1YpyXeEY9hq61bPs3bRWOoEUrSZFNd70czOzgrQv5amhoxVCUO0dpG6z71FELGPJVBYOrlZUGeNylMfNw+GHPiEwzzlOx7f3oAAVjr1KHgpoJkkMXB7k4OZKxQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106462; c=relaxed/simple;
	bh=/ZLcAi0NAsYNFT9QZfyzBs+pJ4BxC0yxZ/AaaalRjvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5YP8odpPJ/qExNCi43ugLTyUk10vJMa3+RlnbKyxfykfPqDhF1WoAL9+h08fFgg4TiWxGzIAwRf2o1FsPpmXH1gdoZO0QdRiZzzPmdtGcX8cD1WIbpLCKX5xogVQvmLdZXRxzmIbY3xngN5LXjTpVUpfSVl1dQJ31bbYktoxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=j0pL599a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48fde2f2d61so4251005e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779106459; x=1779711259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5AssGvWsP766p9mHWby5V0TDO49rQ+HM+32Gpbke/no=;
        b=j0pL599aKnjKCPc3GOaNHeCR1uuaOiAqE2o+j6ayKzDWYiJOP6Qt2PZiShgxd9FNQM
         jFO7WUlA16MW5kBrGQPOGIRbLqqHE5UK7e2Hlncv7SrtdvZoKHHgGoIxWfCtaZFLLbK5
         OMBDE0cYrzKpQI4bJ1bx28NTyD+m1H1n3rvM2MLsL3UnvBLtFc0e4QXyOvIrKi+nyQhx
         0ph5vcIqnYN2tsk51RIG10lOfspoAb42fH19iEqtivmt/xs9S3uHjU9f0BvKRxJonhmd
         c879QRVzBEUqtUdz2dw69vuwEUnBZetN9dN2gUxRponuCSVzE2/svYMlAdcE5g89Rwxv
         6Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106459; x=1779711259;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AssGvWsP766p9mHWby5V0TDO49rQ+HM+32Gpbke/no=;
        b=qEeTEi2A0eJ7iOdzYQX4YZoeSYHwREq++olX5ZK7lBwwcPWThJzWv1OPFUzAecrz/y
         dkYNNPsL8st4te6hfqDOo9tVJwidQ+GBA9WteMU4aUUjH3c9JXum3DFf2IsGbRgYjrek
         8n/vFl8Yd26M9STfHE7opfxZQzaSPf7jGDf7Dhrk+F5kkmGP71MS4Z2t91V1cwGXuL1V
         dc22euKfQby7O4Pdpt/IVxt7denUHn4YXpf3YGjt7VoGqLMw8nYb3TEgvbLvPOwdP0tK
         UkLK4rv9l+tuyi2BCqQnnnQMW2+EEjLrzom3pWJ8LdXGfIODJtTz7At2DadbEWL6s8RR
         g4qQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ubOW4KUCJGliCTLHw/5OwZ9kPTZ7ruxrY30mk32fDJZqXutf060naQdKBakxOFbYw3EevS1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Z7aR119AnEvXUiSnMs1Dr3pbBITWeyrngCzdKt5LuJV0bgVY
	/ueGmaXjT6o4G4htMj3WgZYci8rFQ5L8hT4ZN9FAw5yZB9AZ8CKSJNQ5GVbIjlSBgks=
X-Gm-Gg: Acq92OFLPK1n6nqIsnkB80bUO11tTPtXFksor7SDvR94ZORBuKHrQJ7kmagtt46GqQp
	mpGNYpT7Qx7fUtYOHre/0WJMD6ntUL9cNx4nzVvU9krl0zdUxoxspcnuBpdLSzjCDM58eFJwUuT
	wbykqbriRs1m7QOOxj9z9baJfU8JwLI9AaCZIBDB4B7HuVCIjhe6FZxqCb++pM/0TEmpsfW3ghx
	WH/nRH7SQ2uilbfOSBENkWzzfRGD1SOBZnfez8UBOGNvzfodZn+BXsILuDs3Hu+SM96o97NZLc4
	5ucztVd+weF7+AvEjwNV9K2CaJLko4G1aT42Mt0VnHonCm1GqRSNuWj+hFcewo5aWjM7ZyofMaj
	1/JeJDbOUMd/8U6Lg5ptysgPvGH30Qd2bPqFGeLTTv3U1zktt4ZA2QixswvQuc5yCBOlcvGxfs/
	TPhMI1Ng79GC7y7REx2pdYO4Lmg6XFOBW9yOXmpClkJHFp4GrIs8OnsxHgSaJYkVkqZXa9/QG5r
	aGS
X-Received: by 2002:a05:600c:1d0d:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-48fe59b071bmr112799545e9.0.1779106458820;
        Mon, 18 May 2026 05:14:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm258311125e9.0.2026.05.18.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:14:18 -0700 (PDT)
Message-ID: <40603dce-f801-42ad-96ec-c8c0a57e5aae@6wind.com>
Date: Mon, 18 May 2026 14:14:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 3/5] net: netlink: don't set nsid on local
 notifications
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-4-i.maximets@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260515201937.2813983-4-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CDE256C653
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289027-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com]
X-Rspamd-Action: no action

Le 15/05/2026 à 22:19, Ilya Maximets a écrit :
> For notifications with NETLINK_LISTEN_ALL_NSID the expected behavior
> is the following:
> 
> - if NSID is not reported, then the event is local to the listener.
> - if NSID is reported, then the event is remote, i.e., originated in
>   the provided namespace that is not the same as the listener's.
> 
> Userspace applications like ovs-vswitchd expect this behavior.  And
> ip monitor uses this logic for printing out [nsid current] vs [nsid N].
> 
> However, when a self-referential NSID is allocated for a namespace,
> every local notification starts sending this ID to userspace as part
> of NETLINK_LISTEN_ALL_NSID CMSG metadata.
> 
> This is problematic, because the listener cannot tell if those
> notifications are local or not anymore without making extra requests
> to figure out if the provided NSID is local or not.  The listener
> can also not figure out the local NSID beforehand as it can be
> allocated at any point in time by other processes.
> 
> The value is practically not useful, since it's the namespace's own
> ID that the application has to obtain from other sources in order to
> figure out if it's the same or not.  So, for the application it's
> just an extra busy work with no benefits.  Moreover, applications
> that do not know about this quirk may be mishandling notifications
> with NSID set as notifications from remote namespaces while they
> are actually local.  This is the case with ovs-vswitchd.
> 
> Having a self-referential NSID mapping is not something that happens
> under normal circumstances, but it can be a case in specific
> environments.  And it can be more common with certain container
> runtimes like LXC/LXD/Incus that unintentionally trigger allocation
> of the self-referential NSID via cross-namespace RTM_GETLINK requests.
It is easy to allocate a self-nsid:
$ ip netns attach current $$
$ ip netns set current auto
$ ip netns list-id
nsid 0 (iproute2 netns name: current)

An application should be prepared to handle this (it is easy for an app to get
the 'self-nsid' value).

> 
> A search though open-source projects doesn't reveal any projects
> that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
> self-referential NSIDs.  Quite the opposite, ovs-vswitchd relies
> on the metadata to not be present to separate local and remote
> events.  And the 'ip monitor' relies on the metadata to not be present
> to show '[nsid current]', though this is more like "print 'current'
> if there is nothing to print" situation, but still can be a little
> confusing for the user to see an ID for a local event.

We (6WIND) are using NETLINK_LISTEN_ALL_NSID. Like iproute2, 'current' is
assumed if there is no nsid, else the corresponding netns is checked (which may
match the current netns).

> 
> Fixes: 59324cf35aba ("netlink: allow to listen "all" netns")
> Reported-by: Matteo Perin <matteo.perin@canonical.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/netlink/af_netlink.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 2aeb0680807d6..607ab4e4ac697 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1482,9 +1482,11 @@ static void do_one_broadcast(struct sock *sk,
>  		p->skb2 = NULL;
>  		goto out;
>  	}
> -	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
> -	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
> -		NETLINK_CB(p->skb2).nsid_is_set = true;
> +	if (!net_eq(sock_net(sk), p->net)) {
> +		NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
> +		if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
> +			NETLINK_CB(p->skb2).nsid_is_set = true;
> +	}
>  	val = netlink_broadcast_deliver(sk, p->skb2);
>  	if (val < 0) {
>  		netlink_overrun(sk);


