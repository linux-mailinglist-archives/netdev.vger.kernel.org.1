Return-Path: <netdev+bounces-138379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB29AD32A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBF91C21E9C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D01D0E14;
	Wed, 23 Oct 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZU2ovevV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD51D0947
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705569; cv=none; b=mwc+bnd5VYNTA0m/5Z2Gby6v8mg6sMq7KAxKUKNcuBdu2j9d4HiThthFNq8h8JXMJMNB2H2yn6m+18VUQkQkSdA1t+1MUc0BGllIQ10d6yOWDn8gEBSa8Hs/J0ELZhJaubQ9PyYUopI8cyEY8lghsLCt07DjM2tI2qIl34LJr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705569; c=relaxed/simple;
	bh=HhCRM8LXsD648EezB/Ag71ruZTVUBPWIrjPd9FGl4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrp10mIt7e7MTcWAxnSuFa0i1HwdKqnss6/PBjjFMuQReziJxk+dA478p745KK7e3vCz1lGoPbj8r4q23E77yrmR/mjwzedbRyFODTQY2oZHTE5a7cPlALAYlgV8dMCrCPiz9533eilO2+8VVPf+Gu4sr3Efr72mR5ZK6jahoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZU2ovevV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso192151fa.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729705565; x=1730310365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=ZU2ovevVAkpUpPNCNaZLd9knhxmHGnnW2er/zHUhMbhaXTalgW+K7RZflR6ARoY2yf
         CHxbOc6LCnDXwlqQeAE6vKJ9qg38XnuNHAzjqe7AJcKOwOft5ANLNPApjpHQ6lGgy3UH
         24MMPzTDltwJHhQqNy2qUf16O3liOUTWRoVds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705565; x=1730310365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=ahq7fX38qNggBsWOyNuOfsG/7wbLPrSZT4viGruPHn5a3M9WPU21wb2GQBwdE0/fCS
         SiH3E5jb4f4U4eVEktmmn0cdfKifxs3dwtcZ99YwXL3AVvXARGRfIfOAxXbc/F9Qxiud
         YNhNRhf5/ZZH6XIk5PQ/OGRRRrdw1+TOkJm8ZqnF2l9kWY8iOmZjhuY4Mb1Ukx2iKTt6
         0CxOjRUYcjHcWleSWgNFfw+DYInYeo3FaVZiIfdsQ9SiZSFrp9n2WPUDZ7e3rS8MeGYF
         T1ZP4FXdpHyPQqlIJcB1icciaZ++wqnLcKMMgartMfBBdUMa47/HCeFgbaQzWUC+gY4R
         2LaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8q5ERjqVXHcvJj0zznJI/wC3VKq3to7+soNEwTnsmPykgS2+dYBBlI4KXjkWomZ2IMx/A3sY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ez2UitQPiveBTHGWLW7LeFwCHsIhpVViuHdMoaiKLigoZiUK
	caKqrJB6FImVcCb0tnA+ZoP2I7QIYmpcVq1yikthQTkDBo4UZN8qpHcKbo7oii44ro3DRXj1xgl
	pP9o=
X-Google-Smtp-Source: AGHT+IENKTsk+JlQa/WjhyMg+6ecFCFUi5Pt/jGTI1j/Yoe9B6nCptbUvMloqSeSrYTtO/FHaTdggQ==
X-Received: by 2002:a2e:6119:0:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-2fc9d3838famr14991831fa.37.1729705565135;
        Wed, 23 Oct 2024 10:46:05 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c72615sm4664866a12.83.2024.10.23.10.46.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a998a5ca499so877665766b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmYbqaP/wGf4sZfGnatXeE0F1d3e/H2C7gDlSLqEKLPUj7p/O2U+OEKV5Fvc/2KeepiNZ/9F0=@vger.kernel.org
X-Received: by 2002:a17:907:94c3:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9abf94d4b2mr369489566b.47.1729705563762; Wed, 23 Oct 2024
 10:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
In-Reply-To: <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 10:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, gregkh@linuxfoundation.org, 
	wangyuli@uniontech.com, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

Ok, lots of Russian trolls out and about.

It's entirely clear why the change was done, it's not getting
reverted, and using multiple random anonymous accounts to try to
"grass root" it by Russian troll factories isn't going to change
anything.

And FYI for the actual innocent bystanders who aren't troll farm
accounts - the "various compliance requirements" are not just a US
thing.

If you haven't heard of Russian sanctions yet, you should try to read
the news some day.  And by "news", I don't mean Russian
state-sponsored spam.

As to sending me a revert patch - please use whatever mush you call
brains. I'm Finnish. Did you think I'd be *supporting* Russian
aggression? Apparently it's not just lack of real news, it's lack of
history knowledge too.

                      Linus

