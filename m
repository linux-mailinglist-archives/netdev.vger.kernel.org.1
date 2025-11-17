Return-Path: <netdev+bounces-239003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7FC61FD0
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 77044207F8
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 01:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718DF19005E;
	Mon, 17 Nov 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+4FwWa2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74214A4F0
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763343060; cv=none; b=d8uZp08tr6fkvj78XFBXh5OtgaG5nAEaGFwM5TBnNxireiYufjmomLswBQgSCasZm8TnDfiPgXbpI32nd9I46nSIUMeHDvFtHgFYxzIuhvTgGnbJl5wNjdqrnp9JHvncAr7DjrZQG19KACl0meUNSQLOcn9+DMxNOjHiitnh6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763343060; c=relaxed/simple;
	bh=mI67SWLoiRNudEBMhX5oh5WEMakJt7PYtuv801gZk/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt0Pengo6gZSzsLX7TazMh1lJMtvKQ9nZjKYV+wnh4SZhSc8RlvIZ0dDC5ZFtydY7dK3nK78opQt+GPEhY8wIm68/WX/Vq2O4wE/33pM/WMRjzvM2vzDwXIoqRIMpuu6PolpEoGP5CNqByu3nsk5c2lt4NN44gpQuYfxeVk+lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+4FwWa2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso4236654b3a.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763343058; x=1763947858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNPygJgHKEhSfXmcpruq+1rhcTPVd+Mq0ilbKEOSN30=;
        b=g+4FwWa2+IzByGVz70MDM+vk7PaupOwCN52hCBvubpzUpgxR1gIv//UwOfyu7x04nj
         pmikg0ZLu4i4KA9mfTbq/HSsptcYR7ka6+WifmnukB2svEnTzvOMCrHrd5/bBQvY7UEb
         xCFMViUeTKOPnxU6O19sOuG5Ha7hjJeNPVzmz83esCf4N75h/OzR8iRhVBR1LT4oF0ib
         P5mqLG1R6Mv9E8f9Vp7UvfCp4NetS0uBRz3mcZnObZEg7rg68tJX0ittUfJlZ0efYD6V
         GP1kTimDZ9+qE5jod3EW9GT4tVSGrxJcKQro0ecEPUF97MiBghRzBIJGQW7SzGtI4CqI
         7EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763343058; x=1763947858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNPygJgHKEhSfXmcpruq+1rhcTPVd+Mq0ilbKEOSN30=;
        b=nd5STNdRmMXxKD1PoqSwwy+Sp9ytiwjdxlJyPuNg9dTCpvKHSTqTVy1OTw/CWEVbGY
         HAlsQMbBkF3Ms5jyqp1Mgyioi2MrbA3iou0SkzR0OZ+3dEhZad7CVQn+7Rjne1T+o9Al
         YQQbfX8GEr5eFSutGpSNUuYK22/+BllusSM816d3E0OzjK/gv1Pl4lYHEFoRkyFDOyzD
         epCfAq5hnfiKBuzZNNgHTTDz3tlEbjmEQ8zyAKY5JDqq6Xu/2MQ94OqOl/FVwhVb2iHN
         mL2zUafHHTLsI1CkEr0rvOcDfbQyo68AvvbkXi2aNvRaq2nJGaNgmzJ/nRhQPArWqRJ8
         d8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWNHnfblLpxHEeLPs0uSQ+Ij9vT1ASdz2ZyGPCUF/uTt7JAxM3lRFDHXAlRDh7P5cTLtf6+DSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fWFKaXd8irPrwGhn+8RfEbqik3pZQDaLaAw9JEpa2rtRUsVV
	b2xoWalPuj2nT8m4PyjaIdsVCjNKkM4hJbpmhza9gpM981s7lgNjfXZWp9Mf3/YT
X-Gm-Gg: ASbGncvjpfu8Kf1hqyKv9fRxztDLOrgp64QuNWpUIhEs8K6DA2YUQ9iNILkv0xpsUkR
	iX6Q8NUQ4Oy2U1ZRD5onGNsKu5OVM8Grc6DgGZRpeWz1ohA/pd9H/jMjNlwbVnnsjve1N/nUgjU
	/OLebnlw532u8YH8IcxvqyJQqjgRw+5fYXTs1lk+GkbRPJbegu82Wp+gEzJoRT3hxlIbQKqduXU
	LUvJ+7/xVHpRaOcrVTqxEM8QaG+tOZ3mXrKu0hM51jUTzNF9eqUxPrRMt/BdI+HeyCvMvk7WIMj
	DcNij+VwBbN1pWQgWHjtmVK3Ft8kWR3i6LwtI66MYcGaNXcWCH7wVocMka/CB+FmTXf+q4SYWAJ
	XlXsoxVcNRKatiKgyn4D6bfP9jDJyhRUEpc4R02n8P64cbMd64UkhQbkgvqoAjbMN53TtXp+Bic
	CTNqD74M0wBQUIQog=
X-Google-Smtp-Source: AGHT+IGIOcEw29KdGvy3rFa97w7i/GCBqH+oTOoxq1puvqobPutZglXR68m74DaqlpKmZMslFECPyg==
X-Received: by 2002:a05:6a00:94fc:b0:7a2:710d:43e7 with SMTP id d2e1a72fcca58-7ba3c17e024mr11975000b3a.24.1763343058177;
        Sun, 16 Nov 2025 17:30:58 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924be37fbsm11383593b3a.1.2025.11.16.17.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 17:30:57 -0800 (PST)
Date: Mon, 17 Nov 2025 01:30:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv4 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRp6yb2W10aPZlEG@fedora>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
 <20251114034651.22741-4-liuhangbin@gmail.com>
 <m2pl9komz5.fsf@gmail.com>
 <3f3ecb14-88ce-4de3-91b7-d1b84867c182@kernel.org>
 <m2cy5inty1.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2cy5inty1.fsf@gmail.com>

On Sun, Nov 16, 2025 at 10:38:30AM +0000, Donald Hunter wrote:
> Matthieu Baerts <matttbe@kernel.org> writes:
> 
> > Hi Donald,
> >
> > On 14/11/2025 12:46, Donald Hunter wrote:
> >> Hangbin Liu <liuhangbin@gmail.com> writes:
> >>>
> >>> +cleanup() {
> >>> +	if [[ -n "$testns" ]]; then
> >>> +		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
> >>> +		ip netns del "$testns" 2>/dev/null || true
> >>> +	fi
> >>> +}
> >>> +
> >>> +# Check if ynl command is available
> >>> +if ! command -v $ynl &>/dev/null && [[ ! -x $ynl ]]; then
> >>> +	ktap_skip_all "ynl command not found: $ynl"
> >>> +	exit "$KSFT_SKIP"
> >>> +fi
> >>> +
> >>> +trap cleanup EXIT
> >>> +
> >>> +ktap_print_header
> >>> +ktap_set_plan 9>> +setup
> >>> +
> >>> +# Run all tests
> >>> +cli_list_families
> >>> +cli_netdev_ops
> >>> +cli_ethtool_ops
> >>> +cli_rt_route_ops
> >>> +cli_rt_addr_ops
> >>> +cli_rt_link_ops
> >>> +cli_rt_neigh_ops
> >>> +cli_rt_rule_ops
> >>> +cli_nlctrl_ops
> >>> +
> >>> +ktap_finished
> >> 
> >> minor nit: ktap_finished should probably be in the 'cleanup' trap handler
> >
> > @Donald: I don't think 'ktap_finished' should be called there: in case
> > of errors with an early exit during the setup phase, the two scripts
> > will call 'ktap_skip_all', then 'exit "$KSFT_SKIP"'. If 'ktap_finished'
> > is called in the 'cleanup' trap, it will print a total with everything
> > set to 0 and call 'exit' again with other values (and no effects). So I
> > think it is not supposed to be called from the exit trap.
> 
> Okay, fair. I thought the goal was to always output totals. Looking at
> ktap_helpers.sh I see that it can't output a meaningful skip count for
> the skip_call case.

Definitely, I will add this to my todo list and see if I could fix the helper.

Thanks
Hangbin

