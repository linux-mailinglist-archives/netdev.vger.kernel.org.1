Return-Path: <netdev+bounces-255002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDXSJOUgfGmgKgIAu9opvQ
	(envelope-from <netdev+bounces-255002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:09:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD8EB6B7E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4DEA30062DC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093463009D6;
	Fri, 30 Jan 2026 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaljESXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2718242D8B;
	Fri, 30 Jan 2026 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742560; cv=none; b=Mj+D5blPnNHfAr2HVapzhuPNgwLvjDHVPHRVdwdkS5qYmPn7hSDZSQOYSxG46JRwmn3veUAUgnzdjr+t364iJ4+WLt/eluryYQNT4n3ioOafAwyNrC7LQwuwpuBIw78kN3kkc0IUuvhJowoV2LAnDcsvY2zvzdIo7/LxLeiCtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742560; c=relaxed/simple;
	bh=DPs443/dDi9QRedBrFczLj5v8+8O7Pbgl6i9yZ6jA5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JC1IHg1vM1ST8ZPHfvY5km48au8QpF7NSNAUDc3gMan6IfyplkAJzYd1xOJ+xt5y9FoXcyn3H+W5b3zJDYuZX85CMzBzWVNOhGWbAoCGaoJmHq3nMcqyTcZGUBuKhi8ldsAFxajpE8qRovbXB4I+dU2hgpptWL/ZqR7TsvCdfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaljESXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE100C4CEF7;
	Fri, 30 Jan 2026 03:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769742560;
	bh=DPs443/dDi9QRedBrFczLj5v8+8O7Pbgl6i9yZ6jA5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aaljESXfEaTXZvXMvqeeHo3tznCks1RupiizDBdosQawomda4Da/zsrz+KPj//kgX
	 gnK+K95xIvoB0VIPvTtlc8HkSEYk74B/qHgzqER3VuaEFJdMmRdJRNZ+n0jWvk9ZJ6
	 X1nDcZqW2VDbfLdg7OCQvK3tELEkNQtI64NFxXDV1aP1mbt2nYyQUwAKkdPyAkXt0v
	 UGSBc4RbVNWC9oZB9d0Wb7SwSLIAPXRMYCd3zDqGCv/F0T9dnlSr+2hq/0+U8ByVIl
	 HEHRLD+2WYKt8p7MlSeSVDoXayUdZYRGzK1l1Hv89EYuNQYldU0tXwYuXt9sJOkQ6+
	 fl9O3mB0YgvRQ==
Date: Thu, 29 Jan 2026 19:09:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] linkwatch: hold dev reference to prevent
 UAF in __linkwatch_run_queue()
Message-ID: <20260129190918.4d63d241@kernel.org>
In-Reply-To: <20260128031012.195016-1-jiayuan.chen@linux.dev>
References: <20260128031012.195016-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255002-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFD8EB6B7E
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 11:10:07 +0800 Jiayuan Chen wrote:
> Subject: [PATCH net-next v1] linkwatch: hold dev reference to prevent UAF in __linkwatch_run_queue()

please use net rather than net-next for fixes.

>  		netdev_tracker_free(dev, &dev->linkwatch_dev_tracker);
>  		spin_unlock_irq(&lweventlist_lock);
> +
> +		/*
> +		 * Hold extra reference to protect netdev_unlock_ops().
> +		 * linkwatch_do_dev() calls __dev_put() which releases
> +		 * the linkwatch reference. Without this extra hold,
> +		 * the device could be freed by netdev_run_todo() before
> +		 * we call netdev_unlock_ops().
> +		 */
> +		__dev_hold(dev);
>  		netdev_lock_ops(dev);
>  		linkwatch_do_dev(dev);
>  		netdev_unlock_ops(dev);
> +		__dev_put(dev);

Please move the dev_put() from inside linkwatch_do_dev() out to its
(3) callers, instead of taking another ref. The dev_put() inside
linkwatch_do_dev() logically pairs with de-listing the device so
it's reasonable for the caller that did the de-listing to do it.
(of course that'll let you move it after the unlock)
-- 
pw-bot: cr

