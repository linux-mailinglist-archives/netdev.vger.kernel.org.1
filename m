Return-Path: <netdev+bounces-291975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NZiNXEsFmqdigcAu9opvQ
	(envelope-from <netdev+bounces-291975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:27:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D52395DD8AF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D99EC30091C5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3ED3CE4A6;
	Tue, 26 May 2026 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAwRHmmj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A1236A73
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838059; cv=none; b=iX7xDPH5c5N5is/x7KI/pwsxWKwNgcgAWbuIF9VQGAf11wskzzT6r6KX2gweFDe7z3gHdCHMC0Vxw8RajlZ4gbcWsSV7SD99h/Alm3WjjqUJbSogtPAp943KOEiufZfmKGhTjYav0LuQ8mGKj3KxfdVtfoaGt2lH/riPNgz3aOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838059; c=relaxed/simple;
	bh=XWKRugdBCbif77kQ32/usUUQ8ogLQokJ6R2uYwHANV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEW0MQlWZQHHgyQTS/k7SZvo+bRdc96yMccmbhLOc1QGsvE5ZiaVC4H7p4g4QsjJ9EXEFkJhKb6ZH1vM9Eeg4dnyzClGllU7vdvcFPVXFBW03/FFIwVNeSpEuYtfXmRkNTos9g9z8KqhlZZUmVlhfNKMc+zMWRHdLUgw9IoqJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAwRHmmj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BCD1F000E9;
	Tue, 26 May 2026 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779838057;
	bh=a3/WNsXLG/efdLWwGaD+Ah5amorSSkLH88yA5nIIbBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WAwRHmmjI17Nfyf0gAQBHmUZ33+5IUC80Ba8gEJKVVHkap3/NJz72Gvfhf1OVnnGd
	 sr72Jr7LKXbS1+mTIwUTz5T6QsgssH6M0ofKVZ8RqobKX0qM6D9YhOrzoEf0I4XBsw
	 IIRr88ZXnNrfS/QzeaY328UVWsiieeFJiSNdk16WjB3lTFx+nwuowb/12lNqmaXXHc
	 2Y1arUYIAPTaRLn1CG/cCPE0jlpFjDmMvHVo4oTf67ckpAIq0/Skp0gA3ZjlCTHcsV
	 cxE3W+16LliY+FQkooWMNorkC96KXdF/g8VGQHTAiwNiujZlluQFv/ILeOgSXJyHdp
	 /eglcrpUBslpQ==
Date: Tue, 26 May 2026 16:27:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Zhao Dongdong <winter91@foxmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>, Zhao
 Dongdong <zhaodongdong@kylinos.cn>
Subject: Re: [PATCH] net: page_pool: check nla_nest_start() return value in
 page_pool_nl_stats_fill()
Message-ID: <20260526162736.5e95b928@kernel.org>
In-Reply-To: <3a16e1ec-313d-431e-8960-abf55701ac5a@intel.com>
References: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
	<3a16e1ec-313d-431e-8960-abf55701ac5a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foxmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-291975-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email]
X-Rspamd-Queue-Id: D52395DD8AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 18:04:44 +0200 Alexander Lobakin wrote:
> From: Zhao Dongdong <winter91@foxmail.com>
> Date: Tue, 26 May 2026 14:51:56 +0800
> 
> > From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> > 
> > nla_nest_start() can return NULL if the skb runs out of space.
> > page_pool_nl_stats_fill() does not check the return value before
> > calling nla_nest_end(), which can lead to a NULL pointer dereference.
> > Add a NULL check after nla_nest_start() and abort the message if it fails.
> > 
> > Fixes: d49010adae73 ("net: page_pool: expose page pool stats via netlink")  
> 
> A "Cc: stable@vger.kernel.org" candidate?

Not really, the thinking is that if nla_nest_start() failed then the
very next nla_put* will also fail (nla_nest_start() is a zero-length
attr, any attr we put after must be >= in length).

IOW the commit message is lying, there's no way for us to reach
nla_nest_end(). We will jump to nla_nest_cancel() which handles
nest=NULL just fine.

Zhao Dongdong please confirm this and respin the patch without a Fixes 
tag and with an updated commit message. I think we got such a patch
in the past, so we should merge it to avoid confusing bots. 
But please make it very clear that this code can't crash..
-- 
pw-bot: cr

