Return-Path: <netdev+bounces-84067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD279895693
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96773283091
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301ED8662B;
	Tue,  2 Apr 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCFwJB0b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A786268;
	Tue,  2 Apr 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068050; cv=none; b=ktGx2OlBIrIhNGh1pSOAkXc3GJ4F4EqWtSe1YL98AceBK1kKNPJwSWcV+mUg2EMxmXQuuB2Cgo0BsVRymxLH1lJ1X3fwr+2yj4ozUvKK9DLyt1Nay0KiyuoWHp+lJDiX64KXL1u/Q0VGnV2ffHvMtEC3R2FzbAAXWF0OSZTsLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068050; c=relaxed/simple;
	bh=IzdgC28MCw382UmcvE80JbhG7kFhsjaPi3qZble+/xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u2T1MZYxgY6uW6LWYIGnQJ/anz0RzI6NAbRTEC+OxAqVLQ3+E8SCIzA8gQcatWX887ccMHL6eiW7gGNWv8a7T8U8d278wM7jgn9tje7bT0TGTO8K/h4vjYbXczFBLmwMrWixzIQRWwqpKy3n3qiRPseGyyR2coYgkTERHE1sGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCFwJB0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC12C433F1;
	Tue,  2 Apr 2024 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068049;
	bh=IzdgC28MCw382UmcvE80JbhG7kFhsjaPi3qZble+/xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YCFwJB0bPOnFodPVyWzYmgybAvddl2vQVOuciUH3pi/+hSrYYoNIOb05ZCfIA9B36
	 rLgIbNX0aBjC2m78e9ccK+8WIspvxrLd41yAwLXT501ap4yHAnUmQWHxnwcAN7HPVc
	 +YN8MyH0ay8Y6tedjiayxHUSiKv3tC4vTaRK9aae5/EQs9rt34aPFjL/DJmxjO7x0V
	 zZMo58NzYH//7jm0o4kcv9wfaxAO3qnq1KViwPQkZAXMfp7eWQs1pQb8kwV/HqlALS
	 N0bUDRfQldmpy0pPEzraCWp54To21/iNs0UNDfqDvK3sbHbWO06f2Qpkzm9z2JQDJO
	 hh40dD82AO4iA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Manu Bretelle
 <chantr4@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
In-Reply-To: <20240328124916.293173-3-pulehui@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
Date: Tue, 02 Apr 2024 16:27:26 +0200
Message-ID: <878r1vrga9.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> This patch relaxes the restrictions on the Zbb instructions. The hardware
> is capable of recognizing the Zbb instructions independently, eliminating
> the need for reliance on kernel compile configurations.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Should this patch really be part of this series?


Bj=C3=B6rn

