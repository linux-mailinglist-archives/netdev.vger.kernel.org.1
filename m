Return-Path: <netdev+bounces-179036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2646A7A237
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C5E3B554C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627C24BD1F;
	Thu,  3 Apr 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5bruwKw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58C224B0C
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681410; cv=none; b=gF5DF8da5rqDDYSzL103+PBWU9a1PUL5zFy9v2iSuT5JB29K7Vwd7xmDaOvLoInISOJ7tlDZwmyQmJmMCZ5gSj1rdA/INef7GSDpTJhAv2PVXyRP+j8fqQZ27MAzuZPkGHnGalRM2Akil0H+2x7TKnYhLjaRwSwq70y8XGuvVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681410; c=relaxed/simple;
	bh=CQW3LvrpYLZr2hfNBWwV9hoIx59/BSsLvUr5/tUTLg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2PxzG5jWAGZSV9f8EGmmosypWV/aKEfmJkaPMmoVR/YZ0zZt6dXWBW3jtqCvck/DWUXrjdEFnke+CLADRIfnQUN7PyoJnP1PXSrl7RbjCUaMxbSNPZvtePBbFIycywXK4/yUVUURXNj0bc6lHz0ifSQ059cPkt+W8HGw63QwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5bruwKw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743681408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H5/xBFkSHvSdkgm2kc89t+j93IWUj4d38uiubvlMZM=;
	b=e5bruwKwUMT4tt+QiTJNYJavlYuv4hbUJKdK9RgQ2o4bFHf0JnjF6izRBjo89oAHr6Gjaz
	psaqDAwlCv2ZxCHn4GcjaRNWENuMzbxaEsPdf2rjTuEoHDY9qDPne1aI6LWaMyVv9l/qTb
	oI6OSGAMsRlhia5jWEtGGff5ZGRGsnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-UK_MWUzXPsKBmflojJf6bA-1; Thu, 03 Apr 2025 07:56:16 -0400
X-MC-Unique: UK_MWUzXPsKBmflojJf6bA-1
X-Mimecast-MFC-AGG-ID: UK_MWUzXPsKBmflojJf6bA_1743681375
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d733063cdso6471155e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743681375; x=1744286175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0H5/xBFkSHvSdkgm2kc89t+j93IWUj4d38uiubvlMZM=;
        b=ldeKdnIb+iCZRL9OWXpdB+IPRRhtmJPchVUPM5ARASAQX/wBYPipBy+od/lZeUJg+3
         QqLAliRRVapM5K5K1GaXm3KK/ee41/OqtOkhKFxibk6CgZTMZP41EN+6htZr7h9mCkU+
         P89nCN5dNSNE9N4npFM4XJV++wV63E0F7itMpujQ4+bpwCqYh3PsF1cbijZE+Nwbn9Bq
         THW2tr/+veh9xLs7/q2wWDRvPYgEM6LiE/hdaee69ihYv2j4PPQEnpjywo7scN9cZxEZ
         LVH9Z29mgFM2hio1FFzggdW4JEfD6NDp5mk2DJdpGih6f5wSbQdzYZV0FwJiOEQsUVrs
         8eAw==
X-Forwarded-Encrypted: i=1; AJvYcCXXGTW/sUPRkdiRyOfHGSQ7spc0P7/mOCcv0s1t93ptjv9mDXkG76F2Jgn2jy4V8WwImwAHTAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRI2G4SROebXV9y02vN2ic8rlT6INXK277dqGs4iJPaGtOQu6P
	AmSPFXvPbqn1ZQuHxXHdQBX6/Lj/Fx6KIMtGz/7uahhl76XIE0TnbjuMhqkrntspeJ9CYC5ZQtz
	+eCJOMxheeLXQj4c0EAziMImEjCculNe5oAPAHObh+Jwyl13BoxfFwA==
X-Gm-Gg: ASbGncsiWtqN7xdOgB0BUO8J+m8fy/ZPdP7siJrSLZR5eJNTvcyqKWbFQ25NdUNVRx8
	iOENqS1ZIJUimXSpPC4NXHFwFHr5PIYW4budnON0b4NxqTzUi+r7+/y9ay3upq1eDuLq32CV7ho
	ZAcT7pKJRGlgqxEah89rm/jkxR4Amz77pgUv4bF62Vnx5RZvPmsY3/6bxtcNFnziccos/mGZN82
	wfNAGd7JBxG7Z3hcR3S1oNsVHAd9n8mB27T0xSEMhiM19yHthZKHB/G3FZWIWjnCzGI5lurzmHX
	a4h7t2qqUN4dvRagzKXkXbyUpBEtcgDqmwFukZwx4Eaycg==
X-Received: by 2002:a05:6000:22c6:b0:39c:1efc:1c1c with SMTP id ffacd0b85a97d-39c2976984emr5568302f8f.34.1743681374885;
        Thu, 03 Apr 2025 04:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe9epn8RH+1tWTOrW9iJCz/QsoiUwz7lwD5Ai/FLreIW9iTiIUclOnBL+eTfQUeG5/OFX1zA==
X-Received: by 2002:a05:6000:22c6:b0:39c:1efc:1c1c with SMTP id ffacd0b85a97d-39c2976984emr5568275f8f.34.1743681374535;
        Thu, 03 Apr 2025 04:56:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226acfsm1558796f8f.88.2025.04.03.04.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 04:56:14 -0700 (PDT)
Message-ID: <4ea9e4da-636a-4573-a0b0-78ae3972bdb0@redhat.com>
Date: Thu, 3 Apr 2025 13:56:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: octeontx2: Handle XDP_ABORTED and XDP invalid as
 XDP_DROP
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: Sunil Goutham <sgoutham@cavium.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 11:02 AM, Lorenzo Bianconi wrote:
> In the current implementation octeontx2 manages XDP_ABORTED and XDP
> invalid as XDP_PASS forwarding the skb to the networking stack.
> Align the behaviour to other XDP drivers handling XDP_ABORTED and XDP
> invalid as XDP_DROP.
> Please note this patch has just compile tested.
> 
> Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

The patch LGTM, but I would appreciate some feedback from someone that
could actually run the code on real H/W before sending it all the way to
stable.

Thanks!

Paolo


