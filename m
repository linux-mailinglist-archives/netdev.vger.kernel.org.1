Return-Path: <netdev+bounces-260931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yACVLov0nmmcYAQAu9opvQ
	(envelope-from <netdev+bounces-260931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:09:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8C197C9A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72EFB307266E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274F3B8BC2;
	Wed, 25 Feb 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKbItb+S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0013AE714
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024812; cv=none; b=ByN4t9ChM44GKgkGMre0xeucCR/0MljyYjVaPomGhmFKNAJwXwE7eoMH+UIbUj0OvtE1vPyxzQZST8AnItQmquyvsWYM/d5HL3xGphdfFgbJ6YvLHcPbMT9OVsEtVO3DYKbM8V2zbujA2OI4AU6p0tNzN/asV2CMvyXlJVItYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024812; c=relaxed/simple;
	bh=P1KUZVcv71vqEO+U/iRcLVykTw0aayw2sEqdbMiSuHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ob8PE1KmIrhjp5mWJBRrTXCAxW3Ja6or/D9ypXnnkwxYk4VpaEZPBKyNwKlEn3UQaeeFUrZwMrJfZe4y10j8J7ULQ2Zsqeg9oOjaW+RdL250dQ2eI4y5JH/bhvGZ4QOvFCAZZLaQgpHf5ZY2ElLKNsXDG79mzdMyuGds9KywfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKbItb+S; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43991543a3dso340694f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772024809; x=1772629609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhfcOamQNKKUszfBefT5UFzLpGObxUPREg/uXcwiU6s=;
        b=wKbItb+SASsSk2PqCVZueNG3n6FSIKjkVtqW4XIz9uy8tx4VWLjnd/X5zv1TmNc1YI
         LhKQCIgrrELkbbljqGeKMyshEI5UTCHmS8tMopW+t8gjL4g1Bl6yZ+ufem3fJmIJMh8i
         lsUbsGz3bKNodEMadIskEqTsMvDxgRM8KsXZk5HapVMj5TCuTuMCJTOzyHQAvlltcHth
         G5QvyV9iexDYS11f8vWX/YsHUXa046I0FVA/tgoG/VNsGJtoR6I9fGPXhx1dKJSLk0aC
         05FD4vqhIEwncyuBI9GpDsWL8cGWClxBpiXtE9IhNxFXAoiwcuPR82EI+dSLUFa9m/iZ
         Qo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024809; x=1772629609;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhfcOamQNKKUszfBefT5UFzLpGObxUPREg/uXcwiU6s=;
        b=JwyLf5TXX+SlWjhE9+fkkmgto+mkDYqWCEUoMwWP9whdnpr3g61TXg0Og8YMMoehUY
         CR9Lbp1BM4Z4OpDzkEZ1KUaVNM9J2sQj2hi9P8jrKd4fNcMWy+pOrCdLCe00DrfWMQ9r
         Uge8L+rEK9PzZKqJn4Rk9BE6K8Pw63WCNXmypBuGE1oaFsBiY7OKxjtvLkAQYTAzmlzh
         vgE/cr12hsfPrQWL+TP4ofjfCn4pj0eey/x8XNu8TtDgoSztB3RYDvceE6C2jpo8ewTb
         MuCaaoYnn/bl5r5LD3wEEINMWf/oy9hacCyI3hUa2HoWE3yup4ovxBhrZOs2exjuHXH+
         GLMw==
X-Forwarded-Encrypted: i=1; AJvYcCUJDfPY5AIvgP8EIqQnX3+FCMP42fMtNnLi9xo5BOFJw5aCM/AtcW43QywU3a/1VLwvM+KejE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxweXmv/fv1DzMbegt7KrWFGlHGIajffYv/N1qFI21BmkcmTC5R
	ek9haxjfBKfRUiSZF+vcgLJeSUAek550OsuIhZ/8aWcRpXTlhY1KhgwlML6Uwt40kih0dvzfgwk
	me4PB/9DQNDL1iA==
X-Received: from wro14.prod.google.com ([2002:a05:6000:41ce:b0:436:d0e9:837c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f86:0:b0:431:808:2d58 with SMTP id ffacd0b85a97d-43994304901mr728417f8f.51.1772024808739;
 Wed, 25 Feb 2026 05:06:48 -0800 (PST)
Date: Wed, 25 Feb 2026 13:06:47 +0000
In-Reply-To: <20260225010833.11301-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225010833.11301-1-liuhangbin@gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DGO2DAIFY07Y.367VMZA7XGT4U@google.com>
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
From: Brendan Jackman <jackmanb@google.com>
To: Hangbin Liu <liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Brendan Jackman <jackmanb@google.com>, <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260931-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18E8C197C9A
X-Rspamd-Action: no action

On Wed Feb 25, 2026 at 1:08 AM UTC, Hangbin Liu wrote:
> Instead of manually writing ktap messages, we should use the formal
> ktap helpers in runner.sh. Brendan did some work in d9e6269e3303
> ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> run_kselftest.sh exit with the correct return value. However, the output
> does not include the total results, such as how many tests passed or fail=
ed.
>
> Let=E2=80=99s convert all manually printed messages in runner.sh to use t=
he
> formal ktap helpers. Here are what I changed:
>
>   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselft=
est.sh
>      is the only caller of run_many().
>   2. In run_kselftest.sh, call run_many() in main process to count the
>      pass/fail numbers.
>   3. In run_kselftest.sh, do not generate kselftest_failures_file. Just
>      use ktap_print_totals to report the result.
>   4. In runner.sh run_one(), get the return value and use ktap helpers fo=
r
>      all pass/fail reporting. This allows counting pass/fail numbers in t=
he
>      main process.
>   5. In runner.sh run_in_netns(), also return the correct rc, so we can
>      count results during wait.
>
> After the change, the printed result looks like:
>
>   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=3D1
>   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
>
>   ]# echo $?
>   1
>
> Tested-by: Brendan Jackman <jackmanb@google.com>

Thanks,

Reviewed-by: Brendan Jackman <jackmanb@google.com>

