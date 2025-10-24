Return-Path: <netdev+bounces-232653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D61C07BAB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64553AD668
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF443491E7;
	Fri, 24 Oct 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RanOtGos"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB4346A13
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329880; cv=none; b=bNURRQl+LLmx6N0ZvB1UdG9sVWgzXaTS5occ6NIqpcDQHzAem7+xtUSaQsZ/CEI4wgxOoNX1mvrWj3+ImCpDiucJYewzkUxb2KeM3qEGk4TuILSHLbTmNiA6iRwg37OBsQzRrRsPCrFczAJKRyRhtUghfiSr6c4ovCadbo3xiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329880; c=relaxed/simple;
	bh=f9EWuUddQuX6YNL9LEZegSrVPjIgkYAeTAs+Ik6L294=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um7qXbcYd1G6faZBZR7hmIcjO1t4Kiy/Rn4Y+w2roTg68MMxMWuKhHwY476n2Q9GDW03xzT7dQIuL2sZHZ2qrXn8kc6MqM1dLXehHLguCn+CnqdZGjqo5eupcvB97JnfDbKDp6ZBdwMs6nL9+efjCVYvpVoaIT9+P82eDmjnfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RanOtGos; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7930132f59aso3116844b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329878; x=1761934678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f9EWuUddQuX6YNL9LEZegSrVPjIgkYAeTAs+Ik6L294=;
        b=RanOtGosw9YedowY2h1khk7BmndTmXX44CLpZ3QtKrQzWo9NfVj59Pn9lOOtkDSJHb
         DXML0NEX/QRF7Hsapad6xzTkpSN+EgM+92sfL0Kupu6D18qfcrQTnOQBlzQZTEdN+qrQ
         N0Z5QAeTRmAppNeC7FZYNs/2zNxGsySFJIQ0AVKxRpBlB9whN3LFa7NNNJcnxD1Cjv1P
         Eq7K1KCubw2c87EPvsrVDak+mlaZs7iPQB1mvEOpOqr72Y1kR1x4F59oi+GFIX4p6twX
         0woyd5Xv0i9nzqL0TesXazjNhGr3zcQkdQbHgeHIfLvA5y3h2Nn68YqF+K3OsDSdQ66B
         FUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329878; x=1761934678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9EWuUddQuX6YNL9LEZegSrVPjIgkYAeTAs+Ik6L294=;
        b=d7mqw+TZeZOzDjzWID1eTVRP9+iRKyyIKSX5QO233+duolZPYBSp8tX8Y4CoVU2giQ
         ec7+gyBt+lycPS4a5H6HZ7l5hh8q0i1Drn1/NvDOvbKY9Jf3ED7Kz1//Guj5m6jrubb2
         WmAk2S56N7Ee2zUIN5XZ6b0Qb2VMvH8KDGC8CxxYPNipG4WA7+ONOrNmS4b1hjSVM358
         GxEIz2HLM2zeNRxR9arTFBwstRAudx8zqwuZihWi2RnM4FMvCTvPHV7kP2EKKeD+fCl+
         8wjfDrgGHYs7JKau3sdFDVun45dVeXcLVvhvPwAjaSWiGcL25bxLRRopow6PPkki5iiV
         hCDA==
X-Gm-Message-State: AOJu0YySlBcMWCGOpNa1Ofiw3GDzF34OAqBbx7ghvzYtBG/tf++ECVmy
	WKc3lMYDYu9oHDcmEW/3BOPZSH0RADD1L/xBwZkM2m10Lu/PNrv5K8ul
X-Gm-Gg: ASbGncsZiCHxZ54Nsay7zbkFDqo5k6LhJ+Iu9D4gM4ephi7PacF3p3XVEkW7HKyIyQO
	NPOSNwV41dnglF5ZqpDNQCfXVlxnXqVmY2s5rIUu+GwRT6hlBFE2PK5L8MsqIbmYAMck5Wa6MCA
	6fuoHfUWJs4CDoThSon12ZjkA2qjINVHWvbbC3Dv7MQ7fsfQm9PSLD104KDQp8v72e99zHBR/5H
	Dorum7Gx6mLpBxh+bf/ht+ICSvGXod+z+PNhaNurWt+1tD5Wktvo4uqxmJ5FcNlgJdJa22rw2zn
	33m8kvvK9zs0xB0Fy4+6rAKy/hPuijn9H9Az47fF3nAhorS2DpkK8MlbU+YjKt3nLZl5ZcuFNx2
	ZuFqD/zWjMUoVCwcrhZuh6eVg19EfRY9WCPfe01P6beJyOjW0m5+dwRUseGWGfR9yDcFsiUw2GJ
	2x2qBbvOtzKY8l92gu0WV8sOs2EEg6lV6nWQfYoB3zI8y3OKbf/pzd6C/loNeM8fEwFKB+KX3o
X-Google-Smtp-Source: AGHT+IHeiJK3KGe+VnGjHXLRnMJUwHVfOIfp/7GkKJJk9bi79iBVomfSlmVEYSTiEzsfJqqDkJvbHQ==
X-Received: by 2002:a05:6a20:4311:b0:334:8002:740f with SMTP id adf61e73a8af0-33dec72d38cmr3947493637.41.1761329878500;
        Fri, 24 Oct 2025 11:17:58 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8adc8sm6527877b3a.39.2025.10.24.11.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 11:17:58 -0700 (PDT)
Message-ID: <b262deee-de5e-48ba-9c16-88238fac37fb@gmail.com>
Date: Fri, 24 Oct 2025 23:47:52 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: emulex: benet: fix adapter->fw_on_flash
 truncation warning
To: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, khalid@kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linux.dev
References: <20251024180342.1908-1-spyjetfayed@gmail.com>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <20251024180342.1908-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Please ignore [PATCH] and [PATCH v2].

I have send [PATCH v3].

Best Regards,
Ankan Biswas

