Return-Path: <netdev+bounces-225699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9521B97266
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7623AE348
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D62E542C;
	Tue, 23 Sep 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XFZHxXso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1952E3B19
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650425; cv=none; b=arQ3nZEO61/KDf8ZOgpURpRR31XscFEZJQ7FB2gyGNnVRBwG0RHqIW4/miDB8FxGEnyhYovk258ix9zL0BHoll6Sw7HZkxm8fEnrewghwxVNGBG2Rx0xhN6stoNDje2vq/5Uv53fa5RLOdiScAG6lmYnOj3pI/U3h82tDhxGht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650425; c=relaxed/simple;
	bh=tOjvCjfWNiycJH/sBqgMz4SJifbLP/1BAYIaDyc91Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVTZWBvNQmvk0Kw1PbbQ4UHXhcjI8875dTcFaaKAgahQKg/5zqf/TRmGfh1kxfMQQsU9hyqpl3pr7AoLvZvuQqwyAIufYLtNoHKQI9o0rNa9KY3iscc6x8/HQwc/QYnSPlHEvuBl68BrzPqsyS7keXUsuJl7KT/AU35q9VZa32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XFZHxXso; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-27c369f8986so14994435ad.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650423; x=1759255223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojVDfybQegsK9pzduUejHeeKvXJAyIXRuH9aHP968Eo=;
        b=phYXQVx8iNcOqPd3YZlbujPYm7zoH9pP/IFfhg019eEN+/0RqUJc1/4hElw+NIxKFX
         wZklz6uh6QEJJ5GEVvcSbd/lY2vY7JVTsY8esMK4MpR9bpVjLhRLasIIiYPGnpqjqWyF
         DBMW0ZBdC3wiee+ON4OhvriIqidv9LRiohorJ22NOgI/+29bvEt+goMSKrOsSnNwcx9Q
         9MbeKSZ3fojNXmxnkJeF8TgeTjb1TV13ik1uqBMvKqKJEf9nUhS9Ol4WieTDi/A8gDAb
         JaHU7uulb5ZTO0Hcsruj9rrv5/fNBuBlvfpLGMSIACY7ASu6NSFxTmIu4+zbRaTbhp+f
         k5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL1+YM6E2ptoCYAMZBeCBQd5aIoBu6LOTsvbhi2dFKAY8ypgqEwesN0qswUb/avZawGroOmrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBLgu2djtAuEFPv/PgQNyG4btnclowzoUU9UuNjbhHYmLUlHe
	ge4PZRplORVcNLZl7jpJP4C9cRO9auYxyoS7Ga1LlT0N/ESCStvcXc4anErRoA/jrQNXWgSHCYV
	pr8DX55XWeSuTM+7D5/RkDKZyLhfdQTAFc+C4lZwd7D0AA31ufbcDq0CdT8xd0qw0CmSQe2JW2v
	kG76eI6Fmgy1Z27ZshEvUhN+kMbEerQ2xSBbdTAk5RxY/DqrtT1feq0+AgkcxIiqHbnpgH0ip2j
	Yj4JGPLs24nPg==
X-Gm-Gg: ASbGncvRhijgeRctzMIfyoIOvhwa+j0PP+wItgPlPUpleLHDmDkzC8mPsv2gsKfQRy8
	MjVqeIzu2Vg6dXY+I0OyZkdc7Jb2LPtelVEXAWB1kO4p8UYmx9yTd/X2MaGo5TwYkd+jOIAl6mj
	vW1OoOt3+qe43C9bsNEezRCQMuDFOkX9bNdkjbv8kllsB15gVkX1UY9KYVQkRJExoR4yWnMZ14i
	/Q71uwBQrPVD0EvpDbnldGi3kRyIWABbnADG7myDz6NoiJTgqwe45dqEUaAvAzLqxNh1kmvz0wR
	NCMaHPGBePaEN3zOCXXvylAkvXPk0JfNPyQ978F3HoF68t82xUssHCID90YBvPPGWgwwpEAIO3C
	o5eJ9xLyB8WcEGW+wdO+qFPyFQ5POLh6mioSGhI0SQ6ZvAyPN0stpHbeLaClC5Ybj1SghZtycy0
	0nVQ==
X-Google-Smtp-Source: AGHT+IFEMTmSbSWn6TnmSgDyorKzHBzWDv+XjVSHlZ4ldidDYcOCuavzzMSvpQje0g5Fb4P8TGwslaywD4hu
X-Received: by 2002:a17:903:3c25:b0:26b:3aab:f6b8 with SMTP id d9443c01a7336-27cc98a13f3mr47970145ad.58.1758650422847;
        Tue, 23 Sep 2025 11:00:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bae5fsm10147415ad.63.2025.09.23.11.00.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:00:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so9330243a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758650421; x=1759255221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojVDfybQegsK9pzduUejHeeKvXJAyIXRuH9aHP968Eo=;
        b=XFZHxXsotrS7Vbpk3PafdcA6/o3XNB6WPsAPvgXdrrRd4cIoy+5Ue0q5qDzJy3qHW0
         RJnoklLjP8qVpUmccnAhyBTknyVKnE5sTqIWikKGyjYhBbB/uyrTJtENZYPP94oLpXs9
         jTurk0gUvjBUjIt0rlctUtF2i4zgOGcMfZNbk=
X-Forwarded-Encrypted: i=1; AJvYcCXGHUb6+dVDq8fxoJTQQVWJKj73KifIKNjuW7hw6Chz/lFakA1mmQYq4h4X3hzyBNeICf/wbuE=@vger.kernel.org
X-Received: by 2002:a17:90b:4fca:b0:32e:381f:880d with SMTP id 98e67ed59e1d1-332a951400bmr4467591a91.8.1758650421065;
        Tue, 23 Sep 2025 11:00:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4fca:b0:32e:381f:880d with SMTP id
 98e67ed59e1d1-332a951400bmr4467567a91.8.1758650420670; Tue, 23 Sep 2025
 11:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-2-pavan.chebbi@broadcom.com> <aNLL3L2SERi2IRhg@x130> <CALs4sv0F+RW8gFu83=1-PfdbT7Eyfy6Kb2FYiAP3JhuVw7Jo7Q@mail.gmail.com>
In-Reply-To: <CALs4sv0F+RW8gFu83=1-PfdbT7Eyfy6Kb2FYiAP3JhuVw7Jo7Q@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Sep 2025 23:30:10 +0530
X-Gm-Features: AS18NWC8bOkJwDzjeBxv-HMKtahdZYoNTqMcYZ1RNEeul3owrZPnkzDRw8jUi6w
Message-ID: <CALs4sv1yFO+izik3_Bssvg4q48k-fe7adrgv6E-gtPkaZjcgSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] bnxt_en: Move common definitions to include/linux/bnxt/
To: Saeed Mahameed <saeed@kernel.org>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net, 
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 23, 2025 at 10:46=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadco=
m.com> wrote:
>
> >
> > This file is redundant since ulp.h already holds every thing "aux", so =
this
> > struct belongs there. Also the only place you include this is file:
> >    drivers/net/ethernet/broadcom/bnxt/bnxt.h
>
> Hi Saeed, later bnxt fwctl will include it as well. You could say it
> can still be
> inside ulp.h but fwctl is only going to need bnxt_aux_priv. So I
> carved it out of
> earlier bnxt.h.
>
On second thought, the struct might not have belonged to bnxt.h in the
first place.
So moving it to ulp.h seems like a better thing to do. Thanks.

