Return-Path: <netdev+bounces-97539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E0A8CBFCF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6952328358E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061681AD7;
	Wed, 22 May 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFOc5bTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372B80C07;
	Wed, 22 May 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376137; cv=none; b=e+ssxXaxd0zbp+lDaJyuN+Xce+UqZC1TwjfdCHc9H9sYGWsM9jJOgUr/XcmUGutrx2zueWs0dH1xjRr0n9DbQLRpO8LgCMNyaHLobG7XF+TUIDTzzfUDpN1SDDsKIn/cunjte/a/sYaWckC+2vGsVJNQs1gfOJOv8xFd3fmp0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376137; c=relaxed/simple;
	bh=EUVi8pXNqTfD4bu+3/Opg1n7iWHcwxR9KxjT1HjrgnM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DNFKAPzaaivsgRKxA0A4njsOff9VyLkHuW94ThhndGBwCYOpgrWIvatIxPo4vU0fZSYDDGLXO55Yp7nUCYrR2ORFJLLiMGNchmUoP0nEybn8ez7lSpGFeDjDhYlt7frPj7gDlfMuv47TB2vY3mJpUEgzXOYXfxmGIemoTuHQ2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFOc5bTb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so6014655e9.3;
        Wed, 22 May 2024 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376134; x=1716980934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTA7LnXUVCxdmoKd3vWVKbpmE3D6UHlWv/BKj3RwnS8=;
        b=SFOc5bTbYDBQArSXa3eFaLKP051TESeu3UMCbYjN09H526TLIglRgC/XfR/MK1F5Kr
         6e/xfgo6qAV08TpTnrztXAHNcMTgAValA7aGj9qKqUIufU13VnKUilQDitaOE0T01HFA
         U/7WWGbedORSevrG2g8PrCdy+ZGU6DpuljXU+ntqArMosYVmRDb5PWBVwocCskZyW43L
         rwDYQmjAFZpU08ZZuPDrtQlkZg3TKkUvvwgQUvd9rugBZOzbTVJZ0ao1LFSujBgwYldK
         yYpE3iuhobuXraU7Utt2SmSd8V2llpssGlCOG7KwG78tdH5/SOGW8rkz7unoqJivldxv
         gZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376134; x=1716980934;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTA7LnXUVCxdmoKd3vWVKbpmE3D6UHlWv/BKj3RwnS8=;
        b=qBN3+DKwEmZ25VRwywHIolF+BCS7EMwebZlC0O6IrOK26G4jnzW2EiGBqXo6PEUBt2
         CJ2tsJe1/GMHkDIwm+Pz8XNCHQgRM6MM5hG9gPyOZee35VK/+HQlGOb/k92wf/cYPup9
         SzQLcm1vYrHjAJMWPC6QX1D5Fjd+kFyVKYuIoCw0XJ9RI9naJiXg5UPWIxVVVUXKTCmp
         fs5HNoix4I2gEXb8QxerYtgnTM1i9vMcTlETEhu6dbn1j04npqTkk2i/mRXSpaNoMr+j
         gM488iGmiISI0V9S6sHHLH/rMx9KxrNX3BZdqanaGHUfDm6ZEFnMhoxaL1MNVIe4xWjX
         lkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG3lNHnoi4smm3uqrHoW/G0noErrcIZjyWJh6RhzyDysb3rehqXpBGTaWr+vrDjnizHKlMWJZ0F6jjIrh6KS+r5XeJyvcjL9sJr+7/mtCK06h452CdJkPom3ZfmlxD8rk2VpZ3
X-Gm-Message-State: AOJu0YyzbrMlPnaYFOTZ61hQQMS9IqqgNFf/7Lg43AQ0fN37gVKge5NC
	ziWVPoLOBgzIu8kaUfD6EokekFDwH0v9DcJsjAI+MpZ3ParV3l7l
X-Google-Smtp-Source: AGHT+IHzSwBwOk+aDPnk13PzYrPuoXchlVw/Y8U96+cttyLLSHQJ1BDt2/OzxMjtW076hS73tWCuPw==
X-Received: by 2002:adf:f504:0:b0:34a:687a:8f66 with SMTP id ffacd0b85a97d-354d8d7b3dcmr1026586f8f.45.1716376133551;
        Wed, 22 May 2024 04:08:53 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacff4sm34208278f8f.79.2024.05.22.04.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:08:53 -0700 (PDT)
Subject: Re: cpu performance drop between 4.18 and 5.10 kernel?
To: mengkanglai <mengkanglai2@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
 "Yanan (Euler)" <yanan@huawei.com>
References: <9fd382fb581e47a291ed31bfe091112c@huawei.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <0826f183-5402-5529-c935-e933b817bd74@gmail.com>
Date: Wed, 22 May 2024 12:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9fd382fb581e47a291ed31bfe091112c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 22/05/2024 08:44, mengkanglai wrote:
> Dear maintainers:
> I updated my VM kernel from 4.18 to 5.10, and found that the CPU SI usage was higher under the 5.10 kernel for the same udp service.
> I captured the flame graph and compared the two versions of kernels. 
> Kernel 5.10 compared to 4.18 napi_complete_done function added gro_normal_list call (ommit 323ebb61e32b4 ("net: use listified RX for handling GRO_NORMAL
> skbs") Introduced), I removed gro_normal_list from napi_complete_done in 5.10 kernel, CPU SI usages was same as 4.18.
> I don't know much about GRO, so I'm not sure if it can be modified in this way, and the consequences of such a modification?

No, you can't just remove that call, else network RX packets will
 be delayed for arbitrarily long times, and potentially leaked if
 the netdev is ifdowned.  The delay may also lead to other bugs
 from code that assumes the RX processing happens within a single
 NAPI cycle.
You could revert the commit, and if that improves performance for
 you then more data would potentially be interesting.
You can also try altering sysctl net.core.gro_normal_batch;
 setting it to 0 (or 1) should prevent any batching and in theory
 give the same performance as reverting 323ebb61e32b4 — if it
 doesn't then that's also a significant datum.

-ed

