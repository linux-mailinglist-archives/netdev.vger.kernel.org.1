Return-Path: <netdev+bounces-299845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2AiJ0BLMWrOgAUAu9opvQ
	(envelope-from <netdev+bounces-299845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6247968FC4A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=g6P2MBjx;
	dkim=pass header.d=redhat.com header.s=google header.b=H9KRzvnp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299845-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299845-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C8D300372D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763913750CB;
	Tue, 16 Jun 2026 13:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56836C592
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615419; cv=none; b=VsbWkuVy61CswpGfLGQ3J0VCQOlaNRYwlkOBrBVrl9EyYfcS6q16XHBP+CvFfAF3Is5i6DVGxleFke3xanXVgztqhK7zl55mUbzEMSDJE+TsRWVmTNb97ZenCEDssH5tUMGvIzxJudFgXC7naYy33R077WLlDBNmp9GJC6rPfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615419; c=relaxed/simple;
	bh=j8djdhTpE9KyreEqk3wMsIFtENli4AKg3GaItI1dKoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWgKLuUXbEQP1gxJF3adMCL+F9YWuwULctRMt4F+H2KxmCgz5EVgx/uuGTVSeH14LMDihNTmuMJLpT9nB5T4FPVmnw6z4o7BEofHHeJoQAiLTNK34JuSjD6M1UASaKXPyIqUrEJWV4X1wAJOxswWlP/TQEwMuIW19yge645Bvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6P2MBjx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9KRzvnp; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781615417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
	b=g6P2MBjxJgiBerbF6ygNpPkSn9b74qHJC0plFVZPXoUklZiDV+nlQqK++X1tSWC75ysiXe
	kuxLzX8idFePzNr+1Iptp7A9exlE/tD6XVajkzLWejyz6FkC8HgDwFQwgd/E8DaMC1CnPN
	4TwBoygYj2y49uKFOoEh9Aiaat+ByGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-JhaNLwfzPO23G7YUe7G_ag-1; Tue, 16 Jun 2026 09:10:16 -0400
X-MC-Unique: JhaNLwfzPO23G7YUe7G_ag-1
X-Mimecast-MFC-AGG-ID: JhaNLwfzPO23G7YUe7G_ag_1781615415
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46011aa5000so2130426f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781615415; x=1782220215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
        b=H9KRzvnpnp7Jim2ilOnW6p6T5AAN+lHJkcqMZFkO8X2eVdXlAgu/Xpf39TdyL7DaBl
         Eso+/+mW70hdni8ebvmlvTYMvgGt8CIDbr2BCtUGAqN3K57qCcUfM9JYomueoqMutaiq
         zxTIW2SX5hOpOuCOsd+fILhRAzC3kcpYnzHXpDRlq94ELGqn4KAW+UUqrbJKVFNp83qz
         iCznd4EKC6JySlNTUbdjhtOcUV+q5Mm5XbcrC4a3pkLPIh8yxjsZDppCbAvT0doHqZHh
         C17MRmtVqVgubjvnxecTIK7+jWDlB8wfUQvRb4a+HLSIIj7WytZnVfwPWjARXQKdgrPK
         ZhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615415; x=1782220215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
        b=mc8MJhFdI/XsmfygfIOzcNIgEbL86OAauTcv7Kl3M85ZEt6jAyN5JZ8Izg3KuXLSX/
         FYan/p0vq1rxqyUVhJYxFmPdygHP19nadHeOBtj6kFufXlVz1DO65b5bSg3SIxEBcsj1
         n7DafgPuRvTegb7z92blQOyilrgIXshj2eAfmNa/aj6mVDpplSk1aoYtAg4m81AG4DrW
         TSthyfoQsK1UPQBYhFRNVW9iDkUN5ptw86+FEBdL0C8iWrCKOaraIvXU7XMgvPqI55aW
         4jVfcqvIIhAKV7ymoW23j+kaluD7QkAzIh3EdtLlzW7+lKtfsnLxT4XAoYSR6s/vnslx
         PD+g==
X-Forwarded-Encrypted: i=1; AFNElJ/D5QmL+EAQ70DqDXw8IMJxf3ruGtEmkhUSOXcyNZUaOhZhQQRlLuq7CeTKPw6M35ZSsym64Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMrfXD3e7CqHAb/HLEM72ESD5KivMZcVwtv0p/AciHbSNt/XX
	xNCHs2gom6XnIo01k8ppNLAzjLVsMxrkwSwDtMTzAl6FnZCSuPJYMHmygvf42IKI0vju2AvmFuR
	wKxmrMH2DYLJEhu2rcgdbLJSyMmANN/xdB8CoUP5ZWqoK57hSIR+PKfdQXA==
X-Gm-Gg: Acq92OH1HRb+M1jq/xp8a31AayKR0H8ccSm0gq89dOscB9fXqp3xmdCMKUCEjajejck
	cBpbGO4Cd2SmuCwclC/eSwab0lFnVkEsleS+TKcjMRXaUqdg0WnYrCxB/Cj0C5C0wNmRW/b54sx
	gW3Bgt/+uaxRCfehDukrlQkzpGVhgno/Gfnm0hlKlugp5EveiXEXOk8IKVKxY6aBvH5iIaNsxmw
	i1JuCqHPvDOnOrCpNtR00GW+btumxZjLGH4envxWQwf70J2NpDMvwLHD0xhBt97sa/jMWIzTy5M
	6bqysAkce9pnj5Sp1UZUxxJ2G1aBnWBJWvaUfG6kl2Jo2ctz6FFdh8+rAiPowQGb+gqU+I1xpzQ
	XMbv8aX/Cj1WDw+v4/SeQifriDyRQqi+4qbS6nqsFwDUQKeCYDtmHyyd/TogRtaHIltZQaPU=
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-46074a8a2a8mr23974053f8f.27.1781615414613;
        Tue, 16 Jun 2026 06:10:14 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-46074a8a2a8mr23973939f8f.27.1781615413909;
        Tue, 16 Jun 2026 06:10:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm39082850f8f.32.2026.06.16.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:10:13 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:09:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <ajFFOJSdqpNWgohB@sgarzare-redhat>
References: <20260614174756.170631-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260614174756.170631-1-avkrasnov@rulkc.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299845-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,bytedance.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,sgarzare-redhat:mid,rulkc.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6247968FC4A

On Sun, Jun 14, 2026 at 08:47:56PM +0300, Arseniy Krasnov wrote:
>Logically it was based on TCP implementation, so make further support
>easier, rewrite it in the TCP way.

Hi Arseniy, and thank you so much for the patch!

I’d like to ask you to expand on the message a bit, especially to 
explain why we’re making this change.

In particular, I’d like to better understand whether this is just a 
cosmetic change or if we’re fixing any issues (and if so, which ones), 
so we can determine whether this patch should be backported to the 
stable branches.

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>---
> Changelog v1->v2:
> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>   already added.

Ah, okay is net-next material, please use the net-next tag (ie. [PATCH 
net-next v2]).

>
> net/vmw_vsock/virtio_transport_common.c | 48 ++++++++++++-------------
> 1 file changed, 23 insertions(+), 25 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 09475007165b..787524b8cb44 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	if (info->msg) {
>-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>-		 * there is no MSG_ZEROCOPY flag set.
>+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>+		 * handling from 'tcp_sendmsg_locked()'.
> 		 */
>-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>+		if (info->msg->msg_ubuf) {
>+			uarg = info->msg->msg_ubuf;
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>+						    NULL, false);
>+			if (!uarg) {
>+				virtio_transport_put_credit(vvs, pkt_len);
>+				return -ENOMEM;
>+			}
>
>-		if (info->msg->msg_flags & MSG_ZEROCOPY)
> 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>

nit: we can remove this extra blank line.

For the rest I can't see anything wrong, but a bit more context in the 
commit would help me in the review.

Thanks,
Stefano


