Return-Path: <netdev+bounces-295582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gUJ+Ix0vImpbTgEAu9opvQ
	(envelope-from <netdev+bounces-295582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:06:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2164497F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="GXj0i/iK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295582-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295582-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53C1303CD0C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CC380FCA;
	Fri,  5 Jun 2026 02:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE053E6DCE
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:05:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625115; cv=none; b=AHop5lC4S77syUOnJrjOTZIcR1R9Y+X/zgKGT5Xs3t8tMgw5OGnxLuBHf0BHc4gopyyTVS6VXQMNoM5XhztIQJMzvryvo54z8JnEpI/lOPGUhjhOrPMNNQB/nHnwtBX6/637B8YbK56xCtQFRD6dklKAro77aJNmManaeSnzngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625115; c=relaxed/simple;
	bh=zwnCPhYlPB6oT77FyXyeja7i6xE/0SDarZyYfs5JuTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmochIwUbWmHWdtyOFOa568tQZtS82MHxie3O4rw152qwDLsmcXCLqFQsZT2zT8Q6Rq2x0cbk/Hei0/lZVg2/34PX2Ls6fHQbNeqoceAjqEAxdDIMoqw35xfS/7duqon1nADrAbaApk5G7/WzpvFOljA24NDamLEZCZlpXi28vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXj0i/iK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E21F00898;
	Fri,  5 Jun 2026 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625106;
	bh=IoGezIQY8JwjEgJLtk9qmtIkob+44rNUO48LJRDa2Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GXj0i/iKeM+ZnpE1cotIxgyXfp4QcXowbRPYndm9qLgaJ+IAa/EzCIpiVFIUWF8Un
	 Gb2JgZO2bJSVSiv3PV9Ot2cykXaGUXYJp3pyOwwdbVlJEph6K9pVkh1zPI+3xVLBmh
	 YiQnw73Nb46cU8SEtkM1NBkQcDX1dJPgPItalw5LgVRnnXxwNFy4c5f7VbQRcMwL3A
	 B3tRf5SwPPbfW9IsiozG3rThlHpw9uUA3RwZrKtRDVaZ/ftQZrTt1m+Qrp9lihBKJa
	 utyhfIjT0YNRKldppCwPTLfqBG8996/TeZGY2uivpuO/CrXVOzGUaaBP10GboOUx9b
	 RKRC9SXA3YvbQ==
Date: Thu, 4 Jun 2026 19:05:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 marcin.szycik@linux.intel.com, aleksandr.loktionov@intel.com,
 sandeep.penigalapati@intel.com, ananth.s@intel.com,
 alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 00/10][pull request] ice: Add ACL support
Message-ID: <20260604190505.14a40272@kernel.org>
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295582-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:marcin.szycik@linux.intel.com,m:aleksandr.loktionov@intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0A2164497F

On Wed,  3 Jun 2026 15:08:16 -0700 Tony Nguyen wrote:
> The following are changes since commit dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6:
>   selftests/net: bind_bhash: fix memory leak in bind_socket
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

There's seems to be 30 issues reported by both Sashikos. 
I'm going to assume that at least one of them is valid.
Please LMK if that's not the case

https://sashiko.dev/#/patchset/20260603220828.829969-4-anthony.l.nguyen@intel.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603220828.829969-4-anthony.l.nguyen@intel.com
-- 
pw-bot: cr

