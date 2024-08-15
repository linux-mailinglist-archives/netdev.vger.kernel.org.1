Return-Path: <netdev+bounces-118720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438EC9528E7
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C9A1C2270D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEF1494A3;
	Thu, 15 Aug 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQiqFCCc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D831494C4
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699469; cv=none; b=AyGuhUmn9xzmKS3K/122kY0Arfz8OSjxxqn2wYFhxn+LuqB0j9K/U+TuWMsBya0/vY/sLjmyle2lXhtCnH0FFp/+OpGVQpR71DBfeeHP1YcJ20nucrz/JHNrYhssjWXEsokaXqHusMhD7hk9mBRKejPOLZ+QxBhTpp+3KLJ7c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699469; c=relaxed/simple;
	bh=kjXfPq9BkqNLiNmkWUNGgnT0PMeMF1lcxBd3MEdFQrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip9JXye+0kX5BNrw1a3Db4dw2wakHTYCn6q5nKQ40VkvAJjc6NhpSGDBBHIgrA/Fyrs+hlmElZt9TIErroCK5/pIUPR7k50IYl6XrFS3SRayl+Yod9RRl+H/pwFuWgY7P1HPnhgSGMkV7e95WUlNzxDmfTXVfFAgxuB6XK0Q85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQiqFCCc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723699466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYx7xZkt9eSbJOCYSPXaKHYVyo+CtQM88si3lp0YJtw=;
	b=WQiqFCCcYkzcsu9GTiQIfs5sPyeIWOERTtSFPzA+8B1Yx/ro/bl9RbZ3HWbZnldaErEkgX
	RAuNuoobx3YmiZ4Ih0HwpPg9F3iidZ9YUCEVQYj/OJKWG7mRVumUQCHm73LjkSZ0HS2FdT
	SnJG7IoerEk9zz5+ENc3fljKuHWElVg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-_ltXWiIJMva5k6Y2aAdKBA-1; Thu,
 15 Aug 2024 01:24:17 -0400
X-MC-Unique: _ltXWiIJMva5k6Y2aAdKBA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD82C195609E;
	Thu, 15 Aug 2024 05:24:15 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D38119560A3;
	Thu, 15 Aug 2024 05:24:12 +0000 (UTC)
Date: Thu, 15 Aug 2024 07:24:10 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maciek Machnikowski <maciek@machnikowski.net>,
	netdev@vger.kernel.org, jacob.e.keller@intel.com,
	darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr2Q-sti4TjSjEug@localhost>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <Zr13BpeT1on0k7TN@hoboy.vegasvil.org>
 <Zr2BDLnmIHCrceze@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr2BDLnmIHCrceze@hoboy.vegasvil.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Aug 14, 2024 at 09:16:12PM -0700, Richard Cochran wrote:
> Actually, looking at the NTP code, we have:
> 
> void process_adjtimex_modes(const struct __kernel_timex *txc,)
> {
> 	...
> 	if (txc->modes & ADJ_ESTERROR)
> 		time_esterror = txc->esterror;
> 	...
> }
> 
> So I guess PHCs should also support setting this from user space?

Yes, I'd like that very much. It would allow other applications to get
the estimated error of the clock they are using. Maxerror would be
nice too, even if it didn't increase automatically at 500 ppm as the
system clock. IIRC this was proposed before for the cross-timestamping
PHC between VM host and guests, but there wasn't much interest at the
time.

-- 
Miroslav Lichvar


