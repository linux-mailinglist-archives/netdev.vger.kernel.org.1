Return-Path: <netdev+bounces-145471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CE9CF96F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74D428B047
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70E204F68;
	Fri, 15 Nov 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmL95fDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8111FF05F;
	Fri, 15 Nov 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707739; cv=none; b=bS0Qzm2fTi1Mlvh48ewGpk0p9J3D/HVBcBmCTns7dF7iYNOEqtEfCehqkY6F8BJd6ljR/gXhqwIxBWGNJfLAO7tgkf8BUVRpsQgB2LEws98s6eyHyc8XXNwMCOdOWv+D/0LoXjHNqzGuHJ0z/nOgkjJAEDS30hYubLOeCyj+3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707739; c=relaxed/simple;
	bh=8lMmfOqZiODGIcx4SlXUkqurOh0F3j8AKrId7NUWn7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rteLvsi8GJntePpe+VF5WpUth0kdhGYVHQQ5LiL6V0DKjSWSg1sdMkNNd+2BpHP5UHVlVgUTSLjab+SUsgGXpbk/IJRxzyp5a2X0CH4oVR+NjB+DpC6A34giyJjfEjaSSpk6XKjSFPGubA+9U1YQcjJ7QwVLk6QymfqA1wEC9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmL95fDO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72410cc7be9so2024746b3a.0;
        Fri, 15 Nov 2024 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731707737; x=1732312537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmMYbxJ4coyv+Z6T49LrludaC9pLdJpHpgB5sLMwpLA=;
        b=cmL95fDOKVCUzjHv9GA77Wk7oK4cmdwISnx2PBX619FHEpaReONTILy7JLV7RbT8Bu
         nYuT8IXYrtxWjtWgOatyn6ls4y/KP3BFT3WRc7Pv/x97mWpJS6GibYQ+Tmx1atjVot2g
         4LStXU4yCv74GHeXGSJN+kJIXzK50+Gyqht+5N+YcBSlng5kWkO626u/YCsV7n7L1r1e
         3hyCILHKNOXL9+xuJm/xHVugPYhH7hll79mnnjvwxcYiPKWmyJks3euzSLyhxcXRyKhm
         o0SOzRGOkgHBuMYgCD/1eWh+YZLzepa/nPA4m/3inq1l+PCcTkQFdhKHHw5GAj7Yevav
         /0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707737; x=1732312537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmMYbxJ4coyv+Z6T49LrludaC9pLdJpHpgB5sLMwpLA=;
        b=OLQpSqJLZ9W7H1JY1g3gaCbM6zSkGc4anl19Rbag7gFZL/3Xz9pu03c2knesRDcd6O
         9XOD0umYvOmUrDEq485cSzmO8F5i7rryUQ1wJ4UdVpqtLzgVseexuJuwj6DJd8qknK6V
         FG8Q5SHyl6EZXGt6IUAegFy4nTy+lvKzhC2i0fPy2qKhuUw3Y9EiEb0UJ4wO+QHkjs/V
         QeEVHCpR07KwW+d373U3LhsFHUPnDBDThlRRfLJX8N892GIVoLxfMrq8+EHEDH3qItdR
         0wymHYrRtstWGey15J4NuAOHcflDfnNvVfJedjnU36x4XFZlQdfoG9BP2wPRRhtHVc5u
         A+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWuQZcXN/Jt1f2k5pUSt7BCJUOI+BHf20RQrPbPh1+zaO8MRE41CgfgnVlFGbGe90Qi5K3fTRWhmqtYN4Kn@vger.kernel.org, AJvYcCX7zSIF90OtL/IOoFJ3uhduu2wTpeOAy9QFDCJA6VRgljJVWYhYbL39JnlLTY627h61Eq8FElJihh8=@vger.kernel.org, AJvYcCXU66MLTVyVbueR7BMfUOIt7Bz3Xr1b6gJ10KhDh8TUTs26F96IRzjmII0omsMz9W18YcrpRPHc@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4f/c5pPdv2Xy/G5/zHpUWnB290dpEAE3AQhnypybOa86C661
	5Cq+crC5jxcPuPdneqpJcLWkJUqa8vAoVTLGHDXfSyp2FL5R4e0=
X-Google-Smtp-Source: AGHT+IGGffkc2/SUimzY/QWeSMjwTUkWseb8vdJ5Su82+S0KbYX0+K29jVfXqiMuwQ5y8CO6eVp6sA==
X-Received: by 2002:a17:90b:4a85:b0:2e0:d957:1b9d with SMTP id 98e67ed59e1d1-2ea154f6fc4mr4900048a91.13.1731707737323;
        Fri, 15 Nov 2024 13:55:37 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c64esm3347129a91.42.2024.11.15.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:55:36 -0800 (PST)
Date: Fri, 15 Nov 2024 13:55:36 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 3/8] ynl: support directional specs in
 ynl-gen-c.py
Message-ID: <ZzfDWB1O_mgF0o7j@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
 <20241115193646.1340825-4-sdf@fomichev.me>
 <20241115133244.6e144520@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115133244.6e144520@kernel.org>

On 11/15, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 11:36:41 -0800 Stanislav Fomichev wrote:
> > The intent is to generate ethtool uapi headers. For now, some of the
> > things are hard-coded:
> > - <FAMILY>_MSG_{USER,KERNEL}_MAX
> > - the split between USER and KERNEL messages
> 
> Maybe toss in a TODO: comment or some such on top of
> render_uapi_directional(), to make it clear that the code needs 
> more love before it can be reasonably reused.
> 
> nit: possibly split into two commits for ease of review
> 
> > +    if family.msg_id_model == 'unified':
> > +        render_uapi_unified(family, cw, max_by_define, separate_ntf)
> > +    elif family.msg_id_model == 'directional':
> > +        render_uapi_directional(family, cw, max_by_define)
> > +    else:
> > +        raise Exception(f'Unsupported enum-model {family.msg_id_model}')
> 
> You gotta say "Message enum-model", enum-mode alone sounds like we're
> doing something with how enums are processed, rather than message IDs.

"Unsupported message enum-model {...}" ? Will do.

