Return-Path: <netdev+bounces-189027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD592AAFF27
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A963A5A14
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2B26FD88;
	Thu,  8 May 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mUvuZXlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495F1D416E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717882; cv=none; b=Uyg90sXWF+2szMsucXJzXgrDDYpvuHysFnCudtp88o9vD2nsY023QkBQBzs7IXSRf7HmKX2twHjCVmfd/pz2G1t0ikTStMZwui46E0AAUcInMcx0aUEN2qwxoCBx3Uh2zL4QE2OWS6BE4ECNsJlytb805LKTBYi1xHuS74w5LBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717882; c=relaxed/simple;
	bh=rzJWcF73xdZvu9VqTSaN63XDAlkcDD0MXDP12XxNYHI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTi3sgTskfY2dfKps8O6qZZYntAc/1EGKhYPJpoW8sy6o9OqfFRk653gI5nnRLKNKPkLhtzhswgl2FNWh8F6LS/Jh3mjl9UK9/pUl5d29wfX+HrqZnpyFL+1Q54e5KubKVi0zusXiWjIL++5cSeaI/WMf934oKVspV+d8f4PW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mUvuZXlJ; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1746717865; x=1746977065;
	bh=rzJWcF73xdZvu9VqTSaN63XDAlkcDD0MXDP12XxNYHI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mUvuZXlJ1pkUGI/cCbGDaqXz8BSiAqkbrW5e6A9mZy+SCuPffFLfPuIIDOyYtJzwX
	 V4KsBRElBd2e2ydKvbXwfrFVYJ8XQJWru0O8X3sZ9791nko5xhRv/JwWjYGbK/AYnW
	 deKPxQNFVYbI092vCgBQ70tweZaTAwRKXvEQmFRk524+UdlqYaE37Tafukk+ZKNiOb
	 WteIoeGFHaOkYgVTPw8kQvN5z4q9wai9FsUcNmmRjdh8DIBDAxX9LDw/ogIHGCCWYu
	 cf232McSMfse3U5Sx6MrezfoAwHoYogA3oDhD0y62oAoQPVI0CVchBP9h1hwavC2ce
	 FcV1Ja9J+sPKQ==
Date: Thu, 08 May 2025 15:24:20 +0000
To: Paolo Abeni <pabeni@redhat.com>
From: Will <willsroot@protonmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com, savy@syst3mfailure.io
Subject: Re: [Patch net v2 1/2] net_sched: Flush gso_skb list too during ->change()
Message-ID: <jnzuuJvnV58HQxA8uObgyA-i8S3SMErwTRxyALErLROzV2S8lyIOaL66hUvgEFR-GkDrnGrNvdbif5vRuXuRxNbDwNPsnGfKtEOEdPaLRPA=@protonmail.com>
In-Reply-To: <9ad2d46f-7746-45e3-b5c3-e53d079d1b8e@redhat.com>
References: <20250507043559.130022-1-xiyou.wangcong@gmail.com> <20250507043559.130022-2-xiyou.wangcong@gmail.com> <9ad2d46f-7746-45e3-b5c3-e53d079d1b8e@redhat.com>
Feedback-ID: 25491499:user:proton
X-Pm-Message-ID: 0454ea216e8c5844e8eef8f263cbf4d18d9401f8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, May 8th, 2025 at 10:26 AM, Paolo Abeni <pabeni@redhat.com> wro=
te:

> LGTM, but it would be great if any of the reporters could explicitly
> test it.

Just tested with the original PoC, and it does not trigger any bug symptoms=
 with the patch applied.

Best,
Will


