Return-Path: <netdev+bounces-178970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC056A79BCC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EC116EF1D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7519F13B;
	Thu,  3 Apr 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="J2eRiLgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DD2E3365
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660612; cv=none; b=t0EX9FALhaOlDlRpD52RNMbi6gRhU4zfGjADH6+RCMfYOmZGn7jHvsnTObDDXrxtRW2XWPDeHASiaMZ4h1UWGxq9dQ64p1CeO4e7otg7HEJaJ6+v8NWUs1hnx6ahtrw7wiDNdkqlYFtMB9Desg1uhapuQurzUK/XS7dX/ikDJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660612; c=relaxed/simple;
	bh=94tJFTWaY+4vpgyAoSSVz/64TACbsLCzT497visIiBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADh8Z9ZOicqc/frNECqxmcX/X4GKITGQmUUdIjGMjr3wMuePiAmUvi5EpOYblSR1tr6QLKb6MW+phWNXWhN1kR1qzCBHfp4Z46ZLcBHjULghhZcTT1t69Lvr7tpm9yq45teuiDE1w1lDAnlYK3wT256lotuH5BGhmdrzMV4QXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=J2eRiLgs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39727fe912cso203216f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1743660609; x=1744265409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pM/towQbNyCP33oeJDTGzz2KfXQnDgCTa+Vq4pjFxkM=;
        b=J2eRiLgsKa7PF69kShNU0lCsIP7wk8mA3FY78MX4ZeR6X0Sfkk4jlKtswq6ru0msHh
         8YpxUOpmvLgBFKWB0wGeyfKts2AzwPUTE81fi/HMMuEoYJrXSAtTqKVEKXkoTp49n97F
         Rlk82TsCpNHaxTdfQsLNTCsXDt/5IIJh6ZP11xQhkfb8qB5Yt+BL/yoJbyaTxxHnieCf
         vV4RA2+2casWSOMmESIjR3PwEuPCiqkUPpXWg9UYnA04okMuUsTmqOSqV54lGMiabkvo
         1yl9TDrd4ueDyp5MwtWcr1uibLvP+4PPZ3nJYUUaPluN5+k4ddrpOpA8g1cA4uPwfI4a
         z6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743660609; x=1744265409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pM/towQbNyCP33oeJDTGzz2KfXQnDgCTa+Vq4pjFxkM=;
        b=v9cfUl7DwaIgCp6owMVnnVC3jmIB23i313pUlgNz/LFF5yEktZ2sM52YwLAALVqvkv
         v9Bh3SmU9+gpdmj8D9pqktQKzCsQOLg2eY/LY3jtPHezHXPkX4ODlVp6ejZxehOkGAa0
         9CkOEiwkiphBPPZEdwtpxKuM1h/7gzrc0hPAg1J5UiMWqg6YMTIB9g6XHo4GULxJuj+6
         snB80/oSpEa/4EYtLQe4IOkMB3FwiiutMAU7okUW4v+D/YnXQUfQfNSKSl1vC66t9yk0
         p/n35nbI+RsCcW2Zs42DwlSlmkICqKebRwu2RvoVti7KhmFNYuRrqwn+DtJ+haDG7RtP
         tUOg==
X-Gm-Message-State: AOJu0YwpOSjp5l3Zn+pUV9A1GcTZal1RizSZg0vf0PhPqYMWIM9Pj4hD
	LYAJNpd9L7fdslAAEOjBxXXrJA8OhKOMYkWZmle0KmcibSgTsNKl9B5E9PK4dW04S+b9+udPgw1
	Gxw==
X-Gm-Gg: ASbGncuZD28BjFYj6bCyOAqO+8XshSAru/acilnkMsTAus2pao5g+ApEycxbciZaA0q
	680euvEU90CePHMKehSO+gW64u+pFq2gEOrInpVBrhJGYgMEXpWLtkp3rKTdWQdQ0myRrMlmx76
	/vDX5z4xbaHZw6woHBWUNmabtlqISLH/u38xaGg1AyyPpit/aBkRWZejq1DjU+1Y9c1hB4DbbIg
	na1DhGmZ7+pfA/wLXY93rILrwVk+U9QaFtejcup9Y27N4T5xUlRNiiIQcEMh1MkMGShAEenTHSF
	vDs/BokANqLv6cG6otQgPNtLV8cE64fYGdKT7idE8o6+DBaD44Yt
X-Google-Smtp-Source: AGHT+IF5p9YeE516i05HFTKBZFOLOu8ltjBsF4niBjutNfULhnj4iT3bHJ/JOlXZFpEqZAItRYpwPw==
X-Received: by 2002:a05:6000:2410:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-39c297e464fmr4237810f8f.42.1743660607763;
        Wed, 02 Apr 2025 23:10:07 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226959sm799054f8f.82.2025.04.02.23.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:10:07 -0700 (PDT)
Message-ID: <df6d612f7bb720e157f7387c340c40e0ddc52d26.camel@hazent.com>
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Katakam, Harini"
	 <harini.katakam@amd.com>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Date: Thu, 03 Apr 2025 08:10:06 +0200
In-Reply-To: <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
		 <20250402100039.4cae8073@kernel.org>
	 <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
	 <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-03 at 05:54 +0000, Pandey, Radhey Shyam wrote:
>=20
>  + Going through the details and will get back to you . Just to confirm t=
here is no
> vivado design update ? and we are only updating linux kernel to latest?
>=20

That's right, there's been no changes. Well, to be completely honest, I rem=
oved a custom
HDL block from the design (a watchdog) because it was supposed to be fed wh=
en ping to a=C2=A0
network device failed, but since network isn't working properly, well, I ha=
d to remove
it or the system will keep rebooting itself. I also am now building the ker=
nel with
an initramfs so as to add small scripts without having to write to flash=C2=
=A0and things to
ease debugging, but my first tries were done with the original filesystem t=
hat was already
on the device (I'm now loading the kernel with initramfs using xsdb)

Thanks

--=20
=C3=81lvaro G. M.

