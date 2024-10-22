Return-Path: <netdev+bounces-137959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF49AB3FD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2601D1F2142C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811781BB6B3;
	Tue, 22 Oct 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KtLtxRl4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F4139CE2
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614572; cv=none; b=t1xi3zQoarTngeDJfxGjF9DnvpCPKbYkuLTcuCpVeJThH0YQA0a0MkvJQkNkZH+GdoYddr6l9kOA5SVKg6wrRFLpWqgOgZxC9QNoRUudKrpo2MRTPdUGz6IdfIifYASTASPAVekg7POv5AfvuH/hvg6mTH2doTFRHQs9EdsQtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614572; c=relaxed/simple;
	bh=7Qks6CvcAy08IF1VTlIFn6216CCNKaqgBBA3HhKb7e4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vcr020/ALuNGeS54QC4ZrHBYQGFBPVP1teFWqFZiUzOBzFaD9aMMu2cO5u2eyX+86bwop6PvseLpdRrhGVRwUnnXb7haZcpWV1+FAl9xNgWG1e5WWhl1Q7k4Ae6rYRDNYmwqn99rN8APO8ETWrc2r2tipGTrKuvT/Fibg82iFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KtLtxRl4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c805a0753so50684545ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729614570; x=1730219370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JNlvlgl/Xa91pa5IYvLtXjUZAW4lPaTIhmUIGbxaIFU=;
        b=KtLtxRl46tlPX2lvwYDEIk84G5lEmowTncPDGrthgNnVKQdfbXhgQNW1nz3nYNXawG
         HPMYwdqEtjA3ajeN0OxqLkVp3Z+U+6uaEK4HFncn4tQm/weHtECQ/AwZyxAFFAxRzVv1
         8rUWaPpXeL6uHXGEx4ZNI1CX53YWR88Dl3C/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614570; x=1730219370;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNlvlgl/Xa91pa5IYvLtXjUZAW4lPaTIhmUIGbxaIFU=;
        b=QIFC0tfCsC25k/P2dGtoYj1C6DX1ypn0N45X/5Zu4U9dJVdd+N2oBNya1Oi1GRXEHa
         6ioi6LND6qSQ/DP9fwVwVFBAH7zYViPhG0uqA1D69s8R69UT3OOYLgT3gXImXpClj7px
         ixBhGXHlQKradXmS1J1NtCnMPVEoTMTAGFnZkoTOM5lTSXkhlX/pziPgqVhtZMiFP+i5
         MD9hbsQ+22NDCNWF6znH4OekHyEelEjOlJ/jNll0UM5h2GNtFLPYKNkVcKd+ElCVR/Vq
         lWvCdJ+pOkLb52+81Nfe4wDzkKalxyskuYgq1ZhivqkzeOeL+tpwxhB5hLAsSuQ4rl+v
         ncUA==
X-Forwarded-Encrypted: i=1; AJvYcCV3zYFaC4RMAyHA6Pug7x/zek4UD+X0p+Z1SCc5IEjZLf/sVk4gQlByeeKJc+NOu867FR4KeJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidYVpg26cosiKvCx4Oo4pnQFFlGC9TJin/t15L4A6QG7qBPyD
	rQz6JoW1CcGNpXlV5AGY9Kpb7RMgXv/Q+HEWnBYkXlspwf65V9nHHJ9tab9bDxM=
X-Google-Smtp-Source: AGHT+IGB9Eu+yasVM5qJT8Dk7DAQSznFZAQokHV0j8rclm5i4zN6QwRxYWiSlJxTR5Gh9ZzMb7LHLQ==
X-Received: by 2002:a17:902:ecc9:b0:20d:27f8:d72a with SMTP id d9443c01a7336-20e5a955803mr206681125ad.61.1729614570260;
        Tue, 22 Oct 2024 09:29:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de25bsm44897315ad.231.2024.10.22.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:29:29 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:29:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RTNL: assertion failed at net/core/dev.c
Message-ID: <ZxfS5-HHcbMsjc_I@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>
 <ZxfSV66cYq7N6i5H@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxfSV66cYq7N6i5H@LQ3V64L9R2>

On Tue, Oct 22, 2024 at 09:27:03AM -0700, Joe Damato wrote:
> On Tue, Oct 22, 2024 at 11:24:45AM +0300, Dmitry Antipov wrote:
> > Hello,
> > 
> > running around https://syzkaller.appspot.com/bug?extid=b390c8062d8387b6272a
> > with net-next and linux-next, I've noticed the following:

[...]

> 
> Thanks for reporting this.
> 
> The issue is that in the path highlighted above, rtnl is not held
> before e1000_down is called.
> 
> I believe this will fix the issue you are seeing, but I am not sure
> if a similar change needs to be added for power management's suspend
> (which also eventually calls e1000_down):
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 4de9b156b2be..ebbd3fa3a5c8 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -5074,7 +5074,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
>                         usleep_range(10000, 20000);
> 
>                 WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
> +               rtnl_lock()

As you can see, I didn't compile test this as I'm missing a
semicolon (sorry).

I am still reading through the source to see what other spots may
need rtnl_lock.

