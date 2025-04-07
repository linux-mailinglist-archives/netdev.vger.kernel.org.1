Return-Path: <netdev+bounces-179571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4FA7DAEA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB197A4AD8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049C22B581;
	Mon,  7 Apr 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="uGtGiQRS"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DD21D3D9;
	Mon,  7 Apr 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021167; cv=none; b=XUHTg6jtDuxek7DKPr5Wh9/pz5amNfwlBJK2zCQClvdLd7UkVVUArO976SkvYo3mdVpgcFfzqYxRUAfrcxO9RE4Fxf7kfp1QbK3sXKb+W9yzpM3kzNJXNiiKbyyFizH+7+HyyvV9nwTBgq41uNDW3iQCcKIWumxFTw5usblaJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021167; c=relaxed/simple;
	bh=fNPGdzrWquW6H1oNi/sXq1ti71yv7YBXmGrGcdUNT7s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvDSWhc0ZuJlK0QC0kr7Ym1MWbiZY8Q10k/0A07fVfVH3UGiKqmujiJkAASCj+JmT05i3djMiDU1h9iDlBZoO7pm5mmU0wVtQxdCxcRZ5svkY5edOS6flgOZsNIvSN9uckSdbqh3f3EuVCOXbauvnxMLgV7MYUwZr1J2XLqU5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=uGtGiQRS; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 8D6EDC002B;
	Mon,  7 Apr 2025 13:19:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 8D6EDC002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1744021153; bh=fNPGdzrWquW6H1oNi/sXq1ti71yv7YBXmGrGcdUNT7s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=uGtGiQRSV26qyWcsaf9CHRdGQvTELi6sXwumlyTusF5GjU20VkcbLqXZhIH8yQf/t
	 BhZuGOSLY9j2v+5PPH9zeg/SxZDHimXAl4jARs5BVoRpacp3NtEGbk7CQXhXkBD+rX
	 Axsqt0o9A+E3NQ9XjcxOlPEFHfDvBeMZAkI2f95EsU0gDAeDFoIqJXME/+dsP1X/78
	 rNRIo43B4hL8k74LdV1M3ECvUY8oHrVlQGmcs8s6PvU/CwjUC2dSzVKH54NJvXAoG6
	 glkydREAxj8k7VtK69dEi0HI4K/9mLUgAJDgZP5eg+tvY9FXKQPo3kOn+42rNHKdz0
	 Cl6Ur/hmLQCjg==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon,  7 Apr 2025 13:19:13 +0300 (MSK)
Received: from ws-8313-abramov.mti-lab.com (172.25.5.19) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 13:19:12 +0300
Date: Mon, 7 Apr 2025 13:19:30 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Eric Dumazet <edumazet@google.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller"
	<davem@davemloft.net>,
	<syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Ahmed Zaki <ahmed.zaki@intel.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, "Eric W. Biederman"
	<ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] net: Avoid calling WARN_ON() on -ENOMEM in
 netif_change_net_namespace()
Message-ID: <20250407131930.70ad6df9d1e8c1f7c413f880@mt-integration.ru>
In-Reply-To: <CANn89i+UQQ6GqhWisHQEL0ECNFoQqVrO+2Ee3oDzysdR7dh=Ag@mail.gmail.com>
References: <20250403113519.992462-1-i.abramov@mt-integration.ru>
	<Z-7N60DKIDLS2GXe@mini-arch>
	<20250404102919.8d08a70102d5200788d1f091@mt-integration.ru>
	<CANn89i+UQQ6GqhWisHQEL0ECNFoQqVrO+2Ee3oDzysdR7dh=Ag@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Prob_CN_TRASH_MAILERS}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192423 [Apr 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 40
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/07 08:57:00 #27861720
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Fri, 4 Apr 2025 10:53:35 +0200, Eric Dumazet wrote:
> On Fri, Apr 4, 2025 at 9:29 AM Ivan Abramov <i.abramov@mt-integration.ru> wrote:
>>
>> On Thu, 3 Apr 2025 11:05:31 -0700, Stanislav Fomichev wrote:
>> > On 04/03, Ivan Abramov wrote:
>> >> It's pointless to call WARN_ON() in case of an allocation failure in
>> >> device_rename(), since it only leads to useless splats caused by deliberate
>> >> fault injections, so avoid it.
>>
>> > What if this happens in a non-fault injection environment? Suppose
>> > the user shows up and says that he's having an issue with device
>> > changing its name after netns change. There will be no way to diagnose
>> > it, right?
>>
>> Failure to allocate a few hundred bytes in kstrdup doesn't seem
>> practically possible and happens only in fault injection scenarios. Other
>> types of failures in device_rename will still trigger WARN_ON.
>
> If you want to fix this, fix it properly.
>
> Do not paper around the issue by silencing a warning.

As far as I know, WARN_ON call on -ENOMEM is the issue itself, since
it only fires in testing/deliberate scenarios. And this fixes just that,
without touching anything else.

How should proper fix of this look like? I would be glad to work up
some solution that satisfies maintainers' vision, but I don't see other
ways around it without some grand refactoring, which may bring more
problems than solutions.

