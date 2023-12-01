Return-Path: <netdev+bounces-52853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10BF8006B5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D264B1C20A09
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68681CF87;
	Fri,  1 Dec 2023 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fpCznSsc"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1F1713
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 01:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0TibnNM/UlLuBNvrS22ZgUXN5DbVCX61yMojcWNxpEM=; b=fpCznSscJGxyk1O677LOSZQmg4
	iQDOgPwtmuncEueV35R73/zIaDqHMNrrPvfkIh48/RPM3XGqWy1YMQfof3aPGXxzcJQ2rUT32Bqyw
	E8qJQ6T/KhnkL6ytmvFDZLujrfDi2spml1t1NBHNHGBQ9OjTN+OUpKPHEXeXjZ0HCMwUN/xZbCuOB
	pnRWIFnVG6kwLKz/b6u8V9CQ3zjNUxcAzoGiKvt2ThoZqVxLLvPzwwlIzcDnmsuucfs95h79/U1o8
	VH0dhV+DapmtAal4i9JwkauFGBymB9Bn/cSk3ORWK4WtBf9s3221b7f1DnivaQ52XKkEHkAtcEil5
	qB0HJykg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8zgN-000B8P-NT; Fri, 01 Dec 2023 10:19:35 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8zgN-0006qg-Da; Fri, 01 Dec 2023 10:19:35 +0100
Subject: Re: [PATCH net] net/packet: move reference count in packet_sock to 64
 bits
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Cc: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
 stable <stable@kernel.org>
References: <2023113042-unfazed-dioxide-f854@gregkh>
 <37d84da7-12d2-7646-d4fb-240d1023fe7a@iogearbox.net>
 <6568a72eab745_f2ed0294ad@willemb.c.googlers.com.notmuch>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <be8c4d7a-e27c-7bde-280a-ff2444657b7b@iogearbox.net>
Date: Fri, 1 Dec 2023 10:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6568a72eab745_f2ed0294ad@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27109/Thu Nov 30 09:44:04 2023)

On 11/30/23 4:15 PM, Willem de Bruijn wrote:
> Daniel Borkmann wrote:
>> On 11/30/23 3:20 PM, Greg Kroah-Hartman wrote:
>>> In some potential instances the reference count on struct packet_sock
>>> could be saturated and cause overflows which gets the kernel a bit
>>> confused.  To prevent this, move to a 64bit atomic reference count to
>>> prevent the possibility of this type of overflow.
>>>
>>> Because we can not handle saturation, using refcount_t is not possible
>>> in this place.  Maybe someday in the future if it changes could it be
>>> used.
>>>
>>> Original version from Daniel after I did it wrong, I've provided a
>>> changelog.
>>>
>>> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
>>> Cc: stable <stable@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Thanks!
>>
>> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Acked-by: Willem de Bruijn <willemb@google.com>

There was feedback from Linus that switching to atomic_long_t is better
choice so that it doesn't penalize 32-bit architectures. Will post a v2
today.

Thanks,
Daniel

