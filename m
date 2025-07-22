Return-Path: <netdev+bounces-208979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D05B0DECF
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25A0188B4A1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B32EAB7F;
	Tue, 22 Jul 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmTo9Dfo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4C2EAB73;
	Tue, 22 Jul 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194812; cv=none; b=kte7CPgKUAN5HPB9gwX1u7LZXYE7wvNF1BBLgR61eEWeBuxr0+07OcoxshILDnn83OVaGWGbthSIZzWtdyuucCeMIOPHVY0kaRwCxcKorzfOnTlgxt1X4RH5eHFUwL0BNZd8ManqWZrzGSlEklmtRx59gFXfnOlwJPW/bZqRvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194812; c=relaxed/simple;
	bh=tg4VqS6DhsLEd4nvvuTajQHN/FDEA8gApPFxhYX5nR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3dsiU+/Pr8GoBDy1OmU3ac5PxK4xB4DCGMEulkPec4ZgUpIBovdL2Riq5V+Mphf8yw2sApDd6+mRR6cjAxCUgrqSVy4MBURp6nF7H4sFCZXkP9aFbz4ADxfrSqD493Oj9yCCnOit9pB2JGFmBFT9lxylugb2z6SPHjT+7dG/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmTo9Dfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9361EC4CEF5;
	Tue, 22 Jul 2025 14:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753194812;
	bh=tg4VqS6DhsLEd4nvvuTajQHN/FDEA8gApPFxhYX5nR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fmTo9DfoABPjDU7wn78XHEanzZoKjmimu4gX86Jif6MSxjpIjOqqDHhkPDuUumJYe
	 BaK94hWoI0D9NwxG0dWADLssOmJFsYB10ktCRZ1JT4AfbBOhqngqg1/Y3xIYui9IGU
	 RgZ0FlMH9OzcrDnpi3AhtgDLqls7QEI7CG8xl74jfSO0AIWQmEIxmTcKiWUXp+KKcP
	 DalIPcVb30w8WMKOzqGY7+v7KlNr3kFrAJVUcuZjN6FWGMxpz4B33WrFS+P+pgWzjn
	 nRSpItUA1qmp1x62eHhiGtGs2tcX7CLgk+3k5zAEb9PdxpXXMofV9LgE+uV96K0u0D
	 7ZcSXgTQQJyXQ==
Date: Tue, 22 Jul 2025 07:33:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, sdf@fomichev.me, kuniyu@google.com,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in
 dev_qdisc_change_tx_queue_len()
Message-ID: <20250722073330.5bf59b6d@kernel.org>
In-Reply-To: <CAO9wTFhghrrzH2ysTiBqNrZ1dbb001Y6rWYiKRTC2R8PBm-Zog@mail.gmail.com>
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
	<20250722063659.3a439879@kernel.org>
	<CAO9wTFhghrrzH2ysTiBqNrZ1dbb001Y6rWYiKRTC2R8PBm-Zog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 19:26:01 +0530 Suchit K wrote:
> I'm sorry for the oversight. I'll send a v2 patch shortly to fix it.

Please note that in networking we ask that new versions of patches not
be resubmitted within 24h of previous posting:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

> In the meantime, could you please give me some insights on testing
> this change? Also, apart from the unsigned int blunder, does the
> overall approach look reasonable? I=E2=80=99d be grateful for any suggest=
ions
> or comments. Thank you.

Hopefully someone reviews before you repost, I didn't look further once
I noticed the static analysis warning.

