Return-Path: <netdev+bounces-281337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIhILAlp72lZBAEAu9opvQ
	(envelope-from <netdev+bounces-281337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB6473B77
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7EC305C48C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8F3CFF49;
	Mon, 27 Apr 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh2TvsmZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6bLZzeL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4B2FC00D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297532; cv=none; b=sz+6wW6d1QYAnCYOGTa3bQAv5KNvPdDXetId8ODmGrJPVOt2Ei9k6Se+COgQZYMX/gHDJ893j4PoBxeg3OKE7qTdTp8TNlBmAW1BLjMlJtRhKMoi7S0NWntsAxm46dDN0LW4ubqSlbQgov1lm3j93ReLoMGacpsMwGG0CQA81U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297532; c=relaxed/simple;
	bh=vdEge6E6gvHM8ffoINkybHalssstepUGTZdrRvykmLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ2xNN1Yjwd2S1U89+ftP/TQPzhOryRtFJ0wPdGegKU4+VJ8nu+T7xC2SMttH+YpY77P9wEoQGQoVOpPQeiCGQTDbytoeI7I/xUKJcH+bZjUYhvrp71VBY7OX55InSgEIsjXmG/VslkQ0/Fb85f51802zAb0N8hTb4eVI15JXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh2TvsmZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6bLZzeL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777297527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
	b=Yh2TvsmZa5lGirtFSkXowVPjK37Le9v7/hF4L4OKrXkIhMz8I5WZXNdCZs0bareI1mhNNe
	hwFD5yeVuGSmyqrKyQ8zdMn/11414FLrNGVOtP9IK3eXjfKG2CzxYV6dOL6LWr1qAnICq0
	2nRtOYiL0yQtMX4Xvlb9dd5Ng8uxmAM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-FOfxCn0dPS6z1A562OFmFg-1; Mon, 27 Apr 2026 09:45:25 -0400
X-MC-Unique: FOfxCn0dPS6z1A562OFmFg-1
X-Mimecast-MFC-AGG-ID: FOfxCn0dPS6z1A562OFmFg_1777297525
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4440c5944fbso1172847f8f.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777297521; x=1777902321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
        b=Z6bLZzeLzILM+eK/wPct1O5ddsj7a6waMRazWRzGSIkB5NdCdEL47nfO60VZmdiSfx
         6mlgA1aJGFq7urag+ufUefypzVoRo4Dy/3P+aXOtRVWW8QS7hc1gS6glrIc9YvO29gYy
         OCq5RmnOlGR2lDwKulpSOwcCU/hbBU+/CwMUP5h9faqFGgeRgm9frclSvbTF4xQX1vaU
         lzGNXp7DRT2HGRTcYXrnRXwLWN/M5N4XGITlRVUC01SMsBvnhgEJc5fWNeaX2Nl9Aakv
         uNkWSdZcjc4KYLr35mcoO4/wSNHC3vZyO3cxSMZ2gT4f5M3Vhq/S8qOkVtXm4F3iTUwx
         7nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297521; x=1777902321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
        b=gyofr3cRK3NOh1cRdf51WZTc0Yb6BsuMVSa+GY03G7FRIr/wR/HWr2kf5lgMtHq4wu
         65xF6wKD4Dcvvw3TlbWa4eNOCtt8MDJWBxe13XLR0+b31WZZBJqKEezBOr4EXuv1mjnA
         gki4zNz3hSl862pDywcPY9Dan8SE61W5xT7Ds7cZ+/pf5ouIVZCb7y9twVvACImJvNaz
         l2hfhZry2mlIsQy539oas3BlX4+wKSDmmbV6n4oq01WZiZdWO1r1Q6ly0+kTPsv1GZPa
         z0VWMkZPIoVZwBHZiEUMhJOH+bQsTg5fYtg7d2MIuMAOTaGkmpXEfApYGxSDEMPBVBFf
         uQSg==
X-Forwarded-Encrypted: i=1; AFNElJ/TC+ZR0AX5YQo1hLZGdexMNjnYv8ZTHp3x9mGkfGxV2Jq+xRj9b/aKBV9zsXEJkBmxIyPLbUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81i4Aq5So+uYcPHJPAiZhaaapciBicUDatSFTZ0yuzm+NbZyT
	E7kTJhcbRV+3LH66wdmqo29qj80OMxEdEEVLRHVW9ZCjDDsZ2JLfODPCspbKyoRoBvGbQGrD3SB
	vStlbDvNRubDahFNovC6T/aliiyJU+HEG/1YVCYTNawi5EUtrI9zxs/LWow==
X-Gm-Gg: AeBDiet+5sGWj8FDRRsmIBc3maLGwTVXojE7fQMcRNeuPXsEyqeDs92FmDuZr89l5NT
	y8ktM7JlQLkXxukNh/LMLrC6w61rkMMjh8MBsJ8ArenQqulwGDdT8Zxo/p4BHtVrNOmRoq1cb7J
	TKSvcwXZBzEUWPaLPGDZIIw2NQBBS6kMLc8LUxxhUtP6H0sWXllTEDK4KcyPqWE3RgvTqwpiVIV
	Hc46K1T/DnThWWBo11tkFAybF2jKm0Z+ELar4EgfyPbRS2WM+ZevueyoAX0paW71zvjXbvi1UCV
	bKhXwlPHNe+GhuSQi8mRgy/LkgdJRpjZ2nB4T3kaecgLrQ+HQC93tVP1McHfVnki3nXqUtM1t/z
	XWssjx71hPoCpI0BvY87TFyo5Hqg6RGIeF4yUoiIgHFlfftpmiBMIeJovfVWSgooMqQ1sBHMQSI
	FLEcxDiw==
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr68258912f8f.15.1777297520883;
        Mon, 27 Apr 2026 06:45:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr68258832f8f.15.1777297520331;
        Mon, 27 Apr 2026 06:45:20 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm81966218f8f.10.2026.04.27.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:45:19 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:44:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen()
Message-ID: <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
References: <20260424150310.57228-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260424150310.57228-1-kartikey406@gmail.com>
X-Rspamd-Queue-Id: 02BB6473B77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281337-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1b2c9c4a0f8708082678];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]

On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
>Two bugs exist in virtio_transport_recv_listen():

Two bugs, two fixes, two patches usually.

>
>1. On the transport assignment error path, sk_acceptq_added() is called
>   but sk_acceptq_removed() is never called when vsock_assign_transport()
>   fails or assigns a different transport than expected. This causes the
>   parent listener's accept backlog counter to be permanently inflated,
>   eventually causing sk_acceptq_is_full() to reject legitimate incoming
>   connections.

Wait, I can't see this issue. sk_acceptq_added() is called after the
vsock_assign_transport(), so why we should call sk_acceptq_removed()
in the error path of vsock_assign_transport()?

Maybe I'm missing something.

>
>2. There is a race between __vsock_release() and vsock_enqueue_accept().
>   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
>   the accept queue under the parent socket lock. However,
>   virtio_transport_recv_listen() checks sk_shutdown and subsequently
>   calls vsock_enqueue_accept() without holding the parent socket lock.

Are you sure about this?

virtio_transport_recv_listen() is called only by 
virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really 
confused.

>   This means a child socket can be enqueued after __vsock_release() has
>   already flushed the queue, causing the child socket and its associated
>   resources to leak
>   permanently. The existing comment in the code hints at this race but
>   the fix was never implemented.

Are you referring to:
	/* __vsock_release() might have already flushed accept_queue.
	 * Subsequent enqueues would lead to a memory leak.
	 */
	if (sk->sk_shutdown == SHUTDOWN_MASK) {
		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
		return -ESHUTDOWN;
	}

In this case I think we are saying that we are doing this check exactly 
to avoid that issue.

>
>Fix both issues: add sk_acceptq_removed() on the transport error path,

Again, better to fix the 2 issues with 2 patches (same series is fine).

>and re-check sk->sk_shutdown under the parent socket lock before calling
>vsock_enqueue_accept() to close the race window. The child socket lock
>is released before acquiring the parent socket lock to maintain correct
>lock ordering (parent before child).
>

We are missing the Fixes tag, and I think we can target the `net` tree
with this patch (i.e. [PATCH net]), see:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..fad5fa4a4296 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 */
> 	if (ret || vchild->transport != &t->transport) {
> 		release_sock(child);
>+		sk_acceptq_removed(sk);

Ditto, are we sure about this?

> 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 		sock_put(child);
> 		return ret;
>@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		child->sk_write_space(child);
>
> 	vsock_insert_connected(vchild);
>+	release_sock(child);
>+	lock_sock(sk);

IMO this is a deadlock with the lock_sock(sk) called by the caller.

Also a comment would be helpful here to explain why we're doing this.

>+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
>+		release_sock(sk);
>+		sk_acceptq_removed(sk);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>+		sock_put(child);
>+		return -ESHUTDOWN;

Since this is very similar to the error path of 
vsock_assign_transport(), I think it would be better to start by 
defining a common error path for the function and use labels to exit, so 
we can avoid duplicating the code multiple times.

>+	}
> 	vsock_enqueue_accept(sk, child);
>+	release_sock(sk);
> 	virtio_transport_send_response(vchild, skb);
>
>-	release_sock(child);
>-

TBH I'm really worried about this patch since both fixes are completely 
wrong IMO.

Thanks,
Stefano

> 	sk->sk_data_ready(sk);
> 	return 0;
> }
>-- 
>2.43.0
>


