Return-Path: <netdev+bounces-265813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GClNJrVnr2myXgIAu9opvQ
	(envelope-from <netdev+bounces-265813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:37:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 343442430EF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08CB304EF7B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F581A5B9E;
	Tue, 10 Mar 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h19jWfmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD822126C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103026; cv=none; b=qQe2LR99aGKjv+1IQRK0JeAuDl0AFd20xA5JBzPRx5lqB8PKFo9aqmSIpmhHLgo6ZZ5BUzoyVw9CthUvljgpqagNT80/U866NYd7JF4b76gjTMZmQfpOGUXuCfAf0tb2u9W0XNO8kP8CpaQO9XhmzWcvxOw3xOGXT+PyviCr6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103026; c=relaxed/simple;
	bh=H1HnwjLAmWa0HH4kZNC7SF31fUVoZzNNkFeKI1gbKAE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OX/0qM9h09kzryS6rGmLJpfsv5lCxRpYnWDUEgQ0MIEApKU2SK0wuonrP/zIlcEqz3Sp9XdFN4AbsOTVNEfcwUSlISBnltM3rbIIkoJxkL9eMYGYlvx8VR9OBkZrjxPz6cOWFXUhBwklVNLGM7r+YDl6AGsWYtR5rJE7P+YRl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h19jWfmz; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ca6595c8aso12077859d50.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773103024; x=1773707824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbazBS8+kG0h+vtUgxLTNmrlqNI3bgj4rLuGo4PT6ek=;
        b=h19jWfmzYBCVy6i6eCmW+AdKHOjyQRtL6//NLIMaPvVKNoOwy9PlhK34Qv1t3wF0dZ
         7kDGhguxyb6htl+a3cFoce1l3BHFMPcIhfC87Z0dV4JWGEzLYZ2hBxPdpoCcHQShahV7
         1yvesz5yLSGOgXLzN3M8fVbP0igGYkRdsHkvk6SEqDNoLpM8pnT7xx0NqeBP9M7lDhqc
         w6UWpiDekNq4JmLjy1DBFZNgt7sVmBUTkGWZmAVrDQ8NvJ4kw182kLDifmFlpo9aPsaw
         9lnF0NuHoUd9ZWyP1QpAs0yyCYRRx+tp3Vz58OkYfEahsofK6rpxW58L5pUU6Rvy2xIW
         C1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773103024; x=1773707824;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbazBS8+kG0h+vtUgxLTNmrlqNI3bgj4rLuGo4PT6ek=;
        b=mWgpULhYgfWthtdBBwXmNfES7RBmK7fKiEXWJTPjw/ylz14nuPjvRGfduHWtKV8pmM
         6ZmuzPzOnggcgkIm9QQLqPv2WV+d+F/TSAOjceNqNMMaMTJWAAVkYY73rpcdPt6VQcr7
         QWC+LYl5PxD9ySHEtqIglSKQU/u/uiZC44Cuw7h+Gws40VGxTX1MJAPhzbsianIWbiQz
         EMzJf0DzMTN8J0IBfFlAlHmKMP93NaUD2SFS2OTrZcTA8E5mHrIHArlZP0o4mNFcQWns
         8RXnElujAT5gGoqv1aceCX9wVrV2WEB48sZoLPgISyTCk42+KS2Kd3Pr/1b21ssH/HmV
         LHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRYK1ryovcLgHpcwfVt3RN64yNKxzEJluB6RlApI9UCSq8o6oISTCAULQlgwiNZ1XtXdiyQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZxjTDAGFhwoc+e9PmtKgDAf5QQmpKmat5Q6wGPQ0CxzET6jW
	48NwAVUkq76RlEPY3cYOdVG1VELGGxrf2tAbShhf+Gaq7kITq64/+3sV
X-Gm-Gg: ATEYQzxJF3SOmWgA2WMspL5DWfmqu9ze7vz//prRAONnh5L9+gu9gXg1b4OQIQCKaTY
	vxUsafGOFCgxxGEMODL4siu2kzOAv/EZB01xYBE46oGGVfipthhFdcKJ/pwLxvnYvM3GRSoHxyf
	VvLI30LCti1sBVSNAjhlDC9rtMVl378JQos7+C25fo42BSfeHBu46sHGY3TBeSxKWpyuOPNDLtC
	F/Y5oI8Fcj17QfKvM3aIQrx9IliMyOfb3fXmFDTqyVwVydolkP5SSeLhbZKqlGBhfNAqthigZ6q
	c9lxZDyT7uc3QtYWCHAZO5BXDDZ7H/x/zeJdNjyN2z0qs0ptggzZOATXAxYf2n7QFSWpirgqZe/
	GzfCAqHefLI6KOwvTMuhLaVgt/h0ax4C39yJqUfa4laukZhuxKcXDD/hzYf4DXZtilhrmc4iSRH
	WdSyJX7qUHO2ydLJ106r5QtwYzNsskbvsaj3bFM7oJZ7pXv3UZy++w1qDLo00ngUGWQPLixuqYT
	k2I
X-Received: by 2002:a05:690e:44a8:b0:64a:28af:2d18 with SMTP id 956f58d0204a3-64d143900bamr9660834d50.84.1773103023982;
        Mon, 09 Mar 2026 17:37:03 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64d176c5276sm5569928d50.14.2026.03.09.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:37:03 -0700 (PDT)
Date: Mon, 09 Mar 2026 20:37:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wei Wang <weibunny.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Wei <dw@davidwei.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Message-ID: <willemdebruijn.kernel.21b0d6913512b@gmail.com>
In-Reply-To: <20260309183454.2872967-4-weibunny.kernel@gmail.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-4-weibunny.kernel@gmail.com>
Subject: Re: [PATCH v3 net-next 3/5] psp: add a new netdev event for dev
 unregister
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 343442430EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-265813-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> Add a new netdev event for dev unregister and handle the removal of this
> dev from psp->assoc_dev_list.
> 
> Signed-off-by: Wei Wang <weibunny@fb.com>
> ---
>  net/psp/psp_main.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 178b848989f1..8e00ade706e4 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -375,10 +375,72 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>  }
>  EXPORT_SYMBOL(psp_dev_rcv);
>  
> +static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device *dev)
> +{
> +	struct psp_assoc_dev *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_list) {
> +		if (entry->assoc_dev == dev) {
> +			list_del(&entry->dev_list);
> +			rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
> +			netdev_put(entry->assoc_dev, &entry->dev_tracker);
> +			kfree(entry);
> +			return;
> +		}
> +	}
> +}
> +
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
> +	} else {
> +		rcu_read_unlock();
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block psp_netdev_notifier = {
> +	.notifier_call = psp_netdev_event,
> +};
> +
>  static int __init psp_init(void)
>  {
> +	int err;
> +
>  	mutex_init(&psp_devs_lock);
> +	err = register_netdevice_notifier(&psp_netdev_notifier);
> +	if (err)
> +		return err;

Defer this until an associated device is actually created?

In many installations it won't be and this notifier won't be needed.
> +
> +	err = genl_register_family(&psp_nl_family);
> +	if (err) {
> +		unregister_netdevice_notifier(&psp_netdev_notifier);
> +		return err;
> +	}
> +
> +	return 0;
> +}


