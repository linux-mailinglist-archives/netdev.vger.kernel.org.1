Return-Path: <netdev+bounces-142066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CE9BD3DA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE3284029
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3F1E3DE6;
	Tue,  5 Nov 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cYGuf7dD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A43BBC9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829537; cv=none; b=mXuJWCa4lIPvzeeUyax0IhOtUfKeTDk+EgsiVwPAEP/Clkbyn07uw+VMH9neyCg9wQo7q39vm5u2d21G7g7jgTfReDVRi1ohQ2tgrsu+x51IBsvz6Otnn7ZOqKCCYR8AFZ2bCBZ/3WiCY9m101Sqa94qenyZNvi1+9O8oquOdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829537; c=relaxed/simple;
	bh=kVd0cOus8LbxtjMOKkP3jxVXWr05z7qK6FR7sdypeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcUYQLaoRmz8SzIWfYMONAYp9HwOSX/iHIoKrhZy1UjgMH1uOKHtcDp+on/52y6FLDunhISTedVHIKm8mk00pRzURAnlM3VN2UeraahJP3YJKfnlpUjRaFxeV8kW1QOmwE2F2CoIzuruz+O2aAzg1MI4GLPHzmi7hLXA8PkzJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cYGuf7dD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so5153486b3a.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829535; x=1731434335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rmzTUmWrHINY6Rl7V/QOKpbV5kXf1QIMPCFdCd4rYE=;
        b=cYGuf7dDWVN6pn31Jn65ENl0LTUfhcLYXGu9uJ/ohBqkWe5ahCsy8jLYuZ/WG0M6QN
         BEYvL2+ZSZ2nykHV8fhh9xjf+Jmh0c7qhhVn9DjpkUMm8TtB46Ed5daZGSkNI95rWoyP
         49FeNNqNKIlRrQaKVV2fkofOsnkIOc7u9zvE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829535; x=1731434335;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rmzTUmWrHINY6Rl7V/QOKpbV5kXf1QIMPCFdCd4rYE=;
        b=KP8jFI7Q5PdJfoK3I3rCkB4hauJbys/sqTtRnxDgPjb62cZrL69tH/N/TzPfHVrvCD
         yxKhJNGzjIdV96qMPzo8477c6BNnXlnPFIL8AynxOZzugNb/NeSvHqfC8Hemvfqr5HdK
         WAQWXESklGtAt86v8OMhR5WtulA6PZwaZqyc/LX4t6oczZdYWsATQU10cseApKesbvYR
         Vwvm6QUZX7nNL1oaT9CS+wnjy7wtp85NGDPAOfFoJ2FdD4ya6F9bdRx555diWeum+5Bm
         vgdlz7D9GrI63UV/GGlznMzEEKiSlJhaV41WBEfWwQujjARxFi5V31av07D96MsmeLsv
         P1bw==
X-Forwarded-Encrypted: i=1; AJvYcCVRNqiMVOzMCVGux2TL5Y0XyY493qLfBpji1hAPuU3rkZfipjJ0Y5wwKFdmiU+7niyp7X2jzAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4QWvfdsC1UZzbxXtPAktpokRMoeVXE/oRAJcNxNqJCjQjdJ/
	rzIe+wKq9v3ioV0pToUDatz2gWYsp3QmuZwoIVUFieCUCDQNq+f852wxDqDWHrc=
X-Google-Smtp-Source: AGHT+IFGrxHs6Q6x8tfi5yLTr+mF8nk8T7C7XLUrbUxIdltSvF9WreM4oniOyJR4OyWsrO5ss11lVA==
X-Received: by 2002:a05:6a00:992:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-72062ae79f3mr56944340b3a.0.1730829535095;
        Tue, 05 Nov 2024 09:58:55 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8cc4sm10057051b3a.29.2024.11.05.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:58:54 -0800 (PST)
Date: Tue, 5 Nov 2024 09:58:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 6/7] net: add debug check in
 skb_reset_network_header()
Message-ID: <Zypc3LDteksSMZ87@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-7-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:44:02PM +0000, Eric Dumazet wrote:
> Make sure (skb->data - skb->head) can fit in skb->network_header
> 
> This needs CONFIG_DEBUG_NET=y.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

