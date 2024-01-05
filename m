Return-Path: <netdev+bounces-61759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F22824CE9
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927F91C21B93
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE11FC4;
	Fri,  5 Jan 2024 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBd+5R8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1A1FB4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dac8955af0so679004b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421577; x=1705026377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46tIkZqvPiG0RkOGTbp0WUT/21LC14aHSoIc/kyTXKc=;
        b=HBd+5R8oXXz+M0PAFz0PfIHlx5tdlRc0EjG5Gb4bNwfoDyJyA6th2qOWzJ79xwPKUE
         KQ/ovL84ERjHkwnEktX/oJkdIZG95eFG2Ut5Yc7ZpQrFuy9yGu0+u2aYCtqKpNvLLpH7
         wqENgzJt9Lyh9gNTuwekMJ4mutEFoOm5Yj2frlRUetk1v6U/43YxQBU/1lXWxfYd9yYc
         GDFk0mFaz+AzpencL+olxEyLH1N6Bc/mUHmYqvPjifKev8eET86bYErGjpblNeK51ohY
         YXhA0WqTkm69367VrlFCQrcgDUFTMoPgSizCWlHDIxxc9Ud4OrnLtgtKGI2eePkqn6W+
         dnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421577; x=1705026377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46tIkZqvPiG0RkOGTbp0WUT/21LC14aHSoIc/kyTXKc=;
        b=dPJ/xH7c697fy+G7RVdsmen5lAI3XieyGCn/xrsddfVWAdJn6KmB3FBAwVhawdBSyk
         +c0o3N4Zzkja8tB7rjxIfPpBDMQtFfjWXI4JsnQ5Fp9XGHLsUhqeOk/ahozWqBn4zp0X
         JoiIfm61DMI32WNxKmZiEwFjYAsAM/fGE1T3xeVbtG94xT0MAq/RCUoWktDsmr9VDHNn
         yBMe3hs6ba79t6YkbAsAY9ANtrN6snmpKSnoUi1+B0D7R7o+B24f29FC++bYbxyxW2+r
         8zgqwONAXPxvO8m2VKsN7E8RdJLW8ftXSKs9g3oCh1qYt1TU+HuJUJ2ZCib08GGzN1Tg
         CdSw==
X-Gm-Message-State: AOJu0YyOI5SytKIesvPzD/TaKwJdwUmcxKJHyVEE7tLeMUs3P9QpQ4FA
	PZiLdC8IM3QQFdyLC6DKInEtP4DqhDd1OCgdejY=
X-Google-Smtp-Source: AGHT+IEkycrgFVn5RyLsdf/0PbylTHpx3lM0rNkPdPSYLJxqFDb5hbjTBOXhji5zusGPZAl0zzPbqQ==
X-Received: by 2002:a05:6a00:4604:b0:6da:16e9:9b34 with SMTP id ko4-20020a056a00460400b006da16e99b34mr126523pfb.67.1704421576711;
        Thu, 04 Jan 2024 18:26:16 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w2-20020a626202000000b006daca8ecb85sm343782pfb.139.2024.01.04.18.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 18:26:16 -0800 (PST)
Date: Fri, 5 Jan 2024 10:26:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <ZZdow05irUiN1c8x@Laptop-X1>
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-3-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104164300.3870209-3-nicolas.dichtel@6wind.com>

On Thu, Jan 04, 2024 at 05:43:00PM +0100, Nicolas Dichtel wrote:
> +kci_test_enslave_bonding()
> +{
> +	local testns="testns"
> +	local bond="bond123"
> +	local dummy="dummy123"
> +	local ret=0
> +
> +	run_cmd ip netns add "$testns"
> +	if [ $? -ne 0 ]; then
> +		end_test "SKIP bonding tests: cannot add net namespace $testns"
> +		return $ksft_skip
> +	fi
> +
> +	# test native tunnel
> +	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr

Hi Nicolas,

If you are going to target the patch to net-next. Please update it in the
subject. And use `setup_ns` when create new netns.

Thanks
Hangbin

