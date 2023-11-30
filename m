Return-Path: <netdev+bounces-52550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CF7FF231
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AD21C20DDD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3253C6B6;
	Thu, 30 Nov 2023 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Mjyr2vwr"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515E85
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5NgPc7GHzRKED0Ib5dQL25cqaCEVJt7eXcZUzWsfGqI=; b=Mjyr2vwr2awI1ode/GlMtMj8gW
	6U+RnnREylQQShJzym2RzOmbZCxADl8E60bPtpuhjSwWLA7qfURuJTJk5b6sK7NaIl/F/8WpBKG+p
	f8yZek59D8jqgjjfkGbhvn1PF4ffaQCAxviMY2/2LNF2VNSGN3M4ekhlmdv2b3rIxwIhOkCXnDps/
	0CbWVKCQgqKrzi/44sf0STiVGYJXrq1wieZLSELHh3WZxM+DBTR4aGfevZxzamL2B2gD5MAJhp+jZ
	LckT5s0tU3JatZrK/KyQktn9Jhf/FqU6SGFwo+ieEgHxDxK3AJCikQWXU+NctunWw4UN6nvhm4g/j
	fU+kJoyQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8i9z-000Nyp-T0; Thu, 30 Nov 2023 15:36:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8i9z-0007Jv-ID; Thu, 30 Nov 2023 15:36:59 +0100
Subject: Re: [PATCH net] net/packet: move reference count in packet_sock to 64
 bits
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Cc: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
 stable <stable@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <2023113042-unfazed-dioxide-f854@gregkh>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <37d84da7-12d2-7646-d4fb-240d1023fe7a@iogearbox.net>
Date: Thu, 30 Nov 2023 15:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2023113042-unfazed-dioxide-f854@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27109/Thu Nov 30 09:44:04 2023)

On 11/30/23 3:20 PM, Greg Kroah-Hartman wrote:
> In some potential instances the reference count on struct packet_sock
> could be saturated and cause overflows which gets the kernel a bit
> confused.  To prevent this, move to a 64bit atomic reference count to
> prevent the possibility of this type of overflow.
> 
> Because we can not handle saturation, using refcount_t is not possible
> in this place.  Maybe someday in the future if it changes could it be
> used.
> 
> Original version from Daniel after I did it wrong, I've provided a
> changelog.
> 
> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> Cc: stable <stable@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

