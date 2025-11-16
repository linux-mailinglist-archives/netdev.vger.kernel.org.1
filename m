Return-Path: <netdev+bounces-238977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ACCC61BD1
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 20:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93753348AD0
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640AE22578A;
	Sun, 16 Nov 2025 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O6kfH/B3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB403B1B3
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321558; cv=none; b=tJEZd6LcdrUVisX215RMWfey/Y1l9Buc/DkqQ8GsIENpd4i6yshhxoHl9ZCHtE3h4mbd/LVU3euHBfA2XwpRVW6ZMA6ypp8zGsZEr32OxAndOTsmeHmPwA2azOSd6d+zRz9LD3AKpdyPks1a8iOx/s5mMcdG+oX966iXTjFUVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321558; c=relaxed/simple;
	bh=f6sMcznDIqCuK2Dj37BlBtDR2xRZiUExHaME9TVWwrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSlDEv6c+fIslb5bCllGVZp/V/LExezpwmYWGByNgZ180pOG8sOIJWzkJg5AJti9i3dByd4doRznNKRysvaZVJefhNOsflevEbqx4zHBX5C0pAjQPmEzX6BSzKQ8PRw38bfTJ8pQWQH8vWkfLRvO9+rNhzJzyJwFQ1yDJ+aJUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O6kfH/B3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2+STlTGlTuK9Zr2ebsN+lut9dNbkijn2RHFf0Ty8kjM=; b=O6
	kfH/B3sjodC+5a/jsSIrR6+QB8uTyf754Ym+g7aPgHBxwK8hLdgPihR29pyclOTbn5f/eQ5Fy37AP
	02LJ3VyQBNKE/episVuT70KJWHGkToGKVEZLf3i68UMkaGeyhdQrsv2BWR+Kl7H5uYjUYFR7ddY/W
	Mr5ZcBk9vpfuagw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKiUA-00EAJH-Vg; Sun, 16 Nov 2025 20:32:30 +0100
Date: Sun, 16 Nov 2025 20:32:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mietek N <namiltd@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: fix return value in
 rtl8365mb_phy_ocp_write
Message-ID: <1c0ee3d4-2b24-48ea-b34f-b5653abe11d4@lunn.ch>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <234545199.8734622.1763313511799@mail.yahoo.com>

On Sun, Nov 16, 2025 at 05:18:31PM +0000, Mietek N wrote:
> Function rtl8365mb_phy_ocp_write() always returns 0, even when an erroroccurs during register access. This patch fixes the return value to
> propagate the actual error code from regmap operations.
> 
> Fixes: 964a56e ("net: dsa: realtek: add RTL8365MB switch driver")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
https://docs.kernel.org/process/submitting-patches.html

Netdev requests that you only submit one version of a patch a day. If
you notice something wrong in your patch, reply to it, and say what is
wrong. And then post a new version the next day.

This is also v3 of the patch. Please put the version number in the
[patch vX] part.

Your hash in the Fixes: is also too short. The kernel requests 12
character hashes. There is a git configuration for this.

Also, 964a56e does not seem correct.

The history is a bit complex. It appears it was first added in

commit 4af2950c50c8634ed2865cf81e607034f78b84aa
Author: Alvin Šipraga <alsi@bang-olufsen.dk>
Date:   Mon Oct 18 11:38:01 2021 +0200

    net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC

which added the file drivers/net/dsa/rtl8365mb.c. That version is
correct, it ends with:

+       ret = rtl8365mb_phy_poll_busy(smi);
+       if (ret)
+               return ret;
+
+       return 0;
+}

We have:

commit 319a70a5fea9590e9431dd57f56191996c4787f4
Author: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date:   Fri Jan 28 03:04:58 2022 -0300

    net: dsa: realtek-smi: move to subdirectory

and if you look at that version, the return value is still O.K.

What actually seems to break it is:

commit 2796728460b822d549841e0341752b263dc265c4
Author: Alvin Šipraga <alsi@bang-olufsen.dk>
Date:   Mon Feb 21 19:46:31 2022 +0100

    net: dsa: realtek: rtl8365mb: serialize indirect PHY register access

        ret = rtl8365mb_phy_poll_busy(priv);
        if (ret)
-               return ret;
+               goto out;
+
+out:
+       mutex_unlock(&priv->map_lock);
 
        return 0;
 }

So instead of directly returning the error code, it now does an
unlock, and return 0. So this is what your Fixes tag needs to be.

    Andrew

---
pw-bot: cr

