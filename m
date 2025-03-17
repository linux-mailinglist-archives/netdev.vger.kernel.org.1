Return-Path: <netdev+bounces-175449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58650A65F6C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBF17A4CD2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3A1F91FE;
	Mon, 17 Mar 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ENDg0ENI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210C1F584C
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244201; cv=none; b=ZXKE0zLJc62GUFuwbuiL2m6SNxA8s/tRRNoti5N1OQ9TJg8ez00GoXZ/6xHq25sEM9CWQ+2W5rK7pmXNWkrN79LTjOg7bmwziVlwCtOw/uC7X+4dpsqWKj53RlrlTmksmMv4aiLVqJSQrfXrJRKJl7mV/AFnSrMV4SxQlwavyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244201; c=relaxed/simple;
	bh=CaY9plOsZmG+vqb+Y1a/gKRrf/XFzCbAh8Gjy+jCWms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJlcLy2weh20ODAnKaXi1wu9z7s401uiv5zNlVl9RrTw2HSpU+5elDYi70swQau8mPEGIPKX5tnoctqM7oe4PKwhdblxigq/KAtSXorpqrzeu5SnJaiYq+MPEu6ZC1BaVHTt1igOYT+VJC3jV+6/WITBzUTLOSxjy5n5vfztdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ENDg0ENI; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-6fedf6aaed2so43576927b3.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742244197; x=1742848997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMeuqQnVCFYcIh1s8lv0Ab4xH5GnpJ38EIK5c4gPr0c=;
        b=ENDg0ENIuz6Aks1W7JswZhQRnFXeDkSWMoghPY5Xljiy195QJRAQZh40nBJXj8NEEd
         t+sAvoGnQcSbUZBlMdFv6s/I3z36OZdXIVu5zuDrBKEOiP5SqgIt/WxMReR6xg4V/iYB
         INfgpIYEorasNEIay7nMF/n7O9ty+caatL28RaJZ+bB8xjnGClZdn9huEoYAleLZzaPM
         380ClgbkKoEOQ+A1ur/94l3YGPYGZ/FRCRsHV5LA1npPRf5eSh8H+OuzemKl2acsTdzD
         QVj+ytAj7fSpF4ESVcA5OJqkSgwFntEDnPBb2y5pBA/VdM55oASbIPsvMS5T4ejyqrX/
         qgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244197; x=1742848997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMeuqQnVCFYcIh1s8lv0Ab4xH5GnpJ38EIK5c4gPr0c=;
        b=cEnDNBD5FxjJHhREdokaBe+Dqm0YwqcDgNU+kiIpKSpfsyvbnWkZPNEPfNLTLXJ+gN
         LSoyMWxCAzg9ufFTXdayKlomjt5oMGGXJfnMAmMI9mwONPV+eulNO29+5htsNMsBLqqT
         iyYgdz/xrQCGvjnGnZkd3kKh1hzgW2XCcU3BFoLmF+mhkxtDe2Kp0FHn+luVMpffhxJ7
         j9bLjyfWxrXDwsAh+janxFWa4+Qlo4jWOzwr0PPInWaPde4z5zOoomPbbRKINXu0e/Fh
         QZPFwTreXtle8wIUV9fe3qKz2vVWCMpvXZL0HOj5KQwSdGqjTL2hv9CftdY+XXGvd8XN
         iEFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIq9OC7UsFyGhoIOLKChbwT6Uh2QmHpK3sVgOJIbQU2i/5RTJxtmEdM30Jwur2QTH1VG+sW94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJS4mcee8GYC7sEvPSCfVOgUvrJbwBY8534wIdjHHmmmD8lQi/
	cao4OyvVUUEz2gefRHSvwCmBD7O8g26oZ5vZ0DcYkaP4aHQ81Myab0+NIrQvCkcLhE3kWE3Tgfq
	YEXTWy0lEF7Scy5tmYwIJ5/3wAtsiWxIi
X-Gm-Gg: ASbGncv09nML/IgtQDn/nM6SyjU+9ycSPtF+XjSO0h3pG/xNYjB1jiW64gb8BUxpLT4
	xQD6uiiNU2lMIm3oiudECt9b2KLex+zFwp9RaDBYB7qFVEtuo8F7XuyPEcjVWhOqRHvfJwtnFIM
	YcM8n0KOnsu44f5COS7pgRS6JZYtKoOlsjxvV9VUJwsKSmm6naCudljGJeTqWS1K3n4Xvn7arR7
	qS+/z+TabFAaJUTQh+jVqQcZ1dNleG7INOkP0HzRT8wbsNIqSx2/L+Vk+qlH1UI+0Xm7okIA+wh
	l5R4AR+0KN8pW7FsNmt358yHxw04FMJ5Jd7wVmtgrFv/6e0rPg==
X-Google-Smtp-Source: AGHT+IGhYQOQzoo1W81n7SvjULK8kea4ne4u7SJCVMHMBohbiO+5gVHT5Why/Jb0nEdWm7n7qdstRUUSezbb
X-Received: by 2002:a81:c748:0:b0:6fe:bf32:a427 with SMTP id 00721157ae682-6ffeb390465mr12881107b3.0.1742244197208;
        Mon, 17 Mar 2025 13:43:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6ff32894af3sm4257537b3.37.2025.03.17.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:43:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3E38A340314;
	Mon, 17 Mar 2025 14:43:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 324C6E4020B; Mon, 17 Mar 2025 14:43:16 -0600 (MDT)
Date: Mon, 17 Mar 2025 14:43:16 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <Z9iJZBh5ZFq3wC6s@dev-ushankar.dev.purestorage.com>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
 <20250225144035.GY1615191@kernel.org>
 <Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>
 <20250311111301.GL4159220@kernel.org>
 <20250312203716.110b6677@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312203716.110b6677@kernel.org>

On Wed, Mar 12, 2025 at 08:37:16PM +0100, Jakub Kicinski wrote:
> On Tue, 11 Mar 2025 12:13:01 +0100 Simon Horman wrote:
> > On Fri, Mar 07, 2025 at 01:11:18PM -0700, Uday Shankar wrote:
> > > On Tue, Feb 25, 2025 at 02:40:35PM +0000, Simon Horman wrote:  
> > > > Reviewed-by: Simon Horman <horms@kernel.org>  
> > > 
> > > Hey, since this has gotten quiet for a while, just wanted to confirm
> > > that there's no action needed from my end? Is this in the queue for
> > > net-next?  
> > 
> > It seems that this series has been marked as Changes Requested in
> > patchwork, which may explain the lack of progress. But that designation
> > doesn't seem correct to me. So let's see if this can move this series
> > back into the queue for the maintainers.
> 
> Unclear why the designation was chosen, indeed, but let's get this
> reposted per normal process. The posting is a month old.

Sounds good, I've posted a v6 which is listed at
https://patchwork.kernel.org/project/netdevbpf/list/?series=943246 as
"new" even though it has several reviews from maintainers. Anything else
for me to do?


