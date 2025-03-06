Return-Path: <netdev+bounces-172377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8EA546E3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2297A99D3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE220A5F2;
	Thu,  6 Mar 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezVXRm/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80420B7E0
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254553; cv=none; b=L/zUpZvFOTGTH6C+m19ljLAAzovFDqyq/yFQhN96/ggB3rMw1/ODq9dKhHnV5PVzfazENDy5L0uTKbYLL0ODVkyUv8cAKv/dw1L/dnE7X+JzbRicYliehLrHI0IjkQp4gp/MJnb5XgRHdpQxhgDr7ibIkUPbZBdGsU1U9Z8JEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254553; c=relaxed/simple;
	bh=NTtVgflWu6tAlA8pd6DftngJAv6JiE0FqLRO924rdyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uxwHAWGjgJdXf1gI+LIFw7DXghi+Zn2xP9ug7usPyrF7SY22Th/TS7B6k5zjTeolVuBodd/zd4g3SdXSbPGmYBY9166UezHoGrF4SUob/GV3hWEwzPUkUZdSDzXYa0Kh9O5fGdMNlbLEBIIZbCYuas2pBXbktolGWccs42HXtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezVXRm/X; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so4251375e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254550; x=1741859350; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOvH1h7gY+S/5tjP1o4zbH2Xsc8NxkuCe8boz90iQSw=;
        b=ezVXRm/X8FVlWPru8QQQJ124NAs0KNMCLcbBPQ7e/LKLzHVVIP+zQdy6n9giHZ26MA
         RAiCRvHvaJgw+1D9R/fnNZwrXCa1NfXBlLDK942fS+F62lB2lzIQqACTA5VhcijemrOT
         O5Y+TeV92ydcgnh8MYmqMjkeZBKyBIa9VouHmJjCvAhy1GSCmt5xxS0EUlk42RulYueL
         lRMoqgixdfxRHwr5E79TKetbFL+URKH5+J6L5lTCUxz0HFyMUr97x1bVksGkV8I5CINp
         3R+d3yleeqoyO3Du4hdrWtRpL4Nm0NJuudD5ebRGekVTcb3wwc16P3I+3B8h1lDiBXHp
         sMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254550; x=1741859350;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOvH1h7gY+S/5tjP1o4zbH2Xsc8NxkuCe8boz90iQSw=;
        b=D7wBZxq7gVj4tyEKCLWIppGjXrBgWtG1YSVuyUa0+oA7aDdQqWQgwqWnYwJ+xX4iq+
         lVKlq2ZnmFZFtS9Kn6PsbUD7SWxxjM4JAiEp9UDujMHSV0p5/o0ipk4Xlyjympb2HwcY
         jpmds2SW6UW8RAaj/2C157nZN8mOop27MIiPU0EU3Q0kHR+AmR1SwB/pUYT/UHI7KcRe
         8yemwJaMV53gDPG20/nRRdp+BqQjeEG8v0BtCJV6sJ/mHXZyxUgDyWzzdqTWZD1rVcfn
         U+znH4ZPoHTr3xz9U7fF9B7vo2gyie8YXPKN77KvuSQyD1JmHoxxGALMbj6Z1ZuLGhSs
         ltQQ==
X-Gm-Message-State: AOJu0Yzqqzz5D/O0RAAbH6LddoQ0CBpBC24xzLQp7cNs6bFdMEgw2Ib8
	RkUCqakWRbHboMe/zwv0ba0mpVw842720XLuWmIcNCDzhjqsH6MHcisPDoazsW0=
X-Gm-Gg: ASbGncsaqN/WfdkTyjDVVy96+ube6ldBewK3Aqk3vkjEl3YrmH+LIJpSJG42/J47xt1
	33+7WujE1sMvR7taej5wob/E+ms5eMSvOrBH/+ZQT1JE7bSc/wn2OaNWii6jXiFDCCtvFxsjdHx
	wKZ9HKyi59cDkXnPGqkzfnIMpoupT+S6Mvv6qcHa6B5WYQuMvGw1ycs4qWWWs3yqQ9VSfof2FID
	BSo7d+zx/Y3zX7xxRqX8WBWEemYi3FA8n8H3EUBbSnGoMIWd51WagM+IzCI6Cl8aGePdjZld71h
	/ng4XxtbBm/wXiRMAftPba9z6Iib7E5sEdvnR3qk5gcuhRP+Pg==
X-Google-Smtp-Source: AGHT+IEki70s8g2dcmrVd4Kz2FOJSXan2nOY7Num+J04ZyHi92TIuTxZvYZZl5FNgz3JAp5OJn/Kgg==
X-Received: by 2002:a05:600c:4f11:b0:439:916a:b3db with SMTP id 5b1f17b1804b1-43bd292fee0mr60000385e9.6.1741254550014;
        Thu, 06 Mar 2025 01:49:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd426c16dsm45237025e9.6.2025.03.06.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:49:09 -0800 (PST)
Date: Thu, 6 Mar 2025 12:49:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: airoha: Move DSA tag in DMA descriptor
Message-ID: <46c1790a-0860-4907-894e-2d8ec4622147@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lorenzo Bianconi,

Commit af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
from Feb 28, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/ethernet/airoha/airoha_eth.c:1722 airoha_get_dsa_tag()
	warn: 'dp' isn't an ERR_PTR

drivers/net/ethernet/airoha/airoha_eth.c
    1710 static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
    1711 {
    1712 #if IS_ENABLED(CONFIG_NET_DSA)
    1713         struct ethhdr *ehdr;
    1714         struct dsa_port *dp;
    1715         u8 xmit_tpid;
    1716         u16 tag;
    1717 
    1718         if (!netdev_uses_dsa(dev))
    1719                 return 0;
    1720 
    1721         dp = dev->dsa_ptr;
--> 1722         if (IS_ERR(dp))

Why would this be an error pointer?  Is this supposed to be a check for
NULL?

    1723                 return 0;
    1724 
    1725         if (dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
    1726                 return 0;
    1727 
    1728         if (skb_cow_head(skb, 0))
    1729                 return 0;
    1730 

regards,
dan carpenter

