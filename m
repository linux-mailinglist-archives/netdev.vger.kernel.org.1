Return-Path: <netdev+bounces-95426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849918C237B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFEF1C23423
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D770171655;
	Fri, 10 May 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM5MRwDl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66973770E7;
	Fri, 10 May 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340480; cv=none; b=QacBam47zVRmnOJRAo+rkucXf0BHt4tcdeuYEH4goJ+7XwCsiSyTTY6p2EWxXGYgKhN9yURTvg2FE2peHbgAlnFXDeZ6z5TTJkmfEQycMMo+4+UDuhiKW8mi1JO37oGvAkTHMbI10krNO9rNhiJTwKbV265BH2Iowqd/UjcEHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340480; c=relaxed/simple;
	bh=JsrPHRAIAevdEApv5c1zHj9T0SIIsjgV7KEUWebPyjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZgKSAWdMpsbZRjlYC1awf3mhNouEV5WrvUcGuPCc9GLvNZG31Atf7Um/d4Q8sGiCtfZtGaovnFhkrHgL6Uxx3YkqJvzcyKEABcXLPyXROhMz5NoQzlieaugR7HbbLX11HMkwHL3QaaPiTE9/164EHjqChgi/1+7LBf9I3tKEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM5MRwDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F6C32781;
	Fri, 10 May 2024 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340480;
	bh=JsrPHRAIAevdEApv5c1zHj9T0SIIsjgV7KEUWebPyjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PM5MRwDl9hnTlPnV+AK+eTG4AQOUkjvqZMylV7oNarhrcp2Idwv8eJrRZzBH7rBo1
	 e6zYbF1IxlRdmMc6J+fcGtS+LsEsturG7+e9X3uz+1ZrDA3PjmalpvdLKrGnLZz99K
	 fCo12MrbzQpdTnY0Hd7ZhA+UPW+jmlZldrblmtBHPlGVZ782NCJBPeI3UyXgD9wXtD
	 1FuSw8jy75SMGwSbk8Y0ucn+72ZhXWjuiwCfQhrmADag99+YONs8EKLcAvUimBIUlL
	 +lZRoUkDMkzLL+8Fc/j/Is2JsDXiAbq/Vw6rUTBPYHBYU3PYaA7C8pe16Nkj56Nls/
	 3ts1tj7er+ylA==
Date: Fri, 10 May 2024 12:27:54 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 05/14] net: qede: use extack in
 qede_flow_parse_v4_common()
Message-ID: <20240510112754.GH2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-6-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-6-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:53PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_v4_common() to take extack,
> and drop the edev argument.
> 
> Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.
> 
> Pass extack in calls to qede_flow_parse_ports() and
> qede_set_v4_tuple_to_profile().
> 
> In calls to qede_flow_parse_v4_common(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


