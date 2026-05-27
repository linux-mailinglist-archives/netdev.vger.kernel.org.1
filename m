Return-Path: <netdev+bounces-292062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCMHATFXFmqplQcAu9opvQ
	(envelope-from <netdev+bounces-292062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:30:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDB5DE8DF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A22C301475C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D84363C5A;
	Wed, 27 May 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB5Vkn8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886535C1A6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849006; cv=none; b=sRuL6XVtJ9ucwEK2bwrKglifQ1sCAhF1Em7URiTMs2CiSPVshzwzd+7My92koQdOttrgHF/8cL+2Mra66Bs1tGM1sz6wTQYyfcPNJ53hJyBVZYzUTEIMet5lUPC15GiKH4vJJHcAQjUlVDPyRchz4iK8QwM6OcnhBSobJzkserw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849006; c=relaxed/simple;
	bh=tgeij3cuEzU2fzdZmF5gs7GPknqDJSFdViRRgWypV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxBz19jIdHM8i+ftuC5JaSO3bCVxXN0pRIIWBEsd1xF3vpgAtQP2RZQgQiA7d+8456GW1/smeTTK7sOPMswAU+p2O9A74NI/tq5tylubJu0aZTkIYfWl4yT4/cVCeW16owp8CAxrcKP8d8wZDJCYeNsQlbvXbL9bB+tTz4kxaz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB5Vkn8z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E281F000E9;
	Wed, 27 May 2026 02:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849004;
	bh=U4CR4B8MnRJKGjjkTKb7V4k20i4hcIzipaTf5buvTkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aB5Vkn8znZ7+v3B7T896ZaTD5WxHxrhkIKxU2DYeg/guLcjuo6vRBrn1s1iPAu0Ln
	 qjH9O2jsgX1FqveGKNOt7gkXG7fPlGmO064liigaq8gUpj+gyFDuP0klx+XtKt2W2d
	 1a62pFhsTYtP0dxXQXOZjs5obVRLUNkk1r8OepwXBXx2IRPRr0Fa5cQM1myDJPnkb8
	 Vy8KCgD08bgYS41EsfPQAUqqTBjsTY9WTEzc6/6TjhIlPxZ9WEqQWcjyy5vU7j7nHF
	 xn5tJL28g/DMZ+8bspJyxRbvMVMJ1AvRvj+Se/GIIWdPZsKajt4XLcZ4Mx0POOKo+6
	 QAQpOO3kfx0aA==
Date: Tue, 26 May 2026 19:30:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v5 net-next 3/5] rtnetlink: do not acquire RTNL in
 rtnl_getlink() with RTEXT_FILTER_NAME_ONLY
Message-ID: <20260526193003.692cbf01@kernel.org>
In-Reply-To: <20260525083542.1565964-4-edumazet@google.com>
References: <20260525083542.1565964-1-edumazet@google.com>
	<20260525083542.1565964-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-292062-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58DDB5DE8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 08:35:40 +0000 Eric Dumazet wrote:
> +	need_rtnl = !(ext_filter_mask & RTEXT_FILTER_NAME_ONLY);
> +
> +retry:
> +	if (need_rtnl) {
> +		rtnl_lock();

I'm probably paranoid but can't shake the feeling that we should add 
a check here that the device is still registered / alive. Running full
rtnl_fill_ifinfo() after we may have already called ndo_uninit() seems
a little risky.

I don't want to delay the series any longer tho, please follow up
if you agree. Otherwise we can defer until/unless syzbot proves us
wrong..

> +		/* Synchronize the carrier state so we don't report a state
> +		 * that we're not actually going to honour immediately; if
> +		 * the driver just did a carrier off->on transition, we can
> +		 * only TX if link watch work has run, but without this we'd
> +		 * already report carrier on, even if it doesn't work yet.
> +		 */
> +		linkwatch_sync_dev(dev);
> +	}
> +
>  	err = -ENOBUFS;
>  	nskb = nlmsg_new_large(if_nlmsg_size(dev, ext_filter_mask));
> -	if (nskb == NULL)
> -		goto out;
> +	if (nskb)
> +		err = rtnl_fill_ifinfo(nskb, dev, net,
> +				       RTM_NEWLINK, NETLINK_CB(skb).portid,
> +				       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
> +				       0, NULL, 0, netnsid, GFP_KERNEL);

