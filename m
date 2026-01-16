Return-Path: <netdev+bounces-250651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F4D38816
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 246D93020CFF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0728DB49;
	Fri, 16 Jan 2026 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2jeg763"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060522425B
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597288; cv=none; b=bP6aR6sdVWJ1LLxMqYIXiZDfjVnSCkPsaaFMgiUgb8pr9Ysjmv9s9NwxIpcrRbw21iXqBXo2eJQfRrs5Ovp7AaS/jjU+tkRrmA7g9I/EK7CnATDWW/rPk27rlR2ZFnZQrmLpAkkvJMBwCkSy/EHuMa4IAAgdDlwX6WkfqZwEtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597288; c=relaxed/simple;
	bh=/Xh071rFobUifp9vg+391OtG1/GHsYcuoKH5i8JyjOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQLzeYKMwwjmQQA+rRd4fY+7Kxs3wY2x+5XMbKh68K2cpu5XoKwxFeTvy/QRzb1beRRozovylNlLEGxnb6++oCNMiln7HQk227W1F9CYVdBgy4e7OtLBKKgjv8iLvpLwguqadmVcpjOGiPmoGorno57S4o5rXNHhJabwzZccZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2jeg763; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1723031f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768597285; x=1769202085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXlyykM87bz8EPPmErTX2/nMizjLMi1IDXeb9kqCDiE=;
        b=S2jeg763oGMvOb2mBNJhei7xpYnLP7JJO66GgwHTeN85bumqS2b4dc894XOOzLYvqg
         gPRydq+IVVHDlLMhM5iqlwbYJXKnagmyqvhdgJkwVtZ+rnh163dPCKuWvnrQ7fbdvpFH
         2gKrou1g7aEL96c1vqsUZH0opdGQr8GQePf9PB6cuoUl6NF7Vrvp7xfCH7DTaXqlbBmX
         GB5Jii7QHPgdQaYb8mjfNaxIpHfOxJ1GViFgE639IhwyfHnotfSjAy+4NDKFYlp4oakA
         8FRQcMZrI9Qrw5f9IPO8G+tNKYOcA/0S+FTCZhliTfvsGiP23Ao7HLPvusxldDgsGkY2
         QAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768597285; x=1769202085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXlyykM87bz8EPPmErTX2/nMizjLMi1IDXeb9kqCDiE=;
        b=pvdYgF7R2pItii4CKvimruo8ddHy5cvloMjiRcsCC+lngBiFgzWkkW6WANME5oZcd0
         E9f5xdinFK4HzuMKZTBRrLCFgnAT09ALV3xnlfcelqEHjNaMSIHptBVAMAFC+BrcBO1F
         t0BvzGTls58qHm2yQh/cvf+YRB1OTEffX2R7QORAtYrIc4yRsvb35XA5U7sEwoimkwIu
         IF7FMLjbIoXTYncAk5x5izQb2gSVCGj77/oPn3MCvUw9Geo6nP8EgQlsq+FuId2VVIYY
         ZiMmgV6pYqi3E3QWtT8OBZ0UIuYEIRB10afaO/bpuIXmc+6yaZaBcufWpW2kiCO27DSe
         GUPw==
X-Forwarded-Encrypted: i=1; AJvYcCVhJGjvnIHcrLNFyraMKBgl0C183SbPDhLTsnDEl/As13909RSmJfq1jOcr/s9T55x/JfjvM5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNV+45C6sEz8kknNO+NGt6/gDuD9xkLwSMclBy447LLxVjf0Y
	1D1ERxNgvylEQ4Tki4Q5j55ZCF2sDfUKDPJmSxaGmGlBhZfQVuJDAts3
X-Gm-Gg: AY/fxX5cZsly0rMifi8Xekf8kXpwA93HtEzR4JH76z1cj/az8G2G9VFrfrjDOxoP5wh
	Naf16EChE0I9NYvVvG16HG2LBelqd+HokZJ2hk6VojiaIme7SxgF4MbFYhdB8LI11rwlTKRqNiK
	eoCLQgPBTMdlxmQBCnNSst6Zlp3QY8zkVPdxshUKFWiUWpQSE7kjPHMJOFLfzzRdup+F/vTjSN1
	5SBB8eVKVSqyvuj3EHL6PDZwU3tJR8Y2qRjPvifKFDOjGnsX/mB3Zuwy3xslyr9q3c+StqWJPqZ
	MeMx48dtcgJVdVwIzj46rCmcZgJ0LdNOXLUOmE9Wxt4200GG5S/om6KqImGr4jOJD//dGnM9WRR
	vXinob6V9Lg2aMBy7hO6nM6Fkjp6mHI9zUVEbBPByNXoDoxLxpbHTKhPOjrc0tOjWxebL4N4IjM
	3iHZzujQ==
X-Received: by 2002:a05:6000:4387:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-435699810a1mr5156199f8f.25.1768597284962;
        Fri, 16 Jan 2026 13:01:24 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699982aasm7545219f8f.42.2026.01.16.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:01:24 -0800 (PST)
Date: Fri, 16 Jan 2026 21:01:22 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <aWqkhT_-4UoNHX6F@archlinux>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
 <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
 <20260112061642.7092437c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112061642.7092437c@kernel.org>

On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> On Mon, 12 Jan 2026 09:40:58 +0000 Andre Carvalho wrote:
> > Introduce a new netconsole selftest to validate that netconsole is able
> > to resume a deactivated target when the low level interface comes back.
> > 
> > The test setups the network using netdevsim, creates a netconsole target
> > and then remove/add netdevsim in order to bring the same interfaces
> > back. Afterwards, the test validates that the target works as expected.
> > 
> > Targets are created via cmdline parameters to the module to ensure that
> > we are able to resume targets that were bound by mac and interface name.
> 
> The new test seems to be failing in netdev CI:
> 
> TAP version 13
> 1..1
> # timeout set to 180
> # selftests: drivers/net: netcons_resume.sh
> # Running with bind mode: ifname
> not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
> -- 
> pw-bot: cr

I've finally been able to reproduce this locally. The issue is caused by the
fact that the test currently expects that mac addresses for netdevsim devices are
deterministic. This is the case on my setup as systemd enforces it (MACAddressPolicy=persistent).

I was able to disable this behaviour by setting up /etc/systemd/network/50-netdevsim.link, with:

[Match]
Driver=netdevsim

[Link]
MACAddressPolicy=none

I'm assuming this is also the behaviour on CI hosts. I have started working on a fix
for this test and will submit v11 once that is ready. The approach I'm taking is saving and
restoring the mac addresses once I reload netdevsim module. Example code below (needs more testing):

function deactivate() {
	# Start by storing mac addresses so we can be restored in reactivate
	SAVED_DSTMAC=$(ip netns exec "${NAMESPACE}" \
		cat /sys/class/net/"$DSTIF"/address)
	SAVED_SRCMAC=$(mac_get "${SRCIF}")
	# Remove low level module
	rmmod netdevsim
}

function reactivate() {
	# Add back low level module
	modprobe netdevsim
	# Recreate namespace and two interfaces
	set_network
	# Restore MACs
	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
		address "${SAVED_DSTMAC}"
	if [ "${BINDMODE}" == "mac" ]; then
		ip link set dev "${SRCIF}" down
		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
		# Rename device in order to trigger target resume, as initial
		# when device was recreated it didnt have correct mac address.
		ip link set dev "${SRCIF}" name "${TARGET}"
	fi
}

The main annoyance is that to test resuming when a device was bound by mac I actually need
to change the name of the device after restoring the mac address (since when the device 
is registered after deactivation the mac won't match).


-- 
Andre Carvalho

