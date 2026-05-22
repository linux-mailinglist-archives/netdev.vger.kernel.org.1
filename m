Return-Path: <netdev+bounces-290723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDiUHWAVEGphTQYAu9opvQ
	(envelope-from <netdev+bounces-290723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE15B0A64
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 832AC300577E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C932AAC6;
	Fri, 22 May 2026 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1K5dVot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D21A9F85
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438922; cv=none; b=gY8STvnfg+4TGM/3B6WSoEsqxBEUErYOuKyQOz59TO1nPwOihtDvpCvs43gWTyxSoZfCNo6PyJ9Yb90QkLo6os9lTWZAUNMFH3wzR4R/CXnZFH+JeIy9IfVIKdp7KtaA/QPTAUkkAUtlcXpaaEVSb8nb9IPDbDDWtrobaOhhmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438922; c=relaxed/simple;
	bh=1+4RD8AHA6xVe9Yam57pXo5fVUnIeIhLNaDVy+s6Zho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeah9/6A9lMxSJ/xWy/sZy08g/gIYdqB3PoxiM7wu6ro6h6b/fXFzlO0l38247RZRf/kxNYLlq9rmp8m3qGZP/iYUqHEcx5OKmMMnb7DHppdYCdcLPVEnxajfBNLTb7z4+1deaVNYsWNf+7b/6YnwMJxXVYI9RH8+5qosSNiqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1K5dVot; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C792E1F000E9;
	Fri, 22 May 2026 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779438920;
	bh=JoM/uClrQl+2MRZinFsOHtBmLH1eKT3bd0enlbi9aRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c1K5dVotxN+kvD2QRcHywC3QMDJryMa3IF96pTlLSzJtMPiHJzqP3tq53QoGcF0tM
	 +sTkOq3xVOMmm2QYxL9hbP7m7UC+fx649XFdhj76rJ37W9rj+PkhMOe1qHj413hWju
	 6FSagutMcXPu6ibeE+MAlx7MDZb5NcdLuG2sJsd9zVnGCC6w3y53HALI8SiGg0rwH6
	 Jmm0S/bTIne/zjIVxnjNj+AVFH1deGtY8K3vEDZv2uJsaxpM3mldrG24I3K/JT6TkB
	 OYcyekqCCwLeN2LSshpEZgQ6jJIjH3L2J/jsQbTuBSE93Q+SOtDIWYJz/cmNDg94kq
	 WGQ5Grs0dWupg==
Date: Fri, 22 May 2026 09:35:16 +0100
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kuba@kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: Re: [PATCH v3 iwl-net] i40e: keep q_vectors array in sync with
 channel count changes
Message-ID: <20260522083516.GH1506108@horms.kernel.org>
References: <20260519105637.839438-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519105637.839438-1-maciej.fijalkowski@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290723-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid,napi_threaded.py:url]
X-Rspamd-Queue-Id: D0BE15B0A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:56:38PM +0200, Maciej Fijalkowski wrote:
> For the main VSI, i40e_set_num_rings_in_vsi() always derives
> num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
> the user requested channel count in vsi->req_queue_pairs and the queue
> setup path uses that value for the effective number of queue pairs.
> 
> This leaves queue and vector counts out of sync after shrinking channel
> count via ethtool -L. The active queue configuration is reduced, but the
> VSI still keeps the full PF-sized q_vector topology.
> 
> That mismatch breaks reconfiguration flows which rely on vector/NAPI
> state matching the effective channel configuration. In particular,
> toggling /sys/class/net/<dev>/threaded after reducing the channel count
> can hang, and later channel-count changes can fail because VSI reinit
> does not rebuild q_vectors to match the new vector count.
> 
> Fix this by making the main VSI num_q_vectors follow the effective
> requested channel count, capped by the available MSI-X vectors. Update
> i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays when channel
> count changes.
> 
> Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
> retains its full queue capacity.
> 
> Selftest napi_threaded.py was originally used when Jakub reported hang
> on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
> i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
> identity and threaded settings survive q_vector reallocation across
> channel-count changes. This is achieved by using netif_napi_add_config()
> when configuring q_vectors.
> 
> $ export NETIF=ens259f1np1
> $ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
> TAP version 13
> 1..3
> ok 1 napi_threaded.napi_init
> ok 2 napi_threaded.change_num_queues
> ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v3:
> - address UAF when ring arrays where freed before q_vector's ring
>   containers (Sashiko, Jacob)
> - remove bool params from alloc/free array routines (Simon)
> v2:
> - NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)

I notice that there is an AI review of this patch available on sashiko.dev.
However, I believe that flags a pre-existing problem that is orthogonal to
this patch. o I do no think that review should block progress of this
patch but rather be looked at in the context of possible follow-up.

