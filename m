Return-Path: <netdev+bounces-231145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3407DBF5AEB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99F01351188
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E02F3C1C;
	Tue, 21 Oct 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmL+vvwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196F2EFDB7
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041141; cv=none; b=t2Q0WJ5UEjkjQjMvKe0Z/BEBqXq34WOCkkSMXWSwfqUKcj9EHgjFRkGAnvVqbrupDpu0Gx0jB/UNq0hLK45RQcKa5ASw23AbTeGNaJ/7nS+cqtZHdiThfwxi9PcluIHcMANnF8s6AOITUqLAMUsXZnwfpUMRNyd8wxQNFFH5jVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041141; c=relaxed/simple;
	bh=FTOsFMG3yp3pBDy8xOCbJF+xRG784OPBIBrqv7Flc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3C18ok6RyrzBDg/4kmSaRivo0Au1q5d+7ABLlDObkcDDfng0LSrfrKPg9LRwP0AtK+bCCp2sTZwQGXBoXelwJjaIyO9D+jy93l5GvDLlSmbZb12uC5h6pIl96v8ZKuA6maIdpU7hPXvnM8FCOh/YKL1pmSo+atj5mWnJMlNCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmL+vvwe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-793021f348fso4788036b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761041140; x=1761645940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OK982plIE5xTlCsEWAT0p4OG+z+MqKJ2ACtf5l2iauI=;
        b=ZmL+vvweWzmu0JJ1kGQykJP7cgBv+3ihjHpt+s+HxMEiqWm2Kl5LIRZ0jo7uRdqJ10
         36te9gFpg8Alb7oP1X6XCFlbLYjdYz22Xh1Rcg1nFM3VSiX940Mj+kwVQvnhlsZLzKUV
         LZrzo2Iz8CAA/2ZqjjJ8tV5MCcsryafi33PB9HTRQ6AQKNJBJxoYyEjxchtjoMSL2wmf
         iB0pXq9SKKru7kx9IGyWEH+AO60XxBYpZpeABRs859TawgX02bkcTxVpAQiI1oWj344W
         o8/HPxfl+t6OJTBqbT+B7ark4KjWp8NRtDlCG7UnJLUhItxXgwpXbuYJVri40iVMOqjl
         20FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041140; x=1761645940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OK982plIE5xTlCsEWAT0p4OG+z+MqKJ2ACtf5l2iauI=;
        b=NVNLB1lLFTIZA282b12nMJeU6l7gLEYjcvUQy6lVPkOt7hLROXAsdz6FzDBayfNK76
         2bYuG+6gyPISOHHvW3r1xaKTOqxBvg+KHmhi2Z8tDGNlsHJYntlKVH5Ez+etmbPLn0aZ
         8N3tJWb4Ai3DBP90dXsu2K27zSkKfKi5tfWWH4nAmrZzNjg8AM99+oIGZCzGyfcqWeto
         ygbTLkK4ceATeLwYA2CgIjE1Fh+dX44SYuC0aQQY48zIwNpkrh7FQ9hI457SPJlg3dyg
         wCRobe3kSyjR9odPV7Z9P3l5EgfCrM2ePFIhTMIaZnzGMe3LWeeBEDbw7QR1izVmpxsN
         0ZmA==
X-Forwarded-Encrypted: i=1; AJvYcCWNOfsqfQduVWuH8o+BJMlG2XFjJM86ctUvjp8qbe12jQ5/s3H1KYeWjByAFKkJtVje2hHjWFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vgQ4Fr76BAxnfGSFd6BpxfX0tQ3hxumtsYfBur0VK4a0N6sd
	ffFjuOGa74m2WR034Ocr0cLBXDNG4ACfcSrWmsFAXvzQ40iiPmZT+920
X-Gm-Gg: ASbGncsrXR66kCb0qC5dHxjMpTU15STifPhUntcZA85VD8d0YyJKm4iHXyc6s9NCJ3C
	to8D0Wx6MU32bpWfgMIL4eYcaXkVkJVyxxvyR5h+kzSsD/3M1Wh1neYitGC3SAlXuc02P3EZ0td
	MsTFymii5BeNoFKQbvgVNCOd/NMDX6UV6z18Z7GLAtma+qSilk3IFYhtdzhzcvnNyTZ47wVXFuu
	BtqBNotMZTRM7BWlgmqhB8lLdbTxRvW8v4gOggjCEf9ybLPgI5OCnaI9WZFxap3aOpeVCFyFk70
	AQLBh0ifblUL+C2YbUb4GDgU98RDqf1ZBNEmKIO99QukEpIBQubwHNg85FM4CCi3asCULVOH3Ap
	D6rlczBO1JXvlHqwrOQ7XS6AqbkUspIiaLVdERi/PiTZN+eg+CsBoQJSfpHC7+B4T7AQJZlpCA4
	+08w2U
X-Google-Smtp-Source: AGHT+IHJQ0BdOK4jZyJacNzTC1eK//itHFo/MOna8+vtP/DHwBgPdvCVlQ4hYf0g7EVbWtGRbkRLqg==
X-Received: by 2002:a17:90b:4c0b:b0:32e:d599:1f66 with SMTP id 98e67ed59e1d1-33bcf8fbaa0mr18152011a91.30.1761041139455;
        Tue, 21 Oct 2025 03:05:39 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664a228sm9783349a12.4.2025.10.21.03.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:05:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:05:29 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
Message-ID: <aPda6cAl5UK1g-ze@fedora>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com>
 <aPX8di8QX96JvIZY@krikkit>
 <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e85a2b-58b0-4460-ae7a-b1ea01e4d7e4@redhat.com>

On Tue, Oct 21, 2025 at 10:46:22AM +0200, Paolo Abeni wrote:
> >> + *	netdev_compute_master_upper_features - compute feature from lowers
> > 
> > nit: I'm slightly annoyed (that's not quite the right word, sorry)
> > that we're adding a new function to "compute features" that doesn't
> > touch netdev->features, but I can't come up with a better name
> > (the best I got was "compute extra features" and it doesn't help).
> 
> I'm not the right person to ask a good name, and I'm ok with the current
> one, but since the question is pending... what about:
> 
> netdev_{compute,update}_offloads_from_lower()

The naming is a bit inconsistent.

We originally used netdev_compute_features_from_lowers(), but later changed it
to netdev_compute_master_upper_features() based on Jiri’s suggestion.
Following that pattern, maybe netdev_compute_master_upper_offloads() would be
a suitable name?

If you agree, I can post a new version. If not, we can just leave it as is.

Thanks
Hangbin

