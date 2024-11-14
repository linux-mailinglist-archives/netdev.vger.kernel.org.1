Return-Path: <netdev+bounces-145040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B99C9305
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B0281A7F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764A1AB51F;
	Thu, 14 Nov 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SNy2v0ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE971AAE39
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615225; cv=none; b=Fuv5p0goETgn5t9vTybx+hwAi19rqDxNjdUTP40tavD254A8c1B+JtPjIsXYQ/5vbzVBUUHyOF6daWd6nDMYSGvniBhhKnfbhA7p9+47tddkDZF4LnfhT7T3Qq8+LBValoV7aoT7sLMF3cXb2LX9iPbiF1d/Wwr8V3+J7UglEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615225; c=relaxed/simple;
	bh=pCKYJj71wA06N6bc10/er2DhbontUDxAdn6wLTdlpc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB6fCqGRfKnWbtN0MpuIABF1PsITqpJxvSHgoDBJNqoiJZHlkcYw16qgv2rK/f2bWt32DDKg25a0/kKYIl9RByv3teoiGXXXXXAVtf9OLm/PukMOGnWdB3FmYA65owRYC++X8PF1rBZ8wE2DKbGOT9uDpKHyqSA3iP9DeYD3+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SNy2v0ay; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7240d93fffdso18160b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731615223; x=1732220023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otowYy7OdNtGuwhI4NBl1VzW4OrjPRlTRwbtUvhfdIc=;
        b=SNy2v0ay+qQNr+QEft0IoSuDfkbI9Ro6UGYl7V4xSaEgtWujQkMgpCTST9yN7HfpC3
         uHfOTW8WPizQ+ORXTj+sG2eVsr4rgKsDpGlYzkxAdCq6B6fanMnFJXEGgQ3gHoC6jW0B
         1ikXeGgWYjnI2p6VplHkGxJJYyW1StHGjuvtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615223; x=1732220023;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otowYy7OdNtGuwhI4NBl1VzW4OrjPRlTRwbtUvhfdIc=;
        b=rhEhrCKb+dON5m51i+aTUnpBaxF9WWu9em5vTcFx6qlcwmaGC0SiVk0Pv7aggsQ0Md
         2uTUtyb16KNScWJl6TZ37fAWLvUe+FwghOxy2JCvjbVmZPpD+YSB3zk8expH67U3oVEM
         za3H2M+AEVd2Fuo8hMLuTgjYs6bivnBqdnaTaAmM86WBGbsL27RKUdZbo7gHAAbxZU1B
         FzUthBTrXJVi/cQ/Dw3DaOtnkFJYEEzqBQHhkZiIZeyH3pd82LI+KzQZHJw2wdo7uaeY
         gVi4CxeO8VJ6Xs9OkqUfockxWHyEfmqgNuzwylIk4WhUqI8sZp0w0iCEpzJ8ZJyz++5H
         zijA==
X-Gm-Message-State: AOJu0Yw2nnbIzMHuWhOIZYlLpk/AiSg2RrsunMOKb1Y72qjw7/CgSVkD
	cZVx626+lZ0E8ePaFMlRwD/t2zWHREGiGq9+YX2TWgtN7pzriLJfJYCp9MtWCp8=
X-Google-Smtp-Source: AGHT+IGzgiCgx6YZ4l4cVmh/B6atw7K/LtNrtk/3mukGWleTD3P6jRL/9E898TPH9UCk8E1KLkgQHg==
X-Received: by 2002:a05:6a00:23cb:b0:71e:4fe4:354d with SMTP id d2e1a72fcca58-72476cccb37mr184064b3a.18.1731615222806;
        Thu, 14 Nov 2024 12:13:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0baesm26423b3a.92.2024.11.14.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:13:42 -0800 (PST)
Date: Thu, 14 Nov 2024 12:13:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <ZzZZ85ONoGd8fF7Y@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org>
 <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
 <20241114113144.1d1cc139@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114113144.1d1cc139@kernel.org>

On Thu, Nov 14, 2024 at 11:31:44AM -0800, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 22:29:50 -0800 Joe Damato wrote:
> > - Rebase patch 1 on net (it applies as is) and send it on its own
> > - Send patch 2 on its own against net-next
> 
> My bad, I thought patch 2 is also needed in net, but not in stable.

No problem; sorry for the noob confusing on my side. Hopefully, I
got it right for the v3.

