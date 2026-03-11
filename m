Return-Path: <netdev+bounces-266614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEzREENKsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:56:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04B262A18
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D71D330A0DF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6B3D170E;
	Wed, 11 Mar 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3ybSBEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21E1F875A
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225935; cv=pass; b=rs3Aiu0TffJuht5/V5JGJBXvPzvy1rLfS6B4txq4ZHPBV64p4uYYJmXqp9DL8DNkyuLVRsohtF8nC07YG8xU9fWrT6OAzva4hktTv80om9MQXALFs26sFErh8xMgRryc8sSCH2uYYmbitXxImXDufAwPkLCa0bny0giHwCQsEc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225935; c=relaxed/simple;
	bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxYaHPejKFUxdDMmMugcBFfw7Dud3kEzU+lw5czTJ1HF64E6po3qTuFmxfCq+H2eKznJE3qTVDBKsxUQ88Y1OdA5vUbr40DZuAiD/5W2dGz+Gw2Z5lju9Hetq8cYHPIWPewrCb25fCqsdMuOS4ACksnF6jo838wjQaTSzkkKZSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3ybSBEq; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd73c4a827so477715185a.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773225933; cv=none;
        d=google.com; s=arc-20240605;
        b=JAJ708Y+cro+V4aAsyi4GUgzohLAXugE2KtJluocgaSKOQ125lry8H5qENDilznECx
         Y6RJxVgLwTO9Gjg4iIgu8SlYzUFiDYCwqYRH1weO9RdL8xIkwEw2KQtlZSUJO+nxnv+P
         jsYPhBoACyNQYBw18XKts1uqz1nTe7nPxyxeqEmRm8/jm9cLOr/4fgrvgx5U9fiJDBmx
         TNv5jmFRc+AXj/d415gUwbWdBOxBTcUQNHyNHjntzXr1ijLk7LmeEip0UDT7shRltR1x
         NYBSfIgXrvK7PVm6AHvmzzEZVQQN/jtitQ4hIPPHtP04DTndIdyd3by77PsCNAbJ3QI+
         OoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
        fh=+HA1RDfu0QVuWA4/EXkKlzUEQV7qliXl/87nNiLsSDg=;
        b=PdVDRpGIOl8jCO9iXmUsLYFTw++QULhl8DA/9yrG80vyquyn6+Vmb/M8x5CAPYp+jG
         RqGN0LVp8ncDlSDizzW/z3U/GkzZ0AVDHOZ/+pCashTnXqEjxjN7AGjn2eHE1XkZaqc1
         5YhstLPypss05OskPD3gD7zjC9MiEplDcsY6oYvsqjJPPvc4iKSSymmFN9m05hMcRzZ5
         J6OfCMeSHiE3mT72J2QT2jMekdLuQsHiIvnsLp+5u25vLPZ1Us8K+Zphr0Dmm2MQnz9f
         8AAlYpLbXo/f8KZCY/KSYunZE0Rp+6FFjT1Ze142qzADoaVMgbFdmPcHxCfyNjH0D52e
         NZdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773225933; x=1773830733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
        b=A3ybSBEqCvOF9TOgD/cukZvxNM34FzsWMu2Zht3rmo5m5z8Cl4O8mt4doNlS4bPQsg
         OQ9Smoc3eCcZAG/PxyGi7Xt6QEgPT/gKB5EOiRD9aVSoxOG8JyWjdOFA/h2G+dxThLRZ
         I7yp4VoE9QXVssfdDoz21hQHT8jBEgkVa/8NMCRFokHVn3N0HIGLTLO0WvWXxshGQFpm
         Lk4pYyeRWoJR8HfrwPjUYFojSfC42mmxg/I5+KqFBhwTK4ybKyd0kZHwpuVmmBZbfkLh
         LBC+UhLUQQRmkIbWwrnDlBDT+4IbAGh1wo1VBEK/skA+/I/Dxqks1cUbDt3Juam2skXr
         PukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225933; x=1773830733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7vsDk25zVBTfwb1axdr1KCfVVl/kd3eHhZd/r75+KnU=;
        b=nOaokNovvX42s7XAPJvkrcI3CJAH32pQJFi0u2oXPsrfh5pcIqiSp6QetQSLMlgK6S
         PdUJrH3q24iQMSbLdwCYRFCt7Y0HozcmAMFxayQgu20SmJ7KXqdD9MP7YtYI7eTui7f6
         C8UbI6Yfyfdg3SzK/POKnRt1rpMNjBHO+dhEQGJg6dhKaSKjLHg39dSvVxfLjapNqgrI
         Fnla5XGm1u4DBXvdQHs2COz+LiYAoK2+K7Ro6Yu2QE/1dl6y9CQhrFWMSLGEkvojCFm/
         mudSjnqdv1s+bwzemfH66KJOHP/2xeMclWtDQrZ4gq2gIR3xHznIg9bYz0RsWB4qB35J
         C8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjPVPGrdwneqHpwjxnISBkzVspyO0DF1lTl774a7a7W+hcaNZstZSwEnzOEoSa+vyZ/s5NicQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfFtFiH805RDs6fEUfUGPFPwzf56IQJNtjwcXeTsrOu1Ubtoo
	c7+uhi3XzacJriRO1+f3ZgFIyClzm5lsOEG2mh1bBEOeAx/j2KQWV1csZTleQcXk4V4gulXhhgw
	ol/k9WoV4tG4IQz1c17oUAk2Pc+fvJtkDqStGyVAv
X-Gm-Gg: ATEYQzy9N7rNSe1VG+tZSlXd0JzLq916e74ZreVCGzAZ1CqMy3P9ettw2aym1Etw5eF
	4FiNbEkRn/QBx4Si1//GgZf7Dd6+ocUlz9SWl/vKVDqoWImPV6TQ9ScERLmfP2jQB6TSNn1k/J7
	4e3WBqYDLMuUjvX3uOaquHj6cnqJv/7MwbnRWuf3oCMmoSZR+mSOt2iNgbaBn19Mb8gnw2sElx7
	8bf8lILAOpHbK706kmPUZf/8OQkvnxuyv08Qjimqb5kUmlrhLyxfv48Ka/ksogv6ljCpDqODt4f
	1amLk6LW
X-Received: by 2002:a05:620a:19a3:b0:8cd:8f18:d1d3 with SMTP id
 af79cd13be357-8cda1aa96fcmr238042885a.58.1773225932110; Wed, 11 Mar 2026
 03:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202603091409.866c520c-lkp@intel.com> <CANn89iKUdtWw4ptM8ZreRP0a2FuvQOJ5FgE3o4q-zTRTmt1Umg@mail.gmail.com>
 <abFE5PEtrkT5paKB@yuki.lan>
In-Reply-To: <abFE5PEtrkT5paKB@yuki.lan>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 11:45:21 +0100
X-Gm-Features: AaiRm53pzyyhStKrLmQaAlgunggh_gChR9xqV-J3aHPcZ3AKfR6HTggnSd94pyY
Message-ID: <CANn89iL8xwJxLMm+a-QqDUq_NeYSZBAMxvAAJ2_2X0tCd+J7kQ@mail.gmail.com>
Subject: Re: [LTP] [linux-next:master] [icmp] 64db5933c7: ltp.cve-2020-25705.fail
To: Cyril Hrubis <chrubis@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Kuniyuki Iwashima <kuniyu@google.com>, lkp@intel.com, 
	netdev@vger.kernel.org, oe-lkp@lists.linux.dev, 
	Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9F04B262A18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266614-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:33=E2=80=AFAM Cyril Hrubis <chrubis@suse.cz> wro=
te:
>
> Hi!
> > I do not want to know what this test is doing or expecting.
> >
> > If it expects sysctls to have a precise value, it should set them ?
>
> The test is a CVE reproducer that checks if ICMP message ratelimiting is
> sufficiently randomized so that we do not leak information about the
> system.
>
> See the test source code:
>
> https://github.com/linux-test-project/ltp/blob/master/testcases/cve/icmp_=
rate_limit01.c
>

This test needs to be tweaked/changed.

It has been written with wrong assumption.

(icmp_msgs_burst =3D=3D 50)

Thanks.

