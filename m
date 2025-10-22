Return-Path: <netdev+bounces-231528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED23BFA0D7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6234DF26
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551B2EA75D;
	Wed, 22 Oct 2025 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9B2gomS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1942E9ECB
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110766; cv=none; b=DH2bxC4euLa6yGBzbc2rN1XEreYFn5tfTmQEw/ZFIukxAgwks4XDhNKpeO7G7SE6KfY6BUQLj2Cg5sb2ez/fz+zUguyWBsd9/6oKK0NIaJhR1cIyLcLjJfl826AJ6xq5KvvsFurrxEO81Szb0dPMUSbDPB/N2qxbJO4oOjuRD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110766; c=relaxed/simple;
	bh=5LyT/ygpo0Y8+c57YACqJVq8xSHL/5CSEdw5mQ9FPeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6z9YsJNrzWMayXDS5DQ5rkaTzAgQ0UmT68hLjWEDe1rmoAcQPDQhQHd9hg8zPd/+kx8S819j1lBNxGPXBbsEKPlou4AAOUGXjbiHEPndcQkcKbd11WjjODeQ2IpiZM2oKvRfHS+vw5ySjM8c+3dLcJ74f3R3F1b1b4o5W1EXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9B2gomS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so35526765e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761110761; x=1761715561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTK9xnrabjHdfOVmac+35vVYjvqf9gcnY89/qorWOFk=;
        b=b9B2gomSHtw47A/Zp21c30PJIcOMUt9SznOdWBRuXmF2WCl3RvfimUPyPey9qwZGD8
         5gUEF7jwiJXeeLKA8XcyzL68o0vZgynqcioiXHrso4R7vC+rAFwkMHD4gdT4zUOGEJVH
         eBslxgOf2SVkGFu0Aa+R1rJxw3DNq7bL6/F0Y52u1c4WG1H2HBxXijXcfY7jbQOpa8fA
         RnkZk08s8KTybfUcHlkF/L4B+Uf8r+q34YPqJ5H8FZNv9QRR1br1SJmmuNXEjp+Inui3
         Q4hOWerQSdt7JQP2NO0iVVzDyJXGdFPqzZuiLcyhrcRtbovZCydULv12hAl7no6bGIPG
         JhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761110761; x=1761715561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTK9xnrabjHdfOVmac+35vVYjvqf9gcnY89/qorWOFk=;
        b=h/2oMT/0BHWBAElobygftAXFClqxNr+Fe/ER1OW8W4ozrbIPpt+zhMEbSkVeubG/7j
         cusu8lozRkDoGlULUK0L3r6XS8a2H6UTouKSROzm6paadW6l+xLgpgsOf6I3mm3ENz8n
         YHPuoMRPE1cor0CfSi6twpRe62QJgiy877336axlFmI0Ym0I2545utQ+TJ0HwexIgjst
         ueuMbbXJx4HhEwzvZ/AMoLPLzIsS9AiBD54YHGq1bjFVAaVrkNBOLOBX2gpjmqf2uzLz
         W3Uy8XxteboGRE/9D3FVclUk12Uzt48sQPiMdktg7l0Bsf5xbFYI/0Muwe4HeKxln7kf
         VxSA==
X-Forwarded-Encrypted: i=1; AJvYcCXUPQkvHmJ87IrB5qP9zJTEfdHuWZvVdCqPGjwaxUUNXG+U6wXt0xopaxSiwS4QiSzB1lurcyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7GXWUe5zDuQFRe6EOLWyiyGOZjGS//gdoGX99EpITX1IrxV+
	zCZCZFSXhWBb1TevfGJLgi0rCb/kzHdxom19QmH1DPZ9JR8hqv7DqwSV
X-Gm-Gg: ASbGncv9XzA0gDTMHhbiCQgoncvbseQ359l+ajXL2U2EIPq5jvDjcujnG8QgNpV+mnq
	v3zrs4rLV6BaRZ0Il1X4eki/v0UtcRVCUWPTKG+FKpznm9cPa2/8m2bzJ1zp3YjKYg+5PXo3brU
	OQlOs+0uEokajz8GV22+Aco+8HKC7Kjzc+lbMGAyE04RfVWpP60kg1gX52/TJi0uoTAQwuFz2cp
	M2otsvnLMndZawXEUbMSJ5SGL43A/4ZIsuFoFAEGxTh4zL6aKvFH7S8qFgOr453V+Xhx2bFoLj7
	VnCqLqsBD1JK9XGDAidyll43/oRjKC8dJRw/ZcSBUzeRGUI6EyOlnaxXQysSB52mH1IMibR393a
	/Zn4FuIF3ZjyGLCSEYc2IF8TTC/ptKcMONO1AM1mmlFUgVhCUesCQhUnFazDo8vLsS1FhpqTycN
	iKQ0LQ85Pb0ZDcdOCzbAAY32dvGsc=
X-Google-Smtp-Source: AGHT+IHr6AAOVc1hGvm6Z9gPnF7KZM4WzTsoKOYTkLOkDaFciIKzqCnei8AODqBvkLwaQ/AOvpj3Tw==
X-Received: by 2002:a05:600c:470d:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-4711786d5a3mr136631615e9.3.1761110760405;
        Tue, 21 Oct 2025 22:26:00 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a7dasm25521821f8f.25.2025.10.21.22.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:26:00 -0700 (PDT)
Message-ID: <5c6c1157-b056-4417-b969-ba501f1baa21@gmail.com>
Date: Wed, 22 Oct 2025 08:25:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] mlx4: convert to ndo_hwtstamp API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Tariq Toukan <tariqt@nvidia.com>,
 Brett Creeley <brett.creeley@amd.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20251021094751.900558-1-vadim.fedorenko@linux.dev>
 <20251021094751.900558-3-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251021094751.900558-3-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/10/2025 12:47, Vadim Fedorenko wrote:
> Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> mlx4_en_ioctl() becomes empty, remove it.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   .../net/ethernet/mellanox/mlx4/en_netdev.c    | 62 ++++++++-----------
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  6 +-
>   2 files changed, 29 insertions(+), 39 deletions(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

