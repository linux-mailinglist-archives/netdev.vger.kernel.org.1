Return-Path: <netdev+bounces-278034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKwpIFXL3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFDE3EAECD
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB0B3098448
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED743B6C0A;
	Mon, 13 Apr 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFIfNJTM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/Xt9ZvB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DF3BD625
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077286; cv=none; b=AvUsI9cCfVQYyLSSbXDRs77mY+pE3GJHff0eqW/r5wgAWSKBvURxKNlYees9rqgTrxKrjvxB3Lh7O4oja4/sDCkv06oX/oUhBXCzCfwX+Y4SPwwXPd27+00VHVggCDTfiepKP0U0DL+fj5XGmEnaJX4+oBo2aRfDYoWasvbO03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077286; c=relaxed/simple;
	bh=24kPVeBByq/nL0FPLw9fKqLBam2zYxAKJWdAjem5nVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHobG8674manbjYeKbxfKvul/EB11g8Z8jIaCFfq9ka5zpgHaHHFI2N3bgMFuxaTnHfM6+p+cd0ph0S2RpAkNuKnd5dfCo4FlZkq5kR3wDXX/GImxjm4GRjdJQ7UgtRnbd1Cay/oSRQFRnZwcb26jJ54SNZJBV3SgL4OSHMKh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFIfNJTM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/Xt9ZvB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xy98bZHX4szsCnOXWyavPZcNGx9g8RL85cirUtDlqtY=;
	b=WFIfNJTMAIu7RORQ2itUD3VvRnyeOvyXL+CHe/tUoCZn8mt00gWzC6hgo+RLvVKAy4L4mX
	nICRuu7ELTqzuWRAepBj05HD1B98HsCVBhjAuN56TVzi4Ljcoh+2abzjTanYMl3AYPiPCc
	nU+sMH0njs3pNh1rmtjFENJ4hwdrmlo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-WsFcDNT6OdizV5PgLIsZDA-1; Mon, 13 Apr 2026 06:48:02 -0400
X-MC-Unique: WsFcDNT6OdizV5PgLIsZDA-1
X-Mimecast-MFC-AGG-ID: WsFcDNT6OdizV5PgLIsZDA_1776077281
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so24330355e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776077281; x=1776682081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xy98bZHX4szsCnOXWyavPZcNGx9g8RL85cirUtDlqtY=;
        b=M/Xt9ZvBkzuhsVp5jFKH+M/N+LBap4DO2YApBDmliiDvCXbi7UjdgWR92vlIT6u5V+
         yK3XcDzpN3VWAc8qDOXNlfL3zmvS793DicCi2GG1gHZASYX2G+dsmqVMoCmnFaT8rMha
         WZDhytwHdGBKKmsK9X7eiz1rBvwr/t9vDaQV1xUVYFbTr2Fj/JGr73Gk74cODoeE/liP
         rBI/z205D0f1MKUE5j+rjWbgpWcI7+5D40agJMt5uTAlWtss6AkPGUzLlbCw8iQLUeej
         LdYAiVMZTab3tSM1fI747kmRKf5cMX09vxBWjXgcRf2J3xnxn8D0l5cPBhtn+zyzBdTQ
         rqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077281; x=1776682081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xy98bZHX4szsCnOXWyavPZcNGx9g8RL85cirUtDlqtY=;
        b=XiPXyMTxlxupdEx1BBkmLL5AWxZhgbOSv/XFibzhPdq6Pzm2fdRgu2KWGON6EFlDIw
         voMEZ8ng2B2it07hT8KTfcf1pyWhs1QthiSdgrkMeLgi5NaKeGX5eb+IaIU7e0pea9aV
         AKhqCg1FXOsFue+jb4PaUcL3OeOlftBoqu1SYz8KPfDxvR8AsCa1IJQxyuVzEAi5xkSD
         tuJsIflncK3TM/dqsQ1NttJtfyWDn4bpnHUFW/dWBAGLWV0vU/jaBc+mVv2mM1gTh7Zt
         c+kAeguWe7f2WrNgIwCqCmC8N/shNzJHR+7GM/BZt4xBBCF9kf6Dtnb8kc5ChnNePF7Q
         Z0Tw==
X-Forwarded-Encrypted: i=1; AFNElJ+OcWmJAJ5dXn/274ZvrG9wB4wJg1ulacoKwdJ30SBAzVZbiI2LVMa/owbxAdRErutRR+WE/Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovxdEcOxtZmb63RK+ykBEzSYDNA+mheMvTqy/WUmfJIYehKzo
	4Vg11rDq085iV0dNHDlYTFTKdrtNPvs5EhY21h2ztIUBeun12dB6hhjY4FDuudrjYpBGTOGkYpX
	ART3XqReBlw1kW477mMeqIfUA9/FPBZY1IiUiWNaZjrP3MZ155we/IaYTPA==
X-Gm-Gg: AeBDieu4dpIPvTM8o32K2sHYGKaTUYJ+wCkEvgw41FlOaB+nhHLXKd2LLmHm1xImmTW
	l/jrqwKqJechzo+kve5PfYEHrmiNLR+0q/hR3ufV5sFMsUVmK3BFsipbWuSPuwzTpfKManaX0EE
	QeWYbRmoDorG/yz8+NGZiuU52BbB7jrsudtjlt+VWsGe/dtmMbP+QKVQrHqKK4hkI7b53DveC8W
	7FvEajbdZgSOxXslXq0a+xhiOcfUKCK4MKtNxskgreBxJULgMWeBx2mjaKz5oKxFLNHyU9v7mn4
	ddFpGHFyaF3feD5j4i6UgO1IEnzGXGO8x5g4s1QEfnhmeKdxOc5yy6wmhKmCm1qmvqPNolwqKn9
	bKokoZyQKeKEHNnWHk6EzgZ5+dfFAYA8ybbkFeVywtdEwUwq3hAiulPS0
X-Received: by 2002:a05:600c:4e48:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-488d6858368mr179115145e9.20.1776077281325;
        Mon, 13 Apr 2026 03:48:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4e48:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-488d6858368mr179114845e9.20.1776077280846;
        Mon, 13 Apr 2026 03:48:00 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67e685csm141008475e9.6.2026.04.13.03.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 03:48:00 -0700 (PDT)
Message-ID: <cb5bf340-e5fa-4866-b5c6-565709ba633c@redhat.com>
Date: Mon, 13 Apr 2026 12:47:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 3/5] psp: add a new netdev event for dev
 unregister
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
 <20260408231415.522691-4-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260408231415.522691-4-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-278034-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BFDE3EAECD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 1:14 AM, Wei Wang wrote:
> +static int psp_netdev_event(struct notifier_block *nb, unsigned long event,
> +			    void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct psp_dev *psd;
> +
> +	if (event != NETDEV_UNREGISTER)
> +		return NOTIFY_DONE;
> +
> +	rcu_read_lock();
> +	psd = rcu_dereference(dev->psp_dev);
> +	if (psd && psp_dev_tryget(psd)) {
> +		rcu_read_unlock();
> +		mutex_lock(&psd->lock);
> +		psp_dev_disassoc_one(psd, dev);
> +		mutex_unlock(&psd->lock);
> +		psp_dev_put(psd);

Sashiko notes that the above is racy:

---
Can this code race with psp_nl_dev_assoc_doit() and permanently leak a
net_device reference?
If CPU1 is executing psp_nl_dev_assoc_doit() and CPU2 is unregistering the
device, the following interleaving could happen:
CPU1 (psp_nl_dev_assoc_doit)
    assoc_dev = dev_get_by_index(...) // acquires a reference
CPU2 (unregister_netdevice)
    psp_netdev_event()
        psd = rcu_dereference(dev->psp_dev); // sees NULL, returns
NOTIFY_DONE
CPU1 (psp_nl_dev_assoc_doit)
    cmpxchg(&assoc_dev->psp_dev, NULL, psd); // succeeds!
    list_add(...) // adds to psd->assoc_dev_list
If this occurs, the notifier misses the unregistration event since it runs
before the device is fully associated. The unregistering thread will then
enter netdev_wait_allrefs() and wait indefinitely because the reference
held in assoc_dev_list is never released.
---

/P


