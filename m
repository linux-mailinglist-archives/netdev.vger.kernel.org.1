Return-Path: <netdev+bounces-292059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBCuEFpQFmqxkgcAu9opvQ
	(envelope-from <netdev+bounces-292059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF44D5DE753
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B676300230A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9CF28B4E2;
	Wed, 27 May 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv0wbfZg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB521770B;
	Wed, 27 May 2026 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847256; cv=none; b=ddz5O1tWIJ2qKnb/W1dltdy+XGG6yBcQBinZ1h9bwv9sq/B2CuEZT3PdTyF/jxaz84OUhc2WJ1GVUxxYAv8EOBKUWIrbeaThvL09Aba53zezqbN8Gg4iGR4Lngk83e1czuxa8EIBfPFrOW0Nfd0b5ofwQ9MzXocWQlHn9XxADOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847256; c=relaxed/simple;
	bh=fNPGm87JYOuRysvIxk0i4QUnV04al7jKYQRCCdmn7KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRPCPN7PCuXTT8Vaomnc/YbS+zDLrnYBsZpI4Y6SPZJBUW/R8hsOWobexL0WyGABpxg5su9sspuvsE61+d8Ez8k5pzX0wb7u+s5RoKFvupEIdgg/07b9cenYeOegOpKTfIA64551mMn6bxVY4NCv1xqO7RlPR+rk5gg3R+btX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv0wbfZg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD271F000E9;
	Wed, 27 May 2026 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779847255;
	bh=fNPGm87JYOuRysvIxk0i4QUnV04al7jKYQRCCdmn7KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hv0wbfZgcl3743R5rr04LdFIlxkL+ZJLkSpK8SLXFjsBWn+mgz0CgXSoBK/0FPbzc
	 ASY2oS++EsJhUzr0pNhaD6MiYHOMNko1AbmTJXUWxgJdxEE160ifTr/fggRonsMaNq
	 e8BsUM2u3VyNrKTQ2MdqkNm2FthzQXNhhQIqRseCuJQtYGk8PCpiviAo5CoKdQR92q
	 IxEf+PsiSk8enj0hBOwa2KyawPzV79EODeJaRB0YZw05PmOE1+93od8OFy2El1crpW
	 tCVTSrC8A2gXaN4oYBFjGd6qOk2AUd81wItxEYUDVJVDRWcdbbonDDzhmikUOYYHju
	 xDO8N+PWRQuZw==
Date: Tue, 26 May 2026 19:00:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gustavold@gmail.com,
 asantostc@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 0/9] netconsole: stop charging every netpoll user for
 netconsole-only state
Message-ID: <20260526190053.619cc53d@kernel.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-292059-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF44D5DE753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 24 May 2026 09:12:16 -0700 Breno Leitao wrote:
> struct netpoll is shared by every netpoll consumer in the tree:
> bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
> netconsole users only need a per-port handle that lets them transmit
> SKBs.

Are any of the Sashiko reports real?
At least one seems legit (parallel device and target removal).
If yes we should probably try to fix them before we shuffle the code
around?

