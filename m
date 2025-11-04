Return-Path: <netdev+bounces-235461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE9C30F5D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E4218C4541
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356682EBDC8;
	Tue,  4 Nov 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yisi93uY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAXRxqSG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4492E9721
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258656; cv=none; b=MGGBnqiAJfzrUy5eu9bjATQRKTjTF0NS4zXc52Adz0722o7k6cq86+QO4UVIf7Y8VidLKw37EfLOEyjFrgvJOBOYF8muqsmAZhy0mQVECd5SoTJOdoKpqLPP3CbpCHoFGb4pgZELmMd3+2eGpK292FTd4G0kAYwFE58NeLzXHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258656; c=relaxed/simple;
	bh=P0QOjc+Y/i4SUjAz9hyI1Est9kQhNqP0MO2eaNzC2o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNC9XcRHExeFLiCT86ICZrjcI2cqT8pjrSzLXMnF7poWlQMSs+dU12qtwgyulT3GzN9YpPhctHsLQYE1t8mCpUitueReudnCynZGZh01RY4M6XjDpwgvqSiKunUCpSdrpulQIvjnssg7yywQK8cgowKGuWRcxNMZpTg9TDQ5H70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yisi93uY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAXRxqSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762258652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrVv52+Wup10TuV26Al3G9RFtHr2QH+o3/M+H4STBAA=;
	b=Yisi93uYoLDPtm9UXMnobClAn/PvV9ANnRISu1ceYvXbcNVg89/azk6o4vLl8NDy2W6S2P
	L2DOhNd6xH+QpJJbHhhGwLCrhcAWWGxNjxf55uwlKHxkmORFtZF8arOKyRA8PJT8mUCAyP
	pud5z/f3h9/H8/15VGcdHDROcKXvp1I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-TjkddFNSMAWOIZ0WBKkrSA-1; Tue, 04 Nov 2025 07:17:31 -0500
X-MC-Unique: TjkddFNSMAWOIZ0WBKkrSA-1
X-Mimecast-MFC-AGG-ID: TjkddFNSMAWOIZ0WBKkrSA_1762258650
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3122270f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762258650; x=1762863450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrVv52+Wup10TuV26Al3G9RFtHr2QH+o3/M+H4STBAA=;
        b=DAXRxqSGaR7gXhm83ZvcIJNnx+BstnhQWeOs1FZVeKdCaBq0GHP0a6oNAMiwceMfnj
         uBXP8ubu70STs/7IjpbD9Xzz13PoqRZM2ek1C9rDJ1a3QfPmdBfu9PKvkY5iieHfB+6m
         KCilcropuWEItOtuFtj1CaDLDFojFeR0Per4sGTLQ3q+81Q4d/wLZawGdJfossyY6WY4
         6p2XlCIWT7j7dQRISam6UeJljRHFdbFCfnbypq6cvOhtq1kJHMEUVQSGTIivSQr9coeS
         wndyDHLxY8z5GvSt7dFAGLXFvinPe764WJs3Lr/ZBbjE5VfNPFHxC84vLBH+R9KunJij
         keuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258650; x=1762863450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrVv52+Wup10TuV26Al3G9RFtHr2QH+o3/M+H4STBAA=;
        b=B8ot+oGoRWAoZ1VUSX5Z8LfTdkd3RsVXDjPx41S+WIr1xi3lY8C250+S3tfp8Kp95a
         jyLtnctSNXWVxrok83TgOR4/i7xKYDL+mhGP6cFudnBOQdtYtxk0QLIsNaFVKpp3cdRd
         mU7I0KBmOeLWVtkHyX/Y6Jde6xSwgy7EPp8UDVfJSWVURPg/uACVvyuZx5X2FwuK1ycg
         Bs8aJjIuG39nInOuSvTLFM3y+pow2i88EA0i3/De5zxl5F83GEBCTdvfaXJFTyW0kdOg
         nq6GyzpQsTIEzZVKWHB6vdgzIBK2E7c546nsvqusKrk4TZFx0ySmU4MsHtxW9TUTDgHa
         HHhA==
X-Forwarded-Encrypted: i=1; AJvYcCWrSXjLXZ6NuFVcdPiFMFW0P0Y4y5GXaGOm+Kt6GN25dYmDrsJVbmqiwtq7hBuOmo/Gb1uQw1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRge4szH084s/qLKOQg1uoeUkCl6avc3milmBUha5hLsv7DlFo
	KWdb+GBkhrcfJj8xvToICa1PkxL5VSJ7v5QF4M/IOAQdTFaHyeiZ0vTemcmj5lsrOda5sVU5sNb
	VqTNKyPMvJmqBOjlQD5OvxUMSDnXjugXQbAFeobzLqyzXBFImZGwUoA8FDg==
X-Gm-Gg: ASbGncs6WXjN/eXWVe66ENAjmGt8kdcOydpLdfZCKvZFDShGdSk4rNHG2Rbj5Arbwn5
	7ZPvr6D+t/hod5gX1Ckb+S9r5yev1uWobtKW6rjqgcJ+hV1//jK232UjmtWfI7IwMeRVMor6Lo+
	sk+27fdTzNgHxBsZeeIQnRO0ECZHNGm2BgKYsabX7qTs1xadteeAm/iPWI4Pk4iXrrJ6wCTl0hy
	UQlaqH3o85Ln6XfvAwge9TIdybbyoPfSlop4Gxaia8jFar9LVeOoa5mvZbDL0UVPc9dGDqOWLJc
	T4MnZaBpSb+xHQvEF3j/OKakZW0849xMKE2bkRXHdCjKK+C6H/Q98mbDkAOPS5xGZ3m/qukvHgk
	99I89tzYpNM2iMxqLhXD0Yn3OOjOyfP7GPmUN4J1PAx0Y
X-Received: by 2002:a05:6000:40de:b0:429:d290:22f9 with SMTP id ffacd0b85a97d-429dbcabe53mr2945310f8f.4.1762258650449;
        Tue, 04 Nov 2025 04:17:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElFwJq3LBE7DNZtfuVK0eheDgsp8L8ZPbTvbUgjo7k2WL6IDip2GsX5myepH9Q0/Tu9JOyzw==
X-Received: by 2002:a05:6000:40de:b0:429:d290:22f9 with SMTP id ffacd0b85a97d-429dbcabe53mr2945262f8f.4.1762258649949;
        Tue, 04 Nov 2025 04:17:29 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5a7fsm4316521f8f.24.2025.11.04.04.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:17:29 -0800 (PST)
Message-ID: <635b0dad-98bf-41e9-b7b6-1f28da48fc00@redhat.com>
Date: Tue, 4 Nov 2025 13:17:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/15] quic: add packet number space
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
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <a1df61880c9f424b49b2d4933e0d6ea0bf6da268.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a1df61880c9f424b49b2d4933e0d6ea0bf6da268.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> +struct quic_pnspace {
> +	/* ECN counters indexed by direction (TX/RX) and ECN codepoint (ECT1, ECT0, CE) */
> +	u64 ecn_count[QUIC_ECN_DIR_MAX][QUIC_ECN_MAX];
> +	unsigned long *pn_map;	/* Bit map tracking received packet numbers for ACK generation */
> +	u16 pn_map_len;		/* Length of the packet number bit map (in bits) */
> +	u8  need_sack:1;	/* Flag indicating a SACK frame should be sent for this space */
> +	u8  sack_path:1;	/* Path used for sending the SACK frame */
> +
> +	s64 last_max_pn_seen;	/* Highest packet number seen before pn_map advanced */
> +	u32 last_max_pn_time;	/* Timestamp when last_max_pn_seen was received */
> +	u32 max_time_limit;	/* Time threshold to trigger pn_map advancement on packet receipt */
> +	s64 min_pn_seen;	/* Smallest packet number received in this space */
> +	s64 max_pn_seen;	/* Largest packet number received in this space */
> +	u32 max_pn_time;	/* Time at which max_pn_seen was received */
> +	s64 base_pn;		/* Packet number corresponding to the start of the pn_map */
> +	u32 time;		/* Cached current time, or time accept a socket (listen socket) */

There are a few 32 bits holes above you could avoid reordering the fields.

Otherwise LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


