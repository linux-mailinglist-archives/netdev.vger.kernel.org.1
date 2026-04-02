Return-Path: <netdev+bounces-274508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCdnERFbzmmgnAYAu9opvQ
	(envelope-from <netdev+bounces-274508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:03:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A2388C11
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37E32305BC9F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380943DF00E;
	Thu,  2 Apr 2026 11:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E1390207
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130741; cv=none; b=Y+uWs9xwO9Ol0+5dil6w5auvkhYZmmKR+VCt6erUMmzjUC72jxNyaQKWx1UC1lxDjABQudN4XK7HYb1lQKSTMfXauAqrY8Nn/yCIA80rnXUTbGRDIVd5orI5CWIfANx/LTP7xrdYH6JU0N/gRc22RtheIsf0jg6BXSaIxzCDX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130741; c=relaxed/simple;
	bh=DQf4wN+gP9wOd+76CQ3azToMO7nVuJjvXWOrXPM0o64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG2XwTPSYhBAit4YHzzhGPXNaMfIDOMpTfm6UuPVTSLfDWx10sLnQhfnyGWjq6C0o2qJh88AQOfF5JYhZji/EVlaE6MKbVWAyXSKpVbZ9a9jTk1NU4rW2lAGrhAftg8JrqI/A2/lxgiQf7jL8ezn5IOXRR+i1OOlFWC1AnKSmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1B5E1608B3; Thu, 02 Apr 2026 13:52:07 +0200 (CEST)
Date: Thu, 2 Apr 2026 13:52:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH ipsec 1/2] xfrm: Wait for RCU readers during policy netns
 exit
Message-ID: <ac5YaN5EJQwokOq6@strlen.de>
References: <ac5TePdKtegtWiRG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5TePdKtegtWiRG@secunet.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.964];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274508-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 902A2388C11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> xfrm_policy_fini() frees the policy_bydst hash tables after flushing the
> policy work items and deleting all policies, but it does not wait for
> concurrent RCU readers to leave their read-side critical sections first.
> 
> The policy_bydst tables are published via rcu_assign_pointer() and are
> looked up through rcu_dereference_check(), so netns teardown must also
> wait for an RCU grace period before freeing the table memory.
> 
> Fix this by adding synchronize_rcu() before freeing the policy hash tables.
> 
> Fixes: e1e551bc5630 ("xfrm: policy: prepare policy_bydst hash for rcu lookups")

Reviewed-by: Florian Westphal <fw@strlen.de>

