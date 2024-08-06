Return-Path: <netdev+bounces-116167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19659495DE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744D41F2158C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34B36AF5;
	Tue,  6 Aug 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN0mlmJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0515E8B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962912; cv=none; b=sDZ1CdTe/ZB+VFXw968BYM37efuDFH6LcqUvQoow8nn2VTKrz/soop/XlDktVqMUK1D/8fjDgoHX+X2kbTMDuI3HU9yz+abkNwtAb6rwR18cwIahkJFdcW63/al3OurlKv8h9odf1HkuJ+uurEtFlGoIua53NB5kc03Vt4yQL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962912; c=relaxed/simple;
	bh=vSeOJgCUM2fIqt022j30J70NJ2LY47cLx7nRm7xnHDA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pyb/xn7LEIqqSQ5UH5x0mBAo2EPQqK6GgJqNSyvFzfRLROAzPVqCA0HtsIOhrZFVrLpET7aZccNji+eLkci5HyhPXJZ37nNb9ptjhfdlnBx7MUgjZfbKY2EHdMogznNlOPcvEJyf/iXKNOPdabfitZ05JBmllianOJbG8qD8jzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN0mlmJK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so5988225e9.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722962909; x=1723567709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68ADY4XDlieoDWdv+DaT0wHfDqTOrsISXrupLUZR014=;
        b=ZN0mlmJKx7Z0DHP02h7UiaqTFV0iOfBLxYQqWpiirmTEBIntFKUJFduwy/QLDaGLSE
         Bj+1f0HfXuIeANSVr9CXRP9+iQ/KD2Ieh4Do2qrXl9364PbVFlUtb5veEqpDm/ggFHzJ
         ADaJnbGkEEirMZIYIBs76tQz8EJTMq6YSyHEBTl/Ugp1BauqjxIxnd1zPMpobo6O19b4
         cn756BcedlhnYIWNVl96ZOfYaY199onThPTudTc7eZKngxv71aqMrNw7USTbYX+ki0GD
         aUnJgqC+JrQZfSu8RgvoK3JUlUTz+bfbOgzub83am70kIuMrH/IhtcNcxQHHNxukLCLW
         Dk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962910; x=1723567710;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68ADY4XDlieoDWdv+DaT0wHfDqTOrsISXrupLUZR014=;
        b=byqnWt3lJOMSOKKO9EYoffEcLaLCWb1Vh6zYjQjQ+65XPuEX5eUZUmfkNy+JfgVfTv
         ZtIETj0mpELn3A7TWaKoTNJg7Y2F3BoUkOPmlA2zPWlPWbSe1ZSoUYDu8Sh4+HJPAE/f
         dYWxLsg33fiUlEFzaXc1e8S/hxq5K7lr7KU6p71fr7DsVOV3JVsDWi4x9/6qMOEK4UTW
         vSMZ9QQFs+LwGJ7sE3p/lAg6MRHI7VOIkM7IAj1CdvWIQbqN5WEeXDKNYkEHM8/tP6AZ
         bnv6JSlqQebE/izvcGE+MGtro7AldgJrjbojJ+cJoL1T2Cl+RrS4OXbFIXmKxOJtAwXn
         IMkA==
X-Gm-Message-State: AOJu0YyCM4LglMOAFX24jBKFv7Ktq9VvkS1VDdAQVScinVmIp4TowH/v
	rX2hGCbX1vHLun8jBTQHQ/z0GnOg3uJK9/mnEQfxUydKY50c8aDV
X-Google-Smtp-Source: AGHT+IHpyqnqjnUWct/VRfm8YTemsHesX1uYv1RKTVCJbh4rvoMJaiKEG86G9uhtoTNxnK1v4hUCnQ==
X-Received: by 2002:a05:600c:354c:b0:426:67f0:b4fa with SMTP id 5b1f17b1804b1-428e6af4c80mr112234935e9.1.1722962909258;
        Tue, 06 Aug 2024 09:48:29 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a86dsm250185765e9.1.2024.08.06.09.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:48:28 -0700 (PDT)
Subject: Re: [PATCH net-next v2 12/12] selftests: drv-net: rss_ctx: test
 dumping RSS contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-13-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <915e5b8f-24c6-025e-97a3-3cd10a5018e1@gmail.com>
Date: Tue, 6 Aug 2024 17:48:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-13-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> Add a test for dumping RSS contexts. Make sure indir table
> and key are sane when contexts are created with various
> combination of inputs. Test the dump filtering by ifname
> and start-context.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
...
> +    expect_tuples = set([(cfg.ifname, -1)] + [(cfg.ifname, ctx_id) for ctx_id in ids])
> +
> +    # Dump all
> +    ctxs = cfg.ethnl.rss_get({}, dump=True)
> +    ctx_tuples = set([(c['header']['dev-name'], c.get('context', -1)) for c in ctxs])

Won't this return all ctxes on all netdevs in the system?

> +    ksft_eq(expect_tuples, ctx_tuples)

Whereas expect_tuples only contains cfg.ifname, so this
 assertion will fail if you have more than one RSS-
 supporting netdev.

