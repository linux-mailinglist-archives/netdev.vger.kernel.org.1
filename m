Return-Path: <netdev+bounces-279105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDVLBc8i4WkBpgAAu9opvQ
	(envelope-from <netdev+bounces-279105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:56:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D34135EA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41F57307A362
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30CF1D9A5F;
	Thu, 16 Apr 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QiPVSyre"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D121D5CC6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776361832; cv=none; b=DWJPY7w46mCkg7M9Nou9igxce5EyudaOsckfMSUb++x7MPybfsGOA4hwldxJzH6LVSaqRXyyaLY2AOLf9M/aqpgT/LHkuhKAPAjdjTU7MqgybMrOYrfAO+qhdr2lDe03izDIi4mKwVXNXenhXjYnzSkRyitbE3NNYRx9+muEd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776361832; c=relaxed/simple;
	bh=iEBpxmoGYQ6/z5wnr2VhmitCxn5WFgJ9RzsrwAghSow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs2FHrGbLjWFNILNGIpJEKq3Cb89+daneihkItyPOvnfOs5FnvuQLJZK38bsQmwyE6F+cZERst72elbqd4uPRB2ykOrya/ElyKVy/3UYQhJoKj1W9Y0NgPi906Y92IQXizubFyLoaRksn1jEAkw9/KZY6uY2Ux2ExscexdHSKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QiPVSyre; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <919ce78a-45fc-4f4c-817b-154dd7c1cd00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776361819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXhWQiWYqhCW6r3ekdup8+QEuKfSdHIfYm4xq2OKTH4=;
	b=QiPVSyrejWyDHsNCEaiyiEI3lF/sWkn4f2E0ZTkTmh1mRiAXZke8yGWHta7//8qfE1RcSb
	4PsGSupK9A/Ti4o32zaomK3MBDt3jSHTa2SJcIbFW54xgOQY2ZyV8DkPfKdOM5dvBHHey5
	gO8RelDJx7140pEpKUOHav+cVsip4Ks=
Date: Thu, 16 Apr 2026 18:50:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v6 1/2] dpll: export __dpll_pin_change_ntf() for use
 under dpll_lock
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rinitha S <sx.rinitha@intel.com>, Michal Schmidt <mschmidt@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20260416113952.389405-1-poros@redhat.com>
 <20260416113952.389405-2-poros@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260416113952.389405-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279105-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 605D34135EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/04/2026 12:39, Petr Oros wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Export __dpll_pin_change_ntf() so that drivers can send pin change
> notifications from within pin callbacks, which are already called
> under dpll_lock. Using dpll_pin_change_ntf() in that context would
> deadlock.
> 
> Add lockdep_assert_held() to catch misuse without the lock held.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

