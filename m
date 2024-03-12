Return-Path: <netdev+bounces-79440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145D8793DC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 13:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5234C1C216A8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A27A127;
	Tue, 12 Mar 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cJEd3WGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77D79DC6
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245557; cv=none; b=WZfKMj5TTPhUrD0Sne1V4JAMBne6kxGV6WKxhSiV9zTgkkn3tCTZaupKrL9srQC9ZAKo40Y2jL71H34LCNsaKge0mKEIjqsWNlsk08qgTPanPdceJphtkJz0FrWbZEU3ms3irZ2VKNc8SDhM0RCXEWXxBqUL5leDr/mEoWbnVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245557; c=relaxed/simple;
	bh=ccSj1OYbSYWfnKtIQfa/EhrBt3iwlZ/RwJgcEllvMCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBrhn4Zx1AeCaUxQ5o+TpaVM3P1DOpT4ErAKtIJcQzp2uGps7IrrKuYkVa2wh1p8vD+D6/YK0gziBXfG8MA60YqDZH4zwpqPPENq1fK5CBf4O26eQ/ZLIIqV+oCEuj62MBP+agOm1AZnrzH5SajYa7yi44dtdfurnKLEaRjHF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cJEd3WGG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d228a132acso68749391fa.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710245553; x=1710850353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvhNKAjrvwuECpOuanLYjW/ElEDQZ84VtPQEboLuz74=;
        b=cJEd3WGGOshzVMyS3xPb73aYWzwcTigN8mLCe+R4Ne94NibJmXxCXoFsASUE9qBOyH
         6CcElLUjz/SmdkIdPjEWyno+BLqQjJZ+gFj6j/MBW5N7hqHrvw3jK964SuKfcvtvwoQH
         +oNRHYUDDBvoBEEs1gTAu5ddVZroq93P64f53l/yoWzV3m8RwpVBkkrXnC3l65T0v8kK
         q2I+h2uXMQVxwqe0HMFgj6KGjAYeoyqHZC5gxJ4SmwMTyjmKWKooar+0cKWuvV7TyaE3
         SE+b/kVKA1GJ/f0jd2WLFkxvQzAsiplzCOd5dU+bIgcVSj2626vNm1v98yfCUBTTs/v6
         K4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245553; x=1710850353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvhNKAjrvwuECpOuanLYjW/ElEDQZ84VtPQEboLuz74=;
        b=w0bd5RQFddgfSpxndBW73+mhl6k29uKPz4nGGKDVVWY0m9PE0AZ6MPJvmjZpZ85EZs
         pzA0ePfZ/wJvnG1jQL2pKBzPLEyvolu6iUEXHoRs7TnwBTRh4z/AH2sDXyNYZAnrTXqS
         DWixwegqZSXxHAvYFS44MaL0kUX6pJ9T54gN/OWMWB1ynsWxyKrRF2Q9HO99J4P0qgXz
         bmuGjcLX/+st0nv0tH3EY4EV4BHOXu6XVOXhEL+6077OyTDj//xbRB5WcuDPTHVk4MDJ
         Si5AYiNOFzGgTgsymP6VoZ/Wae20MJXi9nx8v/UOA3PYWcgPFQd7KKdLIsbyp7JNmC1k
         Tl1g==
X-Forwarded-Encrypted: i=1; AJvYcCUp/sESW8JMMLUUBfrgtV5GGeirqoaeOmCG78A1fzPM0GK/RvtdPFQ8IwUJ8oQl7EY6gANVAj7uCrbWmHi1vmQEK1LDaJje
X-Gm-Message-State: AOJu0YzHqfh/Xu1AVj4/Xx2NOnwOp6nWU9o5xWY5hMkxriv3NOyQgJix
	nk2qX9Id+pS2wMNG5DW7KIaaQld1r2nr7vNOSGTzZFU6WGt3GBbguWknrn+kGO0=
X-Google-Smtp-Source: AGHT+IEBCZzZdGqYAGprIGL/GBfcQU2waYn35HUmbNm/hnx8Vxq7XuV1TkLlbt3gYJW7SXWOY8D+Kg==
X-Received: by 2002:a2e:b8ce:0:b0:2d4:47a2:84c8 with SMTP id s14-20020a2eb8ce000000b002d447a284c8mr3464711ljp.2.1710245552542;
        Tue, 12 Mar 2024 05:12:32 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bk15-20020a170906b0cf00b00a4617dfc36bsm2800612ejb.178.2024.03.12.05.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 05:12:32 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:12:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: How to display IPv4 array?
Message-ID: <ZfBGrqVYRz6ZRmT-@nanopsycho>
References: <ZfApoTpVaiaoH1F0@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfApoTpVaiaoH1F0@Laptop-X1>

Tue, Mar 12, 2024 at 11:08:33AM CET, liuhangbin@gmail.com wrote:
>Hi Jakub,
>
>I plan to add bond support for Documentation/netlink/specs/rt_link.yaml. While
>dealing with the attrs. I got a problem about how to show the bonding arp/ns
>targets. Because the arp/ns targets are filled as an array[1]. I tried
>something like:
>
>  -
>    name: linkinfo-bond-attrs
>    name-prefix: ifla-bond-
>    attributes:
>      -
>        name: arp-ip-target
>        type: nest
>        nested-attributes: ipv4-addr
>  -
>    name: ipv4-addr
>    attributes:
>      -
>        name: addr
>        type: binary
>        display-hint: ipv4
>
>But this failed with error: Exception: Space 'ipv4-addr' has no attribute with value '0'
>Do you have any suggestion?
>
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/bonding/bond_netlink.c#n670

Yeah, that's odd use of attr type, here it is an array index. I'm pretty
sure I saw this in the past on different netlink places.
I believe that is not supported with the existing ynl code.

Perhaps something like the following might work:
      -
        name: arp-ip-target
        type: binary
        display-hint: ipv4
	nested-array: true

"nested-array" would tell the parser to expect a nest that has attr
type of value of array index, "type" is the same for all array members.
The output will be the same as in case of "multi-attr", array index
ignored (I don't see what it would be good for to the user).

Other existing attrs considered:

"nested-attributes" does not make much sense for this usecase IMO as the
attr type is array index, the mapping fails.

"multi-attr" also counts with valid attr type and no nest.

Makes sense?


