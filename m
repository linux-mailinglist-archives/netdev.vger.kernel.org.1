Return-Path: <netdev+bounces-264572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JN+DI8Bqmm9JQEAu9opvQ
	(envelope-from <netdev+bounces-264572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 23:19:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D19218DAC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 23:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 312CF301DD40
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 22:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3736404B;
	Thu,  5 Mar 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUmduH04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669D363C68;
	Thu,  5 Mar 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749196; cv=none; b=Q/kXN/VPE+o32Sh+DZf74sVSfD/Eh/b7Jf5p86jqEBKYlCG7Zue+cWx3BM6QSsZzIFnqSR8K4A7Ke/AwFRwDoJIpRWUaTs4K+eIdq/5S+pZE8FDQVNz5n1xDtt5To4n4oXBlUKlceLXOOuIcRzx2RywoMVgJFvEGbiRbup84lHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749196; c=relaxed/simple;
	bh=zyd98cFYzfi1npqO2AZht/m5AaifmmZiVf9SXfnvfD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJu7kIsWJK/VmxBL18M/+WGQJqx11s8SnBSQREjXd0qPbzvv+JuIRuDJG15BpGEc7FjfwhJwVswpjYdyrqC6wxsJcWcL/UpFCIpWw4jZ+saArr94zxKQp4gPmbZ5l/CFt/fZeC5U8TsrlFU+iff3c0/jLWnRe5i7emNS1+gssV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUmduH04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B5EC2BCF4;
	Thu,  5 Mar 2026 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772749196;
	bh=zyd98cFYzfi1npqO2AZht/m5AaifmmZiVf9SXfnvfD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KUmduH04tIZQ8I1BpdO2VS7/GVOE7CBfJEjQV4vCHy2V4upAmURLMvyX6KcIqtPwh
	 /KVqyz/13IG60f8ph5gjWnalsNO+mAPDQKOYs+eJ4AralF3GOXdJ3w+zoKhyFb+84f
	 ab4vef5R+h20Hk7WoxQ10BcvckzDiGquruDfml94R45ZqKe6T6FOCFs0QuLn3u6di5
	 S9hGxnOcyTavf9xICnldHZSEuhj7fu//dyhqeofKcFZ7EYtKvnGxgaqnwHn1hdwH6v
	 lt0tSiDJHvN9SqZLwxO7weapA9lNOpxyjjmYssfv+D9Amry2t9d6FKd95LGPhIH40z
	 AQuvBygDNfS6g==
Date: Thu, 5 Mar 2026 14:19:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, <netdev@vger.kernel.org>,
 <kernel-tls-handshake@lists.linux.dev>, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v1 1/6] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Message-ID: <20260305141954.1f6eae5e@kernel.org>
In-Reply-To: <20260305211402.39408-2-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
	<20260305211402.39408-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3D19218DAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264572-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 16:13:57 -0500 Chuck Lever wrote:
> Evaluating a dangling pointer is undefined behavior under the C
> standard.

Reference?

