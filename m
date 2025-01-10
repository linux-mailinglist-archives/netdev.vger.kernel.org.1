Return-Path: <netdev+bounces-157237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759EA0990F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7433AAEF3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB86212D65;
	Fri, 10 Jan 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mqp7WWYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A6224D7
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532416; cv=none; b=HaEredLfkJBywe4MyHhuofLae4PkscKZbC6sZcu3Et4AEJVaNUUnRIHpvPWc37cVNnnYcCrTSBYLNEQNBRbyc8SepjEG1QQpna+D5wz1XvQUYE9vvcTN7J/teknHB6JlycZtKywccRLyoE5Ji+eVK17RQWH4VoCyKaQEQVMFSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532416; c=relaxed/simple;
	bh=Mi09Sp55PRDxjLLUyTaStPOkC3EP1TDtNgSZDhtwqeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmodS2U1/XpsnWfovlGU5LXCprpC75JvpVwAlVu5OubL5N1X1OWA6JbL6VK6nM26kA27lYKsNVhyTX2L03i7xUBlds078QqAkZ0pJ2NFQEg7pU3fQ0csH1A5ml/vpB2mn04osL5EQb48lwsSF8+GS1CprhKs2SIK4GmOn/2QXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mqp7WWYK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so4053347a91.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736532414; x=1737137214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7oTFbKU7ZUAuvWFntw+g8SLgXEInNG63TSysIGbSKo=;
        b=mqp7WWYKFGGknQ7e4m0L8QSekwYSimbbyvkNCG4Bbt2xCzl3onlBprSGnERA+pqd6G
         WW8W+4JtcxC0JlfP+jAcv9W0KySnQ3vmz62JEGT0Z/dvYuyo+dEMjGaF52cY3B2BXCRO
         9r+coPPDiGCACa7j96sHywiGt8yck3bYNgp9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736532414; x=1737137214;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7oTFbKU7ZUAuvWFntw+g8SLgXEInNG63TSysIGbSKo=;
        b=d6GVit+whhRMsUTqgJOEZReujH9jX9G2QSg4suED44vrHFd5qAT6631uhVquxtZxFw
         OYqlP6congsEkgRparPxYGK4Ng3bveEp2Tt97+P7AK9cINvmaWquYcqhZGNCZMauB0AN
         4ls7DZoYRI5JEDm39GmwMynJXhiblZsBQAdV78zii2u2J6eXWIJW1PjPUn6fXmbC7SlO
         wkTYqPZdlyeXEXWlMBnTtNTcVQBlebwY828wy00H8lOmh0jeXuhEIw47dYrejb4M4+HS
         NSobZxUA6GKqIXBJT/ADOMthBAHNIkPl3diTTUaLM11CC0X+SvSt2Of55cUGnU621BmH
         U7gA==
X-Forwarded-Encrypted: i=1; AJvYcCVpOpTroNLSTouvbCcs9nRR7VCOpmnp3+mKu7HG2/OT7n8K8r4RJpUxK7nL8U7IQxKcDWqnxQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWNPmTf51Nl7GQWKIJ+jrFSgvSkFcbYmsUKcy5G9VQrLcGDnF
	SgEEIoAysaxV3VfsmWoDBssMyKX8Eg66VfeZ5XVjr67rWLovXhH9rmK6+0xfOCA=
X-Gm-Gg: ASbGncs0yQaiK/w2lO16hi0CZmEgm7dCOcLqNvlHqhjouyqy7FfQnFL+WXt+diOc8EA
	SvIl/Bx+r3tlKHgsJVKPGSRGdtgdfigSVOkc5DKCMmc1kRXjY/3w8+YgUREUAgMzdNO9h0t3iME
	S7i5hT86+/kCXmMHlMqAmDockjvNxIOXbjMeb6EABvqzCIXlCe82hzXjU/RwHbF/as4LsW0E+3G
	MVD/bITLtgCnUWZ1ThNCjx3HV9QkMvEpWDv646UF/gXxHWFLyn0cwZeapPxK8K58mMNvs48vi/E
	e517dDfwm7sRCmcySK4xL08=
X-Google-Smtp-Source: AGHT+IHvXY3/GCGGl0LfN3tVULKgmXgCplv58jIUfV9GTIwuAfoMCuYJMQG3lUcIE6WCt3LcE4TtWQ==
X-Received: by 2002:a17:90b:3d09:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2f548f39a8amr18277831a91.15.1736532413778;
        Fri, 10 Jan 2025 10:06:53 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2872a3sm5745528a91.16.2025.01.10.10.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:06:53 -0800 (PST)
Date: Fri, 10 Jan 2025 10:06:50 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com
Subject: Re: [PATCH net-next] net: warn during dump if NAPI list is not sorted
Message-ID: <Z4FhumFu_bfDu8uZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com
References: <20250110004505.3210140-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110004505.3210140-1-kuba@kernel.org>

On Thu, Jan 09, 2025 at 04:45:04PM -0800, Jakub Kicinski wrote:
> Dump continuation depends on the NAPI list being sorted.
> Broken netlink dump continuation may be rare and hard to debug
> so add a warning if we notice the potential problem while walking
> the list.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This is really a follow up to commit d6c7b03497ee ("net: make sure
> we retain NAPI ordering on netdev->napi_list") but I had to wait
> for some fixes to make it to net-next.
> 
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> ---
>  net/core/netdev-genl.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks.

Reviewed-by: Joe Damato <jdamato@fastly.com>

