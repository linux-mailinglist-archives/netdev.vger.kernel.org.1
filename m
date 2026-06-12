Return-Path: <netdev+bounces-298704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W/o7MxcdLGqPLgQAu9opvQ
	(envelope-from <netdev+bounces-298704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A067A584
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:52:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UMmpFZDW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298704-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298704-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC43B300908E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3972345CB2;
	Fri, 12 Jun 2026 14:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B231B10B
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:52:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275924; cv=none; b=NRoSANW0u+2h8pA24cTE4NjZ/ABqTXr0G3o4oeRVdcqvhiptaw5X0DS3M8lc7Iqp4VHD9zdZAxOzRa7gpsdOz+weq571YBcW+LrJBrE1LrqQsPiwZIkRu3OpwrMn0dm9daLz4Ajvu7X1s17etRgy9j++rLbCcgL9P1EwFORviiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275924; c=relaxed/simple;
	bh=MtLXFPswneMburYu+lWG7VpR1RjssBUjozfMNoj/Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6/P6cHpPoqZ4EDvXSR6QtZ8FeZQmcZzfDNYMelyf58n6jFgPjUuyB2X1upyHRU7Et0PufY6e4ImOSLiiSH5J+bkcXgd+QPaRYuS8lOsdum6lOTzGeebHSPlufkJtNncEOzVxj4eVL4Md1FyzOYKsSrbaJ1w94Lf45ENz16gi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMmpFZDW; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c2da7fa321so4673845ad.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275922; x=1781880722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqMd8Q5yt8mAGXSVOkSVuvsH9v3zwILU1VT0pazsblM=;
        b=UMmpFZDWec/Ueibyq22/ITPAeh5nZ0vG+6kPJCTvHSXtCxWIgfpweoWNyGXRmX9uTa
         bjVEBNq7arP6qDkog3CKsSPpVoesSBd+vcxkMZYkwvkrud9w5aD8lua9f5RtMXB8m29D
         GUHHToPlitoyPJqYW7vC2ljUOwZ1DmpxD6vjhixFVlxRxL9OvwY6QMd3q7Ow36Aany80
         J7G28sI1AFnoJrAvTKrevXvxKBS8vJCi95kPidI9swkBW59w+L72P5+xs3YTgIQAsekx
         j9T+d9CGoEEGICBFmDNsQc/P3a8x4F/MVtKmy8kfG4SF8ltMOOVGeZhLkQeqvg9UkkRt
         /kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275922; x=1781880722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqMd8Q5yt8mAGXSVOkSVuvsH9v3zwILU1VT0pazsblM=;
        b=VTZmz4tT3FYi4FcScDPOBOZVKbSSibYiRPFMA8C2vHKVEfxNPXcW5spELnKAYbtbmB
         GpTyihTAXcWVQvluHwM5AvhVy7seu4/u/MXsY4giwo10VPpz7sBz46UzOF+Jvl2X8e9s
         OyE9SmHLsoL2SIf9cc07IiKbMq8Cdrzd2tXANmJl3EspW3gs8s7IMyEB6KPqQboq/bOF
         g39KDEKQn9MyNY5n5RSDGFJcjjzpzvUMg0jlJjwxe8uRqqYh4QOdQ20qDc4ohjPDxaoV
         K0k12EC4amHgTIK19tCeNVkc+hOrMv4pYWkY1aUCs/1Ns2OGzhRQUs7P8xox7SEsvpPt
         aQVQ==
X-Gm-Message-State: AOJu0YzFKZFEeJ0bXNfJG9EPNYmQJIBio9w2Xod+NDoxraaldfUw18J0
	i63xgyBZM02KsD75W9CIgTemj9GThlHBOTWHZ8OJCx2DSpZyzHqa6kA8
X-Gm-Gg: Acq92OFq8ztJbIjWx72V8qB/iHxdY77lWdOQjNE/ltJapSxFrw1TvXNJmOgqMt9qIDN
	15s9ZOfEW41fAZYmFv1lglqoJPeCbMwuNxF/Qh2hOz7l3dX6f+5U2XvlOI+AvqDotO+ajLxXv50
	3bTfVpR7DEyDbxTqJAi8xT3BHMekAHb19Mt+cxxAWUXFYmnngxQGbcD6yPd1Ogxyun4CO8yujfu
	6+GwryEsSWDD6n7sSnsbnj0iDmJgM4wD1Km/qNt7suXiBYJnYiCjRrFKMjl8gclRoBHvqNQofG8
	Fz38k76S4x+5Z+/cF9oi3wHHZA7gl2ex1x3LnItQPD+KWAfcACX6R4IuPoX8EAeVD5YY4j3v28r
	UxzktCggwENF8Ghq3VDMgYC6AnddwjgQNwQrZw0f2uc+PO7dnivUmpPdbCBrEv6WsqhTMwmRCdy
	8rPCe5BIqOWXmPCdgcVG50yEWnaoJZVBEfZ5rGeZFk6gKk
X-Received: by 2002:a17:903:2bcb:b0:2bc:8f9a:3642 with SMTP id d9443c01a7336-2c4114a22d3mr39476645ad.16.1781275921806;
        Fri, 12 Jun 2026 07:52:01 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm25666815ad.38.2026.06.12.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:52:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:51:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aiwdD5EAqxW6Xunv@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-5-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-5-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298704-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A5A067A584

On Fri, Jun 12, 2026 at 04:52:16AM +0000, Raf Dickson wrote:
> Callers of vsock_remove_pending() must also call sk_acceptq_removed()
> to keep sk_ack_backlog consistent. Move the call into
> vsock_remove_pending() itself to make it automatic and prevent future
> callers from forgetting it.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c       | 2 +-
>  net/vmw_vsock/vmci_transport.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 24916dd4e9..4a7d6d247a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -494,6 +494,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
>  	list_del_init(&vpending->pending_links);
>  	sock_put(listener);
>  	sock_put(pending);
> +	sk_acceptq_removed(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_pending);
>  
> @@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
>  	if (vsock_is_pending(sk)) {
>  		vsock_remove_pending(listener, sk);
>  
> -		sk_acceptq_removed(listener);
>  	} else if (!vsk->rejected) {
>  		/* We are not on the pending list and accept() did not reject
>  		 * us, so we must have been accepted by our user process.  We
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index c2db016cca..3e6445f4e1 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -980,10 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  			err = -EINVAL;
>  		}
>  
> -		if (err < 0) {
> +		if (err < 0)
>  			vsock_remove_pending(sk, pending);
> -			sk_acceptq_removed(sk);
> -		}
>  
>  		release_sock(pending);
>  		vmci_transport_release_pending(pending);
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

