Return-Path: <netdev+bounces-92980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA188B97BE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95AF1C22D41
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78E5466B;
	Thu,  2 May 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbbMb9Hz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0454735
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642240; cv=none; b=Nc9Tt0EWVA/GfkFjVyFHczGQ6ReNgHQl+FtihANwFVuVCJbZ8hJ5QIlNM2ETJGBHiAqtTQYd8iF1ToUj6wHdedz+gE7PnTn/qg/ikHotEWd1euGW5pqYPHt/roAIYaatoM/aWm/M6vi440yp3136ZGFFFWZDLqvxEWhwMJ2aFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642240; c=relaxed/simple;
	bh=g/3wjd+5QLHutuyDd1Om5OYRKNIUQNWqYjNqlG7PDyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwq/ypYN7htGWS0R8vrgaE7+L4DwCqtjWzazTAlZrXMaUy2d5PqcgazKPLFX3DpHU8bvtYPd7VREGQ6ltEPi8B2krV1C0fAPYkMgS4IJNJgaGL/0xJtRSJWMg8RFhwSTGMHgqWUfwkwi80zgXapdxWC1c0jaaUNxVTeBS/Ogs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbbMb9Hz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714642237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+3K3coq7KFO882RiOjdUhEOAnmzVmTq6nI9Be4OYR64=;
	b=dbbMb9HzzXrPeYae3GfXEcC8BvgbacKFPSDSwSJBsqYthLdsA/V5OtmeQzkBVz1qDGZ366
	C1cUGy7TohxF+vkktGbL5UMnBH2LVL9NL6Go8omM1wIXb4OkQIHvV6EhdcHXMRg69qEY1m
	Gs5p7rFrzj25cMqphAeyn9DBGShfOQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-Oiumul9CN4iHtXD-ctsNEg-1; Thu, 02 May 2024 05:30:36 -0400
X-MC-Unique: Oiumul9CN4iHtXD-ctsNEg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d7a7585f3so251065f8f.3
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 02:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642235; x=1715247035;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3K3coq7KFO882RiOjdUhEOAnmzVmTq6nI9Be4OYR64=;
        b=jf0pFNWNRfzWuCssrkoj3AKpTovFsVI++1IM4aoBuFLUNv51kdiZM3KU+a69gcoJmk
         uiIZic7Uxe+/ffBmb3IIBwdOmgVhBgCCijBUDN41okH6/4yX/kGKqS/LaGjmkzpMuKrv
         9DrwQWpnaJ0Pw7zCkSM3NcoyO3AfTt4D0nS9lVnM/UzCfnbXInR12MjM2UD3aZ3AWtQ+
         6GtFB8bx9qeC0NymSBWARI14f9+roT+gtoCxUynq2RdSVeSKvTxa2NOtg8UN4b/GTaEd
         EPqhv3HdXDpYc2pj9RSir62SuQDP5W13prFnvvtFKnoBjUC1HI5OgUO5W2iLscYGinIZ
         QD/w==
X-Forwarded-Encrypted: i=1; AJvYcCXz5kQXTx0rVN2tgOoZ6d17Ep3UPszHuuInDogKPDiRPAyqISMW13y9AJ798Xy7pXH9nYd9PT9g2tbZLn2kjssW1V5htjcv
X-Gm-Message-State: AOJu0Yy0/agBhj8S0q10IG8p39L/vW5MROjM8cJW3D/wYhYdpcjcLqLW
	sN8kYVQrs0Glfb3J+V/8w8LtRtnM7f0dANITlPNEOeW89HZYLK4PczdHMGuWj5PfOkWPRVVCGpM
	M2AV7kLBa8/aNwBp+S+tcCIHxtM3YasjyiCXTARugJwVRvQZBc2tYEw==
X-Received: by 2002:a05:600c:1ca4:b0:418:1303:c3d1 with SMTP id k36-20020a05600c1ca400b004181303c3d1mr3596482wms.3.1714642235184;
        Thu, 02 May 2024 02:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1bNs6qzIXMi4CUUTIzKRcRqNSrLhSRmikIKLVuYNnz2Y0gbsEYvxA7AIt1qWVz2Jk82q1Kg==
X-Received: by 2002:a05:600c:1ca4:b0:418:1303:c3d1 with SMTP id k36-20020a05600c1ca400b004181303c3d1mr3596466wms.3.1714642234785;
        Thu, 02 May 2024 02:30:34 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510:426c:715f:ad06:c489])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c311400b0041bf685921dsm1319393wmo.0.2024.05.02.02.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:30:34 -0700 (PDT)
Message-ID: <e0503e3ff778955d2e2b94e746193a5ed73cf61b.camel@redhat.com>
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
From: Paolo Abeni <pabeni@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, duoming@zju.edu.cn
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, jreuter@yaina.de, lars@oddbit.com, Miroslav Skoric
	 <skoric@uns.ac.rs>
Date: Thu, 02 May 2024 11:30:32 +0200
In-Reply-To: <8767454a-2d5a-4c6d-b887-440047c9bc5b@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
	 <7fcfdc9a-e3f3-49a1-9373-39b5ad745799@moroto.mountain>
	 <1402dfc8.20a4b.18f37963e87.Coremail.duoming@zju.edu.cn>
	 <8767454a-2d5a-4c6d-b887-440047c9bc5b@moroto.mountain>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 10:56 +0300, Dan Carpenter wrote:
> On Thu, May 02, 2024 at 12:35:44PM +0800, duoming@zju.edu.cn wrote:
> > On Wed, 1 May 2024 20:43:37 +0300 Dan Carpenter wrote:
> > > I'm always happy to take credit for stuff but the Reported by should =
go
> > > to Lars and Miroslav.
> > >=20
> > > Reported-by: Lars Kellogg-Stedman <lars@oddbit.com>
> > > Reported-by: Miroslav Skoric <skoric@uns.ac.rs>
> >=20
> > This patch is not related with the problem raised by Lars Kellogg-Stedm=
an
> > and Miroslav Skoric, it only solves the reference counting leak issues =
of
> > ax25_dev in ax25_addr_ax25dev() and ax25_dev_device_down(). So I think
> > there is no need to change the "Reported by" label.
> >=20
>=20
> Ah...  I was really hoping it was related to the other bugs.
>=20
> Okay, what about we separate this into different patches one for each
> bug?  The changes to ax25_addr_ax25dev() and ax25_dev_free() are
> obvious and could go in as-is but as two separate patches.

I agree it would be better to split this up, the changelog itself hints
at 2 separated issues and fixes.

Thanks,

Paolo


