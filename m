Return-Path: <netdev+bounces-257896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LaLcHvh3iWne9gQAu9opvQ
	(envelope-from <netdev+bounces-257896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 07:00:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E910BED3
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 07:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1152300159F
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AB23ABAA;
	Mon,  9 Feb 2026 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VtrB3o51"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B26469D
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770616820; cv=none; b=obVPghncNXkPYBWW3nItYbawl+T5t7MgECnoMv0vSPU3Alh7V+ceemOY+X+u90482FniqH5/4X9/MV31lRQlN+DZN+S0xByWRh+keA6pkon1X1jpp01sJ6mdxy4RMB8BXL8d5D2eNukO4+LuDrw/0XLGR3qvIkNPbgDEhtjcJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770616820; c=relaxed/simple;
	bh=/BxYc2RqKqnA2HpCNzzO9Ax82fwk7u5IUUIO5pvGGvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdefYDpc2BBGeF9OMgUJ7e9VBw4tRzkImC4FXNunnfmZnN8qDMvjofLCIkGFIUHWvqZZgjji71Txr0n1agc3Q9gaz2iB9Yux4zSuONeiSFzhSloDD8+kPVM+JV0D9n/JwNDq7GszhEGSjk7KKnZ9EeFbVwdWI3h+Qgmy65JK0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VtrB3o51; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AA1E6207BE;
	Mon,  9 Feb 2026 06:55:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1k781aoepWB0; Mon,  9 Feb 2026 06:55:02 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1D9FE20606;
	Mon,  9 Feb 2026 06:55:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1D9FE20606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770616502;
	bh=2IjvUfa2nTyXHq68ngqfwfmN012FcUOeA/kwWnvWCPw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VtrB3o51hEZMvs9bn7MIYfehax8CV6Rrw7NZSlIDS7v65U5LezrTeRgXQukLg5eaa
	 +n4/Atr92AdtPyx/0bJBqm88R404ADSyNcL79/0F19flM2ROGVCpEUtAKKx6LfWagi
	 xjrWAc9wVtXS08vTHSSzM0jpuWMdBTYPpZGlh2zavSfTUEufyP0uobMGGNs7XRBCbY
	 Ya1SkZaZbw7QjKRCxccL8xRwcenfxKbaftgy4HoLb9CAtoEm8SAiH4vDbe2SYCwZny
	 J2nsrSnQfNFTPIGxFJOVTbhIscLBN1Z7TGx0OyzZHPLA4yUJhoGhNmcNdGcKuWb6Kq
	 eDIdcD7J7+j/w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 06:55:01 +0100
Received: (nullmailer pid 1247013 invoked by uid 1000);
	Mon, 09 Feb 2026 05:55:01 -0000
Date: Mon, 9 Feb 2026 06:55:01 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Florian Westphal
	<fw@strlen.de>
Subject: Re: [PATCH net-next] xfrm: reduce struct sec_path size
Message-ID: <aYl2tYaNpdYVU8hN@secunet.com>
References: <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-257896-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B73E910BED3
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:14:36PM +0100, Paolo Abeni wrote:
> The mentioned struct has an hole and uses unnecessary wide type to
> store MAC length and indexes of very small arrays.
> 
> It's also embedded into the skb_extensions, and the latter, due
> to recent CAN changes, may exceeds the 192 bytes mark (3 cachelines
> on x86_64 arch) on some reasonable configurations.
> 
> Reordering and the sec_path fields, shrinking xfrm_offload.orig_mac_len
> to 16 bits and xfrm_offload.{len,olen,verified_cnt} to u8, we can save
> 16 bytes and keep skb_extensions size under control.
> 
> Before:
> 
> struct sec_path {
> 	int                        len;
> 	int                        olen;
> 	int                        verified_cnt;
> 
> 	/* XXX 4 bytes hole, try to pack */$
> 	struct xfrm_state *        xvec[6];
> 	struct xfrm_offload ovec[1];
> 
> 	/* size: 88, cachelines: 2, members: 5 */
> 	/* sum members: 84, holes: 1, sum holes: 4 */
> 	/* last cacheline: 24 bytes */
> };
> 
> After:
> 
> struct sec_path {
> 	struct xfrm_state *        xvec[6];
> 	struct xfrm_offload        ovec[1];
> 	/* typedef u8 -> __u8 */ unsigned char              len;
> 	/* typedef u8 -> __u8 */ unsigned char              olen;
> 	/* typedef u8 -> __u8 */ unsigned char              verified_cnt;
> 
> 	/* size: 72, cachelines: 2, members: 5 */
> 	/* padding: 1 */
> 	/* last cacheline: 8 bytes */
> };
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Steffen Klassert <steffen.klassert@secunet.com>


