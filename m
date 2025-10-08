Return-Path: <netdev+bounces-228180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BBBBC3E61
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5513A9CAC
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082B2EAB9F;
	Wed,  8 Oct 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktdaglsx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E772EBDDE
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913071; cv=none; b=GWrPdkaErSEvwyrwPg7V5TaaDBi3SGUr7VP9jmD0Y1KLBpZ062gJwoZBjqktWfl0MuQ7ajtlGvzvVLQj4MbCmXBs7yT3vHYBVNSt7AK4aiOkTbMWDEhOeliWfzANnYR/xwSktZkBMUfGCNtaQ+ywo8Et9MImX9p7JygwQz6DGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913071; c=relaxed/simple;
	bh=jQ2r/rcCQFyp8n0GePqoko8xfZQFPXQULeRJ6UtUvkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGuQldesBZE/7oBNqNLIUWrVbuqf2O25r+QVs2THk3ThQFe2vuPylBhDVdiOrr/3B800viqdl7Dj+66XibEd3JDZzzCf2LbnA3lEWe2r8GP74B6Nd8eQBZSNrDHavYUDASzL50V6Twkimj2pvwnr11oreRCNUKi6a/AqbdUAoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktdaglsx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e06163d9e9so72041571cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759913069; x=1760517869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlSjJCs7A1ERmjbEvfSkW/CmM7q/PE2PcmG+9t+wYEo=;
        b=ktdaglsxeMCjhkJ9+ONSTubAFmm8u9Di0puasIn/s17303NJ3557Pedm2p5Q8pNsZf
         4iMw1gVGnTnvipne6Ij4jJBdaT1b936xRAi1aZ249OJS69uH6oX6zt23fjllNTgU+Dvs
         2Fx/sx1XLwnBZ+dGOjtIOVPhcxyTSesq4QPFKA3ls9Vs1EePYDfp2oOaXyF3HhREw6J2
         i/9iJnSKMJhvkqrH2eOdFinyM44fFRKsNANv34YHdLpFnuGMggZUzTzkaPxMrREmCntd
         I/SmgPOG2PLAnsJmHhGw/YUe8E+Jn8vOO/K1bEokHw4ARrdMuDqoEisDVZ6ooufHQWFs
         /gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913069; x=1760517869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlSjJCs7A1ERmjbEvfSkW/CmM7q/PE2PcmG+9t+wYEo=;
        b=WmlB3j2WKEt5Lya7BPqGzbJPgCxvJp3kPs6UE7moGtC2F+NmRFqeg+vnQjjd/1Z6jW
         UY3YzCC4LIb7X7O7OXpJjXKXd+sQtTn7K1NgO2a5VpI+2ClY0Knzw6bu5TWxwOwJcjzN
         VG2ymBsU+4w5vnFwMeliWt8C9jaMD7o3dIWjDsp1KQgw2xMQva0R6iJgNYEJTt1zYX4l
         WW4kXsZ9t5ONEqH6z/6jg+xV1YVDjG71IG7Qp+2nYriUJFhZ61jZuIvFAwgIVAZwR1EX
         kuRI180FAJzxB1HGk1iIKADyicRPyPjLFZwXWOKCEJsKCmM/3wUNR6PNds0La1G3ueOF
         SIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXELAiMXQ62auYdOqodvdD6X6oeWvDXze3O8bKViznpGWhnA8OfWiWwE9rGg7Grsh6SNkvkR2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91QXTroNtAbGdjsecxtmCwPu+rmgxcRsENGeOs7SOYFY069DS
	xcfi/B2AGMYIzpI0Au/j5/L2lyJ0PRlTiCih5AOjb1+2YCGpV3ZN/r9/1VUnR0BXAtEiuHRbRSV
	U4mwjlvAfgUu9JMn4H54BPMOim/CCOjCIqDnFiduI
X-Gm-Gg: ASbGncsE+GhpygoefoAI+NNeLVG3EJ1B9bQQrD2ea1NH4QloITdOqJ+DbnVl6FievJj
	K+5rvN6PZKhCn63fqZJoiM3mtmIjfE1HZWIkE7Zh9UXXP/TnkN/UlxXiWL7kXm9tmV1+V57dI+g
	VYf7BV1/y7up1Bo7y6ulfz7jOafj048rVV60VvKqm08oMJ2q11VImrAuk2ijR9EIT/auEPQYcnG
	dXoilAN75026sZMw33Pv9NCCDVLrBNBcgA3KlQ7EugQkeUCaAjuF8RF466ZrIeHIWBRqywe56Wp
	SAU=
X-Google-Smtp-Source: AGHT+IH6T8Z0phHUrkW2LYomzcuIMTigkC4dYVy2h9gd9Ou0VM87Kj2q+2642RYcQOs3k9cE8zHQiNe+PBbwdD28j0U=
X-Received: by 2002:ac8:5914:0:b0:4e2:cb29:22c6 with SMTP id
 d75a77b69052e-4e6ead46a0bmr35675251cf.53.1759913068856; Wed, 08 Oct 2025
 01:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925223656.1894710-1-nogikh@google.com> <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
In-Reply-To: <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 8 Oct 2025 10:43:51 +0200
X-Gm-Features: AS18NWD2m7wRQRTYoE5oa91q74s9ueKa5gBPaHOd5rYELKrxuXExAl7EfwP9pSs
Message-ID: <CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in eth_type_trans
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, mhklinux@outlook.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:51=E2=80=AFAM Alexander Potapenko <glider@google.c=
om> wrote:
> Folks, as far as I understand, dma_direct_sync_single_for_cpu() and
> dma_direct_sync_single_for_device() are the places where we send data
> to or from the device.
> Should we add KMSAN annotations to those functions to catch infoleaks
> and mark data from devices as initialized?

Something along the lines of:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d37da3d95b65..7f59de19c1c87 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -42,6 +42,7 @@
 #include <linux/string.h>
 #include <linux/swiotlb.h>
 #include <linux/types.h>
+#include <linux/kmsan-checks.h>
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -903,10 +904,13 @@ static void swiotlb_bounce(struct device *dev,
phys_addr_t tlb_addr, size_t size

                        local_irq_save(flags);
                        page =3D pfn_to_page(pfn);
-                       if (dir =3D=3D DMA_TO_DEVICE)
+                       if (dir =3D=3D DMA_TO_DEVICE) {
+                               kmsan_check_highmem_page(page, offset, sz);
                                memcpy_from_page(vaddr, page, offset, sz);
-                       else
+                       } else {
+                               kmsan_unpoison_memory(vaddr, sz);
                                memcpy_to_page(page, offset, vaddr, sz);
+                       }
                        local_irq_restore(flags);

                        size -=3D sz;
@@ -915,8 +919,10 @@ static void swiotlb_bounce(struct device *dev,
phys_addr_t tlb_addr, size_t size
                        offset =3D 0;
                }
        } else if (dir =3D=3D DMA_TO_DEVICE) {
+               kmsan_check_memory(phys_to_virt(orig_addr), size);
                memcpy(vaddr, phys_to_virt(orig_addr), size);
        } else {
+               kmsan_unpoison_memory(vaddr, size);
                memcpy(phys_to_virt(orig_addr), vaddr, size);
        }
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

should be conceptually right, but according to the comment in
swiotlb_tbl_map_single()
(https://elixir.bootlin.com/linux/v6.17.1/source/kernel/dma/swiotlb.c#L1431=
),
that function is deliberately copying the buffer to the device, even
when it is uninitialized - and KMSAN actually started reporting that
when I applied the above patch.

How should we handle this case?
Not adding the kmsan_check_memory() calls will solve the problem, but
there might be real infoleaks that we won't detect.
We could unpoison the buffer before passing it to
swiotlb_tbl_map_single() to ignore just the first infoleak on the
buffer.
Alternatively, we could require callers to always initialize the
buffer passed to swiotlb_tbl_map_single().

