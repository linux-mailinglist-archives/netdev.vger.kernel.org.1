Return-Path: <netdev+bounces-77550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B304872299
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114CE1F220DF
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B31272A2;
	Tue,  5 Mar 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/xg4Rn/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5874683
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652216; cv=none; b=Fu/QlWMrYPF0rcHmOTtRf8kMBTBz70EHaOAD98WEvnGlCiS2LZG3SiWY2V+Qyca2bDYQqtpEAvW0I/T7kLN5BBOO9959KFwB2/NhDdsLTsyGPgSAwFaJJrGmoinoyLps/n06IL20Hzmg+qjwrOzivoDxRHBXywXlbfegXwCoBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652216; c=relaxed/simple;
	bh=7nVpYFxir/53x4SicgSI/QhTWhwrS0QMmdcn5eWqDWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1VqCEzd/rSfVF/tLyxAvr1ppcsfYSanpAzVg+A4VNboGcm6i8HDEJKVbEr3jbMA0XwrUD4PZiiamMmDoWiNEdRzd3hmWIyabLwr95ErQIQ3f6XP3Pu6/yLz0nwPsAyq5rkJU+GjKVp5PSLUQYDSNsSEvl6nimvvM+UiJBdtoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/xg4Rn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671CDC433C7;
	Tue,  5 Mar 2024 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709652215;
	bh=7nVpYFxir/53x4SicgSI/QhTWhwrS0QMmdcn5eWqDWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/xg4Rn/m5Ci5Z9bt59m1Ze+/TGJqbGeOywzUo0/ASbkSpMYUGx62oaKXZWRvUGaK
	 W0pKMHwtKZpT4zer4Dpv8BLtKd4U0fBRZ7DSULE4yBEX67YUcXGzOixxWqoPKPpq97
	 4XlJmMzbAEtXnZ1+RiBCc4wfSfwNurI6Xd4WvuHzb7c9rs4p/YS0L6RmEugLyNHuLL
	 E2J+geCERv5j09Q08PKJDaGpzGCHMr6+ZEuIFCo1l/Kc+YSAkheomPCrwCtoaBYbxl
	 SDBqwYP74NRFNVN9Ul3rMczFDUlwX+ld1L89jwNYy9euhTCZm9Vpls4ZMltBFrRUro
	 W/2XngkLLC6EQ==
Date: Tue, 5 Mar 2024 07:23:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for
 backlog NAPI.
Message-ID: <20240305072334.59819960@kernel.org>
In-Reply-To: <20240305103530.FEVh-64E@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
	<20240228121000.526645-3-bigeasy@linutronix.de>
	<c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
	<20240305103530.FEVh-64E@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 11:35:30 +0100 Sebastian Andrzej Siewior wrote:
> I had RH benchmarking this and based on their 25Gbe and 50Gbe NICs and
> the results look good. If anything it looked a bit better with this on
> the 50Gbe NICs but since those NICs have RSS=E2=80=A6

TBH if y'all tested this with iperf that's pretty meaningless.
The concern is not as much throughput on an idle system as it=20
is the fact that we involve scheduler with it's heuristics
for every NAPI run.
But I recognize that your access to production workloads may=20
be limited and you did more than most, so =F0=9F=A4=B7=EF=B8=8F

