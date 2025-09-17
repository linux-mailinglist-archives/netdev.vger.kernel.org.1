Return-Path: <netdev+bounces-224052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EE7B80179
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322A85278DC
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34C2F49E0;
	Wed, 17 Sep 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1eeGgeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97A2F3600;
	Wed, 17 Sep 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119948; cv=none; b=COdEeGDM/uEnnSav0ZMNSYnNuLSAGRiD9n5bmNolrtG2v6HAD+eodPrhj8nIJcmZmeBH5cQ742eKBhsvgowMyp+RPqwhWcdjytJCHFUpT/MSeMzBAzUhD12wzxmlgUI3HmFXM0npV9z/J1W/Dn3CpIzt0BK/Bmbmd47xgdWK7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119948; c=relaxed/simple;
	bh=u3+VBb0+jmWQQQNa6YrZZDY0GATxxNhEQ0yXVlXJ5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMCEEu1unu78TVa9PF2bjOfp36HkHYwvCp02ly91OM2rNPTImIOGO4pddSLmkez2xBzvxo1ggCjSFOdMADfQO7soe+vT/U6QRF7obA60M5RZgN+r2I2pQb21KakrpedKZfWXlOhKxHfAXbxKODBtM25sGQJNj9h6B1R4BZfiXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1eeGgeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D468C4CEF0;
	Wed, 17 Sep 2025 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119947;
	bh=u3+VBb0+jmWQQQNa6YrZZDY0GATxxNhEQ0yXVlXJ5Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1eeGgeq+AggIW9AVtyBJpJpYfNoylI143diff794sXLTNMKVy8ghMpQkHfSUWdqK
	 8yzWuwzF/4OMauvcVuI+l1WcCsr0O8EvNvvVe5gnagmj+FYVWXJQt1BBlXH4t20Wxv
	 FHFr8csxCJhbqYX7jhighmBjfgphjTvzfNbJkryId3thChMrhKA2uF4kNMpbQ8GKv9
	 kRa6Brvzu85IjGzOA30wQPsrSC6vsDHdlq5z4DxpIzZc/QP5YW1ZyWb3LiSWhdg0pY
	 pmV4ZIsOEWZQqZUcR73pF8EWnESbcESf1IYuhDAtPfGMF4U6+q8BsOIRGpsmrczXwn
	 ICvosiogou9cg==
Date: Wed, 17 Sep 2025 15:39:03 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Satananda Burla <sburla@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	Shinas Rasheed <srasheed@marvell.com>
Subject: Re: [EXTERNAL] Re: [net PATCH v2] octeon_ep: Clear VF info at PF
 when VF driver is removed
Message-ID: <20250917143903.GL394836@horms.kernel.org>
References: <20250916131225.21589-1-sedara@marvell.com>
 <20250917115542.GA394836@horms.kernel.org>
 <CO1PR18MB47473C9867B184DDDB51E1C5D817A@CO1PR18MB4747.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO1PR18MB47473C9867B184DDDB51E1C5D817A@CO1PR18MB4747.namprd18.prod.outlook.com>

On Wed, Sep 17, 2025 at 12:24:22PM +0000, Sathesh B Edara wrote:
> 
> > On Tue, Sep 16, 2025 at 06:12:25AM -0700, Sathesh B Edara wrote:
> > > When a VF (Virtual Function) driver is removed, the PF (Physical
> > > Function) driver continues to retain stale VF-specific information.
> > > This can lead to inconsistencies or unexpected behavior when the VF is
> > > re-initialized or reassigned.
> > >
> > > This patch ensures that the PF driver clears the corresponding VF info
> > > when the VF driver is removed, maintaining a clean state and
> > > preventing potential issues.
> > >
> > > Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
> > > Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> > > ---
> > > Changes:
> > > V2:
> > >   - Commit header format corrected.
> > 
> > Hi,
> > 
> > I feel that I must be missing something terribly obvious.
> > But this patch seems to be a subset of the one at the link below.
> > 
> You're absolutely right — apologies for the confusion. I mistakenly sent the wrong patch and so marked its state as 'Not Applicable'.
>  Please disregard this patch.

Thanks, understood.

