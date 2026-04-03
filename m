Return-Path: <netdev+bounces-275293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IkyEJ5VT0Gmx6QYAu9opvQ
	(envelope-from <netdev+bounces-275293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B800D399255
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00F33301C3E8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175BA2D781E;
	Fri,  3 Apr 2026 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH+pQr7t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AB23E32B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775260459; cv=none; b=T2OG4CGriwWUd2nVXwEX9ESIHguE2UETIMsB4/zCU5zNzjy+4/v9tEE/RqmQz6TZ4oDV70bufgCKKT/Aa5YljrRlhs8L4/jhkfsXoSByrfVKE2qsUr5Cmsa6Hxfh7WjyGdTp/AZFFmsVgLnKp5qjGdjkStJyli/DW734lpH1/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775260459; c=relaxed/simple;
	bh=pyWxZEdkfmFZgrMo4dUBGARFX7VN27e3hI/o+Kd0ld8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lJU4RWOR9xF/f/66ASMzLLXZjbw04UC04k5FL0QXd87YoFRwJtC7e1aMz/zIm04B4knuHcHe5OlT/I32LaulFrWBFmSv7WQthlvfpyLi0DyxKH7fWXulK+fsqRHfOFsglXF4DN0SACNtEgxZyWLvqcMsrxEb3hyD5BRHdpUvwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH+pQr7t; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-797ab169454so37849367b3.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775260456; x=1775865256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa4jEknRG7dUV9ugDTPnYldxh0ZYJtGkHmGlpJkI5xE=;
        b=XH+pQr7tWnallDjjRY+LJcMo2kgvE77MNCwY7MdinbxV/0wwdap8mr/kEIuBjnRaSW
         HVlc2KQQISWPDEZnubRXyiiAWkdG1kk232nzlOcL4dBxGS3to7EljDTKGH2ucHs/xgXj
         liLZZpg+kg323sl8rhdl/1e7JnH/IkcxjDAvAgmiuxmlfVEjG5j2/1rnDkxXOH2Ayz/l
         I5pjmTvXR1RjXMetYnM1M0zFHFuxOmWqWm9OtNkNGSGnT2QmNefnBuaQyRPcwcMGw9+1
         HXAyAFgLBZGDrFtp/GPGPy7XU5+EUg0CYGpZiImSuFIQgUIlTGtrcFc5meVCxgpC3rPV
         ZLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775260456; x=1775865256;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qa4jEknRG7dUV9ugDTPnYldxh0ZYJtGkHmGlpJkI5xE=;
        b=MpdIe1GrL8ukjZG8srgnCh1ZoQ1s66SMgoqlnlXnRDBq/THAlLZ2uD5uICYdMGgDIe
         +k0Cdyg4Xmwn/L9JuIeVSM8MV/L0UtmoI0C7+pw3BNGEZGIRLnffYflf94FEp78M64ZI
         3XoXHK/uSdb+VozENRdQf2Fmdz+JAEfYW6KdyOuI/W+tbD/wEN2aQF35FUzZAiq8Y/CW
         Szax1bBGZcOvo51xYWQ/WQd6oe24nHtigg6KZottfmHh5cqeJDk2U8400ZHa+Fs/kGlc
         Hk0HJ1XeQ3eScKBLYoKIy1eUABghHX9PlM44zXG7K2YZelgHFLmyMPposP1VYg4F4aGN
         33GQ==
X-Gm-Message-State: AOJu0Yx4vMxNAfhpHhXwIBpsBn25/bjVtC2YV0uUNMnxxANC1Fpz9AA+
	xPJSfFsTvyvGT1X6OLy+PpaIZ1i4FPKRkpafGheWujT3tKcoD1jTaLzB
X-Gm-Gg: AeBDieueRp6fpkVq5d5fdtiyjwe/sDu90M87s7B0rkCFA/IuTU67r1FnvvA/zsVKqEw
	Xrpf0oE3FTBClbJtQl+7cHFKs+KlWz/mBYADKWOHUfExycMZPKBH/OFt9WrHrGiwcCGgLz07AWi
	IqfYErLNVwG0edSfK0IEzgyC3z2YvvVYBPo0F8MRjxE+AKcrSS/0qXpg8WdHEerXku4hKl6894I
	3kfSyVwJtNcUrfdUSlPph00apZfFeuYLNfe3HkiFDwps6NfmlZPkPJWMXKM9cap+SQb/7GGouqg
	0lEQwTUE9h9TwYdvSYRhUKOVD5ZRKL3EasPrcWvOj7GGIodVxYQQdtqTqJl1WBHbcELbUU4Surz
	WrVI4/Ioxuy/LtktmldjpTjQLw8OqDvdT+yyrzUqfN/VOOUU2GzLKSs5gkmjO8TQZa4/t4gdzKW
	r32RCEyrLDo0B4JFrHEO0IOVVBh6VMfCisG1KeejMf1kcxnsx/cGW4zVvuZ+2vriX+v7E1ZVIhh
	hb0
X-Received: by 2002:a05:690c:e653:b0:7a0:4146:6eda with SMTP id 00721157ae682-7a4d3dc9234mr33804517b3.20.1775260456480;
        Fri, 03 Apr 2026 16:54:16 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef3fa5sm26791437b3.42.2026.04.03.16.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:54:15 -0700 (PDT)
Date: Fri, 03 Apr 2026 19:54:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.3b5ea6b5c49cc@gmail.com>
In-Reply-To: <20260403132855.7616daee@kernel.org>
References: <20260403175047.152646-1-willemdebruijn.kernel@gmail.com>
 <20260403132855.7616daee@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: convert so_txtime to drv-net
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275293-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,so_txtime.sh:url]
X-Rspamd-Queue-Id: B800D399255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Fri,  3 Apr 2026 13:50:12 -0400 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > In preparation for extending to pacing hardware offload, convert the
> > so_txtime.sh test to a drv-net test that can be run against netdevsim
> > and real hardware.
> > 
> > Also move so_txtime.c to lib so that it is easily accessible for the
> > new drv-net test, similar to gro.c in commit 8888bf4fb980 ("selftests:
> > net: move gro to lib for HW vs SW reuse").
> > 
> > Also update so_txtime.c to not exit on first failure, but run to
> > completion and report exit code there. This helps with debugging
> > unexpected results, especially when processing multiple packets,
> > as in the "reverse_order" testcase.
> 
> > diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
> > index 77ccf83d87e0..a3301d4da540 100644
> > --- a/tools/testing/selftests/drivers/net/config
> > +++ b/tools/testing/selftests/drivers/net/config
> > @@ -3,6 +3,8 @@ CONFIG_DEBUG_INFO_BTF=y
> >  CONFIG_DEBUG_INFO_BTF_MODULES=n
> >  CONFIG_INET_PSP=y
> >  CONFIG_IPV6=y
> > +CONFIG_NET_SCH_ETF=m
> > +CONFIG_NET_SCH_FQ=m
> 
> I think our sort order puts _ after characters
> 
> >  CONFIG_NETCONSOLE=m
> >  CONFIG_NETCONSOLE_DYNAMIC=y
> >  CONFIG_NETCONSOLE_EXTENDED_LOG=y
> > diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> > new file mode 100755
> > index 000000000000..565cecf307dd
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> > @@ -0,0 +1,87 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +"""Regression tests for the SO_TXTIME interface.
> > +
> > +Test delivery time in FQ and ETF qdiscs.
> > +"""
> 
> > +import time
> > +
> > +from lib.py import ksft_exit, ksft_run
> > +from lib.py import KsftNamedVariant, KsftSkipEx, ksft_variants
> > +from lib.py import NetDrvEpEnv, bkg, cmd
> > +
> > +
> > +def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_fail):
> > +  bin_path = cfg.net_lib_dir / "so_txtime"
> > +
> > +  tstart = time.time_ns() + 100_000_000
> > +
> > +  cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
> > +  cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
> > +  cmd_rx = f"{cmd_base} {args_rx} -r"
> > +  cmd_tx = f"{cmd_base} {args_tx}"
> > +
> > +  try:
> > +    with bkg(cmd_rx, host=cfg.remote, exit_wait=True):
> > +      cmd(cmd_tx)
> > +  except:
> > +    if not expect_fail:
> > +      raise
> 
> ruff check says:
> tools/testing/selftests/drivers/net/so_txtime.py:29: [E722] Do not use bare `except`
> 
> Why not pass fail=(not expect_fail) to bkg ?

That's indeed a lot simpler.

Thanks for the feedback! Will include all these changes in v2.

