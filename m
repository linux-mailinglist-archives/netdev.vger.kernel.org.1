Return-Path: <netdev+bounces-276828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNsPFpkY12lXKwgAu9opvQ
	(envelope-from <netdev+bounces-276828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC13C5F2D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67857300A10E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CEC2E2DFB;
	Thu,  9 Apr 2026 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3+hj/QA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F221B4223
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704214; cv=none; b=ap5FG5P5huqxKyoCBWTjVrmEVKMyPp9PDsy6aRfkuJsg6NyF1uXSQ9H+bmqWsvhi9qHHlNVg8yVnt6CR60P1P70PVLT+EvvE08bYukxtEPD3SmHmT+d3tt1dMDpZyTt8+69FAp7Y/Rg2PZL759On6mvXAuO/SY++AVNoSNexzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704214; c=relaxed/simple;
	bh=lluB8gJzk4ko4OxTMGzvmyZtTgk3EHs/aEo/yWd3GsQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GywFx1DOwtWRDDQC5ID1ymuv5ggvWyJSBE8FUUl6r6P2fkBDRk+MJsB845ofAzJ2Xd3TZXIc+UflaTrRe3U8iuEwwkhlV0OMv8L+Z54wjSoxk93x/z1y7HKucturEo0x99V3wfCISlGBwKVvDoSnYBzPTNjToSvUsc6X0aJ/7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3+hj/QA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986e0553bdso4016857b3.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775704212; x=1776309012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RtTNalEW/X6OQ7UenC5qHTpfnqx3k6dKV4EitESgxI=;
        b=m3+hj/QAOkzBunXorn5Ic/8E1YBSb/1LTyAjb0dQavlHN2zS72/+lNjNQlvjtVgOmB
         +kXZH4OiYPbi2wT+CB1Y6MyrhgJYLrYrlLWg5MLZAiu++ssBmhGIj7VHFCgdxORwnNO/
         Z4SLvTdfhx0DDFfA039MyE2tDnxjDOf4RzYjRKgpyD9TDvPQVrwCNQEgFLdS6fTmuKHk
         hjRe5tRjuKw2+wfHCIk37rDyhtoR7VflGAlfAP+/8BppG9qzb7oQPGNMPK4Ga34T4dmZ
         9jwCAETMdMOmvGkQh7jMmIrkkuvasDAno63+wAS8KBRwtlmvox/iAimFUJAMzayWW0Jt
         +2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775704212; x=1776309012;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RtTNalEW/X6OQ7UenC5qHTpfnqx3k6dKV4EitESgxI=;
        b=ad5PMKZXCkeCmwVlgjAD1bGgiqMXeoqMfT8yUgD5phO8ukD0Ey0esOgvccKS2ztxto
         edA+Oa6uoKKx45Di/ACGBLEHys+21NchJD4VIzht5XewXsfNCLUQmhpjnuzC4pO3PDbG
         uFiIJMm53BYxlIg7dYcLR259GtMnG/jdlrNfoOjupXsoCKPTTXk2G76ScfkbfyRpcGRW
         30BLjvr+B1fpkX60YbLuREnbw/Cv0KkPpLD+4kzyXm1gbCmNn6q7kNqmMGeeMSISE8fP
         VDmhduiHK9BV5F9cs6Zes+/4/j0+V7mJqFzjLA1H6fRUkYRcVDgaFCtmITqxnIWiEDnR
         ADuQ==
X-Gm-Message-State: AOJu0Yxeh6Zswz5C2BtdplgZZvzjpG82HIdjBXcVMWiFKPjHL8kPPd6K
	6hPRAdmonZ1V5wEIdYbEcQeU0l8syx2v2emgvXquInZrav5glkEnkxeG
X-Gm-Gg: AeBDievtf3miVf8baIzoDi/CLl9uSNcIOGHxvT6IHZsmXhEbR8IDDCivkuTq2nEvS+x
	9pl2v3Q1CHbUQmNlPHx5G9NF/jKGL9BBVsfMjfmVH4sQxwHTS3hJdMT8NpwmkSrHMy+EDy3+/c0
	fZqxkx9L/Epyts9x3oy1Dve5SAgOSzKYKoFBWrnuYgy8o6S1Cab3k4sQtQQDwcjt8LB40f7/E9w
	K6KhphoLqOLF749CLXZYPgT+1Q9/LMVOYqomfNxrO1IXxQ6xcrFXY54JatjKdAs+C7lNCFPPm8P
	FGJ535X+hjZqGHQwUVA64iipzgLWLyct33JfjSyoZ5+hZOoxtAynp2z7Oza5cSjFsn0iSNbu1+a
	IQP2FPCm5sEOUHuBcRPSUZFJXxF4vkoGZA5KaygGJito4JSrLY9iw49/ZRQQ+mJ/nTW81VnBSvo
	7/FlHxU6CxbIwaWUiTf9vMZwU/U1FZbjkbJbtRex0olG0eASRQlvBii/SEZCQgkkS7nSq5jMkoQ
	LC6
X-Received: by 2002:a05:690c:c36d:b0:79f:d961:47bf with SMTP id 00721157ae682-7a4d2ff25d5mr186559217b3.8.1775704212017;
        Wed, 08 Apr 2026 20:10:12 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712f8c8dsm94163427b3.46.2026.04.08.20.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 20:10:11 -0700 (PDT)
Date: Wed, 08 Apr 2026 23:10:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1e324d665bb85@gmail.com>
In-Reply-To: <20260407191543.0593b5aa@kernel.org>
References: <20260406025020.1636895-1-willemdebruijn.kernel@gmail.com>
 <20260407191543.0593b5aa@kernel.org>
Subject: Re: [PATCH net-next v3] selftests/net: convert so_txtime to drv-net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276828-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: C3FC13C5F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Sun,  5 Apr 2026 22:49:22 -0400 Willem de Bruijn wrote:
> > +@ksft_variants(_test_variants_mono())
> > +def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
> > +    """Run all variants of monotonic (fq) tests."""
> > +    cmd(f"tc qdisc replace dev {cfg.ifname} root fq")
> > +    test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, False)
> > +
> > +
> > +def _test_variants_etf():
> > +    for ipver in ["4", "6"]:
> > +        for testcase in [
> > +            ["no_delay", "a,-1", "a,-1", True],
> > +            ["zero_delay", "a,0", "a,0", True],
> > +            ["one_pkt", "a,10", "a,10", False],
> > +            ["in_order", "a,10,b,20", "a,10,b,20", False],
> > +            ["reverse_order", "a,20,b,10", "b,10,a,20", False],
> > +        ]:
> > +            name = f"_v{ipver}_{testcase[0]}"
> 
> nit: looking at the results in NIPA:
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv/results/593442/5-so-txtime-py/stdout
> the leading _ seems unnecessary? 
>
> > +            yield KsftNamedVariant(
> > +                name, ipver, testcase[1], testcase[2], testcase[3]
> > +            )
> > +
> > +
> > +@ksft_variants(_test_variants_etf())
> > +def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
> > +    """Run all variants of etf tests."""
> > +    try:
> > +        # ETF does not support change, so remove and re-add it instead.
> > +        cmd_prefix = f"tc qdisc replace dev {cfg.ifname} root"
> > +        cmd(f"{cmd_prefix} pfifo_fast")
> > +        cmd(f"{cmd_prefix} etf clockid CLOCK_TAI delta 400000")
> > +    except Exception as e:
> > +        raise KsftSkipEx("tc does not support qdisc etf. skipping") from e
> > +
> > +    test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, expect_fail)
> 
> I _think_ we'll leave ETF installed on the device after the test?
> That seems not super great. As we discussed before rebuilding the 
> whole hierarchy will be tedious but we could at least replace with
> mq on exit and let it put whatever the default qdisc is as its leaves?

Good point. We can not set mq on netkit. It fails netif_is_multiqueue
in mq_init_common. I'll do the following.

@@ -81,6 +81,8 @@ def main() -> None:
     """Boilerplate ksft main."""
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
+        if not cfg._ns:
+            cmd(f"tc qdisc replace dev {cfg.ifname} root mq")
     ksft_exit()

Alternatively could record the root qdisc at the start of the test and
restore that.


