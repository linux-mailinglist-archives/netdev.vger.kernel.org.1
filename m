Return-Path: <netdev+bounces-267262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rnCOGIZss2noWAAAu9opvQ
	(envelope-from <netdev+bounces-267262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:46:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD327C4AD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E63300D319
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9A21254B;
	Fri, 13 Mar 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMU70Twu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B075D155389;
	Fri, 13 Mar 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366402; cv=none; b=EgAWzMixXZnS1xZqYMX7/iEnTceEuwfnJkFy4tdLWSRBN+AgrC4+zfmyCc5D2E3wjrtZMB/jCsE5H1LkrTfjp0MxezhkC7/fRtQIlpr+EZahVHHOBSXHEMFUIJHfzMFb05/8X67rfOmCZj46/M2lSc1AqRs1NFIZVWO3hdUDVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366402; c=relaxed/simple;
	bh=JxLiJsJCjcSjqqg1Iejkt14acuRr9MgMMcPgKn1yzeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A60gGvc/dveS8IOloi7VluoDpWbPCgyAVnBWpesm+6LHQcdo/fuLqB2CW+ux4RBq8yM+Ff8mmYkjXMJS65ObPwWKP/Bm/abCLEK048XkphjNXaOn5e5Vwk4eFzU27hk5Cp4jHMblCECatZfjRXifetzoBVyuPRt1tFAo+x86ahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMU70Twu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54419C4CEF7;
	Fri, 13 Mar 2026 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366402;
	bh=JxLiJsJCjcSjqqg1Iejkt14acuRr9MgMMcPgKn1yzeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMU70TwufC5hBoEgocDZYlT0LM4cj5ifK7h2gplVyRXfFUVzRI9PlPqN/H2dsXh7z
	 4OrsO98xox1SanwjyggQrgGVB1UT+OEzR8PVs2qArutxeviVOHrEIRmED85oKnj+Tc
	 jsonszih7c2NUVgaliMYG+jkLSGTGC8z7azsf5WjuYKdm6okLfI/wxY35MPDTGChyF
	 Arsw8HPFXXl9z/ndCBqKk0zbRCwxU7AYQKfrjYaKhCuE5BNuExpANOT3RJOql4MnF8
	 b6OUw+6CQl1516Lqo88yJyZ1HhD3BszZKk6sIc/2E+Z+e2oeuEDYko2Cw2cP1TukqV
	 dlEKye7upvmTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	edumazet@google.com,
	sdf@fomichev.me,
	aleksandr.loktionov@intel.com,
	ast@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	magnus.karlsson@intel.com,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	daniel@iogearbox.net,
	maciej.fijalkowski@intel.com
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
Date: Thu, 12 Mar 2026 18:46:28 -0700
Message-ID: <20260313014628.1509116-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267262-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,google.com,fomichev.me,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AECD327C4AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: migrate to netdev ops lock

This commit migrates the ice driver to use netdev ops locking. Queue
management ops unconditionally enable netdev locking, so the driver now
uses _locked counterparts of NAPI configuration functions to avoid
deadlocks.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> index bd77f1c001ee..08157dc04ed6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> @@ -273,14 +273,13 @@ void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi)
>  /**
>   * ice_dcb_ena_dis_vsi - disable certain VSIs for DCB config/reconfig
>   * @pf: pointer to the PF instance
>   * @ena: true to enable VSIs, false to disable
> - * @locked: true if caller holds RTNL lock, false otherwise
>   *
>   * Before a new DCB configuration can be applied, VSIs of type PF, SWITCHDEV
>   * and CHNL need to be brought down. Following completion of DCB configuration
>   * the VSIs that were downed need to be brought up again. This helper function
>   * does both.
>   */
> -static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena, bool locked)
> +static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena)
>  {
>  	int i;
>
> @@ -294,9 +293,9 @@ static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena, bool locked)
>  		case ICE_VSI_CHNL:
>  		case ICE_VSI_PF:
>  			if (ena)
> -				ice_ena_vsi(vsi, locked);
> +				ice_ena_vsi(vsi, true);
>  			else
> -				ice_dis_vsi(vsi, locked);
> +				ice_dis_vsi_locked(vsi);

Does ice_dcb_ena_dis_vsi() need to acquire the netdev lock before calling
ice_dis_vsi_locked() and ice_ena_vsi()?

Looking at the disable path, ice_dis_vsi_locked() calls ice_vsi_close()
which goes through ice_down() -> ice_napi_disable_all() ->
napi_disable_locked(), and that function has netdev_assert_locked(n->dev) in
net/core/dev.c. Similarly, ice_vsi_close() calls
ice_vsi_clear_napi_queues_locked() -> netif_napi_set_irq_locked() which
checks netdev_assert_locked_or_invisible().

The enable path calls ice_ena_vsi() -> ice_open_internal() ->
ice_vsi_open(), and that now calls ice_vsi_set_napi_queues_locked() ->
netif_napi_set_irq_locked() (requires netdev lock) and ice_up_complete() ->
ice_napi_enable_all() -> napi_enable_locked().

The old code called ice_dis_vsi(vsi, locked) and ice_ena_vsi(vsi, locked)
where the old ice_dis_vsi() only dealt with rtnl_lock. The new code switches
to _locked variants that require the netdev lock but does not acquire it.

Callers ice_pf_dcb_cfg() and ice_dcb_process_lldp_set_mib_change() hold
rtnl_lock but not the netdev lock.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e381e2f..a8e2db6dc05a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -7563,7 +7570,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
>  		if (err)
>  			goto err_set_qs;
>
> -		ice_vsi_set_napi_queues(vsi);
> +		ice_vsi_set_napi_queues_locked(vsi);
>  	}
>
>  	err = ice_up_complete(vsi);

Does ice_ena_vsi() need to take the netdev lock before calling
ice_open_internal()?

ice_vsi_open() now calls ice_vsi_set_napi_queues_locked() which requires the
netdev lock via netif_napi_set_irq_locked() -> netdev_assert_locked_or_
invisible(). It also calls ice_up_complete() -> ice_napi_enable_all() ->
napi_enable_locked().

However, ice_ena_vsi() in ice_lib.c calls ice_open_internal() ->
ice_vsi_open() while holding only rtnl_lock, not the netdev lock. This path
is reached during PF reset rebuild:

ice_rebuild()
    ice_vsi_rebuild_by_type()
        ice_ena_vsi(vsi, false)
            ice_open_internal()
                ice_vsi_open()

The netdev lock is NOT held at this point. ice_vsi_rebuild() took and
released it earlier in ice_vsi_rebuild_by_type().

Additionally, if ice_up_complete() fails, the error path goes through
ice_down() -> ice_napi_disable_all() -> napi_disable_locked(), which has an
explicit netdev_assert_locked(n->dev) check.
-- 
pw-bot: cr

