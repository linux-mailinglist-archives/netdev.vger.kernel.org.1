Return-Path: <netdev+bounces-274810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGr8NsEOz2lysgYAu9opvQ
	(envelope-from <netdev+bounces-274810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:50:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E538FAA6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DACF9300A131
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6AD23C512;
	Fri,  3 Apr 2026 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srvf+Rul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10E23A9B3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177348; cv=none; b=peG9BKmzukDl178AgCQQpRrcI04bPe+RnCxlZLAfCP65xELSuzfhv4vGL4L4OmL+4G7UG1+fwYF9ovLN4YIg1sIo10Y04Cs0vLae2mFs/BAt53g/+DmxD13/ZAv4DRB5okc65bjtyJwmZwKObHtZMZnpRzJAmk7TO9dPncawNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177348; c=relaxed/simple;
	bh=d4vkOIbe+jA8cuAVoFVgpaN7Kay0cv4uL520qBfVExQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xoo2iypK9jlFz/kYZQbUjGP3s95v2gupxmgIfwO1ptHZ9Wu3VcgpdFhIQ03MvpIoTOsCmyZy4KI8ux5nAW/w38fs+e6w1mtBRAo7zt9gA1gW3PACp0y1qLNpoevpaolvuMfpW30BxJP1NUr5RG8SGF3QnHa3V+5q+phDfeDMakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srvf+Rul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D593C116C6;
	Fri,  3 Apr 2026 00:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775177347;
	bh=d4vkOIbe+jA8cuAVoFVgpaN7Kay0cv4uL520qBfVExQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=srvf+RulFPyP1lLN7p5yA0uLRpo4ICKTC+TDC+gw5QXHjTbGLo5rYVG7b1jgNofR5
	 u5VVu77kakz6ZARRmzcupOS5F/IYCdu3KCNA7qo6yj/VecSY//ywWNCp6KtDo7BYqL
	 NgrsbOSaqaF2xtJTx1/UY7IENM3oFEe2pRCCYzIXNu6qxujAUO/UqgADrIdH5eRhk1
	 ZtLeIdyyd36R9beOw9DxhdzAaYjOZ+obLUdUX5WHT9P1Uq8gkAm3PAQGo7g0ULOVQp
	 FoJAi/MslKFLoJ4DRJ4qWbxjdZsgb98N2Ao8KdqREVyM3dreDL3OhleWhU0EZ+9m5w
	 m3xulPEOJKAeg==
Date: Thu, 2 Apr 2026 17:49:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/7] net/sched: Fix packet loops in mirred and
 netem
Message-ID: <20260402174906.0ee218f2@kernel.org>
In-Reply-To: <20260402131618.21624737@phoenix.local>
References: <20260326181701.308275-1-stephen@networkplumber.org>
	<20260402131618.21624737@phoenix.local>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274810-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A7E538FAA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 13:16:18 -0700 Stephen Hemminger wrote:
> Why is this marked Changes Requested.

Is this a question.

