Return-Path: <netdev+bounces-166971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECCA3835C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEB172221
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A521A454;
	Mon, 17 Feb 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oERNcDvs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409F2F5B
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796566; cv=none; b=KCvXFdsGUk7deOKknKJA+xHmxC/nGbuPitncpcCtjADN/W6ULI0jB8qfwtFZpKw974TdvSuSVDHrpr4Khml8CQuc6RMJ1W3TajvKWSxqTKr9isQowQqlKg2UhfH9pEXESnDrE0x9632Fv2sAx6AyCBoV72SZgxu07ckhiSbNZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796566; c=relaxed/simple;
	bh=bHiqDRvc1mhDBHiIQVyYyfXBxjcUKSSG8qBQZ4+CDoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAmsahHIH/rq9SPWuD4SaRiKS9EYUxmFr+h0ZmGs/NKd87UjRme6S0LP5Pc8oFV9ZG/dumX0uU1nkHYpWoFTH4W1oweQQ4AykKMrargKmcyiJzXpe7u9J8IZaHK6TamWzTWiJAnFDryOLM3Vay3t0F7vj8Pt/LH5Xy4ynai+48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oERNcDvs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43989226283so3995535e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 04:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739796563; x=1740401363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmKKVjUehtS4u8tMOfG7kOlQSPuERUC0wbaOm58IPWU=;
        b=oERNcDvslrcUvl8V2WHrDCfUBqoX690LCOwbQBjG4v3luwTFtpeeagSm2FTUCAEFAX
         xYsz0BpSGZ9NBflYPKZInpMkPQxofgZ1mqSd1wyWsfzqQNojeB2ZNR/zelfrUZjQRQuo
         lNp4j2yAiYmKn3jY173rJJlm2JE9avXzeDrsm3DIELPsr0+9Ii3dDd7/OxNHhJIp6Vnh
         eN8pMIS/3HAIyGADUyr0THwdQ20XvptpPkRnSoVynl58Xs7j5bomSCS2GYY2ah4dibBB
         V8mH5GBJkX+MHnT8RUO/z/MHRT1BeKpq10Z7yhyItGaanpnGlblZZi3mExdVe6c4uWRJ
         MnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796563; x=1740401363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmKKVjUehtS4u8tMOfG7kOlQSPuERUC0wbaOm58IPWU=;
        b=byNUNbRVhPfbQ+D/HVFxnUHeaSnzOgSKozsVk9qLfQSpHzEwj7ExNDHUFE4Ronui+x
         g3ke6bZOzPw6oJiu8ckSftVGeotweOfm2KZjLeEOAwKLqRiuW61Q+wYZqgLhIRHsTFFG
         3ngN3ZBehN612XHo5SfjfdZBBR9oKtq7e0aZR6+a+WF0d4pqN+dIAqSlRCHnJpaHDlMc
         qJQNpAijjeHDTMflPGvdzVguMxHdl8LyDUKhy2Mv1KvTLxcrUmWmOJSmhM5ItGovwtcr
         uSiOUHSEEEpxZG/YD3XAYDFkKXqiamR7Ns5SIfkwGKw91/13jb0+3rPBYF49LJUB7Syu
         s7KA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZ4ReDBCMcFvhiW8x0UhekwniL3Nr/P/fWwadTQUSiKtarlBCH7k75ql9gVYhX++0G/HX+/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSD/bUZjmy3Kmyv62SYfdnoz0UH1d2FBxV9UqnrAlBWM0wdW9q
	vl9EXB38i3omE0a1uW1vtwi+9xXwnmw0JuVnn4HxWrUXu4WT22Ya1WmGZz1gyZo=
X-Gm-Gg: ASbGncu280UucJ3yZvWmz7f4v/4e4v+DcuG6lAKHdy+eIGKzy7/fUF1ZxXlDCvKnC/P
	QZud42wvayLU4Eo84wXu6konS2/fOgUcaQ9t0447Z7lyZXyl9mRzML2s0rzqnQGMOuOTXHq8HGM
	d8cAy6T3v+OC4bezfMRASPvyUaxyBPMXAZT90L+PQD4a8FJ9yciJ++/dmnnSgQEDRJkne3tyqZt
	VtgiGoL3PXtgsFU2e1uCXnKxEmOWa886sV9+aAmn8G90dW9652bVNfelThcimWgQPni1TjPDoB3
	zreHznTujOyQhbeVHA==
X-Google-Smtp-Source: AGHT+IG+t23B0+CZfK+bvk75oBr8zrz/PAsau7x36xGrXz0Kh9HYWs46MPNjv6SioOyW10077oLjnQ==
X-Received: by 2002:a5d:530a:0:b0:38f:2b59:3f78 with SMTP id ffacd0b85a97d-38f33f54f2bmr7539978f8f.45.1739796562469;
        Mon, 17 Feb 2025 04:49:22 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd46sm12190378f8f.21.2025.02.17.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:49:21 -0800 (PST)
Date: Mon, 17 Feb 2025 13:49:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
	Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <ccdz4sq2dzclxhevnj4ecfbehgtbiiw4pxtwctvknjzlvp72fl@lvfpjzfekm6z>
References: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <20250211075553.GF17863@unreal>
 <b0395452-dc56-414d-950c-9d0c68cf0f4a@amd.com>
 <20250212132229.GG17863@unreal>
 <Z66WfMwNpVBeWLLq@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z66WfMwNpVBeWLLq@x130>

Fri, Feb 14, 2025 at 02:03:56AM +0100, saeed@kernel.org wrote:
>On 12 Feb 15:22, Leon Romanovsky wrote:
>> On Tue, Feb 11, 2025 at 10:36:37AM -0800, Nelson, Shannon wrote:
>> > On 2/10/2025 11:55 PM, Leon Romanovsky wrote:
>> > >
>> > > On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
>> > > > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
>> > > > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
>> > > > >
>> > > > > > But if you agree the netdev doesn't need it seems like a fairly
>> > > > > > straightforward way to unblock your progress.
>> > > > >
>> > > > > I'm trying to understand what you are suggesting here.
>> > > > >
>> > > > > We have many scenarios where mlx5_core spawns all kinds of different
>> > > > > devices, including recovery cases where there is no networking at all
>> > > > > and only fwctl. So we can't just discard the aux dev or mlx5_core
>> > > > > triggered setup without breaking scenarios.
>> > > > >
>> > > > > However, you seem to be suggesting that netdev-only configurations (ie
>> > > > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
>> > > > > case? All else would remain the same. It is very ugly but I could see
>> > > > > a technical path to do it, and would consider it if that brings peace.
>> > > >
>> > > > Yes, when RDMA driver is not loaded there should be no access to fwctl.
>> > >
>> > > There are users mentioned in cover letter, which need FWCTL without RDMA.
>> > > https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
>> > >
>> > > I want to suggest something different. What about to move all XXX_core
>> > > logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
>> > > place?
>> > >
>> > > There is no technical need to have PCI/FW logic inside networking stack.
>> > >
>> > > Thanks
>> > 
>> > Our pds_core device fits this description as well: it is not an ethernet PCI
>> > device, but helps manage the FW/HW for Eth and other things that are
>> > separate PCI functions.  We ended up in the netdev arena because we first
>> > went in as a support for vDPA VFs.
>> > 
>> > Should these 'core' devices live in linux-pci land?  Is it possible that
>> > some 'core' things might be platform devices rather than PCI?
>> 
>> IMHO, linux-pci was right place before FWCTL and auxbus arrived, but now
>> these core drivers can be placed in drivers/fwctl instead. It will be natural
>+1
>
>Fwctl subsystem is perfect for shared modules that need to initialize the
>pci device to a minimal state where fwctl uAPIs are enabled for debug and
>bare metal device configs while aux sunsystem can carry out the
>spawning of other subsystems.

Wouldn't it be better to call it drivers/core/ and have corectl or
corefwctl ?


>
>> place for them as they will be located near the UAPI which provides an access
>> to them.
>> 
>> All other components will be auxbus devices in their respective
>> subsystems (eth, RDMA ...).
>> 
>> Thanks
>> 
>> > 
>> > sln
>> > 
>> > 
>> 
>

