Return-Path: <netdev+bounces-278743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PovQD29o32mvSgAAu9opvQ
	(envelope-from <netdev+bounces-278743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:29:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B38403486
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8099E300ADA6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054433F8B7;
	Wed, 15 Apr 2026 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJ3PNSGe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kTgwxjg2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965F3264E2
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248905; cv=none; b=Ir45771blRGdiv2hYLPJrNtg2bojEHQjt53tG5W0up62PV1R7hfviGpuucAEHX4w+WHAFFqixsJJkQEHeIosozK7BOKxBepRHfHkSEHzsNHAzcC8bjDy8goxOeCxYjSvUZgKZjiuL4mG0cq+SrEp2uPTJJcXmlcbSqbUCsi/W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248905; c=relaxed/simple;
	bh=Nq2JUf3iZnsH34xSKQyQkCDKNlRYT1+WHeRN6hIGWd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h79jjguFUvRyyZ3qnx25EzSl663hQo7YZSQSFDpYWnWZ9FWpZsoZun14wm38k0PVQzFXPT/LmQygApmiDMPt/XoGfWlx7T1UchAD85JLKQlBXPu7X8q63Ex42EY1ZQfvgeKU7qicM6caPotWyD9Towj7r+/xI6q6K7cJYmvbOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJ3PNSGe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kTgwxjg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776248903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UnswsbzvcBOLUhzVyhyTshsjUWfgRKeboRPapbCJj/o=;
	b=MJ3PNSGeQmtmIgcrBnz0DmrqNkq1rvaVoJ51Bqq51zCRqcNcEfG+8QfTZsMSTAx4JDUeRE
	8GZ67p9P+CThFYqSrWSFi4t7jS/XysnBF9U09hhF9JKrLHJjMlnKCURRuyqzLoEnUEn5Ow
	TSUTmqDVeQFMsNZehDLcb7nSQ31Ahi4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0Jx8M1wTNpWStOfQi2xx5w-1; Wed, 15 Apr 2026 06:28:22 -0400
X-MC-Unique: 0Jx8M1wTNpWStOfQi2xx5w-1
X-Mimecast-MFC-AGG-ID: 0Jx8M1wTNpWStOfQi2xx5w_1776248901
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d64eba6eso35627385e9.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 03:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776248901; x=1776853701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnswsbzvcBOLUhzVyhyTshsjUWfgRKeboRPapbCJj/o=;
        b=kTgwxjg2eqtLJtSxXlQT8pQZkPS1ooY7id6xEHaLqLNfMHH6S0dn9K8eM039Vn90Pe
         SiEMklus5Es7Cgp0pSpaTOkZZZ+LMdQFi8AmvmjhVI3OvGOuII2JgcDMJ/9rcQzDLy3G
         LE92i00h1ok9R4JQIzV1/Fl8+NpaLhyxLGwnP+xr4Q2HoaBiH98Z1TuPl/JIBRUSzAP9
         padsMP7z5qadNxFaXeDUD88kh1ZzPP8asZfzxEtei5hsJcFwjYK5rLZ5sjmOL31S/szm
         yAzXQWh93PmIP33uQgy0brB4VypuKYbQEoE8dYGVOdz34MGzhUNz9DXlcya8Ahpt96jF
         jYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248901; x=1776853701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnswsbzvcBOLUhzVyhyTshsjUWfgRKeboRPapbCJj/o=;
        b=irVgDqxDiJqV66J7YfTbCG1sJYGREFDwcWRESDF91g9QDIsoT/gC71CLI7eCTeRIt7
         6RscvNtMqg+5csOUlrYJ+6fMnvT3tCZzmPhsc6tH7wGdZlDyv6o1aR0xSmSxYfwxJfrl
         4XGGiHCkcQ380M+1Bg8tBTGopJ3OiXvzTd2+Mh/R+VJ5J3fTUHfDa4TjJZ+uU/I5Lv3B
         cSU3NVcErAsEcD2TI7tbMDP+nA36f6Fn+RwTKhrfP+ZPJ8qzk4CLIt8udDwcb8oCCbWq
         lXZZAzmmbbcFJsxWaIBLExKmekqn/QBAVjMHj7kJgMJLZhMZJVrXxmvhexy8W/nov3fd
         /QQg==
X-Gm-Message-State: AOJu0Yz0BrASO3uDOSl8fWShDOjqaOwNwyqsq3RWGJ93BHeFz+xIJp+5
	PG6b3PulbI8rd4DET7NvUO36QWB41p5BYGEqtZglGt1aMl/qujf0rcDBrwyqA11LpvGJXOf3oOO
	alaHnaoNZfgEJIeYzxfbI29prPkIiUv5LW5ijfXy9Eq6bV2mo9OefomyQWQ==
X-Gm-Gg: AeBDiesdTbB4wIzGSkBIIKsHbqYfUoks+6tJAbodLFpxRVjSjno+HTxqLKzIIoxM1sM
	v1y9+2547E3BWcbdkWeM47E9TbP4E1+VaIaRYQC+Fp95kxdbrz5rHkzngNCpmi7Pyou3b9+thsf
	MWf/kT2IKdGvcBNSY+63ffxQDyO0LEe+TBMN5B52pTEKjYC/t4HR43ZszLI5VmvZO8nCKU1IFH0
	aWX8CrAeuJZJ6Vz9NlJ/nrK1XX0nUgh/v9ybuRWxuYlhyi28Uq7hWfMS+hZ+Z74EKbbYY94bycV
	l9eS4AGmq4YsPPjuiDnBNkI9h8H/ohZ4QNM0i0/T44ojZrOEc7X6SssPJMa1gY9rkQlLRrLh8Ry
	F+Ak/yNnB3of6+iqgKDkwRdYYAjtWmk3aIEfeQfyXmuc=
X-Received: by 2002:a05:600c:c117:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-488d67e370bmr201438405e9.9.1776248900874;
        Wed, 15 Apr 2026 03:28:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c117:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-488d67e370bmr201438135e9.9.1776248900394;
        Wed, 15 Apr 2026 03:28:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm4112158f8f.16.2026.04.15.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:28:19 -0700 (PDT)
Date: Wed, 15 Apr 2026 06:28:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, sgarzare@redhat.com,
	jasowang@redhat.com
Subject: Re: [PATCH v2] vsock/virtio: fix accept queue count leak on
 transport mismatch
Message-ID: <20260415062807-mutt-send-email-mst@kernel.org>
References: <20260413131409.19022-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413131409.19022-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41B38403486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:14:09PM +0800, Dudu Lu wrote:
> virtio_transport_recv_listen() calls sk_acceptq_added() before
> vsock_assign_transport(). If vsock_assign_transport() fails or
> selects a different transport, the error path returns without
> calling sk_acceptq_removed(), permanently incrementing
> sk_ack_backlog.
> 
> After approximately backlog+1 such failures, sk_acceptq_is_full()
> returns true, causing the listener to reject all new connections.
> 
> Fix by moving sk_acceptq_added() to after the transport validation,
> matching the pattern used by vmci_transport and hyperv_transport.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..e01d983488e5 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1560,8 +1560,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return -ENOMEM;
>  	}
>  
> -	sk_acceptq_added(sk);
> -
>  	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
>  
>  	child->sk_state = TCP_ESTABLISHED;
> @@ -1583,6 +1581,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  
> +	sk_acceptq_added(sk);
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
>  
> -- 
> 2.39.3 (Apple Git-145)


