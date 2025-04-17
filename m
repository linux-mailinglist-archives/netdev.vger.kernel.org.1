Return-Path: <netdev+bounces-183893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DEA92BBD
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8448A6F9B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A11FFC4F;
	Thu, 17 Apr 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wtkct3hw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF0A926;
	Thu, 17 Apr 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918042; cv=none; b=EDT0wjKwUtPg4Pvl8ebzHVlz7Z+f9w3tOg5TF2cpr/acI2petTsNWFB0DZaTK0LSf3j88zPvDREshaNpbnA7hJFtt2+CAQsGI8CBnaPIyeMfxpalVz3Z9a1IIXB7UsHOvtnV+mZOJnbd7HY0GRytb9yZpKJgIrINjYz+XRhrJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918042; c=relaxed/simple;
	bh=i16WA67LPvUJ6fF8lKDacbPFAq5TNMbufDZ2u+jPRxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiB69beNWJJ8b3tpiHgLUA27VyXoFt76zJyqV02IC1EKdlG9tGSi6LnmIVr9GFqCBNyNWUDbAll5vN0J84lsY3F2g66ouKrEF2+kkA12tFRXau99H2OCBhXFQ6BhiIV7lvkVRkF2l5zVIQ4CFFbxoA2MVClGhOMlF/tjoxcgLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wtkct3hw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FkY2aR/UXMHQ7V+YHorAT6VNFDvvkYtIHjoCHnXJLZw=; b=Wtkct3hwAh4o3YvYjNC5/4TRcO
	HBSjy/CD1EmYezUXEkXhpidr0RU35Y+tOZMM3PCFGQ55diHcjnb4wDL+Gr9+xKtPw8HGKli7GOJBq
	TDJDlKdDOdSyeVCpeGuzSNXshWFHqOfdcbyT2cZr7lV2zsK5P3QhtpLvAkxlQ5ZDDkiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5UtE-009p88-SY; Thu, 17 Apr 2025 21:27:12 +0200
Date: Thu, 17 Apr 2025 21:27:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/8] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Message-ID: <52e9d5e5-e625-4e0c-9e61-04994cc1b788@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-4-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-4-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:07AM -0400, Jeff Layton wrote:
> Allow pr_ostream to also output directly to a seq_file without an
> intermediate buffer.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

