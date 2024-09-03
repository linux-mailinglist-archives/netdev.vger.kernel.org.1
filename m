Return-Path: <netdev+bounces-124589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DE96A155
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F727B22A5D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DA1714D0;
	Tue,  3 Sep 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NiU09j9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A7156F5D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375315; cv=none; b=KXKoIy5Iq5G2/qO4i41sfYVKxS3gUaeN2kBzx6ciF8UnZ+Np05/fx2GUtSakmYzwi3AbHEfI+AQcvnmoiYdoed0voN6QnnXW2sYFS4QwIysnXiRifz7BVYwqSMwQZaDhb6G2dt/QOCftKcly9yQquYcSj5c6N+mo9N19w20B8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375315; c=relaxed/simple;
	bh=/S0el8odGf3dWTBUBsazXa+FnmV+VPcwZpwe+4m0TuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuqDxX4RdeDVlkTr940iTrEO+h9M1biUjdcJdIQPolesh9Rqb0ER6eJYcyXszbgsz4VYTOIhpo8GjzfiKZBotEjBxxVcItr7zGWv2KhAQISWKiwV21fv3jt9odpZs09NjHU0FkJBaVBWz3t/qK4d0VbT8XayQG0EAFWjnVbX8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NiU09j9+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1784088a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1725375310; x=1725980110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/S0el8odGf3dWTBUBsazXa+FnmV+VPcwZpwe+4m0TuU=;
        b=NiU09j9+MCO1bekKwtwcHfUIgFVjKswR841QjCfqLQq6UlNxbnN2DK/vY3tWjykh1o
         aje7lAZZwmR+81vTIH9pHuGgbTn0PkscKray51oysyeGJd4jblEI3QXbb6Pw/O9JX/aw
         cY9JDZF1iBhWBAXyQb2cKnYx7BjBeuRagnMb6S396nIaTozMa9iDtr88iNm8wRFFJMP6
         1BOVXWtJxiJJH2wYLWsGKU1dmAgULLiZHg9Xk0F4Zi530+vwD+EXCqDOzWTJExLSl/Gb
         qKOREI4AKQEsAN+n90SVFad0JjCPJuMucqV14DERNZ/y39A/PsgPUF2toEBMJBDfi5kx
         nasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375310; x=1725980110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S0el8odGf3dWTBUBsazXa+FnmV+VPcwZpwe+4m0TuU=;
        b=Cj/6wX0LB5hsymRHOHd4vRdstu0rKchUUUlbiYPwWfOsFYLnfxZJtc7plTl611Fic/
         AVPBmELzeifMSgZrGFyAtsTUMvMtMpJYJxKg58ZFhj2oSytwPShSI2zXfLMbBogdb7Yl
         jQXttsDBo0xduSGPbiW/qouMOY6CntJQ9LNcQZnghe2N6UbqJ5E4pZoKBshNqqlLzUzx
         1GTte9gS7txns1bt4t3qb8XAqod7J8v2qC0A8Ww0F8bM4xstXz9sAj0g9pOFT35P/RQ1
         8qEvZA4VbfgfEXYt0ZnTXCjYC7exrswgvLggdLOVujANq3eWYUaPvwXodC5mxq77eqlf
         qzUQ==
X-Gm-Message-State: AOJu0YxEAPLsArgNNF2WFslTL1W0AA1lE88avLoEb+aB7TaovQAHRGvZ
	1bs9CK/4Ve29lRzL7x7r0+U9i/6Oju7ywGDoTnmUxG3X0z5dpsR4AfA7VsTxpOs=
X-Google-Smtp-Source: AGHT+IFNO2CexpzrY5N/V8RZAmfAMPJk2LFTKLsVObG8b67keQA7Tlhjb8AXpYmyaZYUO3laOiEt8Q==
X-Received: by 2002:a17:906:da86:b0:a86:722c:1460 with SMTP id a640c23a62f3a-a89d8782136mr778706166b.18.1725375309425;
        Tue, 03 Sep 2024 07:55:09 -0700 (PDT)
Received: from localhost (78-80-104-44.customers.tmcz.cz. [78.80.104.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196c88sm690447766b.102.2024.09.03.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:55:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:55:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 1/4] octeontx2-pf: Defines common API for HW
 resources configuration
Message-ID: <ZtcjS5_acSWt5YGg@nanopsycho.orion>
References: <20240903124048.14235-1-gakula@marvell.com>
 <20240903124048.14235-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903124048.14235-2-gakula@marvell.com>

Tue, Sep 03, 2024 at 02:40:45PM CEST, gakula@marvell.com wrote:
>Defines new API "otx2_init_rsrc" and moves the HW blocks

s/Defines/Define/ (in subject of the patch as well)
s/moves/move/

Otherwise that patch looks ok.


>NIX/NPA resources configuration code under this API. So, that
>it can be used by the RVU representor driver that has similar
>resources of RVU NIC.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>

