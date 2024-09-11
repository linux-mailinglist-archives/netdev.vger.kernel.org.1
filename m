Return-Path: <netdev+bounces-127214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32B974910
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDCC1C24009
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3024A08;
	Wed, 11 Sep 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ogiynayg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F58C144
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028463; cv=none; b=Ap7u5zF6CRWw3lJlOi8OsOKplfJCoGifNkBOFj8c+QfTzNNhlFj4NxDUS7+iIEo25TXbFykDSaZ13nXO/jPLe33SojpVMwMq+/HKTcNPmItHlQvnzV6If+1dncO1dAM00VEaWxKX6unNkuEp/HC90GDFgBMr+HnDWlV6WrW2nWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028463; c=relaxed/simple;
	bh=qjIPle1X5kAuS9zc9Tnq4VuW3Zc4fxyBC7oRUz9K7fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/uAU9KhsAMt0Qj3mOAaap1rh9IUDEwHEQoVTHaIKo3BoSjnc8BIRepcHR1Egbj9Ron0IVJwxHKykYywsYnlHY+YILEFuDtR1tKWTtwXzqVOAfoSzqv0NgCvYxqARG9MXveHEPtEBlloYJoMpTpYF3jSzPFrYOlSzsR8EWQ3lqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ogiynayg; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4AC5B3F5B8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 04:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726028459;
	bh=ckeGLCEhOMWatxIf6SnWAR9PTInu/komYkbIKWSH8cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Ogiynayg9lqU9IeOWiN8kjqAxql/vt2s5dAjdaWxV6ZTAzOo3sQFO8YLuxPOFZuIS
	 wj30iBvgTZvYsSe2Y7DrFkjKe53kPYageh/tmFkrEePAtjMGk78Bn+D7OgtYVK7G5m
	 A4MEjLCBZm2LY+GzpFk+9cIh1AGR2qtBvPD462DybtGyLpvMwyVXOTOnJ+djqEyCFZ
	 7GWM4m6oSxQLm6KKqu2Yh1Ygfl0wwHvEZVl0sb/VVmKwXJzG7SCnl7LrpTNT4C9unn
	 YpDprj9DtOmFd62K2c2kiL/0h5oqRwmeM1tRbocm5ahdGInS+eji4UohTvXgMA/8wR
	 uWuFgRu5wbozA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-718db8e61bfso7361324b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028458; x=1726633258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckeGLCEhOMWatxIf6SnWAR9PTInu/komYkbIKWSH8cU=;
        b=aDHlGUHn7ifdsEsf8AoQuWLiUq3rKnexYnGfHkAnbbO1VVCNPPOoHe2x9TV8YkOCzi
         0hG5ZgkWVlwneJ9mKXll1XVmKVgHE0OhTAoVNhC8HotUzQ92EYeELgNFLbnVi9NX0kxf
         cuA8S7ReDN+PCLJftq6XkSGPDxTT0k+Pqggjo7e+nyVCvyQBK/mJv2E1rlzL5Q04nCDI
         fFjzyd7dc0F4+5Dpr4936tON0qnONgyA9ZZ3yIOGc4FEslhCWUvPxTwoZBaxaliaqgLy
         +sjl70BxUIJmmXCgrIl4h4oFx8XvtXIDbu6r/ApE4NS5DenkHU5UB5KInX21lFHTRmVd
         yDIA==
X-Forwarded-Encrypted: i=1; AJvYcCXubNY6NWyl98Wa/Kd3E84+daDyHOfqIj/W0vkwcVtSh7oxvjgvS1RBVFipOGOIgsS0qxOxWpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WElz2Z3xOVKCcyqq2eZIAG4/eZ948OPwNyN0hDoBiy22Ftfc
	9AymYGGAGTE4PsbiGX0IBBAf8ijsVyTXURmfMfwULz7JVTfdRD6M1QMKgACj0WQjG4DnBefNLiX
	2xrUnmUFSBfz1elErv5veiyIVKu4H0Sre2NRTSTECR6T5O3vd1cS3eBXJMgmB7Gc9DGteR2mPaU
	mO9s27
X-Received: by 2002:a05:6a00:886:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-718d5e5476fmr25933619b3a.15.1726028457686;
        Tue, 10 Sep 2024 21:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbjgcD/xB0Dyjk+DCBVIMuIFxDQQgs5sulPbzkXnCpb5EcOtlvmxjgmLjNmGOz+VNi8kolRA==
X-Received: by 2002:a05:6a00:886:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-718d5e5476fmr25933603b3a.15.1726028457320;
        Tue, 10 Sep 2024 21:20:57 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-719090c9b15sm2099014b3a.202.2024.09.10.21.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 21:20:57 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: stephen@networkplumber.org
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v1] dev_ioctl: fix the type of ifr_flags
Date: Wed, 11 Sep 2024 12:20:47 +0800
Message-ID: <20240911042050.45254-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910205642.2d4a64ca@hermes.local>
References: <20240910205642.2d4a64ca@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 11, 2024 at 11:56 AM
Stephen Hemminger <stephen@networkplumber.org> wrote:
> On Wed, 11 Sep 2024 11:46:08 +0800
> Atlas Yu <atlas.yu@canonical.com> wrote:
> > diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
> > index 797ba2c1562a..b612b6cd7446 100644
> > --- a/include/uapi/linux/if.h
> > +++ b/include/uapi/linux/if.h
> > @@ -244,7 +244,7 @@ struct ifreq {
> >               struct  sockaddr ifru_broadaddr;
> >               struct  sockaddr ifru_netmask;
> >               struct  sockaddr ifru_hwaddr;
> > -             short   ifru_flags;
> > +             unsigned int    ifru_flags;
> >               int     ifru_ivalue;
> >               int     ifru_mtu;
> >               struct  ifmap ifru_map;
>
> NAK
> This breaks userspace ABI. There is no guarantee that
> older application correctly zeros the upper flag bits.

Thanks, any suggestions though? How about introducing
another ioctl request for these extended bits.

