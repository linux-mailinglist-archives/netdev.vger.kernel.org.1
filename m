Return-Path: <netdev+bounces-152546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60E9F48CE
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56099188CF15
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA81E1041;
	Tue, 17 Dec 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqOK9trF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6801E3DDB
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431101; cv=none; b=CniIy0oNa4an3BdjyD73U0Ckce3eWoMtV8PRGu/fYZj2wPH9mzkfnAtkYDl4I/yYM9IjL5H9FuO+xmWi9AwlEcrt03hB+zOf9uU7o/EnLt2t65KLSN1KIyg2eBg19ubLP4ICXCPyypgcOCkcHXzhstvAjfifdfuvgvlByVrUKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431101; c=relaxed/simple;
	bh=r4bqgRrAO62oBEftz2934XINuvuI99KUO8FcvLao1mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKjSy3uwwmPR7TaMC0LG50UlEtZGZMruCZ8nlBDd4O5MJP2qyhqbuxNB+G/ilxJKgf6ZWZD/x+arIbsbVK+n4x99QhpgzHEmR1R4tLZLtfpPCF1CVT3BWxypKZxpjIAjIPSEqyRAfSS+7jkOiJe2c6b2yKyINRnZH1e80vVRVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqOK9trF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734431098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Z+IZi3pjHgbY13npeMLLfKejV2tx/7wE/4Rf/Cb2Dg=;
	b=VqOK9trFOmm6GpTBX/b0wzUckjAIVqSg12qUXLPtiKCUTrfNAv7WkILC2Frq1Bs28OSreP
	3h2xRmF15Y3r2lRZvN4bj4/5w1d05KbcloVX6Cf6njAcEaZFI1+sP+zql9yIJ3P32JK4Zo
	cP0JpQAh0E5QveKOombeRtvbtCYBv98=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Pi_WqT82NaO-hmbj0-BmUw-1; Tue, 17 Dec 2024 05:24:57 -0500
X-MC-Unique: Pi_WqT82NaO-hmbj0-BmUw-1
X-Mimecast-MFC-AGG-ID: Pi_WqT82NaO-hmbj0-BmUw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so46459205e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431096; x=1735035896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z+IZi3pjHgbY13npeMLLfKejV2tx/7wE/4Rf/Cb2Dg=;
        b=TC56zraY4S/y2ube0CKI32l27Lf1ANak3W8Nc17ABKDqrfzc8J3sTZhVvtobChm0i+
         JGnkmYzTHzegGIndqPqWqXl8W1yCJFriWkN2Ed40EFgpACAFfDkQuH4ewTEp6K9wDB6v
         hHh62fRriFu0Qtl/4jPUhfWld6GP/ThpvL4vOYxC/4ock7nZrUYSbK0Kk6Y1AnUHT+Bb
         5cF14J+ZqeAnVcsr8R0I76WuRk+QLvXZU0tiZWxd1cUykN2Na/pEHJ+vana+rVCY61oD
         CJ+R2QD6LWTkVss6GsX079yZwVOqMKPy6ci+03a8XzLqUMSNsbZkzuKQjOZ/wUg5oqCE
         FsIg==
X-Forwarded-Encrypted: i=1; AJvYcCWE6T0bfYX+dx0rCkiERcSOq8ZKHrN7UVfZKBxpd0K3cHcxXHQAn2OigOyhFpLh0RVH+0oZJ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZOb9AMrqr+2Fa8Uoupc1fz9RtsOBHPZZhC00oW353LCuAezU
	5CIuLw8h2j5TCKJS6jQp717IiBNkF2UvYo7qhPqdjwLOSXXV+i13UFH9yEY4G9FA7ufK9GOK3W0
	gR4RymaiP3NnRUkiboW/De6Ikv5+Mo2m5tJPaEK+/ei32fUx94npMLw==
X-Gm-Gg: ASbGncsS/R/auAaGkmqASsQ7hQnWCMh+LFc1BFXuWg27nCoEDUmrdYnsoK/3ruVZpgu
	r9R9rqyZLgXOlxwZ4PSdSfHTKlAk6XQnuxOoB4K0k+ba4XjT0BBA+2el3OT0suETv2Mf75JqAVl
	ilxLZYQ8Ytde5D2eU2KyDmvtFWX2gmUDv2ENWhLZ6LaX7wf8eNXQzxfs7wa8c6DjUesQcmBOdqt
	dPGTJt7ypTjEXRLTxMtEDLAYJgr/6WWGkk+gsSAmoHX8otbI73t0bJsHzRxMdNLoWKAIs+TjlsZ
	HVZtnuuC2Q==
X-Received: by 2002:a05:600c:4e55:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-4362aa367f3mr146358345e9.11.1734431095985;
        Tue, 17 Dec 2024 02:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv/LUFT7YQH55N/y6qh46LfzJ40wQp1TiBcYBV31spV9HzX8XPEAVc/+UALE97jyBhVNbqog==
X-Received: by 2002:a05:600c:4e55:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-4362aa367f3mr146358095e9.11.1734431095553;
        Tue, 17 Dec 2024 02:24:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm112500915e9.6.2024.12.17.02.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:24:55 -0800 (PST)
Message-ID: <5db21508-711e-4534-ac71-f6f6c8d12d56@redhat.com>
Date: Tue, 17 Dec 2024 11:24:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 04/15] socket: Pass hold_net to struct
 net_proto_family.create().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241213092152.14057-1-kuniyu@amazon.com>
 <20241213092152.14057-5-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241213092152.14057-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:21, Kuniyuki Iwashima wrote:
> We will introduce a new API to create a kernel socket with netns refcnt
> held.  Then, sk_alloc() needs the hold_net flag passed to __sock_create().
> 
> Let's pass it down to net_proto_family.create() and functions that call
> sk_alloc().
> 
> While at it, we convert the kern flag to boolean.
> 
> Note that we still need to pass hold_net to struct pppox_proto.create()
> and struct nfc_protocol.create() before passing hold_net to sk_alloc().
> 
> Also, we use !kern as hold_net in the accept() paths.  We will add the
> hold_net flag to struct proto_accept_arg later.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  crypto/af_alg.c                   |  2 +-
>  drivers/isdn/mISDN/socket.c       | 13 ++++++++-----
>  drivers/net/ppp/pppox.c           |  2 +-
>  include/linux/net.h               |  2 +-
>  include/net/bluetooth/bluetooth.h |  3 ++-
>  include/net/llc_conn.h            |  2 +-
>  net/appletalk/ddp.c               |  2 +-
>  net/atm/common.c                  |  3 ++-
>  net/atm/common.h                  |  3 ++-
>  net/atm/pvc.c                     |  4 ++--
>  net/atm/svc.c                     |  8 ++++----
>  net/ax25/af_ax25.c                |  2 +-
>  net/bluetooth/af_bluetooth.c      |  7 ++++---
>  net/bluetooth/bnep/sock.c         |  5 +++--
>  net/bluetooth/cmtp/sock.c         |  2 +-
>  net/bluetooth/hci_sock.c          |  4 ++--
>  net/bluetooth/hidp/sock.c         |  5 +++--
>  net/bluetooth/iso.c               | 11 ++++++-----
>  net/bluetooth/l2cap_sock.c        | 14 ++++++++------
>  net/bluetooth/rfcomm/sock.c       | 12 +++++++-----
>  net/bluetooth/sco.c               | 11 ++++++-----
>  net/caif/caif_socket.c            |  2 +-
>  net/can/af_can.c                  |  2 +-
>  net/ieee802154/socket.c           |  2 +-
>  net/ipv4/af_inet.c                |  2 +-
>  net/ipv6/af_inet6.c               |  2 +-
>  net/iucv/af_iucv.c                | 11 ++++++-----
>  net/kcm/kcmsock.c                 |  2 +-
>  net/key/af_key.c                  |  2 +-
>  net/llc/af_llc.c                  |  6 ++++--
>  net/llc/llc_conn.c                |  9 ++++++---
>  net/mctp/af_mctp.c                |  2 +-
>  net/netlink/af_netlink.c          |  8 ++++----
>  net/netrom/af_netrom.c            |  2 +-
>  net/nfc/af_nfc.c                  |  2 +-
>  net/packet/af_packet.c            |  2 +-
>  net/phonet/af_phonet.c            |  2 +-
>  net/qrtr/af_qrtr.c                |  2 +-
>  net/rds/af_rds.c                  |  2 +-
>  net/rose/af_rose.c                |  2 +-
>  net/rxrpc/af_rxrpc.c              |  2 +-
>  net/smc/af_smc.c                  | 15 ++++++++-------
>  net/socket.c                      |  2 +-
>  net/tipc/socket.c                 |  6 ++++--
>  net/unix/af_unix.c                |  9 +++++----
>  net/vmw_vsock/af_vsock.c          |  8 ++++----
>  net/x25/af_x25.c                  | 13 ++++++++-----
>  net/xdp/xsk.c                     |  2 +-
>  48 files changed, 133 insertions(+), 105 deletions(-)

The diffstat here and in patch 8/15 is IMHO scareful.

I'm wondering if we could make this more palatable? Can we let
_sock_create() directly acquire the netns reference for kern socket -
when asked? something alike:
---
diff --git a/net/socket.c b/net/socket.c
index 16402b8be5a7..23092f7576cf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1577,6 +1577,13 @@ int __sock_create(struct net *net, int family,
int type, int protocol,
 		goto out_module_put;
 	}

+	DEBUG_NET_WARN_ON_ONCE(!kern && !hold_net);
+	if (hold_net && kern) {
+		sk->sk_net_refcnt = true;
+		get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
+		sock_inuse_add(net, 1);
+	}
+
 	/*
 	 * Now to bump the refcnt of the [loadable] module that owns this
 	 * socket at sock_release time we decrement its refcnt.
---

(completely untested, just to explain my thoughts). The goal would be to
drop patch 4 & 8 entirely.

Thanks,

Paolo


