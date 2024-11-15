Return-Path: <netdev+bounces-145499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA179CFB00
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB480B2D09B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ADF1991DD;
	Fri, 15 Nov 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQbL+pJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FE1991C3;
	Fri, 15 Nov 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711966; cv=none; b=BZ37oWUff0l4INkQm5fGjSCWyfYNaBFaXgrt/wYd8ytuElHKp3rxeC4w1Fff/tOHfdjz72t5Iiz51qVT2YYUiAv/nxwuS+593yWOkHBlBSX6OdxU6YNyixuZq2XD6fiSOhmPBJX6lPVJQzLuYCGCBwCHc5R8Y4J6UAhRHQgTi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711966; c=relaxed/simple;
	bh=Jo+ofuLLw/UUI6bS3MNSWdAiZ8dq2amF42VzCm3M9fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJo73DApnQAEsOGeLr4FwpdtSMA04sS2vnFlPp3D1F61Q/MXrNXb0DjDAeyAVv6XbV8I+N+otRpVTdcL7jHWLjF1psIikE0OemG+u5NMZkHQpiWLAuuPP7rOk57AkeYCvy2xgq/B+QHeVewjf9BIvni+260U0p7X+gQeBT2XPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQbL+pJ9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so140137b3a.1;
        Fri, 15 Nov 2024 15:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731711965; x=1732316765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5P3ajlDLkS73EkMFkGbhTcSlZNQnkDoYtyzH8+TAfo=;
        b=kQbL+pJ9TfjTaBVrQaCUPDHMJhOR6ImmIqWSH3aAiNYrQkX66CGTnmcAZb0AYUTKqV
         rgLTMDbNmLt5fXJGYvZJSngVd8QvR01lZTsXl/TuWn0f5e0cYRdUdvUkW7PuVSN6hUre
         +l8VPVSQsEEpnESh3U9aewxkr/BJ1GbbPswMxjgPAZoRNoVJcgsLF60tSRRn69BzPDUV
         Sqhfx0t1oTdcen2BGo4b1OYj4Cy14ODL6Js7WmAUBESE9aJOFNkivm5RtZ0E+xg7V/sS
         1cCy2+9DWDnKId8clP1YSbfJ9IaKz1HBEe763wcOvh+KOfLqekLCsk5eIxRHLMcKmC2M
         gvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731711965; x=1732316765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5P3ajlDLkS73EkMFkGbhTcSlZNQnkDoYtyzH8+TAfo=;
        b=ECsWbdG6VnHiVnhps/vYTg6nQnvWl8Foqm1mBhuKqx1GJWY0W4ozYofIfitVguKsOQ
         9Srbkq5MZsnjg2BB2l8saH7agoAF03vsVCFh7BpqZVDOPGWvluoZakuVrq98JfmWE8aD
         wDY/O/5IO3u2HZzv+5R0V8cHY/PCAuDY1v6tTf4wNjtkdPlKwtVP3JdkQhor4QBI8VvC
         rfxmNHNoPjqW1sGuvyDEMXl0n3O5nBIiG89dwQKigTgkqU/oqaOBbG6TJfbFjRj4LbQd
         jxcxwELCdzCEb0g2r5R5Md9Hek+coQi8T7IVrxraNSWbVTyDB1Qa/JZVrThjfctS//Tw
         nN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5yBt82Cu3A4W/6ctS4sNb2kF8rVcgGXZLThUX7wh33xCtUTGxB6FzF7QbC2cut3BpO9k5x90z@vger.kernel.org, AJvYcCUNpjXYlESDcLSAlYWMso3li7KuH9FaYemYqhLk/Oh83iXwPMMtKtQpwaaWOHgnMqQIlbf6BwViDc4NGOJp@vger.kernel.org, AJvYcCV8L6kMR3zCQ3Al3WGB2o/BRWHG2qlCacwqxnQ0aLsBzlzsZrqsD1Ewky3OBYeEg/laNP2WeoeqY1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS50YdpQM08Ztd9Z0DYgLVC92lizUqDf6Y3j1++gZQ7Z2mQcnu
	yfGkPP++QAZJTA1qaIbnpeJz6+53bTteVf1zWCJcIjx6F0SAX4gmFUWJmcc=
X-Google-Smtp-Source: AGHT+IFrVuN9D+SAR11xTnlfT9gEOCWakgArlLgW/amJEoyo+QN261soMAWMVTe8ex0XB7scFixS0A==
X-Received: by 2002:a17:90a:c10b:b0:2ea:193a:37fe with SMTP id 98e67ed59e1d1-2ea193a38bcmr4487748a91.16.1731711964768;
        Fri, 15 Nov 2024 15:06:04 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024eae85sm3507688a91.44.2024.11.15.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:06:04 -0800 (PST)
Date: Fri, 15 Nov 2024 15:06:03 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 8/8] ethtool: regenerate uapi header from the
 spec
Message-ID: <ZzfT22EfTHlT1TCQ@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
 <20241115193646.1340825-9-sdf@fomichev.me>
 <20241115132838.1d13557c@kernel.org>
 <ZzfDnLG_U85X_pOd@mini-arch>
 <20241115150125.77c1edf8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115150125.77c1edf8@kernel.org>

On 11/15, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 13:56:44 -0800 Stanislav Fomichev wrote:
> > > Looks like we need a doc on the enum itself here:
> > > 
> > > include/uapi/linux/ethtool_netlink_generated.h:23: warning: missing initial short description on line:
> > >  * enum ethtool_header_flags  
> > 
> > "Assorted ethtool flags" as placeholder? Any better ideas? These don't seem
> > to have a good common purpose :-(
> 
> "common ethtool header flags" ?
> 
> These are "ethtool level" as in they are request independent / 
> do the same thing for all requests (as applicable).

SG!

