Return-Path: <netdev+bounces-97307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83808CAAD7
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD431C2180A
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FE54BF6;
	Tue, 21 May 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JFufAA5+"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AD51C30
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284074; cv=none; b=E8osfYEo48fzr46YZWnauQsid+05E7VCErq82PsfrTH1NKFVsX4bPZ4qH7ZlVrCdosn176lsFwJ30N1LZy6BlvvsfXts69mxKx2i8Y2eTwIrnRYtM0/F1waiKGS+BtAD3Gg8NSWnp6x0je43/a4chf/oEogVTWWb8yyr3QTc7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284074; c=relaxed/simple;
	bh=ysWv9GoBBUuwfVc7hAmoQucfPyZ8KMUuKGe5XPesY0s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jyg4lJpLuhTurJN9FDjf7Ax7NoV3Uiqqvua3RrbFn3DhDMzQ/t0V9qkbLnR+/3yuaztVuUJ+cJRvN5F+FJEvMzNMxT+CxadDR9hgy+hzbGkLe0CMn4eR+O14cuNcu+IT6racRRUlC0tzGnrEcr+EjPc9GIyii2/qHAU2Fj3swg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JFufAA5+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ub6OzTzRGfFGXZBWQpuCvJ8dIqibXht22WVKrr+hdYI=; b=JFufAA5+E7nzvILT7AJTGtklCj
	E1enJIGj5K7D7KZzn/+Td878JxF4ksXloocwUyy6k4BOg0UZNtytNI2A0NIcqP3qgsUas+63LEPXD
	WtNQD26gF4/q/sMubLhr87z3pIy70U2KC76fu0cUq58+tGOQEshv3UCewNXonx0Cxf+YfLTpCMN7I
	vXyI0CFEcVyp6DqFM/fFjT/aVVyEPLda31JaaYzyqOQqA9tbu4IbYC6z74Pc7YoKdbVDBA2NNG8/6
	v1EA0jhr7nghdFMI1AHTg7aeIzeqohUJfrPmPnEMtnby+WdcLZ4A3pNnkqNVkOyVE5LZEYif3m9GZ
	fepPlybQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s9Lst-000Oiy-N0; Tue, 21 May 2024 11:34:15 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s9Lst-000D4T-0D;
	Tue, 21 May 2024 11:34:15 +0200
Subject: Re: [PATCH net] af_packet: do not call packet_read_pending() from
 tpacket_destruct_skb()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Neil Horman <nhorman@tuxdriver.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240515163358.4105915-1-edumazet@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <88fd86e5-b834-ce88-f396-3759dfa61aff@iogearbox.net>
Date: Tue, 21 May 2024 11:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240515163358.4105915-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27282/Tue May 21 10:30:22 2024)

On 5/15/24 6:33 PM, Eric Dumazet wrote:
> trafgen performance considerably sank on hosts with many cores
> after the blamed commit.
> 
> packet_read_pending() is very expensive, and calling it
> in af_packet fast path defeats Daniel intent in commit
> b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> 
> tpacket_destruct_skb() makes room for one packet, we can immediately
> wakeup a producer, no need to completely drain the tx ring.
> 
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neil Horman <nhorman@tuxdriver.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks Eric!

