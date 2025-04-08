Return-Path: <netdev+bounces-180325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1718A80F6D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D9189C889
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF8227EBD;
	Tue,  8 Apr 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY5bllrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED678227E98
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124921; cv=none; b=dy6Hy3tsTnA0ok06imx6OcGBCPrZf+vjhYVmNttyPEICOn5Om7XFHPh8cLLQ3wQlIW/5Jm2xmVsytFBTnokwqLqVMCJCtn8eQswMdTXwX5Rj4SvzZOFOlM+PTsGBcfalQ2SjY2lY0leWu301W8QhlR/Rumy2NAVyyBK5Ka5IsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124921; c=relaxed/simple;
	bh=JKKkixSbGF8UjB/MvSvMZnbtOKQDgMk9jiljZD/ojOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBNy3DLhFAWTPCjlj+CZ22N/9Rk5sOg8sT0SDaW+WkxQvtnK6zT6lcidIzkEJyoUHnZo88qkkiaxsAomMICtFU4ChZ5jm/94cTKh9/4DetwczQyhBV32/+wbo1/NQr4ynVO2vdnkfbX2oRRdHBsPvm9KCcnGRwXi0y2a89x0FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY5bllrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11144C4CEE5;
	Tue,  8 Apr 2025 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124919;
	bh=JKKkixSbGF8UjB/MvSvMZnbtOKQDgMk9jiljZD/ojOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lY5bllrMczeuFAwqaL2ic0vosqWi2zgLDKZ86GauPV39oTs0S9ZQROjT15IDXHtwZ
	 +tfk8ZG1HSKfx+hSGd7pwasg/oj05jw78zTpskW6X4I38c9qon3a6YW14SUZxG4B97
	 riTi69NJEH/OBspDqftawtVDuuSPg3VZ7mcZTmWcPOfSkDooqrY7cKMihfQwP5iD8H
	 194xMqyzRBPIolccxi4FwsB4kmQKrVsyX7LryczBXFGdUfEhbfbyKUReIm5Fx1++hQ
	 ZyILIwxiNkRnOtfNRd7Rj3ienXJyIEtJw1gf0rTmg86VMtpDYWw3vMonaSKNuZAt02
	 X24FQ3R8cpIPw==
Date: Tue, 8 Apr 2025 08:08:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 7/8] docs: netdev: break down the instance
 locking info per ops struct
Message-ID: <20250408080838.5a040d2f@kernel.org>
In-Reply-To: <Z_SLOkj9EGKg_sRn@LQ3V64L9R2>
References: <20250407190117.16528-1-kuba@kernel.org>
	<20250407190117.16528-8-kuba@kernel.org>
	<Z_SLOkj9EGKg_sRn@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 19:34:34 -0700 Joe Damato wrote:
> > +Similarly to ``ndos`` the instance lock is only held for select drivers.
> > +For "ops locked" drivers all ethtool ops without an exception should
> > +be called under the instance lock.  
> 
> Extreme nit (which you can ignore): "without an exception" read
> oddly to me. Did you mean "without exception" ?

I guess I'll never understand indefinite articles.
Let me change to "without exceptions".
AFAIU plural forms are a get out of jail free card..

