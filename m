Return-Path: <netdev+bounces-228568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22253BCEB4B
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 00:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D00394E30BB
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CC2773DF;
	Fri, 10 Oct 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL4d9X68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E21277030
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760135914; cv=none; b=ZFxlRXwo+hho4kYwnIGCscUpJmaqNv8NOwaw+x3oaQ+sCobc6zNS2UsyPf4VGg4kjUpsOBB0PjDimQRCox4GrWwePQk2LCcIGxdoz7XzBUfw58TTVc0U9IDetShYEqcKlTo5g6M/mgNtlMTEdpDYApYaNiLDAYbTzIol6tVuvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760135914; c=relaxed/simple;
	bh=pteb95Xi4F1c7L5LxfT8Xd49MkKK26RH46MP7JDboPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMI8P0gbaQszvqIFcDQGHSbUaOO5XfRwMaNWiwxiW/uUzHvx1SPYXlJzWTUVndIdFSCyQZ7XXqVDkXKk1CSpJMVspmTTsPhZhA1CUqQlQHR38qXsWSfR7mMaobGHVJQjLi9F9NWoqjMRU+wx23JlpTGnFXe+zWoGqddTHmRpQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL4d9X68; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-271067d66fbso24225235ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760135912; x=1760740712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGQ9B/Q40t71eh783ShZxC0q8CEgVQiiom25iacjG44=;
        b=SL4d9X68yVRnmOL6llKXBE7iQEAcZwUfJP7Q98Zy9S8+4Sy/Cl1X6rWxt2ndNgSAlC
         jpJxCPBJOmdIxqludfYtqwz1OzgaubGu30ax8kU1jCs/+yQlFB2Dh9J4/BvZqhM3xkv9
         UvjHJoTyaJcxBUWbfCrH+9skzt2NWA+rK39TqIZ2wBy3PyExI1d1mNV59zbj3y/zJh0m
         TvEnWRxqpwzO633326hLLkYiTWDOd7nqUueP/i+/mGsJzPYmErz0Ol8Z9+hiPlcCMr9r
         gA8/L9QZD3E2AT4Q8wJnnbGCZX2Z32RMC4SXGizdkQDl8DtkDbMOCyVy/x/CTWrna/i0
         bkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760135912; x=1760740712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGQ9B/Q40t71eh783ShZxC0q8CEgVQiiom25iacjG44=;
        b=N87Hw+rgEDeTijzV+wIO+3cCc6OQ5oX0i90dkVGW3CLEaag1JXkjzyI8WArs224d+h
         ihQq8BT/35cVronN9qtDRrTMqRFdXAOVuV7ui91xPWhkAwUE8Ad2btN17ZNprdSLH80+
         9Fokxt6t/RgRe7zcxpz2nlfIRL8jnejiVgKUQ6IqNTeLh6OS9XrCszAN7zSEz1qfyoxg
         qBzQyX9nig4OVNnRRpOvG+9e3fVzBRsKMkb1Q0DNIn+GCRiXBdXogBALbGUG70btvseg
         l1T/Q6o+X2wltL32PZmchAfCwB3Tn4WHWB+ddNBwcReRgyW3ZU/qLT3ZVFPjwhn3sco0
         zKWA==
X-Gm-Message-State: AOJu0Yxd9QlI5E+JkPybP23HGvL0TehYLqhFmycIUSlUqUgfAdY2Du1F
	vN8HEmwrMbkLkJWMvYFM7fcbAegBtBy2LKCmuaEcgRiRk9ZnFs7aEVk=
X-Gm-Gg: ASbGncvFikkMPknWCdAp1SiUbmQ1S3wO4Q7wPt+38U3Dk/6XhI6YO7TWwqpDIheIqkW
	/uuKODotkhRxsVSeFZ6GHGCAFyCkbASNRlhT8CLhvW/R9cORKJnZ/t3UqxT9izESePqOh6Ihmwm
	IsFtWke9LUFIuWIXB9YWJyUnb7Uk/ra+8hB1V7VCqlO+gDMAOmUNd5N6khgGz0AGMRWQF2An6Zb
	w0CTFWYirrm3nubUWBziieCXa9oWH2GEt4+gdk7lseMdjjFbybbTdJqpys5SJ6VSKaDEXIqX2q5
	1EpJwhNUS4+uFc7D4gYVKCsqdrGoNUuNMl8a1AA+Qktqol39tGrIoL7NSS5A1yWOYFHsApclYlT
	PVE/yuKmFPAvZSqhE+gv6T+rCHcehlWuEGR/HSagUiaGWx/7iOZRETcWWv94QA+Cc3reKbWmQro
	VwLCrhsF6adZixcAzDnP8PP5fSOL6gBF0OsQeeJ3sD8yHftELdb2jul5TtHxMNatOY7l0lyJJv3
	spruiIfBxpF+auSPsfRf//k
X-Google-Smtp-Source: AGHT+IFmJGI+WTgbVELH8Dd0/shXDWB+wRlBQIjW4cUi4Oor5QrP0R/+IpMdxN5BbV65x+TxPbTK9A==
X-Received: by 2002:a17:903:1448:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-29027402b4bmr175122575ad.45.1760135911662;
        Fri, 10 Oct 2025 15:38:31 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b678dcbfc5esm3282036a12.1.2025.10.10.15.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:38:31 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:38:30 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net 2/2] net: core: split unregister_netdevice list into
 smaller chunks
Message-ID: <aOmK5i5e_Oi93JiO@mini-arch>
References: <20251010135412.22602-1-fw@strlen.de>
 <20251010135412.22602-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010135412.22602-3-fw@strlen.de>

On 10/10, Florian Westphal wrote:
> Since blamed commit, unregister_netdevice_many_notify() takes the netdev
> mutex if the device needs it.
> 
> This isn't a problem in itself, the problem is that the list can be
> very long, so it may lock a LOT of mutexes, but lockdep engine can only
> deal with MAX_LOCK_DEPTH held locks:
> 
> unshare -n bash -c 'for i in $(seq 1 100);do  ip link add foo$i type dummy;done'
> BUG: MAX_LOCK_DEPTH too low!
> turning off the locking correctness validator.
> depth: 48  max: 48!
> 48 locks held by kworker/u16:1/69:
>  #0: ffff8880010b7148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x7ed/0x1350
>  #1: ffffc900004a7d40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0xcf3/0x1350
>  #2: ffffffff8bc6fbd0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xab/0x7f0
>  #3: ffffffff8bc8daa8 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0x7e/0x2e0
>  #4: ffff88800b5e9cb0 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0x1056/0x1b00
> [..]
> 
> Work around this limitation by chopping the list into smaller chunks
> and process them individually for LOCKDEP enabled kernels.
> 
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/core/dev.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9a09b48c9371..7e35aa4ebc74 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12208,6 +12208,38 @@ static void unregister_netdevice_close_many(struct list_head *head)
>  	}
>  }
>  
> +static void unregister_netdevice_close_many_lockdep(struct list_head *head)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	unsigned int lock_depth = lockdep_depth(current);
> +	unsigned int lock_count = lock_depth;
> +	struct net_device *dev, *tmp;
> +	LIST_HEAD(done_head);
> +
> +	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
> +		if (netdev_need_ops_lock(dev))
> +			lock_count++;
> +
> +		/* we'll run out of lockdep keys, reduce size. */
> +		if (lock_count >= MAX_LOCK_DEPTH - 1) {
> +			LIST_HEAD(tmp_head);
> +
> +			list_cut_before(&tmp_head, head, &dev->unreg_list);
> +			unregister_netdevice_close_many(&tmp_head);
> +			lock_count = lock_depth;
> +			list_splice_tail(&tmp_head, &done_head);
> +		}
> +	}
> +
> +	unregister_netdevice_close_many(head);
> +
> +	list_for_each_entry_safe_reverse(dev, tmp, &done_head, unreg_list)
> +		list_move(&dev->unreg_list, head);
> +#else
> +	unregister_netdevice_close_many(head);
> +#endif


Any reason not to morph the original code to add this 'no more than 8 at a
time' constraint? Having a separate lockdep path with list juggling
seems a bit fragile.

1. add all ops locked devs to the list
2. for each MAX_LOCK_DEPTH (or 'infinity' in the case of non-lockdep)
  2.1 lock N devs
  2.2 netif_close_many
  2.3 unlock N devs
3. ... do the non-ops-locked ones

This way the code won't diverge too much I hope.

