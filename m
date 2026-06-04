Return-Path: <netdev+bounces-295168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0UOQF4BUIWr/DgEAu9opvQ
	(envelope-from <netdev+bounces-295168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:33:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27B63F11B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:33:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="XfHD/mk8";
	dkim=pass header.d=redhat.com header.s=google header.b=qwcSBavr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295168-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4C7311D13B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B437C0FC;
	Thu,  4 Jun 2026 10:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A9377ECA
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:23:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568587; cv=none; b=P27EuGo6a+4QKCJVqO5x8+uCSPUK10bED+QpCuFULILPgJMx7mjRf+UbJ6dC5QRSWctjIfjJtTj9knyVq76ZHtghyQKLXQfAg1HRkIqTnRbv7Qaun8WiGwPEUVElEWRdZPozSIPfrdxIn1UftQ52Ud5AntfZLBD8fR1NccVxf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568587; c=relaxed/simple;
	bh=dixIwFWPM7bAvzVEPDaLhO8cb7WbN6pEYPVYYsaOzkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+LmGlhYxzW7EUMKI6GrELyyqj7pwfUHxhvs+oosr3ToxBqYmQ7xUV/5yjEVRlGljpqR4/an30oxJjp1z/FEd9IbN9bwv75rc89OoN8Jv2CmvCGujOroZN1yKNHB6W/9L5zevkm1mGjFBlyyNVeu4Lvr1kkWuamht+ArGAhMeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfHD/mk8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qwcSBavr; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780568585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+5l/h/t7hfKlD/idoyfI2FiuQnGpbz/XljJ2mR74hI=;
	b=XfHD/mk8nNFXePoirKAvRuztt6J3X0q05jgAwJxNrC08F/uTqhr7QvQGxxW8lQQa7YqTdp
	a8Okmw3Xr2r5+azD4IwX4yeSyh+GlPXYwLzpteiT/3o95rnQ012oVoAwJho1y+HT5L3BQL
	GWkR4mx9ufrwjKMPdjW6HwjoLmUMYVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Q9Tk-ZpRPquzF_ofUnC0yA-1; Thu, 04 Jun 2026 06:23:04 -0400
X-MC-Unique: Q9Tk-ZpRPquzF_ofUnC0yA-1
X-Mimecast-MFC-AGG-ID: Q9Tk-ZpRPquzF_ofUnC0yA_1780568583
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso4656675e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780568583; x=1781173383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+5l/h/t7hfKlD/idoyfI2FiuQnGpbz/XljJ2mR74hI=;
        b=qwcSBavrdWJ8rTb2XvFl/nZc4mw7E0UmKQuxkFc68RgZL3eJGawcEa7911EfYTnHAU
         4eQ2OqyZepD+j+xrD+uDKaPMsGgNIk1b2//vqwkvvjDUXFsXWG99ZZAxSbSuKU1bgrHH
         PgstmLPJwxqBmqL6HsUdcFJFgxaaHKxwZBwbMF5XsmdN2QFIiPIY7Qfx9c3/IsNrxTaK
         KkucHDh7MB9N+HQn0xfx7iqcJC6Jt0oz9ZkaUUEKMa1oslLZohI6KMkQkarJMh8TzaUx
         5f61x0/1JUWnn9HoZOsBvDq3we+sgWoASbUNX7J1NZq6Bk5hNPJOm0lNbo7q3Igd1qFk
         cOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780568583; x=1781173383;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+5l/h/t7hfKlD/idoyfI2FiuQnGpbz/XljJ2mR74hI=;
        b=PtB9nywuXeW5ftJeYhOr8FAOQYerGdyIhExKkNUyJn04XrA+M3yultFim6rkhqlRre
         MAi0r7m2whcU8U7RNR+p0g3r36BSETZDIQgbWgbVbqQFHMemcxJk9g5JvbVnOOH/hNZr
         mTd7b6OOv98/6ani7o6jnPazmZH6oJZD3oBQh2lJQmhm0Q0rpbWI5wOtSsZo/Jx3gtVa
         ePYBh9zOUa3OqRLz39r3m5EJXyvOwsl+YuFnS2RAJxRUquF4DmhHdkb4AIyqn8onKzjv
         ohG+bK8eWC90LkLO4/LKZpW/q46JFbh1E+NNFj62GyEAVd74AhdHHWJzcZphSKy1WjzK
         CgpA==
X-Forwarded-Encrypted: i=1; AFNElJ9giZEx5aFauhdmSbf3m9RVWKf71PJ9IsDhSnoF3FjZ9chux5JU0drkEX/t9Jj8B8esJ93tb+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKl5/vqhCC2oNp2GDZFnFpiOLkZFPq6cuDOMbuHaBvj0YiByG
	6bi4lEacXTeWBrkR/eStU0zLVukQfoFs2zreW0nJPfno6Kjcw11rYYD2FgpOtCnmhy780BYhs0E
	DoYfJLExF0fTxU25lACbk2U+WJvtXkspmmfjqPhmXuTfqqtoN9/51Dzsk8g==
X-Gm-Gg: Acq92OHZdXQglI/7QTdjjwZGj/qxtEJh319aTcgjy33/swdt4ISMzeCidTzgqETDGi2
	/Fhx8UFPhLrUBJem2l68FzPh1RlS3ovbxS/QNy6h1SAEUjGCxaBfJScMNzGsapJ4Me06Y4NPCgc
	DId4KbGpUIGYKPpU4M6oNdZdYDjqM538v31KZH6+PmO21ntHi7x7joa0o3xWYLpMICU/tx3n5bJ
	+QPWgGwwaiB7GXYvzfcsHwPsCLwESGf2EQshnizY4DbjerQOQRtf9sipn+XAG06ovsZoz6t7AsD
	JikGCeX8snTOIIDoaTPXq8mKJ2Rp7QVnhJi9QL1AL/mls+FgKy2F4K0LmrYXepWR1ovWJZNy/M6
	CsJzoMO0z7roTmHKO3Z1pucu9cIwHNe1SQ1+F6ua8dzS4FSnsyIYZHmt+gFBAOn0cKJM=
X-Received: by 2002:a05:600c:468d:b0:490:b2a6:8c1d with SMTP id 5b1f17b1804b1-490b5ea3529mr126923435e9.10.1780568582755;
        Thu, 04 Jun 2026 03:23:02 -0700 (PDT)
X-Received: by 2002:a05:600c:468d:b0:490:b2a6:8c1d with SMTP id 5b1f17b1804b1-490b5ea3529mr126922705e9.10.1780568582153;
        Thu, 04 Jun 2026 03:23:02 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm72928255e9.9.2026.06.04.03.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:23:01 -0700 (PDT)
Message-ID: <a0178564-a7a2-46d8-afc0-636f027c31b6@redhat.com>
Date: Thu, 4 Jun 2026 12:23:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 net-next 07/11] net/nebula-matrix: add intr resource
 implementation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org, horms@kernel.org,
 linux-doc@vger.kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, enelsonmoore@gmail.com,
 skhan@linuxfoundation.org, hkallweit1@gmail.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260601093149.25905-1-illusion.wang@nebula-matrix.com>
 <20260601093149.25905-8-illusion.wang@nebula-matrix.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601093149.25905-8-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,linux.dev,redhat.com,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-295168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD27B63F11B

On 6/1/26 11:31 AM, illusion.wang wrote:
> This patch adds the nbl_interrupt module for management of driver-private
> MSI-X indices, plus hw_ops callbacks to program the function MSI-X mapping
> registers, configure MSI-X info, and enable mailbox interrupts.
> 
> Key interfaces:
> - configure_msix_map:   Allocates driver-private global MSI-X indices
>                           (interrupt_net_bitmap / interrupt_others_bitmap)
>                           and programs the hardware MSI-X mapping registers
>                           (NBL_PCOMPLETER_FUNCTION_MSIX_MAP).
>                           The actual PCI MSI-X vector allocation is done
>                           by nbl_dev_alloc_msix_intr().
> - destroy_msix_map:     Releases MSI-X indices and tears down the mapping.
> - set_mailbox_irq:       Enables/disables a specific mailbox interrupt.
> - configure_msix_info:   Programs PADPT_HOST_MSIX_INFO and
>                           PCOMPLETER_HOST_MSIX_FID_TABLE.
> 
> The patch does not use kernel MSI-X allocation primitives
> (pci_alloc_irq_vectors, pci_msix_alloc_irq_at, irq_domain). It manages
> a driver-private global index space and programs vendor-specific
> MSI-X mapping registers.
> 
> Note: Mutual exclusion for configure_msix_map, destroy_msix_map, and
> enable_mailbox_irq is handled by the dispatch layer; these functions
> assume the caller already holds the necessary lock.

Adding assertion based on mutex_is_locked() would make the above obvious
and will prevent locking issues.

/P


