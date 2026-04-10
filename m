Return-Path: <netdev+bounces-277574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FzDLZ1l2Wk5pQgAu9opvQ
	(envelope-from <netdev+bounces-277574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:03:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988C3DCAD4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DD330557D2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1A3A6EEA;
	Fri, 10 Apr 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLKxDIsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0A36165D
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854665; cv=pass; b=CYtiC2AWZN4VPF8GKzQzn3F34FUWCl3fDPthjssxQ1vywQ35aibKOrJ3kbtJXDFyCi3v4D4yPQbBrE1S9UZXEJLHviVBLFAo1akPpJUT404ssiHmwQeafKUpeQ2e2U6F9s9zg67hwAnL2ufHl6fbk1c+TlUH7ZERuEKuzgQ8f9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854665; c=relaxed/simple;
	bh=0qpsWQzdkyOciqfOiMoPBojDf7jlyui1yVIfjamkWTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnjy4dglLcemlIu2mO2lCiUTbOVzFbuFy1nOIdI0x+p6xZ90dyfk99YcmUVZ73QxzxRrgeHerKeJHkIX3BwH0btyxjcIt/F0iyp2atdNZ3OTb7jMn8tSvyUjnG3NMzziAMjL0/yRf37uJPXcRBgqDM3h9TaNh646hEM5dKh4snA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLKxDIsb; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271195d2a7so1402464c88.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775854664; cv=none;
        d=google.com; s=arc-20240605;
        b=TkHO63zaXsF19wcwFKASYafNRK3pYsygm/IGAbaRIEKP3vQ8HalubUTGYGCmI+b/Qf
         gFbmEWoR89b6B3K0PkDI6AkldxOStkuh6XKBDRQ+/vG5sreZ0SnJPwkZUy19ld+PR9eb
         Kb+baFkkto0PryMVBmc/PaP5YqZtwYM4HAykImONXQPtMqZWKjM4+xepomNNb+dQ4uhS
         pYuinRRLJEcHjJ18b+vJs4i/2UfkGvGiq0eGNSASSfpn+MLTlSbuU8sTdzCgLnNeq7TY
         qD+9Fp7guImH05JiyvMNifekYu1Ou4esbag5U9lljtmcplFgsfcMwsHiA20t9sn43+2i
         Lq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0qpsWQzdkyOciqfOiMoPBojDf7jlyui1yVIfjamkWTQ=;
        fh=HCAbHX/GPssOCV5QuTmzwM0Ug7dNbdNCb/gEAQWjYRs=;
        b=UYxZmzcMPCGG5uT3hGU7wzDGFsCCEkAenP1XNc8dgcZGht/xrTrn823QnIIyYIucO7
         zYlbMTWRjByxvHS97WZKFoPvSQ7QzpqKXG4Xc7ldFAZEGegskgcmfn1agWO6ik+feOyR
         vk6IqM759aV5vG7X3EJI8aXxyYL3X6mAcDj0h81DvbGDAvQEMOp7ZykXmJkaxh56Tglu
         f8xygB0+BHFqT3QvRJr2u/HtWwXnIYidcvB/0KnU3q8hEpOvHLt0HS5cWPbtrvImZnqj
         GFPZMcgUaRn/lUlu7Rt05QwnyBb/gTzFuh3yzNMB7OICtA/Y6dc/eBVvZxDfijdX1WhK
         AkiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775854664; x=1776459464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qpsWQzdkyOciqfOiMoPBojDf7jlyui1yVIfjamkWTQ=;
        b=KLKxDIsb7csXG8Dz3DisWwDdJ7YIQCARw3UxUNqlMNxNFuZ1FxqUpN7T+zR2vek5k4
         76vAztdDB+rSVbaNGvFe4MBk+piOhYRAeqzH1ett2UNesm3sMY517gB+0MvPYsnyIUkH
         s/UFvnnST8/V3MqoFLC75YxFnMPZIE5FZMRnBCeZfrOYhtHBD0HXdVp7xVFbphyixjQ2
         cYNRaoHE3+q+2qaN0XHtW641NQy2m+QfKXM5ptGXhuD8yeh15bzv50naB2VuvDyztIe8
         wpcZ3Ss3+aP0oFmsWG8byg4t8X57LBUHF3KtGHaY/EvhTtbFyKM+71PnkFUWKRWDgUvI
         P4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854664; x=1776459464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0qpsWQzdkyOciqfOiMoPBojDf7jlyui1yVIfjamkWTQ=;
        b=VE/xxvq34oLezkx5q83lS81CIE2aHjgAA3i9vFOwvewomupJm+Tt43g9DZsboNWMbp
         uPtC7IPtQq0gYmZJDHbCHQs0RvabgnogeXGZmSfW3wtRN1bA94xmiixiGJXeI8ZakzdK
         QMa4c08wOLNV9P6dXvwQDsrF/ReAdtNOKniZtRayDYIMokO+TmDFAZJi94D3vJoFpitD
         1F9itOM536P0+l6BvprBF6B7osKV7EVc5WOV9NVo20p2hibF39t0LeY1HUU1MBdVXUuY
         ddmYfz8mESAGlTYKXPiFxIRxE6nfWd+OkhEl4hpa3u4skX7QTUeY8yefrcrlkpUXxxht
         ONcw==
X-Forwarded-Encrypted: i=1; AJvYcCVssD1NB1tlsQe6MCdsXXdRSxE3xM7ex/3EqCavzDS06KBm71ki5nAfo4ZQ1UEFbAjIBOARQJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPb+VR81BDH946hQVcaZsAWFpqE3nNXpOwFEsa4K2tEOlV0LEr
	RJCTr7iIRASgR8bkR1EFTXbUMyXEQWvzoGi9JuFwLHivoxce1e+H44MFjyrcRXTq2FmyRM4dv6h
	lTqaEd2M/5h0GXT/np68D/q0aBRpIV6mqN6gV/62G
X-Gm-Gg: AeBDiesuLbuDDh74RQ4KYEsXj86/xtBXN8f2CcbSMu5jogs+0iJWD92+hGzyk0UuGQS
	B44X8St5l4yckjSFrj8b2K9OZ96JVr/jGLAITkLDjH+3QttJhsCsuLM/ANIVznYZbmGC/CF00Kh
	LqL3StlX0gueg8RXG9XAC+EnEo8WJIlhYTIOcgnCEAK246FNIY8B5FX/dXdUFVTknHANBvZ4qFb
	arTNNi2tMhlX1dAsh46DYYYo5gZjYpd9YaJ3JE1vwyul+m21IoL9u08GH+dfP2Zq1gtkkY43aKM
	kJe1jwRETwGcErE/kK6YGy6YsJ08LvQivgxVRCawsrh1LOVTfzDGzAi3LighV1AHJUzjDZklfjN
	lUbd2zU+6MGV56bsMQUIKSJEZaEt4+5PbaB86kypxVDyThGQ2wwXTPLzdGGyo
X-Received: by 2002:a05:7022:ec2:b0:128:dbbf:fd35 with SMTP id
 a92af1059eb24-12c34f09a4cmr2725366c88.28.1775854662978; Fri, 10 Apr 2026
 13:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410174950.745670-1-edumazet@google.com>
In-Reply-To: <20260410174950.745670-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Apr 2026 13:57:31 -0700
X-Gm-Features: AQROBzCPBSjTT2px0IFMmYiV9GLGwP5migWZ2_NQ2lsm-zy_loKHxXU5u80aibY
Message-ID: <CAAVpQUBr+8ZQMz=iEGTWxzurLCzswg_dnYr9Z2jmQnrXwVCHvg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add indirect call wrapper in tcp_conn_request()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277574-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3988C3DCAD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:49=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Small improvement in SYN processing, to directly call
> tcp_v6_init_seq_and_ts_off() or tcp_v4_init_seq_and_ts_off().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

