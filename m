Return-Path: <netdev+bounces-169121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BEA42A08
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026CE175178
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A9221F0D;
	Mon, 24 Feb 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE7P2kEy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD43264A96
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418508; cv=none; b=dUvFKjfwnSn/Wbj3hCNmCusZFW4BWErB07TsdMoLWud9UWngjFPd9lmicn/+RsKOXjIOgmsvyhYy9S0uWT2Vq1z5HlgLDMy+V2yrdrQRqEq8gz1EMFtpi84Pjaq/y58xQeo1UY0+20R6OAR2018uvKk1G5PGdOxPKrQrqtv23jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418508; c=relaxed/simple;
	bh=rGgoYWIlkI8+3sBWjSmzeTRP0CqbQA48Jnot92sxbuc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DWwAy3bfNDri0oizaKXiB/ZlFCMCRxTINz6r6PbndqXmMD+qW9w38ynAtrY1XMlx7ywuoPwInzKw6DDNUd8lzxG/ys/PTC0Jigo/obSbYRGLc5VwblqPfmCBlLYF1Rw9PAF3O96ecKffXEBnd74nLD2nsOqGfZJL/ONaW4zOo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HE7P2kEy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740418505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGgoYWIlkI8+3sBWjSmzeTRP0CqbQA48Jnot92sxbuc=;
	b=HE7P2kEyGNNElY+l3/1DWWYh760JF8loRHGL5fo7cyYfVxCFMJMQefJZNY75CpPxFrirIZ
	nwNCjXKl+dxAwrV3zHRE13ru1sWsFqbD9MZRfHB+z6S6lXpsVij5LPld/QenVO/53SswtI
	JmnNgXMlg47+XFiXIbk6nL1LjTalDRQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-an0Bv3_kM-e-Tv0Gy7ohVQ-1; Mon,
 24 Feb 2025 12:35:01 -0500
X-MC-Unique: an0Bv3_kM-e-Tv0Gy7ohVQ-1
X-Mimecast-MFC-AGG-ID: an0Bv3_kM-e-Tv0Gy7ohVQ_1740418500
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BE7119783B7;
	Mon, 24 Feb 2025 17:35:00 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.42.28.157])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 481A21800357;
	Mon, 24 Feb 2025 17:34:58 +0000 (UTC)
Date: Mon, 24 Feb 2025 18:34:55 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Simon Horman <horms@kernel.org>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
In-Reply-To: <20250224134430.GA2858114@kernel.org>
Message-ID: <38aad71b-db71-d502-9ce6-9bf2efd5a717@redhat.com>
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com> <20250224134430.GA2858114@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Mon, 24 Feb 2025, Simon Horman wrote:

> Hi Pablo,
>
> FWIIW, I think this can be moved to below the scissors ("---").
>
> Checkpatch complains that fixes tags should have 12 or more characters of
> sha1 hash.
>
> Fixes: a19747c3b9bf ("selftests: net: let big_tcp test cope with slow env")

Thank you Simon! I will modify this for the next version. Looks like I am
falling in all the stones possible for my first patch :) Receiving such a
friendly support is great.

>
> Lastly, and most importantly, it seems that there is new feedback on a
> predecessor of this patch, which probably needs to be addressed.

Addressing it. Thank you for pointing it out!


