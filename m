Return-Path: <netdev+bounces-264121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPH/B1rfqGmjyAAAu9opvQ
	(envelope-from <netdev+bounces-264121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:41:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8077209F5F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6041E305C285
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C97231842;
	Thu,  5 Mar 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpERp4nc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376320E6E2;
	Thu,  5 Mar 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674798; cv=none; b=UVwb7JtW59qpHZKZ5BojSAJ4zpvvoYmEiOOqo6vhxnGesgMMczBkL70e/5dYdBrDSCq2kGCeGu+BfEHN4z0fzZg507DjPZFXOPNrWQutSEg3O1tRATveIh7PpCudJmNblutXYgA52w41weY5HsnyW0aDHeAExm39ekPPD6PPJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674798; c=relaxed/simple;
	bh=XQUDl8bVCw75uNwsouGGdGYB5SekWNlXD3K20j1XYmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwVo28gpLTFxfyaO4atCwQyPMb5l0u2Y1/JwTeWxydC91lcqNxzSjxsi+O8bj8HmBFppZrpcumEoKg0Asu4+/a6Y8Ntcw1og1jhfELMEf3lfm4nCexx7y3aEWzi2d1E9sclBTbcJhCIHsEHUoPJTtS/Pep7+2Ov5EKn9UTXyw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpERp4nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1417C4CEF7;
	Thu,  5 Mar 2026 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772674798;
	bh=XQUDl8bVCw75uNwsouGGdGYB5SekWNlXD3K20j1XYmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rpERp4ncxi/6dZp+/tz9fzgVf0knDKBOgBjQV9nBvKWuh9DqeQXsbq4ZzOZsQQDrO
	 G8gXRj/om59cDTy2aRUFLig8kJ63zQ3xxSckup2MLbPyvsoVygd5UQu7GTKVZgcJZT
	 YwyaJ+OgCwoefRnyJVZeYdrkhdRvcqH704AwlSMUIjrxt8JfH+HogCt8Mi5F92kIhI
	 RYeOHt4m9oPPmkaLC4oKewbvFWa3m4hEHsTk8krtNhNlVI4v36WxfoBxMH0een3wd2
	 F98ufQYG1NTuWln5bflas1ceyszIaF6c5gGNOsIzd0hNWVHqDp5/d/ptq9N1ZIakYd
	 OknGOWdQiDHwQ==
Date: Wed, 4 Mar 2026 17:39:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 jiayuan.chen@shopee.com, jirislaby@kernel.org, andrew+netdev@lunn.ch,
 gregkh@linuxfoundation.org, shaojijie@huawei.com
Subject: Re: [net,v4] serial: caif: hold tty->link reference in ldisc_open
 and ser_release
Message-ID: <20260304173956.0081d8ea@kernel.org>
In-Reply-To: <CC580D33-FC23-4271-ADEF-A0DEAE6BE9ED@gmail.com>
References: <20260301220525.1546355-1-shuangpeng.kernel@gmail.com>
	<20260304012612.2592839-1-kuba@kernel.org>
	<CC580D33-FC23-4271-ADEF-A0DEAE6BE9ED@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A8077209F5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264121-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 20:23:20 -0500 Shuangpeng wrote:
> > Can this dereference NULL? The tty->link field is only set for PTY
> > (pseudo-terminal) pairs. For regular serial ports and other non-PTY
> > devices, tty->link is NULL.
> > 
> > The CAIF line discipline can be attached to any TTY device via the
> > TIOCSETD ioctl. When ser_release() is called to clean up a ser_device
> > that was created for a non-PTY TTY device, tty->link would be NULL.
> > 
> > Should this check for NULL before calling tty_kref_put()?
> >   
> 
> tty_kref_get() / tty_kref_put() are NULL-safe, so calling them with
> tty->link == NULL is not a functional issue.
> 
> I can add explicit if (tty->link) guards to improve readability if you prefer. 

Sorry, I should have checked, I'm surprised the AI agent got something
this basic wrong. Just the Fixes tag, then..

