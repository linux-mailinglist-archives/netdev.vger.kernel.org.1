Return-Path: <netdev+bounces-156437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4544A065FB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C17188951A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693FC2010F6;
	Wed,  8 Jan 2025 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3+5Q6DI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE41AE875
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367816; cv=none; b=IuhkdKS4dF15oDqmykwY5b8+6JvohF+ElJVipORUH+FZw+hRWQ/s4kvuG4HHyrgsNMIy6W8lpc162qK/qo6dV+leQwo0KCgTVDpWYMTg5heW5TILHyaoTbW9vUTuW5E7fKzpo7nmd91zUSmt2yLWfQ/uIcQXn8pRvxtWgsCHZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367816; c=relaxed/simple;
	bh=VvuSxiUY1Io6/3tNyZaNqRNJYFQ5gi+B72aaXJCE9i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8gr9X0hGYCTyBJ7MJUsp810MaiIcdO57Lk9iuUGJEmzu0lSIef7s8SkF1fbeYCCXgZUPRt8iTnf0kMyt7vWAZyd1bwh5PulO+iLngMCXDUTNQWeks/TPSJQ0Q6UKgvtQfN5EcmQdl9ug2yBOFJeLTtqWnToJ3qjWMWtzh8g3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3+5Q6DI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so932331fa.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736367813; x=1736972613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUMo5TcoR2OdqgcIfDQ9gv3qrE0MlGFPgPk4ZRi/224=;
        b=U3+5Q6DIDSBN1IUsF0eD9pMf5VDvtpWHuMdczdAMJFyrVotCX26tPcN/Cpch7mSgpR
         KjFfY5FjFp0OEuOLy0Eu5ZT0uvPSbBSnB5gBIOLcgrYTd/tvNrnQkb5DMtxifd4IM1kQ
         IaSQCdUokH6ZZZFQJvrY1D7qlIz2fBNnTdKFPZI95lRbR/x9AME7dKD3fCtnOap8V669
         ihD42CLhcj7FNc3loxpUKdnu5s1HJA6LLAOagTBw1Yp21OYmwvyM4KOJwHXsdOHSYLA7
         v3MJ1wt4s5w6yH151bzc3uB32VpJfeZUk1aEnYguh5So4NQopdvOaAFAts/UEOWu5GG1
         SRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736367813; x=1736972613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUMo5TcoR2OdqgcIfDQ9gv3qrE0MlGFPgPk4ZRi/224=;
        b=aBl+fWZ+3ube1JOMusMMV8WwUzKqQItoEfU78fO06VXleozngnc4SjyGsOZlx0OyG8
         SWiGBTWHwyNAtluVJjE+d4TfzTHCcDpB5x03c39KHPVw8osuCJzXIHP8THLRD+Ke4fbO
         38sEHUjbER/kcMUMDSss+UyiXv/zBiiUUPhRashRMUqFDtbXI2W5/gTcnzJXCmef08K2
         oWvQT+cFhIiDMQcZupaz+/2CJgS26h+k8X/3Qz3a4YWiAMNZwU5dSD3f3cgOSx4Q6a5M
         I+pNaeljl0cktxeyJprO4JhW9VAI/orFeYNkNlZYEc9yxjKAckJfhYOasHqYw1XiBOxE
         ljaA==
X-Forwarded-Encrypted: i=1; AJvYcCVTeppUGQEXZkw+gvtXGDWUBsuABMJsybnx1fwMPfS1Dji9lKuOb8HNrP6hZNqqiA21ZrDPeLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkc+1R7s5d7cC/Jw8aAQXscwcRnMvwSyFuRF0pcIbTViO9KVpp
	SOe7OhKj+mxerTiLVaZz4pMcYLkOr6aK2b68WnCVepzNiZnBWIkFteSXkV7+
X-Gm-Gg: ASbGncumu6vyP3FnEXoqtdATsQZmKa9AY/H3KqMpJydDfN2IEbcbCZjZz4x209TFDg5
	LMFVFTDjjiQ1Wy6nSP8nozSc4hOz5apY0ECS1BeVIcJ66LcUvUVqeZ0CIEo/1hgPcWxi2Z3/dK5
	mC/yhiybvyh1bhebe9edtAfEp2zIPs5ub1dL4OHo2yOrSR0Qyxrv2OWxVH40l9W09Zx+N9cipkZ
	Lh66/oi/aZpGPT1VPalzUsisah57SbEMfjqTourASRglGVnmmpCW60Bi/yS6eZ+A5iq9RY=
X-Google-Smtp-Source: AGHT+IG4u10DJ2MFPKwiZHkFKBIbkknkdeKl5Viot0iASnrMpocJCWkLzOXUCSAluD3oWiq4SlYYyg==
X-Received: by 2002:a05:651c:b0f:b0:300:3a15:8f26 with SMTP id 38308e7fff4ca-305f445a592mr11691031fa.0.1736367812347;
        Wed, 08 Jan 2025 12:23:32 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b069ef9sm63360551fa.91.2025.01.08.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 12:23:32 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 508KNQgd025995;
	Wed, 8 Jan 2025 23:23:27 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 508KNNGU025994;
	Wed, 8 Jan 2025 23:23:23 +0300
Date: Wed, 8 Jan 2025 23:23:23 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
        Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>,
        sam@mendozajonas.com, fr0st61te@gmail.com
Subject: Re: [PATCH net v2] Revert "net/ncsi: change from ndo_set_mac_address
 to dev_set_mac_address"
Message-ID: <Z37eu/758pzGSGzO@home.paul.comp>
References: <20250108192346.2646627-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108192346.2646627-1-kuba@kernel.org>

Hello,

On Wed, Jan 08, 2025 at 11:23:46AM -0800, Jakub Kicinski wrote:
> Looks like we're not making any progress on this one, so let's
> go with the revert for 6.13.

But this does break userspace, the commit was there for a reason.

Potin Lai, have you tried deferring this to a work queue instead of
reverting to the code which has always been wrong?

> Original posting by Potin Lai:
>   https://lore.kernel.org/20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com

Unfortunately I wasn't on CC and missed that. Can we fix this proper
way please, do we have few more days?

If I get it right dev_set_mac_address() just isn't meant to be ever
called from a softirq (and NCSI here is special in getting a MAC
address update from a "network" frame so that happens in
net_rx_action() context). So postponing the actual processing of this
reply looks like the way to go, right?

> -	rtnl_lock();
> -	ret = dev_set_mac_address(ndev, &saddr, NULL);
> -	rtnl_unlock();
> +	ret = ops->ndo_set_mac_address(ndev, &saddr);
>
>  	if (ret < 0)
>  		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");

I expect if this is scheduled on events/x with queue_work() then we'll
get what we need.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

