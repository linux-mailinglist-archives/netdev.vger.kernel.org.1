Return-Path: <netdev+bounces-177749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1915A7184A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087687A1BEB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB951F3B8F;
	Wed, 26 Mar 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu8n+etb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C81F2BAE;
	Wed, 26 Mar 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998700; cv=none; b=AE0R0Pww0as0YbqlmYXfVbbXmaadDEtg717o+H218zEmZiKwpTNjH60HxSCjdc54Ax2bUAQyT95ZdYxGEg0xCRpz17KShBLZH8iGvHFIPwKHLEzPDigrVMVSd9PJMpdy19vuRB1BaCLjDta0xsFols5nTWLXBU51fGyKTEVCs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998700; c=relaxed/simple;
	bh=8bcK5d2/qC8I3AUmJEOcDuylXBqQR2veB+WRzdPZfSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSGrUcDUAWofmLsOfR77zqfkbGF1FkOkzpF6QYSHkx4aN+wg13b5A7nuljeDGbAtKFE8TjAItzPmiG7hCPrAHLQ5/zdWDxLARUkLebIUdxPnRND4+AjIfNjxHryZ3DXZDJwW+mCjYOnGWnUmNL7kuacyKagcKwHtBVjaOvMSx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu8n+etb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225df540edcso18867765ad.0;
        Wed, 26 Mar 2025 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998694; x=1743603494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdfuJsHH9Fc/T6Cr0np3SRpFWTfbwtIC0r6vigC/3Dk=;
        b=hu8n+etbuNehWE69nTiLxye4DkJyREAT3EBjej71xU7R9X+Qvu8QyZhmj1q8YFjw5v
         Yl0lNAOgO/BKYfrclbKeX9UB4zxhXyozXHGoXvvrdMgR7UwsiapDWvONMncu50XRBNzX
         Hf+XdgbFdGAkFOjvKR5mM6Y5bZQhfw/XT+VOx0EYAa/QniOiuIX3peM/s78X05ei7JeS
         PO9EBxQFb6H6fC/57ZzjXBkZmluNEAuAvEvpp0uG+tazV5E6W9rJ7RD488mqku/lC9Og
         O6j6jVCHaD7EVALpT4gk0jUcjfLTfCLAq6pAx4qyBfdgubFvrl7z8DTSTHonnJYWeng3
         s2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998694; x=1743603494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdfuJsHH9Fc/T6Cr0np3SRpFWTfbwtIC0r6vigC/3Dk=;
        b=JgSLQodP45+j3v03bJEC3DVV8YVLjTViPrS1hAWr6GKtOOjnXFOvSf8OsnXYRyRK1U
         VKcYegZ1YNsQLF4GcMXcSDyjaH2VJHRRL+1jAl28T4ajIWJZfwL3bBZ2GJxiNK6BEBlW
         EFEQiavZm0h6rmYX2aQmOzQYP10ADi4gH1Rhz8O1mXs9a3A33gQwIs4rcy3M+adfSdC0
         wChOHzPscPnF+6GH+mPED2gmmF7w+wVMNLduPaCM1ULm/jgo4qEedDyfHM+Wl7XEGcNO
         UjdXkw6XFosK2YYv9x2LxCYLd0SzoXeVn8JrqjG4mT3uSwZtgrziHQ8A7ULqOQWD9doN
         fOpA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7JMGy6DcptiCpxxeSLqupxAwJ8j2wtm/hnlW8x/64XXskFHEBnZ+Aj3Wr2Xp9/S42OxodFEp5BuvKVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKYSNu7XOHH+N/ng+CwjipbaLJEUwrcEeg294Vrs9Iv8O0c4P
	e4BUuCpmFMxRC8/qZh9oUorMZIlvLOI7ErdcIjpjaqyI6F5jzKRk
X-Gm-Gg: ASbGncvSKZLjs5GUhgH4IUxHHt9byX+AewhGmYYLU3/DqRzs17f2xb2m1zYNAzuhVnm
	PU37pUhvq5+zJ4fCiRWFivGCvhDIxs1IJwH2aThs/+/2zZAbU0srfJH0EI20FXjA2DgGbvaosC+
	QUyoIJLVmkP/PgZbyUMw7xU7rNimC5ZuPAAnRfuYigOUEtrb2f0m1JFefPH6MST6I2GSCG/34I+
	2YUNAlIRJzcppiD8bbqayiOR6vSlO//j31sG8EUDxkpY6dWA+6yEQFj4Fgvb7zztWabU9dsodoI
	QiArsDvgCJECx7tOS902i+70LnlHEVtorwPdr53GqMpsYxdn2w==
X-Google-Smtp-Source: AGHT+IEOEN6P4Ub7FQAgAAwCVbor5mBmKHEVuSk33lHmPw4pAlsWd6k6ZtUxZsdr0hm51IOR/+fweA==
X-Received: by 2002:a05:6a00:21c8:b0:732:1ce5:4a4c with SMTP id d2e1a72fcca58-739514f8495mr5928844b3a.1.1742998694122;
        Wed, 26 Mar 2025 07:18:14 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab1a3sm12236219b3a.21.2025.03.26.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:18:13 -0700 (PDT)
Date: Wed, 26 Mar 2025 14:18:06 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z-QMniz1QK2oqZJQ@fedora>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
 <20250325062416.4d60681b@kernel.org>
 <Z-PVgs4OIDZx5fZD@fedora>
 <20250326043213.5fce3b81@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326043213.5fce3b81@kernel.org>

On Wed, Mar 26, 2025 at 04:32:13AM -0700, Jakub Kicinski wrote:
> On Wed, 26 Mar 2025 10:22:58 +0000 Hangbin Liu wrote:
> > > I don't know much about bonding, but this seems like a problem already
> > > to me. Assuming both eth0 and eth1 are on the same segment we now have
> > > two interfaces with the same MAC on the network. Shouldn't we override
> > > the address of eth0 to a random one when it leaves?  
> > 
> > Can we change an interface mac to random value after leaving bond's control?
> > It looks may break user's other configures.
> 
> Hard to speculate but leaving two interfaces with the same MAC is even
> worse? I guess nobody hit this problem in practice.

It's the default behavior for bonding as bond will take the first link's
MAC address. If release the first link, then we will have 2 interfaces (bond
and first link) has same MAC address.

Usually, People doesn't release the link after adding to bond, but it do happens.

Hi Jay, any comments?

Thanks
Hangbin

