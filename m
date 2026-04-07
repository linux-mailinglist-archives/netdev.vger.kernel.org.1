Return-Path: <netdev+bounces-276128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMtUIFlJ1Wk44AcAu9opvQ
	(envelope-from <netdev+bounces-276128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:13:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E0F3B2D41
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0751130AABF7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF63C457A;
	Tue,  7 Apr 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRyzBbe6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2F34751F
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585421; cv=none; b=JIDb8ZXE7t1hGOYHJ0kOiHQjzvxNRJFpkgFnGGmFJDMVIVMyQprxhoZ48nmgWyc7UjUpUB5Cu3mft67zpQsG8wrCt+konSnhnPeg5p13yxuKFxJsBGCE682Y+bgTsoly5vNhs7fDdAHz47A5a5aAJM7qwoK9LcWdnLiR+7HSOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585421; c=relaxed/simple;
	bh=tcl1qfLwMS19L3mzncct5CqtESe0HXvGG66E6xJupqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cncG3heshY7WayH7xaduQufb798bVHElXGoAB0XK1At9l7p+8O+pqUd8rB9rXsEWQakittrL0t5tql07tJetF94YI//JE1A6akyPLibKeHmMq07Pwk4VH0gxHm36VEJoGoUgZPjO8th3DqsG5YnhDI2rBbSz8eWr6Q90oFMawEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRyzBbe6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775585419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UbtzswuJRThoMSkK1uWOBU5lGKQH4eolmDAlpqc4rxU=;
	b=BRyzBbe6cVGjMaAdmXOYQ+qIu2nVQNAHEwPaEaG3Pf+/We4ymwYb+6eMFTtj084bXll5FB
	qeke97M8nrm1v4GDbpD9lEv3q6mFBRAvidWp+tkapNPUvXeBcmq3z1Tw4fFLOMm3EnwFcZ
	uGx6bbdKDOQK94gOikzt//4uTgZBHxs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-0YH3eheZMEKUe9f5o6VV7w-1; Tue,
 07 Apr 2026 14:10:12 -0400
X-MC-Unique: 0YH3eheZMEKUe9f5o6VV7w-1
X-Mimecast-MFC-AGG-ID: 0YH3eheZMEKUe9f5o6VV7w_1775585411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EC13180049D;
	Tue,  7 Apr 2026 18:10:10 +0000 (UTC)
Received: from thinkpad (unknown [10.44.50.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EBAD300019F;
	Tue,  7 Apr 2026 18:10:07 +0000 (UTC)
Date: Tue, 7 Apr 2026 20:10:04 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <adVIfNgLCvhxr7UU@thinkpad>
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <4549f521-6395-4c26-921e-eaead7248a36@suse.de>
 <DHHZD2L18VZT.2TLAQO4JAD79Y@linux.dev>
 <78c9c953-1aaa-4d44-9c1d-b4e52a5cead3@suse.de>
 <811E5B8F-85E7-47E2-BEA1-25E62C68929C@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811E5B8F-85E7-47E2-BEA1-25E62C68929C@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9E0F3B2D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 08:34:47AM +0200, Luka Gejak wrote:
> On April 2, 2026 1:30:57 AM GMT+02:00, Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> >On 4/1/26 7:05 PM, Luka Gejak wrote:
> >> On Wed Apr 1, 2026 at 11:52 AM CEST, Fernando Fernandez Mancera wrote:
> >>> On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
> >>>> From: Luka Gejak <luka.gejak@linux.dev>
> >>>>
> >>>> Supervision frames are only valid if terminated with a zero-length EOT
> >>>> TLV. The current check fails to reject non-EOT entries as the terminal
> >>>> TLV, potentially allowing malformed supervision traffic.
> >>>>
> >>>> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> >>>> with a length of zero.
> >>>>
> >>>> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
> >>>> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> >>>> ---
> >>>
> >>> Hi,
> >>>
> >>> This has not been reviewed by Felix. Felix provided his Reviewed-by tag
> >>> for the v1 which was completely different than this.
> >>>
> >>> Revisions of this patch:
> >>>
> >>> v3: https://lore.kernel.org/all/20260329112313.17164-4-luka.gejak@linux.dev/
> >>>
> >>> v2: https://lore.kernel.org/all/20260326154715.38405-4-luka.gejak@linux.dev/
> >>>
> >>> v1:
> >>> https://lore.kernel.org/all/20260324143503.187642-4-luka.gejak@linux.dev/
> >>>
> >>> Are these contributions LLM/AI generated? I believe so based on the
> >>> email history.
> >>>
> >>> AI generated review on rtl8723bs:
> >>> https://lore.kernel.org/all/B2394A3C-25FD-4CEA-8557-3E68F1F60357@linux.dev/
> >>>
> >>> Another AI generated review on rtl8723bs:
> >>> https://lore.kernel.org/all/3831D599-655E-40B2-9E5D-9DF956013088@linux.dev/
> >>>
> >>> Likely an AI generated review on a 1 year old HSR patch:
> >>> https://lore.kernel.org/all/DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev/
> >>>
> >>> If these are indeed, AI generated contributions or reviews they should
> >>> be disclosed beforehand. Also there is the Assisted-by: tag. Also note
> >>> that developer must take full responsibility for the contribution which
> >>> means understanding it completely.
> >>>
> >>> https://docs.kernel.org/process/coding-assistants.html#signed-off-by-and-developer-certificate-of-origin
> >>>
> >>> Thanks,
> >>> Fernando.
> >>
> >> HI Fernando,
> >> One more question, should I include Assisted-by tag in v5 if AI was not
> >> used for writing code but only for formating and translation of the
> >> emails to English as I previously mentioned.
> >>
> >
> >I think yes, you should. I also think that AI was actually used for the generated code and also for spotting the valid and invalid issues. If you don't have a real environment for HSR, why would you look into it?
> >
> >Sorry, it is not my intention to be harsh but there are some things that don't add up for me. Maybe I am being too careful here and you just coincidentally found these problems.
> >
> >> Best regards,
> >> Luka Gejak
> >>
> >
>
> Hi Fernando,
> I understand the concern. To clarify, I am a student, and I discovered
> these issues while reading the HSR source to learn about network
> redundancy. Since I lack industrial hardware, I verified the logic
> using network namespaces and veth pairs on my Arch laptop. The code
> and logic are entirely my. As previously mentioned, I only use AI for
> English translation and formatting to ensure my communication is
> clear.

Hi Luka,

I honestly appreciate that you are learning about networking
technologies and the kernel and that you are posting patches to improve
the kernel!

I do, however, share some of Fernando's concerns. I especially doubt
that AI tools were not used for the code here. This isn't forbidden or
even a problem in and of itself, but we'd like to have proper disclosure
of the fact and attribution of the tool, as the policy linked to by
Fernando states.

Let me add a few words for why I (personally) think this is important.
When you submit patches to the mailing lists, there are real humans
taking real time to review the changes. The reviews are much more easy
if the reviewers have all the relevant context available to them. The
information that the code was developed with assistance of an AI tool is
relevant because reviewers pay attention to different types of issues
depending on whether AI wrote the code or a human wrote the code, simply
because they make different mistakes. Additionally, by not disclosing AI
tool usage, you add one more step to a review (determining if the code
is AI generated) which takes away capacity from the review itself.

With that said: I don't want to express blame here for anyone. It's just
a reminder to be helpful and considerate towards the community and the
reviewers, so they can be helpful to you with your submissions.

Thanks,
   Felix


