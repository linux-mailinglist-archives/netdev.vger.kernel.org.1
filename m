Return-Path: <netdev+bounces-189366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2687AB1E75
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CFB1B6247E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5CD25E80C;
	Fri,  9 May 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGqAGjvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BF1E25F8;
	Fri,  9 May 2025 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746823419; cv=none; b=Ror12PQq3fPFZNnyqqVpcd2wKqUAZoPzKjoLGI05xmZrb7nubT/anKlS+NvRBLgXWD335yhXe48j1D/9e0drtedwErxz6iXcPwMt2E8PrMyDe/nMrbwN52dwgGii77Ay2fwKyw+UcHgFS8a0eqgugX9YdUr0dXQ71vOQ+xTh09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746823419; c=relaxed/simple;
	bh=0XAsUX5ht0LsSXepNIDSx20hhEAFQHU25ae0PIJFodI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/GHiyZezO49/PNEfkVdtjqNAgbRmwGBa22hFGMrmrMWUQC+TCjnbSx3gWrkdyNAbySo5ZuUvE5EDYM4ojChHrakRkxKRKM8MDNXseGInTb/Y/0Ghws0o7JMX3LudXm+e0O5WiCQRilR9iMENxH7Ni4I5qINEY/awf75Ks9fkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGqAGjvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A46AC4CEE4;
	Fri,  9 May 2025 20:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746823418;
	bh=0XAsUX5ht0LsSXepNIDSx20hhEAFQHU25ae0PIJFodI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGqAGjvt4cBpqUhzdpEd6UDskhK0I+5kWXq5CR9m/TeQWUUzWkyybo7ojUpZZzNoC
	 GODgWxEz1je657qZaeXRd2uisjicb3I7gWN+eWM7moC4py1qGqcy3RUGf0t91ZhumU
	 EZQ0PMYpUnwzG9Hta6zIPMDEI489vQDnOc73Er1+1YlJpZZs7NQPUT/7A55w/22B3g
	 5hhsNMnOHHPa6yXWlHcnT74/zdgbxl4IJU9vx64eWCHLjAIioY5VTJu6WcqPHvdYlR
	 nM2+hTmzyP04/ey+293WtF1ZBdiZXe3MVIQZxhB3AygWeA92YKeOa4eR54WmJSEbb/
	 yJRS+vrzLpD4w==
Date: Fri, 9 May 2025 21:43:34 +0100
From: Simon Horman <horms@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
Message-ID: <20250509204334.GT3339421@horms.kernel.org>
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508071901.135057-1-maimon.sagi@gmail.com>

On Thu, May 08, 2025 at 10:19:01AM +0300, Sagi Maimon wrote:
> The sysfs show/store operations could access uninitialized elements in
> the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
> dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_out,
> nr_sma) to track the actual number of initialized elements, capping the
> maximum at 4 for each array. The affected show/store functions are updated to
> respect these limits, preventing out-of-bounds access and ensuring safe
> array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Simon Horman:
>  - https://www.spinics.net/lists/netdev/msg1089986.html
> Changes since v1:
>  - Increase label buffer size from 8 to 16 bytes to prevent potential buffer
>    overflow warnings from GCC 14.2.0 during string formatting.

Reviewed-by: Simon Horman <horms@kernel.org>


