Return-Path: <netdev+bounces-241023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A07C7DAB3
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 03:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36DE3AAF89
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330121EEA49;
	Sun, 23 Nov 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="22Al1hVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07281A0728
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763863670; cv=none; b=GUH2QCWcwI8nT3E2qbdRrmsCTRBsjNFz9QCbSnKdzriWEpRbqHAUDkV5fJgKxXyWr/y3nQkNyY1zRmgWl3rAVRa2w8A8BR2ZWTmjOb+ty3JOhkr7DA1TXvi8Nx6xEHopp5wfVDvz20kqRpdx3eaN+226csdIlUThZC8rOKHrhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763863670; c=relaxed/simple;
	bh=4c0Sw81Ia9ndAt5YEnRgp/kupoHNBrXg5JI+nAP7urU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAZOtkl4SpCix+WJmCXPuylbLdFcJWSqMNAcRwe7gdNw7VYR1kQXhjgRy4uE6Z6IPBZqFXPC+NvMUSU0rRUNexLylipsyPNR8VL4I4TglQUmtgf9iLdr8JTQOxHN+N9QDI45gvAO/izWSX2PcC7U0Y8JoCp3rD0f6f2SPeNCxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=22Al1hVI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so3913719a91.3
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 18:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763863668; x=1764468468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZIoteEzegCW+0JXd1Jo93XG2PVvQC5dBeKHebsF4jQ=;
        b=22Al1hVICZ9Lk4qgGK4Bwoe5yKilKbBnrW3eSh82Bfz9WdYFvY+HNBOmxk/4xzDxZB
         Ti0RrTlJOI8cSuudBP8DtjLgbHBbbpNWxH9JkvGdzoUR3ATUAo+2VuToqdAwtkHQsYUw
         P1ZolZVQiNae9J3vfROyJSeYdON2zLkcb893tKxww6j1ziTEhhn3LlM+NYjvqwzwf5Ov
         mIu6WPEuyVq8DW/3a4p76EJ5+/8C+6ojd/XpgW6g/kWTOnIKAKlag9/ZHil4Df6EjlxR
         FsamhiKTvfvBmOyIcohr7cF//9/dVQ7rM8lutGhJtnRV9gFHid61ZE7AuwqCa+6SOPRC
         UGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763863668; x=1764468468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZIoteEzegCW+0JXd1Jo93XG2PVvQC5dBeKHebsF4jQ=;
        b=BXedTT4H7cNxdb5M0/zt9c4PDxebMU6TS97agigKzpXS+gdVhIumsL0ubYMR8k2PZs
         vI7H1sJDX2S2ISOQbtRk70pot6E5iHCLDMJx5LNvI+Th3wgtmd2w3/jy25s+nEwt+6w0
         vnDQa7sJsrh2bRrFKlhbl0tVO50evgYnghHuJgIULiUqqTsABfAk3tmln5/ENnsJ4O+U
         UjLazN/z0h/1gOJgYWKv2oD6vPbgDK/yOLM7bvueetJ43/JzDy2Lf1LAsppt1UAWcgg1
         t9ZvCTxC1Jg0RuzS/ac9FXlvojnzSeOtHaFE3OJPLi7jhSInqUhWNTKFBqKyjBJjR1TK
         ek3g==
X-Gm-Message-State: AOJu0YzTd2zyGT3tTDMbEsoOXDp0dif05x9tFYDIhwqsq24ZDR9doDm4
	Natx33hSWk7tgKh34HY8Kv1vnIHcMyZvV4/Ev+2Ib+vPBCOV8GUE3zhZgaYWaanEYLY=
X-Gm-Gg: ASbGncvcjDEvGAlt5IWffpeWv6ADLuUlTfa3lz/KQzpwTG5bajc9E7VyUPc6bCN8XJD
	TjhGNbIFqID7cEl31rfILArxYJXgIExOAySp8m13DlHTtzrwTYKu7Y3zR44R16/r+SG/aTTz17t
	RQcaeA/QPju5swduANfj52S2wexg6RiCLI2dhi4aml/pQPIqFtHK1zp7NLkj6Vx+UFM2SyHvb49
	ieYxSUEhrJ/hOY1aiHRjrmFS0VoktEu9dTu2raOI8E8/PVrWX19jIvQiNLXl6zfZIsCeoVEhLt3
	5qwhidZCRLzEySvLgB/Xl9f39J5tQVNjZBoKA8djlm+cEodj5ueQarem1tasa7R7BLbSIygiGxK
	1gO6p2Ii96vYL3GeC3siCg9JL+r1TMsXwuS4Eya6wKtV4M3fj868qaPdAgTpVBj52qPdmFBnyrl
	+QvtayKMQ0dErnGc85k+Q1rcIixvusEncrfWYLSFrpx3sJKZtJFQ==
X-Google-Smtp-Source: AGHT+IHRMXTXKXjEyorE/OR+JgIhlUmGW/33HECEKNiQG1+7IFPbdCPZ/lFmn8eUQeIV+QYEJHx+xg==
X-Received: by 2002:a17:90b:582e:b0:343:a631:28b1 with SMTP id 98e67ed59e1d1-34733e94c4bmr7781670a91.16.1763863668056;
        Sat, 22 Nov 2025 18:07:48 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed379558sm10098989b3a.25.2025.11.22.18.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 18:07:47 -0800 (PST)
Message-ID: <ceb11201-0520-407b-b5ca-f32d1e3bfdee@davidwei.uk>
Date: Sat, 22 Nov 2025 18:07:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] selftests: hw-net: toeplitz: read the RSS
 key directly from C
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 petrm@nvidia.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20251121040259.3647749-1-kuba@kernel.org>
 <20251121040259.3647749-4-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251121040259.3647749-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 20:02, Jakub Kicinski wrote:
> Now that we have YNL support for RSS accessing the RSS info from
> C is very easy. Instead of passing the RSS key from Python do it
> directly in the C code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   .../testing/selftests/drivers/net/hw/Makefile |  6 ++-
>   .../selftests/drivers/net/hw/toeplitz.c       | 41 ++++++++++++++++++-
>   .../selftests/drivers/net/hw/toeplitz.py      |  5 ---
>   3 files changed, 44 insertions(+), 8 deletions(-)
> 
[...]
> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
> index afc5f910b006..7420a4e201cc 100644
> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
[...]
> @@ -551,7 +590,7 @@ static void parse_opts(int argc, char **argv)
>   	}
>   
>   	if (!have_toeplitz)
> -		error(1, 0, "Must supply rss key ('-k')");
> +		read_rss_dev_info_ynl();

Do you also want to remove the case 'k' and other no longer used code,
or is there still a valid use for them e.g. someone calling `toeplitz`
manually?

