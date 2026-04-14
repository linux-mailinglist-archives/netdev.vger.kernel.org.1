Return-Path: <netdev+bounces-278455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHmUNs5A3mlvpwkAu9opvQ
	(envelope-from <netdev+bounces-278455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:27:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA23FA7D9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724D9300576C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299B3E6DD4;
	Tue, 14 Apr 2026 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nziiY2cH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F33E63AC
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173008; cv=none; b=AQq/O8s3ad/hjTIVEsJIoud9mbZhcxGYh5J1Y3vSlX5YIQwxScn22E4AoxwlbSeCq9HhIJu3K80VTK1oEQKFGhp9pnt8yRammu6cmqCQoVfNvfn5W5oTqQT8zRCCONUqpNozZQ8w7toNIRKWYGntFNj+4qzmrO4VqxFurzN20N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173008; c=relaxed/simple;
	bh=i28YYCrUHHMDpraT0Z5aLv8IuBAQodP0RU10t8qP06M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl5yzmsNTYGN9c4aLQH5sCmlwfh1mgHFgnzBiw5iQf7ONLaynx05cEdWY7NgUsFWmysJuk1oc69kQe5IUSH4aP7FL3mNx0PjdrvPQa0GDwYC8ogi3uiA2+bRpCodcFOtcPeE5Tja/9DSLPHd2465vsVGKoI+Bu75MQeWFRi2kxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nziiY2cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F5C19425;
	Tue, 14 Apr 2026 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173008;
	bh=i28YYCrUHHMDpraT0Z5aLv8IuBAQodP0RU10t8qP06M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nziiY2cHF9SaKIleFtCmSzONxdI75XT7GwROAvqbs3etvAtGuC7zRg/p2mFMsMKID
	 UKe0EpUVm/KmVEbZZjPNMUNYvh8XnzEmKQZSU+HX2ztEeQyt5xW4UuNQHqHVhk4bwZ
	 Rm11fEs0gfl3m4BjdvxG2/sBJrwSE2dmu52Fx2MD5l0lec9TmmDE7hHeKCYVmXvWrH
	 xz2ZHSXJsOg8Jbom2t+kdj/PVsfOs7tUG7U/4qlLmy9ac/dPl4dieg/xuiKxk2fBML
	 USfeDJzFTmwVPqttkH4nKaF7Xb5H/FNrZlwEsIXgX4ZpPHLBX4kBwTgbzOHzxAXIYT
	 a7DRHJZgXMwHQ==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 5/8] ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers
Date: Tue, 14 Apr 2026 14:23:00 +0100
Message-ID: <20260414132301.756968-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408131216.2662245-6-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278455-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 45DA23FA7D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers

This commit removes ixgbe_ping_all_vfs() from the link watchdog handlers
to prevent a race condition during VF initialization where a gratuitous
ping collides with the VF mailbox state machine.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8110bcf006a30..3071302901499 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8164,9 +8164,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
>  
>  	/* update the default user priority for VFs */
>  	ixgbe_update_default_up(adapter);
> -
> -	/* ping all the active vfs to let them know link has changed */
> -	ixgbe_ping_all_vfs(adapter);
>  }

How will legacy VFs (such as 82599, X540, and X550) receive link state
changes without these pings?

The commit message states that link-state changes are already communicated
to VFs through the normal mailbox protocol. However, older VFs appear to
rely on receiving an IXGBE_VT_MSGTYPE_CTS message from the PF to clear
mac->get_link_status and complete the link up sequence in
ixgbevf_check_mac_link_vf().

Without the ping, will these legacy VFs fail to read the mailbox and stay
stuck reporting the link as down?

Is the mailbox corruption race still triggerable from other paths?

If ixgbe_ping_vf() is called locklessly from process-context NDO callbacks
like ixgbe_ndo_set_vf_link_state() or ixgbe_ndo_set_vf_trust(), could it be
preempted by a hardirq triggering ixgbe_msg_task() (which correctly acquires
vfs_lock before writing to the mailbox)?

Since ixgbe_write_mbx_pf() only arbitrates between the PF and VF via the
IXGBE_PFMAILBOX_PFU hardware lock, it provides no mutual exclusion between
concurrent host threads. Could concurrent writes corrupt the IXGBE_PFMBMEM
buffer and cause the exact same VF initialization failure this patch intended
to fix?

Would wrapping the pings in spin_lock_irqsave(&adapter->vfs_lock, flags)
prevent the mailbox corruption instead of removing the pings entirely?

[ ... ]

> @@ -8197,9 +8194,6 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
>  
>  	e_info(drv, "NIC Link is Down\n");
>  	netif_carrier_off(netdev);
> -
> -	/* ping all the active vfs to let them know link has changed */
> -	ixgbe_ping_all_vfs(adapter);
>  }

Without this ping, will older VFs miss the mailbox interrupt needed to set
mac->get_link_status = 1, causing them to remain stuck reporting the link as
up indefinitely and silently drop traffic when the cable is unplugged?

This isn't a bug, but removing the calls from the link handlers appears to
leave ixgbe_ping_all_vfs() as dead code without any remaining callers in
the kernel. Should the function definition in ixgbe_sriov.c and its
declaration in ixgbe_sriov.h be removed as well?

