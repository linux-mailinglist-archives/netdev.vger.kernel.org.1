Return-Path: <netdev+bounces-170687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E3A49992
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827AE188A003
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3626B948;
	Fri, 28 Feb 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wad9z8hc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1026AABF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746403; cv=none; b=EzIKX6PvAkxh6ubaBXqxglfJW8vxBG+KsoHl6T5grtayRbkFAxsZMREGvEnevodHsVIM+gkG3H48O0s4pQiDSA4v9DnZPje2MHjsY7ahbOdKEeREazdbbIxjCwhbzz0moC8nMQhQyGZ0x5QrYdiXB2FkFi4RMmIykdFCq1RIXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746403; c=relaxed/simple;
	bh=CA5mI02zJAx9xhIlqzkn7acmvfRcg5z/Ks9gil5paZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ6kVBVQu4JSZO1DegzsWbzyxC3o5YWlodneCbUKVrVeQ2t94I56qX1IMm1aC15Y5n2YdDWPkEzpXWVkcwS7RycJy6UmmNzg18HSlQhlkLImQ7G/CbXmA+8SFunCHlGm0w3fu1EG+u+5aMgJsR73L7WuGgR0nmUa/Ohs2LdDng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Wad9z8hc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso3436199a12.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740746400; x=1741351200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CA5mI02zJAx9xhIlqzkn7acmvfRcg5z/Ks9gil5paZY=;
        b=Wad9z8hcGi+FLm77HzR1HAFB2iC3n7wYQ5s+TtrIu9zz0BD8Vg+ZxFxsCxOAicnlU5
         TnMpVvJmtnC220ghMqjMUcoowkJBBdJ2J/38TGwk01/cAw02KeUolFmud90p+ToYaWuS
         RLE8OZU+0Z1wr1V8FCF5QIH/TPYgzr+Ur6JaATZMnzQgxgMSKmXkOaJ+GJzpX/YvyE6O
         pmK6ucq7Ci89vhSaXdmdYe1qFJhRQPa6Qcnvu4bnj8vXXChJ5XH4mwL4jOuCnWCNAYan
         J/bpn/IdP2WSc2qyQsAMTVoWup6nXfman3WrQjhQXRTvdPRhnrJa9Vab3rVeIPBCted2
         vefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746400; x=1741351200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA5mI02zJAx9xhIlqzkn7acmvfRcg5z/Ks9gil5paZY=;
        b=pV5g7Arl3zIfKb7wUq4IadIOucLQaPWMKMwTc5VrYpeuJ2/CvzOcqshJRnM916yyS9
         XkNuUQiJstmOFLZSKKHDv70aeuahjaKcCns9vB/Tw1dsWOhle8at9rxGW/NFKaIyp7ol
         VnFbzBj5eiqReg0wBp0QA5g4BWhAmwxkwEbYvv1hvObwax7YTK37nj267BI8CfXL0kbb
         QINq5GVuixNAn19j9usNS7cJWahEp4pNGplCgqVkeuEIjdXjcNBJDDdxIpuIY3r9mt5h
         Ge/upXcSR/xK+RePtshycsXFJ+RwJKOVhqNwV6GZgF5Dd1paGHV3LUCaSUE0zx5bDrcz
         2VXA==
X-Forwarded-Encrypted: i=1; AJvYcCUUBzaj9aq7iLMtSQ7YsA3j/xopZQ8/iSIaWjGOZEXmAIAHQtXUnknoykKpO7oS+YEWgkUILHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAP2yanMpNQ0THlvYMaKfi0om5uBYO8tLTc+zGoyn5sn41b/7F
	nFardbbBNUINywo9MXxaz5ZmJk2THIfQH08eZqJFHOSPo32mLpVgLKzijJt+Xys=
X-Gm-Gg: ASbGncv+NO1y/jJUu/KX0HKsd5RLcJYsI4rgl/dQa+JwVcvqcjzPvJTifFOS99iDzLQ
	Y2woLIKyAqrZuml+Os4Ly8PRE2chcQ21n9OzyWrQQ9D5yZSIGkOH6H/hgDKb978teorXLKjWVTt
	kYlzzG7gtCtvQFV9VEtncoJqTmV5VzTS4Hh2nikvDyu22lUROLtKpj6fH3dhdvMpemgWbc4g2LE
	Lp3+jWXoucfQ2LiMTYHJ4bUGVtvoo9hRrYVn+H+rEJfRH4omeDLnSV7Uhbi1gEzHezxyQCOzoXf
	L3cTCOEhKlA+BEiRDd6hgY9nib33gb//NeVQV3WE7FWT87+ZMxeclw==
X-Google-Smtp-Source: AGHT+IEFyNMlv+Oh7CwWs+iH5Wg/nOXNlP8KiC0rppAn9gfxq9S4yenJcmQ+qHlUTZG3WWB+e5mHIQ==
X-Received: by 2002:a05:6402:2354:b0:5e0:82a0:50e6 with SMTP id 4fb4d7f45d1cf-5e4d6b70f9cmr2188302a12.20.1740746400257;
        Fri, 28 Feb 2025 04:40:00 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb737asm2474125a12.44.2025.02.28.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:39:59 -0800 (PST)
Date: Fri, 28 Feb 2025 13:39:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 02/14] devlink: Add 'total_vfs' generic device
 param
Message-ID: <d6wfzqngqo2ppqh2knbiafvsta2glrpgyrwoxjhtjgwsfel7ia@ojyqsnwcgqrz>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-3-saeed@kernel.org>

Fri, Feb 28, 2025 at 03:12:15AM +0100, saeed@kernel.org wrote:
>From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>
>NICs are typically configured with total_vfs=0, forcing users to rely
>on external tools to enable SR-IOV (a widely used and essential feature).
>
>Add total_vfs parameter to devlink for SR-IOV max VF configurability.
>Enables standard kernel tools to manage SR-IOV, addressing the need for
>flexible VF configuration.
>
>Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

