Return-Path: <netdev+bounces-109701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535429299CB
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 23:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DFA1F2146B
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF61F171;
	Sun,  7 Jul 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rQJQrc7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1861E894
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720387003; cv=none; b=FMF3mSz/yIvOF1/ELi02shidLbXUa0BEhmZj6roHqSQZCnydeRDMoNGxpspQReV/xHJ72emamZOj67piAlI1E+ZMcD6Dp5CKMlEczZx4ZJmWBTcQ5j+KLc6zoC1o62FTIHj2Goh1EEMoYcd8U242LYo8Tfn3dcgSl/oA1B5d2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720387003; c=relaxed/simple;
	bh=iRmFCJ5phnOkgFFJS/eCRl7vqEuLMfaGgJ074lBD2QU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO6i9JFn1c7FIVG+jWLfq3XtSztS/xNfVP3K/uwJm8qt188u3+o8uQKGYagn0O/N/7bcJYz4Sq3948MHTFV/4uVj/iCH3lKk2Umcbb7CB7mpWEQ9aOgVaeN1Wc5BwD0cNjBpu0j3cen4nToSwXl+9YExTFsoVloKnyrGwYPjUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rQJQrc7j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so17988315ad.1
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720387001; x=1720991801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7rujIh7kUtCTFUJXB9kK3k8vU8XwkXhSTPtNGzN56s=;
        b=rQJQrc7jkUA1AHZN+9n01x7frubk92Ok/nEoKICKr7NnuwPeNsP3IJHRd9dI3/RAgk
         jEINAcU46S/1FZtzk+beCkKIrvMklzAd85v+4U+53aobE+yvDrdA0necHgoNsS7jaLfy
         SrWYBFSkDsjjxb0309EPHthL6/kuxSEHZgon8eZIsfcA/cPLw/xbr8T5JbtHQtfYvZ8y
         KOOz3QHpm5OlC8EUA5WrB7r+WLVa7iwQpAjE9noyjvvff2CHqkEc/2pMZMN+fGJQh4kD
         DUY6GlOWVOTn2uVEZOeGjV9WY9h6l/kw/NfOD6zfK4MWPLDCo4dXUhnnIGMdlwtatizE
         nOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720387001; x=1720991801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7rujIh7kUtCTFUJXB9kK3k8vU8XwkXhSTPtNGzN56s=;
        b=biRI/TzM79gR1b9ZxDFfTK2IJVDSH/nQo56DwswesvctsyJN6R3pzDMApBNbfBcyC3
         uXhfxg5DaSbkUPv82EG5aTO6T+9GpTpTuXRec3LkqOvgiTbVDrL+atGh0woWr+toyXZm
         Rff3ZIcXPF9gO8MK40dN8TYU9OSfABfXfrZ5/fbFGiXVJhQbpDxOYFkTOMA93lIZ/4Vo
         71EP9pwIm6LxSMV1mH5yii1noK9/vFD1/zOY+eN3hu7LD3TRvLPeWVzH0jKL6AgB9MJV
         PuhhYvD+0b7oKxhs96+2p2fTND6F0GrjNpsUaGbwHwDm2aMZpEePHwQOt5lMObRhKhBp
         cG0A==
X-Forwarded-Encrypted: i=1; AJvYcCXyt7jtau/FWxB1Wkuv5kCcuS+YhNziGWHCs29m7PuJIylquWAmCTIhlI91ObHxsE3sMIc8Nlk6nLE7yfCA/pn8oMjtQrw+
X-Gm-Message-State: AOJu0Yw3r51KiJb0VV0N9LD5m2SYEBsGiUXqlpxKthcF01fE1V0kwa8k
	SNEPRLHV98aOT05a1J05YUyQ2kW2I3UZ61M5xt2kB7mK75FFhPugWu8MIyYOsnY=
X-Google-Smtp-Source: AGHT+IE8Z8fZB6kUhyPOMHUOeNTaoPytTCqOQNgAm87ZwnmIJz9NCQrVtvYpbTmjX0IBivQi/6hTSg==
X-Received: by 2002:a17:902:d2c8:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1fb33e05413mr81267495ad.12.1720387000805;
        Sun, 07 Jul 2024 14:16:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb64a608d6sm29879215ad.176.2024.07.07.14.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 14:16:40 -0700 (PDT)
Date: Sun, 7 Jul 2024 14:16:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Message-ID: <20240707141638.799ac0b5@hermes.local>
In-Reply-To: <c83bb901-686e-4507-b4b1-020ae86d2381@kernel.org>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
	<172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
	<d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
	<20240705204915.1e9333ae@hermes.local>
	<547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
	<20240706125616.690e7b98@hermes.local>
	<c83bb901-686e-4507-b4b1-020ae86d2381@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jul 2024 10:16:11 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 7/6/24 1:56 PM, Stephen Hemminger wrote:
> > The original point was to have kernel -next and iproute2 -next branches
> > and have support arrive at same time on both sides. The problem is when
> > developers get behind, and the iproute2 patches arrive after the kernel cycle
> > and then would end up get delayed another 3 to 4 months.  
> 
> Then the userspace patches should be sent when the kernel patches are
> merged. Period. no excuses. Any delay is on the developer.

I would suggest that the netdev maintainers not accept any new
feature to net-next (that uses iproute2) until/unless the iproute2 update
patch has been posted. This prevents this problem, and the problem of
getting userspace API wrong.

> 
> > 
> > Example:
> > 	If mst had been submitted during 6.9 -next open window, then
> > 	it would have arrived in iproute2 when -next was merged in May 2024 and
> > 	would get released concurrently with 6.10 (July 2024).
> > 	When MST was submitted later, if it goes through -next, then it would
> > 	get merged to main in August 2024 and released concurrently with 6.11
> > 	in October. By merging to main, it will be in July.  
> 
> Same exact problem with netkit and I told Daniel no. We have a
> development policy for new features; it must apply across the board to
> all of them.
> 
> > 
> > I understand your concern, and probably better not to have done it.  
> 
> You applied patches for a new feature just a week or two before release.
> It is just wrong. It would be best to either back up the branch or
> revert them.

Will backup the branch since these are the the last patches merged.


