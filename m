Return-Path: <netdev+bounces-232580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E74C06C68
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28093BE108
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442F239E7D;
	Fri, 24 Oct 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilObv4L9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5E238D22
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317329; cv=none; b=gz1zEpnNd3dDxKRB5Ky56OgnVAl15VBHi8rnffylz2/j7PKb43aZ+kI8sZnJYbApQtr2dRFQi5Tn+g9AvZHtnEpU+1MFggtSYossZQ8ZWcYx1+YV1s+ogpyyYimSXuIBZTDlJ1O6gygOiYqfz9LoQryZGSEJ7g0PH0d1HBTLoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317329; c=relaxed/simple;
	bh=uhF5fwIHxFW8yAs72wPqDFCFh7Wmk/B+MbdX+eOAYsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubZeggRkKF62dpyQcTtwMXU40oC8fmbu6euyJ6McpiLhBzES+4H+0z2lbJ2K0CJCm411I5dUshWEUmBs4HBqf57keNUItQxBnAMWuLm2jniZLZdz0AKhs/4V5bKM0j1G/vLyesTBR0QBf4NLr6VkBwBPvTaKTzByOUKEmBI+6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilObv4L9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso16820785e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317326; x=1761922126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMGadhQcL+1aLi8mh0uAQp+IfyQTEprbYOlmMCxs0BI=;
        b=ilObv4L9HDXGuWcnhGVztYtkCdtKDzLr0oRuSCXvJp1ysucHtQkYrh7UvTq1BlQQDF
         oKlmbY5KFXnM8ZREUIJHZiaiMAan0niIR5Wq2hyZV8GAvK1saf0O6Q7k6BXr1XtVk8p7
         iGJ1LGUJjbVW00BQ8RDXoWKy1wY9OoqQ5HEgUaumMCn50jTsZ2QD9vdkDkt/tQCpti9E
         /8kWygtXv9unCfmPcovsreB4c8fCgWP/HyCpFrtl4NBQ4jWItsvhNYLSxm743CL62UhH
         IgLiLrBm+m1g+Pj4RRvgQ468buRZYng/fYN5qjXBpgJYCt7OSztFNJI0TN0Ff3B2R6K/
         4idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317326; x=1761922126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMGadhQcL+1aLi8mh0uAQp+IfyQTEprbYOlmMCxs0BI=;
        b=WCICraAtv0ZCfTZMqddxcvCWpD6CpdHH2EOUdm+Kn3xPNyj800gYsdViJ4jn3lh8v+
         QCVitaK4fp6Ck14DRMXC3mMoNYMey9QD/uADgmu0/fr7vePMb/1YleXHZKf9SftGJbiS
         j9BPKlnfMho3rms7jdiO00L5pqf7DO7aUxpcXAjqvUDfS6nt62b29IksMrNk7ysZsQ8o
         pzPGbNIHV0nJVm0a5p8ht4/aBCO8LBevjZWkoj79KiUWolyLKSB910LkbZlxElBwzGVg
         yKPY829/40X3Be8LLCnLiXyT4p1j4RSp47eiYqFxu23yhy1f0isL4Sxy0k7k2WcEljK7
         tkig==
X-Forwarded-Encrypted: i=1; AJvYcCVgLidwVet2F8scpywkLTMBlWuf1QcX4JMoXF4EowpZ1AMyWa16WdB5e67mRtiVFgaWBwtGMQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkISDSyABwoKnah+GnOvYEWVfldqxluNFYrwjPQrfMcoXUh6rk
	xJvFI+ou7DkpEdeR4o4glPgVPEegnpB7UP0ENWh6lTeN/F2j8voBQqSP
X-Gm-Gg: ASbGncthDQVrdatJ+g/lqhm2a2qFCQh1zK+zrb3MhauSfjQE0s6r0RHvZ/M6jq8sHBM
	PY9I8iX/9lZ1Dqz4p2vT6tPhKKJ/u8aO2yxkbTEdPRoo0KkERCkC6Lyd4Vw+HBZ1rlJ5AYXLDcR
	jxXZpS51729a+GNE9/8yds3yqFBXfigJ2aYm+UgGP8gTwCvuYPHYZR/WVs6gjmodLFQtXfNRvtS
	UoTky3ZEtU6CtZjjr6PimfWv25nURF0ijmSgWnm6pXiNGGTYHk0IoIf/czRkqgtXlHtx+6yKpM0
	ZzrfJE3htKZbN0HfIseJVm5PoH1lYJQNae8BbNnDFYCI+4KJdtdv1fRb8OzJypcNoCE01w+zceA
	qFYaPmGya8AY+GT8Sjxeeh+8bQ7YuFv1e9tEBgqm0PJ5DAxHD+3Vg+GCnXjmm48p03HEVM+M2NV
	cXL6fu5JphH6vE3MJaRpnXnvShMqb7zylBcPB0hHXPTirR4YG78KZbuc4QemC0kGA=
X-Google-Smtp-Source: AGHT+IE/AVTzwrD3CWn4mjR7pxPu/85JnSgPabtjowdHZXXaHv6875lfhiQksEk798Ron6BdKqvkYw==
X-Received: by 2002:a05:600c:528d:b0:46e:1f92:49aa with SMTP id 5b1f17b1804b1-475d2e840ffmr22165245e9.15.1761317325986;
        Fri, 24 Oct 2025 07:48:45 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f142sm97999755e9.15.2025.10.24.07.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:48:45 -0700 (PDT)
Message-ID: <699aa920-ac7a-43ef-8ad5-5157d0018b54@gmail.com>
Date: Fri, 24 Oct 2025 15:48:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Jacob Keller <jacob.e.keller@intel.com>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, habetsm.xilinx@gmail.com,
 alejandro.lucero-palau@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
 <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2025 01:48, Jacob Keller wrote:
> On 10/23/2025 7:18 AM, Abdun Nihaal wrote:
>> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
>> passed as a argument to efx_mae_process_mport(), but when the error path
>> in efx_mae_process_mport() gets executed, the memory allocated for desc
>> gets leaked.
>>
>> Fix that by freeing the memory allocation before returning error.
> 
> Why not make the caller responsible for freeing desc on failure?

Since the callee takes ownership of desc on success (it stashes it in a
 table), arguably it's cleaner to have it do so in all cases; it's an
 aesthetic judgment call but I think I'd rather keep it this way and just
 fix this one failure path than change all the existing failure paths and
 the caller.
Alejandro (original author of this code) might have a different opinion
 in which case I'll defer to him but otherwise I'd say v2 is fine to apply
 as-is.

