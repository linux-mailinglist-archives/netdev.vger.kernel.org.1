Return-Path: <netdev+bounces-284091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE0OA3Uv+WnA6QIAu9opvQ
	(envelope-from <netdev+bounces-284091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:44:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBB14C4EF5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC04300D6A1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F03A7585;
	Mon,  4 May 2026 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOwKjypB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41337B3F2
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938290; cv=none; b=aTRtMkJObYBE9eWhu7Fn8QsEeT1QBad2otszsZfXCMp3WH92Am2BvgdVu2eRseUtBLKA9c3ZUCS8Ycei9tRx98Urxb4UZJVcwuscfXCxWFjk6WdW5VF3urB5GXWDaVNV+PpgjaichukcyRJhpdm2NHarcndT1FjIxpv2Z32ZUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938290; c=relaxed/simple;
	bh=4orhHtv+SSWKjMqyazr08tTgUZgdXkJ+m3yNcAIVKFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXkf2rd3anuKYWqnc9BQlUmAFa2894RAny/JL2KjAv0HuLrp2IIdpXxfPh35FRgJppiiXJzlvAuvG77bbN+KwFczNgKejKLx7jvEqMbj8QJ/OaiPSDU5uOa6kCIcepbSQ1R6LwLHEQOVaYjsglt4PL1pAs88QccpqaoRnwVYYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOwKjypB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F39AC2BCB8;
	Mon,  4 May 2026 23:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938289;
	bh=4orhHtv+SSWKjMqyazr08tTgUZgdXkJ+m3yNcAIVKFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOwKjypBh3PCmFIq8RwGKbOlUBuo6pffiXGyLPfTF5ZTXZaADvp/db+0SqATDf1Ma
	 Em5uBo00pQmJn9iYrvyZD49P2WuAcWdCojCE8uNib34E1PKc3jDghp1E5mzEdUl3aq
	 0F2OzHMoMJyp5xqZbvTnboDVGwWP871qLnEV5M40RNlMXVT8gX1ESkAI2WW36tzQZW
	 r6OpIvSTzLb0bM6YU7S8g66wV7l96DMO65b30PL+uILpdhZGLhoqIBMBWPqAD6jlrH
	 ep/Jsf+I02t4TjBu3OES9+d6vMxkQC1D6Bg/oGBQQuAhjMmWhUqGoVc1XN4HxovCvx
	 UlC62OKWgo/jQ==
Date: Mon, 4 May 2026 16:44:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, justin.iurman@uliege.be,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com, horms@kernel.org, Tom
 Herbert <tom@xdpnet.ai>
Subject: Re: [PATCH net-next v10 00/10] ipv6: Address ext hdr DoS
 vulnerabilities
Message-ID: <20260504164448.0ba4a2df@kernel.org>
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4FBB14C4EF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,uliege.be,gmail.com,redhat.com,kernel.org,xdpnet.ai];
	TAGGED_FROM(0.00)[bounces-284091-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eh_limits.sh:url]

On Mon,  4 May 2026 11:51:12 -0700 Tom Herbert wrote:
> --- Testing
> 
> Add selftest eh_limits.sh. Tested by running:
> 
> $ sudo ./eh_limits.sh
>     TEST: EH-limits - default sysctls                            [ OK ]
>     TEST: EH-limits - modified sysctls                           [ OK ]
> 
> Tests passed:   2
> Tests failed:   0


The python files need to be in TEST_FILES not TEST_PROGS
(AFAIU they are helpers not tests themselves).
They must pass ruff check and pylint --disable=R cleanly

The bash currently passes but prints a FAIL making our CI mark it as
FAIL:

# selftests: net: eh_limits.sh
# 2.50 [+2.50] WARNING: Could not retrieve the OS's nameserver !
# 4.54 [+2.04] WARNING: Could not retrieve the OS's nameserver !
# 6.29 [+1.74]     TEST: EH-limits - default sysctls                                   [ OK ]
# 6.54 [+0.25] WARNING: Could not retrieve the OS's nameserver !
# 7.90 [+1.36] FAIL: Expected to receive for Many EH OOO                  <<<< here <<<
# 8.00 [+0.10]     TEST: EH-limits - modified sysctls                                  [ OK ]
# 8.02 [+0.02] 
# 8.02 [+0.00] Tests passed:   2
# 8.02 [+0.00] Tests failed:   0

Definitely does not look like your results..
Note that we run the tests with

	make -C tools/testing/selftests run_tests TEST_PROGS="eh_limits.sh" TEST_GEN_PROGS=""

