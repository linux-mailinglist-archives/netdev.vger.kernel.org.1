Return-Path: <netdev+bounces-99407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1A8D4C80
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD5C2841F6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5321822C9;
	Thu, 30 May 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NnG4Y1MF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458FA17E455
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075325; cv=none; b=BBTl7NA4NaRPGZ25PpVaAAwkqAhJCdVQtoMz4sZN3mvZOFE3jBBOBVJwAu5IcIyJK6zK93YUdmkOfadFOIDJvMEQh8cCJg8NMNykkCWQWlnzo1CJlSPMjwmVDG78hw6pamw2vqpOLr2C2TqZyJYg0zjoT3iU8o68lp4j/Soifqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075325; c=relaxed/simple;
	bh=k5ZrXdGIaogQHPPhCMUP2jNspqkczrIsO4+znhoujAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osrUPTp8krkz2pfm5xK4drsN6dX8gQ6kJXUwrFwqT2zXdyClwceH5+gz/4Qnn44Ds2ns4SiWO8I2vzDubFOwXpWUycFYGWy2oE1mGxXeFvQnwL1CJivBMZiWjjdOjK3w5lcD/UP74UH2LtSb7u3rlIkpNovvhc+g1HO3I++sLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NnG4Y1MF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-421124a0b37so5445325e9.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1717075321; x=1717680121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QR5AAbAM/8EJY6QaLCoUAYIxXm50GVjZ+QgDb3ypvI4=;
        b=NnG4Y1MFEj0jaxqapqxIUGZtn0jDJrqWss5epyWNUVjkCu6g1h0v89UFT2vDRXwKAI
         YRzmv0/YZre86UTlGLeLd2iUF7oH+m0/Zt2CA3Ru3QOMPOGfq3z0CV2HPqx/3QUU3sc9
         E8AAiOie3ZWy++I2UDg7BRB4RM84o6TWXvykDE5unANx0JxQ9JthRSoi5KBynRZd9MVK
         SZPqfiymRbru83a4qCHVQNXILiOcwqeU6JK0BoHaWQ7FvSveAbFlmzPorErdmpFpbPnm
         NkGpEC+VtdqphvfTqI8jozk7cvPf8l0ZPLJq8pB16Vo8qZC8qHoWKaUt0+bxcJIDzOqz
         EWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075321; x=1717680121;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR5AAbAM/8EJY6QaLCoUAYIxXm50GVjZ+QgDb3ypvI4=;
        b=gnHtNpBMS20GZhQIUcnrEyLPzsVOzzXipsqNbobsBNiiLrLnoGLSIvZwpvrJ0wasvj
         P6rHnngd4gs4Nr6QizboyaqjAyhGdAXGxjbsCIeTfU7RR9sDOJC6QcP3BHOxRj/RjZUr
         UYmiJWS+EM4KZ63Hxbo8iUYeyAaHvGuDgQXatFg29eKuUCy0cY5vujOPzAR4LazlhUNT
         Duf/qI6ARqHxvCjP6uLzHD7hFfP+9GGkLi6HXuhERP4DYcTgEOMuT9VHWmv0wYkuRkYL
         UxsPPpleDq3WW9bCDJLLQqLgV9WQkB5U0VRLANqnqh9Fo1HhQIxIe5pCrf15wGcw813j
         FGaw==
X-Gm-Message-State: AOJu0YzUvd83hntsKqEEkwlABE+1UKj1S8JCkHfGwG5Gho9DpvZYPlMa
	0YCn62AcGKx3StJpD9hsvip5hn1mkyZUed2WqNhCBvqFsM6St8jJx8aUe+j4RsM=
X-Google-Smtp-Source: AGHT+IECcMqD0JpfF/JdB+kof9XgG0D0RK+QAS0oYrv8DQldNWTJPlL4DZFlvYYjJzvpT1FITLTlyA==
X-Received: by 2002:a05:600c:1396:b0:421:2a0c:b5ad with SMTP id 5b1f17b1804b1-4212a0cbb2dmr5896585e9.10.1717075321552;
        Thu, 30 May 2024 06:22:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:9ac1:233e:e430:a80f? ([2a01:e0a:b41:c160:9ac1:233e:e430:a80f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-356c8daef27sm15395040f8f.115.2024.05.30.06.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:22:00 -0700 (PDT)
Message-ID: <0fb2bf6c-1ed4-41f4-b239-c867d99471d1@6wind.com>
Date: Thu, 30 May 2024 15:21:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: make the attr and msg helpers more
 C++ friendly
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com
References: <20240529192031.3785761-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240529192031.3785761-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 29/05/2024 à 21:20, Jakub Kicinski a écrit :
> Folks working on a C++ codegen would like to reuse the attribute
> helpers directly. Add the few necessary casts, it's not too ugly.
It's not so beautiful :D

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

