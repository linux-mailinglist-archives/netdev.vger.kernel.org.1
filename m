Return-Path: <netdev+bounces-105603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0374911F0F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCBCB2486C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28716D4F0;
	Fri, 21 Jun 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2OHCF9V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB339855;
	Fri, 21 Jun 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959433; cv=none; b=lYTHL+ydT7q+V7eD4bU6tre5/99AeL2qqBjDIBbYQ1FmM4yT+B8RQltwLzyOHEw13Vtyxf8+v6kRwiiFPdKOLdbJCJqoj626OrDO4vfSQGMmtPjgvrRaJRpFs01GERRxT1LrfWzMTfPk4nK3K3HJq+MvIfEyDI6L8XhLnR5sg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959433; c=relaxed/simple;
	bh=Ld1llqvq7z39bHSLK1S9wXloCpADkbTyfmvmMUQHUq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqfqUU95a9k7NmTqhm8KMaiQg3yVt14Zhpmj1BQCQL/wcPxwgUpONvcuPuYfy8gCeiUhX4PC0hNItlwLeUQbiiY6pLNwV1VCnCdyJCKP741zVdwznidqOX6dOxlfpY4Xgr3rEKLVBiedzQv7APPLCofqiOp6FA+c/i71I44qrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2OHCF9V; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6efe62f583so170820866b.3;
        Fri, 21 Jun 2024 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718959430; x=1719564230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHBcK6LedzR/+sxEDLbbxs19JXUNiB8eXtz06LeCIBU=;
        b=U2OHCF9VxN4lMWn5jPDbPoDQGqD7abNAodVTWCeo19jP2vjvRLdYbQ/At03CXnyuoD
         vYGBuc0ptyJIvYLsLs9PYosiYShCdOraBE9jG80NOZYnV0TSR1THaDg0fFOaKA2167Ws
         aAdfLGsf6elsRfvUPpbPzUaI9uuhv3Z6GcjIAewnDJ4GjppeI17g2x8MZ8MyCCq1xHj5
         78pZx6IQElgp00DwxoChE49ORl6nj956dZ6+V2jcVBtVocPcyBhqCv0I3G0zEfBKsObK
         T8WjiHNlDcIRICmyYenkGvIyG0jmrqsuFQG/0BFw70MLL/GlAyoMnso/xwIBcofJSy8L
         Th1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959430; x=1719564230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHBcK6LedzR/+sxEDLbbxs19JXUNiB8eXtz06LeCIBU=;
        b=mmIyXAhpbdkz7vSTxgXQdnM5D+hBjfAyc4onSRkmAZMHahE5eXiZJfB45YwW0Xjtn8
         2n3V/Guz4XBqdw7Qp1XfkO+A6vD2rvTeOYdIIJs4ekim4eNZaNtmztI/6F4KMvUmUodN
         PY0rbbjYYHNpbqFgo+UwqQ4wnYmfSZ8cYYFH4zQ6QNfNZeN37YJC7730LTPiAzXribG+
         6Fzm7qVN90ZSKtQuUoeQP3CxOL2317ga61vTSHb9e1nt6T3LvAa3U0A72nTcn+wqDBHd
         Og6ZLyKSfD4nIGB3UfjgoWTxI08Pq4rfRzO4et1jt2dCI86OPk/GRuj0kIbBumTix3Sx
         5wAg==
X-Forwarded-Encrypted: i=1; AJvYcCXs5kVtcyixJ/AYEjRYqamEiwwQ6+KA8rrmCh2oyJxO8ok/sOleAf4Ls1SCSLaHQ/+cHdw1SfS0vpnrG/nuhFc4vNRdKGxFZBKjeNZ5e4Lddm2ijrUtFSc7IsWBKy/rT01qF746
X-Gm-Message-State: AOJu0YxknwuUB00HxxHG0tKqIUJKxpRhZ6Cj+FfxproRVzlof6tsP6Bj
	eDK9sYDj5CGQrQer3h+dWNdir4+eLLmT1l0A4++KZZ3zmGBgRIur
X-Google-Smtp-Source: AGHT+IEg1h9bjy9mKEqAxz5XiZQqhZG5JZr4ltPM+HSMv+vHnYXlMCwdsHEX5OuSh1u7Uh6yCN1XWQ==
X-Received: by 2002:a17:906:3b4c:b0:a6e:f997:7d91 with SMTP id a640c23a62f3a-a6fab64599amr421044366b.38.1718959429467;
        Fri, 21 Jun 2024 01:43:49 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56059esm58013566b.164.2024.06.21.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:43:48 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:43:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240621084346.4v5xc672zojr6dc2@skbuf>
References: <20240619171057.766c657b@wsk>
 <20240619154814.dvjcry7ahvtznfxb@skbuf>
 <20240619155928.wmivi4lckjq54t3w@skbuf>
 <20240620095920.6035022d@wsk>
 <20240620090210.drop6jwh7e5qw556@skbuf>
 <20240620140044.07191e24@wsk>
 <20240620120641.jr2m4zpnzzjqeycq@skbuf>
 <20240620152819.74a865ae@wsk>
 <20240620143306.f6x25tqksatccqwf@skbuf>
 <20240621103144.300a2c89@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621103144.300a2c89@wsk>

On Fri, Jun 21, 2024 at 10:31:44AM +0200, Lukasz Majewski wrote:
> > That being said, I think the responsibility falls on your side here,
> > given that you introduced a new HSR port type and offload drivers
> > still implicitly think it's a ring port, because there's no API to
> > tell them otherwise.
> 
> IMHO, the above problem is not related to the patch send here. It shall
> be addressed with new patch series.

Why is it not related? Testing for HSR port type is the explicit and
more predictable variant of your current patch that waits for the
3rd NETDEV_CHANGEUPPER notifier and implicitly associates it with an
interlink port. If you're going to add the ability to test for HSR port
type in offloading drivers anyway, I don't understand why you wouldn't
want to opt for a uniform approach in ksz9477.

