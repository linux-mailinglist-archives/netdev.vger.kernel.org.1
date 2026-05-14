Return-Path: <netdev+bounces-287929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEOhLE2sBWrHZgIAu9opvQ
	(envelope-from <netdev+bounces-287929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:04:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B3540C03
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C12DA3003BE4
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A93A7588;
	Thu, 14 May 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvYzigWJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="suo/og8l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C318EB0
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756371; cv=none; b=oGkZHQvRqzeAOBcqPiBEYJZVdjoUBt7PH9D23x6RN2zNruqZitP7Wv22TIlKSvCTPqa2GASFZ/J7Jenuu0rcQ52A9pzJnKumB8NX0qeFuniaGoUb9j0LwLJseau5k+NmH+CDoA6ltCIkz7DVGe5j7+TR2rmIhJI2U5swYeoVSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756371; c=relaxed/simple;
	bh=+mUnVQylUsDcmls59bbfiO0X1W5hSrNZLgtjUmSZ+zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CagbjV+wHZjjmFbV3Y2N+bSjuFMopLszYxBR02SLF6tABSSbU2HGM+LI6xXATmSHVA9MngN60OBmvI2KfTQQzfi1qZLESOFi67CNMfC6B4L9fl4UxtcRUV+QoiFGK0ZFl7CAq8KGCnPjbEtuAEBZhiSpvellaBRjjIXQh4uyEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvYzigWJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=suo/og8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778756369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udt7N9vsXQlnId0Awve0KX4MLn70Hej/jGjPBdK6ljQ=;
	b=UvYzigWJtvfXBpoulxzgagYD3LdJJ3Pg7Wjsz0tMam+TWwjzdxLiZ8jywt7Qpui7W6gpvC
	He5ZZUJ5UAZIBwM8Fba0zFrnntyZJFz3tSDYj6frSCjFTLmGR6sch4LfGmdNlvQuvxjTsd
	S+iECKjM+jiQp2aITURBgM2Hvt/h8uY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-1Sl21YuNOtqbHAXP0eF8eA-1; Thu, 14 May 2026 06:59:28 -0400
X-MC-Unique: 1Sl21YuNOtqbHAXP0eF8eA-1
X-Mimecast-MFC-AGG-ID: 1Sl21YuNOtqbHAXP0eF8eA_1778756367
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b941d4b7f2cso763693066b.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778756367; x=1779361167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udt7N9vsXQlnId0Awve0KX4MLn70Hej/jGjPBdK6ljQ=;
        b=suo/og8l5OyTy1fWy74zzkBNmBU0i/6aTdTSy5UqDdIh6VDFz0W5P5V1M0G3pXk0yV
         4Rwrr5IuVdXo20uTtBnJnWijUy8T3S7MDbCsQR2Hg3gPnaGZIEDC3bB7cAT/u0lwVHds
         e1UgkBXOPXAlvaKbUeePb+OGYXl8eW5AfvhGC2xCyLH+25nxVrZXNtRX6G/uhwNLE+go
         OW5aynFSlKHxFTwSwNmaf8re+6RomngHj/V5go8cvlmzW9ZgwdROZcwrSFreUsVM1Pdv
         igpVIj4nMJ0AbGLsKb5sEMyif8BXggfZx68tvqwLZFWvCfX1jp/nahBm+HpLndzj53OD
         4Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756367; x=1779361167;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udt7N9vsXQlnId0Awve0KX4MLn70Hej/jGjPBdK6ljQ=;
        b=VLKK2+4NV5H1Xqyd6jTOUeNQhe1ivfdl1D41rqEMEtzrHWe4Fm+cZJml6210T7ed3Z
         Ie3D2RPPQaRDRPmBvxCdaswj79JI4Gby1AKUd6+KCItpixZuqEDbm13//NMsGlwHpKxe
         vpVkl0TfiytNTLTUH3eQH8RXrmqooVH/DwqSTC2lfmgtszjL1NUWNZo4q6VkzwrOlH9d
         hB8u2ngA33RCy0c7zC8Y0+UcdD3xTYNreF68hPv2ZFyrEyEgxun8noA44GISo/dkU74p
         w6Hxn9+KvNRRh1NLmXeAAKT9uVSBBECHT4qK+/6MWkzQibFRYzo7W4EkxUy0r9BE/1JP
         q4tQ==
X-Gm-Message-State: AOJu0YzGykPHAUUtvO8dK/O+2RYPTuXiHOxyu9vC2iIFA/P2r/axpMNY
	ildeHrrwngSSsLeMPAq0N4fT9SHnQcGJWHA+Qm/aZcs3ge+aVoNo9T9p81SIAYoSTFNyUbnzAg/
	pKg7/2RU5Ac+PhZJ3nhJDgzzzYF1mAgq2BDHM4K3pKQIU7mPDMfyEXUqIzA==
X-Gm-Gg: Acq92OGw4Mdoxqg+nxhm+Yx7NfAJNP8PuGLppNSeLTAthWVQLIeKR4U0XxzF7r2i7Fy
	ztV4XQVq+ixX76Ec/c47U1au5IJJoOk7h2PA7y39iE1dgfTd2V457ZHy5R1VwzHT/n5g/qhGzCx
	5cnPs7u+vHKcsU14hNl1I8iR3tWh3BJdkwlmCSlHCQBoFc4s8oLl16GAHAljVWZ+acpoyOlmU/k
	K/LhdGs5Z6U/D+pKvbeAbkxJI8REEyajqrBWAUZNdopEpMdFvSc0ToQn2WEsG11cZakPkfza5td
	jXcZTYtliLORQMAaCF9jCbOhthDOn2ZzX3FWr6OEqEoxUaHcQ1p5ORmp5utnS6p+ULL+HqY4VuB
	AQWZ0h1bnkCNut5L7WIk3aHx1YA9n9mi323zzgo3ClbyFrD9nOLsNXSQ=
X-Received: by 2002:a17:907:86a0:b0:bd4:3df7:3791 with SMTP id a640c23a62f3a-bd43df7571emr431254966b.14.1778756366670;
        Thu, 14 May 2026 03:59:26 -0700 (PDT)
X-Received: by 2002:a17:907:86a0:b0:bd4:3df7:3791 with SMTP id a640c23a62f3a-bd43df7571emr431252266b.14.1778756366139;
        Thu, 14 May 2026 03:59:26 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e6d1sm617415a12.5.2026.05.14.03.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:59:24 -0700 (PDT)
Message-ID: <eb06cfd2-6ee4-475d-bafd-9331b879692e@redhat.com>
Date: Thu, 14 May 2026 12:59:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: qualcomm: rmnet: fix endpoint use-after-free in
 rmnet_dellink()
To: Weiming Shi <bestswngs@gmail.com>,
 Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260511120015.2298403-4-bestswngs@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511120015.2298403-4-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B05B3540C03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-287929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.155];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Action: no action

On 5/11/26 2:00 PM, Weiming Shi wrote:
> From: Security Analysis <xmei5@asu.edu>
> 
> rmnet_dellink() removes the endpoint from the hash table with
> hlist_del_init_rcu() and then immediately frees it with kfree(). However,
> RCU readers on the receive path (rmnet_rx_handler ->
> __rmnet_map_ingress_handler) may still hold a reference to the endpoint and
> dereference ep->egress_dev after the memory has been freed. The endpoint is
> a kmalloc-32 object, and the stale read at offset 8 corresponds to the
> egress_dev pointer.
> 
>   BUG: unable to handle page fault for address: ffffffffde942eef
>   Oops: 0002 [#1] SMP NOPTI
>   CPU: 1 UID: 0 PID: 137 Comm: poc_write Not tainted 7.0.0+ #4 PREEMPTLAZY
>   RIP: 0010:rmnet_vnd_rx_fixup (rmnet_vnd.c:27)
>   Call Trace:
>    <TASK>
>    __rmnet_map_ingress_handler (rmnet_handlers.c:48 rmnet_handlers.c:101)
>    rmnet_rx_handler (rmnet_handlers.c:129 rmnet_handlers.c:235)
>    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6096)
>    __netif_receive_skb_one_core (net/core/dev.c:6208)
>    netif_receive_skb (net/core/dev.c:6467)
>    tun_get_user (drivers/net/tun.c:1955)
>    tun_chr_write_iter (drivers/net/tun.c:2003)
>    vfs_write (fs/read_write.c:688)
>    ksys_write (fs/read_write.c:740)
>    </TASK>
> 
> Replace kfree() with kfree_rcu_mightsleep() so the endpoint memory remains
> valid through the RCU grace period. Also remove the rmnet_vnd_dellink() call
> and inline only the nr_rmnet_devs decrement, since rmnet_vnd_dellink() would
> set ep->egress_dev to NULL during the grace period, creating a data race with
> lockless readers.
> 
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> Assisted-by: Claude:claude-opus-4-7
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

SoB tag must match the 'From' header, and must be a real name, likely
'From' should be fixed.

Also you must specify the target tree in the subj prefix ('net' in this
case).

Please have an accurate read of

Documentation/process/maintainer-netdev.rst

before submitting the next revision

> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 269c0449760c..2e17a43aec5a 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -213,8 +213,8 @@ static void rmnet_dellink(struct net_device *dev, struct list_head *head)
>  	ep = rmnet_get_endpoint(real_port, mux_id);
>  	if (ep) {
>  		hlist_del_init_rcu(&ep->hlnode);
> -		rmnet_vnd_dellink(mux_id, real_port, ep);
> -		kfree(ep);
> +		real_port->nr_rmnet_devs--;
> +		kfree_rcu_mightsleep(ep);

This is under the rtnl lock and will wait for an rcu grace period, which
is bad for rtnl lock contention. Please add an rcu field to `struct
rmnet_endpoint` and use kfree_rcu() instead.

/P


