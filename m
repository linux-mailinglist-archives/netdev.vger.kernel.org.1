Return-Path: <netdev+bounces-242719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D12C9415A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D05A1346307
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6961F4262;
	Sat, 29 Nov 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAKydBKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4461F03C5
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430861; cv=none; b=JQo7p8O3Y0O/D2h9VIVWlbWVXaJDelG+Q1qbxP9cy5cGNnOl898Z33U1bSIZXPhHkYYGokZZoY9j3m3SvU2edIAwFxfG14adcGtIka+qaPbZFfbfCdw4+N9R0GF0Qoh5Ppdcn0ESFmQXZipJrwRbXIz1rbaw4lOqjpABkezdqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430861; c=relaxed/simple;
	bh=98ShLA3Gc+8iz5Ta26raelUKEqRHNI5RcMvSUa3Fzio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqrdqhtnPP2zsiyKqxSFLTk96mPCsmytJk3Df3S3AUOkCu8DNrjdZ3ir6JMgeWO4oGKudGBn+HNuCoMHJ4k9lRY1hifvIV5LYg0Ox/lmwvskMW8qvUGzUSAMZAx5PMGRNcESOCVrUeua2UXTBCJyA6f9YPswgIgTU3XbxyUdMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAKydBKh; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2958db8ae4fso27929265ad.2
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764430859; x=1765035659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bbXgvlnENKnsdEGuYPN5PUkGwl/lkMRHa8r0W5LEG8=;
        b=JAKydBKhXsU0ISH+XEd016ZmB7u5XXayZU64X4rslL8+aJJE4J+QEmV0IXMgotpmfr
         pDtCeB68jznjPpy+L6bGWtsoivnKtKLKXeBliYKm8opsDjqVOaWG3/xTnxO6fLa7tzkm
         rh3OiJFh4zyxH0HMiWkWKOTqD4WVBCfZL3lZFF/oK6zPXtalQFCHBNj7dcfRHpcixUZ+
         8o+G8QX3o504DUHhEcs+uAFBem2qSPpWbYyngzWAL88tqmZe7wBUtNtM8HrD9CJTvMva
         pmKMY9MtNeShVYB40N591/YW4/sQsd4B/Ka+8Y++pxBqwa+JiqTgryEtfliFK2ktnNRS
         aGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764430859; x=1765035659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bbXgvlnENKnsdEGuYPN5PUkGwl/lkMRHa8r0W5LEG8=;
        b=FYUwTtjq4C3UgYcubhIj9ss/nAYq3MG27tYLRJufZPzn6PdFGCXNSFKs0WSp346qCD
         dWUtxqwvvB81UOh+BlQqgWjOZfBZN2qwqYHIvztHLwgO0/O1OmdMu84bNhqQKEg45w3b
         MhXGiNByLG3CH4v93hw497OT5mQcZjDGlPOhTqxl3ypo9BzLuAE3OWprNQlRpdQ2+BM2
         tcI8MTkEQHuDLxEQcJg2rY627udJivXPuLctx/3MjkOHN4GDDW4SxcS3nmNY+g2OYj8z
         dZdwnBv0jjsAc6V+VPzixR9XQo9VOvvRSutBb4st9fBFNBJpfkYmWJshqO+7z/4HKwzn
         2hdg==
X-Forwarded-Encrypted: i=1; AJvYcCX24PKNmsrvzOG3bge1e3wcKaupy29pgFHpRJNnffZAFfIs7X37s86Dxb39bCnsw5KbJ83fj6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBdwHtNLPJ6x+bQabGW+O/4ywznyGftrU7VWPuyagnLuc7ZbE
	WjRx0PPjm/pqQQM25MjOaXxVNsoscYwsv1jdM1j9OInXv9dAXQMWXVHj
X-Gm-Gg: ASbGncs5QTjTg+3IjQOfBuAmZ0mc6JqgzGfQWepirQH2ky09QpFYXeATJgI1TzjJe66
	/HhP+TizpGjYH90JA0MvxexdPUhn+m2d+UXMJQyws0eQ/iXFP6ic1ew17tlVANSOX8vISuflHVE
	I3dgv2NptfcCDR3NnomlBi+MNa1vnivG9Y7/DCM/lnagoWfaHcoI9J/KN4U3QwPzfiKGxD0zmz4
	aE0avrC9Hs80G4zvNmo7u0L61KO779OTIVD55Wv3mR/vF5XBFnnJA681o7Ku+UqAP1baZbaukKD
	panULHgrEk+FaXvEqIn/dYLJyH9N0Xowvl1GCH3XwhQ2o8skh6dWrjdTrlt7O3a1CYdRDZo/UTI
	6nDttC3IV4IKkSp1oLHni3ntM9d462bWO27j/q3mYDiCaEYi78r54X+p0teaIh4EkQW/g8sYU/+
	ydutTF5k+U4xKahiQ4ib92FRXWo+XqfX/kvek0/4Bm
X-Google-Smtp-Source: AGHT+IGR6+gSpgs55IR0ytGEOhQiXrSj5OpdthG/7BED4fO3xJA8Xtb2N1uITeOdeAVbOohzMgttKg==
X-Received: by 2002:a17:903:1b4d:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-29b6c3c30d4mr328707135ad.7.1764430859202;
        Sat, 29 Nov 2025 07:40:59 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7cf89sm76573825ad.99.2025.11.29.07.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 07:40:58 -0800 (PST)
Date: Sat, 29 Nov 2025 21:10:50 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tls: fix read/write of garbage value
Message-ID: <aSsUAvnn9dnwk91E@fedora>
References: <20251129063726.31210-1-ankitkhushwaha.linux@gmail.com>
 <aSrJTmtJqOX0rNDh@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSrJTmtJqOX0rNDh@krikkit>

On Sat, Nov 29, 2025 at 11:22:06AM +0100, Sabrina Dubroca wrote:
> I'm not opposed to making the compiler happy, but in this case
> "garbage" is completely fine, we don't care about the value.
> 
> So I think the subject and the commit message should talk about
> "silencing a compiler warning" rather than "fixing use of garbage
> value".
 
> And your patch should indicate the target tree in the subject (here,
> with [PATCH net-next]), see
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Hi Sabrina,
thanks for the review, i will send a v2 patch with suggested changes.

--
Ankit

