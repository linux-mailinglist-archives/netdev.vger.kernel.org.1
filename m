Return-Path: <netdev+bounces-210151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCAB122F6
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFD37B9BE7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C02EF9C7;
	Fri, 25 Jul 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL8JmND7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D92EF9B7;
	Fri, 25 Jul 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464332; cv=none; b=fi06p3w3BxYANwi0aXQAKFftOsTNV0wuIbm9NAc9lpFwAENNSiBZpNPGRBt9NO8wATaxBZpxfgR/IqTW4IFuDvm2gV0H3mRRWxXBhLNO5kHcEp9GvreoS2W7VsPIN1IiRMCpD8TUUhwOwFuFwJYx54hlS+mVjJoPQoroR5Ypx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464332; c=relaxed/simple;
	bh=zeX7Qkf3lRGP3FATstdWyXsUlgX+8eb1xUhTXKuUuII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDkpi5k4C3ubf+ZxvZ6HCrlCluRjC2JLisSVj4oLIhRkMTwwrqrgK/qqHUZD15Gji4fvXOGwnrTvHWLIGR2WNAaH44kP5qce5Kn99XNCAY4z2kJvIUzTywu3j8Oum5FlCucJ6MfqD3z9SumTZRJU5yBjmINIE44YfAyPmlOOCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL8JmND7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7600271f3e9so2189910b3a.0;
        Fri, 25 Jul 2025 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753464330; x=1754069130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmLGxEBkN0ZO8rcOT7khGeSzzvTddU8IGWpJopNzb6Q=;
        b=hL8JmND7dSt6iGG7pW4lPrynq5mvu45bTQ99Oa7Kr4RS62mNjty5yJJbsO9hYuCFAW
         Iu+baiMwjPwgWOR6zZLissvpthwogfYcjhdKe1A663+fUkjQDNDncKPoSyzy20IUae7f
         gzrT+A4P+JySxuwKP+fTQd64WWPGlgCZ6PDi52Zy3g/m9znHSaky9/54xxR31BYnJWjG
         vFLxKS75ohDzwjxBNXXb44+6EvmGf/CBtMjtQdeRTZUFYSQC9iMDPX2Qdy0/czwkUTb3
         bUACpDqrJ1KY7d5e9202NJqEi7l5L4cUPukz/FFxqdy1WCeCuvwM3Go56Dkyts4eQHvJ
         HJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464330; x=1754069130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmLGxEBkN0ZO8rcOT7khGeSzzvTddU8IGWpJopNzb6Q=;
        b=wpOd1eInCuRXIrf8HCzzI4BmYIqD/XAf5q/WpYeT5WwA3mNfLerfS/4BTku2viBOAQ
         lugJi4KJV1Kll7YcTuwzWHGdSXAzZGWPMQgetPTzWB6fqanbHjgn4RzNbhH9fsq6gV+Y
         hqxnePG1XFi+IT5XboNeKX18NZD3EpxUNufR8UU0gs+YYhYB5bDnIrysP/ERYyfi1OIi
         4T7oBO0Gt4lFGkJammwGdvnJ8sL2nA7azsfDD2MfFhOBR2Xeo/Im+Wy+L5YWR5G/tgrz
         jVYqkLafgN4EJLXSAw+liFNo7WSCla2Qk0WHdVHsFeWAm8vS9AzPBZjB1pXo8ZMCz99o
         z01A==
X-Forwarded-Encrypted: i=1; AJvYcCWghhTl6Y3Dp748X9y9jmBW9FwEYBcqegsVpXmI2q9mLIfkR2U1O9xSo+fCWR2JWf6X5NdtksMa@vger.kernel.org, AJvYcCXrQZQ5/LyAegQPL+bxhWsfh8JFG3ruznGLYIt856jWo2wOCfP5IigDwKygd9i/wpzZSSq5GlUFzXlV7UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95khkX5Ap/1Xv65OzukKbx2uPs2RHqoO6/1FAHNTf4xVtCkPt
	gnNPG+qvHqxY0CG0tl7G3r2OT7kSDRcGy0PcVpnkhzqI5wk5w8AgVCp2
X-Gm-Gg: ASbGncsgga1XFU1so91/7y5Fl3Vy/10NP95r2H0BoeqYv9g4EurIinoo+WnJ8Luet45
	rgQqNRdZTNd7R9uynYY0ACvzgYFtkvcJr2sZPrMlPbx1zgNxSnSJIDJ7wKk4LwOa3Go+xS7RexW
	GQI0o71ZQiZruGffaQXMbbft3qP4kaeOzHehvt63gcQQ3/9N/ku9gfIJfwnU0e8CTGG4/7Ck8by
	8TlbZ7/LG1RO8BeU5sRnJ7B++nvr6TkRZOiLbmkinsbgy6vJT4+nyYE6ncVGYSRshGTocizC6qd
	5nCFdQ1QD/v6DoWJY06Qz0X6qBeSgiPlfSGgthllMO9NZEfmPkkkQQ41g+Ery8tSIB6Mr6yEZvr
	NP8ReODqengbNQYEPi6kP15+e9A==
X-Google-Smtp-Source: AGHT+IHP5BRo2iYchjZy+FD/VO9iN0pttkceTIhJ2GYzWjjFESGj/MLZr3TNVOZCWUogIUzxnzQ3Lg==
X-Received: by 2002:a05:6a20:7d8b:b0:238:351a:f960 with SMTP id adf61e73a8af0-23d6e3b90d0mr4745798637.23.1753464329961;
        Fri, 25 Jul 2025 10:25:29 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02627sm187680b3a.44.2025.07.25.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:25:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:25:28 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: fan.yu9@zte.com.cn
Cc: dumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, davem@davemloft.net, jiri@resnulli.us,
	jhs@mojatatu.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn, tu.qiang35@zte.com.cn,
	jiang.kun2@zte.com.cn, wang.yaxin@zte.com.cn, qiu.yutan@zte.com.cn,
	he.peilin@zte.com.cn
Subject: Re: [PATCH net-next] net/sched: Add precise drop reason for
 pfifo_fast queue overflows
Message-ID: <aIO+CKQ/kvpX5lMo@pop-os.localdomain>
References: <20250724212837119BP9HOs0ibXDRWgsXMMir7@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724212837119BP9HOs0ibXDRWgsXMMir7@zte.com.cn>

On Thu, Jul 24, 2025 at 09:28:37PM +0800, fan.yu9@zte.com.cn wrote:
> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> Currently, packets dropped by pfifo_fast due to queue overflow are
> marked with a generic SKB_DROP_REASON_QDISC_DROP in __dev_xmit_skb().
> 
> This patch adds explicit drop reason SKB_DROP_REASON_QDISC_OVERLIMIT
> for queue-full cases, providing better distinction from other qdisc drops.
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

BTW, it seems net-next is closed, you may need to resend it after it is
re-open.

Thanks.

