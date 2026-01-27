Return-Path: <netdev+bounces-253646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D0HWCooSeGkYnwEAu9opvQ
	(envelope-from <netdev+bounces-253646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:19:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB458EA5C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B9D3301FC89
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB1238D22;
	Tue, 27 Jan 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYs67asI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB8199E94;
	Tue, 27 Jan 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476741; cv=none; b=O59XD/OFDsN8lEIxKgko7aAsfNTnU8y94NfZLm1mbHEy5ieU0YRb1X90oyM5uGux99ApbLx80Vzl50cVld5689SR5z5HZNzUr8xOs3NlmbwEgHJMbvNnFmZPTomT8MpmY6/FHmyWFiurtpO7FQr+pH78h72dRCOZiWPGxi8GN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476741; c=relaxed/simple;
	bh=I7zlTeswa8SHh4ArIiC4MzQa3xWyYpORcMwR8zCd7/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBsdoFJAVJWa4549k4+X0EIEc2TaRrZ4ZtgHosBcN87WrvvgYvVtk5MAwFFmYjhqBC7oyYNYrqUZsgh+ZujyzN0hh21HI4LhTxpyNn/Z3nL0t+CEhZKCsDyHTJW3u7flIlG82mtBExl1hbtikH8sE+hy8FF1EJWEXyufHDuBW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYs67asI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684B9C116C6;
	Tue, 27 Jan 2026 01:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769476741;
	bh=I7zlTeswa8SHh4ArIiC4MzQa3xWyYpORcMwR8zCd7/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYs67asI5GUDMhYypY4QZlVkelpALPLOGilgr+6yX4s+uvYCxvJYZvetMRla+Q4mc
	 eFSCUUBUr9gL0G6K/5h06NrxGcPFekctSke3y3SdDlAq7nAjP2WDlPOZVdr3OME47s
	 /PE1rXKHtAxmP/8NC/G50T7kvRJazL39jR+zvWoXtfMzGWbVmxgWA2bZNuny6HDJh4
	 Vtj+7R9CsP4h488uYwyAl9wKnMQLtzqF12i8n56voZ+/Q3MuMjGV5lCiZN1imPbpOb
	 hTT8eHf0q7q3MC1QhV1Lcn6lA5C/BzsdCHV+Aq//TSVv82MPJZwiJjWeXpuGc7lTCK
	 +3aWCy0PgXUsw==
Date: Mon, 26 Jan 2026 17:18:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next v2] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20260126171859.5097dfb5@kernel.org>
In-Reply-To: <20260126023946.906893-1-rkannoth@marvell.com>
References: <20260126023946.906893-1-rkannoth@marvell.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,resnulli.us,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DB458EA5C
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 08:09:44 +0530 Ratheesh Kannoth wrote:
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
> 
> Devlink param multi-attribute values are considered to be dynamically
> sized arrays of u32 values, by introducing a new devlink param type
> DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> 
> Implement get/set parsing and add to the internal value structure passed
> to drivers.
> 
> This is useful for devices that need to configure a list of values for
> a specific configuration.

Could you respin this as a series with the first driver implementing
a param of this type?  We can't merge an API without a user.
-- 
pw-bot: cr

