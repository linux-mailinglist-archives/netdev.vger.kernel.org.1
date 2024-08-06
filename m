Return-Path: <netdev+bounces-116118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A63949248
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2713C28130D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B71EA0B3;
	Tue,  6 Aug 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEMzk/Be"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707D1BE875
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952505; cv=none; b=HrMKppNJ+MGAWFbDvw6pp2o1QcCKw72KZXeIaP1gGtYaP9nk6LUJcPwI0OKGME2Du6WxReEwowomj7vmP12N14TB0KZi+61ba2o1iwn4Yc22MhrlMZCr/H1s+yieU+CVBtdP8Ysj7dP2KuvL9fG4XmGHvC2tZRJAX4+dd2O29CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952505; c=relaxed/simple;
	bh=zP6bdKj7d+EU/wmVrhxIGM7hPVuarZ6vfCvTzkn0LIo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AAyNqiCPkvMSjmEN4fi/s7Yx1/PtANlpMF4klFXJPcaP0WdXDgXMTpqjjMvX8Ix3HLbYQFgBcg1ydyugXziMDDBf+Y8jYPy3DIe5mQUU32wRBK9OWUbOmqYItvaoB2upeAd/kpt4I5QMCE+Udq0DiOVqvO6tREmA35DzunJRn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEMzk/Be; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so5203975e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952502; x=1723557302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO91a9Yydi2feb2CZ5z0ZBjybGamqYz3C1mcTItTIEw=;
        b=lEMzk/Beuv9XAsftfSzUBDtycKoTlw6gCwshlXbn9//qu8j2vad66c8t0y1o0OMq8N
         45qzhUZwiKUl9Ne3QSZNfYGEPvpUJXC9O4T+NupB/mSxcXcHK072L/YzgobLRARoUKts
         QAiZEud7cXgFqGQTSzN3dpu84+OFsGSlr5RSmDmg7Bq0365C/5O+rO9aJQaqaar1Ui69
         APC3tju0Sr+oauy+QH3iWq4kSm2wlmtDvzJfWhn/VSDkGtXR5zfKJ23BFXtb0kGMBGuY
         4lJNRcNUJgD0SVws8sER7CwfmJ40dKgcoPqPueawSiKaD2Zfao7w+IDlGAlNRF4xvNFF
         k+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952502; x=1723557302;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO91a9Yydi2feb2CZ5z0ZBjybGamqYz3C1mcTItTIEw=;
        b=oQg1cO7a/BBSB+KoFXks/028nDNfPHD98MO+4+wujNzTN1i5BqaM1exgThAapwLB8Z
         oxZqMMSodl8hRg7Op+hSAFR1UNk/Pky6Ik6kXGVJuVkA/lxRnoIRD0LzN05qzDS6PC7a
         dNx8V5tDSubuwYolREWmg9aGeyTK7oxEdqx+319OKgXVImLXdAxwhur5QuRxa3mC1UwE
         6ud0ce9NWZCDBZSfkzD+eO2r4JC+Zk+mL4Dbj9D7r0kitEf6oc0c3sYF962RwGlnl79D
         Fb17ADEv1LtbU6gukQ4a+6+FthO3cdwDuNflNZSFEDVvpb59awd5pByMlkNJWox1P3pV
         M2Sw==
X-Gm-Message-State: AOJu0YyKW67MTO/EWUUJg5fzs5+QUUA4RggUnuCpRriEzLyZUe22fRbi
	enbX6Dx6KBWzvDq8CPKYglV8Rys0McTImDAEAlgHUk6789JLW38E
X-Google-Smtp-Source: AGHT+IE96ZvE77h+QHmo4Zg2C5nAxcE9X/AZEnMPxcm8H1XPfXIcEwQ8ArJ0bxQTNLmv6iFT0Lt5oQ==
X-Received: by 2002:a05:600c:4f53:b0:426:698b:791f with SMTP id 5b1f17b1804b1-428e4709030mr121503495e9.3.1722952501874;
        Tue, 06 Aug 2024 06:55:01 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e56cfasm180455725e9.28.2024.08.06.06.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:55:01 -0700 (PDT)
Subject: Re: [PATCH net-next v2 08/12] ethtool: rss: report info about
 additional contexts from XArray
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-9-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <28372db9-3645-90d8-fce4-b263528f3b6e@gmail.com>
Date: Tue, 6 Aug 2024 14:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-9-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> IOCTL already uses the XArray when reporting info about additional
> contexts. Do the same thing in netlink code.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

