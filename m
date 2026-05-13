Return-Path: <netdev+bounces-287490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BhwDJhGBGp2GgIAu9opvQ
	(envelope-from <netdev+bounces-287490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:38:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80510530C6E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5578A302452E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794933ADB8F;
	Wed, 13 May 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="duPfeiNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26233DDDBF
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663838; cv=none; b=G+/6LBUTvkUSiAfH6+pn2AzZkKM+v+nCmj57nwmlXVGMHyprK512K9t0/g1KyD369MLnX6jV02DtH3UwsDN0+xA0Il15GUxLd89tmLyYfc64DZEC9Tkt3/NFScqb8atyKBcBC11KMIQ86rt442UDQkRY6/Jm8kest7iM4/UgQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663838; c=relaxed/simple;
	bh=SIg35o41z1LZVAKC3fAi3BASks1XM5AoHSYceWAirFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDfATO4tjWCrmNlEcFV75ZCKtk07PejenXElDh5JNQRh8bcvNqb910Zfp9lqAZBY/n9iemH59CRIGaeJYY8Lp8YfctOh9dLa7AjRDxluchSYiHQAQ3Rl7m82zYJRt5lozcF28ardii+RAtNJ691GxUJQIwl+XCcvONfF5FKilNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=duPfeiNF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso944977466b.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778663835; x=1779268635; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIg35o41z1LZVAKC3fAi3BASks1XM5AoHSYceWAirFk=;
        b=duPfeiNFAprAJGBmpdyVnMnxkvfy6NFXEnzHRzsG3hy0jXvgYke45Fwv+RJ9MEnR8+
         xhrf5Isu2/isFEai/mvr6H3P6k++JhXzMo7JWy5vcY09qG/1ts16giIy1lryE6IvJez+
         dnlCJC3PAFHw6Qsj5PWBlGUq7/YeFLPKpEtt8w3a9d8WfzhmFFdR6v50rVwUh2n5ifDm
         lS801S0uPgCyir2mZJsyqreP0J7wCHQhxHkE6tV26H7PdZQ51YXdaPyOJ6DkQR8E/4Ls
         Aj+t45Ovpp21Wwpq9CmRv8diSrQbNI5RERt8wGJT5/AlMGi8CXvYvA7bjPBEd8cYjEDV
         wf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663835; x=1779268635;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIg35o41z1LZVAKC3fAi3BASks1XM5AoHSYceWAirFk=;
        b=LpsAkCIS3cwp8XXbyr9jm/h7ag4OnxsEz2Uoh4sOGOMtxYyO/YNr6njKOZv+1CQYd2
         4p5x/gaIS+rJPkQ+S2CKsWtA3jZwustcFTTlVD0oC/TPJHqn9QS3BhdgyFTUEBYHx9PM
         x1FikRc2Bl869aLghZjeFnLUFy7fNPq8HSDu4FannN4JEEZDieBS3Tszlo2WSs69ujUU
         C+e7/p3zxIcybdvHAGRut2/RSNEagV62ExiGLlcF/GZLNm+mQt6xEuOE1ppUkI9q/y6B
         0jTFToa18GXgdzNiPpoeEjYvfrj1IIx58LIUCs/xdAblp05Ki7aeGtkC5a31vZsJFS83
         yy7g==
X-Forwarded-Encrypted: i=1; AFNElJ++sRlyXM6Vl2zuPEdg73PcPGYAgbn4LtyzhQreEck6Myk6OErzC/PJWHZSOS2dpNWvvIvTt7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJIYMdtJxdkEshaOt899nRBkoWDOgZqDTAZ/8OsDEATul+S9v
	w3EFKcF2zuVcbfLgps3Na5NJyTLCwaoW9sxfhIb+w+Di8ChFaPaTAtHfp6xR/GgOoKo=
X-Gm-Gg: Acq92OEPZDO450xbxOQp972Spzy6Sgnzw/EfQrjGpQe6f4sGzzDSFXtEy136I5OaG1W
	7+JvVWoM9E6/+b4PNWDagpEoQH6CJHgD32Z2JGln4aIo6oD94EZylbTv4XNYTPOhsC7H1vKvY6S
	qGovXnd5MHIST2CNOfw4YiH9261ez2KWMmXSyfxrbrULCT7cQ5WvPjDmDwRvUsyHGAGcUxKZygY
	zAotA7VB1056g1O1y6Jp+pU6Fs7whAJmN4u9ceRrdMduCVt+yyfFWuILMaeXY0GSzOZ5HGE2ZkS
	coHvpryCIRTLgRo+Y+ogzUlpwOE7xdXug76ISIsPiIN5vFDqrdqSO1fbf78/8/8YlIJgZGyeNYr
	qO5DcwcqE0vsm9uig1TXjLxNU8beCAYSanJDjm2DgcJO9Hbuk8scg48ee5ixIu75bRXGRMUuip/
	r1+PKY3dP0J4i81/SpbMZtExlc5Q==
X-Received: by 2002:a17:907:72c9:b0:bd2:3623:dab4 with SMTP id a640c23a62f3a-bd3c0edec93mr165052266b.28.1778663834927;
        Wed, 13 May 2026 02:17:14 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd60f726desm584093366b.25.2026.05.13.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:17:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Martin KaFai Lau
 <martin.lau@kernel.org>,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
In-Reply-To: <20260430173153.5cd1d348@kernel.org> (Jakub Kicinski's message of
	"Thu, 30 Apr 2026 17:31:53 -0700")
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
	<20260430173153.5cd1d348@kernel.org>
Date: Wed, 13 May 2026 11:17:12 +0200
Message-ID: <87jyt78y93.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 80510530C6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Action: no action

On Thu, Apr 30, 2026 at 05:31 PM -07, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 21:44:37 +0200 Jakub Sitnicki wrote:
>> skb metadata is meant for passing information between XDP and TC.
>> LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.
>
> netdev wasn't CCed on the sashiko reply but I think it now auto-marks
> the patches as Changes Requested :| The Sashiko comments didn't seem
> actionable to me. WDYT?

Apologies, I completely missed your message in the chaos of the
conference.

I actually wanted to double-check with you and Daniel - is consuming
metadata from TC egress supposed to be supported?

If not, then I agree - nothing left to do about the Sashiko feedback
[1].

[1] https://sashiko.dev/#/patchset/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com?part=1

