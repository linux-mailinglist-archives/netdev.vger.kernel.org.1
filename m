Return-Path: <netdev+bounces-204289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8DAF9EBA
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5158C567460
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FAB22DF9E;
	Sat,  5 Jul 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDxJQc0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00B1EE7B7;
	Sat,  5 Jul 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700248; cv=none; b=Gk2wRfBOXcEgxAr9bSp7jxteztqX1KgB3PHDOMFS75jUSbQw3SCAEKIFr6zmgVraZz8r2axxAQnV80mKOR4aUSOqq1PezfQtvNU8yFY9fVJQ/No12hXidddQZswVEazEi8CM8g4OU+Bya3msO9IMnBtVEoVZNErt8F+6WXblXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700248; c=relaxed/simple;
	bh=Pz3cRcv1zbZ1CqC7+IZQFU+GLGHXpowDH4OC66sRtkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ke7SqGuUMr7HcWAHZWdImZrspDfSAZMfDa4NywfmEMXaJ3o3ErjUvoG815CeX571jFsissOQucj4I5MfcrFkCH28PIqfWjaKPgQB85UB70RdA9aTBXscZRr7FSbWdz2oArRAFX5zhLeG9Oa4Oq4TiUo+F28+JRDBAgV3aT00CQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDxJQc0/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso12224085e9.2;
        Sat, 05 Jul 2025 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751700245; x=1752305045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLS+BRlEsONV8EMZAn62VOpB8R0Xfmr2sdk/FeNAY8c=;
        b=ZDxJQc0/AgHmfgGGttl2qzXXWlKV1Gqtk4UdIUAgWDV/2FmUDQvsewWGW60kULHgeO
         G5HgJgz5gkOiIZgdWoPycq6wwYJYQSbQgfwfXl47X8GoThG9BGfTPkYPuvui34smpoEU
         m6btVOiX3l17JWhrfUlRRnjCqlOx3jNJHbT6VGlkeyfkMXbji/RhKvbSPr44yEbRosf0
         8rMuwC88k1haJBAjrsk3Oi7mN4DyikeMlQ0P0tEmpLZI7AFyMIYJmJ3Q23+g9RrclTyn
         18B7yLgTTeOqtHpgJNUw8vXvYxVuSMOUdhdWQ85D5L1M3CnpsZ93woLYwHmWf+41+O7e
         jt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751700245; x=1752305045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLS+BRlEsONV8EMZAn62VOpB8R0Xfmr2sdk/FeNAY8c=;
        b=GcjFnuGy9WDnsyMRkcxzO+VVgTKI12sct4r4+Yc+nMx5DdXBWZIZR4fMFwO1TUeT8u
         vH0U8GUoipyQtzqXrYfPd9bSK1HlQw8w+iReKZ8Kn8iD/XSIARPlnKesVfg18s/did9t
         hdzGZB4e4lHK6IjUI71iqMkFaInr53AOTHJ22g768nT+F9/apCg7Pkl8F5dpYE6925LK
         Vsqkf0NwZTqbvtFUZpx4vOo6OZ08/tAX+50HFfVz5AgmQmhpD7pA/xEebmMACB70DKsf
         WAonu59Tlw6Xqgy9+FLDkXog58uNtpflx4ps4guR2+hKX912yaLRRVeaBwIQajXa+q9b
         mizA==
X-Forwarded-Encrypted: i=1; AJvYcCWBc8cvkMmLgVHVzJvxVyei3P3kGpI0EVUqRwXorgXz9njv3Wp9o2xPqqdtefrYjPl899KltHj4E4H31uk=@vger.kernel.org, AJvYcCXcD+YfIrTAUkcTQqe5nZuM5L54DE07O0BJOuFfa/DzrROtvFO/0ftnfyHnj9IwURMFAUC7k9Ui@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cls2y/keyham6CNbBo01+D46yU7F6IEuqqGWGxRdY9v1ek3B
	67qLmxPw0hBzwLKdDRGmfW4osEuu6KZRN2uzDgKH94ihWt649y4vAOGd
X-Gm-Gg: ASbGncvKW02NNfWYOJozYqjFjEHOfh/UISNnG7yLmCDoFjYRTdFQtAXrZxotTp2n/kc
	GmruFwlPf6a+mHhzQ/IGqZTlABjL95eqAybvWKQK6dd1sJHEm22oHLGGosb57O5VW4N6/LWX/fq
	FU9Igw3sEgW8KN2d2oT5NX+A/i+67ahnzoVh8ZiUd2kcS4gOGEPCpN8MjW/konMMWcmCaGx/6pN
	jsKmLWCje4dYRps1A0xjA34SKCOYGhNYAdVU1PmonPBjzFgBufSP/8XDA8BlbuT24t+7HxBQsen
	9y0OBaWUINz3cdySwPYvtK8dN2bWwSNNnr0RP9Tlu/rm0EAPDYwS8LxB/iXPSh/b0VR1KMSGaPI
	mVQgQf3PKjOAv0P1UiA==
X-Google-Smtp-Source: AGHT+IEq1kay//NkWPi317mX28rlE9Lsk8PLXX7RWA+9ucNeN6EWr6/mdhwPeCNmiUDCSELuiXWCrg==
X-Received: by 2002:a05:600c:1907:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-454b4e76790mr42199375e9.8.1751700245151;
        Sat, 05 Jul 2025 00:24:05 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1695577sm46582335e9.27.2025.07.05.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:24:04 -0700 (PDT)
Date: Sat, 5 Jul 2025 08:24:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, shenjian15@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] net: hns3: fixed vf get max channels bug
Message-ID: <20250705082403.0ba474f4@pumpkin>
In-Reply-To: <20250704160537.GH41770@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
	<20250702130901.2879031-4-shaojijie@huawei.com>
	<20250704160537.GH41770@horms.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 17:05:37 +0100
Simon Horman <horms@kernel.org> wrote:

> + David Laight
> 
> On Wed, Jul 02, 2025 at 09:09:00PM +0800, Jijie Shao wrote:
> > From: Hao Lan <lanhao@huawei.com>
> > 
> > Currently, the queried maximum of vf channels is the maximum of channels
> > supported by each TC. However, the actual maximum of channels is
> > the maximum of channels supported by the device.
> > 
> > Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
> > Signed-off-by: Jian Shen <shenjian15@huawei.com>
> > Signed-off-by: Hao Lan <lanhao@huawei.com>
> > Signed-off-by: Jijie Shao <shaojijie@huawei.com>  
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> >  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> > index 33136a1e02cf..626f5419fd7d 100644
> > --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> > @@ -3094,11 +3094,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
> >  
> >  static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
> >  {
> > -	struct hnae3_handle *nic = &hdev->nic;
> > -	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
> > -
> > -	return min_t(u32, hdev->rss_size_max,
> > -		     hdev->num_tqps / kinfo->tc_info.num_tc);
> > +	return min_t(u32, hdev->rss_size_max, hdev->num_tqps);  
> 
> min_t() wasn't needed before and it certainly doesn't seem to be needed
> now, as both .rss_size_max, and .num_tqps are u16.

It (well something) would have been needed before the min_t() changes.
The u16 values get promoted to 'signed int' prior to the division.

> 
> As a follow-up, once this change hits net-next, please update to use min()
> instead. Likely elsewhere too.

Especially any min_t(u16, ...) or u8 ones.
They are just so wrong and have caused bugs.

	David



