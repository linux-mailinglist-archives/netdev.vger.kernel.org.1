Return-Path: <netdev+bounces-223551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E081AB597E6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569363B1A26
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0D3191CB;
	Tue, 16 Sep 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkoliKqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BA315D37
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030019; cv=none; b=I1aUHfWXrY8rw4vX5yxDgaaUhP40Xa6xOA9MNylI9d5ofqPqAEMz+nw2kxTqLb/YkT46yStDFA0mDA32qcdzwPUr9OB5QesXgQKOtFvh+6g9O00RX1GE8fQ4hRLkyMc05DLdFB+Yc/IUJ1TgsiRsgb4pCgIFhr9Pxmarke6YUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030019; c=relaxed/simple;
	bh=+gio5aL+IW3u8W8SSU4aBeYKAREDBl4pvtVMTW2Fww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj3E/nHO0eSfv3yTaSDNX67bfhqAooGlz4f3KPU0M6ZFPHDvahIfh1o06M5cBB/a6ZEb0q1uLxiiT6kNQreetPC8e0JUZV/1eNceSsblgEE8p9mXbNDDTGaxZlxaAiAXzl66Ui0DIzf3BWwVLPc1Z5HPwN6gtynmKwuXNk51Pjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tkoliKqr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso55075925e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758030016; x=1758634816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=tkoliKqr+Puwgc4wrCBAWlwO76XhSpqvtbzRhcjH8h9IHYLdD0Tgl/3LxnAHvGK/OF
         w/+FBaeXfdzLi1t5i7yNR1Ko71QSPtOH+yIYovkoMpdary1q845eGwwXEV8iiIdMyctd
         tUU37urY/o7g/x9ndJV/NpB02WMCTdKZ7L+ssG1DedVjNAHkhs2ea1joSyCVOCrJ10VI
         ZzOz6B3DN9KHXpBej51hYbhVpc+O+AVr6Z1J1DsjOErRB+E/g0ZMDudvjUu47/G2pPPv
         S7sCE4hFC5qpVdNPFCWjvj4u1DADpjb7z+KsP2o3SWtZtpKgvagli4UGFT4zibY685W/
         FObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030016; x=1758634816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=XQYxwRpSWkKXpGDV+IhFUaZ3l00ReQ3FKSZhAlSGuwEEOMK9zRKSswsCV30pcHE9vc
         Y9zF2PpuiBhK8V3oxKCG92hHxLobiTjBQp4fAgD4bhg6VnsO9lMNwtd7dVFyx4OA1qp+
         pR51lD3Ju+DLsjESP8meeauVZ16Rhq2BXyGYsHn8g2tg/cs4RIdGqUzK8dG+6OBLROSN
         bDp+mAXls1jAH4wziyvnkqfBN/8uZqjC2j8NueaE7y567QP6a4q609jgkRIOBbXOKOgA
         WlmNrDmxm4EklizB48tMT7klHkSd5WLw2M5iWziF5V7H2gEoHs5AMfsbWg6bXVj2h3Kr
         1Xhw==
X-Forwarded-Encrypted: i=1; AJvYcCXVdMHEHumtTnXsJP55ttsCXKYGL/2rcPxsEtGTRwp8L8sMp5U6c6maPtEjZsST0yfayy+lL1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrSf/YEd1Sjrhi2011Nkx2y/DD2SmqYxcirX4qPmjGcJCbeii
	C3cscQpEIhOemchWylxiRFTF6NXXL/OUZcHsh03o8zGxWM66jE7marcg4KbewSKadJc=
X-Gm-Gg: ASbGncuppkie4mdSdrbtFjCi7lpb1hRMEtlMOr2IVP8AXd/FRMyMugsIXE1ICcuouI9
	jLLEDkJG8DcCCF1BQqrWVxw64Llz9X2aiRIT3fWU6sESge7y50pxDz1EqTf+gWYK+5YUyxUACj/
	GlODbhpXJT2eT7nHxKCDdyTqRuqFpUFV+XmTNfz7YThs5tIzwJ1gMq3tNqnbVAGVM4OqXzV5h+W
	RWj9JZDIsYx4OYU4/miwvJjz27zh9N5Ju1geaaOnqIAtqeh3xDDSJpMuehRKfEw8CgNQqJ9oXhr
	aS8zTFXtngYA+HmhyaYGBR8YNG9cvH+BoSd2uVRBcEjuyNsUI0/om7hMPXjQqFcINWpPhvlm+MQ
	14CgvdEf1Hu1MnYXa49oiyfsZkBk=
X-Google-Smtp-Source: AGHT+IG8kaWPMWFHbVd4viKfQeFJBGjRKwC9gr1w5fiYvRQ3T/k+ZTU4DWIxru8SYExw4YHgKkL4Vg==
X-Received: by 2002:a05:6000:2887:b0:3ec:dbcc:8104 with SMTP id ffacd0b85a97d-3ecdbcc8195mr912496f8f.36.1758030014747;
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f31c51e8dsm41553405e9.1.2025.09.16.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:40:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <aMlouk_55OXZv8w5@stanley.mountain>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
 <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>

Yeah, the:

	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
		return -ENOIOCTLCMD;

test is inverted...  It should be if (!valid) return instead of if (valid)
return;

regards,
dan carpenter


