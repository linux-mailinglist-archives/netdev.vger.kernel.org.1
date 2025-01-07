Return-Path: <netdev+bounces-155833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FFA04002
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517EC167106
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DB1E3776;
	Tue,  7 Jan 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=greyhouse-net.20230601.gappssmtp.com header.i=@greyhouse-net.20230601.gappssmtp.com header.b="NHT3149z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B91AD3E0
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254573; cv=none; b=FWA1qTNuYULBbzQcdWcJvVsOaEIsS6oY9kch2zMYVhV3HNjfhMucPfUYuyuDcgsUP3/ZvOcUIGAjEJz0qRKjuhIMLT9Q1moEPsWD7zCTqZmUejyV2phyQ38mfX8/AN5Bq6SxZATDEZRC5kO14qs5RsrioeFopQ18UaS3CdoihDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254573; c=relaxed/simple;
	bh=cmg0CA5nIL1CzJ+q2MTHTq5I5LqYDS9lSkcgBi+9+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlXDy75AgUjjmmHcGnEInYEf5rrZSLrS9KcLV7Hm/4GgE6OtDNRSXg0bgSHIzO7KoJipmyeqiEWgVd8kMBA+j1xHFQS89U7u/HEklPlylStY6NWv2YVDDu9mrp2NzJ5hkop5Sc/fwcQ3k3iKmKjDio/nWkpEOLWlBIl3xmExVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=greyhouse.net; spf=none smtp.mailfrom=greyhouse.net; dkim=pass (2048-bit key) header.d=greyhouse-net.20230601.gappssmtp.com header.i=@greyhouse-net.20230601.gappssmtp.com header.b=NHT3149z; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=greyhouse.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=greyhouse.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8de4407f3so7723506d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=greyhouse-net.20230601.gappssmtp.com; s=20230601; t=1736254569; x=1736859369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V17Lr4umZDu97Ony/jynw06iwKEoPPw9WaPLwS9wuds=;
        b=NHT3149z75j2/vfes0EYy19R4HoejYC5iUHS9vfOs1EahMWoOukFvPUJc3R9eHeN+9
         8AMYy7w6Yn8uFQezTEHNPyxHAXETvUftPHUYEmmHIJ1BCMBXT2Vpcn8fbxOD4PzzG+N3
         vu1hBVRaIUKbqF7CC47XaxkPsNYjBtENAry/WdRgv3/Angpxl4Lpt0LPc7cSiMTSboLb
         6v4UNXu2nKCkIMzaCu1QqKF+5gqS6YBfsTOSiU02QpqWDMGveVPkRE0H89ymP2wHQWtn
         +B+nII7PqO4xca9rVpqufXy9VweYJU1jjVq3h7K6HWEfSb6m5CQ5jZKde8Sht5R0FtTR
         WeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254569; x=1736859369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V17Lr4umZDu97Ony/jynw06iwKEoPPw9WaPLwS9wuds=;
        b=LraOu7Fcbze4zjjYz6TAolHpDTmT6zEWNvr757O9EgzsIRVZQ79/+Mmw7FKQGcygmK
         QozzMsjOjsCiwjoFureutJisHXzjY77flbglEkdpTmvosOkzRXXBzAOW68XA6fYYkECy
         jerumWm0wkinQ4fbe4n1xImQZU/hzB09HLUsTA/2Myl9Hht2mSX5Qs/YY3ESxhlciUW5
         tc1NaBv7yWCvwClMDCms7uE3VIPKBHQ7kn8T36xoX3cOTaZQpC78T71I2A8Oi+yJKY3j
         tRgu5wMPODqVyB//Gu1wvhtO3rih3ki7JGJUrt4cV9Dh6QFy6cIrZYkvwb4yvdO/cTn5
         IWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVklrdRFWckkiJ1F8lYnTWA5OJ0Rup0ums2pkimkDTqIuP/5QES/chISztVS13yo9geIVLdkjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4NAKlARL97bFpY5q4q5cgPypHMXe4wJylyfZiiIStzmObcxC2
	Iki9q2NvHEHXQlLxQYklPfC5wNmXH2qCF1iKlGsypbZNLbx9ysXA9wM+ethCKfs=
X-Gm-Gg: ASbGncs0Feg4jl4UajYsOmmT7RNxxIjj14NlmHlFDL83VAroOiSGAtPTdP5zJm8RTnz
	1XlsCFcBoGSRpIDftOVO9BphYyuIr5GqW+ScABth/kJScnjEpPAVpBojia2oIXHWy9LE7NS+X0P
	FdDI2Zj9JLMJwHK9TGC4pxFwXyohLzrbopG29pccS89/7EzciLn/6/GAxrOn3XmKOh1SRHD83Fc
	oWz01z+/WItAV1JFiIKkPfOFFqBxe/lDZx3zd476PoI/5EIfUeJcQZ8yAWhEnU=
X-Google-Smtp-Source: AGHT+IGhYVfcoIr7sRafonaNiP8Sh7HC+I27KvP9vO+9Pbptf8K7pf0ZGpX9lg2zN8NdeZOGv5f9EQ==
X-Received: by 2002:a05:6214:529c:b0:6d8:a67e:b2ff with SMTP id 6a1803df08f44-6dd233a45b6mr344287136d6.8.1736254568782;
        Tue, 07 Jan 2025 04:56:08 -0800 (PST)
Received: from JRM7P7Q02P ([136.56.190.61])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd31faa052sm158471326d6.9.2025.01.07.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:56:08 -0800 (PST)
Date: Tue, 7 Jan 2025 07:56:06 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
Message-ID: <Z30kZueorMXU0QzT@JRM7P7Q02P>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-4-kuba@kernel.org>
 <2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
 <2982753.1736197288@famine>
 <20250106153441.4feed7c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106153441.4feed7c2@kernel.org>

On Mon, Jan 06, 2025 at 03:34:41PM -0800, Jakub Kicinski wrote:
> On Mon, 06 Jan 2025 13:01:28 -0800 Jay Vosburgh wrote:
> > >>  BONDING DRIVER
> > >>  M:	Jay Vosburgh <jv@jvosburgh.net>
> > >> -M:	Andy Gospodarek <andy@greyhouse.net>
> > >>  L:	netdev@vger.kernel.org
> > >>  S:	Maintained
> > >>  F:	Documentation/networking/bonding.rst  
> > >
> > >I think Andy should be moved to CREDITS, he has been a bonding
> > >maintainer for a very long time and has contributed to it a lot.  
> > 
> > 	Agreed.
> 
> Sorry about that! Does the text below sound good?
> 
> N: Andy Gospodarek
> E: andy@greyhouse.net
> D: Maintenance and contributions to the network interface bonding driver.

This is totally fair as I do not make the time to review bonding patches
any longer.  I do appreciate being moved to CREDITS and not being wiped
out completely.  Thanks Jay and Nik for looking out for me.


