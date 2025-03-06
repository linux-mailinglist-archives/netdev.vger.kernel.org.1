Return-Path: <netdev+bounces-172535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8207A55428
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25C1178CB7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651626AA94;
	Thu,  6 Mar 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c57e2SFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C0275604
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284313; cv=none; b=PP5Y3CA1gsWjIOrZOivN4wO81YSE5SntC0z7iP8tkrA6lp2pztcsCDPeu1S7l0qDSiFHiszZ0s4X3CWTtdr/t9uUek/gGiSKDD/u+CULwpWtY+XLoUbfDSdiGXoLcaokxBlGZ3JAB60GnhSYlfWCOilUnHUlZlbI6ACklUkwU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284313; c=relaxed/simple;
	bh=3PwoF0zToj772xqwtTkyDD+wV+pt7RShXzlQFoHxZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK1ez35EXyS/DsR5dMbNz3B4KuLUKBnetRnIggjmL4DzqJhu9wPVVFtVXprigo12BgXOr3lhDSl2l02bxrnV4UyAPPY+g9DdJb8jaUmvVr8QVppxMum5XbdelJ8UiJRj9QRpIae0xzm3yPa3+dLt7R31Dkch1Cv05z3LePnm0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c57e2SFt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so20118475ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 10:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741284311; x=1741889111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfbzyHW+3j1Fc44hupdNIMdLCl+IfI1UFsdc+cpACxY=;
        b=c57e2SFtuCS73TnpxSNusYduKh+ZnrqKs4LHfOOYzYpVW/r0hzwfvUXPB0iLFY/eum
         8HeXsyc9hZYMuvqb2jtk88inE9K4cFL4qwH3/wVetFl7hYko7Vn9kI430/f6WJG9bxdv
         NVTyZ3JJKsJsx/DTLx/JqpnvTFWVCh87cDoBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284311; x=1741889111;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfbzyHW+3j1Fc44hupdNIMdLCl+IfI1UFsdc+cpACxY=;
        b=axMgkPkcsipVVpk2QKJYjafb6GU0c9YJ+JijouETor0whvQ00QbG7PUFCRPiESDKRO
         HWMJBfe1ElqE9XGh0LrFx3MT3BTLrOOTg+aSy61b+JynkoKyr7jYhkqXh7qyFEATIOWX
         qWTvZvYQFQlOItOtkUelWJsv+QEFgoWJOhJlL/n/aklrMHnn78WhX5yDlFDwzZNTc8cA
         a6iU3xR2u5njtOexsAAE2PfBYhUH8bbF1Rhqrx5XMglolFC0NQrXqkxWBuTBubeCLnw0
         Yikwp3RrnU+k4d6uf0WSSZxnXfUQh8X51Yf9UZjaVBsom3oDMctI8NJY0EsBxrnIukj2
         Wnxg==
X-Forwarded-Encrypted: i=1; AJvYcCVrMKP4nseR9lTU9Mxn4QM5V8YpU14vbGPjUCoaN/jYq1+EokA7Q5CT7IsDJlhCPpuuzTE1l/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCF2b5ScGsavW8Ivrxqls/LNeiPDXSdvC38sYe225NlbLDzMT+
	JOV9bKeliSqT8+x0NuGtjaGRfafkQAlrGs4YRmo9VTfFCYrMfBFqitQg2XAjQ3Y=
X-Gm-Gg: ASbGncvTemBs/Gl7e0K55qsBgeuMmij6z090J0DjBwO9AzdYQGuqdXFNbv9zT1Du/G9
	4brCDyNI1K3UqseYgeeEth8BgQAQxXEAT/wDTeDqadx8lZMXYS1+Fls9yWYBywCvq9Te3yIKQBR
	G+WTM386R7hxjuHTYkOle4mvM8jYN3DhqZRJkxAZEmueaT/0o5ZvWKxowgvY2WqQfghW1nNO9GV
	KeaMulwsWIn/N3M0dXPIh4x5nI2NeuFUF69E3oGgVMzu6nVTIbcgAT+wCoZDWUPHNlwyrXgasLE
	KyrGMYt1phaHFCJ0vaGmMB+YiM7uE5meVIGgjIl80nHEuwPUPLsktbj39BVW94+CjbKJvT58l1/
	DteBvAaUKvrQ=
X-Google-Smtp-Source: AGHT+IETVMt8ZHlhAk9BJSz3LJj1C/mnpejwDBQPZvWM6/uxlLsqo5dzDk70ohOCzj3MwmldoP92Lg==
X-Received: by 2002:a05:6a21:398:b0:1f3:1eb8:7597 with SMTP id adf61e73a8af0-1f544c8863cmr696222637.35.1741284311370;
        Thu, 06 Mar 2025 10:05:11 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a587cf4dsm651046b3a.93.2025.03.06.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:05:10 -0800 (PST)
Date: Thu, 6 Mar 2025 10:05:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	alexanderduyck@fb.com
Subject: Re: [PATCH net-next 3/3] eth: fbnic: support ring size configuration
Message-ID: <Z8nj1Aq7TC3V6WOc@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, alexanderduyck@fb.com
References: <20250306145150.1757263-1-kuba@kernel.org>
 <20250306145150.1757263-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306145150.1757263-4-kuba@kernel.org>

On Thu, Mar 06, 2025 at 06:51:50AM -0800, Jakub Kicinski wrote:
> Support ethtool -g / -G. Leverage the code added for -l / -L
> to alloc / stop / start / free.
> 
> Check parameters against HW min/max but also our own min/max.
> Min HW queue is 16 entries, we can't deal with TWQs that small
> because of the queue waking logic. Add similar contraint on RCQ
> for symmetry.
> 
> We need 3 sizes on Rx, as the NIC does header-data split two separate
> buffer pools:
>   (1) head page ring    - how many empty pages we post for headers
>   (2) payload page ring - how many empty pages we post for payloads
>   (3) completion ring   - where NIC produces the Rx descriptors
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v0.2:
>  - trim unused defines
>  - add comment
>  - add info to commit msg
>  - add extack
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  13 +++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 109 ++++++++++++++++++
>  2 files changed, 122 insertions(+)

Looked at this for a bit and read a bit more of fbnic. I obviously
know nothing about this device but nothing jumped out to me while
reading the patch:

Acked-by: Joe Damato <jdamato@fastly.com>

