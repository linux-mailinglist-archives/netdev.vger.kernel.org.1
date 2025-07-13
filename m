Return-Path: <netdev+bounces-206449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34082B032E0
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923453B01CE
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847E1F9F70;
	Sun, 13 Jul 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW0No6dM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AF51C5A;
	Sun, 13 Jul 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752437896; cv=none; b=pYcYOgezu0YF/CRUwP1tHad4mqJrtED926KE1OU06WWI2XguZeu18qxHIXdh9HvM/pU0j2Fps/HL9iZ+k0CUxnKffRa1YXEQP9ZacYk2psQ6rl3XvU5KklTlZ5ftih4BQJ+JeXHWqsD6280x/pStEDp1xilHEW4gSzl8ZqoVl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752437896; c=relaxed/simple;
	bh=z7p4KwkBk4NY89HWdCsRxmsgX8iUNRQ1eqdg5NIgzk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwv4amWT9sqbTZ6q73mUmc1FpqXeTxHwAG/8Po+sWSI356dgNuVx9opX1c7VJ+9M1wBokRjOLbWEJHu+Ian0Ai0SaZEq1nfreunRNpHVeYYQnYsJJ8mDYs+BcNUdP6Vwio8EgFnDmbzBdMKmS1xLAO0G2Zepxtu84hgFr1hZAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW0No6dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4223CC4CEE3;
	Sun, 13 Jul 2025 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752437896;
	bh=z7p4KwkBk4NY89HWdCsRxmsgX8iUNRQ1eqdg5NIgzk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kW0No6dMzF8fTDn+PoEaSz/eEoJWAW1AhAszDD4U1QtpkKEp+P7d5p/XH5nWxsTtc
	 mHnW4oHCuPwQ0iAA9JXP+rPAzgLnPY9ctueiezhir5lqNCxJyZ9GmBTf8l+QYzsjbc
	 AwC3ITLEg/gF2aje74Fe5IWQhX/7eaCe6hdYJprlU/HT8T9Mb0BuI/4CaidaRvBgp7
	 93Ntibd/e1AbuLB+FcizJHOBFEXE5qQWTpcnO1zfmO8oC73UXj+fA7rmhcPMJ5JG0M
	 hWrfREJvRopNEOVItshen3xODE9HCE9MEhOL7AZVcG2SARcRZ3t2RZx9gZbzXxVN9P
	 cxKlErVMYwjbw==
Date: Sun, 13 Jul 2025 21:18:11 +0100
From: Will Deacon <will@kernel.org>
To: Lei Yang <leiyang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 0/8] vsock/virtio: SKB allocation improvements
Message-ID: <aHQUg5-lIXq3jAG5@willie-the-truck>
References: <20250701164507.14883-1-will@kernel.org>
 <CAPpAL=zBxWBTQ8s-DGG-NywoE2+rDJQ4=9XGGn-YZSFH3R_mZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpAL=zBxWBTQ8s-DGG-NywoE2+rDJQ4=9XGGn-YZSFH3R_mZg@mail.gmail.com>

On Fri, Jul 04, 2025 at 05:50:16PM +0800, Lei Yang wrote:
> I tested this series of patches with virtio-net regression tests,
> everything works fine.
> 
> Tested-by: Lei Yang <leiyang@redhat.com>

Thanks, but this series doesn't touch virtio-net: it's purely about
the virtio transport for vsock. Do the virtio-net regression tests
exercise that?

Cheers,

Will

