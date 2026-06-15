Return-Path: <netdev+bounces-299651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XMSRCCOHMGqTUAUAu9opvQ
	(envelope-from <netdev+bounces-299651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:13:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E4C68A8D5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:13:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="DuDfk/gv";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299651-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299651-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D3230BB9A8
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0363BED55;
	Mon, 15 Jun 2026 23:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1553BED08;
	Mon, 15 Jun 2026 23:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565043; cv=none; b=paO36tHCfN2lcVEaJme3p3tJnYiBaobf+fFDuz2sHcQ7Pz6OtSkyxCnaTIfYF0hfvmhboPAo0bvb9aN6iHTTi8UeSUn2ljWp3LCT9pPBe6ibXSInJLb+p5Byd+twxOI5UqBjHGZLuvkjRFxrXwD/DT8TGcWtdadeBoOVyNo0m/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565043; c=relaxed/simple;
	bh=X8rqJlmljf51avYJ03ZFHhN8xwFAPibelchGe9jtPdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnqcqCxtoJVWLPedvYA3QoLtFu9vowuPg/55fuYZeO05045LZB771+bZ8J9Jt9efCZfHdn9dW3hd6kmjxtBUpH0YvNsAIgYaBU+3u4BqtxcTH4QRdtecZw3QFk1hyOoIDmm/SvRbHRPvB9yr4gGlD/04ib0BSX29M47UruO6LGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuDfk/gv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD8B1F000E9;
	Mon, 15 Jun 2026 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781565041;
	bh=n4uN4a+y3crJut6rAVc3LTXhazxwmnD/VCILUOEYgd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuDfk/gvnd105SzD9wRBWKGcWHJIyNL3tOmAn6RNlOZjwnkusKwDrax4xIKVEd5Kk
	 PjGldRPZjP9eeX9prImoHHmQ86Mc+T3TuI+FcdARBg/+7wxapEWU07PrlDIoo/+8+/
	 s6WCwc90ugDaabWXHwifZcGTjlxbYGpCSuLrdVL6Ar4skFZxT4Zf7bp3iHXpa4TvxE
	 +ahGL0kWQ9BFza4M94H/fQMI3I4PIPXp8pyW/eUSLfh6b0dQySAIJb8uIvnoNJ3IVu
	 rwXmpnumXDhKB9vSqaDw6ZgfUR5Ltv63Qqn0sa88yGbG5rxo7HVNu5F7smGWwQZhZ7
	 kzWFMBkNcPHrA==
From: Jakub Kicinski <kuba@kernel.org>
To: m-malladi@ti.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	elfring@users.sourceforge.net,
	haokexin@gmail.com,
	vadim.fedorenko@linux.dev,
	devnexen@gmail.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	arnd@arndb.de,
	basharath@couthit.com,
	afd@ti.com,
	parvathi@couthit.com,
	vladimir.oltean@nxp.com,
	rogerq@kernel.org,
	danishanwar@ti.com,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srk@ti.com,
	vigneshr@ti.com
Subject: Re: [PATCH net-next v7 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Mon, 15 Jun 2026 16:10:38 -0700
Message-ID: <20260615231038.1007389-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610052511.781752-2-m-malladi@ti.com>
References: <20260610052511.781752-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299651-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:kuba@kernel.org,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,users.sourceforge.net,gmail.com,linux.dev,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74E4C68A8D5

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ti: icssg-prueth: Add Frame Preemption MAC Merge support

This patch adds QoS infrastructure for Frame Preemption (FPE) in the
ICSSG Ethernet driver, including a verify state machine driver helper,
mqprio-based preemptible-tc mapping, and a link-state callback. A
follow-up patch in this series wires this up to ethtool's MAC Merge ops.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
>  		} else {
>  			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>  		}
> +
> +		icssg_qos_link_state_update(ndev);
>  	}

[Medium]
emac_adjust_link() sets emac->link = 0 before reaching this call. Inside
icssg_qos_link_state_update() -> icssg_iet_change_preemptible_tcs() ->
icssg_config_ietfpe(), the very first check is:

    if (!emac->link) {
            netdev_dbg(ndev, "cannot change IET/FPE state ... \n");
            return 0;
    }

so on a link-down the IET path returns early without clearing
iet->fpe_active or iet->verify_status, even though firmware has already
been told ICSSG_EMAC_PORT_DISABLE just above. After the follow-up patch
adds get_mm(), would ethtool then report stale tx_active=true and a
stale verify_status while the link is down?

The commit message states:

    Verify state machine re-triggers on link up/down events based on
    fpe_enabled and fpe_active flags

Is the link-down half of that contract implemented anywhere?

[Medium]
A related question on the locking design: emac->link is written here by
emac_adjust_link() without taking iet->fpe_lock, but icssg_config_ietfpe()
reads emac->link inside the fpe_lock-held critical section. The lockset
for writers and readers is disjoint, so fpe_lock does not actually
serialize emac->link.

Can the following interleaving occur?

  CPU0 (ndo_setup_tc)               CPU1 (emac_adjust_link)
  mutex_lock(&iet->fpe_lock);
  reads emac->link == 1
                                     emac->link = 0;
                                     icssg_set_port_state(... DISABLE);
  proceeds to write FPE regs
  and issue PREMPT_TX_ENABLE
  mutex_unlock(&iet->fpe_lock);
                                     icssg_qos_link_state_update();
                                       sees emac->link == 0, returns

leaving stale FPE writes on a port the firmware has just disabled? The
commit message says "fpe_lock serializes all FPE state mutations" but
emac->link is one of those mutations and is not covered.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,282 @@

[ ... ]

> +static int icssg_iet_verify_wait(struct prueth_emac *emac)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	unsigned long delay_us, timeout_us;
> +	u32 status;
> +	int ret;
> +
> +	delay_us = iet->verify_time_ms * 1000;
> +	timeout_us = delay_us * ICSSG_IET_VERIFY_ATTEMPTS;
> +
> +	ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS,
> +				 status,
> +				 status == ICSSG_IETFPE_STATE_SUCCEEDED,
> +				 delay_us,
> +				 timeout_us);
> +
> +	iet->verify_status = status;
> +	return ret;
> +}

[High]
With ICSSG_IET_MAX_VERIFY_TIME = 128 and ICSSG_IET_VERIFY_ATTEMPTS = 3,
this can sleep for up to 384ms while iet->fpe_lock is held. fpe_lock is
acquired by icssg_iet_change_preemptible_tcs() from two paths:

  - emac_tc_setup_mqprio() via .ndo_setup_tc, called with RTNL held.
  - icssg_qos_link_state_update() from emac_adjust_link(), invoked by
    phylib with phydev->lock held (prueth_emac_common_start()
    explicitly does mutex_lock(phydev->lock) before calling
    emac_adjust_link).

Once the follow-up patch wires set_mm() to write iet->mac_verify_configure,
this sleep becomes reachable from any user with CAP_NET_ADMIN. Should
the verify wait be deferred to a workqueue or a completion driven by a
firmware notification rather than block under RTNL / phydev->lock for
hundreds of milliseconds? Other drivers with MAC Merge support
(e.g. fec, stmmac) take the deferred-work approach for the same reason.

[Low]
The condition only breaks on ICSSG_IETFPE_STATE_SUCCEEDED, but the enum
also defines a distinct ICSSG_IETFPE_STATE_FAILED value reported by
firmware on a definitive verify failure. With the current condition,
would a FAILED state cause the loop to keep polling for the entire
timeout and then surface as:

    netdev_err(ndev, "MAC Verification failed with timeout\n");

even though it was not actually a timeout? Could the cond also break on
FAILED so the caller can distinguish the two?

> +int icssg_config_ietfpe(struct net_device *ndev, bool enable)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +	u8 val;
> +
> +	lockdep_assert_held(&iet->fpe_lock);
> +
> +	if (!emac->link) {
> +		netdev_dbg(ndev, "cannot change IET/FPE state when interface is down\n");
> +		return 0;
> +	}

[ ... ]

> +	if (enable && iet->mac_verify_configure) {
> +		ret = icssg_iet_verify_wait(emac);
> +		if (ret) {
> +			netdev_err(ndev, "MAC Verification failed with timeout\n");
> +			goto disable_tx;
> +		}
> +	} else if (enable) {
> +		/* Give firmware some time to update
> +		 * PRE_EMPTION_ACTIVE_TX state
> +		 */
> +		usleep_range(100, 200);
> +	}
> +
> +	if (enable) {
> +		val = readb(config + PRE_EMPTION_ACTIVE_TX);
> +		if (val != 1) {
> +			netdev_err(ndev,
> +				   "Firmware fails to activate IET/FPE\n");
> +			ret = -EIO;
> +			goto disable_tx;
> +		}
> +		iet->fpe_active = true;
> +	} else {
> +		iet->fpe_active = false;
> +	}
> +
> +	icssg_iet_set_preempt_mask(emac);
> +	netdev_dbg(ndev, "IET FPE %s successfully\n",
> +		   str_enable_disable(enable));
> +	return 0;
> +
> +disable_tx:
> +	icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +fallback:
> +	writeb(0, config + PRE_EMPTION_ENABLE_TX);
> +	writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +	iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
> +	iet->fpe_active =  false;
> +	return ret;
> +}

[Medium]
icssg_set_port_state() only synchronizes the R30 command-done handshake;
it does not guarantee firmware has finished updating the
PRE_EMPTION_ACTIVE_TX status byte. Is a 100-200us sleep a documented
worst-case latency for firmware to publish that byte under load
(concurrent Rx, TAS, FDB ageing, link events)?

If the byte has not yet been written, this code returns -EIO,
mischaracterizing it as "Firmware fails to activate IET/FPE", and the
fallback path then writes PRE_EMPTION_ENABLE_TX = 0, defeating the
user's enable. icssg_iet_verify_wait() already uses
readb_poll_timeout() for an analogous status byte; could the same
pattern be applied here with a small millisecond-range timeout?

[Medium]
The success path always calls icssg_iet_set_preempt_mask(), and on
fpe_active=false that helper takes the reset_hw branch and clears all
per-queue BIT(4) preemptive markers. The disable_tx and fallback paths
do not call icssg_iet_set_preempt_mask().

If FPE was previously active (so EXPRESS_PRE_EMPTIVE_Q_MAP[i] = BIT(4)
on some queues) and a subsequent reconfigure fails (verify timeout, or
PRE_EMPTION_ACTIVE_TX != 1), the failure paths only clear
PRE_EMPTION_ENABLE_TX / PRE_EMPTION_ENABLE_VERIFY but leave the
per-queue map and the EXPRESS_PRE_EMPTIVE_Q_MASK with stale preemptive
bits. Should the failure paths also call icssg_iet_set_preempt_mask()
(after iet->fpe_active is set to false) to keep the queue map and the
TX-enable bit consistent?

[ ... ]

> +EXPORT_SYMBOL_GPL(icssg_qos_init);

[ ... ]

> +EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);

[ ... ]

> +EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);

[Low]
Per the Makefile change in this patch:

  icssg-y := icssg/icssg_common.o \
             ...
             icssg/icssg_ethtool.o \
             icssg/icssg_qos.o

icssg_qos.o is linked into the same icssg.ko module as the only callers
(icssg_prueth.c and icssg_common.c). Are there cross-module consumers
that need these symbols exported, or can the EXPORT_SYMBOL_GPL lines be
dropped since EXPORT_SYMBOL_GPL is only required for cross-module
linkage?
-- 
pw-bot: cr

