Return-Path: <netdev+bounces-277038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBvSAmDA12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:06:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE63CC627
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B971A308243B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C83DA5D8;
	Thu,  9 Apr 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUnKyqsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751E30594F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746913; cv=none; b=LIZ4td6Oa1JMUohSbIgmM4DmsISD7ArQ3nTahfs7Rk6Ix4ewMi+A/DI48kKurBqH+ARaohXXWVeYiiBVX9nSyst1gJyB1pa+JzWdtgQ+U1h45VttmLxW6uu8DRpNff5wPjBOA/pL22evvesBkrwO1w7qderwzfEs20d9HugQAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746913; c=relaxed/simple;
	bh=IWlUdwbGw7EGWTQFN7x+U4W/ZfUKXBRbAQhQRti870o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VOm/h6F1zyRxro9/O1+wlaq6f2CKEZOlhZm/1tK11276iUe8ejnoB27EJ0HL4JIur90EbOOAcEycURaGNgWzI81Q09uT+LmiLtNsp4RDFtVemtknI2kt7hhgW7CMZHaPFK/EHDR3Bqr0SA6YS+eHRyDVPaGj548Et/ZUdvcAS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUnKyqsu; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64edf260b49so1570887d50.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746911; x=1776351711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiqD+3M79IGXS6cmCqJS+BZulAKTkU3fchjWUjlaLYU=;
        b=HUnKyqsuK0cu39zAA2kejp9bKAhk6NslxZr06JpOWIiR2CAQ+TCHmw9/85C9MRO4d0
         dgsKoktw3Y2AOEcVHwh3OLPQLaU47kNveHEK1F2hqu6twczYchF9Mb/ThVkkpZ00SacU
         w5w/ZXLOFnOuXI5Em3Vk9Jp6cv2/lyggBQ/N5a+7Hrgei5N7uJhZg7b3kyMKU1k3rTao
         9PfK3ZHTCIF7EfwF8irKdkRTJ4CXwHzjmut8slNeoAz7Kfe594ItAwtMa+Rq0LxRZspr
         YpJyE8wtFRLMwShGuaF4metojODnYU9BeU2hU1UXYt1PUCN3WhliEXlrnrIdztsGdx0Y
         J3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746911; x=1776351711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiqD+3M79IGXS6cmCqJS+BZulAKTkU3fchjWUjlaLYU=;
        b=ms07e+IZqNRG4uos8utQ8G+XbuoMcHujkK/pa9ShK2IxrzNZk672bsmlCvIrZ/Xsct
         B1AOY4KF0iIm6yIXV9J+76eqvYQfr0a+quHJapAXwJCstbfVsSj5OMh4P2jX+r5b3l0A
         2AfBSupV6qVFc3kM5dplq61vprHcF2FVG4h1GjrYL1I5d2QMh3peKGXkVbUQIfEUtmZ6
         IBtZAYkl8ozr6EzryITktUtU415+Eg5yGDz27jfOxWfNtlM2nZM6YCbR3kLKooCistIi
         EbVRf1XgyHNszhigVFzEdmK1vnGU4iEYhB8al8Ny6R7l1w1lS2KBdG5dUV4dA2Rtfrgc
         AUwQ==
X-Gm-Message-State: AOJu0YwPXWrks5SJXOU76IJoz2/TrNfPpwCnP4DWqiWq4aq5kRZ1G8Gg
	HYYGE0AdVMHqAIbKu/g/wUXXDjtjBxebik+UZa2+ssfvx1MKMPGhEGLpkRVDvA==
X-Gm-Gg: AeBDiev7HEoil5xrwjXMPyNMiCFSCBh472NpQs51viqlP7YCH3vIxz/oBz9MNUifW4r
	tB7Uek6lZUfMUzAeuWpV1Uzvzkz/r8UApRclLDv7dusXJyuVYu54U2PV2uWnHsY6ki86htnYyvu
	oXzxQSyIMfPuQp+zMIdataV5sWxhi0DyCRLqhoM38rYvik2/48KSzHX/c4uI3ZsCv28vsfab4dE
	SY4Y3DddQzXWwQ6I8VtlzTe4ZSrUG88bfXvSkMhegT3Pzvs5CAYvtK9IqSGCK7ttuNPqBiOg9Ha
	JuY8YIAPakhweLXAJe1dmBMqA16rM8Rg7MEsSsNHk81UAfTtHsxVMNkKPg+MLGv5kxOdKfZ/Xc5
	wprvNa8dpdu3vw07+9WQfzC/HHdWiHzYB4ip/94am+4bYsxm0/rMvi0BKDsIFhX2wVWStmyUr0x
	orDMqInB5Mw4OedNx+y/kPpMkNvTfr19ch8UQjRIUZ9YcfP5Ogkkr7EAhSPqHuLHkAcr2qxUyOd
	aRB
X-Received: by 2002:a05:690e:d4b:b0:650:88ff:d73d with SMTP id 956f58d0204a3-6518719f379mr3055528d50.16.1775746910753;
        Thu, 09 Apr 2026 08:01:50 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a824d46sm11100111d50.4.2026.04.09.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:01:50 -0700 (PDT)
Date: Thu, 09 Apr 2026 11:01:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1b750e4c127c7@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1e324d665bb85@gmail.com>
References: <20260406025020.1636895-1-willemdebruijn.kernel@gmail.com>
 <20260407191543.0593b5aa@kernel.org>
 <willemdebruijn.kernel.1e324d665bb85@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277038-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 78FE63CC627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Sun,  5 Apr 2026 22:49:22 -0400 Willem de Bruijn wrote:
> > > +@ksft_variants(_test_variants_mono())
> > > +def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
> > > +    """Run all variants of monotonic (fq) tests."""
> > > +    cmd(f"tc qdisc replace dev {cfg.ifname} root fq")
> > > +    test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, False)
> > > +
> > > +
> > > +def _test_variants_etf():
> > > +    for ipver in ["4", "6"]:
> > > +        for testcase in [
> > > +            ["no_delay", "a,-1", "a,-1", True],
> > > +            ["zero_delay", "a,0", "a,0", True],
> > > +            ["one_pkt", "a,10", "a,10", False],
> > > +            ["in_order", "a,10,b,20", "a,10,b,20", False],
> > > +            ["reverse_order", "a,20,b,10", "b,10,a,20", False],
> > > +        ]:
> > > +            name = f"_v{ipver}_{testcase[0]}"
> > 
> > nit: looking at the results in NIPA:
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv/results/593442/5-so-txtime-py/stdout
> > the leading _ seems unnecessary? 
> >
> > > +            yield KsftNamedVariant(
> > > +                name, ipver, testcase[1], testcase[2], testcase[3]
> > > +            )
> > > +
> > > +
> > > +@ksft_variants(_test_variants_etf())
> > > +def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
> > > +    """Run all variants of etf tests."""
> > > +    try:
> > > +        # ETF does not support change, so remove and re-add it instead.
> > > +        cmd_prefix = f"tc qdisc replace dev {cfg.ifname} root"
> > > +        cmd(f"{cmd_prefix} pfifo_fast")
> > > +        cmd(f"{cmd_prefix} etf clockid CLOCK_TAI delta 400000")
> > > +    except Exception as e:
> > > +        raise KsftSkipEx("tc does not support qdisc etf. skipping") from e
> > > +
> > > +    test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, expect_fail)
> > 
> > I _think_ we'll leave ETF installed on the device after the test?
> > That seems not super great. As we discussed before rebuilding the 
> > whole hierarchy will be tedious but we could at least replace with
> > mq on exit and let it put whatever the default qdisc is as its leaves?
> 
> Good point. We can not set mq on netkit. It fails netif_is_multiqueue
> in mq_init_common. I'll do the following.
> 
> @@ -81,6 +81,8 @@ def main() -> None:
>      """Boilerplate ksft main."""
>      with NetDrvEpEnv(__file__) as cfg:
>          ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
> +        if not cfg._ns:
> +            cmd(f"tc qdisc replace dev {cfg.ifname} root mq")
>      ksft_exit()

Actually, looking at a private field is not a good idea.
 
> Alternatively could record the root qdisc at the start of the test and
> restore that.

This should work:

    def main() -> None:
        """Boilerplate ksft main."""
        with NetDrvEpEnv(__file__) as cfg:
    +        # Record original root qdisc
    +        cmd_obj = cmd((f"tc -j qdisc show dev {cfg.ifname} root"))
    +        qdisc_root = json.loads(cmd_obj.stdout)[0].get("kind", None)
    +
    	ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
    +
    +        # Restore original root qdisc. If mq, populate with default_qdisc nodes
    +        if (qdisc_root):
    +            cmd(f"tc qdisc replace dev {cfg.ifname} root {qdisc_root}")
        ksft_exit()


Do we want to add a tc command similar to ip, bpftool, etc.

