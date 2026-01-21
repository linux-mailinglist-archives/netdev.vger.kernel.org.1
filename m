Return-Path: <netdev+bounces-252018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPtPBpckcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-252018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:10:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DF5BDD7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40FB0846D28
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0374963C2;
	Wed, 21 Jan 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oW9NW3NS"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779A477E5F;
	Wed, 21 Jan 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015958; cv=none; b=p2EW0xX41QN3QhNSvojZbJF2zkigt061Yh4/mv2R5xNpbJdy0peJjonNoYH3I4f9AfowiEwMDWTS1HZzOzvt4++kiL10ghNZOHW3IGOL3MZGyyAWX4JgKHyIoWafUdTHVvmsgMmsRI71upaLbzARHPamDRKkjZhFGkIUg8BZKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015958; c=relaxed/simple;
	bh=2bks8m73WzTYHNM256w3LwuuVAhavqZd4dVvilR1BPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqSGP5haXyEdD0ljHfVZ1U/Y9B3CVBx65UjhNoU/XaAdGWqOrca0obj8JNiGqg95Vf6Sq2Vo0hGC6d6b1P6SAbegF6BShBLiHHYf8e1a1tVo/ip5HD7+fo5tuHXhqpQ6Qw2wtn8mFuPnVmO6a2XA1bmYcQga8AthHjUobKiwOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oW9NW3NS; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <063f95d2-e29f-416d-8226-49a21b7c8dcd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769015948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmF3ucw3wdYGYc3gkItIc47rsbbyXIhq4pUrDh+dLJ0=;
	b=oW9NW3NSf9UgJxn+K+tHy6abM7mflb8AZSUp6MIXwbztOwhurdzUGUPv/YSVewM0n7u8Gj
	QNcpZml6Vv6fJCd+5gUYcoLGLdUpF8qqmq0AP3IZjyJhO+dTQ0hbuMA9OycrLPW5OydlRz
	Pet7TmnFaNTHVnYU8TPZ7JL2DyVWv78=
Date: Wed, 21 Jan 2026 17:18:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: Prevent duplicate registrations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Michal Michalik <michal.michalik@intel.com>,
 Milena Olech <milena.olech@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260121130012.112606-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260121130012.112606-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	TAGGED_FROM(0.00)[bounces-252018-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AA4DF5BDD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 13:00, Ivan Vecera wrote:
> Modify the internal registration helpers dpll_xa_ref_{dpll,pin}_add()
> to reject duplicate registration attempts.
> 
> Previously, if a caller attempted to register the same pin multiple
> times (with the same ops, priv, and cookie) on the same device, the core
> silently increments the reference count and return success. This behavior
> is incorrect because if the caller makes these duplicate registrations
> then for the first one dpll_pin_registration is allocated and for others
> the associated dpll_pin_ref.refcount is incremented. During the first
> unregistration the associated dpll_pin_registration is freed and for
> others WARN is fired.
> 
> Fix this by updating the logic to return `-EEXIST` if a matching
> registration is found to enforce a strict "register once" policy.
> 
> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

