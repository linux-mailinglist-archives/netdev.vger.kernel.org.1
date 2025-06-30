Return-Path: <netdev+bounces-202404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266EAEDC75
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8147A4402
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8B28982F;
	Mon, 30 Jun 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzDTJP2Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B661B4F1F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285609; cv=none; b=DQ4CtKK1R64+pxjOJ7oRgZRxSN1/MeGnxU9ufhDy6ZcUynfB58VhpP/JMviPnw9+F1A/JwOrRFSsitosP/lyCc51uCDO29qZf9+87SDnca6KOIKNLiDZ3JvDM0QTqhCccMpkjDFtOKgKWQ9yjvoVUrkvJOGdCFX90s01Nq1arCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285609; c=relaxed/simple;
	bh=V9GshE4FL9T1h9TFGXTShJYEZ3xAMGtgo1EQg5/Ypks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SopUr66ZNVYRjRslsclYgKJ7PoJ+scRa2Fc6V3xFYcAN36NP6uVe2T3m6IP59hSUXlUnCC7PdTpRoTTRc7CFJv5PlnbiKvam7bNakwB//2qlFGr6bPDQtfm1nvi/SVtXA4jSSh+ImtsPg2ns7SfrIx57AirHZVL5cQMtGGIJ/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzDTJP2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751285606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n1ks9q/aEdfN41uT+wxJPOShcXKS8IqL7xvV1Tc3fhI=;
	b=CzDTJP2YMwmclcWHLVkvE1lqhR767I/feAE7K/R4pHTQb7lD8m4RNWkTjXPoJAGMhMSu5W
	/bjoKch5rycChCd/2x0hfJOly93ClTBkL6TKu+uNt0lPbSypfRW6ubKXHY7Aka9Q5m9zwY
	eD9hXzhE5fnsKGoB1Ar8f/gA9O345mE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-fb21NITGN4ii8F2te0isjw-1; Mon,
 30 Jun 2025 08:13:23 -0400
X-MC-Unique: fb21NITGN4ii8F2te0isjw-1
X-Mimecast-MFC-AGG-ID: fb21NITGN4ii8F2te0isjw_1751285601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1AFA18011CD;
	Mon, 30 Jun 2025 12:13:20 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B16BD18003FC;
	Mon, 30 Jun 2025 12:13:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@openvswitch.org,  netdev@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  =?utf-8?Q?Adri=C3=A1n?= Moreno
 <amorenoz@redhat.com>,  Mike
 Pattrick <mpattric@redhat.com>,  Florian Westphal <fw@strlen.de>,  John
 Fastabend <john.fastabend@gmail.com>,  Jakub Sitnicki
 <jakub@cloudflare.com>,  Joe Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
In-Reply-To: <20250627145532.500a3ae3@hermes.local> (Stephen Hemminger's
	message of "Fri, 27 Jun 2025 14:55:32 -0700")
References: <20250627210054.114417-1-aconole@redhat.com>
	<20250627145532.500a3ae3@hermes.local>
Date: Mon, 30 Jun 2025 08:13:14 -0400
Message-ID: <f7tfrfhpgv9.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Stephen Hemminger <stephen@networkplumber.org> writes:

> On Fri, 27 Jun 2025 17:00:54 -0400
> Aaron Conole <aconole@redhat.com> wrote:
>
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 429fb34b075e..f43f905b1cb0 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash,
>> const struct tcp_md5sig_key *key,
>>  #endif
>>  
>>  struct inet_hashinfo tcp_hashinfo;
>> +EXPORT_SYMBOL(tcp_hashinfo);
>
> EXPORT_SYMBOL_GPL seems better here

Agreed - I think I meant to set it that way.  But given Eric's comment,
probably won't need to keep this particular hunk.


