Return-Path: <netdev+bounces-115500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49591946ADB
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 20:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03C81F21D99
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 18:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909FB18C31;
	Sat,  3 Aug 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Y4kZdvqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EB17BD2
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709919; cv=none; b=NqKfVXA08xgxyVf6ddbOTHnF+SeJrew7gRBDB/+T6K23rKIL+b6UzZ61MWN+uC/pg5XV//efWJGcxJ4cPUilBQ78SZP5yR7PoKqbQvvs1H8IpPX68JrXCl2yfMF62ZjYYRAntKhArSDOGbe23kWjlfwzAkMpi9hlgD3IH9gaVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709919; c=relaxed/simple;
	bh=65wOj3mjIYjmwALC9ReHUnhlcSwBkI8j9RFvSnJ0rbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gamervDWU+PW7ISK62BwNV1HrxBWYClvWjZLK+gqsZzw7LbY3xdVLjm8+aikx6v6IEiee0jg/N8O03/bius5T/cFG9hyVv/0z9FFEK+K7ISmuvb9VE6QGIGmh6lk/dpGq8Clgyss2kFTETdla6I2v2dKhZI1XxJjD0P0GVb0s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Y4kZdvqp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc65329979so81500575ad.0
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1722709917; x=1723314717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw+7kkCGgqsCM4imm6lrOapR3YwBtUHNXt8VLERjVn0=;
        b=Y4kZdvqphE2M/s2bwaRuX9wXv5vKs/SUGSZ4Jvj/mb0ESCmqxLPifITUAD1bsmRXzo
         jeiO0u4pTM0/DLfAwXGWZj7MnNo3Kyv9gpipZSpGV10HJ3RaOPg75SiL77OLJ1uxmyah
         1VTxvGQk5wKqkq6JOFLiY8akfyNeJkzdSCVkccRaM5vTdE3kU6EbUOX9jH6wvvafh+QV
         dysa3N0riOCVExmdjOAWc32a9EaEdPlyaeaQwoz2XFbLQsKv1JuT0RLojh+gCHVphf4q
         TxXh/SsdIyzoF4ur0Z6RG/vUTgFc6NhuRCDSHNZySfPMFXNWYV3QXv52bs9pizKOXxLf
         s/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722709917; x=1723314717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw+7kkCGgqsCM4imm6lrOapR3YwBtUHNXt8VLERjVn0=;
        b=takxhsOhzrPUbHBkp784PE+Bx0BKx4s4ubQ4MF3uMy1nYMcEy5bJgN6eghYq05X2TX
         lEo9eOhnkcMWRhJRGFzf4qfx5NOAKUkljKVVt2Wzvr8Lvav9740tGol4QdgIaOJyQ5nk
         4sSvMefXG8HmT+4DRa9NlId/+fN3wOk8IbIhZs8CUWU68T5RAuB8x6cjJEvavUTwIM3A
         vSWc/QjJNGGYmFLiuyn69hWegvcAmUaOgiQzuAdUEYNmzKYHUOd6BlGEn3dWJdqMEdAq
         RFtLGEpHrq022uvEnKDpJw1DbH0CZ7qkltbG2OLW32+QtXdD61O5hyyu+95jyMxgLb3z
         NalQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwUEoQ9fbLs29bfZ2urD7797lb7GFFV5QXufBj4H/sjPHcO0kKhssGKMePI3fKHPx5sEE7S+4Vrkor2zJ+s2wxQn/VzJMf
X-Gm-Message-State: AOJu0YwA1ryY4bEDs8IdZPl06waTtuY4aZF/2VYp3MmrZ/8E4nc4+A3c
	tAPyi15liB9ncSmu33Qe2G2nbK6OSEj6GDN4nFkJm4ai8emoQDbGA3AmTjaLcR4=
X-Google-Smtp-Source: AGHT+IECeN/RnB8XQBElroUgCD3gl4LUfMgIYD2HQbBTrCVzOOWWqlrpv5nCGlAFzpgCRMQFsCD5YQ==
X-Received: by 2002:a17:902:f54b:b0:1f7:c56:58a3 with SMTP id d9443c01a7336-1ff57293097mr96255815ad.26.1722709917177;
        Sat, 03 Aug 2024 11:31:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c650sm3049261a12.16.2024.08.03.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:31:56 -0700 (PDT)
Date: Sat, 3 Aug 2024 11:31:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Long Li
 <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, Simon
 Horman <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240803113154.67a37efb@hermes.local>
In-Reply-To: <4c32b96f-d962-4427-87c2-4953c91c9e43@linux.dev>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
	<4c32b96f-d962-4427-87c2-4953c91c9e43@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Aug 2024 02:09:21 +0800
Zhu Yanjun <yanjun.zhu@linux.dev> wrote:

> >   
> >   	/*  The minimum size of the WQE is 32 bytes, hence
> > -	 *  MAX_SEND_BUFFERS_PER_QUEUE represents the maximum number of WQEs
> > +	 *  apc->tx_queue_size represents the maximum number of WQEs
> >   	 *  the SQ can store. This value is then used to size other queues
> >   	 *  to prevent overflow.
> > +	 *  Also note that the txq_size is always going to be MANA_PAGE_ALIGNED,
> > +	 *  as tx_queue_size is always a power of 2.
> >   	 */
> > -	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
> > -	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
> > +	txq_size = apc->tx_queue_size * 32;  
> 
> Not sure if the following is needed or not.
> "
> WARN_ON(!MANA_PAGE_ALIGNED(txq_size));
> "
> 
> Zhu Yanjun

On many systems warn is set to panic the system.
Any constraint like this should be enforced where user input
is managed. In this patch, that would be earlier in mana_set_ringparam().
Looking there, the only requirement is that txq_size is between
the min/max buffers per queue and a power of 2.

