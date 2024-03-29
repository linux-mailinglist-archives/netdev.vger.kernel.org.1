Return-Path: <netdev+bounces-83600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBD8932CE
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4876C1F22C05
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEEF147C82;
	Sun, 31 Mar 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518E1474D7
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902384; cv=fail; b=d1uMOZrW6UJBXJNafPdc2xnIeMel5l5/S31yn/53gw3LNHWt2BiaEcVM4se/rf151GptWhYUABHs4oVIB005eFXzpwqd4S/mkD7pEzAuoJ+uAik5gStk1C43HDBpjjyM2iIbw5BddyTPejHeNoDtR6iQPjue7f0hTZVeXejI6Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902384; c=relaxed/simple;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okOxpZCIw62eTFhrpHgAYbmedSajsbT/RxomTls/FTQC+1rtyXHf4hLrdmCXn03PWJ9gTwJOlsmuw7E6yRV6PN8g9Yu8kKLe9sG7KmdJMI7BlQ5Nn6tgvaNqn65CplMePAcxlk6P2hU/JZlZZoeyir6EMEEkqAuXbGvqoo9Qz5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+U+9iL; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C5BC8207C6;
	Sun, 31 Mar 2024 18:26:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NV5KtWBsDNRb; Sun, 31 Mar 2024 18:26:21 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2C7D520892;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2C7D520892
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 2005C80004E;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:32 +0000
X-sender: <netdev+bounces-83467-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAPpLp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgCkAAAAi4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10908
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83467-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 6BFD82032C
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI+U+9iL"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748801; cv=none; b=hLKYXnQEay5o+2wB5f0ryqS+rZ4ZW/pWleHMXwjhbqTEO9laLXYaP0C6ZTYGVrNw+Tt5OVQ/RQaNUat82Rt+EhBBWWqzcvErd7KDsFj0u4E1bDi1tepghJvI1eyyM+7gjw9B2Jl5hWUWRNj3KHwymj9hNAeWQKdXyYcIelmzd6g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748801; c=relaxed/simple;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da0PmiKj4OjIEt8CupTNYdDoBOgmm/fmvFKxeKWlbCItOgbA0gtxxxkd4hPTd3TIzWfN6pUedIOpwdyyZE0XgLyjFKerPpbHIyQsmI5+UNZ2pzKJU7SOGYeO/z+jep+WWfr4R1gtnmwquWEj0SLan7cV63m1nEY70J0ZSUYgjHc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI+U+9iL; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711748800;
	bh=WYrLnd5VJ+w8tGoOoxXgy3WX373NxHkTc+nBr5+yjG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bI+U+9iL3hiAq1i9X3EfgmszunTmib3XIbrxUXRflu3eiFNobwQTe80Nf79MnqiG8
	 t3e98Rgu7Jq4Mk3ZE4Fdq4v43fw9On7zw5k3qEWPs63RVIGvHxkkIqzruRT0wC46jl
	 9q2y63dRk0GsdQxnFxFqQ44B8lisQgn22oS7gpVRPtSnINNdrbZMtXLzpz7n7rYzER
	 WwmL/vzkFrdHEj9I9WpPRcCiHv3J4pPbcwn/oyA4gO058KPdy3NpRp992LZOHjmd3M
	 ax2/pQcD7XZi71fGhCFm+oewMT3YFpCaojmdBqcEOVTku7zALR43tPlo8iANKnkNbS
	 495lKCzcWHj0w==
Date: Fri, 29 Mar 2024 14:46:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com, fw@strlen.de
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
Message-ID: <20240329144639.0b42dc19@kernel.org>
In-Reply-To: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org>
	<m234s9jh0k.fsf@gmail.com>
	<20240329084346.7a744d1e@kernel.org>
	<m2plvcj27b.fsf@gmail.com>
	<CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 21:01:09 +0000 Donald Hunter wrote:
> There's no response for 'batch-begin' or 'batch-end'. We may need a
> per op spec property to tell us if a request will be acknowledged.

:(

Pablo, could we possibly start processing the ACK flags on those
messages? Maybe the existing user space doesn't set ACK so nobody
would notice?

I don't think the messages are otherwise marked as special from 
the "netlink layer" perspective.

> > I think this was a blind spot on my part because nftables doesn't
> > support batch for get operations:
> >
> > https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_api.c#L9092
> >
> > I'll need to try using multi for gets without any batch messages and see how
> > everything behaves.  
> 
> Okay, so it can be made to work. Will incorporate into the next revision:

Great!


