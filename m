Return-Path: <netdev+bounces-121993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD395F805
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D0F1C22360
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15151990D8;
	Mon, 26 Aug 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rde1H0oN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC851990A7
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693128; cv=none; b=VpsvnpJT/pFoJlvXeaJEDgQlSmf1+d8x2IEDE/eSQQZeHUuIfGb30a8P0y5cUF+Q22Qo1erg2jtE6rvVAl7wd+ehp2VkaRyOdVfA5trDBP2KbBV1mw1rA49W9wlWs54ryyhbNhS+22sRG0lrgj5rZRA0Kw7su9ns+eUnNmTIjNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693128; c=relaxed/simple;
	bh=W2PyMWGeYMt5mFrtf2WUppfjyANqe3Y8QOGyt+ELaEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nznZaGDHJPMkqqoJdKjGrK2ymy+yMxYOlggQNXMR/UCSwrnBdsA4kRfKYSseXhBdJzZMzYDTUuAa28aaQOlwp8tfGrRJf1eOsMI8ICvS+bECdXSGz8200Kkrp4OPm85v/gFWfp7dle552pRGqSInj8crki6RLmxNff6nWMgc3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rde1H0oN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724693125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXB9I1RDogYdka/7ESImEOew6DkiGl3Ct/MkOkP43JA=;
	b=Rde1H0oNgl+03xwCxWKT5oTFe9AwwPqxInuXzWBqysjlVI2XBxZ+McdllxwqLG4H8Ehe/2
	60Ia8fcpghw4kfedWyZLdt9Ed//f/T8olh6jYgti5IoQWR+kbK5rKyvGwt8oxo/rutj3yl
	k851djUFTOWmWgPcgABTwf+WGsHxovo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-2oUSde6qMP2wPGEjLW28MQ-1; Mon, 26 Aug 2024 13:25:24 -0400
X-MC-Unique: 2oUSde6qMP2wPGEjLW28MQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427feed9c71so7193235e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 10:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693123; x=1725297923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXB9I1RDogYdka/7ESImEOew6DkiGl3Ct/MkOkP43JA=;
        b=bHsXKY2/qNe+9zf0gZ5ALfjFfAlzAyYew5MTQT7yThmxwaHnVGFCQipiWLvRBmLS68
         XTtRCoOvixiD5TPJxYjcpmyYiyqZyzvgriSrm7HFRcvRk2znW+yIrnlR1x1L97rlNOKG
         YCiX/aNO5r3YtTNXz3enGqVN2QvXmR+WtDF+6nxf3Xy8taWWhQOBhikCa7ZI3h+/FNEZ
         PBv48KtVTbP1kdZ3eiX5VwF6iDJBitpkHePcRwJA0yk0Rn1zeF00EEgyfiS/FCHRyk++
         Ig0kg8CSHR8AGjpABxxylBIqcRVKvBjobNK+pI6ncg31uhseZV2wkm4J8P/AcZn5AYOw
         /g9A==
X-Forwarded-Encrypted: i=1; AJvYcCUi3uVoMi7JOhldDAhdqK9RsjwTmi/qPJPwmrRyvSWfIxaNWPkmFo+Fbrd6dkNffmVO1CSSqTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTjZsGMt9y1xZm27Kl0ysjmbhjN4RO7DA/oUD2kmE1a/MPRov
	8JhqyA+B17v7AxJxzZCsYD54rc1w5T1r13lwuwpLPEUVIk81JqGmlaoI1OkDMB1XNcm9LZdOEj2
	XCXE0Zf90pXBCCNPKcYkX28hnRV99mhZtdyTzxChxgD3vamtvek65BEQMMiuy2sUFUoPcj6RHU1
	QHXZr7OaovaP7hyVqsQ+FRCve2qn2g
X-Received: by 2002:a05:600c:3ca3:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-42acca0c1c8mr45894755e9.4.1724693123149;
        Mon, 26 Aug 2024 10:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyo+gPmcRRqLioaJdl4QFYbOq6EHctF1LM1UYeexkm0D8aNQrr/L+i8vEQVt4zZEV1IJ4ZrHk0TmltECafqh8=
X-Received: by 2002:a05:600c:3ca3:b0:426:6358:7c5d with SMTP id
 5b1f17b1804b1-42acca0c1c8mr45894475e9.4.1724693122031; Mon, 26 Aug 2024
 10:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821160640.115552-1-dawid.osuchowski@linux.intel.com>
In-Reply-To: <20240821160640.115552-1-dawid.osuchowski@linux.intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 26 Aug 2024 19:25:10 +0200
Message-ID: <CADEbmW3kk6bfn0BFz6g5FPEPg3gOnSXW42r53K27RsKF53pi9A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] ice: Add netif_device_attach/detach
 into PF reset flow
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com, 
	larysa.zaremba@intel.com, netdev@vger.kernel.org, 
	kalesh-anakkur.purayil@broadcom.com, Igor Bagnucki <igor.bagnucki@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 6:07=E2=80=AFPM Dawid Osuchowski
<dawid.osuchowski@linux.intel.com> wrote:
>
> Ethtool callbacks can be executed while reset is in progress and try to
> access deleted resources, e.g. getting coalesce settings can result in a
> NULL pointer dereference seen below.
>
> Reproduction steps:
> Once the driver is fully initialized, trigger reset:
>         # echo 1 > /sys/class/net/<interface>/device/reset
> when reset is in progress try to get coalesce settings using ethtool:
>         # ethtool -c <interface>
>
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 11 PID: 19713 Comm: ethtool Tainted: G S                 6.10.0-rc7+=
 #7
> RIP: 0010:ice_get_q_coalesce+0x2e/0xa0 [ice]
> RSP: 0018:ffffbab1e9bcf6a8 EFLAGS: 00010206
> RAX: 000000000000000c RBX: ffff94512305b028 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff9451c3f2e588 RDI: ffff9451c3f2e588
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff9451c3f2e580 R11: 000000000000001f R12: ffff945121fa9000
> R13: ffffbab1e9bcf760 R14: 0000000000000013 R15: ffffffff9e65dd40
> FS:  00007faee5fbe740(0000) GS:ffff94546fd80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000020 CR3: 0000000106c2e005 CR4: 00000000001706f0
> Call Trace:
> <TASK>
> ice_get_coalesce+0x17/0x30 [ice]
> coalesce_prepare_data+0x61/0x80
> ethnl_default_doit+0xde/0x340
> genl_family_rcv_msg_doit+0xf2/0x150
> genl_rcv_msg+0x1b3/0x2c0
> netlink_rcv_skb+0x5b/0x110
> genl_rcv+0x28/0x40
> netlink_unicast+0x19c/0x290
> netlink_sendmsg+0x222/0x490
> __sys_sendto+0x1df/0x1f0
> __x64_sys_sendto+0x24/0x30
> do_syscall_64+0x82/0x160
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7faee60d8e27
>
> Calling netif_device_detach() before reset makes the net core not call
> the driver when ethtool command is issued, the attempt to execute an
> ethtool command during reset will result in the following message:
>
>     netlink error: No such device
>
> instead of NULL pointer dereference. Once reset is done and
> ice_rebuild() is executing, the netif_device_attach() is called to allow
> for ethtool operations to occur again in a safe manner.
>
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
> Changes since v1:
> * Changed Fixes tag to point to another commit
> * Minified the stacktrace
>
> Changes since v2:
> * Moved netif_device_attach() directly into ice_rebuild() and perform it
>   only on main vsi
>
> Changes since v3:
> * Style changes requested by Przemek Kitszel
>
> Changes since v4:
> * Applied reverse xmas tree rule to declaration of ice_vsi *vsi variable
>
> Suggestion from Kuba: https://lore.kernel.org/netdev/20240610194756.5be5b=
e90@kernel.org/
> Previous attempt (dropped because it introduced regression with link up):=
 https://lore.kernel.org/netdev/20240722122839.51342-1-dawid.osuchowski@lin=
ux.intel.com/

This v5 passes the tests that the previous attempt referenced above failed.
The patch looks sane.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


