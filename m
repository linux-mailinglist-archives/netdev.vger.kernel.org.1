Return-Path: <netdev+bounces-102990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961ED905E0B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B31285E81
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5A412B177;
	Wed, 12 Jun 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PW6xWJuA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43FB12C486
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229276; cv=none; b=lNYmtbnaslhI5gsUXHMm6boNd01cg4k4t+74j1NPfkY/7Ugympvnp1lKo0nHHdd8w4eM/oO1fon0P2aUEZHm5JiBrOHmmMJekzJzgkI+sayFT13ZcOADzVPdLd35fapTQwv82706uEKc2axGClPk8CFKjAKQGavubinY61IDHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229276; c=relaxed/simple;
	bh=oyaC/o4K7A3entjcxoiTMTPSvxC71DyJhBkCJpFfOiA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW+4t1r7lbG3tc5LhLC3GO/df7cSOU1STpU5W40rs/IgfdYN/JXxOLlQJmvO8DefLZayV3ajkz27jA5TOSmX+K3EVjyu+tc9DmSeyL2wsE0sWZyvwHxcxD6QDoWa+g4z1Az0pSslPBtf7g3GxignB25wCGbZDad91Cb7GJImBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PW6xWJuA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b0825b8421so1994316d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718229274; x=1718834074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BifripJQYUZpHCC77b7pwMa5qfHAptD7uFiM4T24Muo=;
        b=PW6xWJuAXKJHYyPgsrntgzSoFxBiokfsC9ukNvBsEMI5DCd9DqYJWJoekxkKho2VVF
         tmfD3c1cfeLSM9TGtRnIdHloupjog+pYX3m6Nh2dLZSlf13Xq64q71s0y5Qy9E2xv5gd
         V4nLBK6TFYTmY4WuAFLTPL7Bod+fXbbj9Ku+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718229274; x=1718834074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BifripJQYUZpHCC77b7pwMa5qfHAptD7uFiM4T24Muo=;
        b=Ws0hMipKDIBqEgSNkFG2SSafQr5SJ5BlsYH1U6hqMfE4vFqF+x4hshb/5bh2BVX2/o
         qsI1UhpL6qi3t96uCVNA40cPUenINjkaiwp+Txf9MTTqfHCsmVAweDdGThS7YvIc6Srv
         H6Oc20nR/2CE54VSrW/zk8QCpoVfhejkxGTwwvtgFu4kCxgs4icYou4OXPafSEgQ7Arj
         7j1PDo0+8oZgD65wIViOiOuGeuaQ7X7M+7jlLMB4RBt/2Z27HloqzGPbA91kQHS7uS9p
         nIIHYeIDw6zdLVITsBIP+xXvogXYzesGP5vgMj5Jtif9jfvAOLo2GueqUMNnn7pazIKg
         SlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvyaWJmq9E230cKqBEDQGhwn29+k8VYp1aqWaLqZx3SUNymn7SKaayXq9GQQkdAJdppbUnEZR1JbfTJgcwg6xffzIn7+bN
X-Gm-Message-State: AOJu0Yw5MFZoYUlBEkPw3csHaQmwYXu1zltaPjU0oWQM87KvpxuBFObe
	gqNtiKokCUSUNVwdtjvtBn1rxns/x7Zc0u4nKm4qlu7XPj7dNmTr/YvJMvCSpw==
X-Google-Smtp-Source: AGHT+IHiq29nqrY+z9M8CZnqCgmDtySpFhozvWomQ+8danyaiW4wzAhxiL+v1IFX3VzNdWcOmSSCkA==
X-Received: by 2002:a05:6214:5b82:b0:6b0:7f36:8af4 with SMTP id 6a1803df08f44-6b191498f09mr35147556d6.9.1718229273750;
        Wed, 12 Jun 2024 14:54:33 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf232csm212376d6.27.2024.06.12.14.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:54:33 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Wed, 12 Jun 2024 17:54:20 -0400
To: David Wei <dw@davidwei.uk>
Cc: David Ahern <dsahern@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] bnxt_en: implement netdev_queue_mgmt_ops
Message-ID: <ZmoZDBPrrLY8l6nM@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240611023324.1485426-1-dw@davidwei.uk>
 <e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
 <b2dadafd-48c3-4598-bee5-a088ae5a4bc7@davidwei.uk>
 <1b26debd-8f18-46de-ac6e-05bff44a9c52@kernel.org>
 <80a1ea79-738d-404d-8b50-cc5eb432153e@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80a1ea79-738d-404d-8b50-cc5eb432153e@davidwei.uk>

On Wed, Jun 12, 2024 at 11:19:47AM -0700, David Wei wrote:
> On 2024-06-12 08:52, David Ahern wrote:
> > On 6/10/24 9:41 PM, David Wei wrote:
> >>
> >> This patchset is orthogonal to header split and page pool memory
> >> providers. It implements netdev_queue_mgmt_ops which enables dynamically
> > 
> > Ok, where is the validation that these queues must be configured for
> > header-data split to use non-kernel memory?
> 
> Any validation would be done outside of this patchset, which only
> focuses on resetting an Rx queue. Reconfiguring page pools and HDS is
> orthogonal and unrelated to this patchset.

I can confirm this.  These changes are just to keep the allocation
schemes the same as they are today, but add support for stopping/freeing
and starting/allocating rings individually and via the new API.

> The netdev core API consuming netdev_queue_mgmt_ops would be
> netdev_rx_queue_restart() added in [1].
> 
> [1]: https://lore.kernel.org/lkml/20240607005127.3078656-2-almasrymina@google.com/
> 
> Validation would be done at a layer above, i.e. whatever that calls
> netdev_rx_queue_restart(), as opposed to netdev_rx_queue_restart() or
> netdev_queue_mgmt_ops itself.

