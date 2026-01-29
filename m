Return-Path: <netdev+bounces-254830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HyVCoh6e2kQFAIAu9opvQ
	(envelope-from <netdev+bounces-254830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:19:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926FB15FF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8AD63015487
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC826F288;
	Thu, 29 Jan 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JtUxkb2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF114221F03
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699955; cv=none; b=gBqPsh78cC9HNBK8yprJCeC9tBOTngv1XxchNG0QaWLQ8hRv++JysqY2HSMVU6DxXFab4H7LMzcbyI98LR1HQocO6aJPr38S6X3Lnj/ow8DYcYBEEX9wjznU04CLEnfHVCnyIKKFTBEB9WMb0u8gnSSMzDdpFyXfnwMBW9Sbzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699955; c=relaxed/simple;
	bh=+tmrzRllSFS3UuYo3ZY8r+bPOjC6VUQ2B+vahz2nAVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw5loyrB+DEmAo+oFaZsr0U71kpXabX8R2z47cjQcDQlQWOZGSzt+FiCiiEdUOgkjn0VjsEceWpxnspU4nEoWF48gLyWqBMGnEt8a7HlDj/1iIcV2dkCkLdTMExFGVYHPJ38dWEAKBPoZ755oEs1TEt5iHmQ5iBZs9BtGT04ydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JtUxkb2f; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so8591115e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769699952; x=1770304752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsXQrimwewQ8w9Fgh0pLIlGot9P2osFHXzwl6y2/yiU=;
        b=JtUxkb2fg1gE6rezHHyO/F3n9KTJvBt52O1kDQLFP4aBvEhDX7WKVxT85Pbe++Uzkl
         R2iwCu2deClFOvBFwuVikR/dMC/9oYLzqFgWXC4ERvByVL4p86bkmI547fh5UOaBYQwj
         ZehZpyXLBvGzZFITnEYjnBRYiC2aZPOYl85LPoN2Q2VzVHwDUQDWbt6YZkIJTbToQbnw
         wQWg1uN2EHltHi4HT1+lw/bfK40VY23rM27uNukbe1mAJtBnhcOMi4LyGTqcXdBkodNn
         MxYAXhq3It+9D1sCvANj0YKRPcW7s3OsWFak4xq5mTVedZxsTXv849JPN/ywMdhPaBEH
         2rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699952; x=1770304752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsXQrimwewQ8w9Fgh0pLIlGot9P2osFHXzwl6y2/yiU=;
        b=tzBSn4L90j64W1YAv1kyzmX+A4bf17RVav9J6VVMlS+I3oUbg097zbKevfayRnnKRp
         LahIMfSuFZTUmsJAtdyJPE3I974xfm1kgy/tAEXwbcI9d2LBvVqvvXgQhV/FjBGEr55C
         YdDXNhwEMtPDvyNSRVLAwi273W0wBXbp1qhGVdHTcANODiOiwg3hsziIMVXq00opHf7k
         7UMfGkcWcKeeCBtetEGwBm830jiDc9PW4yYmcag7WkE7ApU76nUtYhgdjRCguTxcmWEL
         9hu9GO0O2rqIgq7CZG7bLUmeWMarZNo4cYutwTbLh/l9k7l0s4OpjzdOl9hTQ9eBviFR
         JPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4+Ofr7PMTkXJfEFb8zQJhqBe5OZ6vmf2YRLSCzao+9ent+kvfa/mmRY2d8aoEZem8NjFd4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVNeH3hgxvo5UJR8bd7eSBGE2RNwoE/a20byuqlgZ/VJ0jtiY
	cXQ1Ygi+O09J6ihbDaMFKZXbFyk3G+U+ogPTjKHEmlT/iGLF0ACmvGqvdN0dJisFuvk=
X-Gm-Gg: AZuq6aK/yiZD9Q8pdbPHqcJwHbdkiFV8QSjFv4Gk4kD6JnLdqm9i8pS5JwzrVT+aOaM
	uisUXpxoI9ah5JZbxqaNKGvcB2HVjtq4rFCWtAAEpXWXBG3WCj2CGggyiIJ7vN9Lc1cd9nTztPT
	w0OHmhmPGMN43g0sKjD/adXe9MSCrkAS5EvHgtcHQEpVf6XBxtJkFic+GhSInstBR5lZZGWFvAr
	9kozuHZRu9R4qf+h//3SozTyfKAyxGp6OsqOfVWR8wjNVfSr2IE/mXLxVUAZCf2fheAyVwQ3ExK
	GEbvshCe05t+u1oP2HMYcaThaC76n1KvbUJJ/VNHpoZuk2+J4Yy7f+npZ3PnOs8kIj83tahU7iA
	W7BdkLpsKVrcFBFB9HaDsR998AraRyuLiSSTq30wIqM/oY60i0IgzX+RhdkiTsQUdRr8TM1G9Sq
	bjG0Nng/XINFD9oCkfu0RV1B5Z
X-Received: by 2002:a05:600c:46d5:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-48069c3fb85mr106936725e9.4.1769699952070;
        Thu, 29 Jan 2026 07:19:12 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c40e04sm201022335e9.13.2026.01.29.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:19:11 -0800 (PST)
Date: Thu, 29 Jan 2026 16:19:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	john.ogness@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 3/4] netconsole: convert to NBCON console
 infrastructure
Message-ID: <aXt6bD4KNb-5aY6c@pathway.suse.cz>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-3-93b4ddbc181a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-nbcon-v5-3-93b4ddbc181a@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254830-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8926FB15FF
X-Rspamd-Action: no action

On Wed 2026-01-28 06:17:39, Breno Leitao wrote:
> Convert netconsole from the legacy console API to the NBCON framework.
> NBCON provides threaded printing which unblocks printk()s and flushes in
> a thread, decoupling network TX from printk() when netconsole is
> in use.
> 
> Since netconsole relies on the network stack which cannot safely operate
> from all atomic contexts, mark both consoles with
> CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
> 
> CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> scenarios (panic) where regular messages are sent in threaded mode.
> 
> Implementation changes:
> - Unify write_ext_msg() and write_msg() into netconsole_write()
> - Add device_lock/device_unlock callbacks to manage target_list_lock
> - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
>   operations.
>   - If nbcon_enter_unsafe() fails, just return given netconsole lost
>     the ownership of the console.

I was just curious and scratched my head around this a bit.
If I get it correctly then it might fail only in a single situation.
It actually should never happen on systems which stop CPUs by NMI.

My thiking is:

  1. nbcon->write_thread() is called only from the dedicated kthread
     so that there is always only one instance.

     It might actually be called also by the legacy loop when a boot
     console is registed. But the kthread is blocked in this case.

     Anyway, the callback is serialized also using netcon->device_lock().


  2. nbcon->write_atomic() is called only by the final
     nbcon_atomic_flush_unsafe() because of CON_NBCON_ATOMIC_UNSAFE.

     nbcon_enter_unsafe() always succeeds here because the _usafe_
     takeover is allowed.


  3. No other lock is synchronized with nbcon context.

     It is acceptable because nbcon->write_atomic() is called
     only by nbcon_atomic_flush_unsafe() where the nbcon context
     synchronization is ignored anyway.

So, nbcon_enter_unsafe() might fail only in netcon->write_thread()
when the kthread is still running on another CPU while
nbcon_atomic_flush_unsafe() is called on the panic CPU.

And it should never happen when the non-panic CPUs are stopped
by NMI.

By other words, the nbcon context synchronization does not have
much value when CON_NBCON_ATOMIC_UNSAFE is used.

It is acceptable from my POV. I write this just to make
the expectations clear. I wish, I had time to write a more
comprehensible documentation about the printk design...

> - Set write_thread and write_atomic callbacks (both use same function)
> 
> Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

