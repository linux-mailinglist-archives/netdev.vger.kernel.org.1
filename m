Return-Path: <netdev+bounces-118573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD2952172
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE14B244BD
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0D1B9B2D;
	Wed, 14 Aug 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fby+Czo9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110E1B14F8
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657452; cv=none; b=IVzC2Ou4GOK9UvFjZdkiapCGeALuq+RYAaDv73mRw1MN4rKcl444GVEKhscvy0wcJ1CANEG1ns0glk1FWq1Y0xqEGcvGnZ3swDXih3u6NYIwMRYOV0YBgrgtPSB5vIcVNtFWLqMYiHiGHjpUshYOXk4IGbq2VIGRrtX3HTGjJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657452; c=relaxed/simple;
	bh=1p2wiaRAIaqAITafCyz69cM6inq5cobf0Fe852jXqmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT8D+ogp/vCpo/xTS2UENDA8vqs1moWZRii3KtVg1jWMCt+WNF6G2ebEagqvPWr7nm3qFcARt+5zUytk7TvK6CEsxCndQjkZkkXCtKEUcqNoudGjkb75Z0NFUy6LmyU9urxRWl4cnNNrGFqeob0X5VqX84J+i0b2bjZwl+ovn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fby+Czo9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d316f0060so855546b3a.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657449; x=1724262249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn9vW4ba3+9kHr4238iV7qQOk+Gnuz8QPe3QCv+drLA=;
        b=Fby+Czo9/vkYvwbgA0+/HVkb1MfRAlVQGs8CoZe0B7yFUgatqb68g3XDnpwG/C0HHN
         ySlfbGyB/kl5sD6kdfKzrZ+rEzNm8k01DFF1hFpmoS4nu+4vAE0fsnxnBVsNEqhtEEw/
         xDTybziXDYeqIe88DtikObpQajE5rBDIBrSQZ9lO6GdQWmjvbywORE8uNi0aKevPADyA
         1U+Y6hILWaGuTDsdlmGAlZ02aDk7FUhlxbkKnw9aKt2ccMo5BjvaunxtZOXkN6KaxkFN
         8Qvc9HwHCzMCflG8zDZzKewoHw6iMgX/uAykdn6E94e8LbcJlTiEhdfynCpDMhieAzMG
         39lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657449; x=1724262249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn9vW4ba3+9kHr4238iV7qQOk+Gnuz8QPe3QCv+drLA=;
        b=uohUNJNN7COpSN4Mc3+Ae2NlTo5goIoEM6oGYF3tS8mpVe8Z18DhFxwaUwzXjACqLM
         Nu77x8jsVf+yd6MfEQH/TNRjNIsathphPpRGdcxqri8hOsTtf1F7QdOP3Epdro06VuBK
         EDITvALprebtAuzegzHjbO2pK5U/SdjoBJr+wSkDNN7be2+MEFDUJeWGAc1bnyAdzwYd
         uWg9x43Tsiom1X8GN6vl//WOhNqplX+j/ZN79eB7I665K3iuKj/bgTG7b5g7RZ7URah8
         NvKV9zrwRSYocOI1zIFSHCBdvIEphx2JNQfZWerjuFLXZGQ02eELT8968z7cJH25fS/y
         tH3w==
X-Gm-Message-State: AOJu0YygbUAcHCY6z60nqCBLTQVQVTAJMAdxO3VKwfoB9tXytVhXMn0w
	Rjg+nADe7+hTbUu/CLacDccSqNLGil3Bqoh0JfSluUJPw4vmMtHA
X-Google-Smtp-Source: AGHT+IHwMinoCwESCGZVDIb/cl7zyeQucqy8zsZgFTgvWT6xx0w4ULlUGFmF+CFwyqa5M6VA9G30wA==
X-Received: by 2002:a05:6a20:9c8a:b0:1c4:6e77:71a3 with SMTP id adf61e73a8af0-1c8f8581079mr801992637.3.1723657449371;
        Wed, 14 Aug 2024 10:44:09 -0700 (PDT)
Received: from localhost ([12.216.211.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab7b19sm7564954b3a.207.2024.08.14.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:44:08 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:44:06 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [PATCH net-next] l2tp: use skb_queue_purge in
 l2tp_ip_destroy_sock
Message-ID: <Zrzs5lDP2Mwmvf91@pop-os.localdomain>
References: <20240813093914.501183-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813093914.501183-1-jchapman@katalix.com>

On Tue, Aug 13, 2024 at 10:39:14AM +0100, James Chapman wrote:
> Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
> ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
> socket cork and ip_flush_pending_frames is for sockets that do. Use
> skb_queue_purge instead and remove the unnecessary lock.
> 

Please also unexport the symbol ip_flush_pending_frames().

Thanks.

