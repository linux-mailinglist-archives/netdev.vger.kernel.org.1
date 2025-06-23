Return-Path: <netdev+bounces-200415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6967AE5775
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A8F3A2BA8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B321B8F6;
	Mon, 23 Jun 2025 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqXM9YL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8A4414
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718068; cv=none; b=BcDtT2ACU5BYtaa7ScGtRPcWbqE5XIDxYeJb/MQANOky10GwZjLO2qLoqgVA5c6FjRjjT9fOyf/PD0emobs9ouH/3bz7KGuZ0bXKovkbE1o9AGi2iTzAuVx/o9GGoKGDU9RbrqQZrnjXm5xA7+7g0S5bwbSjIU/0HByefCjYaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718068; c=relaxed/simple;
	bh=Rq1JN0PiZWqZxac9Xv6iCvGpbVBzkC1LFge0XLUTuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTa8+Osxkfh0Re1iE/GpJ/dMrJ9069zOctX9j2ZSirUTSOkCoDAwNjzXsJFwJweNwSeWYFY/qi5HlMN6RvGPP5M+OMYlAQ5Fhgz7Cr5FuIapY6s1R1uccIU1fVS4uAaVDxI/IdUa0zi5MgycDpgpUxa3vULiSJlAGkZZ7Xi92k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqXM9YL7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso3339749b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750718066; x=1751322866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=smwVGSzZgzgRry60W/jn6YjV3HtW44rNufXfhnF6rzk=;
        b=dqXM9YL7m5dpvqqyJ+NGJqG+3K/NFYBChTkuMmSCicW+ntiFYj8huU5TKgYf+rZFHU
         JDDIp0BeIcGIXProkWNk/Dp417Aw7DfgRnHtP5PjJHJTlQxmM19NYH1rifnk9akTlXhv
         Pk2bou8d4YzU4I/Lvo/qgEqha3e7+1z0uFJ5tMwEqUaTyFE2whOUSCP1QtxMOdOK7I+t
         F4z2J/3VkaN8RaPl/OLxe3+yAToreO8ajsx+2B9aQvuVmDqoZRCNEU3mNOQOT0U24ylG
         B8ldXCasqnaC1YKx85g+KS6EpxAR2JfLdoedGzcm023PUpnxauu8Y4GUiSYhuKjFLVr3
         pHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750718066; x=1751322866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smwVGSzZgzgRry60W/jn6YjV3HtW44rNufXfhnF6rzk=;
        b=McNlHExU4foeELN+RUfDsenFzCRNy6ehmx6z8fB1ILxbG1bV07LYAuTzKQI+kyQbjL
         nnzVnk6WuGpeAKg+uTCC70eipRs2xOQk5ekMaUSjezQ3lKKJC34Dhraf7sAluYsKHztb
         DIp0Se7hvTCs+ReJfHJofkG//b91xs6sB54P+lKpRpz/FAiiMF6MqtjJobMBb0lZ/DtA
         jQyqqTCXL8CQNyyr7dSv9kbh2gTmY9ITujrHbgXEbTTudC2J3ETwuigfmIgRUiZ/VSpp
         8GnGB1DUCCldPuJvcq7mTxaoE7kikFCBgUrz1ZiVXq7iNgU+h8GTlHhT9WIycm3fH5Il
         vg3Q==
X-Gm-Message-State: AOJu0YwBoO2eWfGifvYF+BY8SQxiDJPnEC35ala6AKGlllYpyaPtU6uh
	viCj6aGRU3B3hn1cZVCNE82xbZXige6AusHngl+TqBBqAeDI/Agn43I=
X-Gm-Gg: ASbGncsCkzC39iQzLwQcGU5EvVVP3h0dD75akcRPJY3XLaZ/QCBK+vRiyeos3HY7cfy
	wJjSQEEyVRck2k2y43J+q8cOh7S0cbS5vSBj5tzkZJjRYkxg9tbFOY579qzOXMtZafPdmDI6Csn
	hMy8QqhzrMv/0rGZQenAex6SQUAOVcW5Ei8rO2nxbGUkXj0dH7u1PSKj1gjMCjqFxTu+lfTt32J
	gbZp9C2DYFYI2zpqNiFGA6Kcu97rY/xG08Z/xdVUsHd4+d/ij6bLDCLuavA2aOWUrPvqVLJRVL/
	n0Ip0OXAtxVTWZrG9xyUO2nJXX3wFK9v0fbz6d8gC/j7dv7KCBtJFyBy/sgTI0KB31mFYM3luEb
	DKmO2FoXfrG2Q/V6pBH707t71Z6BpKXSxxA==
X-Google-Smtp-Source: AGHT+IGrSlPGm4ZU2IuYOk5Pkh/6c7iuYX446lLkrDPfM5pLVf0iR3TGTPXgXd7TRcRU6aQ6h0wh9A==
X-Received: by 2002:a17:90b:17c5:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-315cca43ceamr1836474a91.0.1750718065791;
        Mon, 23 Jun 2025 15:34:25 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3158a2f36desm11625631a91.23.2025.06.23.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:34:25 -0700 (PDT)
Date: Mon, 23 Jun 2025 15:34:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 6/8] net: s/dev_get_flags/netif_get_flags/
Message-ID: <aFnWcGnwkg38q2p1@mini-arch>
References: <20250623150814.3149231-1-sdf@fomichev.me>
 <20250623150814.3149231-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623150814.3149231-7-sdf@fomichev.me>

On 06/23, Stanislav Fomichev wrote:
> Maintain netif vs dev semantics.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
>  fs/smb/server/smb2pdu.c               |  2 +-
>  include/linux/netdevice.h             |  2 +-
>  net/8021q/vlan.c                      |  2 +-
>  net/bridge/br_netlink.c               |  2 +-
>  net/core/dev.c                        | 10 +++++-----
>  net/core/dev_ioctl.c                  |  2 +-
>  net/core/rtnetlink.c                  |  4 ++--
>  net/ipv4/fib_frontend.c               |  2 +-
>  net/ipv4/fib_semantics.c              |  2 +-
>  net/ipv4/nexthop.c                    |  2 +-
>  net/ipv6/addrconf.c                   |  2 +-
>  net/mpls/af_mpls.c                    |  6 +++---
>  net/wireless/wext-core.c              |  2 +-
>  14 files changed, 21 insertions(+), 21 deletions(-)

Looks like I missed something in vlan_device_event:

net/8021q/vlan.c: In function ‘vlan_device_event’:
net/8021q/vlan.c:507:24: error: implicit declaration of function ‘dev_get_flags’; did you mean ‘dev_get_alias’? [-Werror=implicit-function-declaration]
  507 |                 flgs = dev_get_flags(dev);
      |                        ^~~~~~~~~~~~~
      |                        dev_get_alias

---
pw-bot: cr

