Return-Path: <netdev+bounces-145357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E69CF3D7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B1BB2B033
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E11D89E9;
	Fri, 15 Nov 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3aWY8wm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDA1D5CD4;
	Fri, 15 Nov 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693948; cv=none; b=mjXJEisiP9YDa3RWj1v1tmO/g9h15zXl1Rq5GKbQKWXUUJCIN4fYTiETPP2dXHCjaX2a1gQTEyXLp0DBnCrDzgznWRf+Q30HfFOrgzkHkUZ823045L2yK/P2hniEJRR0EIGg7PK6buJw2Az3fBhGGjZ2nIC29ctYnT288493+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693948; c=relaxed/simple;
	bh=v+CYDKmSiATr2GvrAIRyc2ehUQtag0okb8Z47fVWIGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/lwBKZFgcEWrW4MaPLlONUj7cdHwR8nxw0yMGey+6AmmGs16KCyD3IsQ5vECavIfcRt23YYbpRDOyrGXKgun3EOTs+wKt/3k1IfnCOlA8NIE5kEEgo5nwJ3+nPMsLOzA1WXgKBBHT9jlYm3x5nScwkslRmU1VgCnCJ56GugNqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3aWY8wm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so150940566b.1;
        Fri, 15 Nov 2024 10:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731693945; x=1732298745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGFiUKAozU3ZYlaKNxg6TSLdRyFWb+v2eqMgR2BUfeE=;
        b=A3aWY8wmkKvyyemZpSNR5MKuPFvpoWLz4rw/Qsoe+mlfBbvKqshbi3y/k2ZV8zycjD
         Ab5I3b4/Sx24/9OEjejR6r+p8gCIsP6l6+nu5clzOdFadh9CIPFTgNPKk3J0Z38YYPo2
         +p7Q0OJ04xgJ+L4mfmXES+6P6Qp6svgVzl9lMrD7iu2xGbyqIwu1SGCZqe00ecvhHh/h
         6/H1FBYuyjxLY+MjXZOAZqupFMSvIuDa6C3ZVPxtBSs/AOcc+2NxSfbuz+oFUdVmQV6Y
         Mfl99eqNj/RGtjlQyh2gcTxUz9H2c4A7iqNUO6cg1HKIBBUd8qst3S7qlpBSEtxCGXxY
         BCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693945; x=1732298745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGFiUKAozU3ZYlaKNxg6TSLdRyFWb+v2eqMgR2BUfeE=;
        b=GrWwnteNxrnWXkTKH3bq0q9mfdkbGS4hEPLTQUlD7kuUvomBnJR1BtEjPaj1w0lBu+
         EovtUhQ47eTBE2Ytoc6DEAlX6IMiZwZWuKVkqvy76EfDIT9b735AK/CbM6JRelVtSMJA
         9OiiLCd+KcBbEDBd0r6Maepk3LgtoFG9mJmswVEa8Sky9r+gjWC3a9miZLpGtCTbv/DB
         W9ER80OzgmepbVEOmFcxq4yh6gKDcDvtLxvHm8cL1YCr85olS2YbvJHWTK6mUsWqSQb3
         mdnhLoDl+OU46OLmZ/Et7cULs/Cy1oIG4GbReWAGyhWMdkKhuQoASkIq8hRKcMKHL0P0
         Qybw==
X-Forwarded-Encrypted: i=1; AJvYcCVnjAvV7XoeXtQ65gIOeXizyF9K7VjH5o6hJZmL7Z9t8FAsAZ+8W3ej4C7tu0MO+ctj59rJ4osQCPk=@vger.kernel.org, AJvYcCWeukouvgIFtlZfhiJ4fvgy/+wQek3hswSRIefA3Ivzwx8hBBWhn0lUNA5FIZBecC+sZPQxWTI5@vger.kernel.org
X-Gm-Message-State: AOJu0YzdV+Owbr4ZM6yBXLBn6/zXS1zY+mNoMqPfq+ZajJBYrzonDskP
	z5dyNhcLiDfVkNlH8Py4oyzy3cPVSuz3FeRRoQQrQKGpj/CzIYxwPIBp6bkveFrEItGz1TzzSZb
	ca9a8qcnrVi8Y3kNzJjMgbNOo9A4=
X-Google-Smtp-Source: AGHT+IE0ELMRJoD8b88E6USCNqZxFEvmarsYK+xwQeoNpZLTLS8F4nzoLeT08JdWHj7IDYI/xS4MSYOmbQASqiGIF5o=
X-Received: by 2002:a17:907:3e1f:b0:a99:d782:2e2b with SMTP id
 a640c23a62f3a-aa4834543e4mr260647866b.30.1731693944679; Fri, 15 Nov 2024
 10:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-5-ap420073@gmail.com>
 <20241114202409.3f4f2611@kernel.org>
In-Reply-To: <20241114202409.3f4f2611@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 16 Nov 2024 03:05:33 +0900
Message-ID: <CAMArcTUfGp0SEm=w3dg=GHd52w4zw2kG7mGLsaP4b9NjTYMTrw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/7] net: ethtool: add support for configuring header-data-split-thresh
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review!

> On Wed, 13 Nov 2024 17:32:18 +0000 Taehee Yoo wrote:
> > +  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``      u32     threshold =
of
> > +                                                            header / d=
ata split
> > +  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX``  u32     max thresh=
old of
>
> nit: s/_HEADER_DATA_SPLIT_/_HDS_/ ;)
>
> We can explain in the text that HDS stands for header data split.
> Let's not bloat the code with 40+ character names...

I'm not familiar with the ynl, but I think there are some dependencies
between Documentation/netlink/spec/ethtool.yaml.
Because It seems to generate ethtool-user.c code automatically based
on ethtool.yaml spec. I think If we change this name to HDS, it need to
change ethtool spec form "header-data-split-thresh" to "hds-thresh" too.

However, I agree with changing ethtool option name from
"header-data-split-thresh" to "hds-thresh". So, If I understand correctly,
what about changing ethtool option name from "header-data-split-thresh"
to "hds-thresh"?

Thanks a lot!
Taehee Yoo

