Return-Path: <netdev+bounces-285751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF1sD563/Wm4hwAAu9opvQ
	(envelope-from <netdev+bounces-285751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:14:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D11544F4DC4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A517F3073162
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F937186E;
	Fri,  8 May 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRm+9gbc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAT+xl3a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910B38228C
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235115; cv=none; b=hd5UkbKwacVqLugQrLif2ckQrdQnV1L+07iErqy9vxp13AFvZ7/U+SE0z7NAUUNWWp8k8At4xkBqYHLCsfvG779OReuE6jxoxQmd6xz0W3AH0JpHZ1YfIe//oneeZ5vBOxjMmoMzqjxHYts8FXcg/7IF8J+55KMOVxKqs1Tysac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235115; c=relaxed/simple;
	bh=5elEoYj/5z4XlNxRebDQfE/NWKivBbNLq4gq+S9kA1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb93liwXxNLvH7DmNDLLuuhrCgQWGKyK1HR/ZNIjiRrEQ0JbN1oOGANGkOFdorKxpffNo6hgCX2hhXbyuvkcFRGCzHNhUURzMIv1ekUcORdUr1U/SHyerIeAHUbilxQ3VyXIFMm1eZrPTXrBsR2+L2aTQGT7mD+YRH2calweK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRm+9gbc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAT+xl3a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778235113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
	b=VRm+9gbcXIUXq3vz5pKOaTFeoKDPGYPqelNiF26r/ZbiJxF7efx99GdB4GPGdiI9B3Xy31
	5QknXi3PawUe6CPeuO9R0+IeJLX8XIagGjEkdgXZSaBIAkJDNPdBRXrq7uqSlKLbh5eU9a
	HEYQTgEwBC8derAvX/vS28WdZa9hc8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-IH_Qv7jUO-2h2v_3onfmWQ-1; Fri, 08 May 2026 06:11:49 -0400
X-MC-Unique: IH_Qv7jUO-2h2v_3onfmWQ-1
X-Mimecast-MFC-AGG-ID: IH_Qv7jUO-2h2v_3onfmWQ_1778235109
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a122a5128so1388724f8f.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778235109; x=1778839909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
        b=eAT+xl3auvACwYVDWNQ/a/vXSSWf7cexflo1EFIy+uSrTc8FpxbKEpEqpfuWWVsxxX
         TdliVyhZCqrZUbhqEf8cbaMOzU12zH9lVg7xk7mypnkmmEfsxHsyZKazvvIWtakdDQ6S
         Hs0OHJmYjVubr/7tgAkJzZbirMrDj5GyjLvJqzFOigNw5NaID9jreA52fXtjBBATKqAF
         VzwfU/FMfTu3C76ri+atdwSEYnIIyUUstgc1vGwQQSIy5bbYifTis2bbIMX6nZLR1jT5
         8w1VcjX+PvN/dn6RR16FXKDRxWsJa0v0WtN9z+8lHzGW28UcObahfcfTPbYQ8kLxZoHu
         CTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235109; x=1778839909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
        b=RVO9rJPTiszOhRDT18HK5jq4KJOHwVBsb1DDyAw/+Owix+r3FeO8o31IW6czfXrRrK
         30N3pWr3F3Y22jAPYRQpxe3zyuMx40zaEau4qAtJfe03hfxgwP9oPvHCZNud2Cq00yPD
         NHEa6ulxAgsCK7FHDgsTdj75aDHqxe5Xo4TPHreYHtdcbDYAe67mT4Qq6/zXNXnDWwi9
         xj8w1NlSvTOrmcb5diP4tTz+rWEx3z3orvuDt1T6qoeiT0HDvKOxdSgx6u7EM53H2YwA
         4hLTOzCae/KfkgX/ANsf47wpoRWjPTI/QsHJmJ/1BrXm4R/LaZL+jw3J2Vjei7yWWn25
         dWVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IOs0+z5YHAtD91vcCPENqzz61X53uyGAhU5Dji5umocCVha4O7BnjX1SlMpDGhA0KauPHn04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JbOmOG6R5rfX/Z3TscQdUbpQZNzAVmowQO8wft+3okq59Hl5
	Kir87BESwdosZSzs5syLibWe5Oopn+2Ogz8XfPI87l+UhZ25yULRganm/s9E3OevZz2y6w+VvAA
	Y5H/bQw88ePKKZczo/K267gA+n0nrXum/LmLJ6SNtDUV+XZv+M4yBhIB6Mg==
X-Gm-Gg: AeBDieubPU6o1OdkQvZn22GnuAWZT3mtTfd6u9TKWgl+4MeYU1EKr3e2dNEdMA8+2eG
	i3/N9SkWFr5Li3TB2N5PRtfU2O/oMEMkHgXS66C/9LYOUCaYEKIcYXROaNHks+zzin5eNkx4jKl
	nhuKtUQ6D5pTq5hG84EGUeAIzz0jvS3vNao7S1utc1OxUKoXPxKBrWfHdjvOZMdU1EqMarVgIqI
	oJZCyma4WNdEL+lX8c+zRCjxe42gCGYAHXIaKbPF2kr3bEVP+n/VLmU4UX/D1GvMvA+WOaci+U6
	RRzwWv2clFIATqK3r7uQZ5vFmtNPKT7e0HvX88cckzfBL7kV5++Mz9J5zweHCFUN9kDNUN+AZDt
	OFa0gFsH7POkm78YSFYPRb//qYv1fULkESyVS0+0gSgVh3L+0onCaxLdwzX4wl3c=
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48e676a4e03mr30602955e9.16.1778235108732;
        Fri, 08 May 2026 03:11:48 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48e676a4e03mr30602315e9.16.1778235108187;
        Fri, 08 May 2026 03:11:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6470sm2848938f8f.7.2026.05.08.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:11:47 -0700 (PDT)
Date: Fri, 8 May 2026 12:11:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <af21ZGlANY6UUCKx@sgarzare-redhat>
References: <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat>
 <20260508055343-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260508055343-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: D11544F4DC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285751-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:58:06AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
>> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
>> > On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
>> > > On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
>> > > > On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
>>
>> [...]
>>
>> > > > > For now, we're already doing something:
>> > > > > merging the skuffs if they don't have EOM set.
>> > > >
>> > > >
>> > > > Right that's good. You could go further and merge with EOM too
>> > > > if you stick the info about message boundaries somewhere else.
>> > >
>> > > This adds a lot of complexity IMO, but we can try.
>> > >
>> > > Do you have something in mind?
>> >
>> > BER is clearly overkill but here's a POC that claude made for me,
>> > just to give u an idea. It's clearly has a ton of issues,
>> > for example I dislike how GFP_ATOMIC is handled.
>>
>> Okay, I somewhat understand, but clearly this isn't net material
>
>I doubt we have many other options given reverting the regression was
>ruled out.

As Eric pointed out, we can't revert it.

>
>
>> so for now
>> I think the best thing to do is to merge the fixup I sent (or something
>> similar):
>> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
>
>I reviewed that one, problem is it's a spec violation/change that we'll
>have to support forever.

I have a few points to make on this, but let's discuss them there.

>
>> This is a major change that should be merged with more caution.
>> Could this have too much of an impact on performance?
>>
>> Thanks,
>> Stefano
>
>It's really a POC, real patch is left as an excersise for the reader 
>:).

eheh, I see, but honestly, this overcomplication scares me. I'll try to 
think it over.

>The correct approach IMHO is to only start using this
>when we wasted a lot of memory on small packets.
>
>For example, if sum(truesize) >= buf size.
>
>then we'll not see a perf impact unless it's already pathological.

Agree on this, which is similar to what I'm doing in that patch.  
Reducing the advertised buf_alloc only in pathological cases (e.g.  
overhead > buf_alloc).

Stefano


