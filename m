Return-Path: <netdev+bounces-89861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F488ABF19
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 13:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB5B20A4F
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90820DDDA;
	Sun, 21 Apr 2024 11:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47C625
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713699937; cv=none; b=YZ4dzvOeVSIYZOf1NfGZ13hAwPlRVH0E/AmYevYhq598+CAmyh0zQFp8XH+n6EdCTeNC6UaJY/yXdjmsAdltsr4TrvQX2ZcZuFL8M3hZXZGDViHsrOq3yl47F+kNXH+ZQ4CudEMGGqA48cQAXMRF64x25Ons0GYa/RCLDS7lWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713699937; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFbh8zNaq7eGleB/TA/DHeDcfP2cZdd7m4liuFZCBtn+v1hIFR5Sv8CEkSvKoao8Js2tHki/4wsrVngZ/s4E361o/xciom0wOSx8lI1ewbd9VIq23H8ceU4Db/OWQ1ztJXGf/FZ6DYekEFznYuFt3hlRhsvACLZv016eSEI7ygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-349a33a9667so503141f8f.3
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 04:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713699934; x=1714304734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=d2zdW3KZCrgBA4EnrjOZVujGft7IYOiiGPcCFuj59N7VtGg31t5e1PaI8dgSwHVgiW
         I2YfiOkff2d+I0E67VDcOAUoCsvataCkHWE30TCT7xVCvUnUAIN9qt4TZJ2T2lUwEemI
         hfNZqlbVUqFeGxdSh0qUTxQE8xfaYYTJTLgoju1ej/4sP3zztu78ik2WLpdYceCmEgIx
         7S6IBOCpU6adgtJFKl39pp2K24oVmvYjjry+N7qyXWY8YlmAz+uwVv99axroIyXMxJhB
         LVUUT91V2UF4PA5Ej3O1IiEpTIEzznssDTz1nvBevGbAj/ge2SDfmrGYlIYEebGPYnuz
         hNQg==
X-Forwarded-Encrypted: i=1; AJvYcCVhS+tpp6cmBxFwGEKygH2UrFO8z4IQPq+OfgMBQ+6Qq3bxZ62J27gYo00Pjop6AlJ76/DHiRYEF0x3eCcPX2ej3c0fh18P
X-Gm-Message-State: AOJu0Yxyotm3M0c6JzeQKr6F/qphq/j7jbrs/56t53MzUNeGah/IFqav
	O44L0zaSzy/JWuSIRQE8x7nu/XZn7AF1orBliDFCAFXWs89ES9n1
X-Google-Smtp-Source: AGHT+IGKbDQdZLCEdcfv2ITJSmNJdZcmNMkVGtrt/JvZZ5rqfW0ovQOoE1Ke1UTdDiZ3RlrtCg8INg==
X-Received: by 2002:a05:600c:4496:b0:419:db8f:dfa0 with SMTP id e22-20020a05600c449600b00419db8fdfa0mr3094191wmo.0.1713699934100;
        Sun, 21 Apr 2024 04:45:34 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm10731705wms.32.2024.04.21.04.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:45:33 -0700 (PDT)
Message-ID: <f91bd5b3-79c6-46c6-be1d-9256b4755340@grimberg.me>
Date: Sun, 21 Apr 2024 14:45:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 04/20] net/tls,core: export get_netdev_for_sock
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, john.fastabend@gmail.com, daniel@iogearbox.net
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-5-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-5-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

