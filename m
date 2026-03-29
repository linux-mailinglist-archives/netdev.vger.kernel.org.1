Return-Path: <netdev+bounces-273006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHw1O/yHyWmxywUAu9opvQ
	(envelope-from <netdev+bounces-273006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD164353F09
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9D633001FB2
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1138229B;
	Sun, 29 Mar 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEepYSvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A636C5BD;
	Sun, 29 Mar 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774815222; cv=none; b=QV3V7CzdexrUh67n+PeSLqshtRLaZc6X+ogdaap6gTxdbQDOBATB00RBZc8XwkQt93wz2L8RTETQrFjg3T9Ucgfd0dFJ5W0hWJNuiDZthIqZFL+2u/CoOWPC6k1DldAX+OI68+hEBq3kI4VzOKJZIMKLB1/0JOxBbxC7qmsc/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774815222; c=relaxed/simple;
	bh=SFlOA1qgDGUighbjNOa+k/5ps29jmKNN2EnfDE8Ndy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoEMsdIZiMutQ88AKs/lGOrmg0R0hwzzuWVBddxw6ljsYgRNE1YhSHkrAPkGT0wVN+fLrqRN78M5ztbFYpwr5mLYX58wo7wPAB12D0USK01nRcKiq7trXDhjlYZZcmubvXeBvDzNqeBf7X86rM4FYkEbsp3gEHGCxi4KkU4SnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEepYSvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F5C116C6;
	Sun, 29 Mar 2026 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774815222;
	bh=SFlOA1qgDGUighbjNOa+k/5ps29jmKNN2EnfDE8Ndy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEepYSvlb6n7LmTJwrXGMovjIPxKw1m2CM1C2EPY6o2JJ9l61gC+EWFw7/JkIZhOL
	 wiBQTkY641iLzxdLAH2yvFopyO0CGw/bpMaUNgQvrSvQZC1w+l5vI56ZJyx4SZiAtq
	 as30v28GTL8CbEYp1TbKydCM4A3jEaTWMfoCKgxCOCUvDNBRbgpZJEYYKpnJdXzqYV
	 jbPjuybeSeIxWghBhrVoeZyNVnSTtvlhbfog8QCKK/1Gb4fB6EAz0A323S1fjC6d4z
	 SlBUmm8tXclqATKlq8juh8NXhQNckE+Xvh2YAUi4DN4Zm3x63cOKg5lGGT9bcsV+eQ
	 9vBqqjjxg3anw==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] enic: make enic_dev_enable/disable ref-counted
Date: Sun, 29 Mar 2026 13:13:37 -0700
Message-ID: <20260329201337.2798745-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-enic-sriov-v2-prep-v2-4-f72cf716ebfa@cisco.com>
References: <20260325-enic-sriov-v2-prep-v2-4-f72cf716ebfa@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273006-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD164353F09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: make enic_dev_enable/disable ref-counted

Both the data path (ndo_open/ndo_stop) and the upcoming admin channel
need to enable and disable the vNIC device independently. Without
reference counting, closing the admin channel while the netdev is up
would inadvertently disable the entire device.

[ ... ]
> diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
> index 2cbae7c6cc3d6..659787f73cf18 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_dev.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
> @@ -131,10 +131,13 @@ int enic_dev_set_ig_vlan_rewrite_mode(struct enic *enic)
>  
>  int enic_dev_enable(struct enic *enic)
>  {
> -	int err;
> +	int err = 0;
>  
>  	spin_lock_bh(&enic->devcmd_lock);
> -	err = vnic_dev_enable_wait(enic->vdev);
> +	if (enic->enable_count == 0)
> +		err = vnic_dev_enable_wait(enic->vdev);
> +	if (!err)
> +		enic->enable_count++;
>  	spin_unlock_bh(&enic->devcmd_lock);
>  
>  	return err;
> @@ -142,10 +145,16 @@ int enic_dev_enable(struct enic *enic)
>  
>  int enic_dev_disable(struct enic *enic)
>  {
> -	int err;
> +	int err = 0;
>  
>  	spin_lock_bh(&enic->devcmd_lock);
> -	err = vnic_dev_disable(enic->vdev);
> +	if (enic->enable_count == 0) {
> +		spin_unlock_bh(&enic->devcmd_lock);
> +		return 0;
> +	}
> +	enic->enable_count--;
> +	if (enic->enable_count == 0)
> +		err = vnic_dev_disable(enic->vdev);
>  	spin_unlock_bh(&enic->devcmd_lock);
>  
>  	return err;

If vnic_dev_enable_wait() fails, enable_count remains 0. However, the data
path caller enic_open() ignores the return value of enic_dev_enable() and
unconditionally returns 0:

drivers/net/ethernet/cisco/enic/enic_main.c:enic_open() {
    ...
	enic_dev_enable(enic);

	for (i = 0; i < enic->intr_count; i++)
		vnic_intr_unmask(&enic->intr[i]);
    ...
	return 0;
}

Can this cause the device reference count to become unbalanced?

If enic_dev_enable() fails during enic_open(), the interface is marked
logically up but enable_count remains 0. If enic_stop() is called later,
enic_dev_disable() will return early since the count is 0, skipping the
hardware disable command.

Additionally, if the new admin channel calls enic_dev_enable() while
the device is in this state, it will increment the count from 0 to 1.
When the admin channel later calls enic_dev_disable(), the count will
drop back to 0 and issue vnic_dev_disable(), incorrectly disabling the
hardware while the netdev data path is still up.

Should enic_open() check the return value of enic_dev_enable() and
handle failures appropriately, or should the enable_count be incremented
regardless of the hardware command success to keep the logical states
aligned?
-- 
pw-bot: cr

