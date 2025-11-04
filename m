Return-Path: <netdev+bounces-235463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3CC30FF6
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A162C34DC6C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D091DDC08;
	Tue,  4 Nov 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXuDU95H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="stiVhQzJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491F7E0E4
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259608; cv=none; b=i1EuTlc6PdqYS90WMXZw0TT1Tg4gCNCT9Jv4Q1cbLpkVNSgEqy5BjDbBnM9ZYkZ6xuV+e7OXg5LvyCxXmCSlqJOh4JSk+iNzCs5LaGYc6MEnwydVHkVNbEO6CyNWK/Un1uF4A0WUz66lVtw3qUU2bY3L9wScZs8dknXRZCtUDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259608; c=relaxed/simple;
	bh=rvu6O0E/7DDQAPj95W4jLS6+wxWIiNJJleMFtELomlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvSQgu01798ky8+Kk4tOq1i0n1OFQlKID/PM+Q1kOy+HnhylyrQV/WYr5bCR8BKwrt2DAGl77TgGcXradWFHHEaXq5rKH5M/VYVhFi3Zq4zcviLSIW8KoHlgxhUFDMgHBAqPA8Ve99Sktma9PQkg8S3mNY1eo5uFhJltKtiAKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXuDU95H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=stiVhQzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762259606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+n3IR+AGm5h5aAEd+ooyhPcJs+3zBjyrD/S6ttEIHg=;
	b=OXuDU95Hk3J0WPFLcGJs2ychYOtloAw9/IOt40heLkF5gidwyIlZXJT5ehHbrZx32LC373
	fnvuUEoiRp8Fyri0pMZJZnIEdcozPPiDmcq2krmFn87LJAjrb9y3SA+9FHpqO5PpHcr2bu
	/EBxqVwJbwrdiXV3o8dZttwkiaCmRtA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Hs_FHZtlO4ao7WZp57gHZw-1; Tue, 04 Nov 2025 07:33:24 -0500
X-MC-Unique: Hs_FHZtlO4ao7WZp57gHZw-1
X-Mimecast-MFC-AGG-ID: Hs_FHZtlO4ao7WZp57gHZw_1762259604
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47740c1442dso22714685e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762259603; x=1762864403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+n3IR+AGm5h5aAEd+ooyhPcJs+3zBjyrD/S6ttEIHg=;
        b=stiVhQzJERihGDSGANrOwBIliV3rj2JtRSF8aPsMEj8BAnWzn1ej2jCJLoBQC8B+U8
         INB2UOvxAJGYTcJOR9WlQvxSUhwEkme1nL+OXs6/tZo1yF9+QqtqKl5MREw2EllXxB+L
         o5UPl1Xg63masJOqFo4Zo8xT+bNQ8tFjR6dL+MpaThTgLLrTzrjG2mm1z0wsndxNALp0
         Gh8IY+q24dG6eiFOzwfTK9ttqBGr3jGLRWd8KWSwFDeVLomS4P/581O0qadq3lQ+bkj+
         yZ0u4HHTTRdKwjPMT/qREpAKAchhwb5gaODXPgEskrpoFROO1iZJuR5XO/UjhVz9i/LA
         rvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762259603; x=1762864403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+n3IR+AGm5h5aAEd+ooyhPcJs+3zBjyrD/S6ttEIHg=;
        b=eQy7kCGAmJIqu7ubinblUpeoBZTUXc5KzlmEHVWsmudfnlHyWRj/MMtQbFswKNeKqg
         tSJWSJlgRK21VxuZEk10tc2znvCrHTD91TWGkifSYDhLM66aU62NvpD4OHoFrM32m6MW
         wYYnnYfJnVMNMkrKn+gh1hO4fLApLy8HIJAJbhqbave6DPfswxtxkCnDo+nScYGhyNTe
         5H9JiXTBb2ibpMj2AmNYSQPKkZ4XkIZrJYVdmgMQqhYkBtZdm787OMwmbfQF4yXRgE/t
         f2H27nSc2wBKGGH2vAyA8nBPnkJMI2MyIBu9x4GqCf4hZ21xjNH9QrozsDPGMuInBtkU
         NoAA==
X-Forwarded-Encrypted: i=1; AJvYcCUGk1e+jRu2tS5lT3rNPxfJxAERIK2UrNNyeYJ/7hx/51yIE/0S+IGBcbmVBUs+BNS85meNLbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyxhEh+1Xl/9h4JXnneeE3s518lFpPo471MZ6SwF90zMhsprJ
	r+p6AlulbfT7WgPtk0kFUUVaalKU7sRh232LUKZcH96wH63PRYGoAHs6k+OLcCW3AcODj5OqQfU
	+nVkH85SKEJwQqubA7uVEN7Zgdg85X7rLUvwUGNYVxa7Nx+whi47cwevR3g==
X-Gm-Gg: ASbGncufIxflZ0p1nwziNtA4a2HmFhnn3/ndDnoC2Y+UsB0cO2HwbLBnherdZDNiT68
	8EN+C91E5nqzEbMzR4R4laKzWqvX3l0bv+7lYTK/sMX09H7ujqlBzVkt+PGgbcVCGINfI4JrOFq
	6r1FIb1FFo13WBWewXeQ/TWk+mRk0kYJP1U2qMSWDOJoAbsplPQiKf8aG4772m4lirTKxLeOyja
	y46tHt8xRLQZu3h9pIBbRqqWCnKH7SrpqIIiBYEQgcDoxN2DRNhKOpgur+nqQHNCZ2LbJqatw3V
	8BBfuQOIkKqEoY69380Ew9Di2ZQo09Rf6LOn75sIsguRINLLEnbv2nFpYdMfhgzFmySqak1ts4Q
	+hMlGW1B3Qs9J0spN5GQC1pMZBYG/AfRiaXJAr4rf/WUt
X-Received: by 2002:a05:600c:a086:b0:477:5582:dee3 with SMTP id 5b1f17b1804b1-4775582e17dmr21786685e9.23.1762259603579;
        Tue, 04 Nov 2025 04:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW7XZAfAI36z3n3gua+YP3lVHEkUX5rYhKEKRSMwAwl/px8xmvwUV2n/8i+Vg7lzMYGCOnZA==
X-Received: by 2002:a05:600c:a086:b0:477:5582:dee3 with SMTP id 5b1f17b1804b1-4775582e17dmr21786255e9.23.1762259603207;
        Tue, 04 Nov 2025 04:33:23 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558e695esm17324625e9.2.2025.11.04.04.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:33:22 -0800 (PST)
Message-ID: <3618948d-8372-4f8d-9a0e-97a059bbf6eb@redhat.com>
Date: Tue, 4 Nov 2025 13:33:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/15] quic: add timer management
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
 <cc874b85134ba00f8d1d334e93633fbfa04b5a9a.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cc874b85134ba00f8d1d334e93633fbfa04b5a9a.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> +void quic_timer_stop(struct sock *sk, u8 type)
> +{
> +	if (type == QUIC_TIMER_PACE) {
> +		if (hrtimer_try_to_cancel(quic_timer(sk, type)) == 1)
> +			sock_put(sk);
> +		return;
> +	}
> +	if (timer_delete(quic_timer(sk, type)))

timer_shutdown()

Other than that:

Acked-by: Paolo Abeni <pabeni@redhat.com>


