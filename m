Return-Path: <netdev+bounces-202405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A4AEDC76
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E118921BB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9F28507C;
	Mon, 30 Jun 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw2UQQ8Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648E288CA6
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285627; cv=none; b=U9G4YiL1r0H0Au2Jjx3AHGqHbJ3tpf0ijlBHVsvmWJeP+CuKbZcZ9ZNo8/XsIVxnJAY4SK3pBxlQbp+DBCz4Cusp8LBvTzpmYW/c+5MytKlwoLktCe0VCNymiasKFOIImYkqGjTV7VgPa/Vqdg1ybnJXKYJdnlsjixm//SzUwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285627; c=relaxed/simple;
	bh=iY2ch4jUqZ25v6X/XWGTFLWn3SG9VMQxDqdWMCyFNEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrJNjKnDxyN9vq3qiWy31pHWdgDxnGVuyIx+bM8rdWRxSK+j0rF0lCl3Xeydcuv6GlluI4sxNv6/PsofVPoW42VXc1JOmtgUPayAZ07gSpx7qzeZx4G0kPMbz9yO6qAtfuKjTsTi7He/jSczE6UK7QHbInbeEsqYgP4P57DurKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cw2UQQ8Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751285624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdpPBSnOitHeeR2UYouwW9SFYJlysBLXxw2KZq2UsIg=;
	b=Cw2UQQ8YiH/S6V3mDoR3XN+8H75lel1nfDad2PwOY6BKf7odVmd6pgKa0J986oCmyeWsVF
	DprSYdIHKN/fvOAkK3/IlUujrxLtf5LU6ZFEGKDKL2YHll6eUwZ7+xv7hDEUmTruqAMyNo
	4QP7+7yb1nPb1QZwDWs8i3U1Nhk8vDA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-Z8LOzH3YNHez3LwolDL08w-1; Mon,
 30 Jun 2025 08:13:40 -0400
X-MC-Unique: Z8LOzH3YNHez3LwolDL08w-1
X-Mimecast-MFC-AGG-ID: Z8LOzH3YNHez3LwolDL08w_1751285618
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD6611800287;
	Mon, 30 Jun 2025 12:13:37 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 358E818003FC;
	Mon, 30 Jun 2025 12:13:33 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,  dev@openvswitch.org,
  netdev@vger.kernel.org,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S.
 Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  =?utf-8?Q?Adri=C3=A1n?= Moreno
 <amorenoz@redhat.com>,  Mike
 Pattrick <mpattric@redhat.com>,  Florian Westphal <fw@strlen.de>,  John
 Fastabend <john.fastabend@gmail.com>,  Jakub Sitnicki
 <jakub@cloudflare.com>,  Joe Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
In-Reply-To: <CANn89iK0C+cmhPsikuAztBjppkr6W1NF3mFn0Rh1Npb+yDgzHQ@mail.gmail.com>
	(Eric Dumazet's message of "Mon, 30 Jun 2025 03:07:54 -0700")
References: <20250627210054.114417-1-aconole@redhat.com>
	<20250627145532.500a3ae3@hermes.local>
	<CANn89iK0C+cmhPsikuAztBjppkr6W1NF3mFn0Rh1Npb+yDgzHQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 30 Jun 2025 08:13:32 -0400
Message-ID: <f7tecv1pgur.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Eric Dumazet <edumazet@google.com> writes:

> On Fri, Jun 27, 2025 at 2:55=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
>>
>> On Fri, 27 Jun 2025 17:00:54 -0400
>> Aaron Conole <aconole@redhat.com> wrote:
>>
>> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> > index 429fb34b075e..f43f905b1cb0 100644
>> > --- a/net/ipv4/tcp_ipv4.c
>> > +++ b/net/ipv4/tcp_ipv4.c
>> > @@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash,
>> > const struct tcp_md5sig_key *key,
>> >  #endif
>> >
>> >  struct inet_hashinfo tcp_hashinfo;
>> > +EXPORT_SYMBOL(tcp_hashinfo);
>>
>> EXPORT_SYMBOL_GPL seems better here
>
> Even better, not use tcp_hashinfo at all, it will break for netns
> having private hash tables.
>
> Instead use :
>
> struct inet_hashinfo *hinfo =3D net->ipv4.tcp_death_row.hashinfo

Thanks Eric - I'll make sure to use that in future.


