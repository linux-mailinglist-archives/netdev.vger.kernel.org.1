Return-Path: <netdev+bounces-288132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F4qJjVvBmqFjgIAu9opvQ
	(envelope-from <netdev+bounces-288132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:56:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DE65483B0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FABC302D909
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F233290A6;
	Fri, 15 May 2026 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpRkYZIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303730BB8A;
	Fri, 15 May 2026 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806458; cv=none; b=Al2WROWzOFxGNXBZZYIVK4r+Q8WwO1GnPDZrogNrg62uVN2wiR4ODwChesQOq/v5wEBtUhu52QTmMUw2t1toQCTWbcNxCbYoQGFhDJ4N9siBCuFANBTyMeAf9mJ21yAYnQYBwH2GbJSB29rMEatQa/VPTCFPvyUQPM5EBTcUK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806458; c=relaxed/simple;
	bh=wZOLjfrjt2pvr5Lt1w+KjqrTR1B3pH1+E6zYCPeGKk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J10vNoElfWJtjTadTMkU2yfKo1995E4o5p0+D4KsHcrJqzD7ziwiMmHR7qnJb/064xcz1K4zAU1GX6q40ORd+lH3pYWANI2Y3ONUBX3NuSWG79xtyWT/QXDLS1rmg/nyCEn8YdJ+yWWn5gL18YFT++wMiJEnUwzux0/epIOOxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpRkYZIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4946AC2BCB3;
	Fri, 15 May 2026 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806457;
	bh=wZOLjfrjt2pvr5Lt1w+KjqrTR1B3pH1+E6zYCPeGKk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VpRkYZIPeoMXJ893zZlQUcewLMttlR03IiU14nUrnaH+GD9gaeqH6PIv3glw6Ttg+
	 2qTeAoKXKAj3OHYTIKGWbBouoel60ZRRUdOMe5vkPuYED/tjFyHNUgYBnqc2MMXeYM
	 8pCCMDpPP6r42+TfL/AM8mTBA1IoIM9AOeEI82fiFmbZtQdeXDtJQasaKT29zaexvo
	 9rlBO3Jlopf2ptIqzxcwC6wO2KhvjKLxaJ44sN4keHg9757FZHM3H0lz96+2FYz5M0
	 OAs8N+7X51R/U5JOtFaKi07QwolGG+hzRtChKa+ithDBP072zapImomTfHSVi6Ljd/
	 Aqs16oiQ3NI8Q==
Date: Thu, 14 May 2026 17:54:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 bjorn@kernel.org, lorenzo@kernel.org, hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling
 for veth
Message-ID: <20260514175416.50b7eae3@kernel.org>
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 49DE65483B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-288132-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat,  9 May 2026 10:48:54 +0200 Maciej Fijalkowski wrote:
>   - the INDIRECT_CALL for taking the COW path; I wanted to preserve
>     existing behavior, but is it really needed or maybe it would be
>     possible to come up with conditions that would cover both generic
>     XDP path and veth?

Yes, the conditions are almost identical. 
I think we can OR them all together (removing dups like 
skb_head_is_locked() + cloned; skb_shinfo(skb)->nr_frags
and skb_is_nonlinear()

