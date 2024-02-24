Return-Path: <netdev+bounces-74646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596A862115
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678471C226E7
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8786645;
	Sat, 24 Feb 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2nvya46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614E639
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733603; cv=none; b=dgEsMN/vm9WWJaWXGVH8r9otvBxb9BJoUr+FqGpLUlyLaTQWL5N48LtVHDYnxoXD5KlaBElqAO31uR2O5/ZiiYKXEGz3KUR8adnD/h6VBWOPOptIOevQ00APOlQb+2V/ATqOrNKZEpvPRAKDotc8ZiPiwjwHqs+BCSiU54BW8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733603; c=relaxed/simple;
	bh=txwqgqlKhx3BI9LEfqWegedjwXCUsBBp96rmLgTk4Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPQNF8GsAqWoGbAvAhThPqJdu5Ay8xdqq2XPeGW0ChuF9/JSeT0bRtoLuZvBlGzaAAwGmlRZKh4ETsk7fMR6DfEwsNO/6ErySyNpQb1Fr+AD2CttSI/wZBMGlrcysppd3fVWMRUX3lIbjAKNSjYZj1odhY/kZvaAlrgWZQtOfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2nvya46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3512C433C7;
	Sat, 24 Feb 2024 00:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708733603;
	bh=txwqgqlKhx3BI9LEfqWegedjwXCUsBBp96rmLgTk4Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l2nvya46FwkJ1sCRTwbI+Ql3nsftYmpmacccy3JAG+4aZcwLNGmaxOlSbC4XPiWbA
	 UxoQvmKN6OiWwo61doynI9SiFTBpWhsQvu8pt7ox8M+nytxn2urRxOL74d8KZF7Q7F
	 EIQgu+ctyy6aCzchLPwUNkHhdqTAKnhk4IPpVghGdr3kZH8UILK4uMNpn+Ifi1t0GR
	 oTNdwS2OywSdS8beHPZ7J1f155hj9bKXtxF3LAdIqDzfCzg/6GUoQZGGskO8rC8PSd
	 eKstUT6MocTvKuwH4IFmlgEXWTik4cw/0YoY3H5pvyY7pu2yH5puHq8b75bqcArGN7
	 +nWqLtz5Mojww==
Date: Fri, 23 Feb 2024 16:13:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
 <michael.chan@broadcom.com>
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240223161322.32c645e9@kernel.org>
In-Reply-To: <de03710a-8409-49c6-bc62-c49e8291cb73@intel.com>
References: <20240222223629.158254-1-kuba@kernel.org>
	<20240222223629.158254-2-kuba@kernel.org>
	<e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
	<20240222174407.5949cf90@kernel.org>
	<de03710a-8409-49c6-bc62-c49e8291cb73@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 12:51:51 -0800 Nambiar, Amritha wrote:
> So I understand splitting a netdev object into component queues, but do 
> you have anything in mind WRT to splitting a queue, what could be the 
> components for a queue object?

HW vs SW stats was something that come to mind when I was writing 
the code. More speculatively speaking - there could also be queues
fed from multiple buffer pool, so split per buffer pool could maybe
one day make some sense?

