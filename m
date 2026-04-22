Return-Path: <netdev+bounces-280383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED0SLT+p6GnEOQIAu9opvQ
	(envelope-from <netdev+bounces-280383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:55:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3BF44504C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4486300EB41
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903423CC9F2;
	Wed, 22 Apr 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArQE3mYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20AEEC0;
	Wed, 22 Apr 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855327; cv=none; b=jpuA573BIWdVk72lDQl8P1S8XZCaIoYfoWvBHKg37Ssr3FMBnvhor/CSmHV//Z23VC6kTO4+zQzC3cIifHNJbutj/sbyumLGDQaQShEkr0Va+hvnoTG345okCJbPJ1YJsLfkTwpYHvK9HEQXnNtaujAsNo2jwriA+Q4QAJmfCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855327; c=relaxed/simple;
	bh=Cv/dvtt9j+p8MbtSj7Sysg2FpL5y9fNb3weRLkynaWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBjME7YrnCM9kKmrxEzPG4cqCogfh8UjJat7dgF/YkZpxiMu3PXBeAEV5HrgnkrhNNqzo4UhzVyq5wf//Kb6uga33tctBgg4c7WphDZ9wgODJyDYCp1tVGiD1qtyICpiAPC/5sxdSbKQK4PSkAt2lJJ9FHPmnBh86P1sFb775tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArQE3mYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEDDC19425;
	Wed, 22 Apr 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776855327;
	bh=Cv/dvtt9j+p8MbtSj7Sysg2FpL5y9fNb3weRLkynaWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArQE3mYUDYrhzX+54sLB9RhfxEf5H81CS8mcbi8mUaELpUurEgvq9posUW1zfxq6u
	 GX6wuyTtjA3YLevsf+u39UeeqLTY3Z0nJlD/VZOOapW+QFvCJttxJRHSmbDVL+plNg
	 i2Ozp3hU7kcwCQR4y+eAgFN0veEmgAdsohrCK2fa3JPWa+hKy98tmpEPLfemuLS55b
	 Nzzn4MX5/ehEIhigE2mtIobktFku2Bl5yBSTzYzHh44GLABvYxfFPgjjcjr4EpgB6a
	 dC1GlMsWFvHbhiSyINSlWef96SBv64+oya2Aqy8R6UidGyiD2vfjRuPfYSlP2idFmv
	 hE3qjQvZPG9sA==
Date: Wed, 22 Apr 2026 11:55:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net,
	skhan@linuxfoundation.org, marcel@holtmann.org,
	luiz.dentz@gmail.com, mchehab+huawei@kernel.org,
	jani.nikula@intel.com, gregkh@linuxfoundation.org,
	demarchi@kernel.org, rdunlap@infradead.org, justonli@chromium.org,
	ivecera@redhat.com, jonathan.cameron@huawei.com, kees@kernel.org,
	marco.crivellari@suse.com, ferr.lambarginio@gmail.com,
	nihaal@cse.iitm.ac.in, mingo@kernel.org, tglx@kernel.org,
	linmq006@gmail.com, linux-doc@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
Message-ID: <20260422105516.GN651125@horms.kernel.org>
References: <20260421022108.1299678-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,lwn.net,linuxfoundation.org,holtmann.org,gmail.com,kernel.org,intel.com,infradead.org,chromium.org,huawei.com,suse.com,cse.iitm.ac.in];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE3BF44504C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 07:21:07PM -0700, Jakub Kicinski wrote:
> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
> from the kernel tree.
> 
> ISDN is a pretty old technology and it's unclear whether anyone still
> uses it. I went over the last few years of git history and all the
> commits are either tree-wide conversions or syzbot/static analyzer
> fixes.
> 
> When we discussed removal in the past IIRC there were some concerns
> about ISDN still being used in parts of Germany. Unfortunately, the
> code base is quite old, none of the current maintainers are familiar
> with it and AI tools will have a field day finding bugs here.
> 
> Delete this code and preserve it in an out-of-tree repository
> for any remaining users:
> https://github.com/linux-netdev/mod-orphan
> 
> UAPI constants AF_ISDN/PF_ISDN and the SELinux isdn_socket class
> are preserved for ABI stability, but the rest of uAPI is removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


