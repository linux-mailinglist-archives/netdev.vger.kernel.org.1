Return-Path: <netdev+bounces-224431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CDFB84AA3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7085E4A6B18
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAB93054F2;
	Thu, 18 Sep 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inyJmvkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138A3054D4
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199751; cv=none; b=A0RpgSmWtt/WULuixnTMIqBAi/kT0o0y4kt4cMhyVAU3GPu/+M1vlTTL79iCfprEGebpCXOszQSLfC/ioqZjGgouHbfEGG43MvvgSBtqeXNvmE1tXK3gyJIrHZLcrxqtB/Q+j3iPkjX2g/gWwU83bmQpqDHWJJYYkQ/g9Zp+6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199751; c=relaxed/simple;
	bh=zOb69Nsj9EJmUEeRMZJDUSN/kYHQvnVoYD2cOYE7yww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyf92BPh4dizGqW9OJ1REGmMh6TFI5AF49iXVixuprGJMtjAGhwGgPbcPMkQfljnl5vWfmLsQVClqu3aJCHhRNKp8BtLBVOTkrycdIDQEKWsNzHMA5Gazf0JLtOY/zyPHD2RmEHNbOnTB+O8cl5bWDuMqV+7Zc8uGY9WJ0UeDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inyJmvkw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b7a967a990so10140271cf.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758199749; x=1758804549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOb69Nsj9EJmUEeRMZJDUSN/kYHQvnVoYD2cOYE7yww=;
        b=inyJmvkwjgdyeHSGC7kzLPDF2vXQYXRVuOFzzjx8Z7nNIK2wGXSxikZQYF+NfXY4na
         ++D9FAL1+/851Lj3P6WN42PTvSF8DYKKCD2SE5UgwZMlpY8bUgq4rDzgL8z1SV7MzU3r
         LrA1B5ljASFYIrRjm4XHhDjFJX241roZ2sa23zxbiMUW3JexPDblY5nP8YjmqNrjrTn5
         4+Pl1oSavK8s2snB6hl4T5kdXw/oI1OpdfRB+DSLouU9LSS7Twrf+MhN2/UxF3o3SGev
         xu7lnm9DjknywKkOso5y13qcD2a4j5QqIdOSn1oCSEh4L0Isn/u80VIB2E6uUJ3RiyGl
         FxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199749; x=1758804549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOb69Nsj9EJmUEeRMZJDUSN/kYHQvnVoYD2cOYE7yww=;
        b=U551tQXXIT0tIjmM+YgGbYE8yXbeD+eOt/k3woqn/TwKObG3sD9M1BxoD6BL3aFO5L
         Ke9NKvmWsOzwIIRw2bjHHH26AkyOt5svRaKPzgKVh+8IdTByoLM+K2PcoMzCNqThegcb
         fZIzwobgCRc1Y6W85xV4UpFtup1J7z6XtoLhH3SmrMGSpCDwOVmB2OGbf6sacaJtzyKM
         55JkPvPMtsVcJgfgWdM0OHC0nvDu/kupykU+t1+AFWaiaDBRUOd1jndC1MGEzD4ktqEO
         ax2XLVfdl2rlKsCBOwYy9no6YjXVqK8JifXIYIDic7wvYBbGdrDFbP56v8N05zjnAKN8
         nKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMG7Gb2HVwbLKV+ghhk6wXOgqL+dX13T3VJrxhfkXBHX18z8V0wuJhDGRE0auPh/H2OoswSpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3XaGkNy3NpdV9jeS/l/7k9H4zpF/CBe33Us+h3C+Bl/hpwTU
	C5SoCjatmPmnfFRgX397YZsVUnoYJexbF2VzOIn3FDY9j6zs0jqgt2vVa1ruhQ==
X-Gm-Gg: ASbGncuVe+WZCCTu+s8Rm0ZLk6ddBDQtJl3hLrDV0cbQpEyRWm/jHe77kbNEM5HGr8v
	oekAOGnXMF7EmUwhANXBdpA4YDj3ntI03GxiwwAD+Th1KhMeTVJ2rglR9uOx4njloe/ck8OFElC
	seTgidI/tK0EXkXtDbGgTLhFtnDgJ7xQoaLtXyWeDuiqjKW2vfUfP0IATJQA2OTEYUbZOL0fYU6
	/3K9WRFyju2J+SLG6/90sxYKUSx1/xuIM8xzsFMr90qNjPX3j5NDOExmx+gEW8sh3idEUWUfq8w
	8SQLFRkbLG/2mubyBFD4G51CjryShm/8QbvJBuMVUZV8srt/aYnu68CjXIYFFqkidnlPm7t+4FA
	dsoTlD0cYkYSDdKB6oXtEdZlru1w3WxrtOeJRjapiBp6aYpcQZBLiSjlfq+pixsqCY1q+rT2jdd
	5V0E+9H6FGD1xrJsLPKT82Ig==
X-Google-Smtp-Source: AGHT+IEEjzVwTFmuyx0XvsOKBlO8NkKM2PuczAH7/B0foSuy4CyShff2ZTBjLhP80me7H+alF2NDfA==
X-Received: by 2002:a05:622a:410a:b0:4b5:1bee:f550 with SMTP id d75a77b69052e-4ba6d90ecccmr57214361cf.59.1758199749086;
        Thu, 18 Sep 2025 05:49:09 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b8:5f00:52dd:c164:4581:b7eb? ([2600:4040:93b8:5f00:52dd:c164:4581:b7eb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630481f38sm152494285a.39.2025.09.18.05.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:49:08 -0700 (PDT)
Message-ID: <25bac004-1f42-4a0f-a2a1-b27b7afb9bd3@gmail.com>
Date: Thu, 18 Sep 2025 08:49:07 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] psp: rename our psp_dev_destroy()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
References: <20250918113546.177946-1-edumazet@google.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20250918113546.177946-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/25 7:35 AM, Eric Dumazet wrote:
> psp_dev_destroy() was already used in drivers/crypto/ccp/psp-dev.c
>
> Use psp_dev_free() instead, to avoid a link error when
> CRYPTO_DEV_SP_CCP=y
>
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Closes: https://lore.kernel.org/netdev/CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
>

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

