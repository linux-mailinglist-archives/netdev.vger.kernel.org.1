Return-Path: <netdev+bounces-101308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD598FE1A8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF051C23709
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44714A08E;
	Thu,  6 Jun 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Q5HuguNM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047B149C55
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663908; cv=none; b=EUo/SBAJNqfC+S7NAve+gAhLtM/wJ7Y3FRfDNVVAusQk1GaFnmEFyIsW5zYkGqifocDDPvoVYSs4onxIjwUchuDCOjJVuF2+F53BdrkKcD4XfEMucl7sYE3SAwWOfZZPE7vTx6HU8DGGDj7DfWH1d9bcvO1u/WejyELeMQDniGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663908; c=relaxed/simple;
	bh=le7JdznuMOuARqZa3HuZAgC1yf88gjF/Sz2dZLZkOr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN8612wkzirq+ZjARVCnJ7/lX2OGK7g9wEdlJEpx6b/TldJFaBsc3kPObZdDPfTlKx0ssS7XHQnZhamg90M9ZBhUhiWxocjU230Ir6J/qxuQgc12GBF6gj9WBNG+NVmP/s2r+5HTe9kmmpoCNv7m6S7HpUxhuFVBWhddHy9Wnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Q5HuguNM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35e0eb3efd0so686940f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1717663905; x=1718268705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EvWLcMlK+k4SkVnn/7IF6otDALsrx+Oi7Doge7yez4k=;
        b=Q5HuguNMD//dqbu+n+e50EPrC1dJ29NPev5jM4byEYYdUdjJ3UKMSmMZMUg0yl2rQr
         I9O18VF9Q9NFfwBcmQ0GNVJHyDUdfV4pqrysaAYIN1sQY8+0mfa936b2UtC3VcXNsMLe
         D+hIm0WoUC2800PIoG2BhtoX6eNe8vjVTJvRJhmboEwzZPD+V9HH+zZ46FqBcn80y7oM
         rr+LoeuNDEag0//XtlYjbmMPlEEerDpny0HuZyYkp2X0GbjLOgkKl7t3y9HeQIYObUME
         0+9WJveJ7M/MWaqbaOu8jeCBL4XzwYQipJCIQyBRo40ke502FZQ9raAr65su41C/hIo1
         n0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663905; x=1718268705;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvWLcMlK+k4SkVnn/7IF6otDALsrx+Oi7Doge7yez4k=;
        b=lUG3y4ffAqVer93hAncayh77JM0pc8JrTtZoBv3uCmn/xeZX9zxbaDey0GFB4QKSOO
         zuz3cn1G3MRu+NRBTHddJ33hi18NxanKtZ33jyQ0fiEQdmT91f+RNxLem41yym+TeZhv
         RE89h++JlOIVg767Syk/K+ga3zOU7v0MvThr5aQLSqGBZVZjmzNqvM8NblNwgAYWorcA
         pl4DJbHlsO7whMcTDhhFGVu3K5pzqZkdPJQCoTAcvGa+6tKgk8yZve5V0yQfGrEnpEh5
         qAjDR5O3yyg3S4vFdSJ/yv5Sqxweib9lje1PjZyucsBO3L0udZblnjE5C1VxsYwFCN7x
         hVEQ==
X-Gm-Message-State: AOJu0Yx/Yzs0ToqMSxBi3DRzy1+bY+U3cOLAHubxSBvSuPXoUwWVB/nP
	QXdmQHunp/WQzfMWTei5ONuOLIHkvK8/j1M4PAB0YAvsuvAgXWZfU3gVitYkEmk=
X-Google-Smtp-Source: AGHT+IGdgcED6Z8uNyuz6jvmndMfYIk+kn7m/2qb0QM0E5FlnQCArcfVVH4u7Y8UZ4OsrATHJ2SDpQ==
X-Received: by 2002:a5d:6ad1:0:b0:358:a66:160 with SMTP id ffacd0b85a97d-35e8ef0ab3fmr3782702f8f.38.1717663904997;
        Thu, 06 Jun 2024 01:51:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ff33:6de4:d126:4280? ([2a01:e0a:b41:c160:ff33:6de4:d126:4280])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d295e3sm982611f8f.18.2024.06.06.01.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:51:44 -0700 (PDT)
Message-ID: <9f78b18a-a2af-4bca-b5e5-c2566175bd21@6wind.com>
Date: Thu, 6 Jun 2024 10:51:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: make user space policies const
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Dan Melnic <dmm@meta.com>, donald.hunter@gmail.com
References: <20240605171644.1638533-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240605171644.1638533-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/06/2024 à 19:16, Jakub Kicinski a écrit :
> Dan, who's working on C++ YNL, pointed out that the C code
> does not make policies const. Sprinkle some 'const's around.
> 
> Reported-by: Dan Melnic <dmm@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

