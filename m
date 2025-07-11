Return-Path: <netdev+bounces-206135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAFB01B7B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EC15A4696
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AFC28BAB9;
	Fri, 11 Jul 2025 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QDF36VfX"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930E1F4C8C;
	Fri, 11 Jul 2025 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235639; cv=none; b=cVpuZXq1qLI+iv4o9rQw+oEqsmTOMivQJUaEL8vi3I2I0xqPZj/Qhs3Z2VZv8yrNKqfSBcKlZtmlq4dmiZRIaHBlRXCxNHMVwP/CYTGtBLh4zLT5HxvMjP/Uh68OC7kBUlCgJHpYtfvuYHnLIqhBD3GcDxuoEFHiuyWJ2wfPpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235639; c=relaxed/simple;
	bh=AerIy58F2mKyZGTVixF+HdoXIruvmQT/irkGVWnAmBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMMbhB9ibE5CrPKTqYp9fbDzfyhiXrYF/dny/lsPERe1oA+9iQtHaATug0cNZumZ4dxt8jVCPpCfOZrOYAmvze3TXqJLct5qAOxsROYpRDUgVLcw7mzxZAdu0vh0dPK2wMQHiTb798zXO1kMuvTR5VPpXoO6l9ki1pXHN/tvaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QDF36VfX; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JAPLs4JTtm6yZPE6BGHezf271ecxd012iwqsakCpiu0=; b=QDF36VfXLn68siDmzoKGYjRbwC
	aprINtr/fDqge/PGDeR+Tbq1cZytAN5BC9slNXBAU2a0VzVf8+oWHmhiOJcyWHsoNhJcJ5nFQEMcp
	YMpZkjqAl7QcU5QGOPXTFD2/2w+nFMZxTI7TbQoiDa5h5Ekh6YbrCWYKCJJOe6taUHd8=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uaCWo-00A2pQ-0W;
	Fri, 11 Jul 2025 14:06:58 +0200
Message-ID: <2c84bde8-5d5a-467f-a7ac-791207e7903a@nbd.name>
Date: Fri, 11 Jul 2025 14:06:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Richard Gobert <richardbgobert@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250705150622.10699-1-nbd@nbd.name>
 <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.07.25 15:45, Willem de Bruijn wrote:
> Felix Fietkau wrote:
>> Since "net: gro: use cb instead of skb->network_header", the skb network
>> header is no longer set in the GRO path.
>> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> 
> Only ip_hdr is in scope.
> 
> Reviewing TCP and UDP GSO, tcp_hdr/transport header is used also
> outside segment list. Non segment list GSO also uses ip_hdr in case
> pseudo checksum needs to be set.
Will change that in v2, thanks.
> The GSO code is called with skb->data at the relevant header, so L4
> helpers are not strictly needed. The main issue is that data will be
> at the L4 header, and some GSO code also needs to see the IP header
> (e.g., for aforementioned pseudo checksum calculation).
> 
>> to check for address/port changes.
> 
> If in GSO, then the headers are probably more correctly set at the end
> of GRO, in gro_complete.

Just to clarify, in inet/ipv6_gro_complete you want me to iterate over 
all fragment skbs, calculate the header offset based on the first skb, 
and set it?

- Felix

