Return-Path: <netdev+bounces-68454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F59846F4E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278BD29775E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358FC77650;
	Fri,  2 Feb 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFqcth6h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DA13EFE1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874212; cv=none; b=J+wUFpGbRaGXjb8zv73uGCl5rgo9P+wMmF0uYvKnjh9Wh5CxNwgaM46dXacUIb+xOnmg2XPbS3fhhbzP7o27VlWod3sqYS0bHGpnmliH2VVReO42C11QyRjPFcLk4K7BaAn7U1i+LSmEL021hZwijPuybQCSFohhn72H5CIn5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874212; c=relaxed/simple;
	bh=2CygvKSNNSwPxj641enH1rjHi5cr/Zfh9uBnsV7mZoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RfMZHRrob1SaNARJfGsR44RhUSX1/TOFtBXA0mPniUlQOvblrYasah5eaLMZr+4QCGw9/g/wPR8hQbQl2LSGlTURqbUId2GFnWzAF4XaHPORCyRX/Aj8swSgoSNJFulxTGzoSKICAJmVt/GV/aBZCEYfQYaSKmG3iAOgdbSeaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFqcth6h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706874209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CygvKSNNSwPxj641enH1rjHi5cr/Zfh9uBnsV7mZoE=;
	b=YFqcth6hmrgWAKOGoZWks7LuENt560BXirOBg8eeoa7MarE26LF2UcTdgqHIHAQbDerLMF
	T0IiBNoPtPJs7s/6xDooVuGpgJq8sNDrssxzdNL/qhmwMpvpt5w8le9vKRRmjW3hRanojV
	9ZvAfTCm6ERXEtrZOeAad0r/C592yC8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-oXqiye4PPNa5vCtkbT3psw-1; Fri, 02 Feb 2024 06:43:28 -0500
X-MC-Unique: oXqiye4PPNa5vCtkbT3psw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-55fe724114bso501233a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874207; x=1707479007;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CygvKSNNSwPxj641enH1rjHi5cr/Zfh9uBnsV7mZoE=;
        b=W2MAexv97M8NlifaEIqf/EjW0aPZTwCW2/ArlfxzH+NQgqEVQ+8G5LOmknQKRTdPln
         ZDD28MS0hWehshrQE9rodVSs1Uds4foPtduspNIz7YQrPCMTHFYl9wHiakIhhqLWi+o5
         DgWQzRxy25SEguuRC675nySt/fo7hmi+xdPPdla2FRtQ47FIqMF+6A/G3ht+jv/a+cBK
         hQ0SQpFF+shbKJ2yxVcxTSn33uMC91WLy0Z9BgrzctF0838xQxWLre1ZDLtggpEKw47u
         5ka+yRXjvNAuZQ69qZrGPCnoCT4flrJamLSMA4j8U9R5lII1UtmyiU3lHX3Rlb2TC5Q6
         H25w==
X-Gm-Message-State: AOJu0YwwBVBCsqz2nYXkEMqb2fLSxvBP8wXu/Z7MKa1pXmu3hRQuU2do
	CzNyfFOxLS88pHVtHP9g0MFVJFFfxoYItZZUBQeIZl2ojErg85mZaSIpFI8Oo7kthnDQt3SeFv1
	ecxPez3XnrmNSX1cAW63o7atR8s9c4jxDImGZTlyPLkrFKQ7MEs5uOQ==
X-Received: by 2002:a05:6402:2211:b0:55f:1728:3b33 with SMTP id cq17-20020a056402221100b0055f17283b33mr4341474edb.40.1706874207403;
        Fri, 02 Feb 2024 03:43:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI/kuU18hYpv9p+rkyP0JPEEB19+0uqwtQS9AFVGtwl9IzpCo1/jQC2jAQCRUFChFc9S0iBw==
X-Received: by 2002:a05:6402:2211:b0:55f:1728:3b33 with SMTP id cq17-20020a056402221100b0055f17283b33mr4341455edb.40.1706874207130;
        Fri, 02 Feb 2024 03:43:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU841n1F9cYtbf8JrkiKtNCIi5FVCnXgjn4DLv9d6ysrzc7SWQmaHRByR/yTjsLJDtfUX6InQAhVgfDTGyuYwELJIMkTkea7XbdOMn7065BiEPNEdVgc8LNfh4N2RjcExjJyqeYsookOKOUbaV+VBUOBIdK8s2OQC2ziHElLUV6L8sp2yYNds4OmCuSY9jIyPPGtwuyOIuaOiI9y2EO3e3pygHI4gdf/ub3DpdVRLO/qMmExMXyRt6mPRUk47+FH+hT50PBz09yin2/xbjQBnhiHKszXxf2Dpkm4Y7oRVl9WHV/JMq9SOBjfgxglAi+f43cobFE2vl0L+gH33CkcMWkOaugyy2e19ZSwWDjFtmUAlnxTdOnX9i97d1VYsYOQAgmEPjd16BMmZEaV5A5onHjK1lDqCU=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u6-20020a05640207c600b0055f63ed667esm727572edy.57.2024.02.02.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:43:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8EF98108A83B; Fri,  2 Feb 2024 12:43:26 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 4/4] veth: rely on skb_cow_data_for_xdp
 utility routine
In-Reply-To: <a9e7f6c9c3f14b43e9f963d767d396f0eb611c5f.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
 <a9e7f6c9c3f14b43e9f963d767d396f0eb611c5f.1706861261.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Feb 2024 12:43:26 +0100
Message-ID: <87mssjxfa9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Rely on skb_cow_data_for_xdp utility routine and remove duplicated
> code.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Neat that we can finally consolidate this duplication! :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


