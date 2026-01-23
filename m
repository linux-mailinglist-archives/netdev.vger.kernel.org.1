Return-Path: <netdev+bounces-252910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M/3C/a1c2liyAAAu9opvQ
	(envelope-from <netdev+bounces-252910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:55:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D37939B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEFB23019B9B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF3246783;
	Fri, 23 Jan 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQNcaRoK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE762236E8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190898; cv=none; b=V20QWwUge5v6UquehdQR6Eo/G8ehc+0vvRpy0NNydbw0pVHv84rXO783n9v/mdU/+hNtEoP3Pbj4AFVI9GTMglwnxCLDQjcBfnGNKUWrqfpe54Lj3foVMHdgwQsuU0bGaeZ/eGbCuDbRfiDjCjmXgqWtmWAXXqW4LXvThzqK/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190898; c=relaxed/simple;
	bh=jZHzPwIW+gEBmdNrysnZ8e5NZXtHMTr4+x+9Bs3d+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+QCVDLI7swUVzxd2xfrQZdVRkglftpNXg0R/zx6VY7I3sQGuGwDWwdvsVwhJVCqd1NDaOd9gy50Te3lR+u5140+pJfh30heK2zhlJOxPh4UxNfJlHO9ulwVUjtudsCPmgOT46c7L2/vxXAA8fAjAwspoY3+k1nNHrngAGeQ2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQNcaRoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69451C19423;
	Fri, 23 Jan 2026 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190897;
	bh=jZHzPwIW+gEBmdNrysnZ8e5NZXtHMTr4+x+9Bs3d+HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQNcaRoKvWoIbdLvcdYAXZDDjtsc5Pd8J9cOhwyKK6FCdogZ7gHsFmjiAzloXvw4F
	 hBkjK/nfFSn+atKGca4KsW4r1QIZZAfqtXB0YYck2xa2dOW5lRieEB0Vwnh9sM83m/
	 qJTsaDBiuYyYRRuUGOxSJVIPY8COt9X68UJU1XEoVN8EsrhnG2CE1ZXitwQheK0aYL
	 oDGMsVTT/SPyEX30nsRlxlkUjbQRSOiEKw7DzvbIoWCAIyu2LasrIBP7uRfPGg8GSE
	 isy9GIU6ojvOwZxwThbfVesPD1zVHuknD6wN4r9WlB7imfxe+ebvAc9mUVlMvbH60u
	 a4uTO5zqIVrkA==
Date: Fri, 23 Jan 2026 17:54:53 +0000
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me,
	petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
Subject: Re: [PATCH v5 net-next 08/10] geneve: extract hint option at GRO
 stage
Message-ID: <aXO17RbleU_YnX8R@horms.kernel.org>
References: <cover.1769011015.git.pabeni@redhat.com>
 <cd0e9dc42ba83f388b604097cffe268ffcb53351.1769011015.git.pabeni@redhat.com>
 <c5f875fc-9d87-42e3-bc33-59864e206f96@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f875fc-9d87-42e3-bc33-59864e206f96@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 8B2D37939B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:57:39PM +0100, Paolo Abeni wrote:
> On 1/21/26 5:11 PM, Paolo Abeni wrote:
> > @@ -566,6 +726,25 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
> >  			goto out;
> >  	}
> >  
> > +	/* The GRO hint/nested hdr could use a different ethernet type. */
> > +	hint_off = geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
> > +	if (hint_off) {
> > +		const struct geneve_opt_gro_hint *gro_hint;
> > +
> > +		/*
> > +		 * If the hint is present, and nested hdr validation fails, do
> > +		 * not attempt plain GRO: it will ignore inner hdrs and cause
> > +		 * OoO.
> > +		 */
> > +		gh = skb_gro_header(skb, off_gnv + gh_len, off_gnv);
> > +		if (unlikely(!gh))
> > +			goto out;
> > +
> > +		gro_hint = geneve_opt_gro_hint(gh, hint_off);
> > +		if (!geneve_opt_gro_hint_validate_csum(skb, gh, gro_hint))
> > +			goto out;
> > +	}
> > +
> >  	list_for_each_entry(p, head, list) {
> >  		if (!NAPI_GRO_CB(p)->same_flow)
> >  			continue;
> 
> AI review reports a possible OoB access later on in:

Sorry, I forwarded the AI review to you and the whole world,
just now, before noticing this email.

> 
> 	if (gh->opt_len != gh2->opt_len ||
> 		    memcmp(gh, gh2, gh_len)) {
> 			NAPI_GRO_CB(p)->same_flow = 0;
> 			continue;
> 		}
> 
> specifically in the memcmp() accessing bytes not pulled yet from gh2. I
> think such OoB access is not possible: before reaching the buffer bounds
> the other packet hdr should match the current one geneve hdr, including
> the hint option. Thus, while processing the such packet, the GRO stage
> should have already pulled all the relevant data.
> 
> I think this is simply too much to get for the LLM, at least ATM.
> 
> Side note: I was sure I did the shellcheck test before posting, but nipa
> says I at very least forgot about it before some latest update (warn in
> patch 10). @Jakub: please LMK if you prefer another revision.
> 
> /P
> 

