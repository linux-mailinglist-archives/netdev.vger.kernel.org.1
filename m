Return-Path: <netdev+bounces-278205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI1VHe1i3WnmdQkAu9opvQ
	(envelope-from <netdev+bounces-278205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:41:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023D3F3970
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859F8305B5B1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458139527C;
	Mon, 13 Apr 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Q9N+w6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CC39525E;
	Mon, 13 Apr 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116058; cv=none; b=ms5MGs+RvvxNulemj/xKWcJ5JkIGrbS2PkCoA3CY4ST6khZesOJQLN03eTSnmRg98m9i5CDn9WmxTLySMdLnoS8x8YjZnjdkkSavR24jkc4EUuFiwgmTXbIYcINhuX/1eHVCSwOIw7CtGASXSoBRnw1rZz4FyerdQ1Wqb3OLW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116058; c=relaxed/simple;
	bh=nN6iPHVDoPf1ZiwVgyq8gelm+4dDqyVAlUk3nosHljc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxud62pVv6kR43gI2IBvQo0rjNM5U65eISE65f123qb3Bb6tAFYeMZ4kOvmtjS8jzIvFQ+htUBndjP/cWUxNgn7SixMwjXqGwxoccU3YkO9zCs0EulddWUwmCgrqvMDvYljh3hllSIX6g4///nRtiJFsuRfW3suwm+HJDlK8X5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Q9N+w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA4C2BCAF;
	Mon, 13 Apr 2026 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776116058;
	bh=nN6iPHVDoPf1ZiwVgyq8gelm+4dDqyVAlUk3nosHljc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q7Q9N+w6G8zxSR+Ba4ACX80jglvBc1+koXL5NnSGVdREDYaOoiF8YJgARNxekwRY+
	 CV3IW+AV3RKm6NU+0c+y5+XWhOJw1Bra/Af7IyWEESQ+inv57ydGvoH9jt+8H0LvH5
	 gYVIMux8pBvx42b7FlhO6+BA8rQlHlNpghly5088UMFTpoynbfHW36oKLAZx4BJ5VR
	 rK0luuLu6/UzL9NK96QAvua339wHgsOivouVHLLeUd0GnEH9o37U9Uk4/6O7gr9h/4
	 uln9Ysj1CdkFKZxnJ8RWTTrJAgo2UcoTEeWbi93e+tjvmVkVwGENrPeUu0obaW/U+a
	 c2IRq724kNMZA==
Date: Mon, 13 Apr 2026 14:34:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, f6bvp <bernard.f6bvp@gmail.com>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] rose: fix race between loopback timer and
 module removal
Message-ID: <20260413143417.0657ffec@kernel.org>
In-Reply-To: <8e76226b-c861-45f5-9d18-8affa0c80525@lunn.ch>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
	<20260413174238.112418-1-bernard.f6bvp@gmail.com>
	<8e76226b-c861-45f5-9d18-8affa0c80525@lunn.ch>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278205-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2023D3F3970
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 23:21:16 +0200 Andrew Lunn wrote:
> net-next is current closed for the merge window. You can post patches
> as RFC, but don't post anything expecting it to be merged.

FWIW I assumed this were fixes, in which case the closing of the trees
would not apply, the patches should be marked as "PATCH net" and have 
a Fixes tag.

