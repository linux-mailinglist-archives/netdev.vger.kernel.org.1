Return-Path: <netdev+bounces-162231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D3AA26465
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4215E3A4EBA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BD20CCEB;
	Mon,  3 Feb 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LydI3mcZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com [209.85.221.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30320CCDB
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614567; cv=none; b=O3OngxheRNMmP2fOcPDJj/HTuInq8tfg71Adgh8+zZtjlqXco8DU3sbkwRNl00M7Sf7KJVpXEUF8ZC4EfeK91oUv5JjvyYaLV1gYqfeVQHfwXbHRZLCiJFSw0FeGwcJcDpw0l8B+8HenIqhzCh6eftXNnrWOfNjEtekePTWp0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614567; c=relaxed/simple;
	bh=DK/GNq4ZSl1hcO1eUoyzUQlQogZwz1VgIr5fTIYPFQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvMymnTUvebHoDbegL2vyD7DyAIpFczYtFZJaIQ3JXGrQ0HmKlO+wKtMUYY4XlIOhViKvKOjhjo5IFDg+KtFCq8EhWhCujPWgd+zI9TP6e+IZlwKtCSa3ZOuhl9KnVwoihgc4yDH5ci4DqceXNsEYAMSdvHBO3sPCZz0z/m9WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LydI3mcZ; arc=none smtp.client-ip=209.85.221.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f100.google.com with SMTP id ffacd0b85a97d-38da66ce63bso58987f8f.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738614564; x=1739219364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSGfFH8baZ3bdvUeFC9HmXyH+PYmE3PnqUWhi5Qpcf4=;
        b=LydI3mcZmPucjbUDogwRfzx3OyzwDk/iZ0OKevuLDI7L1+JoUX1CbM5/xKCg4zCDJd
         /fJZBQ2oVjRH3EVfCYuoOwam0sPWwyoEQD8RlYR6qmCWwxsKsYmaGOMKCCmsk0tGVXZ8
         eZTa2cl9Y38KcBRlJoXx6Vm26XiXWmjKuOCfcg2/aTPt6EFiXldc6PvJvqmOsHhAyo9h
         dJZKW6/5LLFXOyRAo+fl8HktIuDYAqAQijTT6LRYuj1T36WaBHE2CnOPWdz78IN7VFjR
         4IdLceuGk5Xblb8o8iqoHP8Dvx1jbnnHeDzoU31r6Ob35ijwOV98kwjrSxIZ07Km+Lvu
         RGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738614564; x=1739219364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSGfFH8baZ3bdvUeFC9HmXyH+PYmE3PnqUWhi5Qpcf4=;
        b=VT/roGoAImQJFCpTOj1GgJQ+VQ7v8Lx6KN3mvBc5SO8GhVhALAjrm3Fv3wY2/l+aoA
         QLUX2BPWFeiZHDWxeklDu4UB2SB0MKTsu/YHdX5iYRQbT/6yE0U3MpcD0RhL4YoZr4ni
         hNN+xtBPmDE3LdWwK3UyKMWUwAiSJNFRD3cnMXpKRCQgKWDbpK8w5CPc5eDUOV161+ca
         Qr4mS+3w2yOgKbJHrQH4ededUQkaNyN9jPj1I1KnompCentEofCeSnv2zqfm4VgSfogl
         Me5/WB2+e5N9Hb1G0ewMfGKJ0rjXr/wNsXcUtuNYoettMLULun/eC7lfsdNehZEm31hf
         cjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Z3RCSBrir4AglWR32r4l8RexefWqRYIX63vx+k/QikpnTQE3oAXUXvtlf3nkcvSeWUvsX0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytd3Yd0yfySkdKAwc8sEpN4jdCE2OGyH94H6ZSrYK04mKEkLqO
	qGO4iWHc6aWqHvV4TxX4pWE9kIPJGq5YPzcWdEgXeTzEPvDpvBNnqU4rcyP3s0ofQw0gG92JUC3
	kbQgL0SDvxVcx1VnrxhLhaqI8ZnWfidZ4l31GNRUlGwlLHT+/
X-Gm-Gg: ASbGnctoHSU1H4I1ISMF2zLKivV189nGWinI6/BP4JeZNb4WhDyb8zpUAeo6lVQ2hJE
	SnWG84k/ZQekXh6wrcrhoY6rR7dqI7a6tCcnDdfneicvBgmoGFGukZkTzJS3box8FZz7B4m7eOh
	p6IrqJR4IUeFRYFugp22a+e5tFb1paENV+gxqIs+e7xF4mp50EctYiztanZAe7xmfAK4BfdLYS7
	B9xfpjv1v10Sh6peAt7bbOKj4E7ihWkrDIkEABEUIee+Y7pTcmzQPDM+AET147R7/U1TcmNyWUX
	5dvFsoedV7FgcdwoXWTYJ5+6
X-Google-Smtp-Source: AGHT+IE53PAS4Vbh7Ju8mhacSSK2RkOhNrfkc9rwTj7/VyHVEalkfgahV3rbea54ebayTLp5oCT1gYOB7gcl
X-Received: by 2002:a5d:6dae:0:b0:38c:5bfa:a93d with SMTP id ffacd0b85a97d-38c5bfaabcbmr15148313f8f.10.1738614563801;
        Mon, 03 Feb 2025 12:29:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-438dcc26f07sm14173835e9.26.2025.02.03.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 12:29:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7BA3034014E;
	Mon,  3 Feb 2025 13:29:22 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 6B758E559CC; Mon,  3 Feb 2025 13:29:22 -0700 (MST)
Date: Mon, 3 Feb 2025 13:29:22 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <Z6EnIv6M9ujal6Ty@dev-ushankar.dev.purestorage.com>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <20250103-loutish-heavy-caracal-1dfb5d@leitao>
 <Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com>
 <20250109-nonchalant-oarfish-of-perception-7befae@leitao>
 <20250203-capable-manipulative-angelfish-bebe71@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-capable-manipulative-angelfish-bebe71@leitao>

On Mon, Feb 03, 2025 at 05:12:37AM -0800, Breno Leitao wrote:
> I wanted to check in on the status of this patchset, as I haven't
> received any updates in the past two weeks. I remain enthusiastic about
> this feature and believe it would be a valuable addition to the next
> major merge window.
> 
> If you need any assistance or support, please don't hesitate to reach
> out. I'm more than happy to help.

Hey Breno, thanks for checking in. I've had the functional revisions
(removal of configfs interface) done for some time now, but haven't had
the time to figure out testing - last I checked, it would require a fair
bit of refactoring in libnetcons.sh since we'd have to use the module
parameter interface instead of configfs.

Perhaps it would be okay to merge the functional change first, then
follow up with test later? I'll try to clean up what I have, get a round
of manual testing in, and post it soon.


