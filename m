Return-Path: <netdev+bounces-254860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNrUHuSQe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:55:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 106CDB27E3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5945E3034B14
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F50345745;
	Thu, 29 Jan 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzwuvNBN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx4bKnN2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542B344D9D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705603; cv=none; b=EIOsHHsRoYlD4N2+UZQy6lrN+PbRAqdg5opoQHP4LnwzuzMklp0gT3FeMWUZCU5emaNy7gmqO+1ZHXfaHdG8yGRYqxYfSYbsMrP4B4JWBHHgVmGG7yFrKwf2LWfnac1ZnZzup4p9u1FLhM0rmXNZp6OsH9RAf+VLpwAvi36FOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705603; c=relaxed/simple;
	bh=WOGhGhsnQIX0JLxRhL6uuprL7CVf0Nxffn2Etmsupas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjOQ3KBZlv1EASe2xkla6vmC8ztt7KdOZA6hwYdLo7o05R15S/omFrsHAgrRoVhvPug6oxQRBtLvGl9SP3MJG8hwHf+MTedvODAXL218JI7jhGFFa+PIUfMur5sliRNLeWxTO2HPMM9PES6U8RbxT+lc32Y36j7F9J+0Yn+keSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzwuvNBN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cx4bKnN2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769705601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxsJZ4lY7/i7NTzxVza1t8bxhbR1O4VQ7g3k6JdX5O0=;
	b=FzwuvNBNkqnk9SyHXPyHb2M+FqkJV8Xpbb78Gynildhk9o6i6BFqWkYi9OkoxBR96fDITe
	k/E/j8flWnJu+fHSTFBpWyzjjqtnS06tgUiiZbPAXjIphX375H+oSFuciQg3XnWv8hXA3r
	1cERL4tp3ipOrLtFH3+9MHXMeHFrEzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-WUlTHP1-NCqzYo7vq9SJ8g-1; Thu, 29 Jan 2026 11:53:20 -0500
X-MC-Unique: WUlTHP1-NCqzYo7vq9SJ8g-1
X-Mimecast-MFC-AGG-ID: WUlTHP1-NCqzYo7vq9SJ8g_1769705599
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee432070aso9002955e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769705599; x=1770310399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxsJZ4lY7/i7NTzxVza1t8bxhbR1O4VQ7g3k6JdX5O0=;
        b=cx4bKnN23xNlNPkjVSliGWzQOYhrdEjGo2U01yQ5oJXM6nDK7FrqQbEw4KDWMbSk08
         bR3+ek+VXil+s00UnNPRv6+QKZzNxMLNEWhRz2R3CcHpYaPRo+o8EUemjhBeeFdzmLfU
         5NF4++VOTJduSzXEHlqTHcLqyR/8dRh0YHiGRW9vJmokPJPkV8eKRsm83Te9ZS90gqQ5
         wRf5zYhxkI2iBORHx7LclJLjcn5+6+5b0abcYIZQBj5TgS3GI/IUPT/bMLPemLu1EAua
         1AbVcKX6gfKFSpIrpUPeeClvtI/C0NtqJznrCy087PXVC+jQA8vhH72HHBop3PsQH8tV
         a1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705599; x=1770310399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxsJZ4lY7/i7NTzxVza1t8bxhbR1O4VQ7g3k6JdX5O0=;
        b=f2b9Ly3YbRpODJqYtHs2qxd2oU71jmjqVX3gxEX/ybJReXe+vKnFSG8/tRlcVyEVJN
         l18/EWAq8LQeiARBeoEd/iSIDbN0aOUt04OfbcqirlVlQyR0SOlxBw9Vs/Y+1IFjNYxT
         Yo3yKtNlOzA83ZCNC5RwN4Td0xeYY6uRg56r2WHGnvXL0d3ndAVsHdX6QXW32672NhEy
         uYHRgh127mZl9hW7qOoRQJU7zPTzsH6abTE/zxyZz8w7oz4fTQfbNmb77hesa/cyxU8H
         QlGTlxJ49Bo9rJQaU9bw584MzlzQcmmQi9viZz3FlkZMk+gbM6xJlyeRcLpjvGS1ykb+
         QwHw==
X-Forwarded-Encrypted: i=1; AJvYcCXPDJiLFPY53yP1JJXaaONdNdxe99e+b4Lu0rSb0OheEihVwX2wSo8X45C8WVz0fOSnbPUJjnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzXHSFwu2QeSSnvCT6p7Xv1KbhqwmQ2HcmaErz13GLaN+q5bN
	GEllMNMZUlDVHbcXEXMxHkpWcoDvpWhK6a5t1SbwL2C7WKVjXPN7J5aZexFMY5iWTw8GPSZorhu
	VVvXSpbtVLBDNzdyOhRA1s8YsDlV1Cth5zBzVlX2/qXYvsfO/OHLbIU4sKQ==
X-Gm-Gg: AZuq6aKsuqFpAxZpHxujIsrvR1Vlo6ItU/pKN9Xcl0n2tluB6rqgZBzpb+uLZ/znmeo
	kOMJy0mMZ+i6E+653UKAXi63bKA7h6VxayPqvKt8g9upsN5hh/ehMGyhaT2rQKulmmJxlKRTXq7
	FYpLyjWfVraBA9FeWY8HE0zXtDc3Q/wtiv3FfYzBU5GctO62DEXmraV86abyK091wCUGE/WIKXC
	slxogbvmFZpBBG2C7gfnRUmWwhwCxcAzLra0Boqh4Y4iwJJv6W7aRnKzdDTIoxSFXrDBrWnh/9i
	vuH78QD5m6GK9wN5aMLMQQoZVG1vRkpOdhL3K2cL7+UFA5CFEaIIyqzkY0Po0VNEeOIXzfKC762
	ONA2Ljibpez6r
X-Received: by 2002:a05:600c:4e90:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-48069c2a907mr105133645e9.4.1769705598740;
        Thu, 29 Jan 2026 08:53:18 -0800 (PST)
X-Received: by 2002:a05:600c:4e90:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-48069c2a907mr105133265e9.4.1769705598230;
        Thu, 29 Jan 2026 08:53:18 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5e195ecsm793975e9.4.2026.01.29.08.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 08:53:17 -0800 (PST)
Message-ID: <bbbaf4e5-1c31-4c84-adb4-dbb94b8d07f4@redhat.com>
Date: Thu, 29 Jan 2026 17:53:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 15/15] quic: add packet parser base
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1769439073.git.lucien.xin@gmail.com>
 <46f93cbee41da1e1f7b7f408b17915fd93b39ec1.1769439073.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <46f93cbee41da1e1f7b7f408b17915fd93b39ec1.1769439073.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	TAGGED_FROM(0.00)[bounces-254860-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 106CDB27E3
X-Rspamd-Action: no action

On 1/26/26 3:51 PM, Xin Long wrote:
> +/* Lookup listening socket for Client Initial packet (in process context). */
> +static struct sock *quic_packet_get_listen_sock(struct sk_buff *skb)
> +{
> +	union quic_addr daddr, saddr;
> +	struct quic_data alpns = {};
> +	struct sock *sk;
> +
> +	quic_get_msg_addrs(skb, &daddr, &saddr);
> +
> +	if (quic_packet_parse_alpn(skb, &alpns))
> +		return NULL;
> +
> +	local_bh_disable();

Is this really needed? If so, it needs some comment explaining the
rationale, otherwise please drop it.

/P


