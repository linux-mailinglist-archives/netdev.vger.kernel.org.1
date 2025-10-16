Return-Path: <netdev+bounces-229944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9CBE2539
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C6D189CD01
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5112FF669;
	Thu, 16 Oct 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjC3i+Nk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFE235BE2
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606236; cv=none; b=MMx7Ta08juwsC6tY+eJ6yPyj+7ME5isVCyFLZJZTrUv38vJj25yFyKibmfmMqt8Dm9bDlH5GpU/bJOBwkL9Lh4qlRox6IIK7chhEakgBvT8NwaVCKkXgNt53MM4PUx0ZCkNoy5DuJLPUYho2FQdRBmmZylvTfj3NjEbT0UZNynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606236; c=relaxed/simple;
	bh=gfUY6k3Za1yX/HAAk7zG4178blXNgWT89fTHHoWhQPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aExhcM0GzNlD4Bk8G6QJAu6c5nEOWS5/lAckdIj39elLuCArSa1/rf/XCqjd40X/3IxEGSraZgDkdT0vp6wKx2vTjbvbhWnC5C78pKGemKNlxiwxVqpilhgoCeRqalx0WEFmW16t7kx4s1GfbQS5eW4AvXr9yLDrRWb2ufC/iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjC3i+Nk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPLteLwS/Ol+pKkRNcrWyR6iIyl0F/A5LRNN9NP4s6k=;
	b=YjC3i+NkPHTayS3b759srOGUNUUPkDH10L5CbHKTy3Y2AegOJtawVzD7JXPOUFAOIIsbAX
	NhiMUwp0wcux9NsSDYij6AJTKxQfkdX/MwiTTGMlelSPHclEDV5q5zohjyTYZMG/tkJuut
	GoUuIPLz0ovSA5uU/zNr6sXsPL2bL+E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-L_QOYC_-OWyVKLJyHNi-BQ-1; Thu, 16 Oct 2025 05:17:12 -0400
X-MC-Unique: L_QOYC_-OWyVKLJyHNi-BQ-1
X-Mimecast-MFC-AGG-ID: L_QOYC_-OWyVKLJyHNi-BQ_1760606231
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso5093995e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606231; x=1761211031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPLteLwS/Ol+pKkRNcrWyR6iIyl0F/A5LRNN9NP4s6k=;
        b=j/l83KPgCCTZfSBCiyyBzH0DzHse2lnOIrVi3d5Jexrp8pJs+dmke70MFHLTyqUlnk
         5tX24aA2G2Sx5RRwF1brZ4y1G/lZukjHfGLhgklQek2IMU6kPOrB1sh0mei3+nTN9fLB
         TRtk3lDdbeLwGcIiaa67bJlckFXYMvuIJCnQxEwR0P080IqqlIqo5plsn7FVg7tGDTxQ
         6PWPO2qj5vdgprMKFUsz4VPyNvzIMVSt/B7+Ul25OYz2zmAUwnszSBLCrY+zkGTKIxBf
         zdX97059ntDclPHfA2VS5A2Vo2h+SIS9tS6n39/tETEhgwIiO9aYNNNRQ5W4fHoxEkW6
         IzeA==
X-Forwarded-Encrypted: i=1; AJvYcCVmwZhj3hdKAe5BA27+KYfKY6TL2/7U4LTo/mi+NSBduncxlvdGe3AyEKpJjgS4Jz66cjEmIZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjdcfJivT0vRd8tTPdT8Y3N2k0XmBMqDj2oqsUGaJyVOeADa5
	S0yraKXxBV0S5blbtxtjnfIIMiQ6GhA+akrndzF1LXkpql0yvYB1YdAiSVYio40TfEQwuRYLDZY
	zvugQKUn3w9E0y/24hvj2RKisUeF5D7+tefEufeiftZB5oWYUW1Tb2+vREg==
X-Gm-Gg: ASbGncuxWpeSgAziApvzUbP/KfmKnPdv9Ggb4X1HUt/L/oTK3C/lm2fV4tQNIBOjTr1
	6glYYcMmr4BdhySqSSUdkyIiYPQFTAWcaqrV47abcU+zc1DYxu4mQXuBrQcjTGyEceEo/mMM4W4
	Kgq3wOonx2+m1JK17CLLlQpFHxo2Abax9wNUxo1yai2e3MatqI0YLyXK3FRlF9r7Jbrs+YSS1Ip
	M90HCNZ663rwd6v2NKwhb573nxJgYne3XyUu3i0kuyvGlGYQnaHm38wJDBaRiVT3q5sDR2a7qcv
	GnHGKaYbZx1vFMo/rZl/Wz3VC6Q/0JA9w5p5uFOKX0+azuctnAW+O2TUSQBOmYqnJtcjw8WkJ44
	kqw51SI3KJihmFZ5bKI7rbW7gKH5OvKEMlhE5Q5Oe8Oe/Fcw=
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr222149155e9.36.1760606231066;
        Thu, 16 Oct 2025 02:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtQayMfbwHyZG1M7ESHO0HokLA6DuGP71NEXIAOvlVT9W48cYSOggIbCg6sBW0bsUEfsGNsg==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr222148895e9.36.1760606230619;
        Thu, 16 Oct 2025 02:17:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114428dbfsm14301785e9.5.2025.10.16.02.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:17:09 -0700 (PDT)
Message-ID: <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
Date: Thu, 16 Oct 2025 11:17:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
> 
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.

I guess this change could introduce additional latency for RFC3168
notification, which sounds not good. On the flip side adding too much
AccECN logic to GRO (i.e. to allow aggregation only for AccECN enabled
flows) looks overkill.

@Eric: WDYT?

Thanks,

Paolo


