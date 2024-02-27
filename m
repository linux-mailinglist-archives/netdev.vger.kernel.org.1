Return-Path: <netdev+bounces-75390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E1869B73
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4111E2836AB
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22C14690C;
	Tue, 27 Feb 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RWysv+ML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40713146000
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049603; cv=none; b=lYDhTdPPywk//9FRjPQXED5VJgkW2rhfmjS7zmzMp0t8YUfvqD0lA9C1vNCLn5RR0YbLz+XPMQrPS+eyttfB/ZIv7Wqn+0MLSodafJ7wMWONBSFUwD5utwPAyDiuTEHF1lKPIJ2jvnXOBCYDDicavm8sz2yd61f2/Pk5kLrpPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049603; c=relaxed/simple;
	bh=tKB3i2ULzUxqcZteb4ZQczEAibcM9FOTotdV80h3GfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR9ivHxfhpA0uPE+kaZmLUH0zl4efCItk7SQSAO+Ds0TcWvs7I7iBPWLmbAUxeE0dqjq/PBYzQuOsmjNLSx1m/2F454wTdM9QK5LyrpajePFMEMNseusoedSNTk6leF7Fw6OAGnccLxrlFI6KOp/6Afw5d7f3MWwNS+5dvAgl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RWysv+ML; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso5455475e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709049600; x=1709654400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3y4We/I/OAkRE57RPqipAeKw/rV+o/vnjOiV2Pndg08=;
        b=RWysv+MLt1uNpXCYtcVQ5G5V8PznFQyPdRo5L7i91LAq+CJvj9HzewkRr9ZpLrVF67
         6iJ1HVHJY/z4rPW1xB5MZDyunkyGXss7WyfBIfmmAMntuKinhkxY8kwjWqYBOt0RlXa5
         3VW0ywMyGej67smh1XK0U+GCJOr/dl44pS3PFJQ+fxJdjuVxz98JDCOqu0Ll3skBgIAe
         eFa6NS67P3IUSwPSfuG/jBwLopgSHgzTkqwSBLlFDurlSuPlm1y0/7QWGaDtR1Cy+Q5w
         TZ5phbgjwhlLAIbJa4p8ZbIzpkLnn1idQMhKelrXwxddoA7D717u80M+zqfC+AwB/val
         Jv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049600; x=1709654400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y4We/I/OAkRE57RPqipAeKw/rV+o/vnjOiV2Pndg08=;
        b=tIBKGlCUm1J2+O0g+FT22dHut1tc6+hlQwZb0NP1uBg6A5lFYqk4Nhx7eTv1TpRvup
         oVjqQ9+DqG/fkJYK3zyHsfMfoiC+XyieUtBxGup6JssQfr4kthXDTwcbIpinIbwWelF0
         TXSFoI9rnLqqYVpf5rElInqdwRSpmBVsWadBNMVOm0SmnMSjg2OY2H9GKdWAk0JhgpRt
         YwWNjhR7gEZVU4tUTtdparXTJrHGBzsw/H/pdLOUAg4Hw4yviCV9BWuQ82rQ9T7pvjIb
         m2arlhSQNP23Qk5l82hInv9KHM7fGCyIev55nzEripBKftPjn+iE3wQ3/36p5mzfutPm
         tM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXKAFJqC2zZkTfAprwsWOSpbiwh5N4h5sRtXYLdvnWVimPa4ivXZBxO6EBoBiS2FLNTmLEXzEfiVaQDbn5J9qwD++g5jWjT
X-Gm-Message-State: AOJu0YxeQTTLmiwiX5RO9ITZB5ba3m3Lo6HZz9rrFZhSCYvzXyzTr0kR
	dKC5yn83ATf9PToXpLsnh5Xc4Gx5OzJJjpUUDSYlkYZodGhBxiBFWbOln4OaSJA=
X-Google-Smtp-Source: AGHT+IFN22/PPS0qL2fxWHOrSnH0K36g5mA/lXRY/+/guJN2/bh1+PTY0kVY+08pzvReMFEyRZLSSw==
X-Received: by 2002:a05:600c:1c8d:b0:412:afa6:cf3a with SMTP id k13-20020a05600c1c8d00b00412afa6cf3amr1073126wms.32.1709049600456;
        Tue, 27 Feb 2024 08:00:00 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0041069adbd87sm15255037wmg.21.2024.02.27.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:59:59 -0800 (PST)
Date: Tue, 27 Feb 2024 16:59:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <Zd4G_GttG0XtQ0wz@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
 <20240227065424.2548eccd@kernel.org>
 <Zd36oZMvIvqtNSzr@nanopsycho>
 <20240227074117.128af8ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227074117.128af8ca@kernel.org>

Tue, Feb 27, 2024 at 04:41:17PM CET, kuba@kernel.org wrote:
>On Tue, 27 Feb 2024 16:07:13 +0100 Jiri Pirko wrote:
>> >Please wait for this API to get merged:
>> >https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>> >A lot of the stats you're adding here can go into the new API.  
>> 
>> Can. But does that mean that ethtool additions of things like this
>> will be rejected after that?
>
>As a general policy, yes, the same way we reject duplicating other
>existing stats.

Makes sense.

