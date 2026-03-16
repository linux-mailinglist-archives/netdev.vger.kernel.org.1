Return-Path: <netdev+bounces-268331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KWOACVePuGnifwEAu9opvQ
	(envelope-from <netdev+bounces-268331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:16:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFC2A1DE6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4271C301371E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA427FB18;
	Mon, 16 Mar 2026 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9FiX3Nl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967F16CD33;
	Mon, 16 Mar 2026 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702992; cv=none; b=g0sUWAJ5rzMAO3SKt0W3n6R/v9KeBXEbapkQCGBPnslAc/fT01E+3XnCd0BrRfmlePS/+Er2mTf4Iu665IIXoNcbAXx4If3jqhCPxpnH8v7bQ/n6WPZmDFC38KMwRc6grltK1BVPY8i2ma8F4KiNRWDSzebe6m2z7KPCMNbqBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702992; c=relaxed/simple;
	bh=UqdSY5k9v+jSpHH57T3QIm6Yri2yfc8HY4AryziOUpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhJZgSDO1ItCXfKQkFjxVptR5wW9hrjpvQda9bqfCFT1QOmeazf43qNgumWlk9/Me6pFabDrfgQ3+r4cVaFj46S6KtRvO0BU/lX+mmTZ21gqjqJOjINWP9VOu7ZvKrSTGWNsh0RP+057ML9xiIgjSolZuw4QjFGrb6LPeXrk5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9FiX3Nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E05FC19421;
	Mon, 16 Mar 2026 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773702992;
	bh=UqdSY5k9v+jSpHH57T3QIm6Yri2yfc8HY4AryziOUpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9FiX3Nl3Oguett192FM59kJs19skuJobGKShyE9hw4lZzsJz+4OT1zIus7VEwJhL
	 +lQMPvaWi9v3V40jYXGqJhzvhegHU78CeL6vaiw5zm98/Yle0R+aGxjy1msZp7MQUg
	 rn+b09BamG2XvR/JSok5nGwhET07gKwHmO8GxB/JIdfmFzg5r280XPXgRlcVR9BMW9
	 638jBgAVJ0G2eBrmvISoROcIsN7FKQSRU2eLzBT1GGZAL8qxZnfkJ3p3xx6DaVLNWv
	 dJuQGbQO3Lc9rrZIOOCWJ8VnQRa6MKaGmxMBIMDUMw9ca5qyt3ZBTZVpu9xDSd7Od/
	 Qic3hhpoHGAvg==
Date: Mon, 16 Mar 2026 16:16:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <anthony.l.nguyen@intel.com>, <horms@kernel.org>, <edumazet@google.com>,
 <sdf@fomichev.me>, <aleksandr.loktionov@intel.com>, <ast@kernel.org>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <hawk@kernel.org>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
 <magnus.karlsson@intel.com>, <pabeni@redhat.com>,
 <jacob.e.keller@intel.com>, <daniel@iogearbox.net>,
 <maciej.fijalkowski@intel.com>
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
Message-ID: <20260316161630.2d9ac04e@kernel.org>
In-Reply-To: <4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
	<20260313014628.1509116-1-kuba@kernel.org>
	<4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,fomichev.me,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26EFC2A1DE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 16:10:49 +0100 Alexander Lobakin wrote:
> > Does ice_dcb_ena_dis_vsi() need to acquire the netdev lock before calling
> > ice_dis_vsi_locked() and ice_ena_vsi()?
> > 
> > Looking at the disable path, ice_dis_vsi_locked() calls ice_vsi_close()
> > which goes through ice_down() -> ice_napi_disable_all() ->
> > napi_disable_locked(), and that function has netdev_assert_locked(n->dev) in
> > net/core/dev.c. Similarly, ice_vsi_close() calls
> > ice_vsi_clear_napi_queues_locked() -> netif_napi_set_irq_locked() which
> > checks netdev_assert_locked_or_invisible().
> > 
> > The enable path calls ice_ena_vsi() -> ice_open_internal() ->
> > ice_vsi_open(), and that now calls ice_vsi_set_napi_queues_locked() ->
> > netif_napi_set_irq_locked() (requires netdev lock) and ice_up_complete() ->
> > ice_napi_enable_all() -> napi_enable_locked().
> > 
> > The old code called ice_dis_vsi(vsi, locked) and ice_ena_vsi(vsi, locked)
> > where the old ice_dis_vsi() only dealt with rtnl_lock. The new code switches
> > to _locked variants that require the netdev lock but does not acquire it.
> > 
> > Callers ice_pf_dcb_cfg() and ice_dcb_process_lldp_set_mib_change() hold
> > rtnl_lock but not the netdev lock.  
> 
> Doesn't the DCB core take the netdev lock just like netdev_ops? Or it
> only takes the RTNL?

DCB is not covered by the instance lock.. but TBH purely because 
I just always forget it exists. Feel free to make it take the lock
if that makes more sense.

