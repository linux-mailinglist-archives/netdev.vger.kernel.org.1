Return-Path: <netdev+bounces-89292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A38A9EEA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962B8B2368E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112AA16F85C;
	Thu, 18 Apr 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcT6d1KT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9116F855;
	Thu, 18 Apr 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455209; cv=none; b=HYAzcQgPjVyKlU4dxap2AOd1ZvC3QRfVSo4tQ2II12AGbK+yM52tj5ipla7ggMUc5RTFqk/v8M4gufLwyFXNt/eTZEwEaf8w9RfwBWDQJaCJVtJAwjqpGktZnrRmheC1gSOS+TZTeZGA2KLqu2TTtDNYoGXs21J/DVjX1acnpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455209; c=relaxed/simple;
	bh=verQNNpe340ndgNeK05Wz0xIjEug33vCQbOW6oRZGxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLSDR/kj+6SEwp8o1mLu0N6aaukRBGM2gutVBh5R8I77qFEN5/xPeEgfHTvvyk0vx53MfjDt9o3vlvVXCTJOrLaPzRm/2CIAloUWXBvXCN7DbkrLC3+xLF4QYztOfGTtzRtCErqSyvnNI4h+3HZCjBghY+Fb2c6mCgbunYo+XQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcT6d1KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE6C32783;
	Thu, 18 Apr 2024 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713455208;
	bh=verQNNpe340ndgNeK05Wz0xIjEug33vCQbOW6oRZGxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QcT6d1KTjOKeLFBLwVPM/bZbFSdxdbXNirDN7fa7fx3MrAzgDpfp2RfJ7cEzjak0v
	 3+IDFLXN6W39mLdPYM1QpEqdtOrHlsjvjaoYZC0eERMC1WEHxux87Jp3ec8ce9duuz
	 v2VCfkzCuxzdmUmf6T8M+n+/WhGdj2hhJTCrwWKgKS+EaItPlqYoFMYfmLk5MVn9CG
	 mp1XCHDClsibGTR43GfnYH+BWnxBWRMOvMM5pwEspmTsPqTfUIYAMHsv4znDQDVySx
	 0FbxucJVMaNBnVxl03IErtOcR5wBZ5ALxp5o8lHHuZHRYwLjN6lbwQiN8ioauhOBZi
	 Q3q4bsTvXMirw==
Date: Thu, 18 Apr 2024 08:46:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to
 detect
Message-ID: <20240418084646.68713c42@kernel.org>
In-Reply-To: <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
	<CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> I'm not sure why the patch series has been changed to 'Changes
> Requested', until now I don't think I need to change something.
> 
> Should I repost this series (keeping the v6 tag) and then wait for
> more comments?

If Eric doesn't like it - it's not getting merged.

