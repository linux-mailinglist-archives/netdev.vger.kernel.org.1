Return-Path: <netdev+bounces-285231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIfPC8Nq/Gn0PgAAu9opvQ
	(envelope-from <netdev+bounces-285231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:34:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8230C4E6D68
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DEF1300FC4D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10983E8C59;
	Thu,  7 May 2026 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXATEYnn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GryFukaL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D23E95A9
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150071; cv=none; b=OmxlS6Ctaoei58cgO1QLZ6N/0IQm7FTAggYeDkpWVCZJj0GEasgCSxp4FMvxv6PUGmnM/+EEMQDmIgO0z24onZptC+sfnkI6ihmLCtRwMnv4cLCVyNVe+euKCVDUCPNeRtsS6NBc9tiz2DDpRKFWu9OAyR631AmeO5tjMJf41S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150071; c=relaxed/simple;
	bh=Gwjd0XD6/QbMMm4Izy0RkPLTGA2CEqD3rsj6B1S4mP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX2aRY6x0BHlpVV6/dVAWA/X0VZxksEJpM/Y8EYKIJUnXDdqzzgJlgXfjsdLvOEkOBGJBjH+eTWdsn6njR9D1m3/V3fmCzbO6Wkha+oPYZXQZJjXLYS0aOjlFmJ7smUISIth/tzSXCO8P+OuEYRKckFZLa9T4HfN2YAxv2L5vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXATEYnn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GryFukaL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778150069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kRzfpi6h8be8cBkbFeSW4gWzrbliYroPfK4BwMv/Uw=;
	b=NXATEYnnQSZMEzrR5EIt1YGyxHOknbpvbrQ/Ejpydgte5KRq9IFY089JLIELmrFOikQIW4
	sQkaRUlal9FEA5uvpg6bLUBDzOMSTlqXToaQWklvg4k7WrEB1u4gavYZ8KTVq3LOijVEpO
	bs+GPN8Qb1COcLFjGbbnE8HVf366CNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-tGXf7MMrOEO4nfczGwbj3w-1; Thu, 07 May 2026 06:34:27 -0400
X-MC-Unique: tGXf7MMrOEO4nfczGwbj3w-1
X-Mimecast-MFC-AGG-ID: tGXf7MMrOEO4nfczGwbj3w_1778150067
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d121738feso5715515e9.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778150067; x=1778754867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kRzfpi6h8be8cBkbFeSW4gWzrbliYroPfK4BwMv/Uw=;
        b=GryFukaLoqiy8mFOGmiL4v6b05m70gJvPUioRBAQfdiA7/js7XsSguEtiBnSqgh8wn
         ALgwJDgy9uII+67ylUf0gEGT4Tv2M8tmCGGxGd9MkKVeyR8d1ofD0oeBGSxdunlJS2m6
         sSVFe6JlhUue9mEdYR69fNKFAakcdvtn2Haq+qnjjpfUl94e7H7clHOcij4PDss8+4GH
         0sqCUkNKSrtOnwEFeu3rhU/qjARO1oVmTzNijKR0xCSrB6O2iXLMnw4seh5tSR44Lcjz
         u6ZHTG04S53a63hLdDUnm2bow01Yh+X8W4LDbBkBfjTMeKU5N4toGG+UomlZovGAeBPt
         UyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150067; x=1778754867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kRzfpi6h8be8cBkbFeSW4gWzrbliYroPfK4BwMv/Uw=;
        b=H91VU72uTR5344iyeP0Q0ohJp65j33tuqlu9pOy2Sxf60Zla3w8BODd13l9YJxT4VF
         YxNiDjcY6HEE4ew7krNHmqktTyMvLGu0ys/M4NO6vME2JNfnPhhxajwVvjebiqwk+8Vk
         WxIHg2zXGvqA/u3E/bpXhvGFzlcx86ShUsr8KW/wFXLkzg8GKw0yvF19IAAlzbqXPEj8
         VLvvcBQ4exwhCsAtLYyHik4begjFvCI35fvqKhR7tcw1ZMvnD4/bQB9EK12QGtM6AdYM
         mkc4rF/8btSDmnvUW7AsUILue/eMFh5SaCzHQ/3P7ZrONNC7SIGpwS9XWlA0Q/WllFyZ
         1Ncg==
X-Gm-Message-State: AOJu0Yxj6DttAEpR48ua3zFO8ecoTkSiUwwukGjju0x8HSQ1WICZqSYx
	8YvF89OnPad7lzkRJoz0MLdh5x+NEqPZalUdXKIDGRvCySHsaMMuuO7BMIO+01eslUySKiLc1hD
	qCW13sJ/0HICVnFq8dtBZrdp5aOtbY+4qqryXjZXCqv9BBR+Usgm549Rxag==
X-Gm-Gg: AeBDiesocBtmsDn+Kinx1M81Ey546cfsZ9jZjl8fdmWU+OYkoIyw8baGXyzdsnzep5k
	Kc54Ej6jJt4njsvvxaOuPJaFb0f5wzxLJSztkxWKYaUatthXDMMjHV6qUhfs/OG3ZNoloD9mA3W
	cIDPd+0zc6RbBw7hmblYGJom99/HBzjfCt/BKbmIUHjDILBXk6UV4b+f3b947Bt6zLVje0lQ8Ee
	lyEF0nNxmPL74O2E5/HuCMTh3wirnbPJz7hX8LvbwhJHEenS0RZCAtPD261bQhtv79hrpt4MvFV
	VFOsEjp0oTM/xUo59T5IrKLcgoC7UrDsYXu9ovFwUZqEHNAGe4s2vdIU6CTMiKpx8vXj3XpN7pY
	T4oGEnfinkIeYqUXx/QLsKx50PLsb47s3Zj3eSbA2luXiZU5rNC5gQOjzQQyM2rKKrg==
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48e51f4652fmr124504025e9.29.1778150066549;
        Thu, 07 May 2026 03:34:26 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48e51f4652fmr124503325e9.29.1778150065969;
        Thu, 07 May 2026 03:34:25 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm20028528f8f.14.2026.05.07.03.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 03:34:25 -0700 (PDT)
Message-ID: <6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
Date: Thu, 7 May 2026 12:34:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8230C4E6D68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-285231-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On 5/5/26 3:42 AM, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> fbnic_phylink_create() stores the newly allocated PCS in fbn->pcs and
> then calls phylink_create(). When phylink_create() fails, the error path
> correctly destroys the PCS via xpcs_destroy_pcs(), but the caller,
> fbnic_netdev_alloc(), responds by invoking fbnic_netdev_free() which
> calls fbnic_phylink_destroy(). That function finds fbn->pcs non-NULL and
> calls xpcs_destroy_pcs() a second time on the already-freed object,
> triggering a refcount underflow use-after-free:
> 
> [   1.934973] fbnic 0000:01:00.0: Failed to create Phylink interface, err: -22
> [   1.935103] ------------[ cut here ]------------
> [   1.935179] refcount_t: underflow; use-after-free.
> [   1.935252] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#0: swapper/0/1
> [   1.935389] Modules linked in:
> [   1.935484] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-virtme-04244-g1f5ffc672165-dirty #1 PREEMPT(lazy)
> [   1.935661] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   1.935826] RIP: 0010:refcount_warn_saturate+0x59/0x90
> [   1.935931] Code: 44 48 8d 3d 49 f9 a7 01 67 48 0f b9 3a e9 bf 1e 96 00 48 8d 3d 48 f9 a7 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 47 f9 a7 01 <67> 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 46 f9 a7 01 67 48 0f b9 3a
> [   1.936274] RSP: 0000:ffffd0d440013c58 EFLAGS: 00010246
> [   1.936376] RAX: 0000000000000000 RBX: ffff8f39c188c278 RCX: 000000000000002b
> [   1.936524] RDX: ffff8f39c004f000 RSI: 0000000000000003 RDI: ffffffff96abab00
> [   1.936692] RBP: ffff8f39c188c240 R08: ffffffff96988e88 R09: 00000000ffffdfff
> [   1.936835] R10: ffffffff96878ea0 R11: 0000000000000187 R12: 0000000000000000
> [   1.936970] R13: ffff8f39c0cef0c8 R14: ffff8f39c1ac01c0 R15: 0000000000000000
> [   1.937114] FS:  0000000000000000(0000) GS:ffff8f3ba08b4000(0000) knlGS:0000000000000000
> [   1.937273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   1.937382] CR2: ffff8f3b3ffff000 CR3: 0000000172642001 CR4: 0000000000372ef0
> [   1.937540] Call Trace:
> [   1.937619]  <TASK>
> [   1.937698]  xpcs_destroy_pcs+0x25/0x40
> [   1.937783]  fbnic_netdev_alloc+0x1e5/0x200
> [   1.937859]  fbnic_probe+0x230/0x370
> [   1.937939]  local_pci_probe+0x3e/0x90
> [   1.938013]  pci_device_probe+0xbb/0x1e0
> [   1.938091]  ? sysfs_do_create_link_sd+0x6d/0xe0
> [   1.938188]  really_probe+0xc1/0x2b0
> [   1.938282]  __driver_probe_device+0x73/0x120
> [   1.938371]  driver_probe_device+0x1e/0xe0
> [   1.938466]  __driver_attach+0x8d/0x190
> [   1.938560]  ? __pfx___driver_attach+0x10/0x10
> [   1.938663]  bus_for_each_dev+0x7b/0xd0
> [   1.938758]  bus_add_driver+0xe8/0x210
> [   1.938854]  driver_register+0x60/0x120
> [   1.938929]  ? __pfx_fbnic_init_module+0x10/0x10
> [   1.939026]  fbnic_init_module+0x25/0x60
> [   1.939109]  do_one_initcall+0x49/0x220
> [   1.939202]  ? rdinit_setup+0x20/0x40
> [   1.939304]  kernel_init_freeable+0x1b0/0x310
> [   1.939449]  ? __pfx_kernel_init+0x10/0x10
> [   1.939560]  kernel_init+0x1a/0x1c0
> [   1.939640]  ret_from_fork+0x1ed/0x240
> [   1.939730]  ? __pfx_kernel_init+0x10/0x10
> [   1.939805]  ret_from_fork_asm+0x1a/0x30
> [   1.939886]  </TASK>
> [   1.939927] ---[ end trace 0000000000000000 ]---
> [   1.940184] fbnic 0000:01:00.0: Netdev allocation failed
> 
> Instead of calling fbnic_phylink_destroy(), the prior initialization of
> netdev should just be unrolled with free_netdev() and clearing
> fbd->netdev.
> 
> Clearing fbd->netdev to NULL avoids UAF in init_failure_mode where
> callers guard by checking !fbd->netdev, such as fbnic_mdio_read_pmd().
> These callers remain active even after a failed probe, so fdb->netdev
> still needs to be cleared.
> 
> Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Note that sashiko-gemini spotted a pre-existing issue:

https://sashiko.dev/#/patchset/20260504-fbnic-pcs-fix-v2-1-de45192821d9%40meta.com

does not block this patch but could deserve a follow-up.

Thanks,

Paolo


