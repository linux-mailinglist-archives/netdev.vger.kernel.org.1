Return-Path: <netdev+bounces-261277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ASdGvIhoGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2B1A45E1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1672430A8706
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B63A7F63;
	Thu, 26 Feb 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjUVAQ1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354E3A1D18
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102021; cv=none; b=qbeOSl0MqXXZvvElR9sYXFyrBkIOfu6VDSKwv1S7ma4A44Efj+eSpH6EyV11DPA0v1ih7w3HYMVF56pw3pm3CvJTTP9vmSiXs/eEt8SYJ7eiIcfoH8KCvLXCwzDoHoo/txmM84E17YFmqNSl75rema/EXccUVawJXgjtHDsny/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102021; c=relaxed/simple;
	bh=Enj90gtfUFq+0CH7LsZ51Q9ykjr4YYVafTlxZ9EaAMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWJMnVkwRJGUDTo8gt09ZlChofGmGEAGm0DDYYFzdDSQuIF3jzQUnm4JggZxI+oACxl05lCLljFjiI0nfdZLvqzikT1wJe1SJy5sfG31MSRdNsugVyPFiJf+xcftIujVGcUQBhK081D576IvutGPM95LMAJgBgLNu+iRHILSJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjUVAQ1o; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9a9be502so4626075ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772102019; x=1772706819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aL2jI/4a7nFCZtj9lSEiRIWCdkLhqPjvVGi39JfAcNk=;
        b=NjUVAQ1oz2oR+u6ouSYeYP1ebsH0B0qkuTRzPQ7/d0oPcvlsrTk6MhCpxecmVXYUkd
         ARnp2C+Xt713TBuAQnDTAYyyhl/0HIH6hn2X6wVekrV5DkrI5m0WbeH/iLK4Xhinns9i
         eKl3yrEFfbwlr7wkSlvlZNDMUswtkvKoeHP9kT0Crq+6X9XC+6zLXeK2hcBHlUgYlr2f
         NMZSewU39WBjxzHtitBmLYzYda0OyBQO3gljI/bFCcjoGM3It8G4eBtA/6KfngDtIoPK
         KjJgVj4riYI6xFCrZdFWqrGSc8ACl+K0XCErVljCEaBK/UPdXj/DQx+AhLZVG9i6uy2J
         X5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102019; x=1772706819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL2jI/4a7nFCZtj9lSEiRIWCdkLhqPjvVGi39JfAcNk=;
        b=ufgzNJJa8i/m0bt9lQHUvDrSiAkq2ktMTcX6+jG3m/vvR5fiFs+k/fOVIV99Q8JtZp
         /51UW4eKqJlAeOYrBmYhwAPDs5QQwY1laMDMZ/GkaNwJJGMt7nS+4TZv50USYAbFlYG1
         gGin4IQ4tLg8fL6VsCNnkIYKQBkn9OVXwg1LBM3WTEd4zeoJnnGxrZwnY91WlpqnWrko
         gG1CsVZD2h4GRNDp97iJTLyj54V79QcGxuImUGXzWJwQx38bYmDAUKSTVNWdt7xJE4nf
         ABJ0zu2+OjTGmqd9tCK+SuM+6n3ImlnMcD7FeFN30EiMkHo8zMzfz//BjIRk2YpmwaPZ
         +GLA==
X-Gm-Message-State: AOJu0YxRtdrzyv/YsJnxbs50WP4YTQ+82/ffCkQoAsB9fHWAEIp8eDeB
	b2bvrw1GKqOfQ4ijT1e4ObD/KzhCBjfA0zOiI8eZdMB+6rNKv+pD3/Co
X-Gm-Gg: ATEYQzxVYRzgsP3C6b2NdfEDMYN19P/SxZdDcxrwoicf1oT0zDMSguRNaQeMAkt7rmK
	9c+BGhKLhadjcyvHL/5bOiixywiKi67HXC39pCHHpnb1/rTRmQ2gzxlxCEf4ew6PEVdtS39DgF6
	/IkyT+NifCglYBrRsdCmNpFYt7nIleyv6OBWrySgeibUvJ/ASFxf3N1P6gTMIrLHIw2AZZXjgx4
	2J6CPAjOvPMhR/hDVMT5iI3thcb0QdeF2yqm3xWpE16j+lJL6iBT5uOq7Jxt58yZM4iXpaaFoVz
	x++XIi3N1KZKkkrs6Yo4XWMhYM2NU2T4hc5j3UinF1076nCg3jyMgefo66C51RNi3k8HWSNUEdQ
	Qbx810aeBxB0easxovLe9lGgCw5wjazScv1ICDKXVIRiyLUVKf36+FLIu8ZVsuoaomFB69ZZwnN
	GiIuYWeB1/j8K7qy1lOk+oja4vVip3IBTSYWZ5lwunCHh+XqTDW//N7ypBU5z7
X-Received: by 2002:a17:902:e743:b0:2aa:f43d:7c42 with SMTP id d9443c01a7336-2ade99a71c9mr38555825ad.24.1772102019024;
        Thu, 26 Feb 2026 02:33:39 -0800 (PST)
Received: from eric-acer (36-225-69-192.dynamic-ip.hinet.net. [36.225.69.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d24b3sm20012575ad.78.2026.02.26.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:33:38 -0800 (PST)
Date: Thu, 26 Feb 2026 18:33:34 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, jserv@ccns.ncku.edu.tw, charlie910417@gmail.com
Subject: Re: [PATCH 1/1] net/mlx5/core: Allocate ttc_params on heap
Message-ID: <aaAhfgBoQnI3Qdaj@eric-acer>
References: <20260226092857.1583984-1-yphbchou0911@gmail.com>
 <20260226092857.1583984-2-yphbchou0911@gmail.com>
 <20260226100514.GH12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226100514.GH12611@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261277-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,ccns.ncku.edu.tw,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7B2B1A45E1
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:05:14PM +0200, Leon Romanovsky wrote:
> > +	ttc_params = kzalloc(sizeof(*ttc_params), GFP_KERNEL);
> 
> It needs to be kzalloc_obj(*ttc_params).
> https://lore.kernel.org/linux-rdma/20260226071913.GD12611@unreal/T/#u
> 
> Thanks

Thanks for the head-up. I'll send a v2 patch.

Thanks,
Cheng-Yang

