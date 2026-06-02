Return-Path: <netdev+bounces-293960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA9SDko+HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:22:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BB6272C7
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13E6302A07A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F8360EC9;
	Tue,  2 Jun 2026 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6RkH9RE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EF21CC71;
	Tue,  2 Jun 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366514; cv=none; b=Dp8hNd6nzrPa8sYYv47MTW1ACQjR/eKnHQWZWtv7CCuJy7BKx9Y9pVQ7179wKHZ7v+KxPiurh+zOlO0SQkeXD0+y7lH9ReYTZSp3k3MvPecJcWuKFF6zmYXyxmrW6eUQUr+4ThCT2f53jMpc8C2iULk6G/QgP8NZIHCCr5ulpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366514; c=relaxed/simple;
	bh=iS3oSOeENinPUEJgOl9XXtENPyVL9lm0vhEjKaQoOnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD3RCn3PVFibeIiAeWpVFhMV+dqfZWHk2s1k4DaWxoNZ6JidtgZCs8EhBsWDg1Uk6QWrRuNsLKzQ5kaWvdOduzu2YbT4bTjK9SgChctKTLbCp9FQZ7TJQhU97tYKq6CnT87OAiyhnD4n6M5c8iBa8eenIrJbgOLExp2Dmg32NZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6RkH9RE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347981F00893;
	Tue,  2 Jun 2026 02:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366511;
	bh=OWXBVpazxpMGc65TYukeAm8VyZjCyS6ISpTK0XKTrRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R6RkH9REKOUhN7E3Ze0Gk5iCy64LTAWI2A/a9yThYIqkIV4B2KcVcxacDcoM71hoq
	 r3I6l0OI0R5ZJJz2EGTVVUpyB1oqyW8HDkadEH51UUbxjXwJgBaHxr/RbUSqfHtOrn
	 NTnKrqK20V6oWw5PVzjTTdIxWXYo6VxSqV8Nwg1V2YMhEIfrslMFvWOO+ISeqGrH0M
	 1E5hVoLCbtv1IB/iMqTCzNsFee6Pf/ooJ4id5DRyuOaIb1r7kR6K6qygpjcGo7ci+G
	 6q5kJ9H7VquEplvM1XJHlegO2yXOnG80GouLWo9YY0qzTnpkymOg29Ct7Os6XPjYz2
	 qm9ITaDz5Q2qQ==
Date: Mon, 1 Jun 2026 19:15:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Tim Bird <tim.bird@sony.com>, Amir Goldstein
 <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/dns_resolver: use kasprintf + kmemdup_nul
 to simplify dns_query
Message-ID: <20260601191510.537f9409@kernel.org>
In-Reply-To: <20260528222030.1655010-2-thorsten.blum@linux.dev>
References: <20260528222030.1655010-2-thorsten.blum@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,sony.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE7BB6272C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 00:20:29 +0200 Thorsten Blum wrote:
>  	struct key *rkey;
>  	struct user_key_payload *upayload;
> -	size_t typelen, desclen;
> -	char *desc, *cp;
> +	char *desc;
>  	int ret, len;

Let's try to follow the ideal coding style for networking (longest to
shortest sort of variable decl lines) if we have to be touching this
code.
-- 
pw-bot: cr

