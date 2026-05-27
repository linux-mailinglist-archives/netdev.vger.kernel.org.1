Return-Path: <netdev+bounces-292054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIgNEytOFmqxkgcAu9opvQ
	(envelope-from <netdev+bounces-292054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E7F5DE645
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99F53037D5A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27B346ACC;
	Wed, 27 May 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaqrdgh/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECA33F8C6;
	Wed, 27 May 2026 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846629; cv=none; b=DYlmUJMNVeWIJ+a3bxS2Y4mmvqMT6TsLknj3OuABb71RafzLIb0XcALh3cws1k346Hzrq4+6v5y77IgXM/fkTcPI3L3DYAPSAMpAAsY88yUHeJKhcFAwwug7awgyTepplP8v8pqhE3sPNoXJVLfnF79Y3HD12hzpOvxTLFDPDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846629; c=relaxed/simple;
	bh=tXiQj/FgC32YhbXPpL824wy7CeHakhhEOT4noxRGniw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bpd1xsUQ/VZ/xY7w4qlq0nln+qSnoRFq/yGBtNsVKw0MSMGviezVzyevE2IDrYMMkPrBxe46tHqgwbPKY3nj/ZANqgFJpoRqLghccE8xT9h4eHPjMEmDovDBjK9DsN2YzdwgnedH2URn4fT9mU7tdCmnrsa3UKVvpgRRl8XyteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaqrdgh/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E231F000E9;
	Wed, 27 May 2026 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846627;
	bh=gCOfKsJKp4rbEZHjUHe2JWsdkCHEEc/g57Ts4Qfgy60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xaqrdgh/wj2ddFK91KhkJNkQtdNXKxJIb0iTcmHMMGrQJZXoN0dOZJr5QiUS1rbBf
	 5uLpiLOso4xB2Akf/d763pysCTb+3qSgz4IdZZMeMTGJ9NfoUVxWBPJS9xPlgWqvRE
	 vwuf3gHRmNYGiHdNxxHC7TRWsmNuzbHcwu1GS+K5gkUeDhLq16CHwTWv1rKR+f5NIK
	 ECZxqg9z6dao+ZRiXishrxMSniXspeLvXHHtCEuOT/FARj+Y/a2mVjRlkBZWr8xtib
	 1d5gXF7s4gyfcXazjPDzpD8HdfxiQqcnNhbqNJML4vOc/UEbefkuw7wAZn2pCx/8yK
	 nEpyHo9HgmFjA==
Date: Tue, 26 May 2026 18:50:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Neal Cardwell <ncardwell@google.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <20260526185026.680a4b55@kernel.org>
In-Reply-To: <20260525025854.13982-1-nashuiliang@gmail.com>
References: <20260525025854.13982-1-nashuiliang@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292054-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A0E7F5DE645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 10:58:42 +0800 Chuang Wang wrote:
> + * rps_llc_check - Determine if RPS flow table should be updated
> + * @old_val: Previous flow record value
> + * @new_val: Target flow record value
> + *
> + * Returns true if the record needs an update.

this adds a build warning:

Warning: net/core/dev.c:5220 No description found for return value of 'rps_llc_check'

Has to be:

 * Returns: true if the record needs an update.
          ^
          this colon is required
-- 
pw-bot: cr

