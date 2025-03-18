Return-Path: <netdev+bounces-175759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8CA67676
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF041883B8F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412620CCFB;
	Tue, 18 Mar 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxxCVqXr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1146426
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308107; cv=none; b=GuNmJtaf6mbKEhpXCTZvYZysjr/l15oNbDfBeE25rmtowh8tYnoaGa1c3h7TGPl/MhD1yEW8Ga5KbjETAZfjuU9hgGjG6Lum/AwTHRwdAKljDOr5vbIOTXoC5SU9WDn81dPXJILigWtPkwR04Po5u+hSnIJE/U9k4kRclks8QeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308107; c=relaxed/simple;
	bh=k8LbUM9Q381sK+MU3lANqw0BA5/KQAe9oguVZVLwRg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwqp1DVY8pcfHcphpk/OOsnw7Ha/k662N0qgCJDbJmLKcdrP6tvQ3pKBLjM/1TcAF/NaFuUQvnS2ndTepdJpA7Fwizy4Ss8IEeFKRhS2aPiMLPCmvSU27x6wW16lTgsw+/S4CQvvmmh8Spt+XPL06RHVeNzXZCjMCcdHJTssZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxxCVqXr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742308104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6I0wp0IP8KvSrZEWIv66ZUu7eiP77ScDqheeMoFIYc=;
	b=fxxCVqXrIgNLJgTp1k6JCKPBcApMzYIFic7VBp9TFvlZ8d6VMLAGU/qa0sSVq9RolO7D3e
	SSQ1jxfbIXoBmz5oxQMdieZrjuxGSkpno16ia8FR5R/CL6rv8frHp5uG1gZCxBC2zldxNK
	CQbVtj5qPTwKZEeCcZzH6GzW4ZQCtak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-RkMeeseHP0-3wCc802lgVg-1; Tue, 18 Mar 2025 10:28:23 -0400
X-MC-Unique: RkMeeseHP0-3wCc802lgVg-1
X-Mimecast-MFC-AGG-ID: RkMeeseHP0-3wCc802lgVg_1742308102
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so29457565e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308102; x=1742912902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6I0wp0IP8KvSrZEWIv66ZUu7eiP77ScDqheeMoFIYc=;
        b=rU6K0S3TXS8pL+uKwHIZ6SBXCp0txXRzouoV5osXmivQz53apWz8kYB/6MjNBIdCSD
         U1AZXP3tbamKBN8HgJCPrE1LOJoLx9tQ3//hbZA6TfsPWXI6LDQKioeRSV1fmgNZcQo9
         IuFhlC6LKgqdptk6URgPlkW1n6hp8rNQrfZ6r3q3ZAE6BeMa5Nhjn8IxDowqyF8CpANJ
         2H3Ofnp0TVV5gf2CfXLzilLYajWc5KthliNNaOQlOnHgKJDNcU1TlJ4VPny/UNml72cE
         FD5djRJkE0P5IazWeLEwmHEbMli7nce1jU2Q7D/gwFSmKPwAMP+sPhxiU2PJEmi+7Fft
         zvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6kHs3KBTQb3+UEumSBfcpUvAxu/XM60PY4B/+pkjBcxfwEFPZuXzlqgK1YjkvRBnf1wnNshA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4iDpYRyDxikziRueBVNLsCcqWy5OorS5QEbXjINRyUyjj+3i
	sNtRzRIPRM038voGofP5Wvc23X4hAxKe6QFEvKW5p3pNZ1HPqfkNtXozLP9HzNr7H/MmQz6YRWN
	KdjbLf3IjJAGQb2E/Po+9UFkvCWzZCq7UiCjOsDEiuAB63qC9rD92wg==
X-Gm-Gg: ASbGncupSDvXQkCDfw8Eamf7eNonMVZUnKJs/2hCfNDP7pXpn2ID+iYv1QCR9n1lnY0
	ko6K4aV/1v4ydSlnjTuK7YMIVH/Q8xn0BU9M0LVYG77chiV3jy9EMpULPimeKXtku+xb03T3ock
	CdzgbBbgPPyQKvGyUsMcFYEMRmsvxooCfY2Jdrm3Ew3JvwmGkyfKVSsg93JL3yxV6vFWQmIFCsP
	Ll9vaAx9z92OoIj0n1v3xLWNeooPalz+42N4UbEd2zZN9gAKVWNqfpfjIcP4dbO4CjTzZMSE5su
	Zooo7V8QytcWMfNqpOCnSbIErTjq/MGK+WLlYKhmWCdMYA==
X-Received: by 2002:adf:a189:0:b0:391:2a9a:4796 with SMTP id ffacd0b85a97d-3971e2ae2fdmr12130486f8f.18.1742308102155;
        Tue, 18 Mar 2025 07:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFpdrxO3uzvqIUBt8wFXOqIzhdYYo91c5J/KZiOeZADCODR2y/7+pIUFwkH9X3kzq3KrWZMg==
X-Received: by 2002:adf:a189:0:b0:391:2a9a:4796 with SMTP id ffacd0b85a97d-3971e2ae2fdmr12129409f8f.18.1742308071807;
        Tue, 18 Mar 2025 07:27:51 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm18644606f8f.53.2025.03.18.07.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:27:51 -0700 (PDT)
Message-ID: <87c90ae7-2945-4428-b8ac-576082373661@redhat.com>
Date: Tue, 18 Mar 2025 15:27:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
To: Sven Eckelmann <sven@narfation.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net
Cc: kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
References: <20250313161738.71299-1-sw@simonwunderlich.de>
 <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com> <3809149.MHq7AAxBmi@ripper>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3809149.MHq7AAxBmi@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 2:56 PM, Sven Eckelmann wrote:
> On Tuesday, 18 March 2025 12:05:52 CET Paolo Abeni wrote:
>> The series does not apply cleanly to the net tree, could you please
>> rebase it?
> 
> $ git log -1 --oneline
> 9a81fc3480bf (HEAD, net/main) ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().
> 
> $ git pull --no-ff git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250313
> From git://git.open-mesh.org/linux-merge
>  * tag                         batadv-net-pullrequest-20250313 -> FETCH_HEAD
> Merge made by the 'ort' strategy.
>  net/batman-adv/bat_iv_ogm.c | 3 +--
>  net/batman-adv/bat_v_ogm.c  | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> So, it works perfectly fine for me .
> 
> I understand that it is confusing that that Simon send a PR with 5 patches 
> mentioned. It is actually only 1 patch - 4 were already submitted in the last 
> PR. But still, the PR seems to apply cleanly for me.
> 
> Any hints how to reproduce your problem?

My scripts fail to apply the posted patches (when the patches are posted
on the ML, the script try to apply them and compare to the PR tag).

Direct pulling the tag is successful, but I find a single patch there:

548b0c5de761 ("batman-adv: Ignore own maximum aggregation size during R")

instead of the mentioned 5.


>> While at it, could you please include the target tree in the subj prefix?
> 
> It currently mentions net in the subject. But I think you mean to change it 
> from "[PATCH 0/5] pull request for net: batman-adv 2025-03-13" to 
> "[PATCH net 0/5] pull request: batman-adv 2025-03-13". Or which exact format 
> do you prefer?

The preferred format is the latter: "[PATCH net ...]". That additionally
helps the CI to do the right things.

Thanks,

Paolo


