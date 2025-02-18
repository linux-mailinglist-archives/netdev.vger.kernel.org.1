Return-Path: <netdev+bounces-167523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB3A3AAA2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93F1188AFE7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26028629D;
	Tue, 18 Feb 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JplNbAPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5581286294
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913505; cv=none; b=Z3BOVVqeN/gXuVlp1vowrwMlswxyd3ALHt1pVB9T1ej6fgZbvUqNXpql4EkMZsIOAxLPDxcDFSoxAGA6dk3nJmm19uzAaghoCKH/Djpf+OBzJ8cDrw5UlvNexkP577flBNUvDPOFYrtQl1IOUUOoE+6sD6tF6UvJBqpoHZxJ0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913505; c=relaxed/simple;
	bh=lo1Gwb2dLxkXOcXCkLAtPT8W43cAM+6sIfU2T5W7J0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxL3JvW/iFvPS4KBebh/z9cWMx/N8oN/NoSTlheHeUCIZyS/eSCHb3l2s2jtP3kV2oAyRmOUgmQetZMVex/l8jQzclBa9sb5CpYBIz9GkgemazyTUGZnYLi2kppQnnJ7q0UCTMInygGNtpfAeXkK8KXl5PsFz4JMKjTUvAuD9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JplNbAPi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c07838973eso572179785a.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739913502; x=1740518302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjpibHSSEF25njImBVOUOzn2+A4jeVDzE8tXh3W2tcw=;
        b=JplNbAPi99KDDt/Rjy0iZintZf+dTC2U41JEEkmydMImjUHCpzi1hBWyz+Yi+j2w7C
         c4WRF00WTQNqm36CDIUCQShRt3KJ/hsnx9My8Vu+KSEezu5W9vzsFsn1xqcgQSphQKCU
         ouJA0QjrSEw67uCKzGd2xLro0CYg9P2SdFmKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913502; x=1740518302;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjpibHSSEF25njImBVOUOzn2+A4jeVDzE8tXh3W2tcw=;
        b=iOaYJRfyzRO041z8A5iO4+Ycn+0f6gczPEZGM1mNbYIPgtHA4m+rEzl4tBEtxnaqi2
         63C/Y9VqMInk472VJliHl6AUJW3yfXc1Aeig1LXwDsE0zjxyfcXH+Ico+QXQVhpU/F3b
         Ez/JEO9ljSEeOoT9MCVTwOXlj2R+cRI4e2vyJmZiLlNyyS1VkJA576OKosxcRgw+GjDx
         9/JYCc+XGy0MQT6uUjGONBZ2mntbk7M7KuB2HHHl83jpAi6+29Zf6c1ErERUDoWepglF
         1i3V+IYmJfQhcL+xx+Gf8X2zCdoGIJGzVe/ckICu2uSVVqCso4Ht+tIPXkLlTqfXUEeX
         VDSg==
X-Forwarded-Encrypted: i=1; AJvYcCXzj8KcqqDWQc6eeI3fDTUjlENMhT94ElDcx4gMR6Nvv4s8jH8toYCAD1d4Z3bWTd+FhYHT1t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZPZsrRb2HsRCVIhoHeGkJfs57wXPAnmjjyhkmBIdbM3KDm8m
	2UHgK274+iCwWkYQ1EzbT+911C8zy3TMv7+ZWPhz9yvvyGCWmPXZOR6ji48RkMA=
X-Gm-Gg: ASbGnctwsIo3hfeghU31i3XygFIwIdqdSXdt7ZBkZ5r5F5KDpz/IbX635IUNhpvgnQU
	3ya01uouIGbO9BP90i2TewhTirfBEm7awm4MQ6Krs+k0aesdMnUi1TRG9Hnc38azphKts4bj7uf
	ZoND0EKjV8snJBuNPgtybZ5VIWu1iHW+BiUZ3Tyqm4Jf1ydFfqQTkx9MsFnBpMGmGx+xMRLzgV5
	0aRfNv2XBrN0k7eGG3cC/zaJssO/CRHHzXd6obg3WmZBHpVGjlag8n4uDDUc9Yr8O0GlBoSdcKG
	NLa9sP+oI+yUs3yxM2/wUVvIHfWUO8MX+VZXm3SXjstRJE7/6Dnbyw==
X-Google-Smtp-Source: AGHT+IHyAAERxgU6r6geBpJiRax2TCr1qrKBraw11cLisgh07q3oJukBoKVG3mWeGYHnZ0V+R+hI3Q==
X-Received: by 2002:a05:6214:dc5:b0:6d4:19a0:202 with SMTP id 6a1803df08f44-6e66cd19fedmr226120986d6.33.1739913502598;
        Tue, 18 Feb 2025 13:18:22 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ef0a5943sm27784491cf.51.2025.02.18.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:18:21 -0800 (PST)
Date: Tue, 18 Feb 2025 16:18:19 -0500
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Message-ID: <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>

On Mon, Feb 17, 2025 at 12:31:20PM +0100, Kurt Kanzenbach wrote:
> This is a follow up for the igb XDP/ZC implementation. The first two 
> patches link the IRQs and queues to NAPI instances. This is required to 
> bring back the XDP/ZC busy polling support. The last patch removes 
> undesired IRQs (injected via igb watchdog) while busy polling with 
> napi_defer_hard_irqs and gro_flush_timeout set.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v2:
> - Take RTNL lock in PCI error handlers (Joe)
> - Fix typo in commit message (Gerhard)
> - Use netif_napi_add_config() (Joe)
> - Link to v1: https://lore.kernel.org/r/20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de

Thanks for sending a v2.

My comment from the previous series still stands, which simply that
I have no idea if the maintainers will accept changes using this API
or prefer to wait until Stanislav's work [1] is completed to remove
the RTNL requirement from this API altogether.

[1]: https://lore.kernel.org/netdev/20250218020948.160643-1-sdf@fomichev.me/

