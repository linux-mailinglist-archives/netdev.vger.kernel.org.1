Return-Path: <netdev+bounces-200410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7528AE4E36
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB2316AB0D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46FF2D4B57;
	Mon, 23 Jun 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRrlGVyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6366136
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711217; cv=none; b=OtkpJe3OVarIE/wJF8DqHRThJA5ibsAKuJVPtno0SZ7cDFPI2ULDPapjhwngzDzuNvwtAFPII256PxTbEUGQ9e6DY5xYbRRmwTXIlUk0pQAAWRlHgwExfSxmjFtzwwklBCCv6XwPNimcHZFyp4RY8MLARlyTcU2xJhQNRen5ciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711217; c=relaxed/simple;
	bh=Whxy28t5c65QedQnEjz7kL8EDjL0rJEFc+pcRCKs1vw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I2z8mY8UkNCaBOw47UYawCI4plKq7iZBCeXl4GK3vuIFNmXOHHJTsOyEoe9Y3LXiXrXR7Y4nWL92Snc11sS/abDZpVm8Tb4nX1zmUWBiAdwrTp5nEJZvENz2dp/Y9u4rTryy/otaNNFo6FVl6oSSgvN3Z4oRrirPftKuTdIdOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRrlGVyc; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e75668006b9so4178953276.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750711215; x=1751316015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAJQn1EwqBmGVIzar3zbL10KVVCifzAKGMrhh56C4ZM=;
        b=TRrlGVycW6QXGhzogzdNHDV8VXPzZUWYeRBeN8ocvngdXoNnNSP9c4eIGmVjwml5/j
         +WbkmSKmYrfXJ3+RlmtmPkJ6vMSRrtpXR7sBe9SHmXyyiV1/0euVvOpbfTNHN89fV5gE
         C80XEbTiMUl6l3aBnRNHFmf/4IbzkOIq0+F7Yw619pT95A9Rch/CuAnOymzxglfMQ7ey
         ZjC76iYb1uZH1UtEiYH+PIJJxt54OXvgJnihkiaB3BBR54IUp1ZEhYlFq7Hg6U3NKYrH
         aTTQApD3Q7R/9lgTBvTeUqYMgqe1KlOltS10B8+xv9BNK30T11RCi/lRSXtc1VscuMKE
         ++dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711215; x=1751316015;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAJQn1EwqBmGVIzar3zbL10KVVCifzAKGMrhh56C4ZM=;
        b=nPchcKy02R2Zl5tnyf5O4ER01jfzYR502J6HRTB+SP/d0W+j4MvqJgOpBqVSARWAiu
         X1wLDE+Bep/cJilUq+rG0LyWjXDna36ufxGV/cCidXSCg2XfRnwoQeNjhDp2its22amA
         9B4Y9t/qPwvO/Y7sglK40GcgUaoijGNA2IlLOT+ZPncV1o684nFUbHm2q0YuWgM0Qo3I
         szPkTCoBv5L5F2n8WNNeg+WyKuPwfNEoOoNhGJcxo0KRPxtKezfrbTVtUReQOKxtc5Ld
         4/nqxgRx5YpJoW2YB4laoZFsCXxmI8mI9TrEZDXNW85pw6PQUfs0SWfjfbbWaqInZIEi
         iPIw==
X-Forwarded-Encrypted: i=1; AJvYcCXmpJwBuNoxeIZYpSiHHMK/Kt9WxnAEXH/y7IO4Q8ppVfuFYLaB8sfmrX7VTLIpkcGH8iXcjUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XtSq78VLPnlu8s9ME06SJnKT5CL+6CgIOjwwibRwJaZp9RCj
	VsXJZ/exGVVXuK10OYG2u2K2kwQDzQNqkt5RvfumhpJJc4zp1j/EHtV0
X-Gm-Gg: ASbGncurAyAyFX0X9H7WvWhVEmpWMC76+1xpxsTMH6jgekfNTYMtRljG7oXXPDo+Cf+
	GUg0x9sbv1ZndbaaDcLHLJ1KfMHYRhbhphj+vuzvwtkUdWil7zlgXI0LB0vTR8QwpvP20zy3g+2
	MV1Mzbk0yBg9FzB5IP/yEcMzJ6PIhq58UU2eo3CEfjF8ROlXeeNF4+fWLVx+gmdMthEvqb4wwau
	Bk+PjOcM0TNVaL3JBwTcDl4I88EPkGpAZIAtBwHn64qQL0yZuF1nadhVLyLThLTv6zST6HIIT7g
	80w1ZmIkBt5Gpdep6B/aK5kiIHZQ6yahI/N47mlUIc+nQGFqhZkFQk5ncOX9nQ6My7UtaWxrpf8
	KnI7OcPMqqIrhIr8y2DmxoSj+ZojE3wU+OC0jyYSsAomqLG+Zf5u+
X-Google-Smtp-Source: AGHT+IHtBcJjD3teCn53Pgtx+jYpISXrDe3BkA1Z6Xit8zwg2YCBsXRQ5DXa0mlPPe6dFbtNcz8uVg==
X-Received: by 2002:a05:6902:2e0b:b0:e84:1ae0:db01 with SMTP id 3f1490d57ef6-e842bc68bd0mr18852904276.5.1750711215047;
        Mon, 23 Jun 2025 13:40:15 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842acb55aesm2645324276.56.2025.06.23.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 13:40:14 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:40:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <6859bbade00da_101e05294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250623150814.3149231-1-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
Subject: Re: [PATCH net-next 0/8] net: maintain netif vs dev prefix semantics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> Commit cc34acd577f1 ("docs: net: document new locking reality")
> introduced netif_ vs dev_ function semantics: the former expects locked
> netdev, the latter takes care of the locking. We don't strictly
> follow this semantics on either side, but there are more dev_xxx handlers
> now that don't fit. Rename them to netif_xxx where appropriate. We care only
> about driver-visible APIs, don't touch stack-internal routines.
> 
> This is part 1, I'm considering following up with these (haven't looked
> deep, maybe the ones that are frequently used are fine to keep):
> 
>   * dev_get_tstats64 dev_fetch_sw_netstats
>   * dev_xdp_prog_count,
>   * dev_add_pack dev_remove_pack dev_remove_pack
>   * dev_get_iflink
>   * dev_fill_forward_path
>   * dev_getbyhwaddr_rcu dev_getbyhwaddr dev_getfirstbyhwtype
>   * dev_valid_name dev_valid_name
>   * dev_forward dev_forward_skb
>   * dev_queue_xmit_nit dev_nit_active_rcu
>   * dev_pick_tx_zero
> 
> Sending this out to get a sense of direction :-)
> 
> Stanislav Fomichev (8):
>   net: s/dev_get_stats/netif_get_stats/
>   net: s/dev_get_port_parent_id/netif_get_port_parent_id/
>   net: s/dev_get_mac_address/netif_get_mac_address/
>   net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
>   net: s/__dev_set_mtu/__netif_set_mtu/
>   net: s/dev_get_flags/netif_get_flags/
>   net: s/dev_set_threaded/netif_set_threaded/
>   net: s/dev_close_many/netif_close_many/

Maybe also an opportunity to move the modified EXPORT_SYMBOL_GPL
into the NETDEV_INTERNAL namespace?

Context in commit 0b7bdc7fab57 ("netdev: define NETDEV_INTERNAL")

