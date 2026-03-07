Return-Path: <netdev+bounces-265063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PgHEDaiq2lFfAEAu9opvQ
	(envelope-from <netdev+bounces-265063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:57:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBD22A057
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADFD303012D
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6E30BBA9;
	Sat,  7 Mar 2026 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+EpAD7J"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B9CA5A
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855836; cv=none; b=IqQAXfr17aOgUyS82olZEx+oFmMEXWyEHrH1XzbnNmT5QQK3d4jtDdvm2qrB57RfOaX/euvepilOMHxpHJuELp1ppgNl4/muuUneS8rflT989a3rka282AsTHjAHnm86x+BB5kJtdEdZb17beD8le48L8EFlEDH6acgX+OYWMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855836; c=relaxed/simple;
	bh=xeKO+rtigBCA0W7lwpiayf6g52tR3oqifABj7mUmFcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA86n04mUru9xQllW+W6TvCwj7yf/XA3OShpvufvM4GUrB5sA+H4+VfpPpsUhQclhBF9uBJIQxd2LZw1yGlIuUnrXlrXyb3oquOypO5FzqYPEROgBX91pOYs9UmTxrySnC/fVDMUpXInDyqQRe/rpvFcwHLNkXRcSEb540PeXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+EpAD7J; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 7 Mar 2026 11:57:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772855832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=niXuNuatHdkEA4dwo7nbxzJ/CdUMp3s/j+x0N9ZL0/Q=;
	b=m+EpAD7JS/66IytDtMy1LcKp9wCNyCOz2a5/8u+SEj6sa+HtJg+BJ4NPFd+4hSJjd2bDoo
	gcOxJ03jLIHviTAbbPdN3MwcKkOvLFf/c/pg4/GTG9mQ8SvtKQXgpawGsqpBQ40pGl2WeG
	sLzNcsjcAvSE1M6gZft4ZL9982gPJCs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	andrew+netdev@lunn.ch, gregkh@linuxfoundation.org, horms@kernel.org, 
	jirislaby@kernel.org, shaojijie@huawei.com, jiayuan.chen@shopee.com, 
	alan@linux.intel.com
Subject: Re: [PATCH net v5] serial: caif: hold tty->link reference in
 ldisc_open and ser_release
Message-ID: <76bydt5ewaz75njxgkg63rpsbm6ejfvc6doke6pfruueobqfzq@k5rwia4git6h>
References: <20260306034006.3395740-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306034006.3395740-1-shuangpeng.kernel@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8FDBD22A057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265063-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[linux.dev:server fail,sea.lore.kernel.org:server fail];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:40:06PM +0800, Shuangpeng Bai wrote:
> A reproducer triggers a KASAN slab-use-after-free in pty_write_room()
> when caif_serial's TX path calls tty_write_room(). The faulting access
> is on tty->link->port.
> 
> Hold an extra kref on tty->link for the lifetime of the caif_serial line
> discipline: get it in ldisc_open() and drop it in ser_release(), and
> also drop it on the ldisc_open() error path.
> 
> With this change applied, the reproducer no longer triggers the UAF in
> my testing.
> 
> Link: https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f
> Link: https://lore.kernel.org/netdev/20260301220525.1546355-1-shuangpeng.kernel@gmail.com
> Fixes: e31d5a05948e ("caif: tty's are kref objects so take a reference")
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

From a design perspective, ideally tty_kref_get()/tty_kref_put() should
automatically get/put tty->link as well when it exists, so that any holder
of a tty reference implicitly keeps the peer alive.

But that would be too invasive a change to the tty core.

As-is, this patch is sufficient to fix the problem.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

