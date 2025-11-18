Return-Path: <netdev+bounces-239474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14161C68A62
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60E113482DB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107FC324B07;
	Tue, 18 Nov 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/chfVov";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4/m8Khf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677331984C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459493; cv=none; b=HgC2+5G+rAH8vWWM2uHgN0GNrfuZcvoDGKRG5cQfB/tx6mpTw8Hw0V3kZ7Ldiq7kn/PwcoK/OTGqkw6wA55Y9IupBDa3bvKbWqVQoDacyuNgaWCml25ZJa1hp4m0zaXcyaIW66w3XuAFk1plTBXWeXNFEMP7jK1XeWp+gaqhvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459493; c=relaxed/simple;
	bh=vCEQwxutYMtvzkfn4aDJG38kRsbNkfFL4sVGu5IhVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyky4tZ0OYS6XoIhUGRyKv8bPnAoCJcyBQjylwIx6aWifs/uNvKYwXsjV8TRDov5YRr/6V9v84pGEDb4F9w8ZH2Mt6wphSPMg+W3X/MbKk7+b0ofWpEI0EvFGipkeBrigUgIfW30cLu3umJ9ooxwYA7/KJ3XSwNA/q5RMibiJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/chfVov; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4/m8Khf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763459489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsM7rn4162L4RtQdGi/Pr9MgOF3AH3PyQCj0ogQCAI4=;
	b=U/chfVovB6amUGGcPUtbqG8orG1/0eZgIUSoywIwXg5pKJkf/R+qyB+qraQM09so8XsksU
	+ieIGwaLp3TDlHUOkkHUJEHLX7VHL+DtcvzfBSeGTvu0fvKJeDyo9PpcLBQaB7uUdmpnTW
	B3RHelEGqhkmSWIcMBEP6HdsgI7n1kE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-CY9DWjUiOT2QHi9hqnY0Gw-1; Tue, 18 Nov 2025 04:51:27 -0500
X-MC-Unique: CY9DWjUiOT2QHi9hqnY0Gw-1
X-Mimecast-MFC-AGG-ID: CY9DWjUiOT2QHi9hqnY0Gw_1763459486
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-641632b8825so6459340a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763459486; x=1764064286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsM7rn4162L4RtQdGi/Pr9MgOF3AH3PyQCj0ogQCAI4=;
        b=h4/m8Khf0gjEb0ouPrKrKMkqIwn2Mr2bODTANflwcIM5mokGdP8Iiwzc8wu0mjO4Nr
         8cLq8QTlqrhYKJLIH0+g2IGBYMdqdvw/Z8Jm9qX/M2IGq6H3Bpscolycvd20SrgGpmD+
         8wiCrJb7pzOJaJnSCL0KrwL9vLLcYkZjd1EF3QigHqs4lfNDZCTEm7lGB8S2qU29lHAY
         RGRPGk1la1oAtvBWC8HKUIHRFKyE3pROkogIZOPf+S4Zkt0fDsjGJdplp8uwPQJmMvhu
         W7G9/2HJW3RzugwwXgKwWsDwXgej+A/cJ7nDUhkgo2xNa10Ko0CrpGMljjjZb9ywIQH/
         BB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763459486; x=1764064286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsM7rn4162L4RtQdGi/Pr9MgOF3AH3PyQCj0ogQCAI4=;
        b=DCx4Ha1j4Z5yE2dXw9pnmux3Xl/tmQCDX2wlQLhNGa0DZRPKHWKy/Fmsz0Qe+mOEH8
         2oPbg4HQrOjt6tby/AwFTYyXERMugLXryGL3gxK4AK6D/CAYki337SIhn2uP1owAdyje
         0+N+tZZmPESkA0jOS1Zv7mcVSC3aD1TTqsCIY5FSS6/QV4jCMZ7dsZsusbxkSxCsCtLg
         9VsHCg3MOoPhuMv2gmIfdaop592iCdYrSXiI8S1SRp49z+E/AONSJfyHOiVXBJ6XQHp0
         v4J6mEMB/AgrK//kGZLWm86WZmlDAduTQ6kQwurYI06rD15NQRWefSoh50CHfOf9Q6q2
         dRXg==
X-Forwarded-Encrypted: i=1; AJvYcCWmtGgmdWyCXEPaf3wN1Kzeh7pD8cLJDDUYrPw80Qooc6fXGu36Ea3G4Ll57xF3+DuwgN32Cqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBsEJ7090RqnaszDghd+yzcaOOrbYFxJ+Bs4IjXiOFEP84VMq
	uVT6D4CSO5x93ZFKUbuvct4yCYHguscbKZWm3XdDJNmJW+3AttgaBrVGkcZ2Dyt5BdNsV4i3Cbz
	xP+o1HO+h/MEs8mosvJxp1IMqpiYuhbQVG9anRThi+Ks/tFLDIB7FhxG7HQ==
X-Gm-Gg: ASbGncvAi9WYeaniSAflyWwfq1acegbVpo4CbTBjJREw/zeOxN01f3EStvLC3+lXi2y
	sKd+K06qf+NVczALAhxQsT1aYn+ASpc1NDMx83gKgOwRg4s8xHTnikDrO53w+esESSYmS3vNcMT
	4XGpa7b3CFChedd7LLdjR1fG9tMVp1dr3YQ9a6ZMj9xrYRIP7SLN4TTPYWacEzBZ1JyCO7+jZ5N
	eqkH722iianhJHROB5BTpu5OWC3pyZrCOpAI7UqD7z5Ps+vTZSLcscrodiXs+uaDaTfpEtMRq+I
	N4zuE2q3KXdzFSzWvXGFT2Rndjr//IqZCeW6eWo2Cnu0grbrf7bfQc9h3/0sqs7T2wCoHLtday0
	gc/XXESOE6DVA85e/DXBb1E3mGGogOAv+I0aABcSNK36/2/6O
X-Received: by 2002:a05:6402:50d3:b0:63c:334c:fbc7 with SMTP id 4fb4d7f45d1cf-64350e8a2camr15790741a12.19.1763459485777;
        Tue, 18 Nov 2025 01:51:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGBtJLv1qV30eWxs9yIBS6qQkoQ9Ttvf4h0pcNbfbjcxMK1pThVxKi8AHK6HbL+sLLiYnMhQ==
X-Received: by 2002:a05:6402:50d3:b0:63c:334c:fbc7 with SMTP id 4fb4d7f45d1cf-64350e8a2camr15790720a12.19.1763459485342;
        Tue, 18 Nov 2025 01:51:25 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497ffdsm12370564a12.21.2025.11.18.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:51:24 -0800 (PST)
Date: Tue, 18 Nov 2025 10:51:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>

On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>During connect(), acting on a signal/timeout by disconnecting an already
>established socket leads to several issues:
>
>1. connect() invoking vsock_transport_cancel_pkt() ->
>   virtio_transport_purge_skbs() may race with sendmsg() invoking
>   virtio_transport_get_credit(). This results in a permanently elevated
>   `vvs->bytes_unsent`. Which, in turn, confuses the SOCK_LINGER handling.
>
>2. connect() resetting a connected socket's state may race with socket
>   being placed in a sockmap. A disconnected socket remaining in a sockmap
>   breaks sockmap's assumptions. And gives rise to WARNs.
>
>3. connect() transitioning SS_CONNECTED -> SS_UNCONNECTED allows for a
>   transport change/drop after TCP_ESTABLISHED. Which poses a problem for
>   any simultaneous sendmsg() or connect() and may result in a
>   use-after-free/null-ptr-deref.
>
>Do not disconnect socket on signal/timeout. Keep the logic for unconnected
>sockets: they don't linger, can't be placed in a sockmap, are rejected by
>sendmsg().
>
>[1]: https://lore.kernel.org/netdev/e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co/
>[2]: https://lore.kernel.org/netdev/20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co/
>[3]: https://lore.kernel.org/netdev/60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co/
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Note that this patch does not tackle related problems described in
>https://lore.kernel.org/netdev/70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co/

Ooops, it seems I forgot to reply. Thanks for bringing this to my 
attention agan. Next time feel free to ping me :-)

I'll reply in that thread.

>---
> net/vmw_vsock/af_vsock.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 40 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 76763247a377..a52e7dbe7878 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1528,6 +1528,23 @@ static void vsock_connect_timeout(struct work_struct *work)
> 	sock_put(sk);
> }
>
>+static void vsock_reset_interrupted(struct sock *sk)
>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>+	 * transport->connect().
>+	 */
>+	vsock_transport_cancel_pkt(vsk);
>+
>+	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>+	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>+	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>+	 */
>+	sk->sk_state = TCP_CLOSE;
>+	sk->sk_socket->state = SS_UNCONNECTED;
>+}
>+
> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			 int addr_len, int flags)
> {
>@@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
>+		/* Connection established. Whatever happens to socket once we
>+		 * release it, that's not connect()'s concern. No need to go
>+		 * into signal and timeout handling. Call it a day.
>+		 *
>+		 * Note that allowing to "reset" an already established socket
>+		 * here is racy and insecure.
>+		 */
>+		if (sk->sk_state == TCP_ESTABLISHED)
>+			break;
>+
>+		/* If connection was _not_ established and a signal/timeout came
>+		 * to be, we want the socket's state reset. User space may want
>+		 * to retry.
>+		 *
>+		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>+		 * vsock_connected_table. We keep the binding and the transport
>+		 * assigned.
>+		 */
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
>-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>-			sock->state = SS_UNCONNECTED;
>-			vsock_transport_cancel_pkt(vsk);
>-			vsock_remove_connected(vsk);
>+			vsock_reset_interrupted(sk);
> 			goto out_wait;
>-		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>+		}
>+
>+		if (timeout == 0) {
> 			err = -ETIMEDOUT;
>-			sk->sk_state = TCP_CLOSE;
>-			sock->state = SS_UNCONNECTED;
>-			vsock_transport_cancel_pkt(vsk);
>+			vsock_reset_interrupted(sk);
> 			goto out_wait;

I'm fine with the change, but now both code blocks are the same, so
can we unify them?
I mean something like this:
		if (signal_pending(current) || timeout == 0 {
			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
			...
		}

Maybe at that point we can also remove the vsock_reset_interrupted()
function and put the code right there.

BTW I don't have a strong opinion, what do you prefer?

Thanks,
Stefano


