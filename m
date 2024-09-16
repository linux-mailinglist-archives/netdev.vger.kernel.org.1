Return-Path: <netdev+bounces-128493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF2979D38
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6191C22DBD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16781459E0;
	Mon, 16 Sep 2024 08:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7719145FEB;
	Mon, 16 Sep 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476574; cv=none; b=qDzP55nCUPoTh27C7zKBOEt71K0NJhe8TkyehUffTh04/WkgI6n2xm6/iMUPxZqKjK26CBMlnD6SwYUopeaQ6Cp05BfH+Grlrk1CXdfwpG3tPybUu8UDQd23U73CXOr/85PHIuve+SDa4Hy4YbWIKMMyMNHEYnd9cnukuINX8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476574; c=relaxed/simple;
	bh=0RwsL8tRJHrxz6bci8GcnzvSXH8JXVR2mmYCpi0aUro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaRnmqDZeEd3F4m1QkmY79qX/d/4So/fPxP5I+C1zt0ib2zZPETXgU/ZdKjq6mkhA4y0awbO/0x099J6fehCMBeOFuKQcKeQQrGYbejCnqt9C2nU4cWTj3e3ohzFxI2KpDYpB0CUE4Sj5sXFy+gn1/aoFL5MkktE2CACTxlpKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365c512b00so4841932e87.3;
        Mon, 16 Sep 2024 01:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726476571; x=1727081371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZOrm6iFK9ukG4YhnjmMP8ygODxZ0xE2s1p3kqMs3G8=;
        b=sI9jHyKk+FgeLbxBQiBrKph6fSXIqWO/3PiGsiDGZ7uSHT7dL1qCSSJbV1o2vcpGJ7
         yZY41lqXKxFHlgMaMYsTZCWwcGqlltwVrA7xUT74VT4Qe+6zP0MBbZoylR5B0cFE5fv2
         tv1cIcEZ8omnXP2xJgQtzJOTv1qq/9bn9wDRsCZzpfRh2SQathtRkaKLWCrj7Q6WR8Ji
         q3OUxKjfmFJ6F1sdwJJ0l7JV9mWtYegatBG0qZtLXkpCARTvAu5V0yrXhwzExweUBw+J
         oxkKlO7Pnxq1RLUI/idCM56wzbAsZ4IV9E30TeW8ZI4hJO0FPwCc72nkJpJvGOIvyflo
         JAAA==
X-Forwarded-Encrypted: i=1; AJvYcCXAH9FIIZcEm4bUFOx/RppCHYzFTnE0BuHFWWSX67U8Z/W5RAeQhIZXbWDztl1qqti4ImUT8SH/3Kv4sHs=@vger.kernel.org, AJvYcCXKCSS9hNBtGruAlfqr6W0HFTlaGn60LK21ja/BYpJWd20sDyotjfNO5QBKmNvDRbJtqUV/tSHa@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxsNLvOiK367G0qwg7fA0xVCiMt1pChssTEc4HaoHeoxqczmm
	zjBfcQB7vOkYvFsQ6Haz/VM02iZ3ineGit9Y3niZ0FFjN4C45CxNB3tdAg==
X-Google-Smtp-Source: AGHT+IEFEbhDwFhVzXFINy4qHKyg4nbulIUbIHX4c+G04FReJToLhFOJJLvpxphjRuUcNEruypGjOg==
X-Received: by 2002:a05:6512:12ca:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-53678ff2ed6mr7723379e87.50.1726476569914;
        Mon, 16 Sep 2024 01:49:29 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967a5sm285384266b.21.2024.09.16.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:49:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 01:49:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v3 03/10] net: netconsole: separate fragmented
 message handling in send_ext_msg
Message-ID: <20240916-catfish-of-sudden-bloom-dceac6@leitao>
References: <20240910100410.2690012-1-leitao@debian.org>
 <20240910100410.2690012-4-leitao@debian.org>
 <20240915165806.2f6e36a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915165806.2f6e36a8@kernel.org>

On Sun, Sep 15, 2024 at 04:58:06PM +0200, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 03:03:58 -0700 Breno Leitao wrote:
> > +	if (userdata)
> > +		userdata_len = nt->userdata_length;
> 
> I think this will case a transient build failure with
> CONFIG_NETCONSOLE_DYNAMIC=n. kbuild bot probably didn't
> notice because subsequent patch removes this line,
> but we should avoid potentially breaking bisection.

Good catch. Let me update it.

Thanks
--bremo

