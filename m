Return-Path: <netdev+bounces-248113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37FCD03966
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A5CD304C677
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E572874F5;
	Thu,  8 Jan 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZmiTmoI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIEfseNO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369A24DCE3
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883902; cv=none; b=mb1n5TAQc48l0kYb4GPdVtBneiPzmOY/GxdkL6UOcUKJ/x5Qp5CszdI2F9aIxfaeA8/vOHrnysQRjqaaznmQCbRBtBlRSB5OYx1EJ6BqbdJNdyPBj0E6ZR9x654VlFpCIwglyvWMAYpTej7Bavr1yDlS2N9xW7NIer5V7dRSSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883902; c=relaxed/simple;
	bh=DXhgONYeIS9bChdWRL5MXzxkLSKekfV9hllD3azG3T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnTzTPhGUDgBKhA1XSBeHl+E+5uFM5AH9+2lzdGqalVbQbzgMSUpbKAWy0/ybCh8AfwUeSsLBDG2qoZwWMLNQvs3zYU3e+4tdKMVEYFL+BLDBIYTjP8+fuat6Z/+qCS+QioWu/Z5nywRLzD3zstdr/wvyJi2FPWfLYwNagodcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZmiTmoI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIEfseNO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767883900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOEaS67jxDLLnbL0hp6gXDx5hl4Xnwdn7lV77ig2jkU=;
	b=WZmiTmoIUofRl8sr8F9/HwP7/5eQAnMWfSJHHewdgtexOO0cFD0DlxLi297bdfe3L0msCC
	xz62p5OLndM0MEcOhj5xzq9y7Zcr6dvTNZKhRWLzXSAl4hbWGNnmFN6x/K4rLxBgJwrc2z
	BhjUsSgEOdWrX/6biakx/mYH/QMLPjc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-PmXPog5dNB-d2glznz1VnA-1; Thu, 08 Jan 2026 09:51:38 -0500
X-MC-Unique: PmXPog5dNB-d2glznz1VnA-1
X-Mimecast-MFC-AGG-ID: PmXPog5dNB-d2glznz1VnA_1767883898
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcf10280so2206523f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767883898; x=1768488698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOEaS67jxDLLnbL0hp6gXDx5hl4Xnwdn7lV77ig2jkU=;
        b=dIEfseNO62Kx1NSJgTPJ5FMkwWJ+jPWFVMC6bs+UknVBoRSnA17z8fU4y4y1fC12wQ
         ArkAbyOXw/dcyOCZq0VctKF0+UNDPc5MG2R3z1geE/X11mc7a7oryN1NfbiUotxWDCe9
         EvPUYEUeQIRajp6TOyPs79VcEdjZ0ZEqEeb1PhZk421Q9aVBiNw0SUMb6qJS31iYYsJG
         6I0GxHEokhUOZvIq9SIty4dMWWnF5No/bF3UPdRSja8mRQqPJE0bO2bX1wrgj8G6OqkW
         vc5QuI9a6BWvY/ZrSPvzI30z44PXFT6b3Te/ycbPU5HBOJDxOK1dVnmBwr6gwLhl+/A6
         2Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883898; x=1768488698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOEaS67jxDLLnbL0hp6gXDx5hl4Xnwdn7lV77ig2jkU=;
        b=FYjttFrdIzw44dgmDWJUeDzL4VOt6GJt3OYcNFfrvLFshDsqfQbzXxuIZOC6qoDm0J
         8Lty/S/TbtZWuZqP+tlnPGwZZi5+14CyzKcwWVQ5dkhunJOLwzHOJWwDgcYj8Ffc9FJ+
         8k0QYnkYDbZnf729RNuxa2EDupJBKH9imxVeDrb+VRNytdlnQyF1QzaYGwz7yEYDgF2U
         uAY2/dn3T3bzMH4wbpSiHGUke8lJ0H7gx4JVmRfDVfwJ5inw1wwS7md/iZ/v5H+A5/dv
         +Mhg5FNdhjWSYLoiwEQyBSIWV3tun8XpyxuqJPF3Vn4HQhx0+2+I59sBKc+Q1pmGKs4f
         xjdw==
X-Forwarded-Encrypted: i=1; AJvYcCVmcu6cDXB+hJtVr7kVTl7GNTLbTneNWuJHC43sVz4iR2sYUwRG+VanOSGjp4nBmz5AunsNMVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jMABs/w2DXMjrlIJ6E8jgj85aQ3/dAQlSCTj+M+z8w+nzsWc
	9t0DDUx+je1s45jx+ZN7o1WvpCmF5CXmsWyDLGfHy7TL20gCTcvmh/w7AULkRxuZJ+uv5M8FTEn
	nyR0P0aJ7nrEfnyLIh8NhTEdNcWeKTdQ1F263WLuOv8d6DllhhYyGvpmbRA==
X-Gm-Gg: AY/fxX4kq1EFGwYblLPHV8AkWc2IAHfdrGnxhRByZ6xpfR0Xg0+rVF7zAEltc94iRQZ
	x5OSwT2WzoG+4x069S8mHsgOSVwkkQatCpRDqgL4OHThcqQK2pQZPEkpW/AyImU7ZWIj6KnL0b8
	sVjCZc3CgimWwWOvyWigSXUMG5RJ/Ur5oVca4XFaZSgfmheHFw58CEMffQXsgIdFS8M9xzwhZjo
	YDnae1mCa/garOGcRB5fq6oIxJPPXb7U9XnvQ05w2YkqPmErNHoUlv+OslzXfSxgqCUQSTUyity
	do2ewhQspst3fWAvsqAzf2tsuZJIskagfmCwb5US6qc67yClYuWl+of9xJGtmjTx3vFqLTkirbH
	p7Wnh75dzfQwsTw==
X-Received: by 2002:a05:6000:250e:b0:430:fd69:9926 with SMTP id ffacd0b85a97d-432c377ece0mr7284121f8f.28.1767883897588;
        Thu, 08 Jan 2026 06:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl69o07nid1rtv2ElvvEp5emJMaGD57S1+3wGIJzICQrcTyqY6I1e4bFP5EYxEC7EOfbCGWA==
X-Received: by 2002:a05:6000:250e:b0:430:fd69:9926 with SMTP id ffacd0b85a97d-432c377ece0mr7284095f8f.28.1767883897151;
        Thu, 08 Jan 2026 06:51:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm17585141f8f.41.2026.01.08.06.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 06:51:36 -0800 (PST)
Message-ID: <32c5dc26-d200-4c45-bcd5-3739699e39eb@redhat.com>
Date: Thu, 8 Jan 2026 15:51:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/16] quic: provide family ops for address
 and protocol
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
References: <cover.1767621882.git.lucien.xin@gmail.com>
 <d6526f74c99731fa08bdd43f97330f9c2dd78e43.1767621882.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d6526f74c99731fa08bdd43f97330f9c2dd78e43.1767621882.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 3:04 PM, Xin Long wrote:
> Introduce QUIC address and protocol family operations to handle IPv4/IPv6
> specifics consistently, similar to SCTP. The new quic_family.{c,h} provide
> helpers for routing, skb transmit handling, address parsing and comparison
> and UDP socket config initializing etc.
> 
> This consolidates protocol-family logic and enables cleaner dual-stack
> support in the QUIC socket implementation.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


