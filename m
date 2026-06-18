Return-Path: <netdev+bounces-300474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FqplAigONGpRMgYAu9opvQ
	(envelope-from <netdev+bounces-300474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BAA6A13A7
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P5OD24O9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300474-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C113001CF9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404963F58D9;
	Thu, 18 Jun 2026 15:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262603F39C6
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796036; cv=none; b=IDWQR8sG4LKy3ZTMJPgr2F5U2XjIgBAVmVwoFJo5yedaCILcQ3zwve7jHEAbDBm6kChV8b38ZP2bjjGCoymT0DDHmuHGtGi4dWDG+8NFDB6HJ7X3h70C058CufDol1dmicUhPA+ijCnwpiea9u13egTvMaGJIQ65rqJ5lQPARxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796036; c=relaxed/simple;
	bh=OrVa0zReqXo7n+ogA6KUhNoEEjkr2KChIeMLZAZt1Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfG/mBUQycVp2u2gV8aIgBwDQ9RTjwfrBGm1WPHxKwLgZvE4YTd2T/z2Aq42WkvXFyvtMtsb+4Fiu/DqiWkNge2fTy5YalbZEpsQmf6hwVSmfhc7Y3bmxM7g4s9Pz8yVEOusDikfViv0JSaqTUMRJqBrmnOGKsRYT/QJ9zKP8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5OD24O9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792281F000E9;
	Thu, 18 Jun 2026 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796034;
	bh=iJKgupwTg5WwxEIjpjz5zSB35xMfokN/RkJan+N9JxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5OD24O95OD4OIoSxLKZUCF1Lrcw//AApzFMAub/HL4F6TLp6pt6l0WuAyy8B4Z15
	 JOwN2IWMP/19DiHvnI5iL4kti87vzizOLgrc5/Dqy2NWN+FDFk2WXgCiiIojTsiCl9
	 s35V8aKkA4w4UEvnkgHs4bUYGtp5zdeI4pyvHGCymBJKQPKwURVSIhKwj/LXczULxO
	 DKE0RkmogEMiBgT4UwHeFa2R+Y3RbArBbZ3JUN4xzkWGoqNtrrzf9wQoptY9eLS4Kf
	 nLg768APq2KfVyzE6I3b3aeluls1oQpCp43O+EH64PrTsD9UFCyKucDYSAXEvoOKYB
	 3yOtN16WRQ8XA==
From: Simon Horman <horms@kernel.org>
To: robert.malz@canonical.com
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl v3] ice: retry reading NVM if admin queue returns EBUSY
Date: Thu, 18 Jun 2026 16:20:03 +0100
Message-ID: <20260618152003.909400-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617120753.1785565-1-robert.malz@canonical.com>
References: <20260617120753.1785565-1-robert.malz@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300474-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:robert.malz@canonical.com,m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56BAA6A13A7

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: retry reading NVM if admin queue returns EBUSY
    
When the admin queue command to read NVM returns EBUSY, the driver
currently treats it as a fatal error and aborts the entire read operation.
This patch adds retry logic to handle this condition.

> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c

[ ... ]

> @@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
>  					 offset, read_size,
>  					 data + bytes_read, last_cmd,
>  					 read_shadow_ram, NULL);
> -		if (status)
> -			break;
> -
> -		bytes_read += read_size;
> -		offset += read_size;
> +		if (status) {
> +			if (hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY ||
> +			    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)

[Severity: Low]
Does this check allow an extra retry execution? Since retry_cnt starts at 0, 
using a strictly greater-than check allows the loop to retry 4 times
(5 total executions) instead of the 3 executions intended by
ICE_SQ_SEND_MAX_EXECUTE.

> +				break;
> +			ice_debug(hw, ICE_DBG_NVM,
> +				  "NVM read EBUSY error, retry %d\n",
> +				  retry_cnt + 1);
> +			last_cmd = false;
> +			ice_release_nvm(hw);
> +			msleep(ICE_SQ_SEND_DELAY_TIME_MS);

[Severity: High]
Does dropping the NVM lock here violate the caller's assumption of mutual
exclusion?

Callers of ice_read_flat_nvm() typically acquire the NVM lock beforehand to
ensure an atomic read of multiple sectors without interleaved writes. By
explicitly dropping the lock during the msleep() window, another thread, VF,
or PF could acquire the NVM lock and modify the NVM before the read resumes,
potentially resulting in reading torn or inconsistent NVM data.

> +			status = ice_acquire_nvm(hw, ICE_RES_READ);
> +			if (status)
> +				break;

[Severity: High]
Can this lead to an unbalanced NVM resource lock release and potential data
corruption?

If ice_acquire_nvm() fails here, the loop breaks and returns an error with the
lock currently unheld. However, callers like ice_read_flash_module() are
unaware of this internal lock state change and will unconditionally call
ice_release_nvm() upon failure:

drivers/net/ethernet/intel/ice/ice_nvm.c:ice_read_flash_module() {
	status = ice_acquire_nvm(hw, ICE_RES_READ);
	if (status)
		return status;

	status = ice_read_flat_nvm(hw, start + offset, &length, data, false);

	ice_release_nvm(hw);
    ...

Because firmware tracks resource locks per-PF rather than per-OS-thread, this
errant second release could forcefully strip the lock from another thread on
the same PF that successfully acquired it, exposing the NVM to concurrent
modification.

> +			retry_cnt++;
> +		} else {
> +			bytes_read += read_size;
> +			offset += read_size;
> +			retry_cnt = 0;
> +		}
>  	} while (!last_cmd);
>  
>  	*length = bytes_read;

