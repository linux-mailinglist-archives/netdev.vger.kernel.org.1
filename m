Return-Path: <netdev+bounces-202896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D92AEF961
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2EE178F85
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CC2741A0;
	Tue,  1 Jul 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1aI2r3+e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562F25B301;
	Tue,  1 Jul 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374577; cv=none; b=ja8RTEqB7QcheZthZnUhhTCeuECZq5m5UxlZ4/EbVBvgNdofW45FNmA3WQoD7dPhBrRvwRaEt/XeTe1m8i6xNFCIg8CwnHKUUoPE4ZfHzEr2lMbTeiuL0cbRyLwryzwsMfc/rEJl3wZYzbkjYEsi1HNFgk0EbqDU5SM+hYh/IBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374577; c=relaxed/simple;
	bh=s0tZBS8Wvibesn5JPiCnaxtrVXPMb1Ijnjksqr8QASI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOESyv34UYAOm1MiJfEf8+gjAybYBqYOt3IuCdhsVgmoiz3pl2C+W76gmN9P2bi/Xd38TIEtWNugnnjj5FrcAY9jV6+p4Ks1N8fRh4zjFOdr19fy8mdRuybh3eMOh7QhKB2xJGz1HLMfnLP0qi1XyN/AMKLzugmk0qUUK8RnA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1aI2r3+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03DCC4CEEB;
	Tue,  1 Jul 2025 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751374577;
	bh=s0tZBS8Wvibesn5JPiCnaxtrVXPMb1Ijnjksqr8QASI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1aI2r3+e8OpzwbjoJonbdisURE4LfHxOoeSl6h+EJiKPt17aHCtkG9wYWUjzEvCBi
	 Q2E12BpT2NlF/FDMmFEQw2yr6G4MKYV7Dua/hmA2lz7Zerz8sjoy2wgXio5pzifunH
	 KBkk6veQSbclCaxDEqYKp24kLcNpNoVqYzdKk3Rc=
Date: Tue, 1 Jul 2025 14:56:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <2025070144-brussels-revisit-9aa3@gregkh>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
 <37t6cnaqt2g7dyl6lauf7tccm5yzpv3dvxbngv7f7omiah35rr@nl35itdnhuda>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37t6cnaqt2g7dyl6lauf7tccm5yzpv3dvxbngv7f7omiah35rr@nl35itdnhuda>

On Tue, Jul 01, 2025 at 02:42:10PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
> > From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
> > 
> > In vmci_transport_packet_init memset the vmci_transport_packet before
> > populating the fields to avoid any uninitialised data being left in the
> > structure.
> 
> Usually I would suggest inserting a Fixes tag, but if you didn't put it,
> there's probably a reason :-)
> 
> If we are going to add it, I think it should be:
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

Yeah, I didn't think it was needed as this is obviously a "ever since
this file has been there" type of thing, so it will be backported
everywhere once it hits Linus's tree.

thanks,

greg k-h

