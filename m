Return-Path: <netdev+bounces-298584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PeGxEIvjK2psHAQAu9opvQ
	(envelope-from <netdev+bounces-298584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4C2678C6C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Wxw91WqI;
	dkim=pass header.d=redhat.com header.s=google header.b=mZ54Iw65;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298584-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298584-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 318F53196C08
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C936C0CD;
	Fri, 12 Jun 2026 10:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A735370AD6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:46:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261181; cv=none; b=g/2W8ZxZ+bu+9KmfgyKuqFdJ8qj6MSwL0uqxpyMvLwU+LA98+sA8ESofZVpMUFxPxrnqGv7iJ+MBWS0tGzxvR17HlbRpp2823A86Fyn8VOW9KlVFYoDm2wSc84jK0f0lHup/VU+stX+6o8IIq9Xw29wKTJfm5MXOzoWV4en7fE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261181; c=relaxed/simple;
	bh=u65Bn7mUeRrJUx2bbJXKRRbhepBmR/uX4W2GEmfYjVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV98Jq0PvhV/Dyg6U2B1guExw/1XkEpAEJ57uDNflPYeqqn1jmYPwKfhJ2VUQ98OYbL2NywVo0YP8M4D9kUx/n5cHK+TqVA4fIWb8+pwDZ/Q5Wjvde447L77moT2MyYBLp96DoQK2r8WT+HsQAIwMaRjzACa4Kx9hZEHAAH53yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wxw91WqI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mZ54Iw65; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781261179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LD/2C2qsDL0yxbIAux5qj+n5CJ7v1MBG4itfMov5pQk=;
	b=Wxw91WqIfXBYSKhWDHEWWjaOEjOzVjXfrJdn1UpG4F3Um5xyWwcNPqd+jyqWWIPrgHEvgA
	IzbWUZ1Jlus3Amzi8Gsc91dlDIIUKcjdnXPy5NEFDWizX8W1GkvuxBnWl8KlqzlznBiUIL
	qIOTt8xMSlYT6ZNDxvQnsHpWxkm2dBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-6HE_O9HsNQqc9za3Ml94Dw-1; Fri, 12 Jun 2026 06:46:17 -0400
X-MC-Unique: 6HE_O9HsNQqc9za3Ml94Dw-1
X-Mimecast-MFC-AGG-ID: 6HE_O9HsNQqc9za3Ml94Dw_1781261177
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so5223035e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781261176; x=1781865976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LD/2C2qsDL0yxbIAux5qj+n5CJ7v1MBG4itfMov5pQk=;
        b=mZ54Iw65Mcw3jFQy9G8JzfSNGn1m0xC/KbmOUMo8acQ+ZNRlRi72cDi97Ey9r5onKb
         kaO0ltn3P9dUMlDqr5ZbmRI/08M9dZ01qUc5GRp+uh3x6CPf9Rpgc6J9ExhYdeoav5UU
         G9jcoKrWagfzYXUVYzW/Ux4kx+urjUvBAk1LutOXLN3UP/H+g+DKz/UY7rHrSHQKR3BE
         eLnD418Dvhok1nJlsima2Tdr4OegucU8kDLM4WCKzyp1iMK0U9TodCJzvmqTWSQZlz48
         SoeHixNUDv5ZNGaKaNYBBuCTWdvPV7GfNvbgxou33Xa3CFuCufobv6GLEd9oTvLGp58X
         yMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261176; x=1781865976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD/2C2qsDL0yxbIAux5qj+n5CJ7v1MBG4itfMov5pQk=;
        b=gyt0i47vdeMXtAfLKUU6Ktv79ldrE5xKoyG6hJac13PPzGR7V6vJSDO09I7PuxW/NA
         0g47xIW7kkbFfT+UiGp1MNo+UUha6vuj54lpE22lxxwm+w2AU2erDYLvz0e6Da+xjJ2E
         6zTR7Gr/woeWYiFcGr1yr1VMKLA4pbvx1l700jmmbEWBilLVGXTLvuhwFXyq3iTaItvI
         qL2eDbgvrhKH3UXURDun6Kd3Uj1XA3hKTehtr9yvISrMab/WaJknVGurmWeoWgQAwucQ
         LM6olSRZ1JvIUeZpbm+Ek77pTHR+DmKy1Mrv37smtP245wr0fPups7D5/rpHIlO+Oaad
         l6vQ==
X-Gm-Message-State: AOJu0YwbBKy5g/LnnsxuRm0ejLmR8akDZ8ow4jfNg4qfbGcvZoKi3eUa
	K10g8xKxru4ZO1M/1r7k5jE5TQestbiTaK6Tz7FReVohLvyNJmq13O87xq/9HBNpegraCT6DtNG
	v6bG/SnAMcn324N6CbTMfUKMI22k5W30CbdURiTGNuB1b1KkyyR8fkRKJ1Q==
X-Gm-Gg: Acq92OExj5chyUJoIHf1GJGKENGRWyThcSJoGoNbW4dOYsUSFw8uZZTk7ufj4a5i4ZH
	s0Y9msUR9G6SN0v5wBHBSCPLxw1O3+My+UlYtOSlXRMGG+ufj+JHYrMKftE7huPeY+FRpFOs5hu
	Goh8p0lfkcFaRshVILcNIUD53F/3OqWXQrHgqnR6rIefrKCFW9H47yeiQgFFdJyOn26V0J1e0hW
	KjCd/Sj6PiaCn4y9mNwIX7SYX2QiSuMqsY+s89nuvITB5mXQmku3hchLgbQMrEWP9dn1OmvkW/c
	HKVTJi3qOA6HxHe6owWLFnn229LslfymMx4VQmADUXNikH0PMtdDeJ9cUJIX/8EQfgdgbsxtlZk
	IluDcdDbcl6wUAnTboK6WJRHioMkAGMqP8lIZyG6xanH5QRw2YHy1rnr0LbwT8Mh7v1cRw9I=
X-Received: by 2002:a05:600c:3586:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490ec339ec0mr34621975e9.0.1781261176651;
        Fri, 12 Jun 2026 03:46:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3586:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490ec339ec0mr34621395e9.0.1781261176179;
        Fri, 12 Jun 2026 03:46:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c8f49sm63830435e9.6.2026.06.12.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:46:15 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:46:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aivjZya3rcXZa9n9@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-4-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-4-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298584-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE4C2678C6C

On Fri, Jun 12, 2026 at 04:52:15AM +0000, Raf Dickson wrote:
>virtio and hyperv call sk_acceptq_added() immediately before
>vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
>itself so callers cannot forget it and the accounting is consistent.
>
>Suggested-by: Paolo Abeni <pabeni@redhat.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c                | 1 +
> net/vmw_vsock/hyperv_transport.c        | 1 -
> net/vmw_vsock/virtio_transport_common.c | 1 -
> 3 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


