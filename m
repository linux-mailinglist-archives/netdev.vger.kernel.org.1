Return-Path: <netdev+bounces-65868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFB83C17B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB761F26169
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07745971;
	Thu, 25 Jan 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5zD5MhB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0784595C
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183941; cv=none; b=P0vJggi7DlYX+Hi7kzbl2liyUGVM+jplSgzL2L6D2qPtNoXg1nAjkt2vOJm/dLojs/j4oikeAVpB20rOJm8hFIQ44tzSori1kOgnlBr3ZKYqVpsvAz79FH/HDvcpTHPRobzbhJ4zsCkW8JMQFHyKdO/jiz9nDUdUFOmqQCMPdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183941; c=relaxed/simple;
	bh=Kz4bxwlKhxXeto10pI+42QcBi68jNaKp652CDggy7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A24ixMR6T8GOWcWwH+kH9WF92v5QdQaK3vYUvnJDnIhszJufqCd9xXHJMiw5rQ0imAWRkrgsYzGxGvbNPkZidGlfGA4edwO6ODIbYHoZ6iak+macZJf4UV+t36BBQzDlF5ko7icazdQMWc0rMHMmKf3cWJflnAtI0AWamaAbDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5zD5MhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806E8C433C7;
	Thu, 25 Jan 2024 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183940;
	bh=Kz4bxwlKhxXeto10pI+42QcBi68jNaKp652CDggy7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5zD5MhBkomlMDB4dGU4smJeVgfWJRSu/gi9MQj97Z5RmWDAwc1hcnWK8ESEZWhKB
	 gq1iFCzeniTisw06S62fdIaUxVpeFVBC1yn9FsxnZwZ9yU4I5SuaLLze8TKYUqiuTO
	 6lxyu4Xiejfl3r4POI35NRq4qyKhHOsN3tmdRakwYE6dItoG4EH64R+xAR1QRWJUgC
	 1NQBL9l/tGo7Uz2SeXWpDAgK+T0Zji7S5kTDjIvSlFbty1lf9XHks9m50fz7S0OM/9
	 mY4/orjpaBAsJEuJxRC2vIYSczqsoedRRgIpgMdifVgt/TtkXVB7Gj1xgLDi8l2LCj
	 lsci9IwMarZ+Q==
Date: Thu, 25 Jan 2024 11:58:56 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 iwl-next 1/3] igc: Use reverse xmas tree
Message-ID: <20240125115856.GJ217708@kernel.org>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-2-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124085532.58841-2-kurt@linutronix.de>

On Wed, Jan 24, 2024 at 09:55:30AM +0100, Kurt Kanzenbach wrote:
> Use reverse xmas tree coding style convention in igc_add_flex_filter().
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


