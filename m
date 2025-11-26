Return-Path: <netdev+bounces-241766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4687C8803B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27195351B7E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B930A30E0E0;
	Wed, 26 Nov 2025 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOtA+Z5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67D306B06
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130118; cv=none; b=oHB0eaSc8vojJ+xnfvfK56zPhEXLgxdj8niqqjv5ER5cKaBLkXED6aT0qnzMSIrDtNlBk+uH9DW5e5949UmAA5XjdSXUJzkUf8aF87LIC5Kdjmw3bIRhT3dvMSMRakr86bjHmvq66WYw97/I/bQdh4jjuMh+I6hD1JarVdpMvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130118; c=relaxed/simple;
	bh=BsozE1Ga8UZEtcMgNL2q1VWHM2d+E8PeQWt/O1Ipv44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKYatC2uEzaD1x4YqUQgsxUUBMrSby1lbgNIW3Iun0WiVZiPgfBi3Yi8uBmGxwmyl0TVkGctSIo7hsB9TGrQvfC9Tw0M8YI20CAlj1UuHhvOPP7+ozPLXmDJdsdDwO6ozOzneholilqnBbVsrgMiAFaXkrx4Jz00V7Q/UGvPbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOtA+Z5X; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11beb0a7bd6so510459c88.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764130116; x=1764734916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z7iBqBHKRdUYuyoB8rzzmFsKnz3Y3mqQuJiu2GxZKQ=;
        b=UOtA+Z5XHvj25b0MFi+J8uVep44HvaKeMlLCvMEBwkBvdRsGsnaHdA0VwjKtgk1Dfq
         9jhwaSoCtaN5aiCtmJOvOXIUWBiAOjSYdd8maJrSNhlDTJ3+Ncd2+LO72QrJzycV+aYT
         9KPtXE/6v3nLQgTdvAOrQkZNrKhDfOkY9Cy8RIvO/bHIxp1RVZou9Jl9hQGKfHq+Ncu2
         pP7KDozshUDwdXtQ2pzSs4NqbpQdCigmVh1BnUJiv02/M66rN1eNvc2xOYlTa8U543VZ
         IdrVuIWYFvQsdGzDuVF5MhGjhiCVIP5IF2PaSO23dQm4mx98z9JQ9C6+2d3skscmF8Ue
         1jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764130116; x=1764734916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z7iBqBHKRdUYuyoB8rzzmFsKnz3Y3mqQuJiu2GxZKQ=;
        b=P2mS1mlSCJnYVXPFa6pPcUiHC4gCVbpDuDDJcuODsaCV3uf4Agy5JdXEQ33gj45ZHa
         yef0412r7sJdCpYlWvesFMzD7kYbJWzPj2AWZju0p57xnL6uhTthwX+rGKXZPVYR80yr
         b703vEH/b3ERqEQFTW3/awCUsbwgSsubfPjgzZTG/FZb01ujS8RR72RAhsa4mmExeOLs
         rP5IeTAdiIYSfPXKzAA/r4fJbJFNwiK4EnXY4PNnrcaPpwkG5qI3m9r77+1zsqpDC9F4
         7CzJWhOzACNsF6h3IkLy3Q/5mHvVcCDv1Q7rnktY+RXEbL7ccckqeW+kktM/H82fn3A8
         Rqag==
X-Forwarded-Encrypted: i=1; AJvYcCVymkPhqnaay2c4+Bd8CjucqLeUWlhaGuDhaRSu5PAaF48lyNB/5EhA9xit6rmZCxvHEAMNEos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2WgXNOFnqJfa/zY9bD3zbbRaMaWmBkvJcldWuh81KC52V3uc
	C89Afe1vawUYtlfjmT3lgGRztmoPZbhxxd2PkmWMvjZnzJVcxsLMCPm3
X-Gm-Gg: ASbGnctN+FmlZGfteWJsfvLYG9DQ+TE5lCQH9fQEBCd5s0J71C8rCzYUv+zpW3Azzpk
	FgqFYoZ65gTFdcu8q1yZzzEqtC4mmVEZP7qC450Og1iI4XI18k81+xfx1JWkVJSIh2HeOrxQ7eZ
	0bFKAhcdIMp+FnhwUvVZ12GBdaJQAfkJNGFUayxDbrPkT3+lcSvAUSR4KZjZkt1u8wC/oX3YtYq
	8HbDajDBxflVi14ru3iky00oT6uPwQRHxgN0hI3DakttI8MpQdM2LvQ9ZvwcX1UraRNYjJQnHve
	JcYuAhfeM+IgQshplLGAeWkF40LbcFCcUaT0i/JjMpZUItT22xYEcba9+eWwVi2J6vwjTEQ8Hum
	0QXD5rlcQazi/SFLpSJzbNLcZ2W0R8RWSOfKuqR++GTJfYO0OkN/JbJ3BUZCxyPf5kUsW634Pat
	3mgjnKhCCqffrIznEO
X-Google-Smtp-Source: AGHT+IHRA4qM1tECY85nqFQqlvSC4l5L/JqdviFcbhtwG92e/0qqF3TshJ38yUfhDPGNR1ZIZIRR4w==
X-Received: by 2002:a05:7022:6285:b0:11b:a8e3:847b with SMTP id a92af1059eb24-11c9c9363d0mr15232292c88.5.1764130116076;
        Tue, 25 Nov 2025 20:08:36 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:a2cf:2e69:756:191b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm92476368c88.10.2025.11.25.20.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 20:08:35 -0800 (PST)
Date: Tue, 25 Nov 2025 20:08:34 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk,
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v6 2/2] selftests/tc-testing: Check Cake Scheduler
 when enqueue drops packets
Message-ID: <aSZ9QhUImq0nH8mi@pop-os.localdomain>
References: <20251125220213.3155360-1-xmei5@asu.edu>
 <20251125220213.3155360-2-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125220213.3155360-2-xmei5@asu.edu>

On Tue, Nov 25, 2025 at 03:02:13PM -0700, Xiang Mei wrote:
> Add tests that trigger packet drops in cake_enqueue(). The tests use
> CAKE under a QFQ parent/class, then replace CAKE with NETEM to exercise
> the previously fixed bug where cake_enqueue() drops a packet in the
> same flow and returns NET_XMIT_CN.
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  .../tc-testing/tc-tests/qdiscs/cake.json      | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Usually tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
is a better place for testing Qdisc combinations.

Regards,
Cong

