Return-Path: <netdev+bounces-164121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D1A2CA75
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317A3188EA75
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD719CD1E;
	Fri,  7 Feb 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlKx22SS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD119CC33
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950217; cv=none; b=XMYetVnwVv/c5LUZ1wPYKzhtd0BNTmLT39A0GnE+RLtCbIzEW81LzLcABRsOtHA/1sbTZ1FUsvXBHSDfl05kVV+I+dqKHNaKO4H5sb2BSopPXkAA3EfgLCQXi2pHcdBo3ekr645YhSXXeXICL805xF3sCvNOldkvLfeHS8ub0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950217; c=relaxed/simple;
	bh=cP2sgUcHG3+GkBnbps7B40zWYkcP4cSv3URmLeG0WYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMqa7tNi8VUNlNA5MeM1WnMWeeWoqd5AhkZb0ASWhT95lwhg3XXj0hVKdmfK5xb+XSuInGBp8Ar1kQ3webRwacl5Op5F2EmvMBocxa5aEYLmOkRc1yekb+E08DnvUUm7KqfYRqhGePqdJOajEt1LMPsVum8lD0xjAmhT2AlPmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlKx22SS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc6b40e91so84166f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738950214; x=1739555014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkmPtexwI8nJy1J8x+bx228/b4uiSB/blIyffu7J63I=;
        b=hlKx22SSVABd+HwveyoWX0DAnPZavUh4bQs9FOpIGGv4Wi/gZ5rzP6Rg30hGPsV3dx
         DqLC8IEdKzX94AaaAArnWwlVusXkjIkSajc9ozFduOahIsroINUWsSGtKjbxc33/STzX
         caUa07s7kM4Q1G1Rkr7Gn9SLGQN6JG5z8CUd2VXieXWPCv1uhNBLxN9ro/EJAlLU4k53
         SlyEPvWoh86yz56NNgSgkeDblFYuYs6o9dxVzV6RetZH5yyhgds5ZKU07Lvh5qXlmh2I
         74kk12OmWakWiUuDlrnI+7Ebo4SsVBuj9XmjECHcUjZ+mSgN6aL2QhRGOzYogxz0E80Q
         89rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950214; x=1739555014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkmPtexwI8nJy1J8x+bx228/b4uiSB/blIyffu7J63I=;
        b=GKeZgKRih5+q4DeHVUWIuT/XmqP9uYGVD6zZABPjjwIhMLsNKHDi/LGp9pv2lpkiwW
         DtfYNTmTUbmYhbgAj+U7Uzi5V+iaXHrjup+3QXNMtkia44lIch5s6pyDewORwwTKJ9m3
         zxuzbSowkbmaWup8ZrUOXfiHbu1//raam2RbfiqKQZwEF+9UHL6MLMyCBiJLvHQ0h8Aa
         Qj4oX8IcQLh/cWXmv2Hl7WHOViEZ5iv93i32YU0q7HD1yDwA0d5+PmGTnpEga7Wx8uF+
         GRjHBaxKGem0R2a/8W98oY4BzyA+vlDhSIpAgrmvV4RJS8z6U+NQbyEDZVTkDQSaCHbH
         JjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCViB2T1303ePPMVyGKFottfm4Otr2uT18umk+QvoMaLgwTTJlMzJRkCphqrzPqgIE5iayC08lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRKaIQoS8uMmblitOBOA6wlfLQxo7vusRAWmeD+jNkifKRJqE
	Z3K2yIFU/zU2axG7oAX1roQzNUfNhAo+FgQYjo3vxeYifZtjIyCy
X-Gm-Gg: ASbGncvTMca9pdlYdRCHxGi5jFCMPLwHy9o9IFcG9lvvlkx7X1yV0oe9g94SL1VO9jl
	Oz3oKwb2CaqDhnyVHqQHi+mPvJrnQU19m3yKimwm2iypncKVHSHJJ8ML+9I+0Hzmtb+Tt5SCR7r
	9HgJhrRG/ttCBWpHHq4TEA/JD8QMCW+4zhsm+0AmJhjBpzIgFeItcTXrNi51ubr1ZYIKhxABDT6
	GHVHjJKQP+bPCqstCmO0ElUreHMdslYOg4ICjH+9AqxGoxgLHOfRzKPkQHcWXjA/wfmW4mvsTG2
	P/8=
X-Google-Smtp-Source: AGHT+IG11Pc2kGIokdNjW9yoOvHDlH7EpwsiFTJO7Og/oYHydYg6lURB4kMKww92DFFKYw7UzElHrg==
X-Received: by 2002:a05:6000:188e:b0:38c:3fab:3df6 with SMTP id ffacd0b85a97d-38dc913a22fmr1185597f8f.9.1738950213941;
        Fri, 07 Feb 2025 09:43:33 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dca0b4237sm2505074f8f.85.2025.02.07.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:43:33 -0800 (PST)
Date: Fri, 7 Feb 2025 19:43:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: dsa: sja1105: Use
 of_get_available_child_by_name()
Message-ID: <20250207174330.ygfwb63wp4t73dx2@skbuf>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-4-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:23PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> sja1105_mdiobus_register().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

