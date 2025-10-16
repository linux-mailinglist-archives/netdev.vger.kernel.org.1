Return-Path: <netdev+bounces-230134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99536BE44B6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4200D407E3F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F134AAE4;
	Thu, 16 Oct 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwrMLlyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEF345743;
	Thu, 16 Oct 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629117; cv=none; b=mBuEOywyjoVTcdk3NPyanGj0wJp5FCOVW86iZ5mlBlPZgbozDLZLNAZaBJ7u/CKVj76R7hcem+U0PnWHInj/bs5jK3+pLcZP6jVsIYrytiO6t1yFQqs3nWPwJyyNRi7zByugRy4Bf68syUiS6Qzn9A1sYEk58iXN7wVmy5XmvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629117; c=relaxed/simple;
	bh=blGZJ6uP32kU4uCoSfEygsP4Lf0BIfxqND0Tx5J4qro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+3ZD72mtr3Lylohp6L7gsC+gSeFM0aGrHLazoBk+c1qTJGCUJqrv7stGuEOdHuWjGqOLWPTU92zOVh37j0m13XdlWVl3SWdO5FBJ2H+dIhw0cACn0OPajHKYm2nBbau2m8/Z6IVb1gAg7cOVCYOQxDWqhm5G9Xe+rPLwmpAX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwrMLlyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D555C4CEFB;
	Thu, 16 Oct 2025 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629116;
	bh=blGZJ6uP32kU4uCoSfEygsP4Lf0BIfxqND0Tx5J4qro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iwrMLlyVvOkse8r1rjOItA3O1+H+70LbGYPhMiQ4S49HNlq7eVHgKYeXOnZzlZfd2
	 PHTPFlrJ/b30y0LxiXM5wYWLbX4t/e9N9f85Pi5Lnc0B1bkv96nbWJTWGyIe73meY5
	 nNJZpFSnSR4sUrS1wnpbq7wlD2l0j11o4QzBC6Ty8n6Pzi+I+JwMeHfX0lIvRWDSMH
	 SqwByFWXIFO9mlgEple74gjOz0+meh7Csl8QnBypbVu3L+TfE9CQGDYUK9cTM9z5HE
	 6rL1uVZxjd4mnG7gXlMRq+cWyxZoqTywAjm5lFdZgEm7LC6knct4y+BtqVk4i1DOwz
	 hAU14eHTuDpLQ==
Date: Thu, 16 Oct 2025 08:38:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, cynthia@kosmx.dev, rafael@kernel.org,
 dakr@kernel.org, christian.brauner@ubuntu.com, edumazet@google.com,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org
Subject: Re: [PATCH] sysfs: check visibility before changing group attribute
 ownership
Message-ID: <20251016083835.096c09e1@kernel.org>
In-Reply-To: <20251016101456.4087-1-fmancera@suse.de>
References: <20251016101456.4087-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 12:14:56 +0200 Fernando Fernandez Mancera wrote:
> Since commit 0c17270f9b92 ("net: sysfs: Implement is_visible for
> phys_(port_id, port_name, switch_id)"), __dev_change_net_namespace() can
> hit WARN_ON() when trying to change owner of a file that isn't visible.
> See the trace below:

Dunno much about sysfs but this is what I had in mind so FWIW:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

I'd be tempted to chuck:

Fixes: 0c17270f9b92 ("net: sysfs: Implement is_visible for phys_(port_id, port_name, switch_id)")

here as well. Or are we certain there are other callers that could have
triggered this earlier?

> Reported-by: Cynthia <cynthia@kosmx.dev>

Perhaps:

Reported-and-bisected-by: ...

