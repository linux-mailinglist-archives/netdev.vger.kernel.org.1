Return-Path: <netdev+bounces-284250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFCWOJyl+WnR+QIAu9opvQ
	(envelope-from <netdev+bounces-284250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:09:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B14C873F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8BD3007F7E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE173E92AB;
	Tue,  5 May 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmgsvavn"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EB3E4C90
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968513; cv=none; b=IygUU4xi3aHZzbuUvvhtx7e8WyOfvGoiA0WV2efYIOBaxz7gW0bHWiz3TEdiuOHSsSvrnzb5XpCDflXpbdVpgZ97U8kdxGykJ6f17jr8P1q0eYXjso6BiVhGkEtlonArWAmCuXQdn9ORAAQACwlYJbnc24+ryy7LbI+b2jppCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968513; c=relaxed/simple;
	bh=sIu9c5Y2qNQ8T3cj5DKUVHTYsDA82QIYAwtNf88JphE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0HYpqbdcGE7wiYIEt20xf/1QAH5H8Y9Tpep03qmQy+UNfh990Y3RkZHIwa5L86Uvt04zI74KO9NiFZuaQ0Dhb80WfbPFy/Pe4w4+yuyRV4eeNSK2Fmo/mdGTmnGiOsbMH5WGEdsZ0XOOXm0K/NWnSzL5vMxyhI/4vlzOjuOvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmgsvavn; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777968507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kLR2PQ5IHLkV4q2GDMgCAmrx/FMDnC8NB7Ea0Z3IjbA=;
	b=qmgsvavnJsd8aV40I9TpWDeRrEAWEcjESP3FBquVmAP4MUYQpCEPfQJUz3xJVXa6SS8tGm
	Co3t7hOKJpn7lnecoeutTab5evKqFG36B73kDuGIYnQ51QpYuL7TiPZvQe7sht12Lj1HxV
	14xrNxS5zxUD0+RDxsSp2htv5KkaifI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,
  ralf@mandelbit.com,  Hyunwoo Kim <imv4bel@gmail.com>,  Sabrina Dubroca
 <sd@queasysnail.net>
Subject: Re: [RFC net] ovpn: fix race between deleting interface and adding
 new peer
In-Reply-To: <33639813-1de3-4a82-966f-7a0daab25433@openvpn.net> (Antonio
	Quartulli's message of "Tue, 5 May 2026 02:04:14 +0200")
References: <20260504142033.2327646-1-antonio@openvpn.net>
	<20260504165450.7cc15bcd@kernel.org>
	<33639813-1de3-4a82-966f-7a0daab25433@openvpn.net>
Date: Tue, 05 May 2026 08:07:56 +0000
Message-ID: <7ia4qznq1dpf.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E22B14C873F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284250-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mandelbit.com,gmail.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roman.gushchin@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim]

Antonio Quartulli <antonio@openvpn.net> writes:

> On 05/05/2026 01:54, Jakub Kicinski wrote:
>> On Mon,  4 May 2026 16:20:33 +0200 Antonio Quartulli wrote:
>>> This patch is sent as RFC to give the AI a chance to review it once
>>> again, since it was able to spot a new race condition in its
>>> previous version.
>> FWIW I think you can just ask for Sashiko to track the openvpn
>> mailing
>> list?
>
> Yes, indeed.
> I just went through this discussion for the batman-adv kernel module.
>
> @Roman: is it possible for Sashiko to consider certain patches only?
> On the openvpn-devel mailing list there are also patches for the
> openvpn userspace program flying around.

Sashiko ignores all patches which it can't apply successfully to the
kernel tree, so it's likely not a problem.

If it will be a problem, I'll master something.

Thanks

>
>
> Regards,

