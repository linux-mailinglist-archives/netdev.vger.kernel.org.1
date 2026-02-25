Return-Path: <netdev+bounces-260778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGa+M6KinmlPWgQAu9opvQ
	(envelope-from <netdev+bounces-260778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:20:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E01933B4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE27305A2C5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE952E0938;
	Wed, 25 Feb 2026 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z24wLhm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71E22F177;
	Wed, 25 Feb 2026 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003978; cv=none; b=d76LxzerUZAd+1Up6N1U2JSmClFC3zTmOWdoA27HHkKT5GpzRmaGlzRriLK8ymGeUN40iqzbs9zVW/sYA2XmuZV3sSCAOL9p/3+KjNeEZbmwgIU8kWewwUtRKvWSraXWC7DD85RIiqev51NP0KXlgmx3Hmirwslksc1OkIkEKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003978; c=relaxed/simple;
	bh=A7lRttC43wF7lpKdY61+Fq1GW0SYqkp06OO3jF4y3oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls2GjI2ugw0OAx2gHcfgHMNpmWHhNqLHlply6CoxQPs8PJJFYXQcy3pkxw0bLRkZPZnDDMa0ImaO4SB/aT+1smFZwBgnA7t58DGoNFi0IHKfmp1IB3G6fFlNN8D1KucYNvPdA+1dRPS3OKxC6AbCJulZtKkQTPOI7IJUHrIObbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z24wLhm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C22C19425;
	Wed, 25 Feb 2026 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772003978;
	bh=A7lRttC43wF7lpKdY61+Fq1GW0SYqkp06OO3jF4y3oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z24wLhm5/hlhU0gkoIm6x9z2KjkAIaHXIYJV4uUyDIR+3hmm2Bl1Ycmw6+TIfLpcL
	 bdzlprkx0zhWuNM6KdsT2ER383xrUWorB+MYjjkLrUhH8WPSfmMZv5ai9+Dr62Nuqk
	 yEvyIlsaervGrjeETEBQg8ogKCxZ+bH7A+mCTe+Wwu4h4wbMH4u23XDfo/Mfhun2jA
	 hdJleBHr2kYeLtdzt7VMWUxAjImTT4y134nJTkge4cKYuTcAYRY93H5gmbl5yzfICn
	 IlOcLpRZB71TR98tr5eHZ+mjbXIc8ocAa6yULW9aAt+hOsjlchEgDrR+oCf4sdLm6A
	 6n2iLJ74d0RJw==
Date: Wed, 25 Feb 2026 09:19:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
	willy@infradead.org, brauner@kernel.org, kas@kernel.org,
	yuzhao@google.com, usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com, almasrymina@google.com,
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <aZ6ieTRCPs3IKWpp@kernel.org>
References: <20260224051347.19621-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224051347.19621-1-byungchul@sk.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 716E01933B4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:13:47PM +0900, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of @pp_magic, we should instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> Plus, add @page_type to struct net_iov at the same offset as struct page
> so as to use the page_type APIs for struct net_iov as well.  While at it,
> reorder @type and @owner in struct net_iov to avoid a hole and
> increasing the struct size.
> 
> This work was inspired by the following link:
> 
>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on the free path.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

