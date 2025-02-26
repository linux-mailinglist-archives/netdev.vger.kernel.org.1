Return-Path: <netdev+bounces-169965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B474A46AB2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F76B7A73D8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95071237702;
	Wed, 26 Feb 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrCNdM5B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1C2248B4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597297; cv=none; b=VPifoIad7DpnCNAfxSsngLjWj1g0cAT26RrEw5QQIN8jOf1RA3Ul0pHnHohmsQWUdUnaRQ8Awrzb+mNGDnmDJRhGrjXNIyml6fy7Ww3e6lWeJY7AmYRHTiYRhjTnaoP50yxQbfPF3DTw9ppe0+TfgSurFOZL3G5fkLzIWfSuQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597297; c=relaxed/simple;
	bh=NhmONbR6Kz0FVFEI1qzKO5/VG/mOkNn5G3jRJ1/Ui0E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EOCRRHoJfpIEVFJW+IUpVyaymNTmXtQWtf3xlvZ+Ju0prEaxWz5qcxh/cuizCIbx6RPSY/zOBFSYx7gzCw164Nezmh0H5FnTH8un6liOmGA5L/EXYIySgJCZaDzlr9AY8T1T5+qxEbTFl4LjF6IYQBYMaDrQUQjl9aAI4SlVd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrCNdM5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740597294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXusiqKUd0N8mZ+N1Pw+0C9FOXib+lo8DTi+DczZMkI=;
	b=MrCNdM5BD/6RF0PCfSmvNuuPobM8uTyiTbrezwdsv5UB8rXrwoYqceT3vvbP/fcoPRjZVA
	pjywx6DL8tl8YcwZWYTuWXFmMA6sLF0qqKK63olxacOvzJy8DJOFDeaPchKFC+oiqDie/F
	gINdLoCHoYrxXkFQ6P+JG4IQkiqagYU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-rO-D1SgOM8-pCV7c4lHKOQ-1; Wed,
 26 Feb 2025 14:14:51 -0500
X-MC-Unique: rO-D1SgOM8-pCV7c4lHKOQ-1
X-Mimecast-MFC-AGG-ID: rO-D1SgOM8-pCV7c4lHKOQ_1740597290
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB52018EAB38;
	Wed, 26 Feb 2025 19:14:49 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.33.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EA641944D02;
	Wed, 26 Feb 2025 19:14:47 +0000 (UTC)
Date: Wed, 26 Feb 2025 20:14:43 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
    Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
In-Reply-To: <2a7ed528-ed5d-d995-f7fe-12e3319aba27@redhat.com>
Message-ID: <d26ea97a-1ef8-aee0-d9fb-7ba80ddcdcb0@redhat.com>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com> <20250220165401.6d9bfc8c@kernel.org> <c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com> <20250221144408.784cc642@kernel.org>
 <2a7ed528-ed5d-d995-f7fe-12e3319aba27@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Mon, 24 Feb 2025, Pablo Martin Medrano wrote:

> On Fri, 21 Feb 2025, Jakub Kicinski wrote:
>
> > Hm. Wouldn't we ideally specify the flow length in bytes? Instead of
> > giving all machines 1 sec, ask to transfer ${TDB number of bytes} and
> > on fast machines it will complete in 1 sec, on slower machines take
> > longer but have a good chance of still growing the windows?
> >

Testing in my development machine, the equivalent to 1 second worth of
packages is around 1000000000, changing -l 1 to -l -1000000000 resulted
in the same time and the same test behaviour.

To force the failure I generate load using stress-ng --sock <n> with
increasing values of n. The values for n needed for the test to fail are
higher with the 'fixed number of packages' approach.

Testing in the original 'slow system' it increases the time of each
iteration to about 10 seconds, and it does not fail in the same
circumstances.

But I have some concerns about this approach instead of the xfail on
slow:

- If I generate load in the slow system, the "number of packages"
  approach also fails, so it is not clear how many packages to set.

- The test maybe slower in slower systems where it previously worked
  fine.

- The generation of packages and the time for the tcp window to adapt
  increase linearly? Isn't there the possibility that in future _faster_
  systems the test fails because the netperf session goes too fast?


