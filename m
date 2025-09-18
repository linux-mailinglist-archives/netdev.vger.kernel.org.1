Return-Path: <netdev+bounces-224485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565DB856F5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E63463539
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF123C8AA;
	Thu, 18 Sep 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs0GFmSz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8960B8A
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207809; cv=none; b=hWZWNEvybP0Dv39rTvgtWeV+V7aZMd6514ke4Yv47RwG61ZhNtaj7ZTacf/MkZ++ekGlIknlojXFMfNNM5GBPkEUMiRRqXxzdveaEcHhTZL0tBdPrPJWrYQP9w+0f8+9KYBr2/BLYz1XcIaDF+nzonv+nSMpG4gf2GEbO5kVde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207809; c=relaxed/simple;
	bh=EkExrjB1v+E3308pb6pdcKo1s1yc3WIbaOoY/+f5qXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh3zErCvSFraeDqQXqGHYzTdQqWXpGYvMKS9iYR/ynqtxlHvhg4h5k3fOUFr7g3Hl2mUZJ1asTCemz1kScCUFlE4uFg60p3bUJ+zeKOvl9TGomzBQt8ItKJsYT59inKTCfMtSJyP5zlODE4SGGdNfs4bKTlG9FUUMJMM3ztfpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs0GFmSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
	b=gs0GFmSzWvxv8xsTattEFegFjcPcs2ccWQrTBE6CCbLmHsodmxo6/FJAJxZv0NtqxmrjX8
	pLI6IKcEq25Z4znOpHRaxrELJ/AMA+vzvxFjwpMK84M4mZFhtA2qK3tc0MT7E5t9ex2SRT
	P9ARWzWJAmHKQIbw9Pw/C1jziPaZ0cc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-i3_BqRAyNE-a30b1iXjZ0A-1; Thu, 18 Sep 2025 11:03:24 -0400
X-MC-Unique: i3_BqRAyNE-a30b1iXjZ0A-1
X-Mimecast-MFC-AGG-ID: i3_BqRAyNE-a30b1iXjZ0A_1758207803
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so6536795e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207803; x=1758812603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
        b=nEhecrqaQ0n2ETticJ41iIwEzjEENNYnRXjxgf4nK69r+BtQNdXEWO5ARJDh9i751o
         PEdNtR394VykubJr4q39Pj6ZGt6FfXjZKNNRA1NrDSjnI03LsMNrxVP1DiDVkogF64AS
         1qGfL38UEX4EPEonlaRYdxh55N/PBaxodUMUdLZS949qVyRIIAnWQJ5LDLxthhNWGJJQ
         oJ9dKKzX95ma1vofyjy85vdmjACLuLR3rZS8CEdbMCGTpgFQNgxn0JRaYm76XurkFYyJ
         8rbiuWj54uHjbR5MpYN+bwsCNFXPGPlLuBsUkGrL4uxmFk5ukdPreKVx0zrv6Bs6zxOi
         nSeg==
X-Forwarded-Encrypted: i=1; AJvYcCX+IFXrpSfT4YwjJ7tXFpKFtGUAmhGb04AzpyYZskD2FFFuyULwdN0kfObXEpH9ekMVrWW4Trw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjo+72oMTT+OjaKL6yth0Ml6JCtpZSlyZaMpCX/klfqr2LDQNu
	SDzIiKj/XNydZnM6jotBsL0LHAS1h4YwIPhRSA+nubwJjvzVkJDl0Z9TD1IJetOrUvcu1v5i7QE
	j2fZKLiAQkXH2aoHfaW1fjpcLLHW+lqWf85uzKsFJCcv43dj+kmOMYItsZA==
X-Gm-Gg: ASbGncve1WRZoIsAq19l4LqCpy5iUeVpH+S4O/52LfB6vwpdNAVI4BessdwIn6kbWm9
	r5PUEfpDYhoZuAJXC3C/4JmgSPQFJ9jLL9CuBCGhSQvZ4/6mYm5CR7a78rxjWt6GTz3EcMEsXL4
	seyFrqvi2Z3tX9uKc4aGovlkZvWiS/VYmDo5leCI8ItKUHkk85tRxc03l0e0aaza8NjIdDxvqQM
	vkMw450jRVdEE45UxDZ74JVBMFMlO2GEHBdOALbxH9e4rVVEksvMe+G6vv/Xex7n/+B33KVB5vt
	STP9XQPdHmCYrWpnqdDpNaBCNzQnJJeJhAU=
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63892285e9.25.1758207802084;
        Thu, 18 Sep 2025 08:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzXMO/8xWkfvQqlitTmfPRvJ7wLVF0bHaOOs2wJAFpxqVjxaTdhQB7sp9EBt86tb48mNkwbQ==
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63891665e9.25.1758207801215;
        Thu, 18 Sep 2025 08:03:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm45758515e9.24.2025.09.18.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:03:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:03:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918110237-mutt-send-email-mst@kernel.org>
References: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918104144-mutt-send-email-mst@kernel.org>

On Thu, Sep 18, 2025 at 10:41:44AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:
> 
>   virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)


Sorry, pls ignore, Sean Christopherson requested I drop his patches.
Will send v2 without.

> ----------------------------------------------------------------
> virtio,vhost: last minute fixes
> 
> More small fixes. Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       vhost-scsi: fix argument order in tport allocation error message
> 
> Alyssa Ross (1):
>       virtio_config: clarify output parameters
> 
> Ashwini Sahu (1):
>       uapi: vduse: fix typo in comment
> 
> Michael S. Tsirkin (1):
>       Revert "virtio_console: fix order of fields cols and rows"
> 
> Sean Christopherson (3):
>       vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
>       vhost_task: Allow caller to omit handle_sigkill() callback
>       KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks
> 
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  arch/x86/kvm/mmu/mmu.c           |  7 +-----
>  drivers/char/virtio_console.c    |  2 +-
>  drivers/vhost/scsi.c             |  2 +-
>  drivers/vhost/vhost.c            |  2 +-
>  drivers/vhost/vringh.c           |  7 +++---
>  include/linux/sched/vhost_task.h |  1 +
>  include/linux/virtio_config.h    | 11 ++++----
>  include/uapi/linux/vduse.h       |  2 +-
>  kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
>  9 files changed, 65 insertions(+), 23 deletions(-)


