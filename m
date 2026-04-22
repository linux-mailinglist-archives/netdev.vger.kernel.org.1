Return-Path: <netdev+bounces-280318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MjgOiJm6GkLKAIAu9opvQ
	(envelope-from <netdev+bounces-280318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8904424D3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47017304D41D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66D2DCC08;
	Wed, 22 Apr 2026 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfv5f0JH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDqYmxVj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D79221F2F
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837961; cv=none; b=FYmnA/iuNVr7gz+XJeg3fJwvuSdXoWkHYqL1HMWtaxWYVvl99AAaHiPj2zryERYXmbYWvlQMYWkJBdU9Ax42KWsWnWPsL+fpNGafjYGpKyiWfUmb6wIIPu4QkAOB+412YkM9F0pc2BKS2TbXHwM4bxdHVcwb8sGQGwLiiedI7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837961; c=relaxed/simple;
	bh=D0IhErlGrKKuMRwPOP4Tlt1GsqbT8xAI/tb1DvR/nwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpbxBHfN5bn0GZM3mQYjJ0Vi/Td8/0PJVNKEwx8/W4JlcIzJERDxSZRJuCWH9IqYQS7SEUGgAmRazotriVYoVJkuZiRbXg5AqNtxYF2jchTb7ck7iVhltynpy3KR82QMr4mZEgt0wt1WB2eMxfDIEjUmmN5JezIUIAOnTHUp3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kfv5f0JH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDqYmxVj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776837959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
	b=Kfv5f0JHpqpicGsTAaScc4FnO1qDnV/Qc6jlm8+NuYGhNC0RKJZGAPZOzwJNUc75kDcgO1
	9j/9zv2szVNTHBT0X9Us3478saG06peoqVi+tumso6gUhMYxoBJAMAMvXwS/E6UEyCai+2
	8VE9abcizCMjvzuAyG1Wm+wAubdzFbE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-_B549pBJPRKtQpM0wHvqXg-1; Wed, 22 Apr 2026 02:05:57 -0400
X-MC-Unique: _B549pBJPRKtQpM0wHvqXg-1
X-Mimecast-MFC-AGG-ID: _B549pBJPRKtQpM0wHvqXg_1776837956
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a55ecc249so10048145e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776837956; x=1777442756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
        b=hDqYmxVjaUFNP+JqjAK10rEDyUqPY+VznggUVQe3/btlF51uwQpYbTtb55kBTMTcls
         7ncjTixzlBivWxn4QY3xYORodFD6PN3rFZvNmVghZw6obWOH3h/ZYqP1lhSMTttDZKfb
         J68mkCBHDsd5mCC/o7EiuHZC1TLbErOfBPlmGuV7vqunH5DA+IIDle8okMSUrZSBvm93
         XW4JYjcYTa8hOll4OyAlooTBYbUFLdFVZ9ig3Olts6B1mUOyGUSCd55Z+7LiAdb0vd1d
         bV8dks6QJ5d1hSR85vUW2RqQFnUy84iwTfZiOe34Dfi2Ji6afHrh104HrtwF5eTZkDtn
         1rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837956; x=1777442756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztMyE+ktT7jgxWkcpg5pXckPoWAOQRydQBsfKgsWIR8=;
        b=kJ1ofQPBwMs54Q+Iu8mU1a5QM4yW6BBnD+FGeiTfHmnpugmF1XjNhvoKf82HVNBWsq
         CRKpcTWe6KBC+dtSd7YyLunSyBCkg0fasyBmuVVaXP3Ghh4hOGMfg0Zo4BXurc1yviJx
         kfRwyD/akBPp+0TqHU3CELJEVMCfT5obhfs69Yci2Lqz5ydYEmJUSXBCMJ9J+0Fr3Soq
         zWwTwE38SYSFNTWdBSTAiDz84tNSsaO0QIemVjt7XBmFwfBnD48Wa2TXBSgibDDu/dbR
         GCdVJ3lS2mP2JPjxV2J5vFI0sUlEUNn8R4aXh4QMxEhc8lEsNyaFu66TZMwsEvJv4C4z
         lv7g==
X-Forwarded-Encrypted: i=1; AFNElJ9ipkfiWBl3xQdaNLxWSRqsQpNFwOGVSuIklZ7I6/7AelR8DWz3OuYNKpGc4N+MdScbs8UcgyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTA1Ax10DhRstmIYv3jcM0Gs+FJ6/T4NxgSM6o/Jhp/jRMoaF
	m/+zx+HDnKRTxlGjWuJOuMjiWFXuUK0QNldPS8R44uS8dF0GzyMAbnUyxT3/WEZN+03jKIbENk4
	DyNk0kRC+YLxtrk8OPeChK+tLEybIK+Z7sX/+Rpd+uS2mH5JtIiarUGoK+EYGJk84LA==
X-Gm-Gg: AeBDieusmZ/fNgbe6rOg/5BRf38WiXTSYNuWDEYtM4DbsXjV+iEtwNLjgKtS+7MjFFQ
	Uio+9DuZx34YIj2jw52ql/wERGSjd+C2KrE7D6Div+B9yF7HdEGmDcd08+2ybYW2sn3DMlzz+J1
	U3UhLlXXgA0bfyts+y8Sr+QV3P5Jo6qLoe32+0cjRrAhE9LDoB+I3tcFCMex/Gk6Z3xRFLyD39Y
	oUuFBanjkI9sfuT8/sdFDi5aZoXQdX4KbbQpIfwnN85nyCWqH5DttCKpdIUuCVoDQ3jH6XW/Q4e
	8nenZNg2jCLstYnPZ9DDH5WCJUWIPaEQNxfyQjfFSrp2Mjs3z2SUwMTmkA512uUaJI9zeD0hiq9
	4oAkVxsdhm7+Dwd7DqyIYUepoKqjDjh6YMtti3lpNz1GNbh+Ug20lTw==
X-Received: by 2002:a05:600c:470d:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48a52cea6d8mr117687705e9.15.1776837956004;
        Tue, 21 Apr 2026 23:05:56 -0700 (PDT)
X-Received: by 2002:a05:600c:470d:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48a52cea6d8mr117687235e9.15.1776837955527;
        Tue, 21 Apr 2026 23:05:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm520792265e9.4.2026.04.21.23.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:05:54 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:05:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Subject: Re: [PATCH net v1] vhost_net: fix sleeping with preempt-disabled in
 vhost_net_busy_poll()
Message-ID: <20260422020539-mutt-send-email-mst@kernel.org>
References: <20260422023026.81960-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023026.81960-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280318-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,6985cb8e543ea90ba8ee];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email]
X-Rspamd-Queue-Id: 5A8904424D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 02:30:24AM +0000, Kohei Enju wrote:
> syzbot reported "sleeping function called from invalid context" in
> vhost_net_busy_poll().
> 
> Commit 030881372460 ("vhost_net: basic polling support") introduced a
> busy-poll loop and preempt_{disable,enable}() around it, where each
> iteration calls a sleepable function inside the loop.
> 
> The purpose of disabling preemption was to keep local_clock()-based
> timeout accounting on a single CPU, rather than as a requirement of
> busy-poll itself:
> 
> https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u
> 
>   Changes from RFC V1:
>   ...
>   - Disable preemption during busy looping to make sure local_clock()
>     was correctly used.
> 
> >From this perspective, migrate_disable() is sufficient here, so replace
> preempt_disable() with migrate_disable(), avoiding sleepable accesses
> from a preempt-disabled context.
> 
> Fixes: 030881372460 ("vhost_net: basic polling support")
> Tested-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69e6a414.050a0220.24bfd3.002d.GAE@google.com/T/
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c6536cad9c4f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
>  				     tvq->busyloop_timeout;
>  
> -	preempt_disable();
> +	migrate_disable();
>  	endtime = busy_clock() + busyloop_timeout;
>  
>  	while (vhost_can_busy_poll(endtime)) {
> @@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  		cpu_relax();
>  	}
>  
> -	preempt_enable();
> +	migrate_enable();
>  
>  	if (poll_rx || sock_has_rx_data(sock))
>  		vhost_net_busy_poll_try_queue(net, vq);
> -- 
> 2.51.0


