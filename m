Return-Path: <netdev+bounces-196748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CBBAD637E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB767AA041
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1A2F432B;
	Wed, 11 Jun 2025 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mnzqxIQB"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36F2F4327
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682607; cv=none; b=bPuB4Chp/HWV+eMRFI+ufSH7NDo/9qwzszOFZPCEmrdyYwYT82n0oWGm93Jguiby6af/CPVme+YOfe1auoo7mX4yy3kFZeCvR7uhs662LbJNGlPRJYUf/J33ynOWJGcYhyx0ovjiw09+0wMEJ5j7TS6niAszCT0mfNBzZwLBQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682607; c=relaxed/simple;
	bh=2FcfchKis3PBcfDwx+uzHZwY400/FZRsCQHA8MRYteM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GArk8TCNX/8X32CMcGoytBut+hgSQdIOT/CUePOhXBm4aueA31cZHH1CcuSsN3yH7H8P3dh4/Zfwqq0u9wcdkvztdluPAQPsbCKwIFdW/RFyMUiA1x7NcluXfimFP6NS74/YrkPLyj0PAymoslEoZDkXRa8ULF3J7HsyRWsBrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mnzqxIQB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=laRor71uA+M3OHb7kJtcc1ktiEYFXJQA45uaZ5LVXqo=; b=mnzqxIQByT1p//T96p4JD2/lOi
	gPQwvVC3Z06PerO4XTCe96saBEjagfc7Ph6f4ZzV6rrKU6H3v15U9/1plbOs/xO7MO0IL0lt2E1EI
	dLHnWnUwZ9YNiniZBpP1tLMNdcVlQlmat36eNESrFqlAjm5KLRZO5rw8oYa1MfD/e8dzNkxdNfyLS
	YEcLslHKP4kf7vWqAXndKOfZQAFkndKG913HHNEHHS4EVuE4dgZCCv/LjH2L7VYkN2m2t//kQXOf7
	tvFfD9Qi3hItflrQSpRKtSBiI2vntEqA0RF1+bAqIhF4p0seZa/noy3+GecKnzFdQDL/9a1ApMVhn
	pZlRccdw==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uPUMu-002OjG-I3; Thu, 12 Jun 2025 00:56:28 +0200
Message-ID: <9049f425-1524-4b39-adba-43f5dd8c3b20@igalia.com>
Date: Wed, 11 Jun 2025 19:56:24 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] af_unix: Allow passing cred for embryo without
 SO_PASSCRED/SO_PASSPIDFD.
To: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Christian Heusel <christian@heusel.eu>, netdev@vger.kernel.org,
 =?UTF-8?Q?Jacek_=C5=81uczak?= <difrost.kernel@gmail.com>
References: <20250611202758.3075858-1-kuni1840@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250611202758.3075858-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 11/06/2025 17:27, Kuniyuki Iwashima escreveu:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Before the cited commit, the kernel unconditionally embedded SCM
> credentials to skb for embryo sockets even when both the sender
> and listener disabled SO_PASSCRED and SO_PASSPIDFD.
> 
> Now, the credentials are added to skb only when configured by the
> sender or the listener.
> 
> However, as reported in the link below, it caused a regression for
> some programs that assume credentials are included in every skb,
> but sometimes not now.
> 
> The only problematic scenario would be that a socket starts listening
> before setting the option.  Then, there will be 2 types of non-small
> race window, where a client can send skb without credentials, which
> the peer receives as an "invalid" message (and aborts the connection
> it seems ?):
> 
>    Client                    Server
>    ------                    ------
>                              s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>    s2.connect()
>    s2.send()  <-- w/o cred
>                              s1.setsockopt(SO_PASS{CRED,PIDFD})
>    s2.send()  <-- w/  cred
> 
> or
> 
>    Client                    Server
>    ------                    ------
>                              s1.listen()  <-- No SO_PASS{CRED,PIDFD}
>    s2.connect()
>    s2.send()  <-- w/o cred
>                              s3, _ = s1.accept()  <-- Inherit cred options
>    s2.send()  <-- w/o cred                            but not set yet
> 
>                              s3.setsockopt(SO_PASS{CRED,PIDFD})
>    s2.send()  <-- w/  cred
> 
> It's unfortunate that buggy programs depend on the behaviour,
> but let's restore the previous behaviour.
> 
> Fixes: 3f84d577b79d ("af_unix: Inherit sk_flags at connect().")
> Reported-by: Jacek Łuczak <difrost.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/68d38b0b-1666-4974-85d4-15575789c8d4@gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Tested-by: André Almeida <andrealmeid@igalia.com>

