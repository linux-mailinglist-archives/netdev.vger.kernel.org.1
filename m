Return-Path: <netdev+bounces-226373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC3B9FAA9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263B31C233FA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80368285060;
	Thu, 25 Sep 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvYEd0Yq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4E28489C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808298; cv=none; b=qtbPC32PJjCRMhjdsuM3bKeLGByA55Y6ZBd34+alsacWl9HmXvXCBAAFo4WsEmOrImAnoOS9rG18uwAKQOQZtuwYSy+cTxO1hQMsTzPUaf36Z+mZ1GzTx++NEAZ/bKrEJ450omVVfQilQHpM8kSB/5irMPLsJmrTShNo9m3wAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808298; c=relaxed/simple;
	bh=Ezc1PRKFS8HDkESSnH9KzpAHhl4V3gZXuY5x0ljiT7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRdInC0GjvtWQMzV8ciA4X3lOoFG6jArXJEYfEmMGAYDh6A9c9Q5eIq7JwJPix2Yc7GNogpAJjfTsuZU+1mCqhIixlv908dksc0cDpzDX1D4ZKQolNT/sdsC9KRElqdohhGmV1y6Ax7qbWkOroCz6UuP4wonuN6yEhIK1JHbKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvYEd0Yq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758808295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCvR4anKpwujkbOJzUGbd4QogVCV1jf0j+424YD3uz0=;
	b=VvYEd0YqA1UZNXt0ljzLbM5k+4nSUMrvKFKQd6+rsJXlq1yarjRIx+YAKzGfb4F/764osp
	mpXb9rJkMTGZbxof8+lRLncbCsc+GGZkxW+hM/p6hgbCemZ9LNGprNSbHFbUbyf2yHIgKS
	Gx/luWVBzXPmILmDQsLufpwFqGftEg0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-aBYDFJVZNlGUQlJERgIH8A-1; Thu, 25 Sep 2025 09:51:34 -0400
X-MC-Unique: aBYDFJVZNlGUQlJERgIH8A-1
X-Mimecast-MFC-AGG-ID: aBYDFJVZNlGUQlJERgIH8A_1758808293
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so5751265e9.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808293; x=1759413093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCvR4anKpwujkbOJzUGbd4QogVCV1jf0j+424YD3uz0=;
        b=XT9mH01SUJU3Vo9EwAhOiCsgRqK5q1WdROcNrW6YuuupDlZ1jmc0S/v3tdjPafkncN
         8bGtXzrE3bvgaMW8+AzKUlnOwlGknpY9G6Aq4DU2SumsAzg/P/yHEIHJWHch+lpukcrd
         /tX9iuNeSAhWrMMv2xijzWn1vl3CszpV+H5hN3+9RnPoimh5nNUkylh7mOgxDCPIEdQQ
         YXpENV6pTiBueB1ZUCSexTiqvO4vVi6tGvJn5hYzFwwqoKkD4D5pCS0XVVu0cvoWcaga
         Txz3Ku7ZDqkcuS6bJ6WnbwwAmMzX6dVF32Vbn+Vxfwk/aT8lakB8RfHqE6h49eU9HrMV
         osag==
X-Gm-Message-State: AOJu0YyL977CNHnWanpkLWltA5TAxxtmIBKJiaArTaydJ8B39prWZMJ1
	oHQ0NeBrPsweVGTZ6vTRgv3HWLdVuSYS2c2xn547FOo3u8xSJUmBPktxGi7WKllVYcYfAI5OZau
	AuY+Ho2EqJtj09rLo3TSPItf7Fl14k6nf1gZEDImLr/nZixq3oYJYwk2wjA==
X-Gm-Gg: ASbGncvhOsjYugKNjXX6kRnY020OAzP3SH/ww4RX3iRK4RpjAzdoWPJu9aRkzupfiTw
	uy5tAhw/YjCRWm2W+vuR7/BQm5nGjVN4K1PC6gCM1Ht0ZKi9vHcByL1lYTd1SoVVV8PhE/AygYO
	2x5jY/PWrH91zoWszE/XGsK3OxCXaQlMFyn0ft5pqgcloYyD6SVY7Lu530SmhjgXrx+P0SElQhH
	5CgPvTxfs08q5ldAdVZExhpG6oUq9/b7UVRdmToMVcECdIynU2qH7chRbo82oUgwCYma2eOVFQy
	yW0I7RwlL1QoaUsgdRRzTP/7kjIiWf6faTJuaa/S1LsMwAzQRtW46BQHKk4Mm7PP8U1Q2hNYWa2
	JmdRvAaH5T98+
X-Received: by 2002:a05:600c:4f56:b0:46e:2c37:7474 with SMTP id 5b1f17b1804b1-46e32a032dcmr41710765e9.31.1758808293103;
        Thu, 25 Sep 2025 06:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpJDNezhDxHoKG05SoAQ/nh+1dPUF/x5uGDLCgwFr+Z2jjTBMQCDkJawmvg2DquN2nin6xzg==
X-Received: by 2002:a05:600c:4f56:b0:46e:2c37:7474 with SMTP id 5b1f17b1804b1-46e32a032dcmr41710375e9.31.1758808292739;
        Thu, 25 Sep 2025 06:51:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9eabbsm37891335e9.3.2025.09.25.06.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:51:32 -0700 (PDT)
Message-ID: <06363f8e-c99e-4672-a02e-ec9b0c27003c@redhat.com>
Date: Thu, 25 Sep 2025 15:51:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/17] net/ipv6: Introduce payload_len helpers
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-2-maxtram95@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250923134742.1399800-2-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> From: Maxim Mikityanskiy <maxim@isovalent.com>

Only a single 'From:' tag is needed. This applies to all the patches in
this series.

/P


