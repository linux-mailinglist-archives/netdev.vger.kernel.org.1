Return-Path: <netdev+bounces-217935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD2B3A71E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88E03ACABD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B332C326;
	Thu, 28 Aug 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jqsx+q2z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BE32C30F
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400273; cv=none; b=NlhbmBM71nF91wvpIufUvUeZLNaweBNCJaWWbnyATylPIIV+35U1Pe/zUNc7FE8qJhm2hhj37zT93fhoDM06DC8Tfwm77+HHP+y2JqtA3bNq+BUEw8eZQgGr3/JUKMmgB/Ka4q0fHyvxPCtXs05hGWVkPhqVTQ7DvV0EbyLvr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400273; c=relaxed/simple;
	bh=nCg2nwi14+lPzAfgGbrrAYpMMC6kupWYt2gn0gu1knw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvDWKJR9dovDKf+HnghjPAvqxAF6rRofYFRB1jl4MoYEPHsTF2bGHof+lWf3XwoB3OWEnQ1MfCw0eHPYuwQDIfQ5k8M2ON/HXnjwdWueInp5rKmTVGids1DMblLT7R9kYPfQ2wAbs8U3L3G6nIjnhTwFdd5pK2JKJF3EIaMN8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jqsx+q2z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f4468326aso184e87.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756400270; x=1757005070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUlxTvNnxWvVbwi4g/Jm8/uE0pr83dkev1JUOpqywAU=;
        b=Jqsx+q2z1/wIo0bt8Hi4q8xHj4xjEYWVOF2t+wyeqz7ErYYHJg19vNwwpy6kAJjelr
         aE4QUfYK3E69mZ1AbBxrvvfVQdHidgMz2wHN8eLerkmksqPXm0FSDhSkTGH70Mp+widb
         CAerc56TozjwD3M/DRaD5V3ZUW+m/ftaTK8/qjGb/m0Dbe6YYmJci9tD3AjXTIgElU+0
         7yKTxFzhcPCh/7Is4k0Gg65yuWSsL25gvVceU4zQNeZq4Zm0QIev2LULfxyAOqWfPJ19
         6JDo0dE70Yd6f51nGO7sfuWTsgzie7uwh+7htqHB2WDXwObBd+i1br8/AsVjnjkm+bzr
         /wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400270; x=1757005070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUlxTvNnxWvVbwi4g/Jm8/uE0pr83dkev1JUOpqywAU=;
        b=Ub2GIjwywym1pwNA6ikSLef2loDKt9TlQAiOrVrh4IBqcNus62AKhfEVSzf3GpJOe3
         YsvQs+MNW/P/Dn4YMD86sKkozM/IybaRR49ndFcYAiFAaZhvHAHlD8dQpoEd7RA8+Mn6
         B6RSjvSUmXqmLWh3+ejNZCdqfWqL6TgtCPr/b30m4dS/WKkYpf8heIGbqcl2TfIN7kMl
         xob1mY7lklDZIcOFaNhMnVzI8kiNItjJbAk213nymbVZ9YZGBOEVXJygHdZHKiST7Fcc
         kBBuPcoB+9Pu6HOU8fFfyZ2ErbtLZIhUdkhYzi0s72g09BxPry73Pe93DmtyYXP0q9nk
         e4WA==
X-Forwarded-Encrypted: i=1; AJvYcCXljmLxPcjkIiXhdaQN0LTDU8yzIp4BjmBUuPO/6N3klD05FJ+8zj1bYpuffsVybkZv/smnpLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZt7oQDEu2XveuLoMWBxJjCmj2ae0bhSrPIuwRaMfRuKlEYQG
	fQA+aT9kJ8H2ryX0zPlTD+u2+J790vcJCY/6XO/cayrBUbdJfKWg6cs2DFvbYafuB1NK0jYrxt7
	5VcPMahQMUZL79tc77601mPGEuaoUoMXrvQgabVBy
X-Gm-Gg: ASbGnctF0SSzkz/U3uEYu2MmX0CTY+4w0sBAFSkoiKJQnLGBO2IUQ5ygzUZ14jaxdHW
	PK1w6f6WzHVU97xF0a9OnMDxSJkDJ6Gw2TviqcJFmBNnFjYAUK1UR0bvApmEx/JGhl5SfwyOn26
	XL83wnSdymNmeHaZ6AV81/Fd6ZpzcBbQmkGDQCAYaXA7EtZ+iPBZ5+gKhuxch+QbEnoICig47TW
	m2HbFVZTxGL5MJIViET53gmjA==
X-Google-Smtp-Source: AGHT+IEA+x+JHJGxAKqi3gf39h+cXrxl4F1cPaRjmHzOLyzmMNWf5vB8Aw2K6CCK2muVk+ohncKOBj10rKhlESV29Zs=
X-Received: by 2002:a05:6512:609b:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55f4d3263a2mr1010554e87.2.1756400269844; Thu, 28 Aug 2025
 09:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 28 Aug 2025 09:57:37 -0700
X-Gm-Features: Ac12FXyD8odEoc9_-KKAReVcf86GdG5H51-cMjxY6Bgpf4RvXSnT7vL1DpsIvFs
Message-ID: <CAHS8izPU7beTCQ+nKAU=P=i1nF--DcYMcH0wM1OygpvAYi5MiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection framework
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	asml.silence@gmail.com, leitao@debian.org, kuniyu@google.com, 
	jiri@resnulli.us, aleksandr.loktionov@intel.com, ivecera@redhat.com, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:50=E2=80=AFAM Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:
> ---
>  Documentation/netlink/specs/netdev.yaml     |  61 +++++
>  drivers/net/ethernet/intel/ice/Makefile     |   1 +
>  drivers/net/ethernet/intel/ice/ice.h        |   5 +
>  drivers/net/ethernet/intel/ice/ice_lib.c    |   6 +
>  drivers/net/ethernet/intel/ice/ice_main.c   |   6 +
>  drivers/net/ethernet/intel/ice/ice_tx_clk.c | 100 +++++++
>  drivers/net/ethernet/intel/ice/ice_tx_clk.h |  17 ++
>  include/linux/netdev_tx_clk.h               |  92 +++++++
>  include/linux/netdevice.h                   |   4 +
>  include/uapi/linux/netdev.h                 |  18 ++
>  net/Kconfig                                 |  21 ++
>  net/core/Makefile                           |   1 +
>  net/core/netdev-genl-gen.c                  |  37 +++
>  net/core/netdev-genl-gen.h                  |   4 +
>  net/core/netdev-genl.c                      | 287 ++++++++++++++++++++
>  net/core/tx_clk.c                           | 218 +++++++++++++++
>  net/core/tx_clk.h                           |  36 +++
>  tools/include/uapi/linux/netdev.h           |  18 ++
>  18 files changed, 932 insertions(+)

Consider breaking up a change of this size in a patch series to make
it a bit easier for reviewers, if it makes sense to you.

--=20
Thanks,
Mina

