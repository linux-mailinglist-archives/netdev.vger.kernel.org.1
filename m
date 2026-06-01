Return-Path: <netdev+bounces-293640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAjRFi1RHWpfYwkAu9opvQ
	(envelope-from <netdev+bounces-293640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:30:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54261C72A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C56B9301E987
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F33909A7;
	Mon,  1 Jun 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HikTJyRO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB6Y4NFH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF693911AA
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305966; cv=none; b=pMczPBpYzcOIfx6eznhDbBwC4yfsVY/FZzFRtuKyd6VSqU1vXyIbp6k8Px8e4LJnKCpIyVAzD9kXPKkkQYMkT0pEEhZ3b95MU2InQ4Wfnx4iSOGFpZSTSM2vYXMtPvir3yTJERXMAI8z6i+q4J5i7yCSWuQml0FC/2mm1PpxkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305966; c=relaxed/simple;
	bh=92tjw0qOeTMiu/O2oXMKbRtKwgW0ttd71f9F8miPIDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LL84L5ZE8sE04QrsB5CPL7kZabrAYwilQukxgFYsYnJrNAQdN+KUaUO/LKEoSm5/dnGX5Zs2fYPmIv4v50efwKyZekGTlR9o6tBu7wPhK4+vulydJ1IyX5fut9Ca7VfEhMKLGlbOaEKORwriGJ1IoV1I7jNmRacsnyq8+dWJ/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HikTJyRO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HB6Y4NFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780305964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
	b=HikTJyROfwiQYpaYqEDFYZxdvCzsY08WtXRqPXvYMhz6X6ykyTteuqOpspCpCd6Yt1pJJI
	V1jef8kxjQW4Xn6WhzcD8QH8L6nKhWa03gL+THy1W+oGhIN5xOWKWIMQXTQbJ2npQUMCms
	8XzqikMWEX3/h1G4uXASiFlX1ieCE0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-bTrbINFJONqRY5388A4MHQ-1; Mon, 01 Jun 2026 05:26:02 -0400
X-MC-Unique: bTrbINFJONqRY5388A4MHQ-1
X-Mimecast-MFC-AGG-ID: bTrbINFJONqRY5388A4MHQ_1780305962
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so1192287f8f.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780305961; x=1780910761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
        b=HB6Y4NFHNixrbjzXBkgd4id9xC8TXSBSqDB0E9UtM1J0owEVrFX0QKTuHvFsFXqo2w
         zpcSx+J0QYeDeoTs9+fTjcs8ccAgDsU5XM1TS9FjPDOrkn2RcEYVmYDDkzvPjGUUGucx
         ++H0P9OcwiODjy453xYQmietUatsbStAwAMNDhY99HwEcGeD/nthRNV5BSYme3sQ2QFB
         dUka6Azfve6XzeHnvJlvW45jbgZ5WwPfLVo3zAikbzRVCOEi5JTq3jmy50DO0f78t2jd
         ym7vwoKrfuWR034xx+9k09x8QKjjsUwihWUVzOUYvhAWkWEFO9F8ljHaQkL4qPF8QXOw
         LNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780305961; x=1780910761;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
        b=DrQBvdWmXWVs6OAx15EOazhJzeLbk3YUZBs9T29ZJNhGDCLFpefiFq6xzOfk+VVUDT
         z7qZ86oh/LofJSuJ12ndOmvqt9HQbGb1FvjplEpTttvBMphEFfLEjgYvV5JUSDL5A82e
         dHqZ4jgdUdOKLUM9ZJMXDsSbL3jj9tuuOS3Jt5ktSUg9nhOn4d45vL8vcu3FLAJHMRQd
         2GjMn4N5x8SI2W8/dKlHsA8hrWv7CBmLuYuEoDiPR1zSkkQWM86K3B09g7/fREhmubl5
         XqsSjbrZP8WHBjaw27MOH35Q2LfDP5ennka/3KsG+CFxTZYaAWw9mj0uYd37gbe5gxYJ
         ++hA==
X-Forwarded-Encrypted: i=1; AFNElJ+JxbMy1hflVMLmYUkumWLvtODMu7cyx8rPT6BsujMSQEDRRzfj5mcdPMtFA4P5cMsCMoiM8pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZJq2RPDFrmBdMH4eQXZqegOYCU0w2jfQLHKJhamxmxjCVGLq
	OT8cBLdvNGFrcp7l1ZM5sA6JKekc5P/u9CYCW++RQa3LKiJUCBIj5vag299kzwO4Df6h/sRqubs
	Kp4cxbBgww85hElzGz9bL16w8zSvwTo3dpQ6j+EnlrhgwYeMmVUPFg3sFz7d3J4+sHw==
X-Gm-Gg: Acq92OFLDWtd7nYUh1/8YhyyB8/1TPIeyi33pIV2qckm7G6XxyQLegiuevDnYOH1HO+
	tibbRWqUeMYIBwlkTlTDvM4zrdRsFC26ipX/wnyG5j2xeewSJ8/3fOpVy/ieXDm6YcH/7A3Wce0
	k+OE/wppkY8ep9S9jHVEdtDKCx2vxcTavYikdzbOcNvQWNFjET7yJnjb3G/6VD9tw0+QDI4wQQA
	sLXOjJJKQX21wP04LWFxTQBvxOwLxh9Ai0uqgL+Ps9knn00iMcga3uU7nkFaApy+zfHD/Ki/Xi8
	pPXklVGmMdKZ4cIOa3xQ70dmW4dDwFH6UzyqqRRp4ZjV7XiZ2ByC/WebX2PsWHVERVxrFqTtqUX
	fQbqNdjEC7nE0kAVS0NeZDVdMw74mZQUpiis0ut1DS7K8ndagogKJD4Q5J4eeoX7pGHH6
X-Received: by 2002:adf:ef12:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ef6ba1e31mr13765424f8f.37.1780305961534;
        Mon, 01 Jun 2026 02:26:01 -0700 (PDT)
X-Received: by 2002:adf:ef12:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ef6ba1e31mr13765397f8f.37.1780305961103;
        Mon, 01 Jun 2026 02:26:01 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35598e5sm21777598f8f.27.2026.06.01.02.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:26:00 -0700 (PDT)
Message-ID: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
Date: Mon, 1 Jun 2026 11:25:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
To: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: sgarzare@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org
References: <20260526104356.469928-1-rafdog35@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-293640-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE54261C72A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 12:43 PM, Raf Dickson wrote:
> When vmci_transport_recv_connecting_server() returns an error,
> vmci_transport_recv_listen() calls vsock_remove_pending() but never
> calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
> permanently.
> 
> Repeated handshake failures (malformed packets, queue pair alloc
> failure, event subscribe failure) cause sk_ack_backlog to climb
> toward sk_max_ack_backlog. Once it reaches the limit the listener
> permanently refuses all new connections with -ECONNREFUSED, a
> silent denial of service requiring a process restart to recover.
> 
> The two existing sk_acceptq_removed() calls in af_vsock.c do not
> cover this path: line 764 checks vsock_is_pending() which returns
> false after vsock_remove_pending(), and line 1889 is only reached
> on successful accept().
> 
> Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
> the error path.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Waiting for Stefano's feedback - should be back in a couple of days.

> ---
>  net/vmw_vsock/vmci_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index d2579380f5..88ccc55455 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -980,8 +980,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  			err = -EINVAL;
>  		}
>  
> -		if (err < 0)
> +		if (err < 0) {
>  			vsock_remove_pending(sk, pending);
> +			sk_acceptq_removed(sk);

I'm wondering if sk_acceptq_removed() should be bounded in
vsock_remove_pending() ? (even if that change would probably be net-next
material).

/P



> +		}
>  
>  		release_sock(pending);
>  		vmci_transport_release_pending(pending);


