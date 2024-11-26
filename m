Return-Path: <netdev+bounces-147389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ECD9D95C7
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C104628316C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B989C1B6CE6;
	Tue, 26 Nov 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJLIfR7j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B81C4A13
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617885; cv=none; b=fr4kv/lHaH4q9ooscXvlq5pyxJPzB4QvC+/eEyYhdg+E9iIiM+ESzsrvg7+5HY7N5UM9EbB6N7AQuRDpK21KWEZx9m110xz/JvUMlzvRq/VR3kFKL7rlJWJqAgXODF8UM4P7hmkSG7OklpJMkyeMxcu8lpQ5uDNtZ+gVctwFKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617885; c=relaxed/simple;
	bh=KdBWadV999/hFI+4SLYSFHFp8GJDXFgDWBOoMHkFijI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBIxXeGiJ1/1guLF8m7d3FxCXKwoMVd2fmo87ba29fY6MMfom6eg6gZB94sisnCdYJLIULbRJCb1vkOJQTnKdKb2fVP8/YRylRIEcXkyjYG8OJsZGn8BJDvgLNNvu6eM9CAi4qp8aRDzDXgmzC49xmRYI6quDbEkNaoNnelxsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJLIfR7j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732617883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkVy/t0jQWf/59aVVZ4W3SiOPE2oemtlXug1Llmq1Y8=;
	b=XJLIfR7jSpWFdOseEezuEO4F+b86rqW1E5cAS3LbsuZkaJZqVjZ6965FZOouGIzKidMOZi
	4IvAHkhWjTuSdrlG/SKtIL2v9wGSWlISB9ajkr4dncYH0DnmWpU4FOHvIWW+X+nL0AOP0T
	Cdudym60UaAR31L81VZlZvGRTwO0ARc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ywvZ3n32N7ihUhgMh8teNA-1; Tue, 26 Nov 2024 05:44:42 -0500
X-MC-Unique: ywvZ3n32N7ihUhgMh8teNA-1
X-Mimecast-MFC-AGG-ID: ywvZ3n32N7ihUhgMh8teNA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822ebe9321so3426935f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 02:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617881; x=1733222681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkVy/t0jQWf/59aVVZ4W3SiOPE2oemtlXug1Llmq1Y8=;
        b=OQzn5zBVR+gwSCLMmpjZCiSBEyfQRtrxTG4jac3WWynbcoo3hiGA03qEVrW4WlxFBY
         yFGSTXpmgp5bmioiL6+FT60fYWUFStkuI8huP09bzEHx8cOhjkMdIDKHejdEBJeKjRYW
         JdzXwsukRObbsDLiWNXLz+BmzP+QDvbKlhXAVmiZR+UDKI+gEOrgu/BBwdj1xjdvS25x
         uQTBl/uVXVUzrenhsfGMfF/ijBHm6QV4Mmtb0kEoxTXoNFd74XmoBIbMQnP/+1WqZa9S
         24+eHlH6iQKF0J5HUBDHDTmMQfrkDtqRhQjy7rbcYSRTT3HDFTbpSjAEnCdSvxzoQ37p
         eguA==
X-Gm-Message-State: AOJu0YxOsDwPExlsliJJUqs5msIfn8TudQn4aQiIpmLGrX4v/d5qolwe
	I6oht6couIVTn9pPf1jjpwyjgvUff288T7G+S4x+DUSE2KQzKZRglspxC2705xXOXPFeX2H6OAE
	3PCMjDp/RabjaKsYOtep0a5e19RhkFrtE+q3R0B2Nd/rpjjVRrwZU6Q==
X-Gm-Gg: ASbGncubjgk/Plba6lbES/UvV49mPf9QurC+FP2Bwx/lX6JaVqvLEtKo+LDUWsy90yN
	QcoGDtckGlWW23EvNCe49tPaMBiUaqK2P/zEPraM1NYA7HcgGQ0aRroA+EOvFfGk/FEENHXL1o7
	1pJBex4YsyHl4C/Nh++hPBzHZj74l4W724Z3f678htzCvye1e6lEvJ3FkBqk+t6FPIvned5XmVN
	Us0bKesVpKrfnfMe838w+G/UP6ymNuwo+qO+wLl1UjCQRkSR686T5TqjHbSR+i+0T7wNz27Qsg8
X-Received: by 2002:a05:6000:491a:b0:382:518d:5890 with SMTP id ffacd0b85a97d-38260b58769mr13451070f8f.17.1732617880785;
        Tue, 26 Nov 2024 02:44:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTI0+cN9ItH+mhgzw+NIRlvg7G2hbcc86+PnXjz1UHiB6HDILm1hH27tvO3nOKO+UuuqptQQ==
X-Received: by 2002:a05:6000:491a:b0:382:518d:5890 with SMTP id ffacd0b85a97d-38260b58769mr13451056f8f.17.1732617880439;
        Tue, 26 Nov 2024 02:44:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad61b0sm13181801f8f.7.2024.11.26.02.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:44:40 -0800 (PST)
Message-ID: <b48da380-3071-4a94-911d-8d742d9120c2@redhat.com>
Date: Tue, 26 Nov 2024 11:44:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-2-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241122102135.428272-2-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/24 11:21, Parthiban Veerasooran wrote:
> SPI thread wakes up to perform SPI transfer whenever there is an TX skb
> from n/w stack or interrupt from MAC-PHY. Ethernet frame from TX skb is
> transferred based on the availability tx credits in the MAC-PHY which is
> reported from the previous SPI transfer. Sometimes there is a possibility
> that TX skb is available to transmit but there is no tx credits from
> MAC-PHY. In this case, there will not be any SPI transfer but the thread
> will be running in an endless loop until tx credits available again.
> 
> So checking the availability of tx credits along with TX skb will prevent
> the above infinite loop. When the tx credits available again that will be
> notified through interrupt which will trigger the SPI transfer to get the
> available tx credits.
> 
> Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Please, avoid empty lines between the Fixes tag and the SoB

Thanks,

Paolo



