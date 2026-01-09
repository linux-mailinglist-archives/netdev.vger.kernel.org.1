Return-Path: <netdev+bounces-248456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1AD08A0E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9535030050BF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB096331207;
	Fri,  9 Jan 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="NOj7WStQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580D33859E
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955092; cv=none; b=Wjg8OIISl93DkcKIn+NmyrqoX8MloBqRXgZt1Mda4g1Y/7C5VgKt2uQq+yW9G0/+b+j6GpoKQlXIyV/LUFRjq7UnNQz4PVhjwRcLEBnlRzMmB+eWhMirBE2+jJO64BiLY2HUWOj5AHH5vwDlf2fFtARuafoE7J1iSfvxVpx7NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955092; c=relaxed/simple;
	bh=ucIdzzWI2zkCadxG+XMJ2cPClencE+x+z6GmUnX0jK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W/6y9VhJdWbezzonl4o0w8s8S5lQ8p448Wi+S8lFG9HGQkokuQiGgSaOq6h9KQbh6Utk+aGbixh3UwbPW+j9oVTcxpd9d3Kg2F5ADwssB9Y1dc7iQNsWSgMGg0dgPMtMwPax6EPIliu3uQMt2M/L1D4zSpoViVpCWic+WaD2N0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=NOj7WStQ; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1767955082; bh=ucIdzzWI2zkCadxG+XMJ2cPClencE+x+z6GmUnX0jK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NOj7WStQNq1Kdw6IfozFzgEL+BUt108PVum2j43GPNL58FJiTUCVYk/QXVlBXyqHH
	 oRa39HjOR1C+2jCujsFdkTPPy8z0s5q1FMuiMSsC01dmOy25IGG6CpkPhHX9ozQ+hP
	 YrModytk4vI+SDL670H/twbsly/bJcgBkEwsaX42ptkb1IAlxlw5UoWR+NJY99Sc4I
	 tD0bbXQTLalM3itIaxsuL0n1Yoh3Lv3n++RllxzcMHIVa6xYDveZPw3WT/F6PCXwQx
	 DKtX4JJIzsoW6/wcE3gdpLkI0RROYvNXjgEt/smVGurk+BBIMUXBEjzxQE7xvEswKP
	 eSfgZ35kqtOCA==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, jiri@resnulli.us,
 cake@lists.bufferbloat.net, j.koeppeler@tu-berlin.de, willemb@google.com,
 xiyou.wangcong@gmail.com, horms@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, davem@davemloft.net, netdev@vger.kernel.org,
 edumazet@google.com, victor@mojatatu.com
Subject: Re: [net-next,v7,4/6] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
In-Reply-To: <20260109041214.2918115-1-kuba@kernel.org>
References: <20260108-mq-cake-sub-qdisc-v7-4-4eb645f0419c@redhat.com>
 <20260109041214.2918115-1-kuba@kernel.org>
Date: Fri, 09 Jan 2026 11:38:00 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bjj32hrr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> This is an AI-generated review of your patch.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net/sched: sch_cake: Share config across cake_mq sub-qdiscs
>
> This commit adds support for configuring the cake_mq instance directly,
> sharing the config across the cake sub-qdiscs.
>
>> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
>> index deb9f411db98..4dbfee3e6207 100644
>> --- a/net/sched/sch_cake.c
>> +++ b/net/sched/sch_cake.c
>
> [ ... ]
>
>> +	if (tb[TCA_CAKE_AUTORATE]) {
>> +		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE])) {
>> +			if (q->is_shared) {
>> +				NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_NAT],
>                                                          ^^^^^^^^^^^^^^
> Should this be tb[TCA_CAKE_AUTORATE] instead of tb[TCA_CAKE_NAT]? The
> check here is for TCA_CAKE_AUTORATE, but the error message attribute
> points to TCA_CAKE_NAT. This appears to be a copy-paste from the NAT
> handling code just above. When a user enables autorate-ingress on
> cake_mq, the error will reference the wrong netlink attribute.

Argh, the spicy autocomplete is right! This was indeed a copy-paste
error, sorry about that. Will fix and respin...

-Toke

