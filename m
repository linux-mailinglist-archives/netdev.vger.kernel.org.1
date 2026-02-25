Return-Path: <netdev+bounces-260732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGjJOgFgnmmaUwQAu9opvQ
	(envelope-from <netdev+bounces-260732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:35:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F3190F39
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0DA0302CD17
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FC9290DBB;
	Wed, 25 Feb 2026 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJLP7rf0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9478DF76;
	Wed, 25 Feb 2026 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986929; cv=none; b=s1kt18YxXNVlMOdbdkYNiRWtrWAamYXhBq/UKhlEQLDuZ09nI0k8Jn8EIBMSSN3Ng0gw81mGlJTH6j7xyGDjCVIITQSXVNpYwSUU3vwM1rH0ll2l+z/mRpcR3LDAHQ+3bTiM0q7dKMAIoeHCWK569ZwDCkVPFn7IwhIPnqmLSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986929; c=relaxed/simple;
	bh=GCNigCkhCxhmteC3OPykN+XbAA3IA5VTyCCE/lVMn40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYxjqmxSwiuGRuvdvYy0vEDvgh1cRNmO+egcpcvXNJAqe0UCZJW504TewO0gXjHcGXYnC2Q+8XcQWOwA5WyjH4J83kM97WBeQsqjYHOfSxQKCd0cJDYMw7hCjCfgPqjPXEDANZEGTfhfI/JVHRwltqhX3MIjqUxgrEqu1sEr+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJLP7rf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050C9C116D0;
	Wed, 25 Feb 2026 02:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986929;
	bh=GCNigCkhCxhmteC3OPykN+XbAA3IA5VTyCCE/lVMn40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJLP7rf0sURe5/cf2E8qt0ItrntJaYQJlsqC5hQahjcrNecOUPRlhyn1+qzQWAk8I
	 pW6nI60fiVR5Hl0Je6ro8GRJZPDCbkpXEANXXvyDcy2j1szAj48aGgAr3MxJJZiPnQ
	 T48XdHSiACHTBvHGCzutBasM9BeFQB3nN/S690Z93C3g6Isn+QjVkqjLN0QrxROm2c
	 Ln2JGV9T2wBLyq0wcupdu57e+WG8MUD0ZJRCM0D6kN8V9PbmB+LT8GAypRyScqVEvo
	 cZe0U5RE/K1D3Izqy2G5oc4g4bL/clRVWC/8zaIN/kKRRPD8bFzFTLmlP6MvVWoAUK
	 F+WjUqc8FL2fg==
Date: Tue, 24 Feb 2026 18:35:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Ajit Kumar Khaparde
 <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 2/7] bng_en: query PHY capabilities and report
 link status
Message-ID: <20260224183528.757e1174@kernel.org>
In-Reply-To: <20260223163641.755200-3-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
	<20260223163641.755200-3-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260732-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 679F3190F39
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 22:06:36 +0530 Bhargava Marreddy wrote:
> +	/* To protect link related settings during link changes and
> +	 * ethtool settings changes.
> +	 */
> +	struct mutex		link_lock;
> +	struct bnge_link_info	link_info;

Why does link deserve its own lock? Are the operations slow?

bnxt was written before the netdev instance lock existed, if you're
just trying to avoid taking rtnl_lock the instance lock would do.

