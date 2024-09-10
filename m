Return-Path: <netdev+bounces-127028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B27973AE5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FB31F25872
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA52194C79;
	Tue, 10 Sep 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp++4srv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A306A01E
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980590; cv=none; b=X6dj/Xsvbb6T85+YEoqxc3W3/y+GK4HW0nNObg9Dli5OrHNoNh8P0uMilQUO8sX3Drnoy3k8iNuH19EqIyvNx/kPE3yjHyjH49vBq2n3F4r0+g07McdIzZ/KztoP/4N8N91/21uj9VCW6VwSuy5Qw2IgdBxTMwrbMX1uArhCeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980590; c=relaxed/simple;
	bh=vGvMZZgWwsBAEocHTk1SXDw3OHoFoRL3VKijyYtva6s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E54JJDl+Bmq+fTCq+rQvcqA1SIMe0myHTmmX05kqjBKZeCFA1TqG2GebIVry1V9YFCYhuM6N5q7TpcqeJDtZfcUdLjDL8E/OKWY2zTlIkfnhbxnfMo2uHKoE3Fs86H2CY2qn0BQn+GqEXvr+uwrkwsLYetkFEDei/MyGnHgdFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp++4srv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365cc68efaso3693481e87.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725980587; x=1726585387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sY6KSovN5rkp2aTCN8FbZ5P1TT4P0JS6tBy+JA+g6s=;
        b=hp++4srvnvQDf0O2YINvx9ZJs9aiqVKFblDTFzjBOYkYXLQZBok6EiL5utWrSFUgA2
         Ci38KwshtnoStPZ2dP+wBzcU1L3WEzBjjxy1nsjdSSXeVBksEuENRX9/B3Iokf42ntJ9
         UNPgASntCgzljuZM46cxq82cqA3XS4o3fqUA46fvxMrhIjhntD+7uSA7OPjpL4FqYVWn
         ozCmux3SOTu1m4Zbpe+UkXPwf/5AexjJ1ZKBIIC0lTGGwgEhde45z4klRGuF+DzCG7fo
         nq0M1WJs4KsvkJMmd9bxOcgtkculv9G1NgcTnYL7DugeOjZI1HuifbLtu5FDblX6ZFCy
         HTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980587; x=1726585387;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sY6KSovN5rkp2aTCN8FbZ5P1TT4P0JS6tBy+JA+g6s=;
        b=nuOPFpwan97vx2JdwhovVp7hP6J9CKsVACF6o08fr62+vm9D0EyqTxk6rklb6hxNf0
         uSVjQH4ZWhKQ0DOi7t1697mmiL+V0brN5sTr+2sDm9nVne7kOUKjPGyE2E7mPdgeHRY4
         mdpll9FHf+7oUYgQdyNm/f82ZHN3tMt7M6Ue4LF/0KcII28Y5ru4VT1x7vJ8u1sSpaCG
         zmhZx6kIr61WCQfDatwHPYCtHo/XaAOY3+/Z114Vtsv1sdamebiQ9bH5Yavtu2eupk8G
         roozrNLmiOM4oG142Xg/sePb2lEcgQwN8OyyC7bueNPyEuxFb1KbZhckjoZPSAHfUI+h
         Aisg==
X-Forwarded-Encrypted: i=1; AJvYcCU3xIFWDlKaC3tsFuBTUfgepVkq1xJunisHQou0eMlt/4lIFYWdXJRVdATIBce64o80Dlc7ArI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPxDZaK7hMTwazfmQbyFJybW4tQB0/x+PbOqKcNNSPXc3wRAQ
	R08kDytp2Y97+aqkRsV/dj1AIDds1GhYxlKE9gxaevG0fTt2tYCY
X-Google-Smtp-Source: AGHT+IG02YmuSnO/QS8qb95k0p29l9Jxa/NOHBQ3fkywX4e0eb6fy9yOwNf2LzUxQDQeVfNDNOh9mQ==
X-Received: by 2002:a05:6512:6cf:b0:52c:850b:cfc6 with SMTP id 2adb3069b0e04-536587f5c84mr10232233e87.38.1725980586606;
        Tue, 10 Sep 2024 08:03:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce86cfsm493463766b.150.2024.09.10.08.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 08:03:06 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 6/6] sfc: add per-queue RX and TX bytes stats
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 jacob.e.keller@intel.com
References: <cover.1725550154.git.ecree.xilinx@gmail.com>
 <fe0d5819436883d3ba74a5103325de741d6c3005.1725550155.git.ecree.xilinx@gmail.com>
 <20240906190344.2573fdd2@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <81f76aa1-bcdf-f38c-615e-2aa6ed57581b@gmail.com>
Date: Tue, 10 Sep 2024 16:03:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240906190344.2573fdd2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 07/09/2024 03:03, Jakub Kicinski wrote:
> On Thu, 5 Sep 2024 16:41:35 +0100 edward.cree@amd.com wrote:
>>   * @tx_packets: Number of packets sent since this struct was created
> 
> I think it's number of packets "enqueued",

You're correct.

> but the doc says:
> 
>         name: tx-packets
>         doc: |
>           Number of wire packets successfully sent. Packet is considered to be
>           successfully sent once it is in device memory (usually this means
>           the device has issued a DMA completion for the packet).

Fair point.  We *do* have tx_queue->pkts_compl but that's reset every
 NAPI poll — it exists for BQL's sake.  That said, if it's the
 completions you want to count why isn't there just a hook in BQL to
 provide those stats automatically without driver involvement?

> Not the end of the world if you prefer to keep as is, but if so maybe
> just acknowledge in commit message or a code comment that this is not
> 100% in line with the definition?

I think it's probably better if I change the code to match the doc.

>> + * @tx_bytes: Number of bytes sent since this struct was created.  For TSO,
>> + *	counts the superframe size, not the sizes of generated frames on the
>> + *	wire (i.e. the headers are only counted once)
> 
> Hm. Hm. This is technically not documented but my intuition is that
> tx_bytes should count wire bytes. tx_packets counts segments / wire
> packets, looking at ef100_tx.c 
> qstats "bytes" should be the same kind of bytes as counted by the MAC.

Well, even if we calculated the wire bytes, the figures still wouldn't
 match entirely because the MAC counts the FCS, which isn't included
 here.  We can add that in too, but then one would expect the same
 thing on RX, which would require an extra branch in the datapath
 checking NETIF_F_RXFCS and I didn't want to take that performance hit.
So my preference here would be to keep this as skb bytes rather than
 wire bytes, since as you say it's the packet count that really
 matters here.

