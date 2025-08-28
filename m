Return-Path: <netdev+bounces-217745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DCB39AFD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61513BEA91
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C130C624;
	Thu, 28 Aug 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9zThiN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05030DD1A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379124; cv=none; b=BBOIy/b049tA5O+3GoYzaJrQtYRzv51kmyZXGoFXZOzDjpEtDXzGdwqiewGhQOVlxojBsJuTzAJr2Msflz6/+/3VsHaWtq3TuwwxfStMq506wwACZ7JENUZiQSix9Mm/TI9ik+cmH/TfOdRFrSbSiOo3IlTOqo7+JkkRQJeG+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379124; c=relaxed/simple;
	bh=TAUsH9qx5Xo7HZQWurliwAGX0byykFNGH5/xaDPAnAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSbUGlBIwaGuN+zxe6xnnkUPy9v7/V/Gi6KnDNAMLK2OAeRzp7YDmWl+4onEBMM+yEpwzWzOUpAXF0EiZykd3nR0LgzZ7VgCFix5ZVkPAFX3CZ3FpEgu1pXreKeC0eRWS4pH+ubIDh4me9fcC6E9beNNBOpnxckQQK74jQBy76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9zThiN5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-33679c4bd19so6654691fa.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756379121; x=1756983921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAUsH9qx5Xo7HZQWurliwAGX0byykFNGH5/xaDPAnAg=;
        b=D9zThiN5CvyWhSOAXkTsNLbjvHgBmaYN2VOm2aotEJ5v9KaHiO79PizfuAoaFr5i3q
         wgGAAt6itCrxtlVWHTpuoLaCKgxYrk0hFPnr061X8YyXx1Ma7yteboceDByDPNW4hnOI
         lY95iXFrfpYrUrrVcFKvhl+x9MQsQZ8My9oK54/cyAcW29/Lw1i8Q+kugZkeuk9nCyMV
         260qQzfkVL6Bs489EIx/kj2aiJNaI6mrUYg8R3onYuHZOqZfnDl4HBy+b7w9G/GDh8Nd
         70/0RHwwworlBfGAok6w9ZH6JROeJxuwTMRxlVvoIxO8J/mtabP7wK20Vp80jJVmIuxO
         IMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379121; x=1756983921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAUsH9qx5Xo7HZQWurliwAGX0byykFNGH5/xaDPAnAg=;
        b=BcBeK0uGLbdkjRk0qtp1QlfhBfblxFG9qYevzOVIFCnQpUoLv/X22Z7cFw3Xzwglcr
         rB1zStf4TxQhgQPDh5ADrR8ZPEwbzD/f87vnaslirmlVwKf46Qb2hQCSna4LcsdaaLEm
         5JSNkzVG+pnL5xg5T08/zlg12+x6HYMCmCVcM+WPR/2WYEqqfH2ue95kHPGhhezSCLZA
         M6qHb4daCR950uyAQpDw/diYq0uVkio1znToieIF8Nkb7xB/iwk24JpQYehcD+r6FMyP
         GOsywDLQMx2iWsi7O0RieHDOgty9w6X8GNVyP72Hk3pHwsgLj0eFfIagnQGpPQonExbG
         TC9A==
X-Forwarded-Encrypted: i=1; AJvYcCXFZRDHNJrn//wLnLVTujIy/uQd3Keb6oYQ9D0wCbbunzDpQhYxGcWgIc+tNUftWjHmCAKGI+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxbfOwMlqwvPxE19spoLF0uDiG2qUVxFg+Teh81HaiwqpAbOZ
	fLM2GiXEMSWclUBlXTv2nvpR9jV9e798ELrfOJ+loYAvIc4ae3JP6b3GDgO0+QCEdYQFUJhlBo0
	OKvVYv1IpgPPYYvSavkj4tWwf/D3dVLSKpJcSbqdx
X-Gm-Gg: ASbGncsJoDcFev8ingbCux98PQGo6LG61HEzXlCrUXGQy2ibnE0mANKDmXZGpSBVMZC
	kxwuLoNZEsoLS6YuzJ1Rsq8qalYZsFQ147GNbVO3dAnQVVpT+p6oBwAroukQb5TSrZtFGHmc/hG
	n5uT3YRldIkdbLXP7KkTFbUnhG302cU9U1nqTepIVHmMzcd7rqOygqXW6kdux8B116PKsWm1ZWl
	DtK78sPIjc2WSBXn4xR1435+ocgpnVrHvU9GsecYLg7z61Yp0fk/F0=
X-Google-Smtp-Source: AGHT+IH2xqkT7Gm8Y8VPKOFZe2CwX6AJnHBKkNuQ1kWl9XzOyZn3Ty6HeFlWouXcagu0nm0WrDp9EEtaTGEu1op7fA0=
X-Received: by 2002:a05:651c:2359:20b0:336:9adb:75f3 with SMTP id
 38308e7fff4ca-3369adb788amr8793491fa.38.1756379120964; Thu, 28 Aug 2025
 04:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFbECe10JE9MKzdU3X7kehVDoHr0kGnQpK1CVMJrg+qJwA@mail.gmail.com>
In-Reply-To: <CANypQFbECe10JE9MKzdU3X7kehVDoHr0kGnQpK1CVMJrg+qJwA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 28 Aug 2025 13:05:07 +0200
X-Gm-Features: Ac12FXwwRNf_fseKBhowipW4TPj-BQ0S2f9JAeNpAbDYk4E0hs940usVGesVMUU
Message-ID: <CACT4Y+YLTF0bG6yJABOXg7zZt+1nV6ajHLJxSWzazSk2sH=tfA@mail.gmail.com>
Subject: Re: [Linux Kernle Bug] INFO: rcu detected stall in e1000_watchdog
To: Jiaming Zhang <r772577952@gmail.com>
Cc: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com, kuba@kernel.org, 
	netdev@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 12:40, Jiaming Zhang <r772577952@gmail.com> wrote:
>
> Dear Linux kernel developers and maintainers:
>
> We are writing to report a kernel bug discovered with our modified
> version of syzkaller.
>
> The bug was initially found in Linux kernel v5.15.189 (commit
> c79648372d02944bf4a54d87e3901db05d0ac82e). We have attached the
> .config file and symbolized crash report for your reference.
>
> Unfortunately, we do not have a reliable reproducer at this time. We
> are actively analyzing the root cause and working to create a
> consistent reproducer, which we will share as soon as it is available.
>
> Please let us know if you need any further information.
>
> Best regards,
> Jiaming Zhang

Hi Jiaming,

This is likely to be a false positive. We found the default kernel
timeouts are not really suitable for fuzzing. Consider using the
official syzkaller-recommended configs with proper tuning for fuzzing.

Additionally, v5.15 is extremely old. Check out:
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md

