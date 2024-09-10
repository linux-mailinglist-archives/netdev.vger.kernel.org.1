Return-Path: <netdev+bounces-126878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBA972C34
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90501C2407D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2C183CB0;
	Tue, 10 Sep 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIxG2lfO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDC17BB07
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957255; cv=none; b=R8CUzAHIJFREU7T+8y0IX/AdPOomqrVdKqsrFYWfDA6PV/8NMcH2JCq6amFsLw+De9GYfqKsuTAE+WyZVi/4fk6ZJ2wBhQj687+T4kQezCtZ6zQQ11zPsC7gSa2GvHtqCOxMgLk3HEeLolHrWR1TJ+BBRycchqUPEUyg1YR2CgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957255; c=relaxed/simple;
	bh=BSXsdp7msCenF/CWNtIkMl3yyuVcWn29TcloTmediZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbytbCAiWlLoFa7lsnbr7kUSwvYXesSYxPj7u1FayBIl/8ceIV9rda5Rwq9Z8wrT1+BR85ZH0kGmRgAbl6giHfAECtmciRgC266dVQwNm36DBY6ut29mQpr4scNzU/i8nCbBZv4OdF7i3J/lSurXfMqX8UlQN93nAsmOw73eTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIxG2lfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0EDC4CEC3;
	Tue, 10 Sep 2024 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725957254;
	bh=BSXsdp7msCenF/CWNtIkMl3yyuVcWn29TcloTmediZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIxG2lfOXs4zTextmvtoQbSVQ7BttJllZMAfMlDffSOONiwoezxGmfIqjEvr6L8OG
	 Ez0uiRjtU/itIRxkb4cp5hxPWXN1jhOFeVvybK/2qh8v6ODp8m642cwhB+1YwSb00n
	 Nx3Xka/9kRo9oj2WiBXHWZSdm4NW+kI9Rs1AoVuzlL5jX5QFJuhaoVEoxg2KWVXAN0
	 FgFY5JIzymeXCpn0lpz5T7M64Nkh/QGDnV9Evxr0YEGMFcMFRttVD14dx2o5yy8FVt
	 RKh8hJxGwwYn80539qYCGwAlzvyRtb5k9kILsXfihe+6WA/gUKchxYEj9zPFMfk67g
	 KwuoNro6PFbJw==
Date: Tue, 10 Sep 2024 09:34:10 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	selvin.xavier@broadcom.com, pavan.chebbi@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next 2/3] bnxt_en: Add MSIX check in
 bnxt_check_rings()
Message-ID: <20240910083410.GE525413@kernel.org>
References: <20240909202737.93852-1-michael.chan@broadcom.com>
 <20240909202737.93852-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909202737.93852-3-michael.chan@broadcom.com>

On Mon, Sep 09, 2024 at 01:27:36PM -0700, Michael Chan wrote:
> bnxt_check_rings() is called to ensure that we have the hardware ring
> resources before committing to reinitialize with the new number of
> rings.  MSIX vectors are never checked at this point, because up
> until recently we must first disable MSIX before we can allocate the
> new set of MSIX vectors.
> 
> Now that we support dynamic MSIX allocation, check to make sure we
> can dynamically allocate the new MSIX vectors as the last step in
> bnxt_check_rings() if dynamic MSIX is supported.
> 
> For example, the IOMMU group may limit the number of MSIX vectors
> for the device.  With this patch, the ring change will fail more
> gracefully when there is not enough MSIX vectors.
> 
> It is also better to move bnxt_check_rings() to be called as the last
> step when changing ethtool rings.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


