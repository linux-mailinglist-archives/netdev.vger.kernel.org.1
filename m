Return-Path: <netdev+bounces-243169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83702C9A891
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 08:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A843A884B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81F2FFDED;
	Tue,  2 Dec 2025 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QRRRrqBj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29843016FB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661437; cv=none; b=PQBkxx0qQRUIanpX+DRipTrUwCCi2G7dqusZiuncM9QwZz+Z3os3kqVxi/F4R92NhkL8oWGuTsQTwqf97kXirx9MOODv4sZcmm1/J/cwy+vqpa6O551357N3wLhHGV2rW20cyO5zoA4zfGnBiqb+9eMZE0mDYAVKo1HIHL/CYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661437; c=relaxed/simple;
	bh=8ckkjeL/RXlFhgjRWL4DkGaDUwGUgzLODQckI9b7r3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1AjAOp0eZWBJwTuKn7F/de3SkWeEK7lsAVu+nA45t/I1reIUvKLi9GQ4vJLWneyN5q0r1TSdVfGHq7un4h0GRcnXnBO574Jfd47uCxMXD0hJ3d/RdTdCzZYP9Mpt/ig2OB/Phf8KV3ryO+J8UFxBTWT/7f3N54GEQjdQpjWDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QRRRrqBj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso57472635e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 23:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1764661434; x=1765266234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUBQ/3hc4NZIDLxuHm2/2S+7bD6q76Ih+ZYX+6Y2vGc=;
        b=QRRRrqBjD1QVpEKwDHZwcJN6JR7HoApRoRpUwQrwGyqiLWHqdbR7+Aa4YLo9Y0KV9Y
         cS8lNT5P72jDxpxGODw8S5xmz9OJ/QdVnuhnc2ioszPbtc3rhCuYAaXvsRkGwLfY4+Sx
         JgYS/06XI1smxz4HEDZFxPTxKRCQuy8wfRXDq1OSrWuShLcv2Kr1EwDpDyvngBdbp/Yb
         txLz5haTlv0FuFZdrPD0N1ILvj6elwxAo6niYS3m4Wd/XE9PIDzhnEerJ9R/PNG8Dxj7
         w56PyAB0uNZtnlr4owZhE1DiMAK0oUgv5WA4f2WeMj5TwZpzm8t9eT1oY+DkvkIIMVd7
         O5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764661434; x=1765266234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUBQ/3hc4NZIDLxuHm2/2S+7bD6q76Ih+ZYX+6Y2vGc=;
        b=S8YOeMgyJTU1ZTUTKI/xgBTrphWrXIfFSc/PfPh05l1Rck97cYMEXGrYFdSqo7uSXM
         fuTGWM1AgtLdjd0IzjlVfzphj2wXHsIyHvRN+Gi5AccYKdWyzO1EM02JCpD6YkOLvZKS
         up6VBu87nPCThZ8c4brRBhHZTVlM8AzSZYO35f0Drht5CO7WiI/MvyB7s04aJYuUdxGq
         jR1i5TyqMl3jQVcaKL+AHB0h1T9FF+ZePa7DF6NizIc2d4UaUs2DB9RjaLSGzYR6T8ai
         AVtOSqb6eoHRYtEqdN2itumzS4RLS/nIyk3PiNeW5nDnAZtDoPYp6j9dWJ5N35H9Oa8S
         8PLw==
X-Forwarded-Encrypted: i=1; AJvYcCXzL+R7D0IB1al3MliXdy7e3Zq1t9R5Y/aO95BQYMCSus5bKtsQnBmwyO7HKjqfJdCvAYwGc+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90HZ2G4r0EtLFYdFwh3zdBzutXwKS8rdaYknv4DsuKlimObOV
	pmeXfMcDAvjCCTpUXdO/zFGxXY2BMvTRsh6g4FSIRkcva/ls3OVahcmDK2AztV9ZhJg=
X-Gm-Gg: ASbGncsdwBLTsOAq/8pbM0toKRqAdYCKNe4j8DyMsmaQq0A1tcvvBWeVBOi4DGCUOXg
	PUDhqfwW4VOkTHSTCi5+4dPoRPonm8sh3cY2XVTck2GSuJ6sQ8Ke6W5wdDmob+CdrhJ+8mPoO8u
	lQ65MrVbacjS8OpeghWday9KNWgeDtRIooCaafxTXZ6hACon7bGfq1PfyATXOQgkuBKcj4QFLgG
	mo5AZX3WmY51xDihtA3Vka+SQZsTWorRcYFCagnpRnKB8YASag5eC1uWonuYt9HQOfFWDkJnBZd
	gQoAxFDXIXM1Sf/w3pzCHxIkPcq/KSLfwX8Cwljl+e8ppgABOXtO7E5MmMlTAfejciFG88gQG9G
	AggRXmCJjraiVQWQRKJFP4S6ILtmRTf3irgrwJnN31UL6982Eu5oQzb7B6GivvgaqrlfzTncidG
	PJP2Gx7rqDEyS35ub7NAjKAA==
X-Google-Smtp-Source: AGHT+IFOBP7is3O7E3ngO9hcbwxAgJIe2rx8/X9n/iT0/JjDDDlV2gJyo8InmRgjZ9TfFpWZK3LaVg==
X-Received: by 2002:a05:600c:4691:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-477c10c8e61mr387655555e9.5.1764661433540;
        Mon, 01 Dec 2025 23:43:53 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479279e594fsm7823225e9.12.2025.12.01.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 23:43:53 -0800 (PST)
Date: Tue, 2 Dec 2025 08:43:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <2lnqrb3fu7dukdkgfculj53q2vwb36nrz5copjfg3khlqnbmix@jbfmhnks7svq>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
 <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
 <20251127201645.3d7a10f6@kernel.org>
 <hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
 <20251128191924.7c54c926@kernel.org>
 <n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
 <20251201134954.6b8a8d48@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201134954.6b8a8d48@kernel.org>

Mon, Dec 01, 2025 at 10:49:54PM +0100, kuba@kernel.org wrote:
>On Mon, 1 Dec 2025 11:50:08 +0100 Jiri Pirko wrote:
>> >> I'm not sure I follow. If there is only one PF bound, there is 1:1
>> >> relationship. Depends on how many PFs of the same ASIC you have.  
>> >
>> >I'm talking about multi-PF devices. mlx5 supports multi-PF setup for
>> >NUMA locality IIUC. In such configurations per-PF parameters can be
>> >configured on PCI PF ports.  
>> 
>> Correct. IFAIK there is one PF devlink instance per NUMA node.
>
>You say "correct" and then disagree with what I'm saying. I said
>ports because a port is a devlink object. Not a devlink instance.

Okay, you mean devlink_port. You would like to see NUMA node leg as
devlink_port? Having troubles to undestand exactly what you mean, lot of
guessing on my side. Probably I'm slow, sorry.

But there is a PCI device per NUMA node leg. Not sure how to model it.
Devink instances have 1:1 relationship with bus devices.

Care to draw a picture perhaps?


>
>> The shared instance on top would make sense to me. That was one of
>> motivations to introduce it. Then this shared instance would hold
>> netdev, vf representors etc.
>
>I don't understand what the shared instance is representing and how
>user is expect to find their way thru the maze of devlink instanced,
>for real bus, aux bus, and now shared instanced.

Well, I tried to desrtibe it in the documentation path, Not sure what is
not clear :/

Nested devlinks expose the connections between devlink instances.


>
>> >> Well, the mutex protect the list of instances which are managed in the
>> >> driver. If you want to move the mutex, I don't see how to do it without
>> >> moving all the code related to shared devlink instances, including faux
>> >> probe etc. Is that what you suggest?  
>> >
>> >Multiple ways you can solve it, but drivers should have to duplicate
>> >all the instance management and locking. BTW please don't use guard().  
>> 
>> I'm having troubles to undestand what you say, sorry :/ Do you prefer to
>> move the code from driver to devlink core or not?
>
>I missed a "not".. drivers should _not_ have to duplicate, sorry.

Okay, that means "yes".


>
>> Regarding guard(), sure. I wonder how much more time it's gonna take
>> since this resistentance fades out :)
>
>guard() locks code instead of data accesses. We used to make fun of
>Java in this community, you know.

Time changes :)


