Return-Path: <netdev+bounces-74859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4780866F72
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E638E1C23A0F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ECE53E3C;
	Mon, 26 Feb 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p69MXhWn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58123D53E
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939565; cv=none; b=tuHg0CLDPgwM8hYH7hObGJJjY9WCEMqQrHDMeC8InqLM+peWxDbmC8487Yq7i+OXur82LeglHSPhXRhnKgvesaMl/LSkTo6HAVEfeAXBRfV2N9plR9yILMqmER0tvK51fvRmno+/J6Ygtso0l88ADyMsgENFj8zubKZhRiDBwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939565; c=relaxed/simple;
	bh=x9uCrGUckkPuYOH7j9FKj0T4LOdFpik/wacqUqvzeOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC+Fx8XhNcVlccGd8Gwmv478sX9o/Jsy3P0klH76HAlhMt4+1uXsYSo+vYOFnvt86hlEalQsFpYpxpAt2kgE1tOziPRGj5Rz5X03OqYOsP0SDBU1r+mzdw61fcBANE22oRT6ZLRuVl0kbQbBAQmg241bfoXD9bRVIt7oI85phiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p69MXhWn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512fd840142so818742e87.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708939561; x=1709544361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9uCrGUckkPuYOH7j9FKj0T4LOdFpik/wacqUqvzeOs=;
        b=p69MXhWnbF5jFCFYZ3XRf/xq1GQtgqacQw3rh3m1nH7g94gPDowdaRbZVfkiNEVRw8
         Wm8s4PpllLZma3+X6DwA7kR7hQM/A931fMi0eWoQqvzHYVMlOs1qImbf2qW+jmG0Vp7A
         KH+hGxDsX3/sjsngN8E7zzx2MsqqZKN572jPWtzLXJakHyfNs1CFi6C7VOruZaQtvT/W
         kkr9ycQOE7yWtcsTyCa7hKypw+cBRV4YCGcxCQ21M1++70uvEl1u6L/0h9GeEFsKfIF6
         oKrhNlU40Mu+dt0PcWqN8I3gYTyhKQEgF44k9fiZV2d0QtCvDgdF4tyT+PaLzbv7J3YD
         Wl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939561; x=1709544361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9uCrGUckkPuYOH7j9FKj0T4LOdFpik/wacqUqvzeOs=;
        b=d1niGEVpustE4kF5w8DoERbSodixsiDE8C+Zpqj5/p1ch+EPm6mbjxkZUdBPg44FYf
         13eHyDdE1lwjrMrxq1ipnX7zPwEcAxvnSGljVc3Hy8nx68HYEEpKqnlgHayzwEVSNxbe
         fr1PlVjmoB5icZ6S5ohPHVTfTa1Rm08xzzOZAY4ltdDBmJ+1XAINMX9i3wK0ccZF3x3W
         6DBDOlKI3vnHr5WEeZepTOD2dsEanmkqptY5lgM6dL+gsDNsEr0BecmlWQJGYyKPWYmU
         CagQBy9/RrKBHzIsDsxXMrRUvq2JpJn8I0qu2IHXv4Q6vFwME5zWY/5gji+P682eKUfB
         iUcA==
X-Gm-Message-State: AOJu0YxkEjTHjTmaxFABRFdWsAS90sqhJG3RG3Y5o6CAeSC7KB2AArdj
	SE7KZ6ottBw+GGfWFo2T8O2Dk8NENPnc+DH9FM5XhQRZrFkyDayX+Jz0QNIcW24=
X-Google-Smtp-Source: AGHT+IFtL5F7p0fq3M+budN97a0V3Hde2uyoclQGoU8bLA7/TqQC0CEhZbvFiHf7QrEkfrh0jp93Ew==
X-Received: by 2002:a05:6512:1326:b0:512:da77:6f2a with SMTP id x38-20020a056512132600b00512da776f2amr4867063lfu.53.1708939561584;
        Mon, 26 Feb 2024 01:26:01 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b00412945d2051sm7484425wmg.12.2024.02.26.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:26:01 -0800 (PST)
Date: Mon, 26 Feb 2024 10:26:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] ipv6: raw: remove useless input parameter in
 rawv6_err
Message-ID: <ZdxZKOvys1wMMURM@nanopsycho>
References: <20240224084121.2479603-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224084121.2479603-1-shaozhengchao@huawei.com>

Sat, Feb 24, 2024 at 09:41:21AM CET, shaozhengchao@huawei.com wrote:
>The input parameter 'opt' in rawv6_err() is not used. Therefore, remove it.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

