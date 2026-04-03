Return-Path: <netdev+bounces-275199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMqpFWEd0GnN3QYAu9opvQ
	(envelope-from <netdev+bounces-275199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:04:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A106139809C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70237301ECFF
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1104352C52;
	Fri,  3 Apr 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrc5aX31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B126ED45
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246437; cv=none; b=OfOBIPUz/7bn8XdQ5cv+cxPyDyWL9jaZ21L3ap206o80xevycA4UvkctJRWtUTHHvPkshRpkNWg0SapFEN50qTGPwoO1KPIqsaVuCn9tifEo3WcQf298BxB8bQTtZGq/NyfSoL8iNY0C5RlTA6QcsWNYi5fel9DkcPMkWGL1Eug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246437; c=relaxed/simple;
	bh=6lqpbRJSE6fbs3RdncRM2NND33z2HrSK30Q3BP3kd5w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TL3NEYU4hGSPDQLgAJ9Picb6vm//jXsRVvLaqavI00AnbMVGvdXHsMnLSgBUbnHcG/em+7cRAsmA+Y7AHOTxpJ36mBI6cQJTngDpysmTSzmJ/MiOKuy5P2/FyCWTBp0cFRnwWWKi3J/XNZ+r6s7ygGXCBQcdB2RCG1FcEwtDU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrc5aX31; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7982c3b7da9so19914297b3.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775246435; x=1775851235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/phNSL3pbA6geXDe0NXlWFIfTMgrXOMa4N+q4cR6Kk=;
        b=hrc5aX31xzSHDdxI1+161elQvSVTrAqLsWyicTnUTKSfysAeTYOJDNsteIKo3dXuwg
         onaM7u2hS31sdsGs0mlPG6eicUYyhIXAGA05ZO/etkbO0sOlynIcYW4cLHN6haaUZj9w
         aGtM2zzpgYuSZGvGQaR8FYtr4Ia4AT+ZmsIaSzEPv/D5rbyXSd23hLOtkbc5llL1BmCT
         giA8GlWcYk4EiVL5fFwGQ0+5zbgKc/GU2Iyw6DJDvY4GKBoTF50HT5ox69kA1Jm6rVjA
         GgqcUxKM948n8eysYxAYaNWQLfl0UK9VhE/yANOKo/Rvjgc3f+gHI7JKIjsvlSvXjdh8
         F1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775246435; x=1775851235;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/phNSL3pbA6geXDe0NXlWFIfTMgrXOMa4N+q4cR6Kk=;
        b=PoKpQLG3UGfPYlmA6THvCQDn9AWkVAgTq+xL/w9CmtBFFSafHJGgEafXXHMvAAJ4cU
         SdBqDOb8CwwZCV8ThC1yNfqTNlrwhxZTtTPgX0+lPndMvErYnrAexUqLEZPdCnjnX+Nn
         dOw+j8jPlYJFDBdnRWDWECvz35znBA5iVvai/MuIf35uu9pzEykSVFCEqWBaeWnnSxJX
         h8y8RBTmWRXzHyphKFhPc/CfTcnPjrQSlWDlLl5gFxjCDrkF1bra7SCu0o7SJ4EMWsq9
         yN83oP2ZQpeOgBb48wNp2QRF4bLQmR9AJCgCgA5MoITZkDxx1r0UE5iRSb5bXwWBHh3/
         Q2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHa1MfrS2qxe/0c8r5GWXZSqotMDD3yYDFs+NicmXBOVXUzsNN9T+qvXLDD+maZdSjZmr6YGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9HBPIyvPXvuIwfAz4El8HZOA0GljjrOsZhcDzwb40JvuR4lp
	tkd/qoIZpecZZsvltMbXnwfmlaRFqeKpu7YSLBGUbboCYt2GF02RqlJbGcUcaA==
X-Gm-Gg: AeBDieuTEuuLFSqxbTMpYhPZ9lVSXf3XoYCtnktMEWxuFRw6iCrMGfkZGvqDR1xRTTe
	WPoN7aGp6eBckpcC4KmkEQTiJ9AGZDMnx4xr31lqLXMb0KPjVvHDEPt37iQ172rhTxJqqVAxChv
	pdflmcmqyenRC+EriunNd0+zr3h6coFB8LenoU0pkwapKuXlmVozejedjolopMq/xrAXjV7b9/S
	KWGyaG+jhpetKwfGya6iI3f887TpsRej22TREKKw5YrjMDa6zQ9TYdlXkv8pwCJI7Jq84fOTS1F
	+tH4RufoCIHlr6nzs295Zi9P7IhIKbO35sRnzWhLH5Nr4yfBk3wF7cdNvMnJB77KGBmR79Jed2K
	J6BM4i+B0avyEuF8tc9EzoyCpTUyZxQkXjjFPDhOjDP/1BqytHvrwDX7K62PJ0oZBh7aGYYah82
	eL8CLMckCJT4n164q45W12EiCE9yel8nEkGS3RC8YldYWkNTFx3c9IjtDV9fTMw77U38Wx6nbs3
	wWm
X-Received: by 2002:a05:690c:e3e8:b0:79a:38a2:d8d4 with SMTP id 00721157ae682-7a4d5f5a38dmr44671317b3.49.1775246435457;
        Fri, 03 Apr 2026 13:00:35 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42fd37sm25622157b3.1.2026.04.03.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:00:34 -0700 (PDT)
Date: Fri, 03 Apr 2026 16:00:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1b2030e08937c@gmail.com>
In-Reply-To: <20260403175047.152646-1-willemdebruijn.kernel@gmail.com>
References: <20260403175047.152646-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275199-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A106139809C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In preparation for extending to pacing hardware offload, convert the
> so_txtime.sh test to a drv-net test that can be run against netdevsim
> and real hardware.
> 
> Also move so_txtime.c to lib so that it is easily accessible for the
> new drv-net test, similar to gro.c in commit 8888bf4fb980 ("selftests:
> net: move gro to lib for HW vs SW reuse").
> 
> Also update so_txtime.c to not exit on first failure, but run to
> completion and report exit code there. This helps with debugging
> unexpected results, especially when processing multiple packets,
> as in the "reverse_order" testcase.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Sashiko already has a few correct comments (below). Will fix in v2.

Also, indentation incorrectly uses 2 instead of 4 spaces.

> +def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_fail):
> +  bin_path = cfg.net_lib_dir / "so_txtime"
> +
> +  tstart = time.time_ns() + 100_000_000
> +
> +  cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
> +  cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
> +  cmd_rx = f"{cmd_base} {args_rx} -r"
> +  cmd_tx = f"{cmd_base} {args_tx}"
> +
> +  try:
> +    with bkg(cmd_rx, host=cfg.remote, exit_wait=True):
> +      cmd(cmd_tx)
> +  except:
> +    if not expect_fail:
> +      raise

Also test against a test succeeding when failure is expected. Will add
an else: clause.


> @@ -131,13 +135,15 @@ static void do_recv_one(int fdr, struct timed_send *ts)
>  	fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
>  			rbuf[0], (long long)tstop, (long long)texpect);
>  
> -	if (rbuf[0] != ts->data)
> -		error(1, 0, "payload mismatch. expected %c", ts->data);
> +	if (rbuf[0] != ts->data) {
> +		fprintf(stderr, "payload mismatch. expected %c", ts->data);

Add \n when converting from error to fprintf

> @@ -255,8 +261,10 @@ static void start_time_wait(void)
>  		return;
>  
>  	now = gettime_ns(CLOCK_REALTIME);
> -	if (cfg_start_time_ns < now)
> -		return;
> +	if (cfg_start_time_ns < now) {
> +		fprintf(stderr, "FAIL: start time already passed\n");
> +		errors++;
> +	}
>  
>  	err = usleep((cfg_start_time_ns - now) / 1000);

Do not call usleep when already late: uint64_t will have negative
overflow. Also, waiting makes no sense when late. Add return to the
error branch.

