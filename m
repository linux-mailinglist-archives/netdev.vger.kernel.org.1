Return-Path: <netdev+bounces-114962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CEE944CF2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F81B20C66
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68951A2C39;
	Thu,  1 Aug 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YjElgTb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724C14A611
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518052; cv=none; b=mErOsnnJkwjOpfaYSwV7gIv4CU+5LNRIJwEYVQiM4Tdjpf2vprmhgQ9S3n6WMUiNPDN30+VRi2jxnn24GXcRuqHyuxCHtTcglpkMojgXPfvoq/YthmN9xHYRjn8oFNpNGDWcD/9ooe/tjbpbF2hsvCFZug+DHGyzUIS7fU8GvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518052; c=relaxed/simple;
	bh=OfZ3bDvGx/mlDmniVqFGjbuBBbNEI1lO7D3BKzUqh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grSCus/5jPmbin2neL2XB05TNn7R9PWrXAWGSx9kAQzTLozX7tvCgLvgk0pU4fce3rXyiNkCu1Ot1gV/vFZ1DlFlYXY69n1KJtAJ0rPRIuZQ57gBaD5+juWNfsSAesrFLqfk2IcjgBYpleY9yP9QStyhH+2bvCA8tIsnXhZxREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YjElgTb1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368313809a4so1246173f8f.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722518048; x=1723122848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1zAq2A8tIjO2hNDIqGfuwyFl2KKWufIdH/9uRMO7aA=;
        b=YjElgTb1nr8qjdfRmxsv47mH6knl4RN0nPw28V0NyKBs44oHfZyfU68ELLYiz5uikA
         1VEtmWYhsbj9vKS9K+VIsoVeuuH85ywlghUdpmvw9OCR49jIVQyjACJzQrCR3/zxYL3T
         8dZug4bpeA4SyTzHJZQIAo9t2nX42LLVsSzjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518048; x=1723122848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1zAq2A8tIjO2hNDIqGfuwyFl2KKWufIdH/9uRMO7aA=;
        b=HfOsPKMPHumYZowbPrSJ6CQi0nQqncytEnxNt9U7cQ5c+zrfbmmVhuBbaGBlJuQ6W8
         9tlocBR2Rmvbrv+FtI/smjiHuSs/6WTIdQY7jjV9U4u2sDy2OsbhoJct5CdtMpUzMzp2
         vlUphCxgwm4iNc6r6o8kJO+lNUlD9vERX1AgQA3884GMn4yWRJlyGrvubWGcgneWt7Pn
         EgRiFNViEhPn9700Ji2UmLFiJ7Db2NXbtzC3D3B9daEgVUoDFjI1ub31G9tgpQSmJKLb
         UJzQnuzmsfDb5hiJRRsRk7O8zxvE/aW/PtFgm7rIcfA16bNhEB96D3hPe8+I9XX6cYjz
         Z6lg==
X-Forwarded-Encrypted: i=1; AJvYcCUgEYDsPrK3xQGd1fEj9XVN55nPSc54bgZLOyxOGNFuAkjmTCNE9LbZ/O+FQZ7NzHb24V3lU62hMQVj5XRAb+fSFUFLxXFb
X-Gm-Message-State: AOJu0Yz425l47q1WJjG3UMRat7PH3H78ENDLnt4CU3IWpqkYcSf0L0H8
	Q9JFfI7JzzoqMDv3O48f7FZHnR6O3PkbiKSnOyq7GIQM6f0x+FAf5flsBnCbLRk=
X-Google-Smtp-Source: AGHT+IGY6C6HxMfYIEbuN5skOyWJua94QhKtVofdw583XyL2PipegA2/E/h1+XhGjqNYBfKRCf4SUQ==
X-Received: by 2002:a5d:4251:0:b0:367:9048:e952 with SMTP id ffacd0b85a97d-36bb35c63f5mr1373341f8f.18.1722518048015;
        Thu, 01 Aug 2024 06:14:08 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb1dfd6sm56904175e9.42.2024.08.01.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:14:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:14:06 +0100
From: Joe Damato <jdamato@fastly.com>
To: Stefan Roese <sr@denx.de>
Cc: Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <ZquKHioPb6SMpztT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stefan Roese <sr@denx.de>, Elad Yifee <eladwf@gmail.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com>
 <ZqirVSHTM42983Qr@LQ3V64L9R2>
 <CA+SN3soUmtYfM_qVQ7L1gHMSLYe2bDm=6U9UwFLvj35odT0Feg@mail.gmail.com>
 <17deb48c-6148-4e3d-aa0b-6c840f55302d@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17deb48c-6148-4e3d-aa0b-6c840f55302d@denx.de>

On Thu, Aug 01, 2024 at 09:09:27AM +0200, Stefan Roese wrote:
> On 7/30/24 20:35, Elad Yifee wrote:
> > On Tue, Jul 30, 2024 at 11:59 AM Joe Damato <jdamato@fastly.com> wrote:
> > > 
> > > Based on the code in mtk_probe, I am guessing that only
> > > MTK_SOC_MT7628 can DMA to unaligned addresses, because for
> > > everything else eth->ip_align would be 0.
> > > 
> > > Is that right?
> > > 
> > > I am asking because the documentation in
> > > Documentation/core-api/unaligned-memory-access.rst refers to the
> > > case you mention, NET_IP_ALIGN = 0, suggesting that this is
> > > intentional for performance reasons on powerpc:
> > > 
> > >    One notable exception here is powerpc which defines NET_IP_ALIGN to
> > >    0 because DMA to unaligned addresses can be very expensive and dwarf
> > >    the cost of unaligned loads.
> > > 
> > > It goes on to explain that some devices cannot DMA to unaligned
> > > addresses and I assume that for your driver that is everything which
> > > is not MTK_SOC_MT7628 ?
> > 
> > I have no explanation for this partial use of 'eth->ip_align', it
> > could be a mistake
> > or maybe I'm missing something.
> > Perhaps Stefan Roese, who wrote this part, has an explanation.
> > (adding Stefan to CC)
> 
> Sorry, I can't answer this w/o digging deeper into this driver and
> SoC again. And I didn't use it for a few years now. It might be a
> mistake.

I asked about it because it was added in v2 of the patch, see the
changelog from the patch:

  - use eth->ip_align instead of NET_IP_ALIGN as it could be 0,
  depending on the platform 

It seemed like from the changelog some one decided adding that made
sense and I was just confirming the reasoning above.

