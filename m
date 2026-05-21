Return-Path: <netdev+bounces-290394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NhFHpf6DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:29:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FD5A4D0F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC94F30BC3B8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AAF3CAE99;
	Thu, 21 May 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="glANsFbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BA3C8C75
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366130; cv=none; b=mcTCdrHFq9NZxmGseUP/HdPueQjUsuKLGK1+BapyHEpY/R1w25pd5b80rOg2pmb2rQzUDoyPNMLzEUb4pNj62Li2phF+nl1BH/efwRt7BS2m6KjedSJSkcXvSpXVzPLn0G5H5modxcIIdmpU+Q+efd0R4g7fcQXGRSyQlp4VTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366130; c=relaxed/simple;
	bh=6qIKQ4HGRNuC9b1VA8SW31u97PHcK3v1iZgV3ZjX7XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5NvRdubSd2trAExs8/3N/LIS0lc2h12WLjmGeycj/tBLGsINPfPh4X4gkTAyzJmz/79VND3BeLkGKMDYC62m7c/XJe85HsS2oOldjvQ4XSBgXGsUO0L1iJtoeckrziW7GGrClKHDjnEpVl3f++pWolCmVLpXEuYJupoeYi/iEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=glANsFbB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso37313765e9.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779366127; x=1779970927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkozO53PWowE/Kmlnn2nLReMhnnLRxP/AG8BG4YN0IQ=;
        b=glANsFbB63ZxtFs8dZm46vdfJQMP48QOSU+w0/EcXMRz5mZf5rzfwCgW+i6KpbSHn2
         rnvPmSKM9i1KQ9Wba5YYlRGMEu5Oa2cygIyrZHSDTFJopsPiOPRFZHiwk8Vg8Af0cA0k
         lrCDj8U2e1z3M1q5WySOg0gKZez9G/5SM4n6/Y6wcJgjnMuV/KAIeA8J1NDfk4oo23ya
         LQJ0u/y+S1v9k6QO2xQUWSe7gmsXnFEJRx/kEBSCTuIJ+ZBSsbEarTqV0zA1ZNYGap+Z
         /FnIdVbWdynhCx2I3PZb+QvtxrFNqQPibNam9pTeLKEWSQ5OJDNfUgcLsLat/HeHFIqA
         O70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366127; x=1779970927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkozO53PWowE/Kmlnn2nLReMhnnLRxP/AG8BG4YN0IQ=;
        b=YCP0cCkkq+A0wZeAbcndi8zQoJjkDf6cDJQEJz8X20L/cxbLLaTFJvpUzMLGmc9gG5
         ubbkjMEfRS1uFuoQ4FRo80qTWtrb8OppQS7fo5MZVtR5wZONZUmDe/MapFZRc8l6PxSI
         KG2I0CzBLn91CaY/PjEjt4HlvBYGniqWkdIhyhxadVJmlFChYsqtibm/gmdpmIdNReHA
         4B/2qMpZcyGXTL0t1Lx7g75TvAAw1XLFfnESloTf0vHoTa8al/KuaY7DoRzk4PHin5mL
         XgZWLA18gKkqq1y6oZ6OBCkNKx1O1o0R6SaCF92IXGjyPNpHV2phgTUsewj3fEVMP9X9
         bKwg==
X-Forwarded-Encrypted: i=1; AFNElJ8JZiqNP0rg3SRmUthNKZk4xmf6WgT1CJziE14T/W5A6+XUePWPgE2IcXuavQDeHsjHmw9Ljqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRP1lZ/QImeh2R1Yy9OSHeA1eMCPh4e1kOorVP2XFGzAolzykz
	8w8UcSFPcQSwkJimNhP2Mz7IvGCHMI7wnDt0nCCQJesJkOc4tdimkLa5VwsqUEepukg=
X-Gm-Gg: Acq92OGK02/sxHjTK/pX6E6r5MFJEJNvX7KfaK1NdF+GULqQ4ehXUVur5xqniK8wOW+
	gWtUKXv8C2xyGrWUvhyRJzWq7ng+3hcQ/0tBcv2Yv8jfIpHArimMebRCoh1aAfrRWAPrnd+RTgX
	lf2sSUihCRhnH+nc1VqKx/BN8VPJua/nd3YzzCnUr27WTgde+lq2cppBuPJdPDsEYZKKlzcxDRt
	lj7JFnAxPrWgE7Z5v5otz9pFhSp1rQeXQeHH2doZKsNi0t7pIz/LBNVpcq+SOYYvjtQSHP4Zm6Z
	FN2qW4zmzFYD8ztuq6cC2c2MXh8Pprr0ApIbUqfVy+bJYDk2khmIDPG3elsxqZM/5o/+qG7mvJG
	69c30U6z1ipkAXMRsSVIBwkPXzsBGBdu80kXm8fvRvZXpP/6DrtMa0jOsbHy+WCAa6XM1fsa22s
	Qs7uyejOse6biRxQL5D58OaMyUXC4=
X-Received: by 2002:a05:600c:1f8d:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-4903607cc18mr37429845e9.21.1779366126687;
        Thu, 21 May 2026 05:22:06 -0700 (PDT)
Received: from localhost ([165.85.72.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92dbfdsm2368433f8f.18.2026.05.21.05.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:22:06 -0700 (PDT)
Date: Thu, 21 May 2026 15:22:03 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH v2 net] net: bridge: prevent too big nested attributes in
 br_fill_linkxstats()
Message-ID: <ag7463AoU8pVuamX@penguin>
References: <20260520114207.1394241-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520114207.1394241-1-edumazet@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,a35f9259d08f907c06e6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 0D5FD5A4D0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:42:07AM +0000, Eric Dumazet wrote:
> After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_end()")
> syzbot found that br_fill_linkxstats() can send corrupted netlink packets.
> 
> Make sure the nested attribute size is bounded.
> 
> Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
> Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
> v2: remove the WARN_ON(err == -EMSGSIZE) in rtnl_stats_get() (Ido)
>     adjust limit (Ido)
> v1: https://lore.kernel.org/netdev/20260518130531.1015332-1-edumazet@google.com/
> 
>  net/bridge/br_netlink.c | 10 ++++++++++
>  net/core/rtnetlink.c    |  5 +++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
 
Thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


