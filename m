Return-Path: <netdev+bounces-278921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CVCIDlm4GlagAAAu9opvQ
	(envelope-from <netdev+bounces-278921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:31:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA3A40A306
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 06:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34292308269D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167403242CA;
	Thu, 16 Apr 2026 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VvJil7dD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404B311963
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776313833; cv=pass; b=AKGbgkXd4gyUUblHjZ3569LX52Va0ip9vhGbZQwc8EUTXpfxwAVhABBDQbPWqbVZPFuQ8PyVllP33Zee3jVQxPw2YEUSZhGUCs4flXH/YQnGeV/WD7tS/+M8h9JluKaOrNKKWHgH5vM6nac0XEHa6jhhBxz7Tyo91xfGoULr4/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776313833; c=relaxed/simple;
	bh=eBwEvLyvW5ty9QcQNpdbMGy+nVAi1rn9GyGF/2Ur5sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWbA+YafThXUChMkS8Vye6PpQIZWT6H08lsqN0TjCiyD4BDbdpOWZkcVLufX14K28VCLhXtSjB1j0fzZLnkbGZMWP7pRe/H/7uNI9B8Tj9u3aS9WM1hvId0sG+KU/vm0m2Dcap15y50fzQ7Qid3KYvf3DmFCtdccxtzbP0D5qTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VvJil7dD; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2503753efso66383635ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 21:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776313831; cv=none;
        d=google.com; s=arc-20240605;
        b=KEjFk0nsrsAz0Ggsf9OQlmkzdlFghvqb9WKadaa8NI+ZOQDLcDwQHLGQhJyrAeYOFC
         x9HM8rkghMZhzAnmE5WH4DWUjOaHoT0Nj4HVSs+4+icqSHymU9JQ7KfVSNIuF5ucLLwd
         rX9YbB+4gePGHUdR8tft2M15XJfWokKQVx+X1vogBb+kSWeTLfoqcs5NBwwzLPNTKqEQ
         Rovu8tiFK3B+lDe26p77nnhzrM9NBOMhFypL2hK8NWG/Y4JBbg6iNNQGhWb0RX1dYPQd
         2pFoVx4+FFks6R2DfP4nRV4QFMD/czvd0dddtT8Q6vbTMHvOZGqlLj9/f3aGHJV5fiGY
         XmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eBwEvLyvW5ty9QcQNpdbMGy+nVAi1rn9GyGF/2Ur5sE=;
        fh=9aYC9yhaqIRX1YOWyNItHAj57rsDkgbgf6Mlm1tJ0r8=;
        b=QwcllB20Q7W6fbvQjOdYDr27e01OnTwpuAMh/HmAZW/ktpTkj7R+8pBDtQD8aTDKP0
         htYU1ZnKa6H3tulASa5kIN9mpsjB2+9qq9qTvmws1esC8chPHu9yTLio4CkJAq7hRr+r
         vdvPzhe0lc8fbO6dP90HXNgasZ9Puuty55gx7zY9MfwUrJUf0iawnSlVi8s+1O5mg5OG
         EZNTpuN+yrjzxtkFNFtn581C5B8+6DHta1Fd0vcQS7IopWkxEtGRKU3TVJo7smYHb9uB
         e9gYhxAsMD34pe5L1N7fdYpqImjyVRWTzXmGIzQ6rlkEWPYt5LswMqitFh9vJm8tAWdH
         VbNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1776313831; x=1776918631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBwEvLyvW5ty9QcQNpdbMGy+nVAi1rn9GyGF/2Ur5sE=;
        b=VvJil7dDSM3pzbsfhd8hsLU8WjpiLTMSVFqpebNd0WzoQh44CdszYLFISosexLRJDt
         Rn28tsBJxrma1aILOPMzQyRAmQMOTWqExl/CFbYqTAQ1XxB4jdoQQYt9Dv5e14kKACrD
         zly2eUlXdT06FYYYtvHEMipUj+bEIsEATW8NIyF5R/7SwngKGxU/9aF3QKNJGnomihC1
         NkN/HqzDQrJc2rosTXUG+XFlZER4Xngb67vhrYhxnlDhLdkYctin3CaEu6GQnuMxJtZ/
         FQrpiWA+srrkIs0OH7CXnvnyBUV2kmLu5hptEibQFstxiJPFSzI4rV7B4udLOhAzX8YQ
         TjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776313831; x=1776918631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBwEvLyvW5ty9QcQNpdbMGy+nVAi1rn9GyGF/2Ur5sE=;
        b=FLFxx8epY6Y9xBVyHSgEDkxUO0vGXr0dEwMecv4HAjs1Wc9k2yPftEINPLbEc2gz4o
         QSP3s7q4q4pYfO3/IeOuMONy4zS+uI0wC9K6FOUphqRSL2l3qjwzT7vBwGxDWrBXtZzW
         dKCrbWa6M195lomFB2gHmB06m7yfmgY32mw2Pds/F//ZQeuz0K6aGocm+UT1HOPwVpZ/
         /f66jmoD/e0UST2Nu3ikdI3eM8/ddvoucJCVRou7YkqsuCy7VNl8jkSQt5LrXaDry8kt
         27Y33wFP4lqhJ/jP3harq0ffoXwRxVWgWITcECEtSH/2frTdPxG6q2w+OgoRJQWsWi0r
         Ff2w==
X-Forwarded-Encrypted: i=1; AFNElJ+XJ0wbqdwY+iG5EImihqfuYjrS7TZqjkcfwJmqZyvIhO4TyE+FBbqZ29I+Yc0TgKq8aGJjQIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZWffwiDsTe4y5DDadJ+ODRav2jAPebTKivfkE1S2x5Vzex06
	qZViWHH8AULxk9lPMLtQOg2QfpHF8nKuf3t5l1TDW0so2+cKEBM9l4ezeQv7EBy875uexcAB1t3
	0mBX5N23uVVnjCYJxRIlnuvNrrdlxIF2sC5RelnGS
X-Gm-Gg: AeBDiesRqaX2m4qlpd1ug3wYy/zh03l4JC1RbcLLpKsKqYyHQhgdqXcFdk+fGzfoEUo
	/xKJiOEtAeyIU0wkA3Bk4VX1IZpYhkA2NfuUGluZUqaeCnOKKZ7r2dYBZ4ELaLRtGHDz+7AT958
	ATkkPpT5Akrl1aolwzHuL9307S/uKqrg2Jt6O/K5wuDRUM4g9Tgra+e+iXezLWHzVzPjJ7dvVvm
	zQY5hgfXSQn4DWZ3C/RriSxp+lxdHLJBziA2vSGNRX/GUDcwAXaevjy2BxEn9CjfMU4ep1GUNsy
	uP62LVq/CK4DsV66dNo=
X-Received: by 2002:a17:902:bd82:b0:2b2:4eec:9806 with SMTP id
 d9443c01a7336-2b2d59435e7mr175378765ad.8.1776313831108; Wed, 15 Apr 2026
 21:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410101321.915190-2-bestswngs@gmail.com> <ad_C1f2cW5-kctHi@chamomile>
In-Reply-To: <ad_C1f2cW5-kctHi@chamomile>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 15 Apr 2026 21:30:19 -0700
X-Gm-Features: AQROBzArZIGP7P6PYpJC0RLfY5oWoqPDja93CqgujU7BKVV_JgidCYZGHAKQ3wE
Message-ID: <CAPpSM+Q7GTCwzYwJmcvRz2_XP12Dstwtm4cViyRo16C00C3FDA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_tables: use RCU-safe list primitives for
 basechain hook list
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Weiming Shi <bestswngs@gmail.com>, Florian Westphal <fw@strlen.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Phil Sutter <phil@nwl.cc>, 
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:dkim,asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	TAGGED_FROM(0.00)[bounces-278921-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[gmail.com,strlen.de,davemloft.net,google.com,kernel.org,redhat.com,nwl.cc,vger.kernel.org,netfilter.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.381];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ozlabs.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA3A40A306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 9:55=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Fri, Apr 10, 2026 at 06:13:22PM +0800, Weiming Shi wrote:
> > NFT_MSG_GETCHAIN runs as an NFNL_CB_RCU callback, so chain dumps
> > traverse basechain->hook_list under rcu_read_lock() without holding
> > commit_mutex. Meanwhile, nft_delchain_hook() mutates that same live
> > hook_list with plain list_move() and list_splice(), and the commit/abor=
t
> > paths splice hooks back with plain list_splice(). None of these are
> > RCU-safe list operations.
> >
> > A concurrent GETCHAIN dump can observe partially updated list pointers,
> > follow them into stack-local or transaction-private list heads, and
> > crash when container_of() produces a bogus struct nft_hook pointer.
>
> For the record, v1 of proposed series to fix this is here:
>
> https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=3D49975=
7

Hi Pablo,

Thanks for working on this.
If this addresses the issue I originally reported, could you please
consider adding:
Reported-by: Xiang Mei <xmei5@asu.edu>

Thanks,
Xiang

