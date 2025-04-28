Return-Path: <netdev+bounces-186485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D69A9F5CE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A8C7A37A6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B02798E6;
	Mon, 28 Apr 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nO2xf7jt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA927B506
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857719; cv=none; b=PbBXGY2G1PjeHsZucznwDS7wEnDyAdKeSpZhosxS70hjDbe8AQXO/hjrHtfg7skcZIeAiJu0Pork2kFrfJ50VLlWm/Bw2suAgyUZzrhLtCtrDeSZDqS5ZSxrn+RjRQrmfkeYAL4POys3WDNB18VFmqyv87TkXM0OkUdlXDfXT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857719; c=relaxed/simple;
	bh=oc9SGkyl7iRgL4xnP4okiQYIHHy8HCLqSuWkKVKOKw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYU1RO8DT/mZU1sZo34KezewZxqaukerNTZ1QIUXhv76CyteMpv3gyvlwBEhEAeNd5MkPwlBIPAaB9NnTxlZpDH7jfZRm8pRzC+dG7ALLvFxQEnQeTIZrdkY6Vv2lHCj1L0gwimAEr+lQjXAIPTH1lHzedxrDeMmW6pjKJTZiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nO2xf7jt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso34339525e9.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745857713; x=1746462513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5Sh5qhet3TeHwmg3riu4NLkMBEyug21VKjwEZZHLNo=;
        b=nO2xf7jtcfBWckQTF6G4K2z+8kga06CPzun5r3zhJNwdhhRxg7MncbIS36iyb91laW
         mRDM8Pa/Q0L2VwfKCZcEbQtvgIVUrdSZTvN+WNZerEMbahMijaw8jh2LzHiVp/YiY3ne
         vJ+ATddVcOxk3jwU9ivPik6LseK1nvMwgKAUmj0OTU3LGmFf/1DUKNVYvjYPMxsNJdy+
         G0pQMIXPjB6kCOvQbO2I2ipukTmaFx/Ej55eKgNVyB9yauOorB5Rdx2+2Lilz1rGV7pe
         1WXYJCiWTdm9YyXYU4lkRxCV1aMPeXb2RAqMY4VKVYTETgRZGs0p1ur45IHeNwSrNr49
         IgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857713; x=1746462513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5Sh5qhet3TeHwmg3riu4NLkMBEyug21VKjwEZZHLNo=;
        b=hJ8t39DxgtPYFFGklQe6d+v9f0LdvyogtXX0M4qfz5B4bl/kxrpao7rmF2J9oE8yTj
         0ocD+x1ZTYJfGya+7QpbuZI3ay88hTDYcUtxQca/x0+Ej9jYy2GbjDTx3icax5x7M/CQ
         wPDpFm0PrQATPkpmSqHrzbiNYeMvriUCiQ3pKYqYIz4StxLmeyGShnF1/kw8G+IVsK9y
         5zxqIZaLQtReoYEkBecgKBDiUBdEC6JNbCLE4MLuBLebgwiBT11g6KhgHc9V8ZGyqyAA
         mC8bMHWs7NxyRoRXbC10EFBdXp5241qQDdYAsLNJdYCBZNPE10DbTZGLLn4taKgFH/ru
         mQug==
X-Gm-Message-State: AOJu0Yw3p+drC9lMY2YrXS9OrqFMSyzMmWHR29i5JD+k6RptFMcN+l7z
	xC3EkMLVo2HuC8j71SkAO7JN4au8HgjFdddFZTsIHRn6yu0Zuki7Wuoq5td7Vzo=
X-Gm-Gg: ASbGncultR4Xn+JMmKypTc9ZDJcMITONF5AD3lRI0bzLoneTK2ju79Q+tMmOA6NM9Sd
	uoBF7A0Ym8Vi+E2/oa1MWBk52AtstHUpJEAF+Tmf/JyIO/vvFd13MkjIJBTEBbk/bYYBWmVSWcF
	iIp9viLkdunaFOX8hQHdnaAccWbsZrFQR9MpLclAILmhhT00rLdsg0SSLFthcm05Znvotrtx658
	fm68qA2Qdhzes1FbAecnZ89AA3l14J6DMxo1NkimJxXDGBsPJA/BeJEcIF1oFf+wqa1QhRmnO9g
	1PKOuRkENx54f72LelqAaUEnUVAiljABKlJCkOYhgSY=
X-Google-Smtp-Source: AGHT+IGpIqAdI9bsAeI+R092y4I+aEABFjMsH6iP+qDlspDtEufrgARuiVmoJoLXrU7CJRawQNgLUw==
X-Received: by 2002:a05:600c:46cf:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-440ab8722d8mr61198965e9.28.1745857713513;
        Mon, 28 Apr 2025 09:28:33 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538f4aasm127685045e9.38.2025.04.28.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:28:32 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:28:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <fx7b7ztzrkvf7dnktqnnzudlrb3jxydqzv2fijeibk7c6cq3xb@hxreseqvu2d2>
References: <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
 <20250418172015.7176c3c0@kernel.org>
 <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
 <20250422080238.00cbc3dc@kernel.org>
 <25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
 <20250423151745.0b5a8e77@kernel.org>
 <3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
 <20250424150629.7fbf2d3b@kernel.org>
 <kxyjur2elo3h2jkajuckkqg3fklnkmdewhch2npqnti6mylw6f@snsjaotsbdy2>
 <20250425134529.549f2cda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425134529.549f2cda@kernel.org>

Fri, Apr 25, 2025 at 10:45:29PM +0200, kuba@kernel.org wrote:
>On Fri, 25 Apr 2025 09:27:19 +0200 Jiri Pirko wrote:
>> info_fuid is the devlink info function.uid I'm introducing.
>> the "fuid" under port is the port function uid attr from the RFC
>> patchset.
>> 
>> Is it clearer now? Should I extend the diagram by something you miss?
>
>Yes, it is clear. The eswitch side makes sense.

Good.

>You just need to find a better place to expose the client side.

Okay. Why exactly you find it wrong to put it under devlink dev info?
I mean, to me it is perfect fit. It is basically another serial number,
uniqueue identification of devlink device.

If other place is better fit, I don't see it. Do you have some ideas?

