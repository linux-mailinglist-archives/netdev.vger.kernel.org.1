Return-Path: <netdev+bounces-300969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id deNmKgflOGoujwcAu9opvQ
	(envelope-from <netdev+bounces-300969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C16AD436
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:32:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dVPg5kH3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300969-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300969-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B904A300F0E7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DFD36E46C;
	Mon, 22 Jun 2026 07:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D236E467
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113464; cv=none; b=M+ToSqsSnv/8zqq84LBCxYflNe1ZbIXhDasoU4skDFaoDW6oo2Bu0pfDDNiVWvo79SEW/jDz2ef6YuQ9dyh84U7k9/Tza9NIykEL2e2Z1QsAfCuo7t3VJwUFwZ0EhiO65YczoXOIXRWaYL3NsFThfkCKPOKn3zuFHHb8szx7GoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113464; c=relaxed/simple;
	bh=/hZQCbviLRk9vV3M1eYr1w9VvAaN49TuUMxh+uysLuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jauhkkba4nn1ZHm5mOGPUuyGmU5YV3r1Vrxv/lkWAIYoOMqTHxdNrSAHipd11Jm/JZ93orXdq2d+ZCA1e7HciB1q28L/w7DlSZ+9hvrCoMCSS2bOG4ElNjwJqmQQjgU8fLbAsjn756itUXOLCGYdCvA/v27Ok/2NVp7JhGBNWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVPg5kH3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4EF1F00A3A;
	Mon, 22 Jun 2026 07:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782113462;
	bh=dMPvIEI+w93HiuN2NS/tC8/gWcQxei3DMqgg6cViNHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dVPg5kH3s9VjfqirB886mN5sK8U4oSArE0GakJrwBZdxN7EsROvMtOlmeDfNcpuzd
	 EPMxpu1PgybMndIJV50HEz3jvtk6zXn8HgJPYfG8ikR91uNWer1My0cikRxUyvD1C2
	 SAqNUmZ+cwNOBxNipAStyDqK4LqgEW11ncOe/pDsVg0VyUu7bKa/u+QayZo0uyNRUN
	 A21WUieVNdVgY73TFPvXpo48LHai3mKj9dYOSlfGJaofQzmwZhdcQt4vGDTTzwjDTy
	 LUYhCuZ6uf9FfWjH7WYVIZK3pzaT1Wl+iO2/tVnhbtMpG/ASsl0KoROUWDxPXZbQf2
	 FMEf6WGtiDpwQ==
Date: Mon, 22 Jun 2026 08:30:58 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, madhu.chittim@intel.com
Subject: Re: [PATCH iwl-net] idpf: fix max_vport related crash on allocation
 error during init
Message-ID: <20260622073058.GY827683@horms.kernel.org>
References: <20260618192325.8694-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618192325.8694-1-emil.s.tantilov@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300969-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:emil.s.tantilov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:madhu.chittim@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A23C16AD436

On Thu, Jun 18, 2026 at 12:23:25PM -0700, Emil Tantilov wrote:
> Set adapter->max_vports only after successful allocation of vports, netdevs
> and  vport_config buffers. This fixes possible crashes on reset or rmmod,
> following failed allocation on init
> 
> [  305.981402] idpf 0000:83:00.0: enabling device (0100 -> 0102)
> [  305.994464] idpf 0000:83:00.0: Device HW Reset initiated
> [  320.416872] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  320.416918] #PF: supervisor read access in kernel mode
> [  320.416942] #PF: error_code(0x0000) - not-present page
> [  320.416963] PGD 2099657067 P4D 0
> [  320.416983] Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> [  320.417093] RIP: 0010:idpf_remove+0x118/0x200 [idpf]
> [  320.417130] Code: 8b bb 98 09 00 00 e8 17 0f 5b e5 48 8b bb e8 08 00 00 e8 0b 0f 5b e5 66 83 bb 28 06 00 00 00 48 8b bb 20 06 00 00 74 49 31 ed <48> 8b 04 ef 48 85 c0 74 2f 48 8b 78 20 e8 66 58 91 e5 48 8b 83 20
> [  320.417183] RSP: 0018:ff7322212903fdb8 EFLAGS: 00010246
> [  320.417205] RAX: 0000000000000000 RBX: ff4463de40300000 RCX: ff7322212903fd4c
> [  320.417228] RDX: 0000000000000001 RSI: ffffffffa7f7d100 RDI: 0000000000000000
> [  320.417250] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  320.417272] R10: 0000000000000001 R11: ff4463de3a638f58 R12: ff4463be89ac7000
> [  320.417294] R13: ff4463be89ac7198 R14: ff4463be94fc7198 R15: ffffffffc0f10f20
> [  320.417317] FS:  00007f963c0e6740(0000) GS:ff4463fdd65d8000(0000) knlGS:0000000000000000
> [  320.417342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  320.417362] CR2: 0000000000000000 CR3: 00000020ba674002 CR4: 0000000000773ef0
> [  320.417385] PKRU: 55555554
> [  320.417398] Call Trace:
> [  320.417412]  <TASK>
> [  320.417429]  pci_device_remove+0x42/0xb0
> [  320.417459]  device_release_driver_internal+0x1a9/0x210
> [  320.417492]  driver_detach+0x4b/0x90
> [  320.417516]  bus_remove_driver+0x70/0x100
> [  320.417539]  pci_unregister_driver+0x2e/0xb0
> [  320.417564]  __do_sys_delete_module.constprop.0+0x190/0x2f0
> [  320.417592]  ? kmem_cache_free+0x31e/0x550
> [  320.417619]  ? lockdep_hardirqs_on_prepare+0xde/0x190
> [  320.417644]  ? do_syscall_64+0x38/0x6b0
> [  320.417665]  do_syscall_64+0xc8/0x6b0
> [  320.417683]  ? clear_bhb_loop+0x30/0x80
> [  320.417706]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  320.417727] RIP: 0033:0x7f963bb30beb
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, an AI generated review of this patch is available on sashiko.dev.
I think that the issue raised there can be looked at in the context of
possible follow-up.

