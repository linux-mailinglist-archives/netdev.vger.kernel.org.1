Return-Path: <netdev+bounces-119175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C9954817
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A9E1F234B8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909C1A0B1E;
	Fri, 16 Aug 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTA1Cice"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FE198853
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807869; cv=none; b=doy3xrbDGbceuehM4GJnOVu0bd1yy5zbkcg+J1fnR4DL4s9lnR5gA1C+Yiw9iymFxUzf+MMLtKRaN1g7npyQnej/1wFwIB47FxL8NaOYUvhuqkGVY6VnGn1fDRPaAkezPFGj5tH9gUx5gqrly30sXP6TP3ZPJnlrVd4dU8KmZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807869; c=relaxed/simple;
	bh=1bktqQayWYWtMAKqssvWuw4y7zQFT4lfZb54Csz+S70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfxFTORoPvLMzzFDIvPAC6zJgc8m4VqVB/if+yZHuUJ1102XW7Kz5HNkXsVIS3G0MyddeasQtWJR2sjHpZ1/08a+mynPDbJNm6HZWW+o5gi7ZwPeXZ9d+03DcbFGX/0hYuKvDGaVyOHIvhyD7qJi9C96vn3KgbdusOMPjEgOC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTA1Cice; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723807866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bktqQayWYWtMAKqssvWuw4y7zQFT4lfZb54Csz+S70=;
	b=BTA1CicesdoeBZfvBi/GX3WIjMnlu+PPMbNr2Jh5hoPfxBS7A6n68dxdlQ4lpM1kPUzOWZ
	rlt8P3axtssCw9b+umnHbttUsSBAaCHo+Gq8KimrWe75Egz+wxhgnCYIvd8o8blTYOacno
	ORE7uD2OToZI7dfGNAzgG8P5K3tYwnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-m_0m6xEONzyfuWOFb42SgA-1; Fri, 16 Aug 2024 07:31:04 -0400
X-MC-Unique: m_0m6xEONzyfuWOFb42SgA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3687529b63fso1027968f8f.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723807863; x=1724412663;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bktqQayWYWtMAKqssvWuw4y7zQFT4lfZb54Csz+S70=;
        b=N1oukrPSzl+u3ash8YIx6DV6ng/8U72sQMFmmSzn7pkL6rLtT6KWNkhkaKu0NPvaYO
         5rOmYFSAyVt6wPyO8Sh23Ka9PaAsVtShtL0uG6LtQ88oqbc53WTQtQin60imQiM4/HbU
         FSX+0Q/UOURAlESdRydo0OoR58Ou+Zh1rtYRPB9yM2HVtSjeHO9UnBxosPROBWzWyW0H
         EvUldm5LsSXq1AMj/hoV835QmE7B9G/KIGmq7N2W5MOl8OvCrjFnBmNDHr9vbKR+lYbp
         8pWdaGsiE+WMJRvV0wvUPpSsKGs8xfcuo9OG+FdW/hPwvVCVfhGgPmh8aUgca1h0A5E/
         Uk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5qaOTGvV/ntSg+t9yEDPrt4/3WFwz9bohEeS2Ca/7TNG/sOcAmrCVNcZdI7rN0Og8QSoghetg62qdkobkI0Mm+MPG+Npl
X-Gm-Message-State: AOJu0YwpejLS6aZUrUgPMu+BPTlEhnCrx8oioQHuhgkFGD8x1D0/gLFn
	n2FkUmZNLCnxlbMcYTNUnx6oc/byaBzxw7Gd889PGON4VGq77DEjyc9XefjWCKaPA9bNxFP7Qas
	5Xm5FptAUIajlfpj2LjzXaKqp1HcznF1+qR2soFpd9ISzDuTGHEP0Aw==
X-Received: by 2002:a5d:5110:0:b0:34d:ae98:4e7 with SMTP id ffacd0b85a97d-3719469531fmr1542914f8f.41.1723807863419;
        Fri, 16 Aug 2024 04:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSxwNIUjnAJ8rcUcO6moPhGgsuq5H2/SGprZmmZkrEska1ZBtlsqGNAmMt0ivJktdwkOTeew==
X-Received: by 2002:a5d:5110:0:b0:34d:ae98:4e7 with SMTP id ffacd0b85a97d-3719469531fmr1542903f8f.41.1723807862844;
        Fri, 16 Aug 2024 04:31:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7dae0sm74202835e9.44.2024.08.16.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:31:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DD75114AE084; Fri, 16 Aug 2024 13:31:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Johannes Berg
 <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Michael Braun <michael-dev@fami-braun.de>
Cc: Harsh Kumar Bijlani <hbijlani@qti.qualcomm.com>, Kalyan Tallapragada
 <ktallapr@qti.qualcomm.com>, Jyothi Chukkapalli
 <jchukkap@qti.qualcomm.com>, Anirban Sirkhell <anirban@qti.qualcomm.com>,
 Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath12k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] wifi: mac80211: Fix ieee80211_convert_to_unicast() logic
In-Reply-To: <20240815-ieee80211_convert_to_unicast-v1-1-648f0c195474@quicinc.com>
References: <20240815-ieee80211_convert_to_unicast-v1-1-648f0c195474@quicinc.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Aug 2024 13:31:01 +0200
Message-ID: <877ccgd7re.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> The current logic in ieee80211_convert_to_unicast() uses skb_clone()
> to obtain an skb for each individual destination of a multicast
> frame, and then updates the destination address in the cloned skb's
> data buffer before placing that skb on the provided queue.
>
> This logic is flawed since skb_clone() shares the same data buffer
> with the original and the cloned skb, and hence each time the
> destination address is updated, it overwrites the previous destination
> address in this shared buffer. As a result, due to the special handing
> of the first valid destination, all of the skbs will eventually be
> sent to that first destination.

Did you actually observe this happen in practice? ieee80211_change_da()
does an skb_ensure_writable() check on the Ethernet header before
writing it, so AFAICT it does not, in fact, overwrite the data of the
original frame.

> Fix this issue by using skb_copy() instead of skb_clone(). This will
> result in a duplicate data buffer being allocated for each
> destination, and hence each skb will be transmitted to the proper
> destination.

Cf the above, it seems this change will just lead to more needless
copying.

-Toke


