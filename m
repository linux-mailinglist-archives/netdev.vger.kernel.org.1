Return-Path: <netdev+bounces-241372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B388BC83337
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45904E4403
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B35B1A83F9;
	Tue, 25 Nov 2025 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="1c6MYFxx"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8462A1C7;
	Tue, 25 Nov 2025 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040569; cv=pass; b=L9X2mTueuFHyW2R5BpauhixbpTbEFl6iGr/rmXodYvyvmx1dl3ZGq908IoNIg84nN4/87UBKLbohR4y7u+bLaWFfgssFo4x9rpsIlyTvSvsm7+sv2N5i0D3umOMH5kqhR6Bs9nAtfdTdIx2Bl8QuozyLBijIpM2AkSyCaKZ4E/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040569; c=relaxed/simple;
	bh=LiKsBfIhITdIfEkwcRpX6Uvyc9RO9g/3brcIusyI/wc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Quz54de9FcfVOYL7yfBH9usp2K6Ex9mOeccj8LdBzO45/7Lyy7qGsxOSiul2UcrTO8IxmdG2eOGrlfNp1ndWqGsHw7Kpep5fUHHOSuFcmJ4ilAFH+OaCm5NC0uZ05JdMJ2Wi8ias2TMZvigbKHDHci1uAZjIdM9c54ijmmDfrLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=1c6MYFxx; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764040527; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PkkBaYckwjWegrpu/fgcL57VzAkvnNI349e1lKiYi2Wh3Dqkk48wbp06UawBPfgB6mbczr5vKRHKW1VQXHmqWKQcfWF94Dz6WjXfyZ3AvIUE1QpGkMUTOCbJt61xzfDiYDyPA2c9zN1QRkj7Hcvphl/Zuw17siQcCRCdKmPHRis=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764040527; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6KFyFUeue7vnoz79vdihPq5QsxgMrrMVUwU+A4GO7c4=; 
	b=VPdYEQpvZvfU41AJZFSCk+n2TAxSuQo/W5jBnVzmmOfXkloqGSYZ8GEznF/n12J/u6BOEVS0ntR1+38CA/wkbGYO8JS76dzYtNVmCwhNs55MmkssfegxXiIKVALqNBDvjSm/zwexKJNW3DrGu/mBQFHsr338qy/Jhmc7YIiPteI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764040527;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6KFyFUeue7vnoz79vdihPq5QsxgMrrMVUwU+A4GO7c4=;
	b=1c6MYFxxPQBLUeJQw4tHSdxBAZH3ijaW7YP4MZWyrnbCW01PE4vM6msv7z8NItwg
	1Q/omBCqB7LKHEZ/YeHPslqM7tf3JOIRXk3buHV9S6qWk6K2qmimprsp4jLf9qJLNvd
	JY2jrvkudqGAeWcDGqiXZ5mB+Jy3xhVlfES1OhuQ=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764040525649893.4123499982568; Tue, 25 Nov 2025 04:15:25 +0100 (CET)
Date: Tue, 25 Nov 2025 04:15:25 +0100
From: azey <me@azey.net>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David Ahern" <dsahern@kernel.org>,
	"nicolasdichtel" <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19ab902473c.cef7bda2449598.3788324713972830782@azey.net>
In-Reply-To: <20251124190044.22959874@kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b> <20251124190044.22959874@kernel.org>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-25 04:00:44 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 24 Nov 2025 14:52:45 +0100 azey wrote:
> > Signed-off-by: azey <me@azey.net>
> 
> We need real/legal names because licenses are a legal matter.
> -- 
> pw-bot: cr

I was under the impression this was clarified in d4563201f33a
("Documentation: simplify and clarify DCO contribution example
language") to not be the case, are there different rules for this
subsystem? I think it qualifies as a "known identity" since I use
the alias basically everywhere (github, website, GPG, email, etc).

