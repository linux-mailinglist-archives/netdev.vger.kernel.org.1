Return-Path: <netdev+bounces-172937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EACA568DC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C0D3B13D2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A1D21A422;
	Fri,  7 Mar 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vp97v42k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B1156F5D
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353961; cv=none; b=jCCVLc8nYUgi69VZjWzFxDSckcuzHl4sCIszBQaYwuhHjr2OD6I5Xu9vxhWAiChLJlWRuMjuXm4yAO2cdDg+qbB86S1iVkr6pj1K2l1tYsreAzch56y/MIdSn3iOKznmefgOrt66xS3ok1ap0YEin05kZSuVNHz2N1tzfzNjM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353961; c=relaxed/simple;
	bh=QjFtvFBCOpKFhZFNQHlsjywHYpBnf+5fShh9rKHlSSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HW9CDpVXJdzvLgCViivmU3qwpWhHgZdIp+ORC3xvE808ew6bMNTRzQY1drMh1hQxVfO0fDJgGO+sd32HPn2sQToLMLfvXJZQ3ChlGiNVYA7BG2DvfTrnm0raKJ3MJNup4yRrGk3cM9WviX9NaCJq/SxAWFqzSW5bHXKvcuBlXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vp97v42k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741353958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XrKagdOJGjtdIULAsDlR0i/bowAYipZ2lwgi9ghdXg=;
	b=Vp97v42kBblwrwSHcL00vwusvpwSxpWqxlxfwsztjwfnaoUEKaVs91Kt1qDrJU662axtDB
	5KEPUFh3gM8PP5R9Y+F2uzvMq7RnfYJ8AC8lKy7bDh28Q/K2MaNaiEMes+mbyzh9qeI3N3
	W7wPNgc0gZmF9829LqTdu4U+UYeL/P4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-QehtcVAxMqi6BFI5QwNntw-1; Fri,
 07 Mar 2025 08:25:55 -0500
X-MC-Unique: QehtcVAxMqi6BFI5QwNntw-1
X-Mimecast-MFC-AGG-ID: QehtcVAxMqi6BFI5QwNntw_1741353953
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C36419560BB;
	Fri,  7 Mar 2025 13:25:53 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C6B91801747;
	Fri,  7 Mar 2025 13:25:50 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>,  davem@davemloft.net,
  netdev@vger.kernel.org,  edumazet@google.com,  pabeni@redhat.com,
  andrew+netdev@lunn.ch,  horms@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: add a note on selftest posting
In-Reply-To: <20250306112522.0a2b38b6@kernel.org> (Jakub Kicinski's message of
	"Thu, 6 Mar 2025 11:25:22 -0800")
References: <20250306180533.1864075-1-kuba@kernel.org>
	<ba1afa07-ea24-4ae5-8f65-fc2fc24f1a22@kernel.org>
	<20250306112522.0a2b38b6@kernel.org>
Date: Fri, 07 Mar 2025 08:25:48 -0500
Message-ID: <f7tr0392crn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 6 Mar 2025 19:22:49 +0100 Matthieu Baerts wrote:
>> > +Co-posting selftests
>> > +--------------------
>> > +
>> > +Selftests should be part of the same series as the code changes.
>> > +Specifically for fixes both code change and related test should go into
>> > +the same tree (the tests may lack a Fixes tag, which is expected).  
>> 
>> Regarding the Fixes tag in the tests, could we eventually suggest using
>> the same one as for the code change?
>> 
>> Sometimes, I do that to get the corresponding test backported as well,
>> if there are no conflicts. That's good to have an easy way to check if
>> something has been correctly fixed on stable versions as well.
>
> Hm, that's probably up to the stable team to decide. My intuition
> is to reserve Fixes tags for fixes, and add another tag if necessary.

+1

You could consider something like "Tests: xxx", but the problem is that
not every fix will perfectly map to a test, and as noted below, it is
possible that the fixes don't merge cleanly.  I don't know if there
would be a good tag that makes sense, really.

> The mention of the Fixes tag was primarily because of NIPA checks...
> A bit of a wink and a nod since we try not to speak about NIPA checks.
>
>> The only thing is with the selftests written in Python or Bash: it is
>> easy to get a situation where there are no conflicts, but the
>> modification doesn't work, e.g. some functions or variables are not
>> available, etc. The stable team will then not notice that during their
>> build tests. Not sure if my suggestion is safe to recommend then.

I also would note that I like the approach where the test cases detect
if the condition is even possible and [SKIP] if it isn't.  The reason is
that we can then run the latest and greatest copies of the selftest
suite against even older kernels.  Reality, it is not always possible to
do that either - so it probably needs to be case-by-case basis anyway.

> Good point..


