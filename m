Return-Path: <netdev+bounces-240955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3AC7CC66
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F3344702
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3A2F12A2;
	Sat, 22 Nov 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiNkRK7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3833295DB8
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763806567; cv=none; b=pG/iFwE5H4hz400JkOFwOd6QnpT1VPd+46/UHz+xYW7GU918zt9f7Oi8yW4pSC8QfOefPhBkPwaIoJ9cbnuLjDLSYhm6qPpee5mLlfyxc4RK5jUvgE1xIiA4AoOSul3duHvp4J8fZpaa3aSkhlhYHYHaPdoFOkIxickWQOQ2T6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763806567; c=relaxed/simple;
	bh=okpyZGlEFjEuEDFNYuruZwkefkPmV4EIGxCGt77K1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An92Wor9Xbx8Zvqlc35J+sRvBGPpVuaI7V9E/zIml9hb6dmJ4m/ZiAF6bldoxEZ4yI3bJgEd0auJe0o/wa4j81H8jbRZb1oIPFm7nPvtfAwEJ/Ekr6zJyVB7VfNNJjQ2BbLOb6YwZxi5I4rDZsp4IPw7V1ghgkBKAFTxXhAmJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiNkRK7F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735e278fa1so567116866b.0
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763806563; x=1764411363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mS/vz1rW7oaq1ahBZ3rleu8uUoiOnYHPIRfP3oM2Z9Q=;
        b=eiNkRK7FWVQQ4EFDGPfIPJkC8lovp7vBYF/9D8EplMpXmMyibk0T1MjtegsoC2UPrl
         KpOrI2dRYkx8o7MmTvZiurG2k2MK3qPG3QzU4k71AAgU6yckiRV2R6FXtmiGvRYvHkll
         R9KjbSsjV2f3rx2nC3lHAAT2GGo7oG5ojlbeJ8HVTEK8/2qR/2TozhBL5nB0VA4rrXfF
         tu6Q33YDZN2VhkoevrlSxD/kN21wuSgXXXzNgGELpDggjNmswQDgH20wD+7CJzNy/E61
         NdiCVgCZ6FlE9Sbj9EMfrjbdBcvAqBHbQF20DHZO5tzsaSr9zjwN1hjAezc/7dVaY0P4
         8/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763806563; x=1764411363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mS/vz1rW7oaq1ahBZ3rleu8uUoiOnYHPIRfP3oM2Z9Q=;
        b=PDL0zjc/ovGe6hv4jtfdmZy+g9u8ydjpResgL52O60wKJpPCHe/y3sH0aUIDm149Jy
         PDChKCdu5xYEevpVlTpKZTlnxW+YdUd1f2N4Ic5Mz2Ui2BcKIvUiNMFbnlkQt/+zIOQI
         QEuz4+MVy0bBuWwV9m2cWUrpQ7B8etZE2GoeJQMZ1mkFCfSmwNmTbGWfaaFg9MJHgSAU
         jQUXYQk/BxHkPq55RSXiTTpyRC4v27jHe+ZCYHSZya6LHtqopTSB1KWhKp3Ez2d5GWqe
         QyMizlchsy1F645/heXwFscuhCPXdg8qoCplxYli0s53w9+BnO5Nj+0dn48oRR20MSNu
         dGzg==
X-Forwarded-Encrypted: i=1; AJvYcCUiQMayTChrtafspYr9yk0cCgreIVKAnmUh+6G+fq1Gv1HOsL1ih/fwyrWko1YgZb+IVopBR7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIOFS4gSEM50WSTin+gQ6EstNWq9oeF7jR4wexJD8Lq7mm7Ho
	i77kIaCxQcJ35iPlYXIfTsPJIxpodOifgkNBlUMe1jdFP7eGASpXoC9G
X-Gm-Gg: ASbGncsO1KVcgvd9bYBOFOU724CDHgE2pg/Xy5je/1fUzPGyFrC4X4kE+aRj1hoq6i+
	/gUuYtS9KFG3cmWH8Mw8c10rflIqtxOO6DIWphfEOxLxKeu8yalqezr+FZrAIY4BeypsoXOZxp4
	Hjml3wDIoqUHOQVzaRfQSnlfZjAu0Pmh5SGyMWTHzJdLp6xcRBFwSblFY28L+9tbFGINFsgwOai
	GZLKWPcjX0iYjJj59Yv5N/IXuE/z6IcusI4nMbDwiiyb/bK4DbioJkrovXGbewc5frsIiinyXhZ
	x/ovJWSSyXOhoH/MfqxH23Azbfb2YltwfgmIcLyK2wd0wjwQpiEd3WFsWdrn9yYsMOMHHhSHsrb
	/iJNIyw9DWMmPuMV4xMO1p6kHzbnZIEkgAa4K/NA/ql536L/J0xm45rsE4qGRlWxKepLhrwHpLp
	sEVRjPeGMDjoyeqYq/Qi5r0eFyF+mujFlW2c6o
X-Google-Smtp-Source: AGHT+IFvc6Tdcl0gKFGge7EMecimqjBsOE5KfFFBnMOWlWkZjJiEqjTrnAEKRSLZBoXUKpD+VYqOVw==
X-Received: by 2002:a17:907:1c26:b0:b70:5aa6:1535 with SMTP id a640c23a62f3a-b767157138dmr624288566b.18.1763806562727;
        Sat, 22 Nov 2025 02:16:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654ff3962sm698791966b.50.2025.11.22.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:16:02 -0800 (PST)
Date: Sat, 22 Nov 2025 11:16:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, gnoack@google.com, willemdebruijn.kernel@gmail.com,
	matthieu@buffet.re, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	yusongping@huawei.com, artem.kuzin@huawei.com,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v4 12/19] selftests/landlock: Test socketpair(2)
 restriction
Message-ID: <20251122.4795c4c3bb03@gnoack.org>
References: <20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com>
 <20251118134639.3314803-13-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118134639.3314803-13-ivanov.mikhail1@huawei-partners.com>

On Tue, Nov 18, 2025 at 09:46:32PM +0800, Mikhail Ivanov wrote:
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testing/selftests/landlock/socket_test.c
> index e22e10edb103..d1a004c2e0f5 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -866,4 +866,59 @@ TEST_F(tcp_protocol, alias_restriction)
>  	}
>  }
>  
> +static int test_socketpair(int family, int type, int protocol)
> +{
> +	int fds[2];
> +	int err;
> +
> +	err = socketpair(family, type | SOCK_CLOEXEC, protocol, fds);
> +	if (err)
> +		return errno;
> +	/*
> +	 * Mixing error codes from close(2) and socketpair(2) should not lead to
> +	 * any (access type) confusion for this test.
> +	 */
> +	if (close(fds[0]) != 0)
> +		return errno;
> +	if (close(fds[1]) != 0)
> +		return errno;

Very minor nit: the function leaks an FD if it returns early after the
first close() call failed.  (Highly unlikely to happen though.)

> +	return 0;
> +}
> +
> +TEST_F(mini, socketpair)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_socket = LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	const struct landlock_socket_attr unix_socket_create = {
> +		.allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family = AF_UNIX,
> +		.type = SOCK_STREAM,
> +		.protocol = 0,
> +	};
> +	int ruleset_fd;
> +
> +	/* Tries to create socket when ruleset is not established. */
> +	ASSERT_EQ(0, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
> +				       &unix_socket_create, 0));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create socket when protocol is allowed */
> +	EXPECT_EQ(0, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);

You may want to check that landlock_create_ruleset() succeeded here:

ASSERT_LE(0, ruleset_fd)

> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Tries to create socket when protocol is restricted. */
> +	EXPECT_EQ(EACCES, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

Otherwise, looks good.
–Günther

