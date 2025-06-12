Return-Path: <netdev+bounces-197205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9ACAD7C52
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADCC188060C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC9F239E7A;
	Thu, 12 Jun 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNro+Lxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E11A265E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759822; cv=none; b=m9tH2vGUFqbfJEJdK6LJiaJa4tDpMmYdO2hrBN9C3sPmtvpTkh9sbUAQUyrhHTSWsQsGdgJqOjECW7E00PQjxWA8BBuNPuB0nGBz2RqxFWfrmtoXiEMOOB6XZTCqmXZko7BMHoN7GYoWDm8rDUxumVg2gYBrhWAhr2Hmnnj5c0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759822; c=relaxed/simple;
	bh=6jVcHGGZK3tLZgdMAF0nBAwKaUmegjfYDoSyU158oLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6cX3luc9PVkVJR9qUSPK3UH2h0FkJPIvNe4czdxOg2E/B+0JokVbPT6pqNdOCFJAjlINPqHSDc+JWtRNkseLFeGy5t5GS84xVT7eddKNvbqNT/dP3t4aTx27TQurIeX8rak8popakUZyFpr/TuCTqGsA0EY7R0DWe23A8afa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNro+Lxo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2353a2bc210so14196475ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749759820; x=1750364620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1HrjT0EgU9O9bIFhFQtS6IoS6CsATOQ2exdSqm7ts0=;
        b=FNro+LxowAWWv1VbTSm0jS83ciI6KAF3Ih+x30K/KSNRSUH21fxiHa+10W3Z/cLjpq
         PyRjTRL+Gzb24eG6ByMdLFlrqz2CWTk1BkS/Wb43d/PeOVAaI4QxUndlSfNBwVRIKkRQ
         TxM/1dTFHfttj1iZU3JS+oLvd372sG7nJyLf0qIEFQWrhkiOSeQQbgBdC7hOxnFZEQU+
         iHtaxSOCXRJuYeGOF8thIh52gkMNQEkOEdh9mVp+/j2Cd/J5064mCHg93BeTxBAkRXFn
         kAh2Xh264he3jwGr4yyMVpZLl/tAKDozrILATdO5HIxZk/xdVFjWFA0HPEzjtlzhSASg
         F9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749759820; x=1750364620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1HrjT0EgU9O9bIFhFQtS6IoS6CsATOQ2exdSqm7ts0=;
        b=C1SregksA4oXl6MY47Opz2A1I5C+hFaccSz9f4xP46+f+crtV+kvFCFoiCTsM2puTP
         ycIUdVdB44Len27TvchmnnSuJEU+zL/Lh5Iqzi8XXbdKkoK9ww2GX2dVLhoVgaj/gEV4
         Ev21umHKaHRcdd92yKsSv9mDOiEN1TZYBVwEHU5qqH5/jqwixYL2zFMmz0mxj9lUh14q
         Lt8H5PoHJ9nKdx5nEBRrh48cNeIAzeH0zGBJudW6jbl1L12JNJG2flu6aNwuxR0xAf5a
         5n0NzqxQpKKYtsgu5QD3BIYqyaz99j2ZAKKc7k/5NXBLMuHkbzMBiFKH3j0vY0VbepLG
         564w==
X-Forwarded-Encrypted: i=1; AJvYcCV3yNHq2+M+v/k8cxSvZ4PjRGqbgka6xUFbELO0IO59enws2gOLSB9RHhAj6SVvmCJ/Gc++wp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfbm1+vS9mh8GBLhMFMIcYoQwYEbkykouqAuC6PkQg5LxLp10Z
	JqWuIImXPDz3c5aiqFN1VJm3ukFEgACSiZVWh0YDZtcF5iqqNSuLRauT
X-Gm-Gg: ASbGncs4SGU5pI2ioP8ZdKkbt7IdEVvBv5xisKuEO97oYJQxQVEigGg8KZxZi61SvYF
	mA5RUwn01Ao15nj0O7BC6rFN74nrFHgUXz/hE/wvoFNaT708jOJoB+5uMD/ti+X7Svt8xsys/PR
	pS8IvcoyXr7S8rm+Y9ibzz4aFQl9XyZoD7rMCF8VSVgTm4iL/NnO5rfeBYm4tEdQ0ufu1Y4Ibwl
	PruPA4LLYuSNIM+Zt7mWWCQ7t7JhLnh8sP1D+4zzyfsABVmgzfwOpZFmGJoI77LAE10GnJIcvz8
	/cwrtL5nK/P8xZllVqxW3zsQEN/mazOQr5KanYQyaP/laslNreyf+SqJFNnw7Gt6oQ==
X-Google-Smtp-Source: AGHT+IEDWlrjK5ChTWg8MbvJENPVFCG5gbhg2olHSxod4/xA2yLd1yE+1Hs8PCPI8kAFSZuOaWzkYw==
X-Received: by 2002:a17:902:e54b:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-2365dc2fe19mr5479785ad.45.1749759820151;
        Thu, 12 Jun 2025 13:23:40 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bf19sm1460415ad.48.2025.06.12.13.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:23:39 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:23:38 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, vladimir.oltean@nxp.com,
	netdev@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aEs3Sotbf81FShq3@pop-os.localdomain>
References: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>

On Thu, Jun 12, 2025 at 07:16:55AM -0400, Hyunwoo Kim wrote:
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 14021b812329..bd2b02d1dc63 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
>  	if (event != NETDEV_UP && event != NETDEV_CHANGE)
>  		return NOTIFY_DONE;
>  
> +	rcu_read_lock();
>  	list_for_each_entry(q, &taprio_list, taprio_list) {
>  		if (dev != qdisc_dev(q->root))
>  			continue;
> @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,

There is a taprio_set_picos_per_byte() call here, it calls
__ethtool_get_link_ksettings() which could be blocking.

For instance, gve_get_link_ksettings() calls
gve_adminq_report_link_speed() which is a blocking function.

So I am afraid we can't enforce an atomic context here.

Sorry.
Cong

