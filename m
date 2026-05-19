Return-Path: <netdev+bounces-289361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHAfBycyDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:49:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048157B9F3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F0AA306E509
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101414657C4;
	Tue, 19 May 2026 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsWvEJTx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO2yYzcL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF74657E5
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183726; cv=none; b=tigLu7DyFVw9tmoTJSiIqMbxcUGJhGMn+c0tztf04WZvaQrClHnMlAZ1ebzpXbXmuDUQliyblLUmpEUkFmFeQMZMhZohEfSvAASKHTeLMG2B1ZTeWIT6rPOsFZgvgWAHbpRM1wyy+ozlT63r+OqqBK05ZwjHF7BcoImPvP9391o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183726; c=relaxed/simple;
	bh=yt0H3bvBRFcuJ9DYVM0S3Grsofv+ydRaNi8hw/H/mjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK4vDJyf4RfhVkzOS8lqvh8OeOA2SubpXqB5ITf3b5IOCHZ8UXgTkxHC9eYmIKjlKPXZH5pAYdbqlcP9EfbOtWAHhz+5F3lprUQMhulGzkPwQvqRaw3JESZQiQaKKWGuTfoi0fvYabVCLms5y/vRBFwDHOqXT7uj3dmjNTVGCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsWvEJTx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO2yYzcL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
	b=DsWvEJTxEjMz9QABqBLgiYO4614/hfm+wUx+WhKi81zif/3hna5r3c9rOMgvF5Ww1MvSjB
	b+B3w+PcgGTlokrpLbc41nJOF7Z1bSVl7AgO2+LYf/eXr180GF/RAElB8Y9o1RBY17T3e6
	IpLAVa2rVLpJS6gD9Vz1kmX4pgrGRF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-0wGbRp44PIWLZkdHRad0rw-1; Tue, 19 May 2026 05:41:55 -0400
X-MC-Unique: 0wGbRp44PIWLZkdHRad0rw-1
X-Mimecast-MFC-AGG-ID: 0wGbRp44PIWLZkdHRad0rw_1779183714
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so2670680f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779183713; x=1779788513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
        b=MO2yYzcLm49L+93RMyfoZ7e3aSRE0Vt6y/zTmzYK3ivNwMrBbGczvi692nr+ZeTdoJ
         HihyHPxRIxa13cvSWsGidW2MvMvaef5gCYGkMcQNC46Si8moHcHAAWYkAFGKATDL24ue
         8LMNeHpPBIC9EjrD/anW7wBw+UKaIlBX4gEvX5wKOyIvyDPVvGVbxHIGY2C3vt9D9+jT
         XF1kSxWcvfHfNo3B87rxrwr+nC/ixJD7O9dozQnvlq9HhbrluTL6y0uAFdC6VQ8252ok
         LYtHeZBpDgjKyoecZIUNQdJiIvlNVp250dFO+hragUSVR1EGxYF/OSNQBLDe3g34LO1v
         /ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183713; x=1779788513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk6v1iOlM6Sc6be+bYwuVr8WIaK4VMHqbDmDqfyVw54=;
        b=M5d5x84ghS4PyT7Y3JozqGOiNeYbEohu9vK74cU/0Mi5sBpvm8QJ/7Icrgm4KFrWf3
         G85LWW3M6vL3Y/WD7l2Ft1IsqKSy0lYRwvABZzBUTfZybVV/64XojgH9sz3wN+QC9vZ3
         9idkaBUpFY9INi9PwQ+OKsfX4s+lB2d7kz6spHRuGZeh+SVZJkeajVDPNkoXjSXPFnKY
         sOZsC/lJ+c4GKTa/7suiAtVBIIGWXntGjwWM92v+TpqRCIx0LLBMzfnC/JziAy6AoMAL
         8OxilxYlj6woEOs5R5LMDGtnAZInf3wxRGXddB8PT1UKja1nNb9CHhWLIAA9e4u9058a
         zAqw==
X-Forwarded-Encrypted: i=1; AFNElJ93aP2iTnmqwGwRGiZ0Vt+Wjljojkx0vjuzwkMB6h7fcmyzW3/4toB7GTBaCu2AtY4Aypgabik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhp7X6YkSY+FJqNUJx81cgZALgizcKjTaDTn5QDDL0w1gTzZ2f
	kCqIJc2wtOYHpfNLx1u2AWjcYCL+7QrTepi/JRz8y1OGNQ6Z3oauNZto+zqyDAL90URijk4a1wH
	nxVq+0GCOKr+zZAv4gsrX8RfwSRJMyzSWdqo/z1cooSgt2edczddldSXd2WSzbJF1Aw==
X-Gm-Gg: Acq92OFM/5YlnB2i/4PJqMRDLlktp6ORVlBvvANLdGwjyR1i0AjFp5gEBQ0FMTVGa5U
	tV4njQVWAh8cp24m9izgkuwY+UjVMLaGg2Q7B4WW9auFC98/hhAJJv00LQ8M7DaeyVJ5Eo0IyMw
	Jq1xu/a6PX/M/9c/d5ZLZLw+Xnx62vn3r7euc+C/uUwiRNX2/wGoFe4EAn1sURuBybKB7RGaED2
	btHcU8rTmms+Dyge8YFvtEbIpxXzfheXHUAJYWZzM6ByeTPLv3YuunagRiuFa/BOD0xfCvudIhb
	wvW9Sd5T0X9XEUnHGV23GXE8GJodEyGOzmspF7IcAmTDZjNvCiWmptaF3qwSPsjSkoClaVnWBeH
	OSQk4sl1zaSO7i5RCS6Q73iVKSzU1+0lyHYfza5b0PgmC+Fz2GYvbmk174h+AnOnX178KMEkGNA
	==
X-Received: by 2002:a05:6000:25c1:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-45e5c5af3c9mr35164488f8f.13.1779183713288;
        Tue, 19 May 2026 02:41:53 -0700 (PDT)
X-Received: by 2002:a05:6000:25c1:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-45e5c5af3c9mr35164400f8f.13.1779183712778;
        Tue, 19 May 2026 02:41:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm43263408f8f.16.2026.05.19.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:41:52 -0700 (PDT)
Date: Tue, 19 May 2026 11:41:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, 
	Minh Nguyen <minhnguyen.080505@gmail.com>, Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Minh Nguyen <minhnguyen.080505@gmail.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
Message-ID: <agwv3YkxYIC7mvyj@sgarzare-redhat>
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
 <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-289361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,broadcom.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8048157B9F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 03:26:28PM +0200, Paolo Abeni wrote:
>On 5/12/26 4:58 AM, Minh Nguyen wrote:
>> vmci_transport_recv_connecting_server() jumps to its destroy: label
>> and performs an unconditional sock_put(pending) to release the
>> explicit sock_hold() taken by vmci_transport_recv_listen() before
>> schedule_delayed_work().  The existing comment claimed this was safe
>> because the listen handler removes pending from the pending list on
>> the way out, which would prevent vsock_pending_work() from dropping
>> the same reference later.
>

[...]

>Sashiko says:
>
>---
>Could this change lead to a socket memory leak if another packet arrives
>before vsock_pending_work() executes?
>If a peer RST is received (err == 0), the socket stays on the
>pending_links list with its state set to TCP_CLOSE, and the base
>reference is kept.
>If the peer then sends another packet (such as another RST) within the
>delay window before vsock_pending_work() runs,
>vmci_transport_get_pending() might find this same socket.
>Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
>default switch case, set err = -EINVAL, and call vsock_remove_pending().
>This removes the socket from the list and drops the list reference, but
>it bypasses vmci_transport_recv_connecting_server(), meaning the base
>reference is never dropped.
>When vsock_pending_work() runs later, vsock_is_pending() evaluates to false.
>This sets cleanup = false and bypasses the sock_put(sk) call, leaking
>the pending socket.
>While not introduced by this patch, does this error path leak
>sk_ack_backlog slots on failed handshakes?
>If a handshake fails due to an error, vmci_transport_recv_listen()
>handles it by calling vsock_remove_pending(). This removes the socket
>from the pending_links list but does not call sk_acceptq_removed(sk).
>When vsock_pending_work() runs later, vsock_is_pending() evaluates to
>false because the socket is no longer in the list. This causes the work
>function to skip its own sk_acceptq_removed(listener) call, meaning the
>listener's sk_ack_backlog is never decremented.
>---
>
>it looks like the above is trading an UaF for a leak ?!?
>

@Minh @Bryan can you check this report?
It seems a real issue, so the patch was not applied.

Thanks,
Stefano


