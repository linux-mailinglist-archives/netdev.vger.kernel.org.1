Return-Path: <netdev+bounces-210396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7697B13121
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D650B7A98F5
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5230021E0AF;
	Sun, 27 Jul 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sV/1Vr4i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AC2A1D1
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753640288; cv=none; b=eWV+4dwXQXkzFBJyIEhYkCyT89PgsWHg6T7PmkVMZxrl04bD1OHyxY92EPvXYrH1urnE6rrK1zomzyk0AJtQB1RqDQJgEgHiMqB30S/Gtir+YAJ41XK/KglESdmjYHP7fUMShxT9vkBYbGjhVP+f4DaokdoNQA5zHAAX+a3F0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753640288; c=relaxed/simple;
	bh=Oh3MgeqnOYp4K9k+9BDHHKlnsg0BQzGc4dHtDzS2t7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov6SJeqE0yV6rP47HmfBNEacRoLYwwLVMX6jcksCCpV8ALD1Kox8FLOAEeyxLbKn3dkLoTEfKkx3lDPkkjCGo1lxFTVR1VAEUQMJSpp3FUTKSJJJiTVSrc90+TWrnBbKuV+ijFw43Iv5Etf6adYX3sIy5aPYUU83IrKhtZipgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sV/1Vr4i; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dd9ae5aacso155625ad.1
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753640286; x=1754245086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrCK6S0JfTZW8/CSdvpX6rnp+yviEEZjXuCZqY3YBDU=;
        b=sV/1Vr4iJplUzZMvP2yLPXc1rMOvJt72RobXQwj8qSYflVTUJU5fTyVT/4ri0PlcrJ
         LRP/pyxBiowTLebJjW85wu1+T9RnLHPNIFyaFGIXHgbB3llrvJltINiaoqIIdCXS4BLR
         Yj3HIOAQ18/XEVqwZS9+n1xWZyqaG3Y3EbokJfWnnmZf98Zk0b1g2srTGkmSCkc2ScHb
         kC5QrYsuRV72KkIEIUXQ8GZcYSWnCGELHgGIP9lawwi5EfaqTbJfpRlQ/UgBZvXz6QN+
         UtJBEy857nKezVfIPMktI/8kZraBAACVsR//kYz7zSGJQ0DXPnzTcqox7JTxf+vBKSyg
         ODHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753640286; x=1754245086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrCK6S0JfTZW8/CSdvpX6rnp+yviEEZjXuCZqY3YBDU=;
        b=Cl8Q0BizxcRCMOca2Fn1kI2cnSlP67E8aXPv5lWCjk7tx2q8jXl7W0ZgG+d08SwJu5
         rHlmtHfaCi1MVuc7oNbgwD4JdoQBGsDGwivtwXfI6Wi5RgjNdSitLnTiPVJzh2vQNO2E
         nccGIxH9v/nhRXGKOa7Adi4KGAshHe6K/A1/SqBjJRjL1oUGlf0PPLNV8QRuR2rZopAd
         kXg35NNBqDEWqpWObpS0JRUC1fJI8qlKnQzy3O/KpAkQ0N55fQyeQPuy7rCxKLVmYeqP
         nK1FOAw+GY2bcMLxHS4wc+oax2TeVLwTd29+EscRJu+IHL3dMBZnUECIeTCpVdbSCwrY
         zMjg==
X-Forwarded-Encrypted: i=1; AJvYcCVGs8H7d6tYIO0mMKiWZCdpgIG15rRD9IrnzYA1UPcNzGLoqys5TgWiBtuQ0H4SFbZeQoifvbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1kLft6xTPZgiJoakuWl+1jF791xS8yxoBP7V5hFat60/k/sC
	/DFY3Gn1a9yQcNae0MQ+O9x6IDvj84IOQvgNPTqk1EygzWYen2WjJRi6wmaG2pVB8w==
X-Gm-Gg: ASbGncs0YiXsy07Wn0RoA+ptKq9Jrwk2IJw39K5T25lhWs1S7vS/Uv4NFqN3fz2xtPV
	dSXu56qt+vjOKQBsSLqOFzlND46FA67M0mb3eQsdQL178cQsntR+zi6W90xT56p2L3cNYjRXv0y
	bDYzjaMxs4SiSRSzVrduvNbo6q3Ipny/I1I0vWb3BHcCCpjeB/fueqn2nt3xyyoP1jEe4LXjcjG
	GRzSX2tbJ1J30uB4jMvsmJKAQ4qlWBLjG5tpzo7TP2h6nTcffhDaOOtpPUUUmtH6ku4PwX67xYx
	wkPISz4LslTp1rJ/ZBDYUKhHvpx60gWtKIlzZER89EQ0QzeGta9E2bciWhg4bbcacvhqK9JxGO9
	Gi5wiGNBHiJLchNIVVYU1W+JPfzLU26cVtotXC6s4+E/1yxB3jTyxfGXhmUSHfXc=
X-Google-Smtp-Source: AGHT+IFuHg9slp36BYzs++FA75XcSgyone2OHe/zLOFgSAqf2O6bVxYmK0j6OseG6HWIpZ8I/hYfBA==
X-Received: by 2002:a17:902:fc87:b0:234:8eeb:d81a with SMTP id d9443c01a7336-23fbfd1952amr2788425ad.16.1753640285487;
        Sun, 27 Jul 2025 11:18:05 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02640sm3851608b3a.37.2025.07.27.11.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 11:18:04 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:18:00 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>,
	Shai Barack <shayba@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v19 3/5] binder: introduce transaction reports via netlink
Message-ID: <aIZtWGPFCsHdNvq1@google.com>
References: <20250725183811.409580-1-cmllamas@google.com>
 <20250725183811.409580-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725183811.409580-4-cmllamas@google.com>

On Fri, Jul 25, 2025 at 06:37:46PM +0000, Carlos Llamas wrote:
> From: Li Li <dualli@google.com>
> 
> Introduce a generic netlink multicast event to report binder transaction
> failures to userspace. This allows subscribers to monitor these events
> and take appropriate actions, such as stopping a misbehaving application
> that is spamming a service with huge amount of transactions.
> 
> The multicast event contains full details of the failed transactions,
> including the sender/target PIDs, payload size and specific error code.
> This interface is defined using a YAML spec, from which the UAPI and
> kernel headers and source are auto-generated.
> 
> Signed-off-by: Li Li <dualli@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  Documentation/netlink/specs/binder.yaml     | 96 +++++++++++++++++++++
>  MAINTAINERS                                 |  1 +
>  drivers/android/Kconfig                     |  1 +
>  drivers/android/Makefile                    |  2 +-
>  drivers/android/binder.c                    | 85 +++++++++++++++++-
>  drivers/android/binder_netlink.c            | 32 +++++++
>  drivers/android/binder_netlink.h            | 21 +++++
>  include/uapi/linux/android/binder_netlink.h | 37 ++++++++
>  8 files changed, 270 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/netlink/specs/binder.yaml
>  create mode 100644 drivers/android/binder_netlink.c
>  create mode 100644 drivers/android/binder_netlink.h
>  create mode 100644 include/uapi/linux/android/binder_netlink.h
> 
> diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
> new file mode 100644
> index 000000000000..a2e54aa42448
> --- /dev/null
> +++ b/Documentation/netlink/specs/binder.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +# Copyright 2025 Google LLC
> +#
> +---
> +name: binder
> +protocol: genetlink
> +uapi-header: linux/android/binder_netlink.h
> +doc: Binder interface over generic netlink
> +
> +attribute-sets:
> +  -
> +    name: report
> +    doc: |
> +      Attributes included within a transaction failure report. The elements
> +      correspond directly with the specific transaction that failed, along
> +      with the error returned to the sender e.g. BR_DEAD_REPLY.
> +
> +    attributes:
> +      -
> +        name: error
> +        type: u32
> +        doc: The enum binder_driver_return_protocol returned to the sender.
> +      -
> +        name: context
> +        type: string
> +        doc: The binder context where the transaction occurred.
> +      -
> +        name: from_pid
> +        type: u32
> +        doc: The PID of the sender process.
> +      -
> +        name: from_tid
> +        type: u32
> +        doc: The TID of the sender thread.
> +      -
> +        name: to_pid
> +        type: u32
> +        doc: |
> +          The PID of the recipient process. This attribute may not be present
> +          if the target could not be determined.
> +      -
> +        name: to_tid
> +        type: u32
> +        doc: |
> +          The TID of the recipient thread. This attribute may not be present
> +          if the target could not be determined.
> +      -
> +        name: is_reply
> +        type: flag
> +        doc: When present, indicates the failed transaction is a reply.
> +      -
> +        name: flags
> +        type: u32
> +        doc: The bitmask of enum transaction_flags from the transaction.
> +      -
> +        name: code
> +        type: u32
> +        doc: The application-defined code from the transaction.
> +      -
> +        name: data_size
> +        type: u32
> +        doc: The transaction payload size in bytes.
> +
> +operations:
> +  list:
> +    -
> +      name: report
> +      doc: |
> +        A multicast event sent to userspace subscribers to notify them about
> +        binder transaction failures. The generated report provides the full
> +        details of the specific transaction that failed. The intention is for
> +        programs to monitor these events and react to the failures as needed.
> +
> +      attribute-set: report
> +      mcgrp: report
> +      event:
> +        attributes:
> +          - error
> +          - context
> +          - from_pid
> +          - from_tid
> +          - to_pid
> +          - to_tid
> +          - is_reply
> +          - flags
> +          - code
> +          - data_size
> +
> +kernel-family:
> +  headers: ["binder_internal.h"]

Hmm, it seems this header inclusion was left in from patchset v13, where
the 'struct binder_context' needed to be exposed. Not anymore though, so
I'll send out a new version that drops this part.


