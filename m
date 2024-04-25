Return-Path: <netdev+bounces-91213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1A8B1B5D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 09:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EFD1C210AE
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552D5BACF;
	Thu, 25 Apr 2024 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XGqj47o2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583F5A116
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028495; cv=none; b=Ogk/75e0XKEH2GOe5zgAp4bhTQ074qHsuLweGT+LyWwlVyR+fS9rP2R3e5p67W5r8HreyhOPA6Jk/rmJHR1JBB/h3gcsDVx1AuT0kU8PkGs0i6AuD2rYJxm3W/bqMlb+esT14XaL/rczxARviPIMl+KM+WkU6uX5nKeIRh0KG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028495; c=relaxed/simple;
	bh=WiiUok4AegBe2uU4K9vMo43oS3SWMuOEatwbq1nPPwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKvEVIbDTcpM1J+ue/yNX5raavkVCrWGAzHL7OMUGkWjHCAIctx8UvvrDVHsemXCcQNNaOyVvidKp2ltC8lbB6BilWCnNPnB0mFZGLhkDIpqxjpNmMTYoB3N7AOJyfBveoMtniOgmd/MsjzxJvG16lkmDBd+IKzaB7CbnRtU/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XGqj47o2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572229f196bso659725a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714028492; x=1714633292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6C9uaWNnv7OreWQT4CPgZHNrbG3hZGGvHKOXRENPeQ=;
        b=XGqj47o2M45zfoYgVPL67FlbgUHf14BhASJ2JznxrBOC/lDefoiwoT7kZD60NZAjq9
         jwOZ5AB5EOsVEkgkL1ifBiIT+ADzadmEe08mmGMUXKs73m+/hMPMH8j+ChOYm8/DBolf
         Dlv32A5ji+JMsq7uVPVCjkBiIAkR/7dAo64YuZFIh3KGN7cbfs8FCzzePgisDnjlxY+L
         8pCootTcYEDM8J/jxXlf5aNMITAvqToz+MiCSAQn/9Tu4fi/DjcIfqzczf8fi2bRXk0a
         Mn6sVqUAgWYC7GapNY/HwwOLF53ZhokRf2GTJrNt2+ax0e/RQCSL4A+57nsMMihEUc5m
         pGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028492; x=1714633292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6C9uaWNnv7OreWQT4CPgZHNrbG3hZGGvHKOXRENPeQ=;
        b=lGWQhtffvhmU6EPL93OzjOzWvdndgVkk4cqzdBC7lijy3Md/ugD4FCkTuPWN0i1cPC
         WOIyT9D7nCNhxQyAVtesvfQBgr/9vBuC0X8/cJaG1nSEUFPMaA40hZEBMPKi1juqXpZi
         aKEUzATNVCFul2UgoZLQP2gv6YnNZMj0gSu6zDRMFGOlAQpikt8AspT3vtfNXL5Fuarj
         Xw/ACjROexyNzGwC6K3OMYj0zsbQL0nJCpjjWq9O39IG5XmW8lYUYsph/B2SVO5JkHcU
         n8BQvsAkKWvzJuuIWVyMLNpCzqa2M1EW5418NHrwvIwC84+AL0BDNSCksEs0+5WqaxhE
         wt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX861+kXhD1Kc/HFzEoGoq6q6WfdBaKNB7/N7eQXLETy4XCPygerftE6wMKQoGESjpYnJTAdDdOas7JM5PJTP+NsL5NU/Y/
X-Gm-Message-State: AOJu0Ywm4toqRvO8ejCkZQ545b80F9vW9dK1zxnvrWLe3iox1xuj3OHa
	Kn7EYNTJG6E/JpO61phc0ZUA24hiXJrcjhiQ4i5ISUi8W18qqhSuE49ejp4cT28=
X-Google-Smtp-Source: AGHT+IFB6lli7LnflsZkGyY0QY8gATtlywaKK70+9vEOrHkrwpQU2p7kgi3nYFoKqr5pDPi927Qmhg==
X-Received: by 2002:a50:9541:0:b0:570:1ea6:e986 with SMTP id v1-20020a509541000000b005701ea6e986mr3584233eda.6.1714028491655;
        Thu, 25 Apr 2024 00:01:31 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7dd4c000000b005704419f56csm8669745edw.86.2024.04.25.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:01:30 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:01:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Geethasowjanya Akula <gakula@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [net-next PATCH v2 9/9] octeontx2-pf: Add representors for sdp
 MAC
Message-ID: <Zin_xmhFiD0-rysf@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-10-gakula@marvell.com>
 <Ziex5kCf3XwNQzjK@nanopsycho>
 <BY3PR18MB4737A73191B281ED6BDB466FC6172@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4737A73191B281ED6BDB466FC6172@BY3PR18MB4737.namprd18.prod.outlook.com>

Thu, Apr 25, 2024 at 08:09:03AM CEST, sgoutham@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, April 23, 2024 6:35 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v2 9/9] octeontx2-pf: Add
>> representors for sdp MAC
>> 
>> Mon, Apr 22, 2024 at 11:54:01AM CEST, gakula@marvell.com wrote:
>> >Current silicons support 2 types of MACs, SDP and
>> 
>> What's SDP? Care to elaborate a bit here?
>> 
>> 
>> >RPM MAC.  This patch adds representors for SDP MAC interfaces.
>> >
>
>Hardware supports different types of MACs eg RPM, SDP, LBK. 
>LBK is for internal Tx->Rx HW loopback path. RPM and SDP
>MACs support ingress/egress pkt IO on interfaces with different
>set of capabilities like interface modes. At the time of netdev driver
>registration PF will seek MAC related information from Admin function driver
>'drivers/net/ethernet/marvell/octeontx2/af' and sets up ingress/egress
>queues etc such that pkt IO on the channels of these different MACs is possible.

Add this to the patch desctiption please.


>
>Thanks,
>Sunil.

