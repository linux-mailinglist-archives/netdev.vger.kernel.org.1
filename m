Return-Path: <netdev+bounces-201356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E1AE92B5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEF1883515
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09911287249;
	Wed, 25 Jun 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHUQvPLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5A2DD5E3
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894047; cv=none; b=gK1BRJaabn8o81tIejsGdHKP83XgZW12H0hCBiODFYKDJBj5GU2L9Z7NR/zdIBGeaRZ2TQmoV5a77UL2MANirQ7g/z0fWoCVwzor0lRAZBtY+Oowui28DcqC31IOQxcE1oB9+3tfmKepKhi9Hv3W6W6ruF5boXyoAmCaOVXVdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894047; c=relaxed/simple;
	bh=kx0FBz5kxfLMHCooOeoxb/WH5qJa7rGUaz7/wvuEWhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn/WVCwWWyAt8V5XrVEenyzbIAWO88KQXbD6F4p+J+gvjlvvdKo8MKudBtHeDXeOnP6nRZfQexmekk07DFH5QJDgk7l/Son5JC0yh3TzYCvdIkkNNgmL5uIaBLoGbTZghsvWxihq0QI5U3U8tr2mEDhC9ZXZjBGI9wWiSbX692A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHUQvPLt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f270513bso35045ad.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750894046; x=1751498846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx0FBz5kxfLMHCooOeoxb/WH5qJa7rGUaz7/wvuEWhw=;
        b=MHUQvPLtfZ2fUVsQouD0s4A4F8YbYdmzsfLSRjE0Odbl64jTbgle2hXQS0VAU0Ujg7
         h0NFCkW8/xKnUCerniEisdvmcqMSUuxyIMOwOzbVxtVbp+QpUft3DS8FcTVjX831isNT
         FJfBb2CwejjrwLawiDTUvuEKmmF1YtUW0Zlha85rfPSGkfjRJpUwJ8baaXY0ChViaAYG
         3lqfjb6Gbgvay8G/tcrmXmLFat05bvKUpZyLYon8ViXascJD671XIE2sKtzgYrMnA9yn
         UrmAq7DnBOlWg2+djsPWwgq6gJw9n5W64ah7EkL9x5bXKNq6qeeE6I7b5aRfu0zrvmaw
         9zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750894046; x=1751498846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx0FBz5kxfLMHCooOeoxb/WH5qJa7rGUaz7/wvuEWhw=;
        b=BrRv01X8CDESeuoIeLWpJFp+gvFdAau4Q4S6j2GIFMKiOmYyUPQPR0VpyVEImVrsZZ
         wnPU1W0TBBwI/rJuCegK0A/HSv3v1zazogs5IByPlrxmS5PwyTVqZrJTK2oI8NEaWBR2
         OTfit33SfjiplXsqZyWTpNReSFnGxkaQSkCfYR87RiKs+G1rkr7y1Km3kJF+HI53tRoZ
         stzrExPz8WpjWzf71/4pwUoWO6QogzbLBZce1hHOOOl4WBKsW6LxcaEp+jyBfgLAxmvF
         bOQtraUceNP6mtPkoYN5LlTbzJ32XHGt7Z4fB4ndavra31tHWNWXxRCuOFjCT6ZyejOb
         RhZg==
X-Gm-Message-State: AOJu0YywdKzyuPGyBmQ5pIMfDxsD0MzxMjhcP/k5aKc/1k4ZLFqgOgoI
	vNCkVYXZQVuyKz77qqJm+0QOcVILPG9mhamloQIvVI8TNWHzLuYYekuh/ZqL+CT5Ifz2b2v+xqx
	0LZvEhezZFmuBL+0yHUflA1eV3L1XL0QM78RpgTrgyc6m2h6ZiJE7NGbE
X-Gm-Gg: ASbGncuHGpBqs1sYmI3StzTzgn30+T6FRhwdGfIaFqqmSglaOsqrsk45+ZfmjCjhd8I
	qrRtkc8buRFy/X1io1GbUVIcEVcwjM5v532NbDnE5Qc10NCtSPQa2wQh6o8jfnv+9nYgIZaHYWo
	HOoHWYzFDbGEhDAEqI9+Awvcb00vYIH2F4vzrDRVbvz2UUdKUti89lMXyuIcqNyrmPk4lTu1S3F
	A==
X-Google-Smtp-Source: AGHT+IFrGat1M8QP/7zoAcIXKoils2gNnPA0GSx4CmoITbKm6/QYmlQ9DspDtT8SNS7GNjrlk9R+lu+OSoZ7G/MIqco=
X-Received: by 2002:a17:903:1209:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-23978ba18b0mr1206005ad.24.1750894045108; Wed, 25 Jun 2025
 16:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
In-Reply-To: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Jun 2025 16:27:09 -0700
X-Gm-Features: Ac12FXw9dIpBvK2gofOzg6ZIJftbo8Gcj1PZacPrSRZh88xnBf67PtMxM5KLs40
Message-ID: <CAHS8izOCvLBWee3vp-Xv_XATztcTA2Rnu7CDtRfN+2CHo_cgww@mail.gmail.com>
Subject: Re: [PATCH net] net: libwx: fix the creation of page_pool
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	mengyuanlou@net-swift.com, duanqiangwen@net-swift.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:41=E2=80=AFPM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:
>
> 'rx_ring->size' means the count of ring descriptors multiplied by the
> size of one descriptor. When increasing the count of ring descriptors,
> it may exceed the limit of pool size.
>
> [ 864.209610] page_pool_create_percpu() gave up with errno -7
> [ 864.209613] txgbe 0000:11:00.0: Page pool creation failed: -7
>
> Fix to set the pool_size to the count of ring descriptors.
>
> Fixes: 850b971110b2 ("net: libwx: Allocate Rx and Tx resources")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Looks correct to me. pool_size is meant to be the number of entries in
the ptr_ring indeed, not a size in bytes. wx_setup_rx_resources does
set up rx_ring->size to be the size in bytes based on the
rx_ring->count.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

