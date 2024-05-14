Return-Path: <netdev+bounces-96309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A878C4E87
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D312B21C6D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32E1D54B;
	Tue, 14 May 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcrYibdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769525745
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678099; cv=none; b=pJg4Lj+9Meah8uswLlSpkdXunVEhtPykatTSjrGLHEptjiBnh4ZMr/2TPltrC7yLb95JR1Ic6seFtdQEmHlLOAg9XTIYRUQPF3FawtcCYRENUEOsbuYObsVayk/7xW5fLm+PKZyxGvk1V8EvLCnSqYsSJCbeP9PydmeXe4BNtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678099; c=relaxed/simple;
	bh=icODbfYucz8iEZrgAXkiUdXTmzMqOGwAC8BcHGY3Tbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl7wqqurecbrZkUB22dJcjSvay0Z8lcUVNqIvhIzszverHlcI87WbRIBSQTYRhE3DiwV7Nrl8MdPYWN+VWxaiJ5+k8JBbMxE4eG36XbTUQ7TsBViCwoPlaJKJbiT6sxNTB5wcWbNEwq2dRi9JjcxkLqFs+wXKRcRoBiJ2FJt0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qcrYibdz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6181d032bf9so52866647b3.3
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715678097; x=1716282897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HwiEG+/aSeVq+45AIyqwaFB4r49uUU/xCyg6kp9PQPw=;
        b=qcrYibdzw8ejm3DTwFw0aQ1+8lS7v2cSxPOunX5wyzvQ3VIB47U7vUt+w0Mhhvmp7Z
         z5P7kDVAcGymKYdHPrjLIaeJK/ImNxN8LnlWBwQ7gZ/zPT1rBmsqgeNyZqgTcqhyA6Vf
         J1xROsideLdaV4Fo00Swsvk9uNh801DspFGapE3Y7wX0j3udajKlB/tjQbk3+7105lzX
         miKVMNy8RwOWj9fc+fJxPwImi7TroSZzDytSgAkfdW7PB1PqLbyYQFm+uwLuTGGXuAew
         wE3bKYXJuE1Kyek921rT/w91vx2Dh98ZXnNatzi+4zPzqP1KnuoqMqWLhVGELXnRlHfy
         fDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715678097; x=1716282897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwiEG+/aSeVq+45AIyqwaFB4r49uUU/xCyg6kp9PQPw=;
        b=H3lw7t0oRPONp92+WguFVHQJfrVDWiJETuqH/m7HwCEy0DF6bm4vTyupcAFlw7Szt7
         /jJWoX/sLmO1FnanzLNhpylh4Fnf3B0o4RzeL5w9OgPWykGcP/MWf7m2V61nrudl8d4n
         5AFhJs3B/M+SkYKw3PQ5m5ovi0LbWnSEnJqLMcrUNF0qquvxYiC36V21tgsj5yN79q9N
         zHUvnuzTTmXvfyqlx+IfgBHF/KzLEKVqIdPlZGPMA0zChpJ0CJ9Ow3DzpN299mzUSkL0
         IQbRczYTDOj7lm4OHE7S4o23GO7iY75hHCVUUznPRqTnpqM4mQNuOaKyafboS/GHivL/
         Umvw==
X-Forwarded-Encrypted: i=1; AJvYcCUHmPBuCopMp4Bm4R0GMgRaHLfsCYSlUUUyWmj/NcgWg/tW4Lsig8XuQ6MOek6oIDeYSrm4I2BIVzkh/w9qWkOG4lQvWH/6
X-Gm-Message-State: AOJu0YznTRvbQ0ffI9LvZrDh5CxIPsRbzddYhqfoJZo5JLcuz2UzSUWZ
	JPMgDAMCOo+YkhrsO+9odgEQKY6EevUAs9m74rEeIybj5Q4JwY0CaJts3lAtab8UaEpUIL1ajO9
	VUuBAba34c0Q5gxqJyuUlG50BD2K+yVvqKpknog==
X-Google-Smtp-Source: AGHT+IHTndqU8L/COCyzxzWqR9ztoQ2UlOx5uP/3CeJVhfGg7caer2qbn+5Tp3fV+rceU+UurQnOt0LPpOXSqHkDU54=
X-Received: by 2002:a05:690c:660e:b0:61a:af67:1cfd with SMTP id
 00721157ae682-622aff906e3mr134790487b3.5.1715678097010; Tue, 14 May 2024
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37XWZ118=R9tFHZqw+wc7Sy_QNHHLdkQhaxjhCeuQQhDJw@mail.gmail.com>
 <20240514070033.5795-1-jtornosm@redhat.com>
In-Reply-To: <20240514070033.5795-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Tue, 14 May 2024 11:14:46 +0200
Message-ID: <CAMSo37VywwR8qbNWhOo9kS0QzACE0NcYwJXG_GKT9zcKn4GitQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Jose
On Tue, 14 May 2024 at 09:00, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> I could not get a lot of information from the logs, but at least I
> identified the device.
> Anyway, I found the issue and the solution is being applied:
> https://lore.kernel.org/netdev/171564122955.1634.5508968909715338167.git-patchwork-notify@kernel.org/
Ah, I was not aware of it:(

Thanks a lot for the work!

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

