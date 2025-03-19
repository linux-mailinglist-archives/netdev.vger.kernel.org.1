Return-Path: <netdev+bounces-176163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51958A693A9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216AD1736AE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3F1C3BE1;
	Wed, 19 Mar 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xhCtYU5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168A158DAC
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398559; cv=none; b=PBTUrGdn3p4SOIRc8lLHkKTpDzNkhGLszEI/EzxSPHBu650CdJc/C/utplgkL+mIdpIVMZpykCP4L5APyhndQldU/RVzzR+66g+gZZHoN9mnjCIll6GtSYGC2Q+RHCtqPn2I5tooRSsP/OR3bzhW4WLo+uv4mJiIN+4eA/R2XjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398559; c=relaxed/simple;
	bh=FliY1mZLdfM6F5jkw11JCHr0QbDbk4ytcOPd2ViWBxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoIv/Py6EUtbnzmBqps3c6bkVgnmOgTIM7IxIf6nmXhdGUEJMeXFnwYBwPqvqhnfv3pzqrJudKDH0UZI8KVPdx/cLNjiGuyjy0MYLq6GpSoOgtWDJFyWTIWGvJURUYZwv5gN4ZhtdfdRLTlJLUb/U/Hhnep73krVW7hgLeDX00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xhCtYU5X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22423adf751so127155675ad.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742398556; x=1743003356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ4El0IDIl55DEcGT1TojkpAPTGa13An5HvreBfUETs=;
        b=xhCtYU5XRHmo0UUgenGMtp+i6+pRXJK2VevH5tiyvo0O8Qv2sqvKcEkoLMDiU10xeF
         V/fSjFfZTBGfY9YpsnO61mQRafamXbadQtBzINvEwJctyYUmThtLZYM2EFtdUFhRWUYf
         /8rotSSeq8jiZ6BcxPmiBmuRm2mHvTL8TlFZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398556; x=1743003356;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ4El0IDIl55DEcGT1TojkpAPTGa13An5HvreBfUETs=;
        b=UNTwHeNbHCiRvq1r+o6bDIVNgFf4MdxgXKvq63BfnKJMDXN8ln9i8Y6/ndJxXJWxGc
         xVFnOWvlxx8iJObGNQUwEvL98KvK6MmlT1RoG93uJ5xXndxTgSq+jZQJ/VcudtiPa/Fe
         qToKD3b1o/43vpuJIMJy0ON7cQrcZAbB6jt3BtkuMcqeHKNtG5cM/gAMVvC+hMFRxznC
         q2mQ4W+0hh5ktuGLixK1GI/DvK0wz+oV4/Iyf0qg5YpTGzkI2pMj0+QAulIo0xoL1uCr
         JsL6XYXhML0/PByiVfdhX72brKVq7mwWqmZONyEr4kphEMt5zRPzoUX72Kqi3DzSJfaB
         p1wA==
X-Forwarded-Encrypted: i=1; AJvYcCVJE+/bfZ5qfrz0Pwh3m/JEHsvGt9+QVfzpzreVFX9uTfzW6s01a0QRUPv1w3WMevogsJLrsp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGhv5FqHpkGh9FBJtBff/8B93nOxyyAHHTBIeCZ8GWcGkiAnc
	Jh2mrayTcdAah6OP6ZVGlkNe+IZLmxbu/cGxh2vk+6jTutFng52aeNNyTrD1CwA=
X-Gm-Gg: ASbGncuE5mU42+qGKnGv1u++t2IyRj3NZ21jBm7mqPg9m0Pw3kYY1Qmm2eBUI37xp+P
	5PsRVd4jlgUp2y3YNKYzwC75jPuLewek1DwJiz+sQ94/w6VuFOZjST20g6R9Vor/Yg0BtFjt4tr
	yBYt4EGUvyd6UXiF2WgEuil/9MmQmNiBW/+FdSKwWo6aRHfqek3GZKqoy9Q8qGG9yBrhQMdY5Yq
	b8/q5sICzjeT5BmkkoNRxBnxu2S0JJpapZK6lbyag0+xy+QXsC5lZ2xICC4XEJdZA9Zd3bJvmy6
	wXMSVkHuq9v1H3ZoRj64BifPhbBLunbCdiNUWXUVEdW8XgsBXc1R7OHYwHgoWeyJSAUTFiK4YxD
	f5sQSRMTBNBxx/edw
X-Google-Smtp-Source: AGHT+IFkHW9Ch+UrfyFX4GKPbdlIDvz2wh145OyBe1favuUANibDg81i86DIOD630S1dqYyxBWGiOw==
X-Received: by 2002:a17:903:228e:b0:224:2717:798d with SMTP id d9443c01a7336-22649c95c62mr45177375ad.50.1742398556084;
        Wed, 19 Mar 2025 08:35:56 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d69sm115552035ad.158.2025.03.19.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:35:55 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:35:52 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 2/4] igb: Link queues to NAPI instances
Message-ID: <Z9rkWLEkwRJXYo2x@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250319-igb_irq-v3-0-b9ee902143dd@linutronix.de>
 <20250319-igb_irq-v3-2-b9ee902143dd@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-igb_irq-v3-2-b9ee902143dd@linutronix.de>

On Wed, Mar 19, 2025 at 11:26:40AM +0100, Kurt Kanzenbach wrote:
> Link queues to NAPI instances via netdev-genl API. This is required to use
> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy polling
> support") for details.
> 
> This also allows users to query the info with netlink:
> 
> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> |                               --dump queue-get --json='{"ifindex": 2}'
> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
> 
> Add rtnl locking to PCI error handlers, because netif_queue_set_napi()
> requires the lock held.
> 
> While at __igb_open() use RCT coding style.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>  drivers/net/ethernet/intel/igb/igb_main.c | 43 +++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 5 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

