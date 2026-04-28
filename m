Return-Path: <netdev+bounces-281738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGhwL7Z48GlgTwEAu9opvQ
	(envelope-from <netdev+bounces-281738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:07:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618DB480EB8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F12CC30771A0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3153A3D6CD7;
	Tue, 28 Apr 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuGktwg/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAwM32SR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80712313E07
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366681; cv=none; b=bt8XSFQtc2UwgEvnOpZAUC2l/2eQVaizNVyNxTjqKmZntgbJL1Qt0yGFbVpgrdhTsUnMzk3SahDXsAQxPKA0J6TNC7GbMyx1rXX4KHvdpF6C8LARWh+tcG3FloLs7BGHy41ljlAWs7tTMWuoNZlM1RoK5yGjDhybqTPsubo2NUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366681; c=relaxed/simple;
	bh=uRW8e72Rqzipki+9LHRLNLqQmu5KdCJEOG4HG3wjS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH2n2Tt//o0/N3bPQlTXGWwxiR1lalnh2JxENCA14AGmhq309LHcJpBBPhrO+j3rlNclfHxaj6urbw6pM3hV6u+ZDA6jfFHF/GemdiXC3yJyRIxQjc2L0oHRpaurJ8LqNUHdRUK8+YMzFn3mboquuWf66fWL6kMecNN2Jz27JMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuGktwg/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAwM32SR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777366678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
	b=BuGktwg/HaFhg0M3grsaQnjUvw25RgE6THKapGAucrtmnvDamKCDyNf/6s5ec9+3gIcrLI
	K5KnpMdPAWd+5FALQmQ3AvhQBgQd6ukPOX+Pw06WDuN1taAiGJx9bcEY30R68FieKqFANU
	AiRbTi20jvrMD38nxF3AbuS//T44dw4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-srQiH-J4PCOaYzjB0NBH2Q-1; Tue, 28 Apr 2026 04:57:57 -0400
X-MC-Unique: srQiH-J4PCOaYzjB0NBH2Q-1
X-Mimecast-MFC-AGG-ID: srQiH-J4PCOaYzjB0NBH2Q_1777366676
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so9028835f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777366674; x=1777971474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
        b=OAwM32SRVUIL37zmjCtBd49J8Q3ecj9VpYAuKE/n947vXGaniH1Gyy7cJR5mQw6Ake
         SB1m/ewoTHsEUYt1VHUn9zsf4PPmZd1nM5e723O61RdUCV/QGLjO0bHDdA9hct7VqlXS
         LrX2n8Z4QVhp9fqRVaHTzt+nLpAkBgNBg3YcUcQqWb0L25CIOY3Yi62EKmjb3f/d/INq
         sCznr/pjENHq5VYyhAVneyWUyrVA9FIPdUBMXBdg77xnx+sEPLf6DT0yX57SREB8bRcH
         6LV1DDZldR7O3ja9+Mz8SCaWj+zWqLj8Ek/tCGS1zBni044cG9w8i2Erq18CTDGPlTUy
         yq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366674; x=1777971474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
        b=DVZ0O/s3Jp1xNmrJhAgngXybnP2EOWVrTn2VCcyqiu3EouhLwyyS/VDra4hEswW0hT
         hIoZduXwg30QwwNvNnyNcg4PBTSPmjSEH8ULSDZ8mQHte5VWXZEaAQZyb6MDagNm8xu/
         xQqYvvDS2aD2h70BTwxwqzjfx1Ex/yP8iscA08+FIZJaTMIs5f3nM2q4h44FacEBT1w4
         X5XVNkbhdAye8P+WFDKaqm/CtXHujjN1M8KBxsf9I1RLh2yjHeUMjqd/vmzq9ck9OQlo
         VnaRcYoJC8824sQzHsJ0oqcE80SfUE1DEwNgzf/BX6aI6x32qajN6YkIMRoVXdIc/Jj5
         nYWQ==
X-Forwarded-Encrypted: i=1; AFNElJ85qeouRshJYzfJffXb/lf+lqqQ/VC7dlGrkggnL81zXr/jgdUAdKW2SZbfj6wtOxa0z5RI3Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQdv8n0v6irm5l6sq4j8zEcIyR34EpTmE+HstRlPxLx5/rcss
	qsZrAvzXpsJsPvnxx6Y7kl+kS8Eny0/G1qKU8DKlA1dYdK2a+XeHy0FOfdQA6IeW+U4zZ1EHAby
	rEhD2YFjaj7NUljo7TposW2y9SSavW6x+AoH3kjp8RYQgY1XWBpOqvU1rvg==
X-Gm-Gg: AeBDiespMy6585CxDCmLAFQrCI3fIqaMyN9MTG7J1/OGKSJkBJr1cl9tYxErVsmAQr8
	1W/YXhCfWpxgQBVbt2Y87Xd1Edp1B3gaJioTFPq1i0ObHwP54YWK+93d1koiMqo6Hesjwpxt0f/
	sSHH6IJvxYtuIjwiSKvKi5e8AHYs4WlM8oK1LpjFaAanwaB1rjDc0VPtTkRs730nMVwsoj1IZN9
	SrIs8wF+LS+JEemerlG/KfHbfO5Pi10GjSe8JuLG5/9rOEEqmaNK/S5bOccQi7T188LkqRvzSC7
	DXP8io2iRxY65mcHgkIIaevClAH8Zok/XYPSEGyLRnLpwSsm4vdNq5ONAbqzRgoYT7UmGqxk4Hz
	meqNzIIS9nJTdeW9Bkd9W9oH15rgd2zdOXkAN2mzW5Qpijk21GbIgtOzxg996qDtOauNPRbuOU+
	VUkqY6qQ==
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id ffacd0b85a97d-4464a913403mr3894575f8f.33.1777366674226;
        Tue, 28 Apr 2026 01:57:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id ffacd0b85a97d-4464a913403mr3894514f8f.33.1777366673658;
        Tue, 28 Apr 2026 01:57:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fb7e2afsm4634086f8f.28.2026.04.28.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:57:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:57:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen()
Message-ID: <afB2QCHtoREOV6ml@sgarzare-redhat>
References: <20260424150310.57228-1-kartikey406@gmail.com>
 <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
 <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
X-Rspamd-Queue-Id: 618DB480EB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281738-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]

On Tue, Apr 28, 2026 at 01:54:36PM +0530, Deepanshu Kartikey wrote:
>On Mon, Apr 27, 2026 at 7:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
>> >Two bugs exist in virtio_transport_recv_listen():
>>
>> Two bugs, two fixes, two patches usually.
>>
>> >
>> >1. On the transport assignment error path, sk_acceptq_added() is called
>> >   but sk_acceptq_removed() is never called when vsock_assign_transport()
>> >   fails or assigns a different transport than expected. This causes the
>> >   parent listener's accept backlog counter to be permanently inflated,
>> >   eventually causing sk_acceptq_is_full() to reject legitimate incoming
>> >   connections.
>>
>> Wait, I can't see this issue. sk_acceptq_added() is called after the
>> vsock_assign_transport(), so why we should call sk_acceptq_removed()
>> in the error path of vsock_assign_transport()?
>>
>> Maybe I'm missing something.
>>
>> >
>> >2. There is a race between __vsock_release() and vsock_enqueue_accept().
>> >   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
>> >   the accept queue under the parent socket lock. However,
>> >   virtio_transport_recv_listen() checks sk_shutdown and subsequently
>> >   calls vsock_enqueue_accept() without holding the parent socket lock.
>>
>> Are you sure about this?
>>
>> virtio_transport_recv_listen() is called only by
>> virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really
>> confused.
>>
>> >   This means a child socket can be enqueued after __vsock_release() has
>> >   already flushed the queue, causing the child socket and its associated
>> >   resources to leak
>> >   permanently. The existing comment in the code hints at this race but
>> >   the fix was never implemented.
>>
>> Are you referring to:
>>         /* __vsock_release() might have already flushed accept_queue.
>>          * Subsequent enqueues would lead to a memory leak.
>>          */
>>         if (sk->sk_shutdown == SHUTDOWN_MASK) {
>>                 virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>>                 return -ESHUTDOWN;
>>         }
>>
>> In this case I think we are saying that we are doing this check exactly
>> to avoid that issue.
>>
>> >
>> >Fix both issues: add sk_acceptq_removed() on the transport error path,
>>
>> Again, better to fix the 2 issues with 2 patches (same series is fine).
>>
>> >and re-check sk->sk_shutdown under the parent socket lock before calling
>> >vsock_enqueue_accept() to close the race window. The child socket lock
>> >is released before acquiring the parent socket lock to maintain correct
>> >lock ordering (parent before child).
>> >
>>
>> We are missing the Fixes tag, and I think we can target the `net` tree
>> with this patch (i.e. [PATCH net]), see:
>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>>
>> >Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> >Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> >Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> >Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
>> > 1 file changed, 11 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 416d533f493d..fad5fa4a4296 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> >        */
>> >       if (ret || vchild->transport != &t->transport) {
>> >               release_sock(child);
>> >+              sk_acceptq_removed(sk);
>>
>> Ditto, are we sure about this?
>>
>> >               virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>> >               sock_put(child);
>> >               return ret;
>> >@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> >               child->sk_write_space(child);
>> >
>> >       vsock_insert_connected(vchild);
>> >+      release_sock(child);
>> >+      lock_sock(sk);
>>
>> IMO this is a deadlock with the lock_sock(sk) called by the caller.
>>
>> Also a comment would be helpful here to explain why we're doing this.
>>
>> >+      if (sk->sk_shutdown == SHUTDOWN_MASK) {
>> >+              release_sock(sk);
>> >+              sk_acceptq_removed(sk);
>> >+              virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>> >+              sock_put(child);
>> >+              return -ESHUTDOWN;
>>
>> Since this is very similar to the error path of
>> vsock_assign_transport(), I think it would be better to start by
>> defining a common error path for the function and use labels to exit, so
>> we can avoid duplicating the code multiple times.
>>
>> >+      }
>> >       vsock_enqueue_accept(sk, child);
>> >+      release_sock(sk);
>> >       virtio_transport_send_response(vchild, skb);
>> >
>> >-      release_sock(child);
>> >-
>>
>> TBH I'm really worried about this patch since both fixes are completely
>> wrong IMO.
>>
>> Thanks,
>> Stefano
>>
>> >       sk->sk_data_ready(sk);
>> >       return 0;
>> > }
>> >--
>> >2.43.0
>> >
>>
>
>
>Hi Stefano,
>
>Thank you for the detailed review!
>
>You are correct on both points. I apologize for the confusion — I was
>looking at an older version of the code where sk_acceptq_added() was
>called BEFORE vsock_assign_transport(), which made the
>sk_acceptq_removed() fix appear necessary. In the current kernel,
>sk_acceptq_added() is already moved to after vsock_assign_transport(),
>so that issue no longer exists.
>
>Regarding the lock_sock(sk) fix — you are also correct that
>virtio_transport_recv_pkt() already holds lock_sock(sk) before calling
>virtio_transport_recv_listen(), so our second fix would indeed cause a
>deadlock. I missed that completely.
>
>I am still investigating the root cause of the memory leak reported by
>syzbot. The backtrace points to the vsock loopback path
>(vsock_loopback_work), so I am looking there next. I will send a v2
>once I have a correct analysis and fix.

Okay, thanks for looking into that issue, feel free to chat here, or in 
reply to the syzbot report if you have some new findings.

Thanks,
Stefano


