Return-Path: <netdev+bounces-143119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615149C134F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65942846FD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891A1BD9F9;
	Fri,  8 Nov 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MsKfIE2e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D88EBE
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027072; cv=none; b=CCcfBPTePuf9NHCNJtx0il4TocoEhPtlmvr7k7WkPAKVatZH0vIO5zo2/xTJSegMngxWFR2n4CgPjGxSCwHvXH98DpWZ45JtpZitp75gwViFxJCOwAjFzkFWXNv9lBRMWY5y4hkDjTzzxF7FIU0hgo/KkUbgwbPNNwKbnq/7fYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027072; c=relaxed/simple;
	bh=EkvZN+fvO8IPHhMIs/eiPJd3rH5DKawZfnHv8lL32rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzXUw3HHVBApZPZ+ovwxP3GH1rp/vsqh46p5wug/pexQx1V85Tggh5WhsmR1u7O4PBcxxt5/1bq7DkbaWsHItkj0zdCDaDA5eijh2F3baKW/5ijL3BYwAyWKrReCWdWSYJM9SsU/3kTiK3C8I1DWy3ybW2qy+Exco7wp/E/qFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MsKfIE2e; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso1377906b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 16:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731027069; x=1731631869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t27cfroJH9TB7hdPF1HXEo14qpInzcrC+NjZSGpkhsY=;
        b=MsKfIE2eQ6Ixmxke7GuYPBz/pzN7SH22dJGHPTww0gICxOhzb3riOGBU6RAGJcHvkB
         HUzxIWT8qJ8Rkkt4LzUg5+hIQ+MT8ZEnR4phKYKfc4cVRt6NdtKBnWAzKu9qIHDIWRQK
         5nscjoVb+LW4g1J3uNCNDaqptxLu5cWjmIJ1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731027069; x=1731631869;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t27cfroJH9TB7hdPF1HXEo14qpInzcrC+NjZSGpkhsY=;
        b=c5xRSnRl2A2IHJMe7V8LRcyJJ/4wSZ4m3ZrrimdcekfzJ7D39tTMglt4MTK56jevrs
         Wh8Txp143DxUwSh8z+Im6EgeBkBreLJ2gcpWT1slEXWKFtoXD2vfZki7Fd4Rd6ki3/Dk
         rG80ViO5Kwg2HHdCgb8htFf3GAPVd40dXf2dtEX4+mlYFCDfBpUlolka84k1nh4oXJy2
         7zS/jvO4y6+9bnunuFP5TmCWH6+abmxaW4V2WO/zq3f7HVm2at1hBNS6y7BOH+QRoYVG
         oeLe4rvqgyVtGeGJnLf1EgoPze0DBRkDuyqkglLoBaJv9mEcaTCBU+LqtACVf5aHp6hr
         ZmGg==
X-Forwarded-Encrypted: i=1; AJvYcCU3dK/dewj9V4GYl3M4TLRSS7pWykyd1R6ad+R16ZsGiboShv16tL7a5CQl86liDbrq3LTZp1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtABPf1xt6KfJpOAbWZPsyiLDEaC+blO5e+BBybHUocEPLE+Y
	+MunRG1UT2Nbe+PznB2r13/Vy5UETgOni86RoSjhszFEOrN62/UiXMSlxaUtzDg=
X-Google-Smtp-Source: AGHT+IHzdIIPWkhaAcJNvQciv1I9zIZrwsClPf3ctLTBzdJQTyACpRdQesFQwnWyhOfFjXzjcmFLVA==
X-Received: by 2002:aa7:8882:0:b0:71e:6c67:2ebf with SMTP id d2e1a72fcca58-724132bff58mr1432070b3a.11.1731027069522;
        Thu, 07 Nov 2024 16:51:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce1cbsm2391043b3a.87.2024.11.07.16.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:51:09 -0800 (PST)
Date: Thu, 7 Nov 2024 16:51:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] selftests: net: add netlink-dumps to .gitignore
Message-ID: <Zy1geqWubYmrYGjk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20241108004731.2979878-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108004731.2979878-1-kuba@kernel.org>

On Thu, Nov 07, 2024 at 04:47:31PM -0800, Jakub Kicinski wrote:
> Commit 55d42a0c3f9c ("selftests: net: add a test for closing
> a netlink socket ith dump in progress") added a new test
> but did not add it to gitignore.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com> 

