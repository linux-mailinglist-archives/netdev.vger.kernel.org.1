Return-Path: <netdev+bounces-128159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08166978504
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04301F28105
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C864776E;
	Fri, 13 Sep 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFClVecN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1114A85
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241942; cv=none; b=KKpg3Hlhrb8MxiRwCwAcdScUPfzij9Tm8k95ThzeyV+pN0At5WpYB4THYDETggnRs+SCtyGopwDjO3dro4H9sKtLW+KK3v9soY25G8C/DHGVTqdDgPFPJCsMd/w0SM8NPrdqyHwXd1DxDUi7RwiVV28h0J43Y47O5I/bY6t3WEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241942; c=relaxed/simple;
	bh=aLoNoWoenZGbszOH/3yu0dZQbZjbXUeSIhZUcCPkX2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7fYutUrSmkiD37/o8s55wdb8ItpU0PJnxN0Q0bMEMHtAqvA6/juTbwr9KjG+whKNu+Df48of8d4w7u0ginICtvoStNVhLkvseZZiQj6aA9GQKSmLfbt5K9luGPpIMcRCq7BeT81J7ucnyiDGrNogdKYm6ei7gDyXoBpWD2MG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFClVecN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581cec6079so275831cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726241940; x=1726846740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLoNoWoenZGbszOH/3yu0dZQbZjbXUeSIhZUcCPkX2s=;
        b=cFClVecNA8D4Hme9xSTy0J7z4qOKdnS79CvE9AFkBQyRRh8fkBWChhUB3u29Eknh6I
         rZjjZkBmx7MWA4jSwPX9/zdWO2cFWnFnuZu4Mzdv7rIN1DmQpRVj2EtXd05aWlQiur3y
         af00CnK7CPooNSOzh5JqUgy02puRQimfxo6CMdaomn9CzF+KZ0Kaq2TRiy0y0ZB6Jrkd
         trV2g4Bom05KsmxZnFM5FfmqxaOukfiFjgcPMQnh9jI//vhYwdXiDAFbSHs9c4CK+owG
         bomYoHzdBedR2srEw8H099r2tcozRvq+yhOBeqimhhKj/K/KLDZ07ss62pxIdDFSG5c3
         UKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241940; x=1726846740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLoNoWoenZGbszOH/3yu0dZQbZjbXUeSIhZUcCPkX2s=;
        b=WflP0yjsdA5EPhy2/6RDK11INbUpl4tk0k2fJKU9O80p57YVnv31RA8wbfrY6TtiOL
         4phr9jPw8oRBWSJgySXLs9eqHYkQx2TD7Ivle2b4i7xf0i3YotxyaodJKQ7k2uctWcjt
         1xI9WBUdz5iQBUDKgbHxdjVy4JvaE0SC85cff6HpHRjB7z9TQ61tBbMufKG29ARBx0eZ
         7PXZ1ltor/VuZB75l0m0eKxgNNsgkB6ZVA8JNcxHFeMFBT4YKxlbgzOMcmgLQ0Piyo3k
         lI3UIeobzioxRbqfnsN0xpfWSVnmCc6gHP4VRIdNHkKK6WG/sOQn+qRtvELNnq1cwlnh
         zqCw==
X-Gm-Message-State: AOJu0Yw1VdIQ7cbZOYZOt4XhNSVApVLDVRyL2lLk6ygFrbCFJSmwji2w
	EKMSR6ldoUltkvpMAUy3WTRrLiDqiK29PGe2pqJ8h656MDEKrWWdGO1MIpzeV7/VvJB5q2OEjjD
	BEF86ZsclCMcNhZo1fO2+kHQIkmbMBXMSK1/zHtqZmZctsoyjeV+SWyE=
X-Google-Smtp-Source: AGHT+IGeo0ts8ErA/iJfTbUAzZLMxhUavTGlxTDbIG8wiJwTZjCTTpSupySe9B8Nvg6/D3ejbQzrDhsr+X/K/FfJ4jE=
X-Received: by 2002:a05:622a:2d1:b0:458:1d2b:35f6 with SMTP id
 d75a77b69052e-45860830c6cmr6505461cf.24.1726241939417; Fri, 13 Sep 2024
 08:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-13-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-13-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 08:38:47 -0700
Message-ID: <CAHS8izNTgbf-654fB84Wiz1kgA4z5HoicDm_MuGS_72561AnuA@mail.gmail.com>
Subject: Re: [PATCH net-next 12/13] selftests: ncdevmem: Move ncdevmem under drivers/net
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> This is where all the tests that depend on the HW functionality live in

Is this true? My impression is that selftests/net verifies core
functionality and drivers/net verifies more lower level driver
(specific?) functionality. There are tests in selftests/net that
depend on HW functionality, I think like bpf_offload.py.

devmem tcp in my mind is primarily a core functionality and a lot of
effort was put into making the driver bits of it as minimal as
possible. Is there a need to move it or is this preference?

--=20
Thanks,
Mina

