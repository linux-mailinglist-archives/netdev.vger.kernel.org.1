Return-Path: <netdev+bounces-288733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHpGNF+6CWqvmwQAu9opvQ
	(envelope-from <netdev+bounces-288733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:53:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838D5610A4
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0C0B30082AA
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD93630A7;
	Sun, 17 May 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5icDaQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847C35F16B;
	Sun, 17 May 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022428; cv=none; b=evZHp/4EKMWpjIHuK+vnlXiElaorg4ZIPmFYpphVBR9wo6C/K0hN659fO7pzHx57YMHJC+WP+m9obEPzQZxVkpgDkIBXpRh4wPXnyvR2JzJHSosnEghHEWjwPI4FbIrj5YI0F9MmZttU6fbDnnNckbo9qHIXlFroG4P3yj347HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022428; c=relaxed/simple;
	bh=5227o132yhYHPelozgML0w8ICBHHEAPyZwL87DcG9Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObH9BJf6FqZrFajc3AKiZInuocXswQSbIbIdw20ejAlrgYsubyDYW9xNOh3FO1KiTyrc0NBn92fhChbZwxzX5bEj9aA2gCVe9AwNf0RoeYE3micvpUuWeNO4bqxC6kWWgGqLWGNyyTrOIFcgbFRLAX5KUHrwBTiAkgnZKHBUilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5icDaQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95505C2BCB0;
	Sun, 17 May 2026 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779022427;
	bh=5227o132yhYHPelozgML0w8ICBHHEAPyZwL87DcG9Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5icDaQ3sw4UfrzLCGbWK/zhofBuqO45zU78c4xujoW97j39QOqZLFEc5n6VWNWt5
	 d/vQ8VHJC4eQS3P0Ukj1whMs73niXLv99YhxSr0WZKi5Ge7hIubwA0KiD1Fi/Yo0wE
	 UqV3o210dRbq/0kO6Aj0GPH5tJXp0xn6B1lG2+7EqEvrIPRQPZWPq1RoiEgpRgO1zK
	 Dwa9Q24+qs/SvpdY0KkJAluIxgKmURBW+74StPRX1hkQhBcfixy5vZYacijobBV4Bf
	 5ibCQjYWIvjCxFlbEAzupDRuRM8iULdRES4QWBNALnF4Wjm8G6so/XJD2skniqZx/D
	 lmCJKbMy6uGFw==
From: Simon Horman <horms@kernel.org>
To: gorcunov@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH] ice: Fix wrong dsn read in ice_adapter_put
Date: Sun, 17 May 2026 13:53:07 +0100
Message-ID: <20260517125307.287246-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agQ_xZUp3Sq905O_@grain>
References: <agQ_xZUp3Sq905O_@grain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4838D5610A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288733-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: Fix wrong dsn read in ice_adapter_put

When registering an adapter instance, the PCI configuration space is read
to fetch the DSN and generate an adapter index. If the adapter is unplugged,
the PCI space is no longer accessible, resulting in a zero value. This patch
fixes the issue by using the previously known index instead.

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c

[ ... ]

> @@ -130,13 +130,13 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
>   */
>  void ice_adapter_put(struct pci_dev *pdev)
>  {
> +	const struct ice_pf *pf = pci_get_drvdata(pdev);
> +	unsigned long index = pf->adapter->index;

Is it possible for pf->adapter to be NULL here if the device was probed in
firmware recovery mode?

If the device enters firmware recovery mode during ice_probe(), the driver
calls ice_probe_recovery_mode() and skips the ice_adapter_get() allocation.
If the device is subsequently unplugged, the memory-mapped read for the
firmware state register might return 0.

This would cause ice_is_recovery_mode() to evaluate to false in ice_remove(),
allowing the normal teardown sequence to proceed and call ice_adapter_put().
Would the unconditional dereference of pf->adapter->index then cause a NULL
pointer dereference?

Also, does this implicit cast to unsigned long bypass the XOR folding used
during insertion on 32-bit architectures?

The ice_adapters XArray is keyed by an unsigned long index. During insertion
in ice_adapter_get(), the index is computed using ice_adapter_xa_index(pdev).
On 32-bit architectures, this helper explicitly applies a bitwise XOR fold
to the 64-bit Device Serial Number:

(u32)index ^ (u32)(index >> 32)

Since pf->adapter->index is a 64-bit value, assigning it directly to a
32-bit unsigned long implicitly truncates the upper 32 bits, omitting the
XOR operation.

Because the lookup index would differ from the insertion index, xa_load()
might fail to find the adapter. Would this trigger the WARN_ON and return
early, permanently leaking the adapter memory?

>  	struct ice_adapter *adapter;
> -	unsigned long index;
>  
> -	index = ice_adapter_xa_index(pdev);
>  	scoped_guard(mutex, &ice_adapters_mutex) {
>  		adapter = xa_load(&ice_adapters, index);
> -		if (WARN_ON(!adapter))
> +		if (WARN_ON(!adapter || adapter != pf->adapter))
>  			return;
>  		if (!refcount_dec_and_test(&adapter->refcount))
>  			return;

