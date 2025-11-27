Return-Path: <netdev+bounces-242203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D68C8D721
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C2E3A9F14
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265931DDA4;
	Thu, 27 Nov 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Tq4NIyqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171032D948A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234596; cv=none; b=Umv5AZJnt6cL5/c+lUlg5fS0GXzzJVb8qy3fmtY6f6vDp8R8VspipWzfNXrT5cIUSVfTmYWYJhDopDwM2Xk9bMM/r4aQj2yUnXR3BMWTKkpClN/ZK1z8pN8A0jeFWJu5d7RzPUqGQP0L5EGkk8bkCP/d6XZ4IpMTFsFh3GBo5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234596; c=relaxed/simple;
	bh=09HyQ4UGpPJyJUkbkCXpJsFR75Ah+m/bJ0r7EglgoYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejDOBvsCMRVqu9Sw/Xd5cPhMdPabBPWrssMguT31JI57A7ipGSVa2EDLDOvsafpWWXrQyl2ZPVdJCMSMZ2LIsgVypAOrECyAvl/rtHyaZcRupq2a/2eunM0qqAOTTdZDXV/EwuoBgsu3a68wlcU9EaJwxVJh8nA7k0M5UOofTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=Tq4NIyqY; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764234582; bh=09HyQ4UGpPJyJUkbkCXpJsFR75Ah+m/bJ0r7EglgoYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Tq4NIyqYFAvGb+bD4fGeddhGHdvG7EqNSinF+/zfVtyNZXg1aWT12Pyr8GqYVLLIR
	 2HWl8sWe6KGXXe6ElQ0reZ12FNrm/ONW58/vyFCDCOb3aU8RxSJIt1l5SYDZZvKLij
	 CeLGUxSokFWB+jM2KSG/TWbMKZELAfv2PExc0wum2R+pMRQUhN09yaM+uutqPNKIbk
	 650qZHt6H0R+4tMORZUBD7bOL2sgZTY/3Gu+YLwC2xzsfXk/xryRcrFapcBeVbddAN
	 rTLmhchW6Giz/FeRcbqH3YHZluyajDr3cfl4jDUbgs0Pt1QgBboCj4CeLYwuON60o5
	 BchrFULeUAWUA==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas
 =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] Multi-queue aware sch_cake
In-Reply-To: <20251126194305.31ebd8e7@kernel.org>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
 <20251126194305.31ebd8e7@kernel.org>
Date: Thu, 27 Nov 2025 10:09:42 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zf87c04p.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 24 Nov 2025 15:59:31 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series adds a multi-queue aware variant of the sch_cake scheduler,
>> called 'cake_mq'. Using this makes it possible to scale the rate shaper
>> of sch_cake across multiple CPUs, while still enforcing a single global
>> rate on the interface.
>
> Looks like this needs a respin after Eric's recent changes.

ACK, will do :)

-Toke

