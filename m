Return-Path: <netdev+bounces-94222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BC8BEA69
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C7B221F0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893B1509AC;
	Tue,  7 May 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cp680MhP"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067B14E2EF
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102078; cv=none; b=J8SLlTVEra5T6e8hdR752hoijeZjtcJ77IlQM0OtEg1F/giD9f0ZtGmKElg5Hu6PWA8RRc49e29FIFK/6Me6yWJJtTnb728Wwksuxy4GwUcab3TBIqEBZeCFCscSEXOg9M2SNlV4p6Bunseah8yqK42IN1WD8BZ/KtiJWXlMmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102078; c=relaxed/simple;
	bh=TO1h/li+oup9MqcTYIbz0gdRv4yNy3lYo2K+l4oeUtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZneBn54/1LzfH+7bT1HDVijTz0NFJEtcOUljX3FvFAVknUDNUYOwX4Ql2paWwGGBg89J8ZNCYeIsRMvdHA1gwcpvOd1F6GXYwBJ1xBkoOmYecnoPsO1XJ7aOnanGu6TgpB/OOjSiotEODVfebEftsBQYPbgZiJ1hjkQbwDwUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cp680MhP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s4OOc-00E5i7-SO; Tue, 07 May 2024 19:14:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=TO1h/li+oup9MqcTYIbz0gdRv4yNy3lYo2K+l4oeUtY=; b=cp680MhPSpdYEVuuW2eVI41WP0
	JtRk0XmAQ4xYZcZSgjZe9f9W03A8f4a+uBhNA7Fzl2yg+eeW9OvNU64bCChmahzWb9pHTk2SKFySt
	YhsHDQwSiiB2OpKPQcPXWvvxIZH9kViitxpMyjfmAo4ZDV0KTlJTi9eH+ZewCxytIOW/rqiT8AeDN
	pwPH3IML8SPzXGJxHmJ2CHM+W4UdzbJ7iRZc8WP4MJLY999VmbgB32fs3+/GV+PqJIdyAAQZf+uEI
	CAumM0mrt9536Ll/4Qj0xJK9Pe2AtyFZt9N/uOrbGlYBV6WKCM/Cwfm8qUY+u/CplAsjuIpffq+Tt
	xEakFmzQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s4OOb-0001Bj-Kc; Tue, 07 May 2024 19:14:29 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s4OON-002nU2-ES; Tue, 07 May 2024 19:14:15 +0200
Message-ID: <d92602c4-f192-44e3-b974-220d9b928da7@rbox.co>
Date: Tue, 7 May 2024 19:14:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] af_unix: Fix garbage collector racing against send()
 MSG_OOB
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@amazon.com
References: <20240507163545.1131404-1-mhal@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240507163545.1131404-1-mhal@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/24 18:29, Michal Luczaj wrote:
> Garbage collector takes care to explicitly drop oob_skb references before
> purging the hit list. However, it does not account for a race: another
> oob_skb might get assigned through in-flight socket's peer.

Ah, my apologises, I'm not subscribed to netdev and haven't seen
https://lore.kernel.org/netdev/20240507170018.83385-1-kuniyu@amazon.com/
I guess that was a race condition ;)

Michal


