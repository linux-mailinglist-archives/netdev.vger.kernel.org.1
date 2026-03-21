Return-Path: <netdev+bounces-270132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIb6DGftvWkwDwMAu9opvQ
	(envelope-from <netdev+bounces-270132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:59:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65A2E2B84
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D9093016C87
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562CF238C0D;
	Sat, 21 Mar 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1QT2o4K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AF19C566
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054742; cv=none; b=MReEOi0ySC6o5UHVjNg65bfMR7Ddd1sI1FHjq/78FcqrgZ/L87KHoaXgnJRAXNQIxrug3Whi6v/JhfNYJNZU6ieEOzCV/CknpdblDyVvBUggACyRbEqI2UvmHfXbDnQVzDryMAYnLWGQI6cKZmE4+3St3Ws7667+AfA9KFxdplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054742; c=relaxed/simple;
	bh=xlDB4MPkVdLuI2GV9cUxuF4brdnzQHOqYmeiGc9qJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp8SYUhQIITfaCVIs2G1orzIgkvAcUgaiKJsrT+2unKN0gVoLO2Ji4flgu1LyMnWKQryws+keJe4JRPwVHAzQL8jerH7V17s9/P5erAedFHT63diR7TPRsoPB03QaijREaqeroOoEuYd3DOOZVXXTXr8VcQRKHfmpMhEnfUQylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1QT2o4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C5C4CEF7;
	Sat, 21 Mar 2026 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054742;
	bh=xlDB4MPkVdLuI2GV9cUxuF4brdnzQHOqYmeiGc9qJwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1QT2o4KDasw0DGp5mODgOFjMcmofshsGsU8JrYCNuNv0dXLg6JZAkKYZi0ZFmWay
	 OLHQCRJww1zcg8hdpmQMI1ygnX7FDPe9ezc4iD8PCIFabUrW/Hap/uY/BsV9zq0Ktv
	 I6/D1jL7oAu2PiWDadYuS2iv2OVNIB50G56tcMpmbtNY5RMfT+GTXYFbpvLihvrBNJ
	 MPNZhjR9Xx3ves9aIZmfnZukUsWxEowlkEFARa6cWr4NgGBNYY9+LzGj8oePNAOk7r
	 K1ze1Edta7Zl5M8+Rvgx2Cne26Uy2AMy+e2rgj8avmveyycyjs9dp1OTDgct3x/Yja
	 N9hJXXByRGddA==
Date: Fri, 20 Mar 2026 17:59:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, David
 Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Onyshchuk <oandrew@meta.com>
Subject: Re: [PATCH net] udp: Fix wildcard bind conflict check when using
 hash2
Message-ID: <20260320175900.0a7801bb@kernel.org>
In-Reply-To: <CAAVpQUA2JhaewkprZHccQQu20XgnHmMgZ_q6AZWCP-V+e_YS4A@mail.gmail.com>
References: <20260319181817.1901357-1-martin.lau@linux.dev>
	<CAAVpQUA2JhaewkprZHccQQu20XgnHmMgZ_q6AZWCP-V+e_YS4A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-270132-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC65A2E2B84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 16:07:10 -0700 Kuniyuki Iwashima wrote:
> Confirmed this fixes the buggy scenario, thanks !

Should we start a selftest for UDP wildcard bind behavior
or extend bind_wildcard.c or it's odd to ask for it now?

