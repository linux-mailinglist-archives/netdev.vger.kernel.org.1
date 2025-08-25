Return-Path: <netdev+bounces-216475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8885B33FBF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FAB3BB2CD
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711A1C5485;
	Mon, 25 Aug 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOLM+6qm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7551B040B
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125650; cv=none; b=C4TsQZrvpsGQ8e4aUSh3U7gvLCFH8Sq7mHKjTpZcGn+n4Hu+zSQrE2nmM/qKq9WD9JwjLVuWblu6p6ZFJGdQk6tPX8iDH5lyKI7GXeD3Kl+AH6tOX9BbzPhg7rQ683rXHUoN29ZJXfqDh5tb8SpP/H2469b4IYEerZpBnA71orU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125650; c=relaxed/simple;
	bh=YLoOSnAIdgarnwk8uFSTUkwrPlZZxe4hvFL/64ixOho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfhJWPaZW33Wn4aizB3ja9UwFCoL1pIjKzzHw//mZpE50i8RfqPyhcZjjRxRXrJiOsGmUiBoNauYRiDI9WAJkPjp43KzVi/1pIzTzuKsy0nof2HPJqmx48t3ZM4j+GBNC3C/yjufBYb9geSXMMRuKs2d92ClhUewwJcRkevV8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOLM+6qm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a286135c8so26890785e9.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 05:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756125647; x=1756730447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTosloLQ3YuyXDH+QuOGGkkdswqFnw/93ewHj7HME/g=;
        b=TOLM+6qm1kq4dzlwBo/KMRY9iKJPJXiHbroBqAUD/Sl5Hc3RKl47MFGOHgigDFxWHg
         L8iAokqtpDvQ/C8HS5mkVqebD3jVEp2itPZUTQ2Tb1mHfQuvYZUgjjpLfyon7+tkLCs/
         Psg/4qdgxzCDViuEzpCAqcyKMp4joYuE4ytSadzfXTP9cFm68wasSRvXHBVOevy0f4f+
         Rs4U3/ipzx+T8NHoIinTvmQgj0c5dIgnMfV4gUhCmWuQ4Z17A2A0lPraIF/AKuFl2hHs
         57X6p4oQH5mFappu/MIccU+fbGhx1SkauIP7C0qkOrFjJdWe+h53IrJ4zTCAF7R1FcWZ
         ltLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125647; x=1756730447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTosloLQ3YuyXDH+QuOGGkkdswqFnw/93ewHj7HME/g=;
        b=D1rTdGrvHrRnKxS3uW1kQPuQAMdsnmM2X7+IcbgUiXiXwc/spulG9G+Mg8qQWI2gFr
         VuE6pgeHB7tLjXni3Zz1Rpw176pREnfclDIpSe3OqVbacnqrWRzeWwu+OtaQMgzT8yUZ
         cEQGBiENTvaugyTYhFz+dunnbq141HTzhxE3B7G399kqsh71JlcTvZrqUNKKnIkEFsf6
         jBDNUn61WUA21lFk/U2MPK9Zvn13JlyysrCdWFbgCwUc0umNzWmw/0/8foHnDTDouVHp
         gjqkZ3jUhPA4/aaXqObXCKfQPb2kCw5Xs3vBEq179FzGOBOtO18lxefbw8+D+HPN+zHE
         psCA==
X-Forwarded-Encrypted: i=1; AJvYcCX7kn5prct4+CBQcXDu9qh50JR3eHQCVng8/ixcSlqwZ0+1WGppJsbFD4pAFOolY9aXcZaQJ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvmRgK3CxIEjP5+3hn9F7jk62VEQam2v113dxAiunj94ydRQH
	eOubh3YQnOnylhs/YZnfTeP3pYtAdX5rBZb9rlhgEkU2ApRUiSkTYx9mnRz3etT7MQw=
X-Gm-Gg: ASbGncsIuTzlaLt3bYVj2HKKPo015cmR6U+b2se9ThewvgIORT7D/2Z7T7pJCy+vlXC
	XZuM0xQG8BNjpysYCUZknsHLH6rdxQ3eCujkKuV8d1ITCvc9lAC9XHbJG+ickKA6UTMLmhfOHS5
	S+yrPN707LsR2lusa8/6eLnm1cJGQcIkNwaaX4MnnWWt5UYJrTl/LaVFzdIOBzyAzUM0E845kj4
	3BXsIPBR0yd3RWiTJ9H6kV3S5jCWSxvcxLxrnKtX+tzOTlEceKCqNvqOrFTXJ+VeojUE9nnTzyf
	IOlGaEW/xeO36myDoGFmNzWkYfTiCmwyVzyN1lu553B+H0cVazlDdiczpkjSiR9tq43j5pA+uUI
	KsheNVjCosdPnIgGkMBfR4fgr4os=
X-Google-Smtp-Source: AGHT+IGYnRFBxjlOFgSEK5V1glXjk8f05pfjihNiBtPsj4TS5/Z8XylNOYygqLLEKXdAYPz0RaRh/Q==
X-Received: by 2002:a5d:5d08:0:b0:3b7:885d:d2ec with SMTP id ffacd0b85a97d-3c5d4320764mr10255477f8f.18.1756125647309;
        Mon, 25 Aug 2025 05:40:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c70e4ba390sm11920651f8f.12.2025.08.25.05.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:40:46 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:40:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: F6BVP <f6bvp@free.fr>
Cc: linux-hams@vger.kernel.org, netdev <netdev@vger.kernel.org>,
	Dan Cross <crossd@gmail.com>, David Ranch <dranch@trinnet.net>,
	Eric Dumazet <edumazet@google.com>,
	Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: [ROSE] [AX25] 6.15.10 long term stable kernel oops
Message-ID: <aKxZy7XVRhYiHu7c@stanley.mountain>
References: <fff0b3eb-ea42-4475-970d-30622dc25dca@free.fr>
 <e92e23a7-1503-454f-a7a2-cedab6e55fe2@free.fr>
 <acd04154-25a5-4721-a62b-36827a6e4e47@free.fr>
 <CAEoi9W6kb0jZXY_Tu27CU7jkyx5O1ne5FOgvYqCk_GFBvnseiw@mail.gmail.com>
 <11212ddf-bf32-4b11-afee-e234cdee5938@free.fr>
 <4e4c9952-e445-41af-8942-e2f1c24a0586@free.fr>
 <90efee88-b9dc-4f87-86f2-6ab60701c39f@free.fr>
 <6c525868-3e72-4baf-8df4-a1e5982ef783@free.fr>
 <d073ac34a39c02287be6d67622229a1e@vanheusden.com>
 <6a5cf9cf-9984-4e1b-882f-b9b427d3c096@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5cf9cf-9984-4e1b-882f-b9b427d3c096@free.fr>

No, this patch doesn't do anything.  "p" is never used without being
initialized.  Plus, I bet that if you do:

	grep CONFIG_INIT_STACK_ALL_ZERO .config

You will find it is set to =y which means the compiler is already
initializing pointers to NULL anyway.

Perhaps you're worried that about this line:

	p = kmalloc(struct_size(p, data, 2 * size), GFP_ATOMIC | __GFP_NOWARN);

where it seems to call "struct_size(p" where p is not initialized?  On
that line the compiler is just doing a sizeof(*p) and not really using
the value of p at all.

regards,
dan carpenter


