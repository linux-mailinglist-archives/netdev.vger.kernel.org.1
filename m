Return-Path: <netdev+bounces-286972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIgJAfvSAmpJxwEAu9opvQ
	(envelope-from <netdev+bounces-286972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:12:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241651B8D0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453C830AE2C6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34EA3126BF;
	Tue, 12 May 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPHJLkDc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pKU8V+Bd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0D379C4B
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569625; cv=none; b=NF4sPqzJoAWKn1uervos8+2xXogsp7JbdGY+O5MCMmmTRRuI9Y5y9pQIm68XVXzfB52jDIbmOi2Z9F0zStWsC+PSjbUonlixToWt52ZHgD2liDOK6SIISV57JGpeBEnE7GHAFYbMtolz8rNWws4Dl7sZI6PlBpE4Ri0jvdUl9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569625; c=relaxed/simple;
	bh=vS9bD3PJ6QBZRXfBeufUTv14f2N0oWCBZ2zQWoQYBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyqnCfgSl95++8h8k0rQ5FRbdo9688JLeSWw84vkNMh3LhRjXhDT7Ab7GqRfF9Mgt3ZtZTSOQm3gpZs9ykj6Q6OsvpD3kjy+zFIDI7rhQIuL6Y1XVWw21ETOx43+hXomrICi60cuNAtGMAhuNNB4eWMn+jNxTF2qts5Vi3nSNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPHJLkDc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pKU8V+Bd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778569618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
	b=XPHJLkDcLpyIP1PHB5TEH34jAIQ4Pwic9ci2Hb6NvK2hQ/7dmCKKnPp4qqC1oGPoUf70UC
	SKM2BkfUEiR5VYp/uP/vvrSZS6k3Tc1wc5X2127qBwp/pC9d/iSrbEbiVNBUmhXcZHPN5Z
	c2DZyrI1BIdA4RKVR8a7oGlRo/8jdWg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-BHo-ygK3MAOHw46TnSPiwQ-1; Tue, 12 May 2026 03:06:56 -0400
X-MC-Unique: BHo-ygK3MAOHw46TnSPiwQ-1
X-Mimecast-MFC-AGG-ID: BHo-ygK3MAOHw46TnSPiwQ_1778569615
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so3390326f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778569615; x=1779174415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
        b=pKU8V+BdcYL2C2ens4Jnikn9y71oQ8Wz7BcQUa1MpgaxYfdSrv4qCLHxCz71FBy038
         cjWNbSLk/uVD0K1jzgHyk87ZMKMPTuaHg4rTrKTxbUy8O8zeKloAOi52JqauQiVDe0tT
         LjjZM/AD+IpSAgcplCR94NvZgI20PKw+461tCW7FZL53LnhLX1KOPcrDhE9nyftIyFsQ
         1vAPYID8Nr4PGgdMBh2/Vj/dm9yJlbcQ3Q+9Q0u4gB4RBWgsai7aPjamHSrNn6cjG8Rv
         7dob7I3NhsmJnaG/MR49CtkkGL+JSfQ9+JIBQ/zn+0k60D24j09QTsiUjq6xL8KssnV/
         CxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569615; x=1779174415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAb8hIM0aTA1jBLlkdpVPpG/v1UTe85oY7sMeZc2mf0=;
        b=WO+LFLDZCO49Gk9LjSRbsa+7h8WWfFBT6V5mUTtSMPB2iXQo/Bd0pwuXr+8PSnKYVu
         hT5qgzBUtw6uKY7EiHVJz6Cu76kl6tJ8P2XolJ3tpXwtwQ9MC1R4zI4LYablUu+3o8C1
         FahLW0VPSkYG3t297ixN+oWuRIjdIWv3fWIK3k3OTRLu46xPmAK/sknCMqxJJAgDU1hc
         JgfCv8Unew58q7AljPo52h7kNzPU/HrbEQqdwJilECK3miCZImV4+jAd2jUGmq9+rz9J
         upTyJOjXMORJQ/YgOtINtmX07XNZyiA8l27m/SJo9O9bZ4zLuABsUwf70WhkV/WM9LLF
         IztQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oK3xwGZ69GmcIdivhxMFW1IxkIO5aSLxwoR8Sv50gOr6pgIINcXmSrAezqBIZNzDS1V7+ngw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFKQ0en4hAE/QpzkTKEwtHLtDDI4f6AeQBDDB3mAzdq9hp7wO
	cOaHmQkA/80/jdYRgKbhKD7pKquPVh1V8Kx5Vow5hxN88r/gEh7Hv03k0ndsIuwPBG+ZqXVpZ8S
	vcIlFB+Uigwqm9bBBJh7BlEbM6hkxXJCPbL8Ix7e4/jgaj6QpU64qJGxocQ==
X-Gm-Gg: Acq92OHAsLfMxL8nNW3JXmezOA+t6Zkd8i8zjmfH32UQxiY0tQLE+LkB/jPCTJXYyg6
	r6NQaGJAjdDTpIEnwuhu6Dxdo6ZcND1NC1two71oKVMOnU3jLd5FQsELmxxlADxLW2dwT9qGiLL
	4Xd+kK7P0bT5b6srCabkyopEPzPFldCiVp2u12sX75QKU9J8zcJUlVVfIT6kqdZGXHf60/lYB+z
	IRuiXeQiMNPH/UYQNWH1ZRikqn5hG+fTbpM6lSgP2+SE81HHOmlpakOUOZPdlT97JkRrVjUCgcQ
	Hj2FBRqPc0YRHlPzpIdV1bDpAQDZdpXqWYRK/LPJTQh8U/YUaZ2Z+UhQlEdIQ+xRcbuRLrxpnF7
	mAcCRaDbmX4FvhpCg+9P7/AyaGI+prV4E4E6E0ZWNAvYzou+LhRv5rcRC6E56s32yN0gnsMuMhA
	==
X-Received: by 2002:a05:600c:3b08:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e8fe80569mr22966025e9.28.1778569614942;
        Tue, 12 May 2026 00:06:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3b08:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e8fe80569mr22965345e9.28.1778569614432;
        Tue, 12 May 2026 00:06:54 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052cd24sm24611725e9.3.2026.05.12.00.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:06:53 -0700 (PDT)
Date: Tue, 12 May 2026 09:06:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
Message-ID: <agLRfHBHJ2990NJo@sgarzare-redhat>
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
X-Rspamd-Queue-Id: 5241651B8D0
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286972-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:58:51AM +0700, Minh Nguyen wrote:
>vmci_transport_recv_connecting_server() jumps to its destroy: label
>and performs an unconditional sock_put(pending) to release the
>explicit sock_hold() taken by vmci_transport_recv_listen() before
>schedule_delayed_work().  The existing comment claimed this was safe
>because the listen handler removes pending from the pending list on
>the way out, which would prevent vsock_pending_work() from dropping
>the same reference later.
>
>That assumption breaks for a peer RST.  The default arm of the packet
>switch sets:
>
>	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
>
>and vmci_transport_recv_listen() only calls vsock_remove_pending()
>when err < 0:
>
>	if (err < 0)
>		vsock_remove_pending(sk, pending);
>
>For RST (err == 0) the socket stays on the pending list, so when
>vsock_pending_work() fires it takes the is_pending=true path and
>drops all three references itself: the pending-list reference via
>vsock_remove_pending(), then the two trailing sock_put(sk) calls.
>The unconditional sock_put() in destroy: had already dropped the
>explicit sock_hold() reference, so the second trailing sock_put(sk)
>in vsock_pending_work() is a write into the freed AF_VSOCK slab
>object.  KASAN reports a slab-use-after-free write of 4 bytes from
>refcount_warn_saturate() on the workqueue path:
>
>  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>  Write of size 4 at addr ffff88800b1cac80 by task kworker
>  Workqueue: events vsock_pending_work
>  Call Trace:
>   refcount_warn_saturate
>   vsock_pending_work
>   process_one_work
>   worker_thread
>
>Triggering the bug requires only the ability to open a VSOCK
>connection to the target and send a RST before the listener accepts.
>
>Skip the sock_put() in destroy: when err == 0 so it only compensates
>the cases where vmci_transport_recv_listen() actually calls
>vsock_remove_pending().  RST is the only path that reaches destroy:
>with err == 0; every other path produces a negative value, so their
>behaviour is unchanged.
>
>Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
>kasan_multi_shot): same trigger binary, same VM, 100 iterations:
>without this patch 52 KASAN slab-use-after-free reports fire; with
>this patch applied, 0 reports.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Cc: stable@vger.kernel.org
>Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
>Assisted-by: Claude:claude-opus-4-7
>---
>v2:
>  - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>  - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>    enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>    same VM, 100 iterations); test summary captured in the commit
>    message.
>  - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>    bug is no longer embargoed.
>  - Rebased onto net/main (no functional change to the diff).
>
>v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
>no public link available).  v1 review summary, for reference:
>  - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>    vmware guys on this that know this code better."  Asked for retest
>    and resubmission via the net tree workflow.
>  - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>    me."  Also noted that no modern VMware product allows guest-to-guest
>    VMCI communication, so the practical attack surface is host -> guest.
>
> net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 4296ca1..88d7128 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
> destroy:
> 	pending->sk_err = skerr;
> 	pending->sk_state = TCP_CLOSE;
>-	/* As long as we drop our reference, all necessary cleanup will handle
>-	 * when the cleanup function drops its reference and our destruct
>-	 * implementation is called.  Note that since the listen handler will
>-	 * remove pending from the pending list upon our failure, the cleanup
>-	 * function won't drop the additional reference, which is why we do it
>-	 * here.
>+	/* Drop the reference taken by vmci_transport_recv_listen() before
>+	 * schedule_delayed_work() only on real errors.  For a peer RST
>+	 * (err == 0) the listener leaves pending on the pending list, and
>+	 * vsock_pending_work() will drop that reference itself when it
>+	 * later cleans the socket up.  Calling sock_put() here in that
>+	 * case would be a double-put and free the socket while
>+	 * vsock_pending_work() still holds it.
> 	 */
>-	sock_put(pending);
>+	if (err < 0)
>+		sock_put(pending);
>
> 	return err;
> }
>
>base-commit: be48e5fe51a5864566307998286a699d6b986934
>-- 
>2.54.0
>


