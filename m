Return-Path: <netdev+bounces-290657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA22ANbKD2obPwYAu9opvQ
	(envelope-from <netdev+bounces-290657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:17:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF15AE470
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D7C43008C0A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB931197B;
	Fri, 22 May 2026 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdBJdGkr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AB1E8332
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419859; cv=pass; b=QRxoP/FfH3LHxgtkCWWRtbZjTlvtPycRnMaiCAZwcZDvlOENU8qAPAcn4W3Ex0bBZWTaBh1jm0pu1nyeg5aVtbPt1TL3IcbuoIBMusFaD8KaCHedpq6gFuIfE0aETqfUsWOFxlVc4puvZqrfFWTyGq4QIHCOWkqSI2dyzqrlMWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419859; c=relaxed/simple;
	bh=j99GBY2z5Xu92Yp00HFMB1qnKMRK75hvdfSVk8I1hAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMz6JqWXVvbCKE8RXqne9Hvd2pwcIJ/eBPCSBjy1kcQGwny9w4y1QuSV8OUEqQcUF6iqUN17eDQCChoMrOoLtQAfo5FC6Qgc/9zd0ZvXhBJkGgBXZ4P3EioQJ9VhAxMQJDTi+z+7yBltX28BVsLtdEJV9e6yQRgbcQgduasSkY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdBJdGkr; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1357c851a48so8458322c88.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779419857; cv=none;
        d=google.com; s=arc-20240605;
        b=NLRUAuGXPkOuiD9LcBU72aT70YjI+pa0VG3Vji7JUxaK9Za+3B/NF/QsDas71OCWc4
         G9Al0zBYbymENNuzaGnNLO/d9KTIG2I+qVoINQsuYx6xlZ/UIFD0m2hIkywVTAEaEPac
         Sd5NFte9HRJdPU6M/Odeetr8cGXyPVpcFZhlHhvSu0EC2VvaNq+HWpRbXrpR2E3R0nEh
         8JW/lvr0jMiaPF1mvk+HKPLGlYz3jgSDMKATV/2yFj6b0tEQj41PNjccwncsCqTsJHLW
         IU+F3+eWEgbXCvjIypdSo1i66ru4/oI+/70riRdXypjM2mF1Ksd8+kVaQSssZVtFBOea
         lgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j99GBY2z5Xu92Yp00HFMB1qnKMRK75hvdfSVk8I1hAI=;
        fh=eXviSQX4F59V4wNhIqqvzp9DBgTw7G6CooN+zd4pSVw=;
        b=QaWGACH+Fe1H4hs8N0BTv1zge15T9uIhUcpu40aMUUe2xVeFvNzyKe6FTECSU+U8c7
         +M1otnHZoA4BPaxSFs4yIwyODeE4SWvT+5I+4VkJ9a/KfekRA6b6QBqL55D3LUL3nHZQ
         zRxVUJmDDLYitAhLxPsb2uKF7c7lUSvufv8NiQE67jqsXFCxSk/9jUFrQV7jEprPGg24
         l4+vOMr4w4GLv5HIhOlINhIUdzrrOz3RvTxHxKAqEpKOX7GR4M42H+D3EsDv95J56LKv
         8/8i4NTYwnRPBqWt8LWkl6nnIQN98tofWUarGaaE4kz0dVevG7qtt2j5wmFIMTSESUsI
         0RWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779419857; x=1780024657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j99GBY2z5Xu92Yp00HFMB1qnKMRK75hvdfSVk8I1hAI=;
        b=IdBJdGkrMfngqz6ceUQhfbh3yZsH0m5tI7W9uea+cITf1qO/bEwszjG2fyaDYGXM2m
         NO3MN43t2ZJSI2Uv5LVTbIrydLI2WsYI0LHxGIqSvyY8qFR3wjebr7UozLlPox75egnm
         JW0maDFtwynG6uICFdXFvTSprNgG8P9iCv7Rw6792zHKajYvnGLX0z5gW+S+G3MnlAkH
         5EFLGyfP2s9u7GTk280pbi6AZyrpJWy7Uo5RuVXrIMq4C1Vg9YlzzIdaOEEuENxApYKA
         bj0UlujWSe9AVZF3ziCiKqZzg+fsxI6WBPj8ygGzUDDbFSz6eRbb4WPCKONvjeLrzoP1
         6nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779419857; x=1780024657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j99GBY2z5Xu92Yp00HFMB1qnKMRK75hvdfSVk8I1hAI=;
        b=YiWYakxXqcE1osiiIXV0mHu9eKr9nlFzIqk0KH/YDVu9iPzKw4hqQLoa1IAID+Nk+L
         /a6ETMx3kFUGDq2R+1xg4djPAIUnhF2Wj2E+7iyeQJwEppgZexXrAJStOvPz/Szu8fuE
         plJgiN1HugtOCp5KMO0bCu5skf9OWuayboJOczEOb2eWlqK+29FFJSafnTIEcYYG8Yvu
         HmxzJs5R7DMYMklnYAQBX3j4WQtutQcUFwi5tN4Etj6Psr0sHZSlLUGypPARsmpUnA0U
         5KMbYXt/FoqimjaMvfMWlHwme29xfO7HGcTd7RYBDMiKlQlMBRKosCYi4ctLbXZO63Q1
         tnXA==
X-Forwarded-Encrypted: i=1; AFNElJ9mO35T+OxH5F4nJ+It1CG3HO9RZ04alLp5RYZD3tqEhaT0lCc3qFxQHWngSKq35NZvjkZbzUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgrwky7cI+VTR46WYAeydhDlYlUdo4yQvqcDF7JiL78N3gLQI
	jUOLXwjnato7mCbfnQhxKFYgZWL76QSL15a4VKypYLUEOq6Xjsj84vVUbvFkr6+ahATtNCoMahz
	kSUs8juPop3uQn/34r4uPHIHMRSqQ1hOiOjefarfE
X-Gm-Gg: Acq92OFk1voPRZCq7N2fIbFR3w2NLxSt35DhsuCY3UaqunXqFC1d7ayv4Qc6Xpn47sw
	TbIItQ9NWVbxOG4seWa13JBRPQsQxlaQgK4lirzj8jNKjBxlp6r69Yytep67CnYzTblatSZycVs
	CwuYYPYx48f9HfAz9OU1usZFLQDoKePOUvcWzQ3pDCg+Cgx1Ha9kas8qE7dY/823amxWqfGmhbl
	xdoI0/rbPg8f3m3Hq6n5bb3fxoEI0gauguG8ZMtA8rdhZbTxY8o+l+HSoUpdK5/KPlKiKdCjjDx
	YI0kolt/Sfj4VXmg/BPry9lHtV3+rnpr0DVkEAfa9XyjMXJiSQQF3dDVtTnjKmkNJThJ+k0ZxDV
	hPS9L/te4T4trcIp9EbooKSEr0wYzxMjCcbdwUYWzG4rbNNzuFy8J6S15QfRRzv+f9HUott0RlA
	==
X-Received: by 2002:a05:7022:117:b0:12d:d27f:d817 with SMTP id
 a92af1059eb24-1365fa442b1mr799712c88.19.1779419856248; Thu, 21 May 2026
 20:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com> <20260520103227.1133277-3-edumazet@google.com>
In-Reply-To: <20260520103227.1133277-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 May 2026 20:17:24 -0700
X-Gm-Features: AVHnY4IO7SxudK-ZfSMlKGCY5gsp3Ft8gNelgIhrYFb-t_bV-x7hTWiDtHP4kK0
Message-ID: <CAAVpQUAXq=G=JyOJGzVkqhoN1sL4GSpUB697KU2z+c=uquHWXA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/3] net: defer netdev_name_node_alt_flush()
 call to netdev_run_todo()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290657-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 96FF15AE470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In the following patch, we want to call rtnl_fill_prop_list() without
> RTNL being held, but after a device reference was taken.
>
> We need to free altnames in netdev_run_todo() instead of
> unregister_netdevice_many_notify().
>
> Freeing will only happen once all device references
> have been released.
>
> Note that dev->name_node serves as the anchor for altnames,
> thus must be also freed in netdev_run_todo().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

