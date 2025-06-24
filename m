Return-Path: <netdev+bounces-200782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F9FAE6D75
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12F43BAFED
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5B2C1585;
	Tue, 24 Jun 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr9zXGtj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A53274B2C;
	Tue, 24 Jun 2025 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786061; cv=none; b=e1RrAUG7CrcP2nSz72/MMmGRK5f1O/HvEQsF6d4aKdW+LCCV9tOJXZpnJH3/2zyrQE/ZRdHeMehxi41J1axqiZR31yq3ZqLYibAJGq/MR4qWD3z4HeCAuXdy7hJwxT050dLf6r6uJknAOiGQ9/GkCYvtGcqdBHwEKt4UaaZHCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786061; c=relaxed/simple;
	bh=oshLx90C0YrDegIOUStwpIIDSGSg7PKJPRr6TKfFAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C38VRR2uhISXRHNv1SaXH511iPKRl3YEpV+fkK16zWyJZg+SUezrbZ8cl9yAKNdkoX74rr1fp5PW3elK13aiMchYpm9/+uNw5SehkxyT323GQVvjEkw7AINVPNUzhHdAO6G4hhEEcMczUQWgvxEnwVikZzT87rYhwoiZrv6TDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jr9zXGtj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so770732a91.1;
        Tue, 24 Jun 2025 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750786057; x=1751390857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5nrAwOBM7dVDDH2BwXUu00PJTBJWmkBmfMiBcNhlPE=;
        b=jr9zXGtjIv3eYmrA6zutGH8hp/mek9/RQY1g2Tp7//FxcseEJy5c+1i4IEhRIDqHGS
         tN4qWJaK1XXR9KnFa9PpdV2WoE98pFAhmf8HU6EP9qgzu6Qsg+T9bYEXa2xVYVNvruZH
         Q/l/2bPGlBw9f39LSBMln0v+A1y5XzEatwGb2XuK9iZnfaaLEGEAoH6rUYG9cGYBczvc
         v9hypC3uBT4aCj2ADztNnvPXElF0IIbA5H8QcK2e3WBiprR5xUSGtmP3S2a31BcNSc8L
         UYorRDDm9RJeKcxJsm3nmPq3L91H4cmK6VTJMWWpc/laEWI+yk7408gLr7V3mY/upQJz
         oEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750786057; x=1751390857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5nrAwOBM7dVDDH2BwXUu00PJTBJWmkBmfMiBcNhlPE=;
        b=Fn3RciuJPqY8x3oGp7n5hDQqibmlKkAOGONe4nPACNKFTQc66gRdh8LsCe1yhWFGRX
         UfuUsK4ysOxWC74jwypCJ5WaSfdvfeRpyGTb6rveOMDZhuV2wbrYkyDVmqinQXgqOgb3
         C/qdCu+kfAtQr2ry+dl6AhWIqMdxA4n/E+1lsGDMNybCfzWKgVa4R0epg6IFDSEWAAuE
         h8iqetuuCzl/aXcU1JCtEgmgaHzBER15IeRHCITs7G+f6nLGDsptcPx+QjE+gzhJ1ug+
         HGSgb5nCnmj1UvNdGOPwnBOjl4idOmBJVdNPFvAqUN0yj06djdwNjoy4clH+95uS2lyw
         PBOw==
X-Forwarded-Encrypted: i=1; AJvYcCVpcPQVCW6qPqxdYFXEn+uP0bxfB8/YVOSIOfaVg6DLT2xM53fOuY84MOrC5iDTi+sZwsnNZ6e6@vger.kernel.org, AJvYcCXds45VHf8sneyS+PZsiSio49kFOsgOZhll2s0RerITTg9oiR8TFohrwrutfZ9S9YonEo2YaZKI73y4/l2jqvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2VRnZtpkuTxIEF/a/aogx8xJV6I81yz3H5HMvHXQxOPtwGcm
	GYBhxTVQ6eYQBUWz3EBXLu4ur9doHQ6EFlp6npbc5OksPzg3lCIzcRg=
X-Gm-Gg: ASbGncv0vOiZiumjte+SKM99elgOhCoMi/h3x0LpEjf6fOPtDZr9etlV1lJfIMF2gnn
	e64zH6l5bfqrECP/hJvEei/Xpc3lid4Dcq8f1+oOblO5FT6TP6c1umO9nI0SN9OfsLRS+QsJ7vU
	j++GzN5myieuGyHuukouaD0sMACciOdvBC5296Eo+Kfxrzkpe2kIxZfDs9jxF9VtY1kuZ7lbnqh
	pQBCM7+xntDgspMi5bMYKpymgKQTKR30cA5yIYYwIkqKBa+OCC4OZcrsiKznz+WkGGh9t2Qpnkr
	1pV2H95xrgCJ9BfVXaRKB7QNvnY9eP2Ibl21OSo=
X-Google-Smtp-Source: AGHT+IEuCS3d/5YsrevBrQ/hdUuTNTmD0eveveA2d4d4t8z9iyc418TDnkEXiZhaDdnYdY3A7E9Wqw==
X-Received: by 2002:a17:90b:3b45:b0:313:f6fa:5bc6 with SMTP id 98e67ed59e1d1-3159d8c6ce2mr23563714a91.20.1750786057408;
        Tue, 24 Jun 2025 10:27:37 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e082441sm10894189a91.48.2025.06.24.10.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 10:27:36 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: luiz.dentz@gmail.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [GIT PULL] bluetooth 2025-06-23
Date: Tue, 24 Jun 2025 10:27:29 -0700
Message-ID: <20250624172735.430106-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CABBYNZ+C+HGgxaMg6L+rA4z1dsoSkPG8gSJLt3jvS63_egmSxw@mail.gmail.com>
References: <CABBYNZ+C+HGgxaMg6L+rA4z1dsoSkPG8gSJLt3jvS63_egmSxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jun 2025 09:01:01 -0400
> Hi Kuniyuki,
> 
> On Tue, Jun 24, 2025 at 6:50 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> >
> >
> > On 6/23/25 6:54 PM, Luiz Augusto von Dentz wrote:
> > > The following changes since commit e0fca6f2cebff539e9317a15a37dcf432e3b851a:
> > >
> > >   net: mana: Record doorbell physical address in PF mode (2025-06-19 15:55:22 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-23
> > >
> > > for you to fetch changes up to 1d6123102e9fbedc8d25bf4731da6d513173e49e:
> > >
> > >   Bluetooth: hci_core: Fix use-after-free in vhci_flush() (2025-06-23 10:59:29 -0400)
> > >
> > > ----------------------------------------------------------------
> > > bluetooth pull request for net:
> > >
> > >  - L2CAP: Fix L2CAP MTU negotiation
> > >  - hci_core: Fix use-after-free in vhci_flush()
> >
> > I think this could use a net-next follow-up adding sparse annotation for
> > the newly introduced helpers:
> >
> > ./net/bluetooth/hci_core.c:85:9: warning: context imbalance in
> > '__hci_dev_get' - different lock contexts for basic block
> > ../net/bluetooth/hci_core.c: note: in included file (through
> > ../include/linux/notifier.h, ../arch/x86/include/asm/uprobes.h,
> > ../include/linux/uprobes.h, ../include/linux/mm_types.h,
> > ../include/linux/mmzone.h, ../include/linux/gfp.h, ...):
> > ../include/linux/srcu.h:400:9: warning: context imbalance in
> > 'hci_dev_put_srcu' - unexpected unlock
> >
> > (not intended to block this PR!)
> 
> Can you address the above comments?

For sure, will send a followup.

