Return-Path: <netdev+bounces-291146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PmsMGXqaEmrr1QYAu9opvQ
	(envelope-from <netdev+bounces-291146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:28:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1E5C183A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A7E300B622
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15CC2D5926;
	Sun, 24 May 2026 06:28:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434810F2;
	Sun, 24 May 2026 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779604086; cv=none; b=JuwsVjvlv8rc1TaTfFYFdZs6Q08leaXkOpfB31w7IKcVlkjeNVAFvBf/unjSo7ym6excR0bko4nKXML+tmlwp4ml9ZAt9uT/OFzWKfICAM6euv5/Q6IFv+XmAp4o2VM1ztzveAOtydWN5PhJC57w8gzh9r0DzJ3EmhbnZwNmunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779604086; c=relaxed/simple;
	bh=C56XPEmyiutI6uU+IC8A8y7eRsd2kZmjmJDlh7z1wV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ilZDvAACMM/CfWJRIf9VK2uZvFM4XerMORAyk4jCsndNGpWyGpcUCFLnuDUp5SSIEupXTR9aHZZcmWZ2mymTzHrw0LruWAQVCcNrguw9i3EuhwQXf84TLHxa6QSxKKXoIVdecsMIt5pf4vuccJfSnxE8yId9lT5XeaLjnyvXdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (unknown [47.225.56.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id D79B37D08D;
	Sun, 24 May 2026 06:19:54 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: Takao Sato <takaosato1997@gmail.com>
Cc: netdev@vger.kernel.org,  steffen.klassert@secunet.com,  w@1wt.eu,
  davem@davemloft.net,  herbert@gondor.apana.org.au,
  stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
In-Reply-To: <20260522142504.1394864-1-takaosato1997@gmail.com> (Takao Sato's
	message of "Fri, 22 May 2026 11:25:04 -0300")
References: <20260522142504.1394864-1-takaosato1997@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Sun, 24 May 2026 02:19:53 -0400
Message-ID: <m2se7h1g8m.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291146-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[chopps.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.877];
	FROM_NEQ_ENVFROM(0.00)[chopps@chopps.org,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,labn.net:email,ja.int.chopps.org:mid]
X-Rspamd-Queue-Id: B3B1E5C183A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Takao Sato <takaosato1997@gmail.com> writes:

> iptfs_consume_frags() transfers paged fragments from one socket buffer
> to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
> the same class of bug that was fixed in skb_try_coalesce() for
> CVE-2026-46300: when fragments backed by read-only page-cache pages are
> merged, the marker indicating their shared nature must be preserved so
> that ESP can decide correctly whether in-place encryption is safe.
>
> Apply the same two-line fix used in skb_try_coalesce() to
> iptfs_consume_frags().
>
> Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Takao Sato <takaosato1997@gmail.com>
> ---
>  net/xfrm/xfrm_iptfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 97bc979e5..4db85e158 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
> 	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
> 	       sizeof(fromi->frags[0]) * fromi->nr_frags);
> 	toi->nr_frags += fromi->nr_frags;
> +	if (fromi->nr_frags)
> +		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
> 	fromi->nr_frags = 0;
> 	from->data_len = 0;
> 	from->len = 0;

LGTM, Thanks!

Reviewed-by: Christian Hopps <chopps@labn.net>

