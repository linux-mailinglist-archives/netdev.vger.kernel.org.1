Return-Path: <netdev+bounces-300763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0TKOIs60NWrx3QYAu9opvQ
	(envelope-from <netdev+bounces-300763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 23:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419B6A7CD3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 23:29:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rm2LLIXY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300763-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300763-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0903062F5C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21F3DEAFA;
	Fri, 19 Jun 2026 21:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C873D412B
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 21:29:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781904578; cv=pass; b=YJDyjAtQyYoGRuvjfokZgrQBxq2OPxlUVuRr4ErZQBKIU7Hmp3ZPSIi2F5XxwxxmsV4mpkehwMELBOPnYjRQtibb+B+U5RakOFoK/JRZvJXRZnBxBHy75iU2iJ0a0A7BIU+qcngWwN4i4yGQOo3BtxknZBg/WwaobvXh5MpxNF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781904578; c=relaxed/simple;
	bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCo4Sgmf/Nmg+5+pnfIMH30flxg8W8APY7Mz/xGSj/mtjgXqKtYZ0xUU949uJBr80AT/Rbd71y2y+Fhx8mLFRhmgoNNQ5Cek7dwkpw39Mc5CIkbi20k8RZ1g4oR2N8Hs/273oSQoMoAOpwI3EjE0HCctFikX57YP3t5FXF820xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rm2LLIXY; arc=pass smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-138501f8c04so2146388c88.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 14:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781904576; cv=none;
        d=google.com; s=arc-20240605;
        b=GSIRgqCFZ0xzjx9h29B/GR1YsOBusuKirfDLvO0LBwJJRLTQzORRulcdQuQVIqdipe
         SZhQ36EysD5MC635XyZlPNap98G+zamfJPLkGh3eG/7H3y2J6aHORU+1EWPxaBx1K3te
         1IMv+QX8l2PuHC2Kpifh74m0dzW/f34r7CDz4qxXLM1oLBo9Q5Fk6mGXjqPkp0wwhwGB
         Fo/0XHZzNIQFU0qZPJKfVXTEjflhbexn1tbQ3DY6xhIq3l3iH0GGof/o2i67eIVP3B9m
         Hku8EBTABBCXfgVx/faIyf0l4sYXWWlBKVpaRYC3QohmQBnQvSSSWcnVn63ifr5qb+f2
         SRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
        fh=IUdjUfhWT1Wlc2IhhSdzg9XICW7gln5KO6YbzXDSq48=;
        b=JPQRcUEtLk/a1bSMlO+RmquQbXZ9WyhDBODQwtT+zYM6ubZSP/6f6GCW55u4lfB53h
         7f2rNsILOH9jsr8aou8jRb+CDA6TGOT2oPJ7SQMpQFycu9HMVEXH+ksBUFIaA90KM5NM
         3Mn05W9M3fSHclCDopllw2jKjz1BXYe33CQ96BcqcBc6djlyK4XipQ+cagsiYHYEjrGd
         a87cwydoFKGkDm+H65vuWARfUZWE8Rb/+7TZAjFGX06xoij0q7mvqnWTGZbgRfl9CMhm
         mDMQKcLU3BSTr+MT/zmU4I1KGz6SJeTxxeAKdIyh5RG2ai7EjyjttestTHp8YSu2rRnO
         Hc3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781904576; x=1782509376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
        b=rm2LLIXY80jYnzxKMHUOQjzclr6iPt5JNAbgtpikOvGC0m7TmBhefQsa7s1vGp4RSe
         lRwRvFDXeX15C+vbRbx3EN04rfjU6qm6u6tbb3/TsJbJzYRCpGwCNVA2J3T1s2JfOtbo
         TRWx6LjemN1tdAf2U93lz7fp6HlFTDKZVXU8TwW0M2pc7FKKpQlT1sh/XPc971u9brdy
         0VP88WrvAYiTM1Dnu67JWrUP/zmT5pWZC7LOFDRH5y/r6ySFk20oL96lVIjQAOdz3HIu
         +l+AhpBfzn4vBQqurMs+2hNdixN81il81B9P/G5YuhZUhfESuFGkDlffjThaMLycyH9G
         sHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781904576; x=1782509376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
        b=kDhKTDcavbH9FK4mp1BbWP6cv3QJeeLj4FY6yX3cWIvcoJOOvu/+iYbJikz6g03SzU
         CP6AYQM8vb8FkPkAP+eWfzrydl//SUSq15/BHPBmAJ7jiQEbnFJunhhJkmOhQc/n1cRy
         Qgdo4QygKHcrEemAJ6Ow+8lQmYsKVtYmQBM7iP3/90bga09HppEM2jcGEPa7Z73qPv1x
         Lo9LMtKl6tyuJmpJ72HklRDeLPTBHRJPJcK3P1pF7EKIBl1c5PYHjIQbDK1sJJNE4ZqQ
         1n1mbsyWNRR6WzikXLj3jMSiOpgAZnQVLoF7a6OeZ3bDNO/WsmVadD42R+B9UTQMquof
         74eQ==
X-Forwarded-Encrypted: i=1; AFNElJ98RBJkHtX3RyAMF+6lNdQoerRG0DEReKHWr4t97kpWi70sxrSuYGhVJcbE8X14fQZs5FITJF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKWVwqAYTfIJAr7ADkzjGS10tmbdhvnWaz9vLiaMsTjlmnrU6
	9d0oCQ9JY03zRx2bkMyq7aAgT2eee2BEEPzarAlj236WzQenUACxR4n+LuPU50Tkh6YGo+C3QdP
	JayC798qquvfZbKHMeUIO0dN+Udmfygb6raeIPiAfSmYw/hdSreUSfKaXFOc=
X-Gm-Gg: AfdE7cnBS8lIKJusPUaOlL2RdoSobg80oWY1my/oqiLh9Tn6XIhGLAafCDKvqP258mu
	VC/Zb4/OBXXMOZd49Uc7RVNGPJI/WgcGFN6Rji3Dn7Qk1v1yQJl/rnyrxIgKCZUZPEgwnfbsQZp
	ItJi00fxUgnXQHnNKRmPRyDklPW07A/9aZOkvqeOoY5X3+9J1Nsp6AjAG6YlZO0w2RJUqjyfFz1
	pN2XvhN/BPeLldqNfrXsLqSE8H/MiHy8Ctbmxpg4DHdNxkZEUanDiaapzt83yhSqCf/4mYmoCKr
	JcXjIlc2SRNvzkfgceSqIUt9Godu431g5x31gFx1GomNdSJ4N5hu5J8dYWAi/jTAwA/6N1l5FFD
	iUN7TtEB18BTFcIt0d0RwA3XHga1bF86QOkh9lQZC+PVDYq5R/zc=
X-Received: by 2002:a05:7022:43a1:b0:139:817a:f00a with SMTP id
 a92af1059eb24-139a210c4famr3381380c88.17.1781904574988; Fri, 19 Jun 2026
 14:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 19 Jun 2026 14:29:23 -0700
X-Gm-Features: AVVi8CeTbFth22JNyN4ZbCRv9iOwGjjOFHXaiWJLYUYc1xJtx2RZrKLN8qTMr8M
Message-ID: <CAAVpQUAdmJUihGxFp7QS6tP5htsKmP2Gt2Dgpzp_KTwkNb+fTg@mail.gmail.com>
Subject: Re: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns
 for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shaw.leon@gmail.com,m:nicolas.dichtel@6wind.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-300763-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2419B6A7CD3

On Thu, Jun 18, 2026 at 12:08=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ipip6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate ipip6_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed. sit was the one tunnel type not covered
> by the recent series that added this check to the other changelink()
> handlers.
>
> Fixes: 5e6700b3bf98 ("sit: add support of x-netns")
> Link: https://lore.kernel.org/netdev/20260612085941.3158249-1-maoyixie.tj=
u@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

