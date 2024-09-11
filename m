Return-Path: <netdev+bounces-127480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600269758AE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FBB1C22874
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379E1AC8B2;
	Wed, 11 Sep 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlHtOJvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE54D8B9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073158; cv=none; b=SU3VXq/pRr62F4Y84Z24/EbhHrhR+YKE5YEgRmCXpAzzP4B+3FjrTZBbChD2h5XDAdFl68F8fEISaU7Qw0WJGtqJOn8VBW2f3Sd3g7gxZPRYQC9ahHRxQsyIRE5YwoMg0vgjkGJvfS0thWy5SU2pluePhhLzyfGgvu4wvanxvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073158; c=relaxed/simple;
	bh=muxbbxDRVsv2QDMfqnXVSHvG5Uhx6abcDQ4fYY/K+bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyjeLHwgXEGSVcVXO3LhVD1RoSvWHjSGXYJ4ZbFPt1LWkVt37QqNw828l/NkRrwxgyYxkBUR9Mm514PD+W+lc7cIqZKB6Ygx6rJ3tnsOB6hNbK/EWVmJJUK/bwvV7Z2YFoxXFUHE5ACCw6wzp/Q43qaPxrf2LN+Sf136VBnHSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlHtOJvS; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e03b6d99c3so14982b6e.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726073156; x=1726677956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiJY8mEVntebwdt1Up6l8zcXWONEhIecSMn8XiTv8oU=;
        b=AlHtOJvScC2VReoq9eyd+q4KnkP1Wqo429/4txEMFid8oX26uMK07MippCOq5hS83k
         fRSsFtBuhu0yExOImI+JcFtQgkSgPYvgMbG+5TIyAtWRAau4plrYw5yABL64UDlHlSkS
         la7a/+eRRvhzhZB2IB2P5Dm51k6nVCmxvpzhBWKGuCw/hdNBLTMD/MaaQ8/FGPur7FAi
         zx9HaHJgC89FvtCok/pPITAio6tru1VqQBQYUrFa96N/BDJLscgVUnNtSWeKvVy9lDeO
         H7ZeKfu65j/eWTHnEL1bv/VWP8zklnpee1FFkJJANK8Xu2I7NapKVrztPfxLXH52XJaZ
         BM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726073156; x=1726677956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiJY8mEVntebwdt1Up6l8zcXWONEhIecSMn8XiTv8oU=;
        b=COPhskvz1k3GhbO9Utx8InJdNX257/SAqkvD0vvFrUt8XgGOVP4kIpnVvEcoXqkXp5
         R4t5cRAUctIqL140R3S7a6SN33STwoqg7c5J3PFUJ9gJYSgS70SpEjX3xl1OppxYZh9O
         n91na+4D+wS6hespheLuHc4r4r6GSNgwVhVtrPDEndcYxkfEQzHzjxzfS9SuvNtbmQSl
         wADLe5Yxy6Ju/AnV/qzwW87rWKYI4HVYsaKzHAUVB3FxacCMaJxVNMRlx6tG9+9xFHeD
         flml+t04lL3QjpDJYimMmuZXLrc8gB1KLrzyET1T1+MAdul+KuFcFGxi0ZFlURaN/ays
         v0pg==
X-Forwarded-Encrypted: i=1; AJvYcCWvGWTcZBZL4fgb8gMzQJ7ppxX/p6CFcUpiQL8yiimIH+UiopXZWJ9vJTVXmsIMKMCp/8jR8zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrS0my+0fApxKxKoT4zN0iWIb/KSO87S4vN8jqj0ClsYXeWon
	smLDbpXWoInYgkf+9CQ2jd3ZnA3Fw1K/sNZOqIQYTi58XNlAn/3x
X-Google-Smtp-Source: AGHT+IHLsil175UcveB/DLKXzfNwquBwKPZzqvslqQ9oVYng4a/a0g4dPtkEYu1F6tfnXtQ1Vvbewg==
X-Received: by 2002:a05:6808:3a16:b0:3e0:4441:8cb4 with SMTP id 5614622812f47-3e0681a163cmr3040017b6e.10.1726073156257;
        Wed, 11 Sep 2024 09:45:56 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6166:a54d:77fb:b10d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdde8cbsm186390a12.60.2024.09.11.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:45:55 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:45:54 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH RFC net] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
Message-ID: <ZuHJQitSaAYFRFNB@pop-os.localdomain>
References: <20240905064257.3870271-1-dmantipov@yandex.ru>
 <Zt3up5aOcu5icAUr@pop-os.localdomain>
 <5d23bd86-150f-40a3-ab43-a468b3133bc4@yandex.ru>
 <ZuEdeDBHKj1q9NlV@pop-os.localdomain>
 <1ae54555-0998-4c76-bbb3-60e9746f9688@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae54555-0998-4c76-bbb3-60e9746f9688@yandex.ru>

On Wed, Sep 11, 2024 at 12:51:04PM +0300, Dmitry Antipov wrote:
> On 9/11/24 7:32 AM, Cong Wang wrote:
> 
> > I never tested the RDS code (hence why I didn't post it). But for the warning
> > itself, actually disabling CONFIG_RDS made it disappear on my side, yet
> > another reason why I suspect it is RDS related.
> 
> OTOH sockmap code depends from CONFIG_BPF_SYSCALL. So I'm pretty sure that
> there are more sockmap users beyond RDS and turning off CONFIG_RDS by itself
> is not too useful for further investigations of this case.
> 

I guess you totally misunderstand my point. As a significant sockmap
contributor, I am certainly aware of sockmap users. My point is that I
needed to narrow down the problem to CONFIG_RDS when I was debugging it.

So, please let me know if you can still reproduce this after disabling
CONFIG_RDS, because I could not reproduce it any more. If you can,
please kindly share the stack trace without rds_* functions.

Thanks.

