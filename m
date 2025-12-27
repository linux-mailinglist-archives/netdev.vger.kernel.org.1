Return-Path: <netdev+bounces-246158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BADFCE01AE
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 061BC30111AE
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA93242D2;
	Sat, 27 Dec 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYPif88n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B22236E0
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864996; cv=none; b=LOPcgxMu9+TIm6CuycNuR8MRJKbSWWnEn2rGSnTVsB1LmVA8gkn/SEP2Kmt1s1JUkWoobAMhj8ID+Xr87zHQh+KgBa7UuWqVXskwxKST5jtH01P7XXd+Rjut91NtEbbmIZSx+gQl2vcmIURvJZTO4FRVKDNC8EhZJZMl2oOpqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864996; c=relaxed/simple;
	bh=tcOhN5F2jVUyljFaKmwclxjwwd9i7p+unxHW3FV3GSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dnhh87pNQKK7FGEGq69LDpgv31KBdUqARtrOalUplKTG3cYH9Wet/YELOqMykI8jibMbv98kcHSTzIUBaR7IJyu8EcOX9TV9ct1y6BiqB95xg4joQR1QfxCYaClqZAB3ktO2mydNKkXCOVAIjPYflPbC2DLzRqvQIA+taJOZIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYPif88n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0834769f0so80019105ad.2
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864994; x=1767469794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcOhN5F2jVUyljFaKmwclxjwwd9i7p+unxHW3FV3GSg=;
        b=VYPif88nXNlbRiRAedXIM5a+3BYkAgEhhdhGmz69ABzLYQObv8fSjDezVYrt0Jiv73
         aBwANTYMBSttitjIBXzpd9R3VbK5fvTXC9qGA6TZ8m/wTM7aqFqP2uG4Qexf0ZFKSeUy
         Amyk9SBnkcklxdp8b90uzoPWgLIylGknU0qtp4rYJimZLaOx5eTi/fe1H827Ib/JWqJs
         fpzIYToL7jgjcoZkScJN2Wa5sn5VArCw3EF7621Urad4QdlPy1PSU5boLVEwWz1Pu5bz
         Fag1mZDPa1pBoGcDbBR9vVc2VWhVItoDSqJTYsAIXh+rf3iW4narbe5pPb41ueW9Mglb
         Y6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864994; x=1767469794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcOhN5F2jVUyljFaKmwclxjwwd9i7p+unxHW3FV3GSg=;
        b=ogz/fNXG7Uu0IsruCQCCimu16Hprg5OF6AGuLnW/sNtXM61smGP/iZvuXQiV4r2wFs
         Kn4LihPV+uYnX19w35hSJu/UsCmC0WQPNh1jmnQWo0uxiFugJcyjtBoTHhZsLLKFRMvB
         tS0+nM9MAstNafdIb0HyeL09Pi5/1qqXIA2d43UjF57J8JRihM+TD0SMAentzjplmPsE
         D5Dgm1SJFO4EfvjQIqr9m6h8AigFvzTmifhmzh6Vqrda7TaoRRMl+bWGRxABH6QgHn8H
         PBdWFA1mZ85ZDW5R8f+NXyyiLqZOu0mDMc4CArQU7J0CavCj/izBB3RvrMV+ibfi8f4T
         ssEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2d2RTofJ4PZXRtlS+HHeaPgVvjzuOXczq5Ol5qohn0RbwWT+mwmR271CLhGAf4Fo/ZXzuzhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUCyzjhlJr9DskPd3j50q0/70o9H/X1OtR2HF6+Cqt+zZdS7h
	V1gLrweaUN33ZD9y9lrXk9BLzhqRjLDYVCvD+8Uh/L74afhLDBX3OrkV4JcCXg==
X-Gm-Gg: AY/fxX4aFuYBjM1FN+ohpInpWUoK9D5SH3PdrKGb1tcowMlefdJq9FG/zUfHCB8+xo1
	I6idGLCwTHpl2XIU9EuQ8GkhuJaiCfpu6dcrXhAcNKwRM7kBVEQxPAicSYm/oDg7Zw591URfumf
	kOAYdBhZMrLSpbQapzwhC9nClVQK1SxIfTb4sjudqwPw5pqI5Gotm8ylpBeTSdIT5URUOhe9ZEA
	QEzN0ItBFi68qaQqcMmL09gK2TSdl+M1cqy5wGpxRojt8+BETMJDgDHmWswkoRHS8ioEQ5JWedy
	8Kt9B6uyBSeFgybIxx0jsFWmoRi68p+Ptwx1wq72CWbLrVVwZ45TE0/UObT3B2Ia0gMhiZnPPuE
	7+tJIGAsxAIGSqkaxTGUd/mv7kr8y0gxnbyqj0U37fehOMTIbur4FB7tYG4pnCKpfPDc6l9sJ2V
	/8DCeXYEtwXFJbI/hT7A==
X-Google-Smtp-Source: AGHT+IHUmJ2kT9c+ffkvaSVuIXDpr8kxbxH8p6fmp38yx57OoC0P4CfNd9P5Zk4bVWgwm9EFWoqYVg==
X-Received: by 2002:a05:7022:687:b0:11b:baa5:f4d1 with SMTP id a92af1059eb24-121721aab3dmr24764391c88.6.1766864994173;
        Sat, 27 Dec 2025 11:49:54 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm101037018c88.11.2025.12.27.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:49:53 -0800 (PST)
Date: Sat, 27 Dec 2025 11:49:52 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Manas <ghandatmanas@gmail.com>
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: Fix divide error in tabledist
Message-ID: <aVA4YJIT6at11JwH@pop-os.localdomain>
References: <20251222061306.28902-1-ghandatmanas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222061306.28902-1-ghandatmanas@gmail.com>

Hi Manas,

On Mon, Dec 22, 2025 at 11:43:06AM +0530, Manas wrote:
> Previously, a duplication check was added to ensure that a
> duplicating netem cannot exist in a tree with other netems. When
> check_netem_in_tree() fails after parameter updates, the qdisc
> structure is left in an inconsistent state with some new values
> applied but duplicate not updated. Move the tree validation check
> before modifying any qdisc parameters

We are reverting the check_netem_in_tree() code due to user-space
breakage. I hope reverting it could also fix the bug you repported here?

See: https://lore.kernel.org/netdev/20251227194135.1111972-3-xiyou.wangcong@gmail.com/

Thanks!
Cong

