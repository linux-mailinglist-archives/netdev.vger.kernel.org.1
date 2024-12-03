Return-Path: <netdev+bounces-148462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7D9E1C6D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C7216090C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3541E767C;
	Tue,  3 Dec 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQygbgL4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517651E884B
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229803; cv=none; b=VyleOlk7mXkKL4nYi4YR5h4V7LLycKbWn6oAYVsosDAxvPaIYhZVBPrrX56Xneeo4v4m28zun3/KppPsTGssMxEIGlcU7zV74Yxh/NSqSHFQimnAJcB9uYefsW2jbCC14QYILosE/2gGPaxkeU70gK3vjNdAo1ANXTkgWDb4il4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229803; c=relaxed/simple;
	bh=GzBvztZIsAnA0j805i0Hdlzz/ySCIXvl+SnZ96ohns8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV9EjVwPhQpl2NAf7v9bxSx2tCSP2vTrLV3xzogmDYXV6DWv7fZU23LtJRLBSMvo+kUCLfGHSAE5lqBOqiQ911e+si03abwCXOGTk1jtoXsVTUqPU8XvZQq8CI0lXFnqPb9O3pqqsGJlkbvwBvwVU8bVWo/Mocq/q6RoJdBcC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQygbgL4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349c376d4fso5384375e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 04:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733229799; x=1733834599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KO5UMHTUP1STwabFpZLUivHeu96b1MzdbWV6oLLApyU=;
        b=RQygbgL4gaJ08eC1mu4QXbapHPzbXx+ucO+RUEVEmGtIz3g0KN30XWz8rxKkc6g8Ul
         LFSDG8xD0VCBLk3vUWScHKkDJnnmxISmhyrstunkhRvZB1bl0WSsT7bTxE8p0dze7lw/
         0z/7Ru8mwDFf1yyo4oA6N6M451f62+/9Zyo01wIzGZFA2VGew+JT2O1T1gbC2vtY5v0H
         sy6tNP1PrTrxyAP2Z6bCwa+DWR3U8n9Kf8CayijhY6Z4OCZcWccLi4Rvgl/hWzcwqk/U
         3o1YrEKrXfVSLgHNSlaYEiOEn4MYnhk9SRhfw+GV4kb1CBI7QbQGzmIM+dcmh/ZMZ3Z5
         Uk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229799; x=1733834599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO5UMHTUP1STwabFpZLUivHeu96b1MzdbWV6oLLApyU=;
        b=IXBt3O/RgvgKnluzu/OPK+Gwj1ukCoi672X89JZ8cPU+gAA6kX118nw7NQRP1IyiY9
         hFnA5k9KwyVNc3Om/3PTE/oU2+xRHgSGq1FfLdfypciVTJiYDD9h4XqYBweB0g4SQ6Y4
         p06aGfzmiAG1obNqzGUzIesDyEkDRUvx6SqnmX8mXE4XOJzLfhRhoi0cxOa4BcKzUmvp
         lH18xQLYgGqu8SyYX+iMbPqjcoaQGIoc5kmrBsCr2hIwTIDXptJikQngPBvFHSiYAWfX
         J+33I5nFkmDg6YhCOhBxg1dP4kbWAWuZhcHzApKmzqmjJ2bGG6ewppgQCSgUW5/cpEsp
         L+yw==
X-Forwarded-Encrypted: i=1; AJvYcCUcNIQiI1dsyo31ccIf4dVhLwXBqf0P2L1ZwFxXXdS8u+LsVAcmwfcohV/fuUKh9D8bPrd1JcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8yfPOUvMp4gvokqKmd4Ym4KLE3Yk56vTywk9EnKx1C0LA0ae
	qn1zNcjbLa+PG4MirYFns+DO9w3C6pQAvw8XomVYx+L/P/Ic/y4C
X-Gm-Gg: ASbGnctK8HB5NhWJ9AZS5RglucSuVmv/EfAlct/KdfNqJDYYsExafngYw/S6X2asAii
	VJC5BJ7wKLla3dUR+Rg4gOBOHhmLJu7YJ6CT69V3TUMOOQR/5xww7ym78CBfvWCFvUlbOC4pkOG
	BNfAZskpRlN+bXzGnq1zmMJL2sJlD5mFXcXrH87+CLv02ORhWiU1UjjlTAwdtTSK31yhSw0Sy07
	j6Fh6+weY5kjcjWnFiywnnQnDKS8nZo4C2/MRc=
X-Google-Smtp-Source: AGHT+IE179aeoJVF/xJTXzkRB1047Yc+2x9I2LLqIFSxmadH4ORqjZwu6nWQNf71YbSvfXJP3+THmw==
X-Received: by 2002:a5d:6d02:0:b0:382:41ad:d8e1 with SMTP id ffacd0b85a97d-385fd42b9ddmr804660f8f.14.1733229799249;
        Tue, 03 Dec 2024 04:43:19 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3cbe250sm9875228f8f.94.2024.12.03.04.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:43:18 -0800 (PST)
Date: Tue, 3 Dec 2024 14:43:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v7 2/9] lib: packing: demote truncation error in
 pack() to a warning in __pack()
Message-ID: <20241203124316.er7w64rdkc4nedno@skbuf>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-2-ed22e38e6c65@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-packing-pack-fields-and-ice-implementation-v7-2-ed22e38e6c65@intel.com>

On Mon, Dec 02, 2024 at 04:26:25PM -0800, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Most of the sanity checks in pack() and unpack() can be covered at
> compile time. There is only one exception, and that is truncation of the
> uval during a pack() operation.
> 
> We'd like the error-less __pack() to catch that condition as well. But
> at the same time, it is currently the responsibility of consumer drivers
> (currently just sja1105) to print anything at all when this error
> occurs, and then discard the return code.
> 
> We can just print a loud warning in the library code and continue with
> the truncated __pack() operation. In practice, having the warning is
> very important, see commit 24deec6b9e4a ("net: dsa: sja1105: disallow
> C45 transactions on the BASE-TX MDIO bus") where the bug was caught
> exactly by noticing this print.
> 
> Add the first print to the packing library, and at the same time remove
> the print for the same condition from the sja1105 driver, to avoid
> double printing.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Somehow this is missing your sign off.

