Return-Path: <netdev+bounces-258191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKuZM6QEjGkeewAAu9opvQ
	(envelope-from <netdev+bounces-258191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:25:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BF1212BB
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C06930067BF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24742353ED7;
	Wed, 11 Feb 2026 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7QfpDZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E202AE78;
	Wed, 11 Feb 2026 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783905; cv=none; b=vBQLUdsqVrwH5aD3wrI4RMnMef//0fjx44+ZlaAPaEtWXq7124Fg6C5MWpV5V46uRnmg7Uf9jrBkcYxZtKGriV2JY0FBHuB7t0App+pEtitTKpss/VXzEUeZ9GayHkSoNCvRHOES2Wyt62Vn0CWcoyiScD7Gn2AmThxRLztvtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783905; c=relaxed/simple;
	bh=aa/15ciw0CZf6nRGl+0/9PQlvmHCJzO6DwFSP+b7Nbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaBnWVpmIENzBs8tEH2iTQCNjtBX6REvAz/Y7hwBF7CKuUM1774NQKTmY4ZwgAPm4ujDYrUxAeRByIM/dNdFvVcgyKVX3oZD/7rzlKSqVbKA+5Ku7YCRzrOFpsbLcbGhVEvhN8c8F4IAGxpO7J3yvMDHbwILFHoeJwETcYR+wRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7QfpDZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73574C4CEF7;
	Wed, 11 Feb 2026 04:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770783904;
	bh=aa/15ciw0CZf6nRGl+0/9PQlvmHCJzO6DwFSP+b7Nbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7QfpDZCvWFbniv+jz/FmTahx+1zXz6E0go7e2UJ2mmPTRWEvmJ79GB5FEq8Uz6Ap
	 kpelXlUcY2R2TSRqnyF7AlC6YG/B9CgVCDXclvTEES2NYD2mYR47TTJOLm2YJ/1jiW
	 gesvvHaLKKTw3qEc60ZfPuqssL3WtiXKz707meM2cuqdsGEdYvnf6D9UpNvU6U/YRI
	 UggwwWdFgZ3I4op6ZqPDmZBsLA2bbmhiZnWZq80BsQlRZCamrl7sJb2rZnO3SWPjEw
	 3hzPwlRGjqBUVHvYDHqoGV8mxEuhn0/XRbxeTHad/fQ5K8neJ4Ap/HSuzhKWed+7na
	 ok6cN9Z59Kr0Q==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	sx.rinitha@intel.com,
	horms@kernel.org,
	yury.norov@gmail.com,
	john.fastabend@gmail.com,
	kohei@enjuk.jp,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	alexander.nowlin@intel.com,
	daniel@iogearbox.net,
	maciej.fijalkowski@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	edumazet@google.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com,
	hawk@kernel.org,
	jacob.e.keller@intel.com,
	magnus.karlsson@intel.com,
	pmenzel@molgen.mpg.de,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com
Subject: Re: [net-next,3/9] ice: migrate to netdev ops lock
Date: Tue, 10 Feb 2026 20:24:58 -0800
Message-ID: <20260211042458.555701-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
References: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258191-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,fomichev.me,lunn.ch,intel.com,gmail.com,enjuk.jp,iogearbox.net,google.com,linux.intel.com,molgen.mpg.de,redhat.com,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 727BF1212BB
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: migrate to netdev ops lock

This commit migrates the ice driver to use the netdev ops lock by
requesting ops locking and using _locked counterparts of NAPI
configuration functions to avoid deadlocks during suspend/resume, queue
rebuild and resets.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -2308,10 +2308,14 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
> }
>
> /**
> - * ice_vsi_cfg_def - configure default VSI based on the type
> + * ice_vsi_cfg_def_locked - configure default VSI based on the type
>  * @vsi: pointer to VSI
> + *
> + * Should be called only with the netdev lock taken.
> + *
> + * Return: 0 on success, -errno on failure.
>  */
> -static int ice_vsi_cfg_def(struct ice_vsi *vsi)
> +static int ice_vsi_cfg_def_locked(struct ice_vsi *vsi)

[ ... ]

> +unroll_vector_base:
> +	/* reclaim SW interrupts back to the common pool */
> +unroll_alloc_q_vector:
> +	ice_vsi_free_q_vectors(vsi);

Should this be ice_vsi_free_q_vectors_locked(vsi)?

ice_vsi_cfg_def_locked() is called with the netdev lock held (either by
ice_vsi_cfg_def() wrapper or directly from callers like
ice_vsi_rebuild_locked()). The error path here calls ice_vsi_free_q_vectors()
which tries to acquire the netdev lock:

ice_vsi_cfg_def_locked() [netdev lock held]
  -> ice_vsi_free_q_vectors()
     -> netdev_lock(dev)  /* deadlock - already held */

This would deadlock when an error triggers unroll_vector_base or
unroll_alloc_q_vector paths (e.g., memory allocation failure in
ice_vsi_alloc_rings() or ice_vsi_alloc_ring_stats()).

[ ... ]

> @@ -2703,7 +2748,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
> {
> 	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
> 		ice_down(vsi);
>
> -	ice_vsi_clear_napi_queues(vsi);
> +	ice_vsi_clear_napi_queues_locked(vsi);

ice_vsi_clear_napi_queues_locked() expects the netdev lock to be held.
Are all callers of ice_vsi_close() holding the netdev lock?

Looking at ice_sf_dev_remove():

ice_sf_dev_remove()
  -> ice_vsi_close(vsi)  /* no netdev_lock held */
  -> ice_sf_decfg_netdev()  /* unregisters netdev later */

And ice_dis_vsi() when !netif_running(vsi->netdev):

ice_dis_vsi(vsi, false)
  -> ice_vsi_close(vsi)  /* rtnl_lock only taken when netif_running */

Both paths call ice_vsi_close() without holding the netdev lock while
the netdev is still registered, which could trigger
netdev_assert_locked_or_invisible warnings.

[ ... ]

> @@ -3069,16 +3152,17 @@
> }
>
> /**
> - * ice_vsi_rebuild - Rebuild VSI after reset
> + * ice_vsi_rebuild_locked - Rebuild VSI after reset
>  * @vsi: VSI to be rebuild
>  * @vsi_flags: flags used for VSI rebuild flow
>  *
>  * Set vsi_flags to ICE_VSI_FLAG_INIT to initialize a new VSI, or
>  * ICE_VSI_FLAG_NO_INIT to rebuild an existing VSI in hardware.
> + * Should be called only under the netdev lock.
>  *
>  * Returns 0 on success and negative value on failure
>  */
> -int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
> +int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags)

[ ... ]

> +free_coalesce:
> +	kfree(coalesce);
> +decfg:
> +	if (ret)
> +		ice_vsi_decfg(vsi);

Should this be ice_vsi_decfg_locked(vsi)?

ice_vsi_rebuild_locked() is called with the netdev lock already held
(either by the ice_vsi_rebuild() wrapper or by callers like
ice_vsi_recfg_qs()). The error path at label 'decfg:' calls ice_vsi_decfg()
which tries to acquire the lock again:

ice_vsi_rebuild_locked() [netdev lock held]
  -> ice_vsi_decfg()
     -> netdev_lock(dev)  /* deadlock - already held */

This would deadlock when an error occurs after ice_vsi_cfg_def_locked()
succeeds but a later operation fails.
-- 
pw-bot: cr

