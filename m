Return-Path: <netdev+bounces-127415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271F79754E7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31251F2128F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC818DF97;
	Wed, 11 Sep 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJQvpJNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606AC187353
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063378; cv=none; b=tAWEZaX+c0ItP7Fisk+XcW8hBlDJCVmE1Mq2a4HwigIEOINBDKSDB5wxEhmbnbqmtNouyJmHkGQLDNwbB+2KxUdw+kSodJPvPb1LshhaxbCep3S9ZlJy55rIWILTd7bSNPPXWRnS3StrFIXidgNNqWTQVl/+g7Yj/3blZ364bjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063378; c=relaxed/simple;
	bh=+YR/RFreJyRCRa3F20cHoIRaF2VX3sYKXEq3F9Kl5tg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=d28TgnLrG1+GLo/WkmujZh0zrvdGN7/Pp92UBvh35dIuUAEQCyC87IDErlqLcpjjiP5UaqmNsi+TUkN+KGZ0Xbpq7NDpu6OY3D5rZTZaShSp0LlDPTpa8k6tT+uXFv2Xtt9Ft4urGsK/Vb+4bgTtUXESTF2RdsKehaMzmJPqUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJQvpJNv; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4582face04dso8507501cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726063376; x=1726668176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMEPk98ZvTS50/RQk1ry1vockvcCjfG/gXPGA1kS0V4=;
        b=KJQvpJNvcxGygfbvms8GarpjmcTmpdw4Q35gZcbyNFDx53kECGYF1ZxYQhUWZ6TCFJ
         ZnE3hWCgivSV4GNG1LgwG4uasM+OECZzTFbbkYPnqJNudlOL2TqUYoCHlnPj98aGSy7n
         dmp4flP/c841gksKqa0vDjMezB9b7CNtSEgvVFDEq4i74M478r8+H3tsKucd9Iu5dN1S
         gtK6Ag5kLw5BMqUJpvWZKZYxb2RyHF6lntvLvFMztmKkNLRqm/OUEiFKIFPKmFn0CeOL
         nzBEzaP+SK2gzGcVPfi/NAUuEh5tO9LpGaITaJ3R9BDmluIRn3bFp6AAj6AQOEDABzwY
         xhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063376; x=1726668176;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TMEPk98ZvTS50/RQk1ry1vockvcCjfG/gXPGA1kS0V4=;
        b=bsgtJQjYmwOcsJN7k9iFfFx09WS1WC7vaJReYfNAFV6uXS/1/JXbCRzBESmxjulPr+
         BNuhiT9jDeFdiuVkC/y2zg3K3IzO63tlNWgQCd53Xs1UoNY7Y29feuV4EwuIcgrGeU/j
         WXbR9ME56nb4ySTav5aCUYIB1xZFhysoF3zS2KGkDyfM1z2cm7fX3KMHiikYouA73bYC
         QmMytvCq6zvdSAL6uXzo05PaC2JpmrDtM6jOswsNDyEWh+fvzrtPxsdVadnqmS5cM1pR
         qOX1DJVs668l544cADi02X51a/J8lqBFPF47BejTbQcswfMAFdvDAc61z31XMgsScjPB
         JIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0kLtRSBg/lHS1Wxa3EQiX3/B5FdRorMIdJV6w3ut/jkJ6ILm3Ua4iiz1kJpNFJN+FPKIV+ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlk8Mxb69LG4n8sQWa12oFjxVodhgnD1e+TKI2khHpV3zL3ST4
	qBLh93QvAxQCYLBacirPpfhK+3Uzv8Dw2t+YiBBgfb/cTr5Akr5g
X-Google-Smtp-Source: AGHT+IFCsenYiXg8vhHptEfQzQzRJDZ8uoYRQEKCs0sOJugiqRGiRVVyisaqmUYRJm/o9u0LLL8Riw==
X-Received: by 2002:ac8:5842:0:b0:458:1fcd:efeb with SMTP id d75a77b69052e-4583c6f45camr127733571cf.13.1726063375974;
        Wed, 11 Sep 2024 07:02:55 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e618ebsm41223841cf.11.2024.09.11.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:02:55 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:02:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e1a30f285b0_117c772948@willemb.c.googlers.com.notmuch>
In-Reply-To: <d0964c32-268b-445e-a2e5-687600f63ce5@kernel.org>
References: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
 <20240911000154.929317-3-willemdebruijn.kernel@gmail.com>
 <d0964c32-268b-445e-a2e5-687600f63ce5@kernel.org>
Subject: Re: [PATCH net-next 2/3] selftests/net: packetdrill: import
 tcp/zerocopy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matthieu Baerts wrote:
> Hi Willem,
> 
> On 11/09/2024 01:59, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Same as initial tests, import verbatim from
> > github.com/google/packetdrill, aside from:
> > 
> > - update `source ./defaults.sh` path to adjust for flat dir
> > - add SPDX headers
> > - remove author statements if any
> > 
> > Also import set_sysctls.py, which many scripts depend on to set
> > sysctls and then restore them later. This is no longer strictly needed
> > for namespacified sysctl. But not all sysctls are namespacified, and
> > doesn't hurt if they are.
> 
> Then you also need to list this new file in the Makefile, added to
> TEST_INCLUDES.

Argh. Indeed. Thanks, will do!
 
> (Also, even if I'm sure that's fine, Git complained when I applied this
> patch)
> 
>   .git/rebase-apply/patch:216: new blank line at EOF.
>   +
>   .git/rebase-apply/patch:267: new blank line at EOF.
>   +
>   .git/rebase-apply/patch:712: new blank line at EOF.
>   +
>   .git/rebase-apply/patch:776: new blank line at EOF.
>   +
>   warning: 4 lines add whitespace errors.

I'll trim these too.

