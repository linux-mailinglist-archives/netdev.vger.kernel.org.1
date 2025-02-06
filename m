Return-Path: <netdev+bounces-163560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C8A2AB1A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9E160A20
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B82451E6;
	Thu,  6 Feb 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="w4WBJPzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947622653E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851799; cv=none; b=TH86SRzqHX9bYxWftjCk7Mr3TnWYHu9bDoSpo9Cy1iD+UZObNaDX+udcT+e8W3UYfJW+SQpv20lfesNI9phZ2+Z7XnAbxi9HhUZQCNOf3TbqFMOxLjEFxbVYNMYF0xAAU5uSV/jpedxt3vgOPWlTxVPQzScWvkPnIcK1tw1zAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851799; c=relaxed/simple;
	bh=hYNDYZyhU3vPLzYPSaPWEcPzJSNHuY39jWh45uxHumU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVRKArm5XxArBVJI3WFMY9v7uS1JzYof6F7+pHkA/h87VHYF4+4447MKtxAbKOMreB0OXEtq+1nIXLqkIE1anjbMZN/+k023YgwYKFhj9f3L049oJLRvFo0Ambgrwut8/V/bvP+oXsm9AI9nd77K0fBTHAcHcE4uXBMn8bWGsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=w4WBJPzX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc7eba78e6so2093488a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851794; x=1739456594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFMFd8yvXqVnAGCGrRETRe/V8KRYdG7T8ArDcX9VBwI=;
        b=w4WBJPzX5UOyQ4pAoq2W+LwYbdYtyhv13tvBJnEyAwICDjjNPnZJdDRsX1IFceliKl
         4hD8mN066oU7ph/Y+RIveutEVH3p95RV7bChlz5h0viKFz1CfIB4G3oRIvDEt1KzziC/
         ZT6r19Aa1ISdkPQzzRxSrq37Pf78WKrbKwdP1LEkDD+8WHG6Q3kqZa5v2uPDaTba1Trr
         g2hEIDczbeLjDtzpWJTEawV5dNbp7aFPxf0Km5LPPuhLjdjybpBq28lp1sWjmWb08qjv
         KbLbOvUj7i8WEWfdScP3L26R4oNps+CVHb3VxOHsOGaHnsM+9kjbTGXXPkd08fUew9XN
         OYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851794; x=1739456594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFMFd8yvXqVnAGCGrRETRe/V8KRYdG7T8ArDcX9VBwI=;
        b=RBLKK9cxcs7YPymIBDwuqUn5Cm4+RsWTPph/AfCoP918G3Tl8G0Pc4ohkZe1YpWPKM
         7D4WeWfBcsA6avOQALIcgAnUourYR2MNtaQVfRrOeA/zRAzEq0973Zwgc42Hz1Ueymx3
         MKP3orrncVPLraK9Kwn2Stj7JpzreFqm4iCgltdaR4C7cz3olR2vbd2NiDZvf9S0jVXR
         RGq4RqwF/vBjSc+aElVeCZk/MRpfRiMAOxuRwdl1cNQbzhDVzrpRR4CIT6JEZqA4WyW1
         ANGCtXZ6xRtxvFC3K5r/25kO3z+hpDXyQRkCC9oXSs22LCczyXnzAOo50KQZ1I5moqr2
         fGcg==
X-Gm-Message-State: AOJu0Yx89lqvk7TqC6FYuS3aKjsUvmg688zbfXRYvzO5xXIZWJxRvEwg
	yXHIK09O44nW27W62UMkhif7jlZOEd4j0QGgkpoTo5YCpqLczQcJmophS7j48b4=
X-Gm-Gg: ASbGnctcKaqSdeoycwYzPpBj30NbsAuQnM0Yk+ux6QzYbX5sO9Dfg/PSRw+Ivfh0iWa
	SB7nC0bEwfKJD3LeGrTLQSqAHLRp4L+CMQS36vjqcdHJJjs46Rd2JbdetsMeask1cwOWi2f/e3Z
	D7NrskzmRbbYV68L5sGLaOuvlK7h+1nAuAU7El4VtGYNQpMVJBBrh2c5KfUHYpRSvwYWWWEMho8
	tmpnxWdBcGHbtgAMov02i5Qw+PJx/lPiKMbGxCUz6iuYyEe7ltj+U3w9oRuEhNeyyfg2yxmf2zs
	daY2uDAYef5VayGe8sOdZFH0PRIBUsOH2h41VxeP7OKtBUA=
X-Google-Smtp-Source: AGHT+IFFyvQfINAl6lz2A01y9ohntI7gR0hYfp3ILlqctgCUIUMFbzNkfcNhO1QK5iS0p6NSxCJe9w==
X-Received: by 2002:a17:907:8694:b0:ab7:b93:f77d with SMTP id a640c23a62f3a-ab75e245be1mr816768366b.3.1738851793676;
        Thu, 06 Feb 2025 06:23:13 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f486c7sm106211766b.23.2025.02.06.06.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:23:13 -0800 (PST)
Message-ID: <5de6707a-6a77-41d1-8964-19667a0e91b2@blackwall.org>
Date: Thu, 6 Feb 2025 16:23:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 06/14] net: core: dev: Add
 dev_fill_bridge_path()
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-7-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-7-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
> It handles starting from a bridge port instead of the bridge master.
> The structures ctx and nft_forward_info need to be already filled in with
> the (vlan) encaps.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/linux/netdevice.h |  2 ++
>  net/core/dev.c            | 66 +++++++++++++++++++++++++++++++--------
>  2 files changed, 55 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

