Return-Path: <netdev+bounces-293304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOVBAu9uGmpq4QgAu9opvQ
	(envelope-from <netdev+bounces-293304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 07:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62460B49F
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 07:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3425304420E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B401F78E6;
	Sat, 30 May 2026 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OvVKDCBf"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3317A303
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117227; cv=none; b=hWDP4805tRMkF3GsqYHIXspFaVgA0JFxS4NhIDh3SmhlW6rfyg4Y2EPm1F5kiYyNwo7nzygU01b+szchNMLQwk48YonALeUgb2Ug1REbAe3margULWqXyVeyshOJA1zm/G29BWnr2usgUQMtJkd9APwOD2lp5g1YeZP2AyLVXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117227; c=relaxed/simple;
	bh=bs36QcS8fMJrTk5szSTZJ3tc+6ZBIoy+8y5ivAc9eQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEt1AXV0Slb52Wx0IDJHTS/msYoasz0M2O/oq5pShD/kH++i3QiyGd6Wo4h6pRcSTbt/LtsgV9WepnuFy2BRs1C8Xo6AJQ5Qg6PxtoJ1c9zyeMZXJkTFeHkGU0AymrWpnakE71YafuyhOl2H6oXxyETy0BtUn3JteuuenGitFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OvVKDCBf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <63b950ee-a137-4c65-bace-915f813d5459@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780117224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NUUjgvmzZYYcCbigWCzkHqVs/Edq5TVDYxrE/lSUPM=;
	b=OvVKDCBfL7CPUMEaeSBePNWMWxskvQmhm3K0xBfI0cKDMUgB6uuGzEVdWsym6+HQW8EhK+
	caP9tqBKwZEZxmS+HZeFURu/e9jadd0hpfxuKUNTFtk5e2qcVNYh0udplMt3zn5ePhed5v
	9pZXYQrw+rmqxPQhVy44CEBQj/MGxXc=
Date: Sat, 30 May 2026 13:00:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] ipv6: anycast: insert aca into global hash under
 idev->lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 syzbot+819eb928d120d2bdad0e@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260529152219.235475-1-jiayuan.chen@linux.dev>
 <20260529135116.183e083e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260529135116.183e083e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293304-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,819eb928d120d2bdad0e];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 5B62460B49F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/30/26 4:51 AM, Jakub Kicinski wrote:
> On Fri, 29 May 2026 23:22:18 +0800 Jiayuan Chen wrote:
>> syzbot reported a splat [1]: a slab-use-after-free in
>> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
>> under RCU and dereferences a struct ifacaddr6 that has already been
>> freed while still linked in the hash, so a later reader walks into a
>> dangling node.
> Please do not violate the 24h repost grace period on netdev.
> We are tracking the violations now, if you keep doing this
> there will be consequences..


Oops, sorry about that. I slept on it and somehow got confused about the 
timing.

I will make sure to wait for the full 24 hours next time.



