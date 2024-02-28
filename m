Return-Path: <netdev+bounces-75578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4D86A95B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2AA1F22A5A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C725601;
	Wed, 28 Feb 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Vc1xq/B8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987C241E6
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106991; cv=none; b=rwp7RNRSVZgwRtPm0YLX4YBeOWQ43oOxT3cQBWWadLE51fTIjdl2f48CnwY7Czg6FqBEWmurepHrLzm4P0mf6qEVcO3Jyogi1/ZVv1rhe2o5wub2UWXEeloTTOaX7oE/9b+IQBRKWR9doL5UHDBx8v/2wPg8VTNwQYE6YwgN8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106991; c=relaxed/simple;
	bh=Tmx/UV3N2ZKbJbdaYdag0DSZlyt1I3bsSZdSjZeWQhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azIZas6aazyCWT+xDpv98mzSq/kfpE8j3eoy1przn8yAIej6b4QkZbJZtvlsGYNP3Jjziav+Uaq5Oh8pGEjDJKx1qR0fIRh5L9+Ef0v45BolPVVzKWeesDFEKvvAmBiLr134W7Z4TYIU39P7mntFQYAcBsjIDx45991X67KU/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Vc1xq/B8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d228a132acso70375401fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709106988; x=1709711788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkhzpFnK52PbLTe1kicsNxtwn6/GApGEIKCN/asm3IU=;
        b=Vc1xq/B8XVfKP55EblAz3WPWCoXZyE8qHS8PRSWzUajCmVlP6eUXVFBomd/iDojJHI
         fvqr3p3wxZaCi4e2njrO73E+o5jnRZcCjQmTcMSVpM9LF/Uzn6C19rGPoOAg3UDM14aW
         Hm4ppFVylD83643QN7aB/nhheUv8B/oOZ5aWeFhSEmhTHiRnWqe2lUyf2n2GbH024jm7
         N3BsoQpXyKQ0GB7bch+ZJuTpX/sRo2eGL0545we5/CQxXn4/9gefuzzwrZaTHf5EcwMW
         snet4+bm3pcwQPZJLxXjKxnlDvl81Ffa1Piud882YJw2KSQzaP5rm+Ha8aLKEvqzKt+4
         m9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106988; x=1709711788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkhzpFnK52PbLTe1kicsNxtwn6/GApGEIKCN/asm3IU=;
        b=f0qMTeO29GToxR06xerrK2j+hhheUNSoCJ5z19ygiNwOfT+x2a2SVMuCVI5otB+Mh1
         aFrs9vVf5TIj7/6HRgnNSYoGDT/g0mjSEXm5PAICM8jjPJh/Q0ui7w/6w5rGYxs4cHe+
         dJExiHLf2MuyCRiTFZpa7Ec9PtAaIX40I6q7vSJGJNQu6g13/4yX4uCsL5OnSThUCiXt
         IqTHvO5JH+Am4zpWF4GEhMED0LbOX6ZlDn9blvDbOIhRRgNAMklbT06MaPVItxzPU7wa
         dF0rR+DckpWnhJw9qprZWP076+cLyuxIZ4guOYdpSvpw+Ejh/1ihY0BgGM0mhtiV2bkp
         x0gw==
X-Forwarded-Encrypted: i=1; AJvYcCXl9hg0wY97wWxwwFLxqj8OwKqNx++keBUmgbePJniUT3eDHCRTj3jrk/0mYTPb0ogVqNP8s5MvmyqlEsu7E7AdinScrdOd
X-Gm-Message-State: AOJu0Yz26P8oJ8UfumuUTFhWbW2tYZUgL7PX+oofilwvJjm71Y2Diz6f
	5WVerB5jvQZ1bVzbTE2zngSfIQBCC/94TKf4eTGgiHSpzc2Pqn5Rz6tPl4XkX3E=
X-Google-Smtp-Source: AGHT+IFRhNiiT8HYHGLW04Lxp5tPekDN0sFrkIf6Rntrwbhs/VwSRuKJxOXfh04GkS7Xm2t3y1pxjQ==
X-Received: by 2002:a05:6512:3190:b0:512:fca7:4d7c with SMTP id i16-20020a056512319000b00512fca74d7cmr6621855lfe.35.1709106988482;
        Tue, 27 Feb 2024 23:56:28 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004129335947fsm1263188wmo.8.2024.02.27.23.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:56:27 -0800 (PST)
Date: Wed, 28 Feb 2024 08:56:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: remove some holes in struct tcp_sock
Message-ID: <Zd7nKRuwjcBRWhT8@nanopsycho>
References: <20240227192721.3558982-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227192721.3558982-1-edumazet@google.com>

Tue, Feb 27, 2024 at 08:27:21PM CET, edumazet@google.com wrote:
>By moving some fields around, this patch shrinks
>holes size from 56 to 32, saving 24 bytes on 64bit arches.
>
>After the patch pahole gives the following for 'struct tcp_sock':
>
>	/* size: 2304, cachelines: 36, members: 162 */
>	/* sum members: 2234, holes: 6, sum holes: 32 */
>	/* sum bitfield members: 34 bits, bit holes: 5, sum bit holes: 14 bits */
>	/* padding: 32 */
>	/* paddings: 3, sum paddings: 10 */
>	/* forced alignments: 1, forced holes: 1, sum forced holes: 12 */
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

