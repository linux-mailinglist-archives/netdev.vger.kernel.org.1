Return-Path: <netdev+bounces-179243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F3A7B840
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CD21898388
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC1146A60;
	Fri,  4 Apr 2025 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="mnTdbCMf"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788117A305;
	Fri,  4 Apr 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743751751; cv=none; b=F0nA7q4TftxaCXWLpgxsYJPeUFpoOZAnpwKAGitrMGMNAHehcYJpiUdfnJOlVCKYjHdTpeCehO9kKDVOgKiSmfTmj22gvEw6EHNXhdT1qXw97dYr0RbT491fZnMWqLL9C/C8umOG8YoPvgWRNAxBIeVe0+KqlNALjxdACxLChfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743751751; c=relaxed/simple;
	bh=Gdy034SGP0SVYJpBA4vja/eidsXwrx3GcUylpIrFV2Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwPEAs5iQPRMiwuUsjXBz3rK2BbaAN2V9RO5X82Ce0e69/B6hQLeqcNF/dLWlAqvlRHw5m+DKiLwt3WDUAp70Y+JBZExTRnyUOLAvbPnud+fczXaVd3OcToBxtpNepyM08HOM356AN5YSbIpUQa26ZSLxzsG98dSmkH7pgeJzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=mnTdbCMf; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 8A8EEC0004;
	Fri,  4 Apr 2025 10:29:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 8A8EEC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743751743; bh=Gdy034SGP0SVYJpBA4vja/eidsXwrx3GcUylpIrFV2Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=mnTdbCMfKEVKSaMs7ivR/LkdrKfuzXKZ8XGuIxDHi73W1H7AHeVn/zPEQewzmh8tU
	 L/2N9WhHFOhXGa+3wITlrZgfzVDkKGJhsPuoaGHD3M7GpEcdG9q1loNfYNKQCo6Id/
	 WnWRnZdRKmnGTc8F1J1emtNq4Gx3pZIYTnWwve4qfhvIgiKPqoaqp2VdAnoDpAy2WH
	 6q/rmLKqNhJRrVK5uXdG6st6hxL6W6cMC4iZLXtF0P3sBFmmLtoKOXb5+Mgr2+XmT3
	 NEOKwHGuwwXPRTsOoZlt6CVjRFUe56dvHo7zZ0fU+YyVQCF2tcJTNgVs2j6tw9EXVL
	 O0AVOFKX6QE1g==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri,  4 Apr 2025 10:29:03 +0300 (MSK)
Received: from ws-8313-abramov.mti-lab.com (172.25.5.19) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 4 Apr 2025 10:29:02 +0300
Date: Fri, 4 Apr 2025 10:29:19 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
	<syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Stanislav Fomichev <sdf@fomichev.me>, Ahmed Zaki
	<ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] net: Avoid calling WARN_ON() on -ENOMEM in
 netif_change_net_namespace()
Message-ID: <20250404102919.8d08a70102d5200788d1f091@mt-integration.ru>
In-Reply-To: <Z-7N60DKIDLS2GXe@mini-arch>
References: <20250403113519.992462-1-i.abramov@mt-integration.ru>
	<Z-7N60DKIDLS2GXe@mini-arch>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Prob_CN_TRASH_MAILERS}, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mt-integration.ru:7.1.1;ksmg01.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192369 [Apr 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 40
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/04 04:51:00 #27854642
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Thu, 3 Apr 2025 11:05:31 -0700, Stanislav Fomichev wrote:
> On 04/03, Ivan Abramov wrote:
>> It's pointless to call WARN_ON() in case of an allocation failure in
>> device_rename(), since it only leads to useless splats caused by deliberate
>> fault injections, so avoid it.

> What if this happens in a non-fault injection environment? Suppose
> the user shows up and says that he's having an issue with device
> changing its name after netns change. There will be no way to diagnose
> it, right?

Failure to allocate a few hundred bytes in kstrdup doesn't seem
practically possible and happens only in fault injection scenarios. Other
types of failures in device_rename will still trigger WARN_ON.

