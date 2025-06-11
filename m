Return-Path: <netdev+bounces-196478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4CBAD4F64
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFAD7A6785
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC92417F8;
	Wed, 11 Jun 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdTS2ryo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1A13A3F2;
	Wed, 11 Jun 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632951; cv=none; b=Fy9vQ+YIWlDp9PWmccV9GpxUV1tjCDEuMAhn/EKZMYyEGZvguXEJUTQn4QdpvVlRcF5KtM7/4swuuUqvVuvEQNGhoEHXjROCfnc7+sIYSC89h8UmYZ/Or5pjPyenijsOhs/qFvenE3i0FIXr1G0ZznwrU2UK4FRF4SveUgoRAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632951; c=relaxed/simple;
	bh=/ulSuPmv3Z31n1JyJiqmNsB3uzV7uIoVWgBAXmxAlXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5ci/i9YrOwf2b5ibSA1IstnGku+8eaqkiVwgHsx6JJrh9xAd5FTVV17Pli5HzlNVLib9KnRhm7IBszkpF39BoxIiej0AOVEq2FzLpYliVUx1sQ3ZjKpjRxwTCQZ2oqwCwEzmdSPsdnIaz4a7ozzW4G4/4CVSMtbvX0dM5v3jJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdTS2ryo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c56a3def84so584202785a.0;
        Wed, 11 Jun 2025 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749632948; x=1750237748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0uNjouf1tVKiKNvEBer2Dir89BlROQ9UZqvbNds5Zs=;
        b=HdTS2ryoOiOcjVPX881Cr4xqw4anyXRg+n33tWF3ya3c9U7BmL7vaaNyJ8xRs2Tvw5
         5guzwFZtPmbXWfzx2FVrxbYzPkeNOb0IQ3oRG44Z54ShEDIr6lX/dc9VWpB+zCsK3eY3
         kE3SQ8KSos5fwI/zyy/sAEH7SP2pIP1FLal/v3suAndNKsexu35FqR9VCiQVT0oWzloG
         fXUKG3IOK230K6tGKB6IcP6uiir3uHP1AV3fq6sM7b/2RikRwOLk13cL6rmLpuhHT+F5
         7wJM+J+Ezn/4foFqLU/bSokyt6dk5/SFAgb6smsCFtxtm9U//fWDHPiSRUbwKjjYFSJb
         tRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632948; x=1750237748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0uNjouf1tVKiKNvEBer2Dir89BlROQ9UZqvbNds5Zs=;
        b=XeOx9bCAPr7WrSnrw0rsmMn+lLwgfssy5KSv4ifDaCDqr9tIzDXuyO21mYnblyLzLQ
         92nVcl1LIiCIfBrG1PWavzhBxOL+OvonSlP1aT1MixxhIT5Jg55HRtWgRMluuTKwEHX3
         Sc8hrm7SsgddRDAWtiU7FalYZtaAQPCnzsiKrG3iTLzJb2N02CS21BbCs/reiMslpibK
         Hh1drOkYtGdGnGrrz2zZ1c639TbBDmnYBx212I1GE2cmhl7o8b3fOw+9oF5B6oQ+9Ctq
         kwqSQgJUF+DU7Q9oDMsYQJ9c9qaUh+PObqhHVALS3Go9MdetXWzEW1fIETVT9tSyQvm2
         apKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmIijSljyxS+nn5nNCNoI6h833QJ+ki9WY05fnaFDdG7SVEXxQf1NYNkSEtuWaD44/ztySviR37RIkhck=@vger.kernel.org, AJvYcCXPW43MuZESaZh7EML/RgPKsf+aieDe24522FaTDRUX6axo+nLE+FVIgglzYP70xzykW4YPNEMR@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyB0wpVXAqI/+xIusaR1O1K2/aAN6n0tw66hPmB0GKEuD1tmU
	+J6hjmJ8OXyCrJy++ANiV43JKbPY4QAtoUXJshZj/5Ao+kdqDGQ/IUQe
X-Gm-Gg: ASbGncvUWZzbBkhoM/sRtZidAybMQ8osGd6uKm7yC+KjzTpBocCLO6w97wnH3FbVnPf
	7GKGt15a4M8pyZeRtBbZHDAzcqWg3Tfx/FbqrIggysUgyWgPy2SF9ByM8xxfweeMgjGsOUGvA+g
	GOKjTFe60d1G3AeaOutYyZNKbJgAl8cWzO5HyGSzIEZvfDJ+NOjvKUykAS+7WTvyKw0r/LxmcG/
	GveOIG6d717zUK1II2rBAcs28LgDEgIfrEfkaNhELxo8Dv2N0f9/s9DKkiQJuItccRW3VFhlTyq
	oZAsoRARqe1Y2O0+gOfGJIiYHfQK/Mx8dv63jmR3h+jT6ScZ90/PU/vLLQ7nzFAmqs9ccK8JA2U
	l8fz3Bhjf4Fo=
X-Google-Smtp-Source: AGHT+IFy9aKXEbpBdOIwlB7FEB9sJJStW5dF+mQfKY3NEa978nxRPDFAr1gnJPXdH94Fwr8xDTw7sw==
X-Received: by 2002:a05:620a:6289:b0:7d2:107c:4228 with SMTP id af79cd13be357-7d3a88316b0mr370207285a.18.1749632948405;
        Wed, 11 Jun 2025 02:09:08 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d2669b4759sm839297585a.111.2025.06.11.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 02:09:07 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 55B993HZ000421;
	Wed, 11 Jun 2025 12:09:04 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 55B9919M000418;
	Wed, 11 Jun 2025 12:09:01 +0300
Date: Wed, 11 Jun 2025 12:09:01 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: kalavakunta.hari.prasad@gmail.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, hkalavakunta@meta.com
Subject: Re: [PATCH net-next] net: ncsi: Fix buffer overflow in fetching
 version id
Message-ID: <aElHrRb5Vk7PzEAs@home.paul.comp>
References: <20250610193338.1368-1-kalavakunta.hari.prasad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610193338.1368-1-kalavakunta.hari.prasad@gmail.com>

Hello Hari,

On Tue, Jun 10, 2025 at 12:33:38PM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
> 
> In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
> need to be null terminated while its size occupies the full size
> of the field. Fix the buffer overflow issue by adding one
> additional byte for null terminator.
> 
> Signed-off-by: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>

You seem to be surprisingly persistent about ignoring my remarks on
your commit message.

So be it, since the code looks correct and reliable, fixes a real life
bug, and actually applies to the right tree now,

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

