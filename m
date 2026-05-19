Return-Path: <netdev+bounces-289416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOihD91MDGrjdQUAu9opvQ
	(envelope-from <netdev+bounces-289416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:43:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992357DE14
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87FB030465C2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC8397E81;
	Tue, 19 May 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6r3fD6J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211A3F4DD3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190737; cv=none; b=SzzsMLrv6KbRCl9sRGMu6tvQ3ab574+L1+64+NOUO08GX4HcMErGAzWl+R4GwdI/1/Bhgo0WPtcLw7doRMFWYIPKeCP2wL7EoZFNbVIqWhahiQyXJyvoFiBURZfJPG6GvYhn4DwWo2CoM3aGgC+FgeQK+EyEwWSHoWhgJkoHQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190737; c=relaxed/simple;
	bh=KiFpB0w9Atpxh/RMHT67LgHh+4onbI+2n/RFEPij8Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm+XFg377ywMJE+RxpbsKVhazlxCHhCd4Obr0j1GtDo4Oba9JTEfMmp7VGkhJVncBUGPCRSQQ1XkUT9Kn0G4uA+mFmivHnVd2XgukuuYt58FAd4kt/MSIukK8smV4a8qWZDDQcBgxxhheecVeGzcGKHZwCTLbDnUdyvkWZQKVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6r3fD6J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779190733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5F1bMI17kRYHb8PJHmvShGbAFsiW30BzJ/xfYQz3Rh8=;
	b=K6r3fD6JdI7kVSwxt5TqgRGwJ9RmGG1aK5AJZn1KSKFgemE/QB18E9HJzzqdUoM7mfCsYX
	UziBhpVmKSO+82pFKr1/dKX4/Wgsxo7fhDK+7I7b9JszjWJcYHainXtQ7E6r6unJN6ZJoa
	D5rRHqONu9i2muOjkd3JPr1OeRGIGnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Hjcup8OwNNSenuDVpJeCIQ-1; Tue,
 19 May 2026 07:38:51 -0400
X-MC-Unique: Hjcup8OwNNSenuDVpJeCIQ-1
X-Mimecast-MFC-AGG-ID: Hjcup8OwNNSenuDVpJeCIQ_1779190728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B057C1800367;
	Tue, 19 May 2026 11:38:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E06531800352;
	Tue, 19 May 2026 11:38:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: grzegorz.nitka@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [PATCH v9 net-next 8/8] ice: implement E825 TX ref clock control and TXC hardware sync status
Date: Tue, 19 May 2026 13:38:31 +0200
Message-ID: <20260519113831.152957-1-pabeni@redhat.com>
In-Reply-To: <20260514225946.2885623-9-grzegorz.nitka@intel.com>
References: <20260514225946.2885623-9-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289416-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 9992357DE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ice: implement E825 TX ref clock control and TXC hardware sync status

This change implements TX reference clock switching for E825 devices via
a deferred worker triggered by DPLL TXCLK pin operations, and reconciles
software state from hardware after link-up using a new TXC DPLL lock
status indicator.

A few questions inline below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 1b193e0c35ab..c9b101613fbf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> +static void ice_dpll_txclk_work(struct work_struct *work)
> +{
> +	struct ice_dplls *dplls =
> +		container_of(work, struct ice_dplls, txclk_work);
> +	struct ice_pf *pf = container_of(dplls, struct ice_pf, dplls);
> +	enum ice_e825c_ref_clk clk;
> +	bool do_switch;
> +	int err;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	do_switch = pf->dplls.txclk_switch_requested;
> +	clk = pf->ptp.port.tx_clk_req;
> +	mutex_unlock(&pf->dplls.lock);
> +
> +	if (!do_switch)
> +		return;
> +
> +	err = ice_txclk_set_clk(pf, clk);
> +
> +	mutex_lock(&pf->dplls.lock);
> +	pf->dplls.txclk_switch_requested = false;

[High]
Can a request that arrives while the worker is running be silently
dropped here?

The worker samples tx_clk_req under the lock, drops the lock to call
the slow ice_txclk_set_clk() (CPI commands plus an AN restart), then
unconditionally clears txclk_switch_requested. Consider this
interleaving:

  CPU0 (callback A)         CPU1 (worker run #1)        CPU2 (callback B)
  set tx_clk_req = A
  set flag = true
  queue_work
                            sample do_switch=true,clk=A
                            unlock
                            ice_txclk_set_clk(A)...
                                                        lock
                                                        set tx_clk_req = B
                                                        flag still true
                                                        queue_work
                                                        unlock
                            lock
                            flag = false  <-- B's flag cleared
                            unlock
                            (re-queued run #2)
                            do_switch=false; return

The hardware stays at A while pf->ptp.port.tx_clk_req == B, and the
next link-up will misinterpret B as a failed switch and revert
software state.

Would clearing the flag before invoking ice_txclk_set_clk(), or only
clearing it if pf->ptp.port.tx_clk_req still equals the snapshotted
clk under the lock, address this?

> +	if (err) {
> +		/* Roll back the requested clock to match the current hardware
> +		 * state so that ice_txclk_update_and_notify() does not
> +		 * misinterpret a future link-up as a failed switch.
> +		 */
> +		dev_err(ice_pf_to_dev(pf),
> +			"TX clock switch to %u failed, err=%d; reverting\n",
> +			clk, err);
> +		pf->ptp.port.tx_clk_req = pf->ptp.port.tx_clk;
> +	}
> +	mutex_unlock(&pf->dplls.lock);
> +}
> +

[ ... ]

> @@ -2635,11 +2690,29 @@ ice_dpll_txclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>  				 void *dpll_priv, enum dpll_pin_state state,
>  				 struct netlink_ext_ack *extack)
>  {
> -	/*
> -	 * TODO: set HW accordingly to selected TX reference clock.
> -	 * To be added in the follow up patches.
> -	 */
> -	return -EOPNOTSUPP;
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_pf *pf = p->pf;
> +	enum ice_e825c_ref_clk new_clk;
> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	if (state == DPLL_PIN_STATE_DISCONNECTED &&
> +	    p->tx_ref_src != pf->ptp.port.tx_clk_req)
> +		goto unlock;

[Low]
Should this early path return something other than 0? The kerneldoc
update for this function says "0 - success / negative - failure", but
this branch silently returns success for a DISCONNECT request that is
ignored because the pin's tx_ref_src does not match the currently
requested clock. Userspace cannot distinguish "request honored",
"request ignored", and "no-op already in target state" via the return
value.

> +
> +	new_clk = (state == DPLL_PIN_STATE_DISCONNECTED) ? ICE_REF_CLK_ENET :
> +			p->tx_ref_src;

[Low]
Should non-DISCONNECTED values besides DPLL_PIN_STATE_CONNECTED also
be accepted as a connect request? Any state value other than
DPLL_PIN_STATE_DISCONNECTED (including DPLL_PIN_STATE_SELECTABLE) is
silently treated as a connect here. Other pin-set callbacks in this
file (ice_dpll_input_state_set, ice_dpll_pin_state_set_sma) explicitly
reject unsupported states with -EINVAL.

> +	if (new_clk == pf->ptp.port.tx_clk_req)
> +		goto unlock;
> +
> +	pf->ptp.port.tx_clk_req = new_clk;
> +	pf->dplls.txclk_switch_requested = true;
> +	queue_work(pf->dplls.wq, &pf->dplls.txclk_work);
> +unlock:
> +	mutex_unlock(&pf->dplls.lock);
> +	return 0;

[Medium]
Once the worker has been queued, this returns 0 unconditionally. If
ice_txclk_set_clk() in the worker fails, the only feedback is a
dev_err and a silent rollback of tx_clk_req to tx_clk in
ice_dpll_txclk_work(). There is no extack message to userspace and no
dpll_pin_change_ntf() emitted on the rollback. After failure the next
pin-get can still report a different pin as CONNECTED because
tx_clk_req was reverted.

Would emitting a dpll_pin_change_ntf() from the worker's error path
help userspace observe that the requested switch did not occur?

>  }
>  
>  /**
> @@ -2651,10 +2724,21 @@ ice_dpll_txclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,

[ ... ]

>  static int
>  ice_dpll_txclk_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
> @@ -2663,11 +2747,18 @@ ice_dpll_txclk_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
>  				 enum dpll_pin_state *state,
>  				 struct netlink_ext_ack *extack)
>  {
> -	/*
> -	 * TODO: query HW status to determine if the TX reference is selected.
> -	 * To be added in the follow up patches.
> -	 */
> -	*state = DPLL_PIN_STATE_DISCONNECTED;
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_pf *pf = p->pf;
> +
> +	if (ice_dpll_is_reset(pf, extack))
> +		return -EBUSY;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	if (pf->ptp.port.tx_clk_req == p->tx_ref_src)
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +	mutex_unlock(&pf->dplls.lock);

[Medium]
The commit message says "TX reference selection and synchronization
status must be observed from hardware rather than inferred from user
intent", but this get callback derives state from tx_clk_req (the
user-requested value) rather than from tx_clk (the
hardware-reconciled value) or from ice_get_serdes_ref_sel_e825c().

If a switch is requested but firmware/AN never accepts it (link never
comes up, or AN restart fails after the worker rolls back tx_clk_req
to tx_clk), how long can userspace keep observing the requested pin as
CONNECTED?

>  
>  	return 0;
>  }

[ ... ]

> @@ -4674,10 +4767,21 @@ void ice_dpll_deinit(struct ice_pf *pf)
>  {
>  	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
>  
> +	/* Clear the flag under the lock so that concurrent callers of
> +	 * ice_txclk_update_and_notify() either see the cleared flag and
> +	 * return early, or are already past the check and will finish
> +	 * before we proceed to free pins and DPLL devices below.
> +	 */
> +	mutex_lock(&pf->dplls.lock);
>  	clear_bit(ICE_FLAG_DPLL, pf->flags);
> +	mutex_unlock(&pf->dplls.lock);
> +
>  	if (cgu)
>  		ice_dpll_deinit_worker(pf);
>  
> +	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
> +		cancel_work_sync(&pf->dplls.txclk_work);
> +

[High]
Is the comment above accurate? It claims concurrent callers "will
finish before we proceed to free pins and DPLL devices", but
ice_txclk_update_and_notify() drops pf->dplls.lock before invoking
dpll_pin_change_ntf(old_pin), dpll_pin_change_ntf(new_pin), and
dpll_device_change_ntf(pf->dplls.txc.dpll). Consider:

  CPU0 (link-up)                        CPU1 (rmmod)
  ice_txclk_update_and_notify()
    lock; ICE_FLAG_DPLL set; capture
    old_pin/new_pin/txc.dpll; unlock
                                        ice_dpll_deinit()
                                          lock; clear flag; unlock
                                          cancel_work_sync (drains
                                            worker only)
                                          ice_dpll_deinit_pins()
                                            -> dpll_pin_put on
                                               txclks pins
                                          ice_dpll_deinit_dpll()
                                            -> dpll_device_put
    dpll_pin_change_ntf(old_pin)  <-- UAF
    dpll_device_change_ntf(...)   <-- UAF

cancel_work_sync drains the txclk_work, but the link-change caller
that invoked ice_txclk_update_and_notify() is not synchronized.

[Medium]
Separately, this teardown cancels the worker but never invokes
ice_cpi_ena_dis_clk_ref(..., false) to undo the CPI enables performed
by ice_txclk_set_clk()/ice_txclk_enable_peer() during the driver's
lifetime. After unload, do external SyncE/EREF0 references stay
enabled in hardware on both PHYs across rmmod/modprobe?
ice_get_serdes_ref_sel_e825c() detects the currently selected clock on
re-init but cannot detect clocks that were CPI-enabled but never
AN-selected.

>  	ice_dpll_deinit_pins(pf, cgu);
>  	if (!IS_ERR_OR_NULL(pf->dplls.pps.dpll))
>  		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -3073,6 +3072,7 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>  {
>  	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
>  	struct ice_ptp *ptp = &pf->ptp;
> +	u8 port_num, phy;
>  
>  	if (!ctrl_ptp) {
>  		dev_info(ice_pf_to_dev(pf),
> @@ -3090,6 +3090,10 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>  		 &pf->adapter->ports.ports);
>  	mutex_unlock(&pf->adapter->ports.lock);
>  
> +	port_num = ptp->port.port_num;
> +	phy = port_num / pf->hw.ptp.ports_per_phy;
> +	set_bit(port_num, &ctrl_ptp->tx_refclks[phy][pf->ptp.port.tx_clk]);
> +
>  	return 0;
>  }

[Low]
Should this set_bit be guarded by a mac_type check? The tx_refclks
bitmap is sized as [ICE_E825_MAX_PHYS][ICE_REF_CLK_MAX] for the E825
feature, but this runs unconditionally on every PF. Today phy <= 1
and tx_clk == ICE_REF_CLK_ENET == 0 for non-E825 platforms, so the
write stays in bounds, but any future change to ports_per_phy or
num_lports could push phy beyond ICE_E825_MAX_PHYS.

Would adding an "if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)"
guard match the rest of the feature?

[Medium]
Also, is this write protected by any lock? Other writers in
ice_txclk_update_and_notify() take pf->dplls.lock (which is a
different mutex from ctrl_pf->dplls.lock when pf != ctrl_pf), and
readers via ice_txclk_any_port_uses() take ctrl_pf->dplls.lock. The
writer here holds neither. See related question on the writers below.

>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_txclk.c b/drivers/net/ethernet/intel/ice/ice_txclk.c
> new file mode 100644
> index 000000000000..7b3cf8fc399e
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_txclk.c

[ ... ]

> +int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
> +{
> +	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
> +	struct ice_port_info *port_info;
> +	bool clk_in_use;
> +	u8 port_num, phy;
> +	int err;
> +
> +	if (pf->ptp.port.tx_clk == clk)
> +		return 0;

[Medium]
Should this read of pf->ptp.port.tx_clk be done under
pf->dplls.lock? The field is written under that lock in
ice_txclk_update_and_notify() and the worker's rollback path. The
worker invokes ice_txclk_set_clk() after dropping pf->dplls.lock, so
a concurrent link-up on another CPU may be updating tx_clk
concurrently here.

If a stale value matches clk and this returns 0, the worker proceeds
to clear txclk_switch_requested unconditionally, silently abandoning
the AN restart the request needed.

> +
> +	if (IS_ERR_OR_NULL(ctrl_pf)) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"Can't set tx-clk: no controlling PF\n");
> +		return -EINVAL;
> +	}
> +
> +	port_num = pf->ptp.port.port_num;
> +	phy = port_num / pf->hw.ptp.ports_per_phy;
> +	port_info = pf->hw.port_info;
> +	mutex_lock(&ctrl_pf->dplls.lock);
> +	clk_in_use = ice_txclk_any_port_uses(ctrl_pf, phy, clk);
> +	mutex_unlock(&ctrl_pf->dplls.lock);
> +
> +	/* Check if the TX clk is enabled for this PHY, if not - enable it */
> +	if (!clk_in_use) {

[Medium]
Is this TOCTOU intentional? The lock is dropped between reading
clk_in_use and acting on it. When pf != ctrl_pf and two PFs
concurrently switch to the same clock on the same PHY, both observe
clk_in_use == false (the tx_refclks bits are only set later by
ice_txclk_update_and_notify() after link-up), and both proceed to
call ice_cpi_ena_dis_clk_ref().

> +		err = ice_cpi_ena_dis_clk_ref(&pf->hw, phy, clk, true);
> +		if (err) {
> +			dev_err(ice_pf_to_dev(pf), "Failed to enable the %u TX clock for the %u PHY\n",
> +				clk, phy);
> +			return err;
> +		}
> +		err = ice_txclk_enable_peer(pf, clk);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* We are ready to switch to the new TX clk. */
> +	err = ice_aq_set_link_restart_an(port_info, true, NULL,
> +					 ICE_REFCLK_USER_TO_AQ_IDX(clk));
> +	if (err)
> +		dev_err(ice_pf_to_dev(pf),
> +			"AN restart AQ command failed with err %d\n",
> +			err);
> +
> +	return err;

[Medium]
If ice_aq_set_link_restart_an() fails, the CPI enables performed
above on both the local PHY and (for SYNCE/EREF0) the peer PHY are
not undone. The worker's rollback only resets software state
(tx_clk_req = tx_clk) and never invokes ice_cpi_ena_dis_clk_ref(...,
false). tx_refclks for this port is also not yet updated, so
subsequent code has no record that the clock was enabled in
hardware.

Would adding rollback of the CPI enables on the AN-restart error
path keep driver state consistent with hardware?

> +}
> +
> +/**
> + * ice_txclk_update_and_notify - Validate TX reference clock switching

[ ... ]

> +void ice_txclk_update_and_notify(struct ice_pf *pf)
> +{
> +	struct ice_ptp_port *ptp_port = &pf->ptp.port;
> +	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
> +	struct dpll_pin *old_pin = NULL;
> +	struct dpll_pin *new_pin = NULL;

[ ... ]

> +	if (clk != pf->ptp.port.tx_clk_req) {
> +		dev_warn(ice_pf_to_dev(pf),
> +			 "Failed to switch tx-clk for phy %d and clk %u (current: %u)\n",
> +			 phy, pf->ptp.port.tx_clk_req, clk);
> +		old_pin = ice_txclk_get_pin(pf, pf->ptp.port.tx_clk_req);
> +		new_pin = ice_txclk_get_pin(pf, clk);
> +		pf->ptp.port.tx_clk = clk;
> +		pf->ptp.port.tx_clk_req = clk;
> +		/* Update the reference clock bitmap to match the hardware
> +		 * clock that was actually accepted, so that
> +		 * ice_txclk_any_port_uses() reflects reality even on failure.
> +		 */
> +		if (!IS_ERR_OR_NULL(ctrl_pf))
> +			for (int i = 0; i < ICE_REF_CLK_MAX; i++)
> +				(clk == i) ?
> +				 set_bit(ptp_port->port_num,
> +					 &ctrl_pf->ptp.tx_refclks[phy][i]) :
> +				 clear_bit(ptp_port->port_num,
> +					   &ctrl_pf->ptp.tx_refclks[phy][i]);
> +		goto err_notify;
> +	}

[Medium]
On the firmware-override branch, the bitmap is overwritten to
reflect the accepted clock, but ice_cpi_ena_dis_clk_ref(..., false)
is not invoked for the rejected clock that ice_txclk_set_clk() had
just enabled. After this point, future ice_txclk_any_port_uses()
checks will not see the rejected clock, so it will never be disabled
by subsequent code. Is this a hardware-state leak in the cross-PHY
clock-routing case?

[Medium]
Also, the writes to ctrl_pf->ptp.tx_refclks[phy][i] here happen under
pf->dplls.lock, but ice_txclk_any_port_uses() in ice_txclk_set_clk()
and ice_txclk_enable_peer() takes ctrl_pf->dplls.lock for reads.
When pf != ctrl_pf those are different mutexes. The multi-iteration
loop briefly clears the port bit in old slots before setting it in
the new slot; can a concurrent reader on ctrl_pf observe a torn
state and call ice_cpi_ena_dis_clk_ref redundantly?

> +
> +	old_pin = ice_txclk_get_pin(pf, pf->ptp.port.tx_clk);
> +	pf->ptp.port.tx_clk = clk;
> +	pf->ptp.port.tx_clk_req = clk;
> +
> +	if (IS_ERR_OR_NULL(ctrl_pf)) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"Can't set tx-clk: no controlling PF\n");
> +		goto err_notify;
> +	}
> +
> +	/* update Tx reference clock usage map */
> +	for (int i = 0; i < ICE_REF_CLK_MAX; i++)
> +		(clk == i) ?
> +		 set_bit(ptp_port->port_num,
> +			 &ctrl_pf->ptp.tx_refclks[phy][i]) :
> +		 clear_bit(ptp_port->port_num,
> +			   &ctrl_pf->ptp.tx_refclks[phy][i]);
> +
> +err_notify:
> +	/* Update TXC DPLL lock status based on effective TX clk, while still
> +	 * holding the lock to prevent concurrent link-up events from racing
> +	 * on dpll_state.
> +	 */
> +	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll)) {
> +		enum dpll_lock_status new_lock = ice_txclk_lock_status(clk);
> +
> +		if (pf->dplls.txc.dpll_state != new_lock)
> +			pf->dplls.txc.dpll_state = new_lock;
> +		else
> +			/* No change; suppress the notification below */
> +			pf->dplls.txc.dpll = ERR_PTR(-ENODEV);
> +	}

[High]
Is overwriting pf->dplls.txc.dpll with ERR_PTR(-ENODEV) here intended
as a lasting state change?

This is the only handle to the registered dpll_device returned by
dpll_device_get() during ice_dpll_init_dpll(); it is never restored
anywhere. After the first time this branch is taken:

  - Every subsequent ice_txclk_update_and_notify() will see
    IS_ERR_OR_NULL(pf->dplls.txc.dpll) true and skip the dpll_state
    update and notification. The feature becomes a permanent no-op.

  - ice_dpll_deinit() guards
    "if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
        ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);"
    so dpll_device_unregister() and dpll_device_put() are skipped on
    unload, leaking the registered DPLL device.

  - ice_dpll_deinit_pins() calls ice_dpll_deinit_txclk_pins() which
    feeds dt->dpll into ice_dpll_unregister_pins(); that becomes
    ERR_PTR(-ENODEV) passed into the dpll subsystem.

The trigger is mundane: any TX-clk switch where the new effective
clock has the same lock status as the old one (for example, both
SYNCE and EREF0 are LOCKED).

Would a local boolean ("emit_dpll_ntf") instead of mutating the
long-lived txc.dpll pointer express the suppress-one-notification
intent without these side effects?

> +	mutex_unlock(&pf->dplls.lock);
> +
> +	/* Notify TX clk pins state transition */
> +	if (old_pin)
> +		dpll_pin_change_ntf(old_pin);
> +	if (new_pin)
> +		dpll_pin_change_ntf(new_pin);
> +
> +	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
> +		dpll_device_change_ntf(pf->dplls.txc.dpll);
> +}

[High]
These three notifications run after dropping pf->dplls.lock. The
old_pin and new_pin pointers, and the txc.dpll pointer, were
captured under the lock. If ice_dpll_deinit() runs concurrently
between this unlock and the calls below, ice_dpll_deinit_pins() and
ice_dpll_deinit_dpll() can free the underlying objects before these
notification calls dereference them. cancel_work_sync() in
ice_dpll_deinit() drains the worker but does not synchronize with
the link-change caller of ice_txclk_update_and_notify(). Is some
additional synchronization needed before issuing these notifications?
-- 
This is an AI-generated review.


