Return-Path: <netdev+bounces-141043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BC69B9363
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D730BB222AA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609331A0721;
	Fri,  1 Nov 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQMPLew7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D145179A7
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471794; cv=none; b=P5MMtQgoRSmmTvluUTQafEwKfuws1Oe4eklChKY6OIN9pJxScb087F9MjsQLPNnXnPmSeV8YexB6+dgfyrpZIPvXIT8jF9TzHl3Is9M48JEyfwcKBePTQFmyhJnxgooyJvgfv4E5RK+9aYdMVOpctL/XOnzJeRB5BmR9AjfD408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471794; c=relaxed/simple;
	bh=d6NX3T56VtGNY6geWRG4/CgyC67jTJ5kr0WPz+wnEVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URlsxChbt4sj7+IrsogG0D0u9d7SJHCSKIsydQb039zQLBxed5A+XZz/nHwJTciCRGvMgWeeDT/txtve8dNTkaUEwm2mt/sUP096Y2pBFp3sUdgmfivW3QpZt0Z0XdzWnS8SOm1GeBzGF3TLZ6T+5dJl23kjCteRLJOxZZBrUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQMPLew7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460a8d1a9b7so145351cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730471791; x=1731076591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6NX3T56VtGNY6geWRG4/CgyC67jTJ5kr0WPz+wnEVM=;
        b=CQMPLew7zQptENUvwXAhY2z1eVFe23eUDIhnUd1dV3y0nnkJ+5BFzir/7Rmx1Ls/E2
         bv1feivQXTH6Fwp1eJb8xZ/TM/XaW1PvJGzQEy6XVthKweguIYGC6bF4UATkSb8pSlCv
         zvGaZJzbULtZxbcEf5FwCw4Jl0MX4kdoWOsTbbrZlgqS4N4H5GBiQlqdIYgmvcrPJhH3
         oeAES14x2UDH+GhtxeufJyNeBBSurr33UndicSwe7mO5OQZyLA0i2DIaNkzDXZp6HLj5
         xqLgEm/WgOjR0KysVT7P8/alh+f9H3spzu2nchA0MYQs0ejIXa2wex4cTsDbb4n3b+w8
         Mxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471791; x=1731076591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6NX3T56VtGNY6geWRG4/CgyC67jTJ5kr0WPz+wnEVM=;
        b=ARMzv1YA8fnxZNWknPhIMTsmuBcIGu8DqEzKZLjwL0YXNtbG6KPTx7nU9xtJbrcKvX
         vbDLB1EQGsQRgvdvEBNKPuRdBw7axIvzSbZcZpBe0xGd0UXMiPB5p1IP2a7/goM+hfki
         AdeH+zdYAOzrlJGtnsxoltFL13goV3GtB3mrF8amZF++nt+JGIHENktV/5Q7Lt7WOJFD
         OUe1sFZqPLabN1ONZk3hZkJitdk8o5C4FDy6XaMU/lLJfyiQ5Otd1ScRufiyTNcSNrtx
         +xRdLS7kXpjO/RXP17B2L3qPTU6ljeAo6GJF43oC0LxLG2yAkG5Be/wdRgEk4qS5iTEc
         QRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgN9B1MNVfSXZHsQMTmLlczCdAXnl+fdYsjcfVX2p+11zKg2kJqs/3vQUnDAWPFpfA/KXhb68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRyJTacz/x1K6IkuR2Crf0tvAGz7J8tEGnjC6szLpEJDcwy0M
	nDnRfneJXSgHuxK9hVx095EMnUOtLF6B64sI1YrfDdYR5EPDFRC3iKHLxjaVFnrs/vr7sufs4WF
	GpYH9Bqcr3fY0+w2j3Iay3rLeBb78efDy80Z+
X-Gm-Gg: ASbGncsHi9CTS5D5JopyoYUv7Q7z9udlY8skrieM3CvkYPc7TlZjAE7lxG1YvE5KZYa
	STUlpjzga085X5n8S1vV0wpHFD/y+95s=
X-Google-Smtp-Source: AGHT+IHgDS6evVoXDLElKeR+nHSLejpXhNgU/IwCa1d74G4/285uIsXlk/PgeDqpBQb1bOc1plRErbGPcgqPv5xItT8=
X-Received: by 2002:a05:622a:1989:b0:460:e7fa:cf2 with SMTP id
 d75a77b69052e-462ad20fb0amr5183651cf.23.1730471791231; Fri, 01 Nov 2024
 07:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-8-ap420073@gmail.com>
In-Reply-To: <20241022162359.2713094-8-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 07:36:19 -0700
Message-ID: <CAHS8izPEBze7JK1Jq+sdcjAAQmiCxi1=z7Ec_xFp7+3p=pQHyg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 7/8] net: netmem: add netmem_is_pfmemalloc()
 helper function
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
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

On Tue, Oct 22, 2024 at 9:25=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> The netmem_is_pfmemalloc() is a netmem version of page_is_pfmemalloc().
>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

