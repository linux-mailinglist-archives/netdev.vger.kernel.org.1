Return-Path: <netdev+bounces-281315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INiHOfZA72lP/QAAu9opvQ
	(envelope-from <netdev+bounces-281315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB684715A1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C61893060229
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641903B52EB;
	Mon, 27 Apr 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jOtwIQwq"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C903B0AE4;
	Mon, 27 Apr 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287105; cv=none; b=OfQ9JUugCQpTw2Vz2LkGs62OSsaQNAM9XkCjP7SCU4dDliVZDbqJiCJy5ZdITrjm1H3e/XrG7BkHdj7iVm5OssYNCFBuYPijFwhTeFhm9YleyveCgubWFNVou292TgZx7gwlaFvr5T/vE2ixyQPeUxAmOE8TbVfV/PIYmF31jR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287105; c=relaxed/simple;
	bh=6pyrW8sJIANJQbRHFg8gx/scOttl8M5LrU/gaDM6qzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsUtyDTjbcpOmETEH28t/fXnCchrz4iroo27s6ToN1DiQX6GJGDKe097FZ/oyKXkMOfAUoW6zl169199mevWVCL33Pj0aBXOEa529ouw7L6HeQQ3iye7u94KEYkdBnjoj1Yg1gcnni0nMt5d37z097Mego1gG+hI56ayKpasFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jOtwIQwq; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aEkTn9BlH5RrGCS2Yw9JDIJ2OMglOp2TPgHVKf+qbEU=; b=jOtwIQwqz0sEd24VHIfShoo7tD
	KORkS6vK/lkKYbsZc5xVO9rJv0EgpX07XCe18MSpMlvvg/CQi5SjTQ/CfrWzESLuk6RZkLQaxwOem
	EhqfSF+nTpWoAKE0Oyoq+Oc0bRRIVsy0NBhascHwYOIYaUnAVnrnvi6Dne/1QWUs+4RM5eiw8k9XR
	NtTNR4jv1T/WzLx6vMP5den1C3axE8EFwX29nCNfhVpwPv6ijwA2q/2wb+/c+eyHnQh9Cz5bJfU5w
	VhN/C+hDKNTaVftVjDdmLy/WEarrjVJXc6kD3m43dAlxYUhyktK5OtLFFS09haxK87ho11HKVNe48
	tVa/vwNw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHJYo-005Qj6-1e;
	Mon, 27 Apr 2026 10:51:31 +0000
Date: Mon, 27 Apr 2026 03:51:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, k-keiichi@bx.jp.nec.com, satyam@infradead.org, 
	akpm@linux-foundation.org, thepacketgeek@gmail.com, asantostc@gmail.com, 
	gustavold@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net 2/3] netconsole: avoid clobbering userdatum value on
 truncated write
Message-ID: <ae8-qlp629HHmyAR@gmail.com>
References: <20260423-netconsole_ai_fixes-v1-2-92b8b7de9a2c@debian.org>
 <20260426083515.1127542-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426083515.1127542-2-horms@kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 7BB684715A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281315-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

On Sun, Apr 26, 2026 at 09:35:16AM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> netconsole: avoid clobbering userdatum value on truncated write
> 
> This patch tightens the boundary check on userdatum values to prevent
> strscpy() from returning -E2BIG and leaving a truncated string in udm->value.
> 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5713cb3783ef2..4bef003d9df64 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1074,7 +1074,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> >  	struct userdata *ud;
> >  	ssize_t ret;
> >  
> > -	if (count > MAX_EXTRADATA_VALUE_LEN)
> > +	if (count >= MAX_EXTRADATA_VALUE_LEN)
> >  		return -EMSGSIZE;
> >  
> >  	mutex_lock(&netconsole_subsys.su_mutex);
> 
> This patch addresses the state corruption caused by strscpy() failing, but does
> this fully resolve the issue?
> 
> The commit message notes that returning an error after modifying udm->value
> leaves the internal state out of sync until the next write. Looking slightly
> further down in userdatum_value_store():
> 
> userdatum_value_store() {
>         ...
>         ret = strscpy(udm->value, buf, sizeof(udm->value));
>         if (ret < 0)
>                 goto out_unlock;
>         trim_newline(udm->value, sizeof(udm->value));
> 
>         ud = to_userdata(item->ci_parent);
>         nt = userdata_to_target(ud);
>         ret = update_userdata(nt);
>         if (ret < 0)
>                 goto out_unlock;
>         ...
> }
> 
> If update_userdata() fails, the function jumps to out_unlock and returns an
> error to userspace. Since udm->value has already been updated with the new
> string, the next successful write to any entry on this target will unknowingly
> pack this new value into the payload, recreating the same deferred-activation
> issue.

Right, this seems to be an issue where udm->value continues to be set,
even when update_userdata() fails.

The correct approach here seems to use a bouncy bufferr.

Let me create add this exta fix in the v2.
--breno

