Return-Path: <netdev+bounces-245676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F49CD4E65
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 08:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A65300E3DC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069F9302741;
	Mon, 22 Dec 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nxNbiH3s";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bflwTc80"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EB2FD699;
	Mon, 22 Dec 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389718; cv=pass; b=gG3ibAi2szp6NaPwmqMeEF7ibrkvOpoM+kGpkTFH6hWbLbmEw8DA7Gfo+TgVc1HOVEVJM2LU+eujGsbzNhEdaGlejHPlUk775ayGs6gmfhybW206ki7mEkub2Svt7jxL40YWEePqwcvRZHxOTfQYClMs9ffTfUvQvOwDYTV1Kyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389718; c=relaxed/simple;
	bh=yq0Pa0EhNj50KN+PsuqmojBUm0vgMiDXqU8SjFIrfNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcUS14Xt7tduOJYaRp3sTFz+N3EY2e7vA3xg8umerWHjCvCjEPuIIkLV2/nq5m/PQBOsI3JHYlbN7cAR6Su9Z4fwA1bAmOixO2lmuZFFiM1EeGvYo26qjwOOIRtDT7LVEf8vTFdOp0slx/3gJ2Y/TVGFHZ7uipKjC4x34RDXUdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nxNbiH3s; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bflwTc80; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1766389709; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cunZ8vSmPPvAbczI76mKmdRsHFX6ucKeHU01Z4VqpxbL/53OKna/bAJISXXJC/nPyx
    av5FtRD0ZPLxyR0VO7O/5vpNliixSjkM7OzTGXnQ7+QEKeayz1sJxItqn7zHD0zPLlWm
    GKe93iccRVO2rI38MU4eTn84chyPOJy7k6iqvbnMXyHz0k7qCFujsyQL6CBVeN/59fHX
    Aeqq/TsAO5L9TXX5c+nUztarEjA2bYSycd+7u5moaBOXJiqi3qwJQvLmkPQheHswLJ2s
    elbIZOQ9qUjgBFmYirzReYR8RUMkXzO9Cn6oGEPOz75N3zNCyiKorZCprB13i3LNCR0E
    87fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766389709;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J/2Q/Oke8TdKbyOXgfNzuShDUrhIepncbabd6YqCCjk=;
    b=WRq6Y8j/zLY4L2BB5h8AGpfeKI5yn9/PKBvvmWzfUHc3D/5bfVNfhzPJnv5M0NKY4h
    3lY4ytmPz2ie++9ozb+nTA9KwLGtNc6nP2/JUVhGkP7UbiiQNf1YVo/suPV2DIFDzSpG
    rRYSCQdyCTc7yrtnH7vhVWfbr5Tc1ZhqIgCs3SAzT+9a0tJzUfCdLLAu5anBYrjWlLpB
    KBna4LguD070CpgLFmyik55uiUQAX3XdC+yd+Ccj/3LGGrKJQDwNhAaUBbIzv+lz6e/1
    9E958MTSTk3Kn2KakXKvYHkBCET1xCZ+uwk2IirQSgT9TeHc9jvnjNbhvPFbD2FeWcPi
    2NtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766389709;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J/2Q/Oke8TdKbyOXgfNzuShDUrhIepncbabd6YqCCjk=;
    b=nxNbiH3sIWYvfne3gNKOhc+pdI0JO2DOvuxVkxNK76GCWt9xgu7SL3heuludnNHoUv
    NLkgnU3GDCzQQCu+ec4ZgT/a6VWjGUxR5GzeUzbXVm1b74OYLMP2rrjHKo9TmiBrhZxQ
    eoNSPduSx1aySsYLshRxT5wycByiXmxLWcannek+FMWT0c1CKQHKW4aPgMjG0JKQm5AN
    7Q0svDmZWkligOfSaH4meH7+SsW3Cf7niK9uDhy9SZ5hpB3sky51WX+4YlAQSgEeh5k7
    HVIlJ7iGPyMuD/71koQlHmY0rfUfQtXGR7Do0HcuPS2rs00/mOxyNoGraCnxYMWJA77I
    jZPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766389709;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J/2Q/Oke8TdKbyOXgfNzuShDUrhIepncbabd6YqCCjk=;
    b=bflwTc80seN91N/soGfO47ftDNNk0ojU+mOFc+hcT5+6XbXxXWY440UzHPOEyqjc5j
    +MU61DzKlwwAfZRA51Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b1BM7mSEqI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 22 Dec 2025 08:48:28 +0100 (CET)
Message-ID: <221ba5ce-8652-4bc4-8d4a-6fc379e32ef8@hartkopp.net>
Date: Mon, 22 Dec 2025 08:48:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for Linux 6.19
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Tim Hostetler <thostet@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
References: <20251202234943.2312938-1-kuba@kernel.org>
 <CAHk-=wgG=XFsHgMhgZpOM-M-PMa1cuz5=jExFv0KbajJ4JXN9w@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAHk-=wgG=XFsHgMhgZpOM-M-PMa1cuz5=jExFv0KbajJ4JXN9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

There's already a fix tested by many people which is not getting 
upstream for some reason ... ¯\_(ツ)_/¯

https://lore.kernel.org/netdev/20251204123204.9316-1-ziyao@disroot.org/

Best regards,
Oliver

On 22.12.25 01:17, Linus Torvalds wrote:
> On Tue, 2 Dec 2025 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> Tim Hostetler (5):
>>        ptp: Return -EINVAL on ptp_clock_register if required ops are NULL
> 
> I didn't notice until now, but this seems to result in a warning for
> me on my old threadripper system:
> 
>    info->n_alarm > PTP_MAX_ALARMS || (!info->gettimex64 &&
> !info->gettime64) || !info->settime64
>    WARNING: drivers/ptp/ptp_clock.c:327 at
> ptp_clock_register+0x33/0x6e0, CPU#0: NetworkManager/2370
>    Call Trace:
>      iwl_mvm_ptp_init+0xe6/0x160 [iwlmvm]
>     ...
> 
> and the reason I didn't notice earlier is that it has no other ill
> effects outside of the big ugly warning in the kernel messages.
> 
> Looking at the iwlwifi driver, it looks like the reason is that it
> doesn't have a 'settime' operation, only an 'adjtime' one.
> 
> I can't tell whether it's the iwlwifi driver that should be fixed, or
> whether that ptp warning condition is just bad. So I'm sending this to
> the usual suspects, and hope somebody more competent can make that
> judgement call.
> 
>                  Linus
> 


