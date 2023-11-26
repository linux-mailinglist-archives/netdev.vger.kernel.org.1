Return-Path: <netdev+bounces-51099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D317F9118
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 04:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D86B20ED5
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4A21FB0;
	Sun, 26 Nov 2023 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fKHDb2P3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F9D3
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 19:04:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fa2714e828so425994666b.1
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 19:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700967895; x=1701572695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rkaMoHrFlZfVMg+m4s+x5AD3GeehE8yA2Qqsd3VE908=;
        b=fKHDb2P3A5H/08NFkefR28i53gh/+NjqO03sqYQBmUmCxLiYG6Ge7S+KR87Rx7UAAH
         6xkhQHfGyBHxPFbJp9fieJS87JemWHboaIQU9NKggYUPRmgoU2ipSFHcp53aUPQpjifa
         gKH4tiavdI07m6kIHn0mtkB7KI5kyCWBiG9ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700967895; x=1701572695;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkaMoHrFlZfVMg+m4s+x5AD3GeehE8yA2Qqsd3VE908=;
        b=h9Pff/B94kfYHJkx3I2fSlHB9L5Eqfxn62L8UyhSA2twCRejYguYkQemthb6htfTFu
         QgCQ+VV9Dof0KHWmpGX0EjXFWCrSOTt6jOlj0f+Mmz59mh5wGFeKLnL4261zlwr4nUAd
         vWYtw/rKDPwFYNQeazuqtXHPYzbVT5r0TaRWXLXuvdUfnTM3mL65Ze137+7W0sE7xxAx
         y+fyXOq+q8GPoB5Zi7YxkVoABhGTJeAQgiXd2Ra8zg77H0A5dRcXNpYsS2EemN7fe224
         Xo/Dg+OoiOSJhQr2+L5x6WZpDXSH6E+RfDd2WtvLsl4Ow6XJ9VyDQDZRMfKhDVfDwExa
         Y14A==
X-Gm-Message-State: AOJu0Yz9WCU4m6ettaX9NIzTZCjmWfKWVfzdvQrGj8Zkjcn4E9GQGYUv
	icScsKeDsD0uQud7lT4xI4k3O6KwdjeDWt4JE0oyzg==
X-Google-Smtp-Source: AGHT+IHGtaQ1jj5k3o0H79xso+28UxEwwMMKj1xcdDYxW8LOLWrFxePkxbv1LwmHGgQLGLb9QIsUJw==
X-Received: by 2002:a17:906:5187:b0:a0d:3a70:11e3 with SMTP id y7-20020a170906518700b00a0d3a7011e3mr851494ejk.63.1700967895153;
        Sat, 25 Nov 2023 19:04:55 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090632cd00b009ca522853ecsm4107600ejk.58.2023.11.25.19.04.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 19:04:54 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54a95657df3so4468730a12.0
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 19:04:54 -0800 (PST)
X-Received: by 2002:a50:99dc:0:b0:53e:7d60:58bb with SMTP id
 n28-20020a5099dc000000b0053e7d6058bbmr5738755edb.27.1700967893714; Sat, 25
 Nov 2023 19:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Nov 2023 19:04:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
Message-ID: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
Subject: Aquantia ethernet driver suspend/resume issues
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000147411060b057306"

--000000000000147411060b057306
Content-Type: text/plain; charset="UTF-8"

Ok, so this is pretty random, but I ended up replacing my main SSD
today, and decided that I'll just do a clean re-install and copy my
user data over from my old SSD. As a result of all that, my ethernet
cable ended up in a random ethernet port when I reconnected
everything, and because of the system reinstall I ended up with
suspend-at-idle on by default (which I very much don't want, but I
only noticed after it happened).

And it turns out that suspend/resume *really* doesn't work on the
Aquantia ethernet driver, which is where the cable happened to be.

First you get an allocation failure at resume:

  kworker/u256:41: page allocation failure: order:6,
mode:0x40d00(GFP_NOIO|__GFP_COMP|__GFP_ZERO),
nodemask=(null),cpuset=/,mems_allowed=0
  CPU: 58 PID: 11654 Comm: kworker/u256:41 Not tainted
  Workqueue: events_unbound async_run_entry_fn
  Call Trace:
   <TASK>
   dump_stack_lvl+0x47/0x60
   warn_alloc+0x165/0x1e0
   __alloc_pages_slowpath.constprop.0+0xcd4/0xd90
   __alloc_pages+0x32d/0x350
   __kmalloc_large_node+0x73/0x130
   __kmalloc+0xc3/0x150
   aq_ring_alloc+0x22/0xb0 [atlantic]
   aq_vec_ring_alloc+0xee/0x1a0 [atlantic]
   aq_nic_init+0x118/0x1d0 [atlantic]
   atl_resume_common+0x40/0xd0 [atlantic]
   ...

and immediately after that we get

  trying to free invalid coherent area: 000000006fb35228
  WARNING: CPU: 58 PID: 11654 at kernel/dma/remap.c:65
dma_common_free_remap+0x2d/0x40
  CPU: 58 PID: 11654 Comm: kworker/u256:41 Not tainted 6.5.6-300.fc39.x86_64 #1
  Workqueue: events_unbound async_run_entry_fn
  Call Trace:
   <TASK>
   __iommu_dma_free+0xe8/0x100
   aq_ring_alloc+0xa4/0xb0 [atlantic]
   aq_vec_ring_alloc+0xee/0x1a0 [atlantic]
   aq_nic_init+0x118/0x1d0 [atlantic]
   atl_resume_common+0x40/0xd0 [atlantic]
   ...
  atlantic 0000:44:00.0: PM: dpm_run_callback():
pci_pm_resume+0x0/0xf0 returns -12
  atlantic 0000:44:00.0: PM: failed to resume async: error -12

and now the slab cache is corrupt and the system is dead.

My *guess* is that what is going on is that when the kcalloc() failued
(because it tries to allocate a large area, and it has only been
tested at boot-time when it succeeds),  we end up doing that

  err_exit:
        if (err < 0) {
                aq_ring_free(self);
                self = NULL;
        }

but aq_ring_free() does

        kfree(self->buff_ring);

        if (self->dx_ring)
                dma_free_coherent(aq_nic_get_dev(self->aq_nic),
                                  self->size * self->dx_size, self->dx_ring,
                                  self->dx_ring_pa);

and notice how it will free the dx_ring even though it was never
allocated! I suspect dc_ring is  non-zero because it was allocated
earlier, but the suspend free'd it - but never cleared the pointer.

That "never cleared the pointer on free" is true for buff_ring too,
but the aq_ring_alloc() did

        self->buff_ring =
                kcalloc(self->size, sizeof(struct aq_ring_buff_s), GFP_KERNEL);

so when that failed, at least it re-initialized that part to NULL, so
we just had a kfree(NULL) which is fine.

Anyway, I suspect a fix for the fatal error might be something like
the attached, but I think the *root* of the problem is how the
aquantia driver tried to allocate a humongous buff_ring with kmalloc,
which really doesn't work.  You can see that "order:6", ie we're
talking an allocation > 100kB, and in low-memory situations that kind
of kmalloc space simply isn't available. It *will* fail.

Again, during boot you'll probably never see any issues. During
suspend/resume it very much does not work.

In general, suspend/resume should *not* do big memory management
things. It should probably have never free'd the old data structure,
and it most definitely cannot try to allocate a big new data structure
in resume.

To make matters worse, it looks like there's not just *one* of those
big allocations, there's multiple ones, both for RX and TX. But I
didn't look much more closely.

I don't know what the right fix is, but *one* fix would certainly be
to not tear everything down at suspend time, only to build it up again
at resume.

And please please please don't double-free things randomly (if that is
what was going on, but it does look like it was).

           Linus

--000000000000147411060b057306
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lpevtqap0>
X-Attachment-Id: f_lpevtqap0

IGRyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYyB8IDUgKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcXVhbnRpYS9hdGxhbnRpYy9hcV9yaW5nLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hcXVhbnRpYS9hdGxhbnRpYy9hcV9yaW5nLmMKaW5kZXgg
NGRlMjJlZWQwOTlhLi40NzJjN2MwOGJmZWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9hcXVhbnRpYS9hdGxhbnRpYy9hcV9yaW5nLmMKQEAgLTkzMiwxMSArOTMyLDE0IEBAIHZvaWQg
YXFfcmluZ19mcmVlKHN0cnVjdCBhcV9yaW5nX3MgKnNlbGYpCiAJCXJldHVybjsKIAogCWtmcmVl
KHNlbGYtPmJ1ZmZfcmluZyk7CisJc2VsZi0+YnVmZl9yaW5nID0gTlVMTDsKIAotCWlmIChzZWxm
LT5keF9yaW5nKQorCWlmIChzZWxmLT5keF9yaW5nKSB7CiAJCWRtYV9mcmVlX2NvaGVyZW50KGFx
X25pY19nZXRfZGV2KHNlbGYtPmFxX25pYyksCiAJCQkJICBzZWxmLT5zaXplICogc2VsZi0+ZHhf
c2l6ZSwgc2VsZi0+ZHhfcmluZywKIAkJCQkgIHNlbGYtPmR4X3JpbmdfcGEpOworCQlzZWxmLT5k
eF9yaW5nID0gTlVMTDsKKwl9CiB9CiAKIHVuc2lnbmVkIGludCBhcV9yaW5nX2ZpbGxfc3RhdHNf
ZGF0YShzdHJ1Y3QgYXFfcmluZ19zICpzZWxmLCB1NjQgKmRhdGEpCg==
--000000000000147411060b057306--

