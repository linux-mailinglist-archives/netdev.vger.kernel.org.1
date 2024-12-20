Return-Path: <netdev+bounces-153660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB739F91EE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F627164402
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825541C4A1B;
	Fri, 20 Dec 2024 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFuzDDJI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0561BCA19
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696617; cv=none; b=i4pfHK34OQ5AAs2ISdYeuyd8I6RJnHPuFKIqBaEI6GVlMwxU+pKXBi2bZK7pkILoto7UqhlG/GTBS4HE8RZ6Y1vBi3YKjvOHXbGzZnkSdV+T4IMv4SXvvRgUbqEsc24JO0uQCXSKiqL4OT4+uh0EOKBiMx0izH6j7IJCBxlAsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696617; c=relaxed/simple;
	bh=qMbvQQuDkz+xXeq9BN1TUtXhOAfotlM9YZSjsGcleWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcxZpiAm7PsKQ8t6wbhBgEI+TAL/9dYXzVz4ZycG9+VAtL32QacKowvYlNs97XC4j41T8vI92LuuTNezVMXmKbIAYSgRiOQDsGe//cZiR6A507i1zNVvg/u887E+JWiatDrO9ZSoieAe8uhKJXGNw1T9pywhNtecASoYqrlyEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFuzDDJI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6a38e64e4so31229466b.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734696614; x=1735301414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQ+ci5U58b1qibnNpvgeGWEIgYyYSBKdQvKp1TPS2SY=;
        b=AFuzDDJI7HbPzYDt61PYVLvwZKG37kgIEsZ2YwGs2kasPU1WY0lNz3jgZM/SunC1ST
         ocIjJTJgitvcaE2RKfoqmgvnr4eZgYyGd/UPg3E2Z79py/UCkDSVzP7HQsx7qKsDEyiv
         b0b8ruBz0ElS2+ZidAoouto3ZX7HmdA3mrTArkfeItJNcYsXfaoWbnnuRPdMigzZgZUw
         3LnFy69V5GprLlAp7C0Hl6NrawVvcgdkY1IKA8nsUfoPzNDalkjHh1XbjEobCxCQg1in
         w7MEfuapH3FKJXwzXZRhq3gILSRYYz0cTvunTcS0U8QFhgGL1GTOiV0b2C1musnAF9li
         gUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734696614; x=1735301414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ+ci5U58b1qibnNpvgeGWEIgYyYSBKdQvKp1TPS2SY=;
        b=YH/V2u3BAy+Yhb4nxkUmzhTZpouYwX2E8+fIxQ6rgvz7kze8brouvkS9JIm5Lf2kPx
         794rRonElHHIGXSMU0JMyMwB4VPXFWSvCrxL1GZurB1Ll9xnUongQ2+IiaPEjFFAR9Qi
         U0poBk96o1v9aQJndtDhc7+F2YXQTr9fbzXmDZrvsPXZkM+mgwTY6w774I9Ug4yP/vKf
         TbRP9qlWW3BN4BOsa6S+K/MdssEKIzSMl+WWJYWV2NZIg7intmxXPjdrICZy6V3A2iA3
         MtZaBF+b7DuImg+XwDDyVjxCXmxvmXMEcq8n2/pdnYYjhYMBxR2mmJVXCSLB8aDr1XcU
         nDIw==
X-Gm-Message-State: AOJu0Yx1t1WUl1F4kTsO7agQTGOp9kPMsJrjeA2mm3E6tP9J8xCdU1Bi
	TU7gHe7majnTXiQbrev4fBn7cFzL13jP6XxaMwBGxtdXEXFRDWJO
X-Gm-Gg: ASbGncuoBbVs0zGOMISM1NOmo+lhP33QAGNd1PgLnHGPhhjYs095jWUn0cjrAtvW0jg
	0CYDqVSuJX9RIpoD73s3Ihnl4xFWkMHxRKu5+tiDPfSLPIMlSdsLxTwOwoNPP/6+nnaWMUhalGy
	NYbc3943YeguLYa+wpuQLG1k+rQj9yFomgA8TlUzkzKqOuV+Rzw42XQ1Z1EmsI1GMai9jskeFQR
	T+yvqQnKWmjNOhf+m5MCATRgRG4WnKq6IPTXGDkIxiz
X-Google-Smtp-Source: AGHT+IHepjuEfE9xMqab0E5XN1Ej3M/iDy3pdEVDGw0bjayBetVyij8iBjQ+XTzg7kntLcVSN4R5YQ==
X-Received: by 2002:a17:907:a681:b0:aa6:9b43:1049 with SMTP id a640c23a62f3a-aac3368bda5mr64131266b.13.1734696613654;
        Fri, 20 Dec 2024 04:10:13 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895194sm170867066b.70.2024.12.20.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:10:12 -0800 (PST)
Date: Fri, 20 Dec 2024 14:10:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Kieran Tyrrell <kieran@sienda.com>,
	Max Hunter <max@huntershome.org>
Subject: Re: net: dsa: mv88e6xxx architecture
Message-ID: <20241220121010.kkvmb2z2dooef5it@skbuf>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>

Hi Luke,

On Thu, Dec 19, 2024 at 08:02:38AM +1100, Luke Howard wrote:
> I am working on TC support for the mv88e6xxx DSA driver. [1]
> 
> Two architectural questions.
> 
> mv88e6xxx switches support AVB admission control, where frames with
> AVB frame priorities are discarded unless their ATU entry has a flag
> indicating they belong to an AVB stream. This requires knowing the
> intent behind fdb_add() or mdb_add(). One, intrusive, option would be
> a NTF_EXT flag that could be set by the SRP [2] daemon. My current
> approach is a NET_DSA_MV88E6XXX_AVB Kconfig option which assumes all
> static FDB/MDB updates on MQPRIO-enabled ports should have the AVB
> flag set. MQPRIO and CBS are supported without this option, but will
> fail AVB/TSN switch certification (which floods the switch with “AVB”
> frames not setup by SRP).

I think we need an AVB primer. What identifies an AVB stream? Should the
kernel have a database of them? What actions need to be taken for AVB
streams different than for best effort traffic? Is it about scheduling
priority, or about resource reservations, or? Does the custom behavior
pertain only to AVB streams or is it a more widely useful mechanism?

The tradition in Linux networking is to first create abstractions for
the software data path, and then to offload those abstractions to
capable accelerators. This allows certain platforms to do the task
more efficiently, but still using the same user visible API as what a
pure software implementation would require.

> The second question is whether Linux TCs should be mapped to AVB
> classes or to queues. The admission control described above requires
> dedicated, global queues for Class A and B AVB traffic.

What is the lifetime of an AVB packet in the Marvell DSA switches (in
enhanced AVB mode)? Where do they go from these global queues? Still to
the individual port TX queues, I assume? I find it a bit difficult to
understand the concept of global queues.

> This effectively imposes a mapping between TCs and AVB classes (with a
> third TC for non-AVB traffic).

I don't understand this. A mapping between which port's traffic classes
and the global AVB classes? You're saying that mqprio TCs 2 and 1 of all
ports are backed by the same queues?

> On mv88e6xxx chips with more than 4 TX queues, a mapping between TCs
> and TX queues would provide more flexibility, particularly as it would
> also allow per-port MQPRIO policies (a feature not available on the
> 6352 family).
> 
> I think I have made the right set of tradeoffs but clearly there is
> compromise between supporting CBS generally, and supporting AVB/TSN
> properly. Any thoughts would be appreciated. More detail can be found
> in the avb.h comment in [1].
> 
> [1] https://github.com/PADL/linux/compare/158f238aa69d91ad74e535c73f552bd4b025109c...PADL:linux:marvell-fqtss?expand=1
> [2] 802.1Q Clause 35, also our open source implementation at https://github.com/PADL/SwiftMRP

I believe I don't understand enough of the Marvell AVB model to make any
comments yet.

