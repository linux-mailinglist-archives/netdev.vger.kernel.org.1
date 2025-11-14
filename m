Return-Path: <netdev+bounces-238653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550CC5CF08
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1EFD4E1622
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259D31195B;
	Fri, 14 Nov 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWhIzGUg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E172D94B7
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120826; cv=none; b=KaqUkUmoGX9lF9q2/IYgb7yDpYxoAElwhkkNRTVEPnQuDbwM4xV83FwQPiKYN7MInIcu+ZKeih4vddRxITas6Vvm8Y4wyrP7UVmeajdxZwlWIFysO06uoB/O+D9fh1tNsV5iSK7Ogv4WXwbNJYXQf2UFXfpYvm5haruTatudwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120826; c=relaxed/simple;
	bh=3OoVc1oQMTWhRpyuTCUeIdNfj61vGvIb1qToVs3NQi8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=I/CXrfWdPq64HBJugVb6R8IEnXNuqP/iqIJbONdhn5Vkck7w/XxXtKRMRSxN9W7AStCvAlpYG3yB015inuI88RINp0eweA5NY9+kq3lyrSgKyz9f8Jyco2j0x5oPkgvGMv0GhJKpdg473xP1Jhb2pLmXHjhB4pDxu4BhWWEfi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWhIzGUg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32900c8bso1113551f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763120823; x=1763725623; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkz/e5bzwKPWQTirQ4qxkDjkePECDJOS45HioDFVT6k=;
        b=PWhIzGUglAorvtQMOZ7W7D7+rn+1lF2jAryM+JfQe2agAyQ0pT8Dn5xFS2PQ0eHj6E
         qD4fI3+H7DdMzkKAInBGq0L08cjalKcly2ZAc3Mm7CL4KdvQu110pJPQccYGUSd7kLo4
         73W+6kS6tCXyD5gMki3L7rQnwDbirxk/Grk1//9vg8FIHAaKp/s+z7n9OQ4F5JdpiBFW
         hQOXFAMnN9K9o491bhMBZPNuYAmbiQ9BzabmADVtbLYOtr7IGvIYOHfpZQZ03EgMoofN
         OlqOkMms9H9SmRLLak1xQTAi4t8hfqajCl+SGsThDdwmxzfYGXDnEgpPsNZiFM4N2MGA
         P3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763120823; x=1763725623;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xkz/e5bzwKPWQTirQ4qxkDjkePECDJOS45HioDFVT6k=;
        b=AeI+JlX04ppSa/iaYi85qgQG/o7fDuGrXwZOuBo4LYOoeRbjefKxrv59Pg6Lw/U8xQ
         lqVolzw6udiQzImXw76Kg/WCFCFy+X7V/+oV5zI5zrKIuKbGdoCw03oMkfaa1+PQHCka
         THjmIKp9oZM61E27wSWPVB7tyoT/XW6djWllNLkEZRjxb1l0pfGF/0BfrWjxZeRbDDVR
         IdCRsfhsvmYT6OfyPb9r2+0HGxeCAjto4DgvrhaDFqnLYUFXhFI1+n3LCkc3CjHNWUV7
         IpRTu+yvkK0Vd1vVVv+Z96dFYwNzAA4uybRmx9BPLGFP8iyLfD6spU+kGVYrayfbrcdG
         30bw==
X-Gm-Message-State: AOJu0YzSy1F2JWT30IXTGiabj4qmtoLAsZXbF9zC7D4lG/RozEXF/CbG
	VEdAvnO+iGQVvRjZrYCE4JnBQ8wAClEiHOc92ZfHzFztfGj7iANdYNyk
X-Gm-Gg: ASbGncvdSBJZLL62cT/vb+KY6HG5wqkcON8vmAqi1yxzo1chYUDA5FHTsHLuBERIkKN
	PmIdtVSUqWohEzz4dShq05vdtx+itU0saw85mhppJKSlENkdCOfQiF5BWEaLa3tXSRdTbxZeqMj
	eKvXWUa1DrovZ49cE4egyBD1yeKJ+OfqWbzuoZ6EsFVONg8m1KIUs0Z623TStQnyz6rMggCdcXk
	lFCb+dEcxKnRjq8WbfNN6P4hawIgYERPVUrDoOcf9Xlh0aySmmrnX4p7ZvX8bap+ocyM833/6yI
	Fw3TcjGJSwg5VoZlVnWhC67JjJFjG3uSwGlrPFrJ8o0vvFP87Dda9nVizjA+2nNgaZCZHDkUO9e
	md8E3EOgv1DHw2cNMROoJNhstqOt1LYVDyEmj3eEKOGHrSBwVUN6gRYULv3gx/cqxPz/rlk7vDc
	mE0WGc+w9W9tg0rti+YquqnA==
X-Google-Smtp-Source: AGHT+IGvnhEtLr+0QbVGNIbRNcnUZt+yVEYG6ZVMccyyqAJ6ifW1nyD+7q7VKUGMHc8w62Sqsbj91w==
X-Received: by 2002:a05:6000:430c:b0:42b:411b:e487 with SMTP id ffacd0b85a97d-42b593248dcmr2275740f8f.2.1763120823137;
        Fri, 14 Nov 2025 03:47:03 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:925:8b2c:a441:8a94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm9522910f8f.25.2025.11.14.03.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 03:47:02 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jan Stancek
 <jstancek@redhat.com>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
  =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Ido Schimmel <idosch@nvidia.com>,  Guillaume Nault
 <gnault@redhat.com>,  Sabrina Dubroca <sd@queasysnail.net>,  Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCHv4 net-next 3/3] tools: ynl: add YNL test framework
In-Reply-To: <20251114034651.22741-4-liuhangbin@gmail.com>
Date: Fri, 14 Nov 2025 11:46:54 +0000
Message-ID: <m2pl9komz5.fsf@gmail.com>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
	<20251114034651.22741-4-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:
>
> +cleanup() {
> +	if [[ -n "$testns" ]]; then
> +		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
> +		ip netns del "$testns" 2>/dev/null || true
> +	fi
> +}
> +
> +# Check if ynl command is available
> +if ! command -v $ynl &>/dev/null && [[ ! -x $ynl ]]; then
> +	ktap_skip_all "ynl command not found: $ynl"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +trap cleanup EXIT
> +
> +ktap_print_header
> +ktap_set_plan 9
> +setup
> +
> +# Run all tests
> +cli_list_families
> +cli_netdev_ops
> +cli_ethtool_ops
> +cli_rt_route_ops
> +cli_rt_addr_ops
> +cli_rt_link_ops
> +cli_rt_neigh_ops
> +cli_rt_rule_ops
> +cli_nlctrl_ops
> +
> +ktap_finished

minor nit: ktap_finished should probably be in the 'cleanup' trap handler

> +cleanup() {
> +	if [[ -n "$testns" ]]; then
> +		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
> +		ip netns del "$testns" 2>/dev/null || true
> +	fi
> +}
> +
> +# Check if ynl-ethtool command is available
> +if ! command -v $ynl_ethtool &>/dev/null && [[ ! -x $ynl_ethtool ]]; then
> +	ktap_skip_all "ynl-ethtool command not found: $ynl_ethtool"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +trap cleanup EXIT
> +
> +ktap_print_header
> +ktap_set_plan 8
> +setup
> +
> +# Run all tests
> +ethtool_device_info
> +ethtool_statistics
> +ethtool_ring_params
> +ethtool_coalesce_params
> +ethtool_pause_params
> +ethtool_features_info
> +ethtool_channels_info
> +ethtool_time_stamping
> +
> +ktap_finished

And here.

Otherwise LGTM. 

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

