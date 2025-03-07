Return-Path: <netdev+bounces-172958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D381EA56A6F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E9918999D8
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7C121B8E1;
	Fri,  7 Mar 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8BmaH9t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE721B8F5
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358011; cv=none; b=dhin98oKcmnw33GwuuV0NZDzb1wNO9ZF1syKVlE+uvJvjhjHou5WSgsAssUBbu+wZ/uxTi8IHPq1vWekhDQ0Prz2fbMNG052PYlWNGOG9Umqr4bE3n7ufIekO1+5+nCCRLGxMPV0DLkrstletpJPdJStknfpuCnp/kkf/6X0U6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358011; c=relaxed/simple;
	bh=v/AgWLHrrQ2VYPYzBhWzxFlMDI2s+LOACTA+EHHN6ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXbyb4Jm90hIUW0w7VzlgpjNbgLHUt3j90Cup/WTNfXy0S1Crri1dNvbRr7SJ3JhW9ztKepAmo2MjZiv1lsJ7YmBG/sBwnHW2sM1oWUMWoci4Z4XGuNE+H2ie3CzZtYiCgu/U9pu8ClP2BZyZHamh9K9SL9dzhsF9RjnS1/ZZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8BmaH9t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741358008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfVgJzThl6qU0ktwEkW6YL2TZPOkm5c2XUTKql/oniw=;
	b=B8BmaH9tpq93lXcSQdhLzrI/bjo620t9lLOFq6mBjOqti5IWZnMcCQRmIr1S/XdqKBABQA
	8Or8A88VYQ2iaP22w2v7E2ZeejbKCEUHwdF+65JFb4x7QA/Kp8fWjU/OBdfmanWfy6oC7p
	DO3ypyjXEIcXDh2DSCJ7/vlleF4fno4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-_qSmR-TbP8WOoM7qtFh43Q-1; Fri, 07 Mar 2025 09:33:25 -0500
X-MC-Unique: _qSmR-TbP8WOoM7qtFh43Q-1
X-Mimecast-MFC-AGG-ID: _qSmR-TbP8WOoM7qtFh43Q_1741358004
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf4c4294b0so254365466b.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 06:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358004; x=1741962804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfVgJzThl6qU0ktwEkW6YL2TZPOkm5c2XUTKql/oniw=;
        b=YckNeBqzHds+eU9BMNHqb6diTLOe+Bs9x8ShOO9tW64xKguB82P4CEIhkPu7tAMhAf
         PABHrhot6WVIbspK4DPOeARc0s+K6yvIvwfrexBXibiPy2TreLHkX7Y/TFLIJ5NepbO4
         gOawIB5m4M/07A+n0sNWPiDEdQjldyJbwcIkSXyKBjgPil91jtN+SJf8QPSyTlVUcn6Y
         /PVcBnSeYJkn/VCdOw1j9HbvupkeB0TMH8fHJUffmWuR/nvdjJk23sS4OoOdjQ64gPdI
         7bLSpAFf13BC+SG1fhlPWpx/l5d3p1ewkQOVz0TxzZnq65YLifTyb8URw+djE71vHbHx
         bhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKy7jYsVEOfrgt104e3xB+BUxg3eZohO07HR89usdUlsah+u9Nu6LZjox9QhRYZEH0LzmYhjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXueV/Y120TiaPV6PF7VvU9z1tbLYm16V8ECwOUVqlFnydbzo
	Bt/o4WQAbeMENj8GOBF6ViwBamAKFN1TnEEw0FalKmApCI8e6NgwKwlvMOfsSF9iQNrHp7LQHha
	tsOG0H8A+UiFiJh4e0o/Jzr4jTKC6H90ZG6R0qmmf0ohsGSvPpQAXgA==
X-Gm-Gg: ASbGnctEHdJXdAuv9Qcp7aPbh1GAy3Fo1FQ5muAgxfKKWixHiBiL3r+pg4DnkZL2WEn
	5u6MVdh79keUF6Zn+0hmjig2m1v7RK9e0ePJfUguS3JvuWjbU7rr5k29/Tq4d/zKQAFmEpVcKgF
	ZZZ/ChkckiiWHHl+MwMyyWcTghayDxw9zLc6vzizBOgNk3SCoQk+aMy/z9b/VBIWuX311LQkHfa
	aRIoaFrT3pv9sg5RTz1LNNayxUTI3cv5gGVQDXSD5IqjEPhHdUAfU+1ShrlYsbO+dPWZjiaVJBH
	RcUVFN8a+xv44v2bnBWkhg+sVeuEETM6I3aIKc9VvVtK0eFSakga+xixSoj1sICs
X-Received: by 2002:a17:907:2cc2:b0:abf:427f:7216 with SMTP id a640c23a62f3a-ac22ca6bc71mr833960266b.1.1741358003933;
        Fri, 07 Mar 2025 06:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiQh441xM59qwFfF090OJlmAEuZlCdwlXxiHvCJYadWEnvU/ClOU1kiRzHG6fq22dRMTrpPw==
X-Received: by 2002:a17:907:2cc2:b0:abf:427f:7216 with SMTP id a640c23a62f3a-ac22ca6bc71mr833955566b.1.1741358003319;
        Fri, 07 Mar 2025 06:33:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239736389sm284326566b.103.2025.03.07.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:33:22 -0800 (PST)
Date: Fri, 7 Mar 2025 15:33:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <wt72yg4zs5zqubpyrgccibuo5zpfwjlm5t2bnmfd4j3z2k5lio@3qqnuqs7loet>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>

On Fri, Mar 07, 2025 at 10:27:50AM +0100, Michal Luczaj wrote:
>Signal delivered during connect() may result in a disconnect of an already
>TCP_ESTABLISHED socket. Problem is that such established socket might have
>been placed in a sockmap before the connection was closed. We end up with a
>SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>contract. As manifested by WARN_ON_ONCE.
>
>Ensure the socket does not stay in sockmap.
>
>WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
> sock_recvmsg+0x1b2/0x220
> __sys_recvfrom+0x190/0x270
> __x64_sys_recvfrom+0xdc/0x1b0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c  | 10 +++++++++-
> net/vmw_vsock/vsock_bpf.c |  1 +
> 2 files changed, 10 insertions(+), 1 deletion(-)

I can't see this patch on the virtualization ML, are you using 
get_maintainer.pl?

$ ./scripts/get_maintainer.pl -f net/vmw_vsock/af_vsock.c
Stefano Garzarella <sgarzare@redhat.com> (maintainer:VM SOCKETS (AF_VSOCK))
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
netdev@vger.kernel.org (open list:VM SOCKETS (AF_VSOCK))
linux-kernel@vger.kernel.org (open list)

BTW the patch LGTM, thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 7742a9ae0131310bba197830a241541b2cde6123..e5a6d1d413634f414370595c02bcd77664780d8e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1581,7 +1581,15 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>
> 		if (signal_pending(current)) {
> 			err = sock_intr_errno(timeout);
>-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>+			if (sk->sk_state == TCP_ESTABLISHED) {
>+				/* Might have raced with a sockmap update. */
>+				if (sk->sk_prot->unhash)
>+					sk->sk_prot->unhash(sk);
>+
>+				sk->sk_state = TCP_CLOSING;
>+			} else {
>+				sk->sk_state = TCP_CLOSE;
>+			}
> 			sock->state = SS_UNCONNECTED;
> 			vsock_transport_cancel_pkt(vsk);
> 			vsock_remove_connected(vsk);
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 07b96d56f3a577af71021b1b8132743554996c4f..c68fdaf09046b68254dac3ea70ffbe73dfa45cef 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -127,6 +127,7 @@ static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *bas
> {
> 	*prot        = *base;
> 	prot->close  = sock_map_close;
>+	prot->unhash = sock_map_unhash;
> 	prot->recvmsg = vsock_bpf_recvmsg;
> 	prot->sock_is_readable = sk_msg_is_readable;
> }
>
>---
>base-commit: b1455a45afcf789f98032ec93c16fea0facdec93
>change-id: 20250305-vsock-trans-signal-race-d62f7718d099
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


