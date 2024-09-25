Return-Path: <netdev+bounces-129855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C89867AB
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C922830E3
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1B13C9C7;
	Wed, 25 Sep 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6rsU5vN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2581D5AD4;
	Wed, 25 Sep 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296409; cv=none; b=cTAuka6XUYYnYeiBNfJTMkK6YxIJrC5cGGRk7HuX02KSg7xFaUUB5DEVtzflm1P4EwWvnFxIx/NYyjDsKIhyDoLnAQaSJfG9LSk+HGdsCHrhYkROrTllIi58SCFpz9n+7QA6MpUxZVuRSj7YN5iK9KZeE9/Fd59iiKHFRlVDXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296409; c=relaxed/simple;
	bh=HpgSrmqNuDOQLEzuojrRHnUCwj/9yjSRpB04a5p19zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbq/1UtlfgdTS0o36KDuQZooWS+hjkmcKPt3yAdOAjQvpIu+r163AWQ/bESfL4xjv9XFSafMNlQlSBvxmAvfNGkeXv3wctagdVuFZd+Scon0XkG1K5ZLbg4y5xXoUz6SxvxK1Ymb53nqdF1l/+x3s8F9P2wjtV83PedwImVN2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6rsU5vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E42C4CEC3;
	Wed, 25 Sep 2024 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727296408;
	bh=HpgSrmqNuDOQLEzuojrRHnUCwj/9yjSRpB04a5p19zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6rsU5vNunQbKbHiwSIhfS/0dN/TFPzyOuoYk6PkqV7PciY4Vf2tMtAQwUbPAb2ZU
	 l+i31N/TOL72jBcWPDA9RdRjOBUEdEuab6ThRn9JZo/J5n+wIj/CXd7lu0TAF0rcvY
	 gC6vzfdJGYm6F0dykUKOlffU3njiuFH3Spvo69DufOpxYHMGxmpt0Nd5WSjcbDllo8
	 fCRsQh1E3flPt0Z3LTfLwZaDCAEEdthZwaI9k5lg0s2TrMa5IIuNd73tiMiC+43fe+
	 ZJ8zxHyWtn9EshrF3Zzjoo0rx8d0A9ej1EKZLt00nWlk+nppG+CvzPHbgevu5PiOz/
	 RDcySfNrJNqzQ==
Date: Wed, 25 Sep 2024 21:33:24 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
Message-ID: <20240925203324.GD4029621@kernel.org>
References: <20240925180017.82891-1-jdamato@fastly.com>
 <20240925180017.82891-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925180017.82891-2-jdamato@fastly.com>

On Wed, Sep 25, 2024 at 06:00:17PM +0000, Joe Damato wrote:
> The sizeof(struct napi_struct) can change. Don't hardcode the size to
> 400 bytes and instead use "sizeof(struct napi_struct)".
> 
> While fixing this, also move other calculations into compile time
> defines.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Simon Horman <horms@kernel.org>

