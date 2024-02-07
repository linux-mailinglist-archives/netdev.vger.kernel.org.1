Return-Path: <netdev+bounces-69920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454584D0E0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75CF1F229B9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF208564F;
	Wed,  7 Feb 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRmnYruK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB682D88
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329087; cv=none; b=uv2RsAfsB0aZvTb2bfZs2MVjBU3pVOYWBZc3dvZkp0aw5hPkc1A3C6GC3k/UCKrNaS40W+WAopaX8OsDkw4esL0yWK5LDQ4Wh0otannvS2kRTZTfN2H+PdkAUblVhRmnydDmNqf66PWLYymNTf22f2Qu+AA6u6hE+c2cW7WRnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329087; c=relaxed/simple;
	bh=MxlJu+J6TLx8yj+iNOuTo7euy0CLu6uztwIQApSEcdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIFAGZaG8GGH5haHkd2faJrpidD8A6zybNw+33yvacffsXTd9UXZV/ORPPsFX1/X9RAXmAI/RfqPU9CQs8e5JJrC+A5aI64apKb+lGZzUn7ZoXy2EfgW20m4qF5VsjUumfFih+ht8OggrtvGnD50cJZ73tT1uy6IR9qiFzwxmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRmnYruK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-560daf8e9eeso611a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707329084; x=1707933884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxlJu+J6TLx8yj+iNOuTo7euy0CLu6uztwIQApSEcdw=;
        b=ZRmnYruKBuH/13Moea6Bi7TOWWw2+RIYKHX83n+CP0a1BtX8LtX1H3++iDshWmCHmf
         sOPywdnCcDKSKnESQho54iOEpihxGvtvJPUa8hI5UcCDVv1wETlrVCNSxeCdlMge1JqN
         mP7H/PS9ChFRJDQ86N+YgZi+Ves3pAkpcfBl/s76A5eO444zUO6icpengm9MwHuwR7H3
         iKdI3p7ymYKMLRC+urrcmiRUDEG6eed00PPr1FIEhxE5FgJsvAOLRl++eCy4JA0TiQy1
         FLOenSnxUanj3+zSOtI/0GKPe34hqcdacWdl7t9V/twmO+TjypxPM1Wpt7HqC+aEV+L+
         YSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329084; x=1707933884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxlJu+J6TLx8yj+iNOuTo7euy0CLu6uztwIQApSEcdw=;
        b=ksiHfm6WO4bupQqa6lG1nV03jzpwncv9MrNNffySNt2XA3mYv6q/d1fwOjxmqa7IG8
         XdS/59QTD/1g4zVGrkUNT3c9Sgwo9v2C5K/i/ZFNXb80efGTJAT7jS99Vc9MJPg9nMwm
         uG16e1FhLIapT6aPoCYQaHLhgMHB6KVeO9Z7yE5ajYjf1Ur1TMvBrcZ/nzO2nlH9Qjx+
         bd5i9+HQ/0MQqsJo46IJ8N2w0i1vq62MWWi/58OxORE2gxW3aMWGE2GN1l8QK8NdMMyn
         NczltEKJ58RAMz9kmm3pkrOGnzwbLNQAqyFOQGx4mXOEvgdavW5DiyHVZBqCabB85SuR
         bCBg==
X-Gm-Message-State: AOJu0Yz/2vNHqS/FVUEjEmmqAZVeDBucxQiNRG92eVsbvMKaleO5Pmz0
	FJYWRVlROCvIF7kWgrPWcV9xJXiYhc4UOUzxFjwD6KasMzJSBWwXCIlVP4I2uDuJLW7aPgHq6ty
	jFoyTPG7BFhYeaRnuI5OiiqIfp+7jLnyEbv4k2BMmSF7/ZTMbYQ==
X-Google-Smtp-Source: AGHT+IGI0Nj8OAAEvuNW0mz5/CZNiXvVPMS0pCsSld6e6qLsiP5wS+LBjIVJBP6jozn13Ag77CnMg0Dgf+o6GhL9CpA=
X-Received: by 2002:a50:9fa7:0:b0:560:f419:71ea with SMTP id
 c36-20020a509fa7000000b00560f41971eamr51348edf.7.1707329084080; Wed, 07 Feb
 2024 10:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
In-Reply-To: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 19:04:28 +0100
Message-ID: <CANn89iLi7J0Hi28k9O6S3RnTt-opj2pNV6cEw3oyWUV_CiRPZQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add more missing kernel config
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:31=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> The reuseport_addr_any.sh is currently skipping DCCP tests and
> pmtu.sh is skipping all the FOU/GUE related cases: add the missing
> options.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

SGTM thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>

