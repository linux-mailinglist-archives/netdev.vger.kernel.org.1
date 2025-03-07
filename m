Return-Path: <netdev+bounces-172923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB00A567E8
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A783175608
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49279218EA1;
	Fri,  7 Mar 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="k3Cezxij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81E14A4F9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350940; cv=none; b=AqPH+imIZtxLaL0R5q1ub3I8a2lJ0dhpO50J1mNgb5H7EDZDwoYdkxiRFMyzd/eCRKINQLecGXE9wpocp5O56XiqYSILmH8aDy2Do8vVNwNXOoThqkNLZouuWvq7tGk1Th+JR4RU4Oy018YD1HkbOCKLVHMfNBXvnQ3R6HWCXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350940; c=relaxed/simple;
	bh=JUDJvweS/z5/VCSm9dP1Xxb+hExW7ENJRjxfohhsdak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcL3j4RATXi+R31vxzonm9SJzzvcOjRg1fQzOJeGVgiEJuA3d7Mr/PMcOd6/rtBm83kofE8mI5sdkGnYNQwBAcUPQFoWY4RPw96cey3Ud2Y1LMFQupkR1Fq1kDbfGJRtyKGr7pGynlR6xgyqVOHSgXUbVGRyenifTLZYypTo7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=k3Cezxij; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so14034855e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 04:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741350936; x=1741955736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUDJvweS/z5/VCSm9dP1Xxb+hExW7ENJRjxfohhsdak=;
        b=k3CezxijvTrcejXV1u498rjbimIChut3gXfRYAMGamrrhinnMvPoeG31nC4AKK91ij
         olXaeN4GW6WJ9CW8ARa9/0UWK2xWHQEcwHflxMjMUkG3T1GEYjqh+AduymFdGfe5HwUQ
         edQ2acVWs+lNuH89XjITTU7K20Zms6n9qs/aRXw79Fv+78qvs8QKXZG5vv0rW2+wKNgN
         Iqba5t5R65QzWcAcCGBEeCwWpA4rKj8c/kCHoob62bmHSZ1uPdp23zxAQEMu78AIp3q9
         j8AAScDUhzZ4RHYrTVD3lTJTNGKCCZln5BjpvQYrtPYTcxvZdKdgyUPJiiP9AxrFcMr7
         BSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741350936; x=1741955736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUDJvweS/z5/VCSm9dP1Xxb+hExW7ENJRjxfohhsdak=;
        b=Sl/iNty6eqbg+LkoAmaVncvl1PISoAUP42J6W5sIWCmKO5uRvtbxLsKP2derv8h4Xt
         yQ3A8Jfb5we5SL2YlSraEQ+YQ592CyZ6CjGk85JFtAz8NXhssg+agSbLxErbSs3a4pcZ
         4NRmiLT4NDtpDoKDW3d3T53LbzKKfA9meeT6Blmxg3n/qSnrr7c5VumckSMOhrrFbzv8
         C5CMlUd9+YJhcUzkzb2mF/Y0ztp3yxeNDgBehDIMxqRe2nGGubFOBi15AEYxWfiGwIjR
         wCA9Wd4IvuBaeDCaFZb5FRjKXH8eKKL42G6DWdPeDmxIj3h5konPLbylltvgtCAnGM5a
         1bhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1SnI8zI1ef2vMxBg4slzSStarHWC7KWmmr6NJcoas4X5Cj+lrS3EVJihDg/caBeZHdzLU6Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1I/ajfop3uqBDNauWP+kw87k3H2fhaCP+qmt/wtx5nuIW0VNh
	fOgzUE7oS91iC7jRql7MOaHxSjbcbVPXSaB+Fjz99vtZ4Uiwxfy4JeKyZsKX0qU=
X-Gm-Gg: ASbGncvWjwW1CqHebXECh6C/oZoyBBu0kSbd6OEntlBV5IgDYU3uzYrOyQsmnnV/yoy
	Cu6lS93JFrDT53iSlOMsoNl+v0YANCXhP2h3QlKkegsB1ytTfVk4tgTFDufGrxBnQ/dvhm46P2q
	gWOTNq92Czv+/+csun7hKkTantDh0WJ1+doEet5qh0S3jjuvxzayFCvLqT3pXlX1nwKoiIN3hkc
	d4tdw017HDBMquhVUVLH3vfJmRsmxHeQhb5XKCqWU6pqMKE6cf6XkETdA0rev47NgzkMqFrRTK/
	nkJMLNQznPnW8lYOLdCwiMOm/xl3m3gLzp5UA/hGOgXG2UyuQF+/1wT0FymLL65T8Tw5L54=
X-Google-Smtp-Source: AGHT+IGpvRs8uIfgLpKNmLJgZEO4I4TiQ0j65DkQ4CGy6TSXaoZTtK30ynO9jDDFFV2YjHreKgW7wQ==
X-Received: by 2002:a5d:6482:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-39132d2b33bmr2069440f8f.2.1741350935894;
        Fri, 07 Mar 2025 04:35:35 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2eafsm5353960f8f.68.2025.03.07.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:35:35 -0800 (PST)
Date: Fri, 7 Mar 2025 13:35:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch, 
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <ahh3ctzo2gs5zwwhzq33oudr4hmplznewczbfil74zddfabx4n@t7lwrx6eh4ym>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306114355.6f1c6c51@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306114355.6f1c6c51@kernel.org>

Thu, Mar 06, 2025 at 08:43:55PM +0100, kuba@kernel.org wrote:

[...]


>nvidia's employees patches should go via your tree, in the first place.

Why? I've been in Mellanox/Nvidia for almost 10 years and this is
actually the first time I hit this. I'm used to send patches directly,
I've been doing that for almost 15+ years and this was never issue.
Where this rule is written down? What changed?

