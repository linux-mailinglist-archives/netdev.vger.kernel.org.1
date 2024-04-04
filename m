Return-Path: <netdev+bounces-85044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5468991FC
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 01:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAC51C21A29
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FD13C805;
	Thu,  4 Apr 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="020UjXX8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4D13A41A
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272592; cv=none; b=tgZ69JLCZ43QY55QYdK6KsQ5QFV5gcuXk36FHvLIIiNMfeISJEtQDAAlhmRsYC49EkE3zouiNqXWeaN76P6cO+wKABBG4Vy7+ZDUDuGeSdUS50BPeJ6luPIVLIS8D0lppOiTw4SiBAslYXYzXSySOpiUSbbZwCU9+2yuH95S0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272592; c=relaxed/simple;
	bh=ZVqrIv3MDSsLdNpjcykyDt18AMWPbB/yOL4TFECNDUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clvApCfvfhkhiBW/blaERoTQa3Q/jh8oXyrRa9t0MncOI+O/qug5GmpQalIJP18MVZBkdqUKWI9EsHx4+mRtV1uUAIVeNoTfpV7P/IQ8ujmwDGWSbWWhVH/Lk91kvUlEnLEIDakyPO93nc5BCK01DXeXz46buE6NRIcYET5GUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=020UjXX8; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so1551887276.2
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712272589; x=1712877389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVqrIv3MDSsLdNpjcykyDt18AMWPbB/yOL4TFECNDUc=;
        b=020UjXX8TCmz4YfWnIeYflzYU6Au5dDVpnprciHxX8T4becXUZ8Mya0cjXTlCrIWlZ
         IErzPEFwcbfNrqDhi85D/iQWmhAt0R7Y9P5DjkcG0tXVjOp7k8iItZass53bJlExkSiA
         CC2ZJUeB+goe0dxUXRZy/XpMHQdYnYYAOfQ9hpZ5FGOc6iFkGdjTizaiCnG7l85jpiOY
         wz0cIYkhXeJs9t6VyYCNJtbZ4oHWmE7xExrBH5hsEte01bhepkeOzzRZIugcX/uNH2/X
         U0TPNQxhSBV2Va4/Oo6yFFVFwxOHbtH589F43cTsZWzOvSWMpG/I1EmB3f492FgreVUx
         Aufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712272589; x=1712877389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVqrIv3MDSsLdNpjcykyDt18AMWPbB/yOL4TFECNDUc=;
        b=K7YKEljz/rmgtILdrKhzH4PKXiu5TYGk7MPgP1n6aS/M/ZnnxvM63eTsIMrnynEvTf
         nu8yz/k6FWl8UWFNyTGL0rfOFsU7t78B3xzu0XrPspTIx4gplL0Pr/cPrTnmDemIh2RN
         cdbuiwhNChkVzY3NAhRYfm4RLJA3NIdL8pK1UzY5oHczcQmAvxngjj1BgrBxs39hw4Zo
         CsIRaawNzqwzZprkoHRYOQk4BuM3m4U04kXsSBEqpWFd5UJ7PeuBWq5ssY0c9lPN8SGD
         /L23UyIpIBKiBY7+qXQ60l8+HX64efX+wdBU0KM6KE18yrUb3GYB5ONr6nhfyAUuX2rp
         uy2Q==
X-Gm-Message-State: AOJu0YwqRsJ5MZ7T137x9dLjqMl8D/1CnEgBGc6zGaYBoLkJUKcmuX+G
	JWbrM55hVrSqjar5rimvlingYk5rtyPkBwJYMAjrbId6igMVBM70hB+fPG2aYOLVOiq8r9EgF+Q
	ZHvK0D5VUb4rN6OUSEzBtcY9aPv7ame4rrETH
X-Google-Smtp-Source: AGHT+IGLyhdWdwtXPnNQ9QdcPsZ3gr3TztSWBZCu5HQda6NQNZ3TPxhzjrVD9iMwo3YAnZ4H3AzzroJJwYBu9egTMvc=
X-Received: by 2002:a5b:148:0:b0:dcc:8f97:4c42 with SMTP id
 c8-20020a5b0148000000b00dcc8f974c42mr3911903ybp.13.1712272589343; Thu, 04 Apr
 2024 16:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122338.372945-1-jhs@mojatatu.com> <20240404122338.372945-15-jhs@mojatatu.com>
 <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
 <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com> <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
In-Reply-To: <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Apr 2024 19:16:18 -0400
Message-ID: <CAM0EoMn6Nyu5AKgSERZEtSojvzKN6r7enc7t313G9xBvq-bcog@mail.gmail.com>
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, victor@mojatatu.com, 
	Pedro Tammela <pctammela@mojatatu.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 3:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > We will use ebpf/xdp/kfuncs whenever they make sense to us.
>
> In such case my Nack stands even if you drop this patch.

We are not changing any ebpf code. I must have missed the memo that
stated you can control how people write or use ebpf.
The situation is this: Anybody can write kfuncs today. They can put
them in kernel modules - i am sure you designed it with that intent.
So what exactly are you objecting to that is ebpf related here?

cheers,
jamal

