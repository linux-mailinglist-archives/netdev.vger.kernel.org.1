Return-Path: <netdev+bounces-298581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FWkhM1viK2oKHAQAu9opvQ
	(envelope-from <netdev+bounces-298581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D6678BE7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:41:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=O0IrGygV;
	dkim=pass header.d=redhat.com header.s=google header.b=MVOCA+5x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298581-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39604314E964
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9C3ABD90;
	Fri, 12 Jun 2026 10:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261C3A48E6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:41:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260887; cv=none; b=VapdLc9bzdSqwsOX9u9CsQ7qk/LyfpkpklRFj0vD/fWVUJXsdgEH98zkF+h/FxpN4/cUV8VXYYkpO87x9NMmT9+CNQoeqB1uzqD78IQf5bRv1OCv8iicIj5LszfpCAQ7jeiwPoLhsBeFDGhCcaNNn+ETJJogw91+bVmry1kUCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260887; c=relaxed/simple;
	bh=5rn91acBsm08u48pralh41ZJgakPaI+PEvZtOgQ92sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o90qaMJEP3wlxfGCmn1PTpHlNlpt7NtrmRfFNwnhcekswOT9bgJCH/iShtVYElJQjkItd+otq4v+NymOCk4F/qczpyxqnb+QaUsbl5qlCyaXj/oIpuDqMpJ5apO1/uclR5OYbAsLsuQKQ8hk1Zl99jJ56rPVLhwgr4mOHnXiWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0IrGygV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVOCA+5x; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781260883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
	b=O0IrGygVmYEqqi3sT3bTUvJwT2STsGxzvpGE899qWgTSRp8djuM3A3awAfYGptVP9/zsok
	CcycSYs8S5fNDYDAEaJhAxW3ZtMcZ+uGBVv9pTzFEiMUf6j/kgr1oyFJlwU3L5utgH1H1E
	5tIYOztgAa0vCPKQ/pRBnhpoX2zjJP8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-alkSOLQPM1CFa2liwAxWsQ-1; Fri, 12 Jun 2026 06:41:20 -0400
X-MC-Unique: alkSOLQPM1CFa2liwAxWsQ-1
X-Mimecast-MFC-AGG-ID: alkSOLQPM1CFa2liwAxWsQ_1781260879
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso499107f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781260879; x=1781865679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
        b=MVOCA+5x3ksoxZkF7IhnoW9HWYtEJb90XEMn7eHGArFRd/2pZRLQvhlixCe8SU4RDZ
         b4PJn5oFm645T9gK3BTJgFurbOE5vS/eHo1RPUzbeRVJzoGaVs1aX9d6SibFahtuOdSm
         RPZduKi7hzQ99yKR3VeNLVeW663AEwVSGWUCsXktLu1ihfBHUVVkTWY9W2t7zr0PTwZP
         RF4onvvbtFyQkboUZxS6S77vFvF+kLd8P7lCszolYk5SNTc9VZPBrXFYTr+dgYv5R3sG
         yXqd+zr00fZaFo3J204qRe5c+vvML1B9o9ZmoGG/75wyiK+cRNpNHVWMko60kWq3UPH0
         UNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260879; x=1781865679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
        b=Y3uThG99n8o6kC6EfWmsuYcS8r3W+ytOaHHZkRyTIVjWaIJUo1xVMBS/PMO2YRGytk
         8pCN6IaMSehmVpNxKoM/K42IMB7WXLrKYjbYWFahUcuqLFJVuPhghiuxOOoabu5cykC9
         kV61q/9wKoyxPSKEH0uu++gQEOjq+gdMWPVMqCshwNPHLvcf3gVot0dfbvx04yH8hcLN
         eTex9dbZLLffjyDBwXpJnmsGkHUMx9A/Cm4GDxF37TmIzBDluJdHy9JG7UniKpm5B3WI
         XOxXUPUCHxTBc6s82N6o+0cjk1Qoa7ewJ58z4MhIaRbxBXJGSNlbhC3QBaLMkckrmuk2
         45xw==
X-Gm-Message-State: AOJu0YyE8Z5ObQ1pnpyd3rr9l5LTtFIBnmf7qur0RwQWYZYagLrQs1/7
	8khLE+UYyfz8RaiR43h+kkEF/FvzDK5BrsEVwF1ho6xyldJjVSzNWYgovMWPYMdEIhTAYtIoyGH
	+VNVOX2cOdfeWHbnQ5Tf7ihhmDAneLqstquZv0mcQEQe8bvLluDq//kM5QQ==
X-Gm-Gg: Acq92OEIWnW3QIHtif4brAYiTjflZXnjC/ltlqpV9uj+e3zKWp9CO9kNHK7bXMTU9Os
	8Jh245nVGVI8du+s26HfuKyr6HW67wmxzmJztwrIny0i6LidMFEuEb8xecd+OmBQCLe8oYXbXJm
	FpJJFZDv8lz02KdX09FoTXXx185EjNkuc3WRRLg/W8Bq0K9RDcvlNWPXIJzWdLZqQwsYbPTOmop
	FnDGqJv1lvekvhvx6r6CrXg/FROyqrG5Nkv6f7O+ZFqG+xnIz0r1e3Y7zdxP/5uCs/AG+QG9Dp9
	mAGWTAIXiFdRSYHpW7UD/r9KvmPWMopTf0EDTbHQtlhV4y7fS8NNZNyCHVCciPAt550lw7WIIC9
	CP1hlH3gnLhns7aX7rDXnJNnioioknoMSwNq3bcavO0Z8NV5Zp5HQF1NP/NzqfrvOPcJv5so=
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr15956435e9.15.1781260879099;
        Fri, 12 Jun 2026 03:41:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr15956155e9.15.1781260878658;
        Fri, 12 Jun 2026 03:41:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm72684005e9.11.2026.06.12.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:41:18 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:41:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiviO__2-a-1TZLC@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298581-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 302D6678BE7

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
>Add vsock_pending_to_accept() to move a socket directly from the
>pending list to the accept queue in a single operation, avoiding
>the sock_put/sock_hold dance and the sk_acceptq_removed()/
>sk_acceptq_added() pair that would otherwise be needed when
>calling vsock_remove_pending() followed by vsock_enqueue_accept().
>
>Use it in vmci_transport_recv_connecting_server() where a completed
>handshake transitions the socket from pending to accept queue.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> include/net/af_vsock.h         |  1 +
> net/vmw_vsock/af_vsock.c       | 10 ++++++++++
> net/vmw_vsock/vmci_transport.c |  3 +--
> 3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


