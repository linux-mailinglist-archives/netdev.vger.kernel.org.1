Return-Path: <netdev+bounces-153765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E09F9A85
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737F17A0344
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCB21D591;
	Fri, 20 Dec 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+BwZ7dA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89F1A00D1
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723112; cv=none; b=tiu0bcUY9ZhaA19q+FaFL0GNinSFPaTjW+i/dcrLGpf/LEYDNifBOCtoSCQzW6LBmXgGkVXImHdyYupJBx/7Kxn1cphj++yiPM2bAq4QS/FYwNIFU0kocNZWjkUXyUgKEg0si9L+smnMpddhacMc32hEjUKjdjmbvP8/7OAWOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723112; c=relaxed/simple;
	bh=+4g4e4/8/+FDcyJHcl/sVApYT/CcOCKIby3fyXQX2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvMb4A1RKXxwxZ9ZUDLPA5GmvYCPwa7hI3DTri9F1IoTlxPqz6Q+DbVQ8CvR5s09dbU+LKHtw+eI4q+np2MDyot79/7ob6oAVD/fPpr39s1cw+YJ3f5aHos0xo3NfeQxdzSRoX0Zu/Tb0PR6pqmEjb9OSBg1DxJhCQn3MD5kMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+BwZ7dA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CE8C4CECD;
	Fri, 20 Dec 2024 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734723111;
	bh=+4g4e4/8/+FDcyJHcl/sVApYT/CcOCKIby3fyXQX2pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+BwZ7dAqUU63NzEoYE/uaCP+32cdn76WZxJkPrP1X1f76fnQmmIt/Tsl+mVES+Ca
	 VSanIA0ieLU45V4oJBMq2qeRnhx/+AGJHnU43j0L/LIvsJ30i4YJmIn5llnty9j+NV
	 ImZ69n7A1wrenZ8cVuq0nBWoJjU3u6kK8jCfHUpwbn+TKWJmZKmyeNff0ViB4tNK2+
	 rx/GuZCj4d/qIkVElokQrThA30pPMssdqXrqW+Ex5vmBz8PHVqwwRW0kmjnNMJ9p+H
	 Jrsg+xW5t5Ss4Kh+b6wH+FVCldgT8VVX/2EyD1c25Ye1JCnyEQAeZ8dkV9sM3s+xZj
	 rueIYPJ2+u79g==
Date: Fri, 20 Dec 2024 11:31:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API
 for Homa
Message-ID: <20241220113150.26fc7b8f@kernel.org>
In-Reply-To: <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
	<20241217000626.2958-2-ouster@cs.stanford.edu>
	<20241218174345.453907db@kernel.org>
	<CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
	<20241219174109.198f7094@kernel.org>
	<CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 09:59:53 -0800 John Ousterhout wrote:
> > > I see that "void *" is used in the declaration for struct msghdr
> > > (along with some other pointer types as well) and struct msghdr is
> > > part of several uAPI interfaces, no?  
> >
> > Off the top off my head this use is a source of major pain, grep around
> > for compat_msghdr.  
> 
> How should I go about confirming that this __aligned_u64 is indeed the
> expected convention (sounds like you aren't certain)?

Let me add Arnd Bergmann to the CC list, he will correct me if 
I'm wrong. Otherwise you can trust my intuition :)

> Also, any idea why it needs to be aligned rather than just __u64?

The main problem is that if __u64 doesn't force alignment on a 32b
version of a platform the struct may have holes and padding in
different places on 32b vs 64b compat.

Double checking, I don't think that's the case for your structs, 
so you can most likely go with a plain __u64.

