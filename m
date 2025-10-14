Return-Path: <netdev+bounces-229142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0BBD87AB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F34C4F980D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC62EA73D;
	Tue, 14 Oct 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lI7AwmEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB82EA15B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434831; cv=none; b=fOO03UX8+xS77vbiwBLzyLjbuIkJKQ1/IKjeYEHwdb1WhZhKc8imCLpxuRewtDTaJ/hDL3sKFr2oEZCrWMs41iEGWAIR9ne4/9IXdl2TGRbYmBS4rqxX7+vCICBEAvMIDeakZ8Ik7G05Kg2mN7nOy/4P3pMrXTe4T6oOQG634FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434831; c=relaxed/simple;
	bh=wRKvHPeq0IjJrOaHI66asnH+YnrNb0PTfpXzCuY2EDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzqxJh4dElzck1Y4TWRcCWqGRA8i8nT1K6TsDARGVlNHNtpD5LlaVL0yweDcViEQfQ+s6wLJ7oOicfjJfzqBS7yDCCZIphWGtrMvrG3bI4sye2M58XF69CUGv8JzYY0Cs9maSuj1GHEVkuEC3ycHNlh2QKchVSmlvT0F6ZGndi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lI7AwmEf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so51934175e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760434828; x=1761039628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwcAcEVMFbFagSHujABEn/5LkWsDvenqWgEz+Q71K50=;
        b=lI7AwmEfjwytcy7C9GNZ0iRsPyf1sPDlnB5TcU2LUbmfCvQMhfh1DBO3drMmzCHQ/C
         wZC1qvcREs5DOYRivHuvTYKpDHPaCNXfNWtZnvBRDV7r+PZ5709mt4hSuPhXKHZG3kOe
         w/z7r6UMfPuqC/f+WybTZuF+X0Pwv5bws1EA24+izYd3sNobRi1TfOw3M1SP5VPb1AHN
         xbrrM1v0ssR0xpNynrjvC3mko41ooOFAeIF5Umtr+jOQzUCXsUq5F8c4QRB3y1FpurFc
         3gVROPP0SqGaDc+NmlS9BYwoo0teA5cfpGNjaZq4E2KIUJUJQmGj9pUzw1/wJyM/lrZs
         3z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434828; x=1761039628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwcAcEVMFbFagSHujABEn/5LkWsDvenqWgEz+Q71K50=;
        b=h3njAd+kxBsisYwbQG5SIZLeoqiG3Cjeq1SdFXsRGQwsV1rIh0hW5NWvyAWTNW6RXj
         bBo4xGLGsOjos/1iZpGus2fWH3MoHo0yQw6sORdLtQqQhTfU6OQaHLrlcSvis07MnzCs
         zsr7V7bCMk9qK6CW4gYY8RtusLs/dIUdSCfhMPgdghJcmLJ+ClsFL1pA50DLZ/TFa5JW
         T9vYd/Cuh4bRLu1vjr9JhNHjgfdvJajjWkX5EJwOqQL/UbX12IrRgTLKVNjNx0WGeXvg
         7VJ5QGwj2iTWc+DWnqGQDGa8Yx500kQRc1zzLvwMhOlSfl5YUoNsenGHf4C/L+tB9/qt
         iRlA==
X-Gm-Message-State: AOJu0Yx4rjbhlHy167rZ2eNlCfJ2VVJ8oSlEMTlXXRyu+7upJyLgHCJT
	wfTlWbP9S0jnXmWeOfHWEXVgHbVH9TNrfnThcn6wW37uEmst+VsLhSKe2vb6fMfS+OO+TGe4byb
	FDN/sWwttzw==
X-Gm-Gg: ASbGncu9FrB6Y95AfpAeOwbzHjR55sxZ7TsCY5zhs+X5hJ8kOzWPrTuGaM5R0LizAgB
	Z8C5m++45mOMbgIQOCAlhp95F4vaLYl/vdnUG1kiH1j7ozkckUTEBzd8oTDUqn89h8xw8YCn53H
	KwZ7PKZTbXKStHUvA9T6mlWMO7SSQsFi0zUYX+z3G6dvvSi8eC3virVtiWT8UXNc5jA8pyVj6U7
	bmsouxN3xpbuFpNX8S1X5CgB4ZO1ComQb3TU7xh4hV9d0lnRoyXRqVENQOBNzvHyASi2hsHe7TA
	3vAt3GrbA4p/ovuSmMI5LReD6g6vv9VPYfvONlixxrP4TzA/kbcBnl9hnD7jJakCxm/vygWIyHl
	Zq7bQHvf7ZIaEheERqh5BeW7y1IQQOM+ausa/NESZC3cQ3s/gI1n50MzSpyw1AC+msJw=
X-Google-Smtp-Source: AGHT+IHXmiUu6VVSyfoi7gU/XjlYIF2/0bxO4RUXhVMSkCCmaHjzamtRFltrBIEPIqHHZ3nvWstrgQ==
X-Received: by 2002:a05:600c:468e:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46fa9b092femr190108795e9.31.1760434827487;
        Tue, 14 Oct 2025 02:40:27 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm23512241f8f.10.2025.10.14.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:40:27 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:40:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014080217.47988-2-liuhangbin@gmail.com>

Tue, Oct 14, 2025 at 10:02:14AM +0200, liuhangbin@gmail.com wrote:

[..]


>+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \


I don't like the "virtual" naming. In the past, we always tried to avoid
that for lower-upper devices like bond/team/bridge/others. Soft-device
was the used term. Please let the "virtual" term for vitrualization,
would that be possible?

How about "master_upper"? This is already widely used to refer to
bond/team/bridge/other master soft devices.

MASTER_UPPER_DEV_VLAN_FEATURES?

[..]


>+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)

netdev_compute_master_upper_features?


