Return-Path: <netdev+bounces-170701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A1A499FA
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756187A898F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F126B96A;
	Fri, 28 Feb 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qNxtaKeY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B826B96B
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747073; cv=none; b=BWhGKQ8qx/iLgoeYvky1+GpiIztc4tNDsalR/w4vXTedVGfEWrkGheWEzQ9jQssoP5s1FY2XJYFD6cNOobfKCvk7uJIPDST0dq2buBUqLlBkJ4pqGzk/wNJSVjLByTqtDXoLYAJOqcgHvg8qZF9FGGPgT+QiSiwFtCqSL8tTNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747073; c=relaxed/simple;
	bh=GJ22bgLMG3WFiRjpYLAMTm3RGaEZQzTgJQAtB1EeqSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/uQ3XeNscLSZ9hpKR2WyBEL68hRP2RO6rnfKwiGt7Ivu/UgtSoGXwyftawEl8C3SL/iaaI3adAggLnQY6J6qcwVpFSMvDxTM6sGRBySBEzcHWvz3xgjyF8jyv6iPHaBtfPLNd8uEwgZZ4TEuutgIOX//UKur00oUMocT5T94oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qNxtaKeY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso3116432a12.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740747069; x=1741351869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ22bgLMG3WFiRjpYLAMTm3RGaEZQzTgJQAtB1EeqSk=;
        b=qNxtaKeYeJdoJ7LrF9G1WT1vuGSBPsHBk6AB6U4h0yb3N0piEBl8hr1oIkdIQvQ8Jd
         +XlXE7/mnwtUPFqEYQMub1dd4Gfhz2AdRbYLCNhtglx+p/U6A30FUn++Z0kS4ug0wxxu
         eKzJ8pnC1pSNxQJrxk2vsu4xYxq4BTDG6Lxdd0J/7KSGpCnRQ/vrW6UV2hcDUwg49ykf
         uaWEYpYjopycjXc3XdLciFKwo6oZ9clmdlrxeymgHxH0Vy2NvT2zJmle1pc8Ci6Chyk6
         YzGconPbYY7PR4moYwijnCtPBJUmDU/4iZD8/DsOFvGXdPqpSvkqQdG/993TrKK5e75r
         ruTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747069; x=1741351869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ22bgLMG3WFiRjpYLAMTm3RGaEZQzTgJQAtB1EeqSk=;
        b=M3Yl1uyuyr1mipa9M8uazC8zjVB+cuucNPGcCFREY9V+Xtj1lGCq2jYFQca9nPJYqw
         2fvKleVw1j/RSd1fSe7htRs+lDU5F8hjjlCVuMLKal5kGoLOfdtOe+apYqtmkVhUms9v
         uLPNLKJ//JKK335l+koCZ5jiD17vZ8K8pNK9XzVK7ry8UwsaA1ZIHXvbVxM0jxdZmNT3
         RNFjhJAysZrVyBzATGjI4UrUBxn4zP2M3woZf5gGzEKZbeTlz4cTH/MdikBFvI17M7oA
         rBae1sEMFPVRbFp7fiHtmJqSL0PsSX2bCA6TLU48CbtyOG2Kz8d8VeQWuab6YlywltwX
         RTGg==
X-Forwarded-Encrypted: i=1; AJvYcCWBeENul8A3YqvAmoiuvbDaStjMa/BTnoo7WQDVc5RXcifWfzjLJQVj6Gwj4Au+XUByeSN/geY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ40gqB98HQXlpMzjyfQBUg4qsIPzA7vVIJIPyg6QzTo2reNLT
	8oFLX+2fXQnjuukj+TotVz7EqXOJub6bVypys2jsO3F2DHSRo5S7qRbpgqrsk4U=
X-Gm-Gg: ASbGnctWwSbDnVHVLgx1VvbEylbPYE0vzaR2qQAXJmwiS8Udq6omeOjpyjqbZwX1jRC
	WgYuKUSufjA0SHfEcMVFCFiPjjydBWTocNPz3h3vy9LUJQSKxhBLbzaBGNNECX/fii5FSewQ1RE
	b6xbePK2Mz46Juu9+fxblASZH/s0NMGOQgJKnl354KeM0RjXrEJ7cFO5UD97XSxx7iuhcJ0eafi
	4BzfUz8IMXJZykctqePCnytUUdOcr772l2iQe0TJy8G+I2NR59xNmbwfb2z37Nb3BuDZJPRMhh7
	3Xx4OcdJ/pW5DeRNzTbrWrgo5nruDNV1HR2a1WgJgZJh50FTNp3dtocw4mFJInxrP5E+HpWV
X-Google-Smtp-Source: AGHT+IHxaeh9r5KXGg7jxz+2IZARwypI80ttiiaU0W5DiG3+nujLmQuTgD/xKqrS0a7YzwU0Ycd5Cg==
X-Received: by 2002:a17:907:7b82:b0:abb:519e:d395 with SMTP id a640c23a62f3a-abf26424e91mr310250666b.20.1740747069634;
        Fri, 28 Feb 2025 04:51:09 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9ae8sm283213966b.36.2025.02.28.04.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:51:09 -0800 (PST)
Date: Fri, 28 Feb 2025 13:51:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 10/14] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <6fvjidw5hc5mbb7msxu4aeoyros7en44snglqi435ojbdlhaea@sqhbohp2w2ma>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-11-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-11-saeed@kernel.org>

Fri, Feb 28, 2025 at 03:12:23AM +0100, saeed@kernel.org wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>Devices that support this in permanent mode will be requested to keep the
>port link up even when driver is not loaded, netdev carrier state won't
>affect the physical port link state.
>
>This is useful for when the link is needed to access onboard management
>such as BMC, even if the host driver isn't loaded.
>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

