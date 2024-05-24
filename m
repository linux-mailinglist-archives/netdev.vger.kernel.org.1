Return-Path: <netdev+bounces-98031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8A8CEAB2
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C31B2130F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C763F9D2;
	Fri, 24 May 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzY8fuDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4584D3F
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581304; cv=none; b=IOzBc8DlXOb34wa3YMyg0GIDWSiagjuz4NK0yhef7AwU3elLELB6OnP+Ni2zj2kNGtF0muwnIYJv4ynTslZgPWrtXVvQtkxo+04ClkMWOTmfeZde4KMCPRUx6Hq6LNpE9ySznRXSfqec0T+5Wf4FGRer2GZyejbvIYBY0Px/+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581304; c=relaxed/simple;
	bh=4FcReVOVCS7hYyDzoxRFPQL2lrzw79+DnOI7/JBY7bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyEvgFQBBy5CbNNQpzT7LCXrbmTC1BgOVRdgLSrlLfZAEB62Lm6sSrUJ4ZTl2UiglQd1quSn5v/h+vMMyNdlW6GINWNx9BbOCyVVK6SOaPQuMWN59UKfGq4VexgPvlCdd1He3TQIR8bMnKbytNwuC/DhYZCvCbwDSbpdqw/jSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzY8fuDX; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df7812c4526so598126276.1
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716581302; x=1717186102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCIWhXYa2p87CDvkJmySfb+8QTD7UAzsT7978LLc4BA=;
        b=wzY8fuDXc2MIzqoc41UIfK6/pwnVFMAg/Ga7Jg7yC7gD7f7H50dLYsRddqUn3tgXK5
         rcXTUO/hpOywg5M+fsO1s8pcT+bTb+69rKZ27CyG/ijGbqcHxy1Nznow+ksZGN8g+hPw
         0xyITZRZi7kiEOSn6cYCdkVNtB2MYuvMRgOpC7yRffDXFHJ++7HSilg30XnRs3Tg67iT
         XnEWxbSZQRMp9t+BUqILT/ipSn4xnuGL9c/H2CLkuNno966Rf8aP+erDTB7nPDGFG5oB
         tt8VTlUelt82XcmMMc+4oXZTFe8y2PfxnjZOjbS/2zTKe99R1lrKwrKs8Aukb89fzg+t
         s4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581302; x=1717186102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCIWhXYa2p87CDvkJmySfb+8QTD7UAzsT7978LLc4BA=;
        b=dEVGGEuBQ80dZ0x1Ma/I2Q3LmX0xUMO0sr2KHGe3VbajWQOxgqma3GQ7sBOO78aBfN
         OcE9/LgI9a0EW49qyu+bMQ72ZFV7DMshG2xUI9agqNNGwBOpoGAW7EMevdaLWEZGkKIX
         HIQ8T6o1JsJ6+KAZ3ZlCyuxTWyprDXyt7/Ym3zfEETLTqUgrZdkTB+b6erhtuoA7hfnc
         di3uSzvNPKxEBeKpWPy4/84ZE9fhgps5AcyY29295MlSl1XPxBvx8VOTX8j0NaW41zzh
         NeAHUQa8kR8T2ua8CYZO71I2bi7xxj2dZ7xUB9zwQBnNbcrJss9dr3KoXf921+08qJuK
         87qA==
X-Forwarded-Encrypted: i=1; AJvYcCXKTwV8eKDIxZyY8c6EfHa+b5t3dNWxFZEzUOTzFwzbAZKcQTZi4XVjeG3Fdtpr39kWfyBlpqh6DZOmqfkLlh3UVesrNGUG
X-Gm-Message-State: AOJu0YzQLnVZPRARl0sB+DwYN1+SU9ApIcIiXwrE5Hi2Bzo9NSoj0aiO
	YpxGuyOpRwKQyjGA7GKcAeOfCGC+trHAqybjRO7JxF5BuHAA0RuGT8NqNS8H9KgWB+3q5YMZMvL
	2/8iQfnaizul8IjTtK5npAndzHwIFWRc8UYuR7w==
X-Google-Smtp-Source: AGHT+IGfAILPpHKmHhMhPuha3zVO3krHrOtz2jtUmy9g1cSv1RC+mxHXjhsBUatjQc7ZmXfc28FlOTJyiuPQQbjt8K8=
X-Received: by 2002:a25:6b0d:0:b0:df6:ad25:f5ef with SMTP id
 3f1490d57ef6-df77237822bmr3447230276.58.1716581302201; Fri, 24 May 2024
 13:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37V5uqJ229iFk-t9DBs-1M5pkWNidM6xZocp4Osi+AOc1g@mail.gmail.com>
 <20240523064546.7017-1-jtornosm@redhat.com>
In-Reply-To: <20240523064546.7017-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Sat, 25 May 2024 04:08:10 +0800
Message-ID: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Thu, 23 May 2024 at 14:45, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> Again, not a lot of information from the logs, but perhaps you coud give me
> more information for your scenario.
>
> Could you try to execute the down interface operation, mac assignment and
> the up interface operation from command line?
> That works for me.
When I tried the down and up operations manually from the command line,
it worked.
But it only worked after I ran the down and up operations after the boot.
It fails to work by default after the boot for both the fresh deployment,
and for the later reboot

One thing I noticed is that the following message was printed twice
    "ax88179_178a 2-3:1.0 eth0: ax88179 - Link status is: 1"
after I ran the up operation,

Is that expected?

For details, please check the log here:
https://gist.github.com/liuyq/be8f5305d538067a344001f1d35f677b

> Maybe some synchronization issue is happening in your boot operation.
> Could you provide more information about how/when you are doing the
> commented operations to try to reproduce?

The scripts are simple, here are the two scripts for Android build:
    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/ethaddr.rc
    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/set_ethaddr.sh

Is the one to run the down/change mac/up operations script.

Not sure why the up in the script does not work, but works when run manually.

--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

