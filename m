Return-Path: <netdev+bounces-288409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFLmH29iB2q90wIAu9opvQ
	(envelope-from <netdev+bounces-288409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA52555F94
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5954C3000B93
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253523FF1AC;
	Fri, 15 May 2026 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/QN/TKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024713FDBE9
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868717; cv=none; b=Xw6O03/6/E56urUFpiRUDS2pKVREMWfMLLBNHwJPTlPdlqhd833A1TEtV3P7fuCMzziOyhYkgV9vr71cKWJvEotWr9MbpuZuVnLRxAPGo+XIDke15aiHuyeWRtZ9GbSnpKS90gx+FaFO7/GK2Uht6Z3JwwxjcxLP50+OeRb4q9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868717; c=relaxed/simple;
	bh=alyM4fL2zP9I3YpMAWZdGzHyvU+rcfKXgtXzmLlxz5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvkNco6p/cvFfT/sRU3FJO8xK3tGSk/6JwVoUh6aQWoQ+1ZPlSi2tWBKEIIENFy6jCdY/YM6cKBW/0UwziKsyN6jwQo422MJT9CijHJ2iCTvhcmgz8AS0ZjUnRFszUVsc0SwGBLWHH5vFGPvrQptuh9C2gU6kLrOVwKZcl8uVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/QN/TKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03530C2BCB0;
	Fri, 15 May 2026 18:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868716;
	bh=alyM4fL2zP9I3YpMAWZdGzHyvU+rcfKXgtXzmLlxz5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/QN/TKFkDsP9Npdr4s7C/jmY7qzNZpRsZWIkLAQsQnzFeLtkykbKK/wKfm00YF3i
	 uuZ8lT4rLbru7G111nyIAt6Zk4RZVkgsWF0CaoLMx/CyJqKDTsN/z3qDf9B+M4ILpU
	 O7We8tKrTeNcQrSlUonWmx/V7EJswXiS2BtlW0uOTDL4lnqZ5n87OqLy2IuyMFWmhl
	 1PV4eKNHKn2aH7//cTSfyZBDYBeRqkFd5hioCoWFSDNQzJp4j4m7qpNLgDSTwwczwj
	 ZBfRJUhJc+rJq5DnqA2YRYK6qGzhywa8Wr96sLI5qJQ2paqelbCN76YYwFGlvlQH8u
	 NEkFCzfC+jYlA==
From: Simon Horman <horms@kernel.org>
To: przemyslaw.korba@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH iwl-net] ice: suppress DPLL errors during reset recovery
Date: Fri, 15 May 2026 19:11:11 +0100
Message-ID: <20260515181111.272950-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
References: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FA52555F94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288409-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: suppress DPLL errors during reset recovery

This commit suppresses DPLL error logging and counter increments when the admin
queue returns EBUSY. The intent is to avoid unnecessary warnings and prevent
the DPLL periodic worker from being disabled during reset recovery.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 0704e92ab0430..78b8836b534b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -784,7 +784,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
>  				   ret,
>  				   libie_aq_str(pf->hw.adminq.sq_last_status),
>  				   pin_type_name[pin_type], pin->idx);
> -	else
> +	else if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)

Could this check of sq_last_status race with other admin queue commands?

The sq_last_status field seems to be global state that is modified by any
admin queue command. If this is checked outside of the admin queue lock,
could another thread (like an ethtool operation) issue an admin queue
command and overwrite sq_last_status before this check runs?

If it gets overwritten to LIBIE_AQ_RC_OK, this would falsely evaluate as not
EBUSY and log the error anyway, incrementing the error counter.

[ ... ]

> @@ -2955,7 +2957,9 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
>  	    d->periodic_counter % dp->phase_offset_monitor_period == 0)
>  		ret = ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);

Does the reset recovery suppression also need to be applied inside
ice_dpll_pps_update_phase_offsets()?

If ice_aq_get_cgu_input_pin_measure() fails with EBUSY during reset recovery,
it looks like ice_dpll_pps_update_phase_offsets() only checks for
LIBIE_AQ_RC_EAGAIN before logging an error, which might still spam the log
with EBUSY errors.

>  	if (ret) {
> -		d->cgu_state_acq_err_num++;
> +		/* EBUSY is expected during reset recovery */
> +		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
> +			d->cgu_state_acq_err_num++;
>  		/* stop rescheduling this worker */
>  		if (d->cgu_state_acq_err_num >
>  		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {

By skipping the increment of the error counter on EBUSY, will this create an
unbounded polling loop?

Looking at the end of ice_dpll_periodic_work():

resched:
    kthread_queue_delayed_work(d->kworker, &d->work,
                               ret ? msecs_to_jiffies(10) :
                               msecs_to_jiffies(500));

If the firmware gets wedged and persistently returns EBUSY, the error
threshold will never be reached, and the worker will continue to hammer the
admin queue every 10ms forever. Is it expected to poll this frequently
without a backoff mechanism or an upper bound?

