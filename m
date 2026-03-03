Return-Path: <netdev+bounces-263384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DpvJ2o2p2lwfwAAu9opvQ
	(envelope-from <netdev+bounces-263384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:28:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167901F5F9F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050113014505
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392BB350297;
	Tue,  3 Mar 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEpNsWBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC42D23A6
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566120; cv=pass; b=ryLExmFgLMUpg4Rs5J0wzpcvTSKHPfGwU+M0NUgo7naG32kh53eYSprvne4icCnJyNNE1D9y7e+Qxre0Odpe4DStdkj4kG9ODB4ngUuOQAdrfhshlyzSIlmLl6W5Qnq8MzBOey8+Q4djlzZ+JgzxQr6vu/55zUJ50bOYpEOZef4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566120; c=relaxed/simple;
	bh=yT2oMnmlWOJ5xTYWdefSoQBgG51a+hOYNlIudObEkVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu2YH0/1ZVS3hOYIwnuAD4lbFW8qqU6RRs7AD/EHRQBi05uhPlWtwNYWMF+Och9o19EgsyEsETJLMNkuCVljy2ZytBeN3pjVzLI0gCUBxAMQgfgBxRKxYiTGQpEnBie4sIqgG/Zgdyaq5bX2qU29TdBBRLman4xNShUjLszc1d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEpNsWBL; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732165d1eso6551660c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:28:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772566118; cv=none;
        d=google.com; s=arc-20240605;
        b=KoKKWDlt7K5WgWsa6n8PEbOwcUHTZo5H+PHiv23Ph0pedc6uO1DnOGZWygo+feAVdJ
         vKdaqy5IO4+mlPCdyPJ060sL99VtB/G4W7kYGPuqQpvUdEElRdJhjYJBKIoVFh3cMR3c
         IX3YxiX33GSxf7tNqWnLE/MRMlPz5cgWjucrVcm1vLPzzNIXbn7eE9zw4kYd+lCSdmyq
         bQt4Vuo/4ApK/V8v7j1lM/+ksNCFieqyFcuE9DM1RjMMxU9Hub7gbKhzo3RgtpALSf3Y
         zJjIBvMMFaRNChXobti2pJTMb/j66g/bsPIPqqFA5MzRGrmgQit3yDpqnUqy1bO9BBAM
         GCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yT2oMnmlWOJ5xTYWdefSoQBgG51a+hOYNlIudObEkVo=;
        fh=Ja8Q1/iJXpt4Kk3aQoQYT8Il3+olnfzuAq7+LgpY39k=;
        b=OdeNwqITRsIIky8xyhSOqTL3MzGxO4kYruoL/THdDm2rVDL2hhH34yx9wpTaVB+wyb
         m/85ID3fmnQwNq/Eo7ageOoTy2DL+Y8hWV4ydtuNaZ0dSrpLkCVw56SXoN+XjlD4n1pf
         AI/ME4Q0XCU6enHol+NVTn2dbaEsEXwWM832+52Atth/C+fD+Opd0vFoAGgDW2tHZb4o
         jr1wiJjxqDTV2tiXRiQZSkDD+GHNbm9W3dth5O/pbzmUb00fipmOmYxtsItoTxC8rV04
         Gl3XuzRblfLNISm1dUltfXYEbERs1aPjIUxhmJQToM83d43EW5UQg+Pb0bONbPbBrzjN
         Oa7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772566118; x=1773170918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT2oMnmlWOJ5xTYWdefSoQBgG51a+hOYNlIudObEkVo=;
        b=TEpNsWBLQmZ2BP6Qyz8Q6CxmBDEPGnwsbkzX+iWBz8J4fJ10TW3+Y96He/NGs9fKg6
         gGJUIvSZxRRrw1+cqgQQevJ9EV3XjNep3ZTJRVig5NzZEqfEIEBcKb1XZ62sxP6LJJ4F
         hdAq7gX4Uj2otz8l18akskVlmcXmKH2JowbkBT3lDdg5Rq45ivEcBtcf2UhCiya0vJV2
         +2ml8tNMmDie8IKAmTtn5zKJNPTTlTodtMb1N4IqG3YH/ECnSPgzC6rIkkT7j3o+5BKz
         dR9TBlvVthddKHRZVjA5scoXMKp29I/FhQqGVFuxxjxVqb2iLV/wcBGo7zFGUtRaR3rR
         803w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566118; x=1773170918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yT2oMnmlWOJ5xTYWdefSoQBgG51a+hOYNlIudObEkVo=;
        b=Jf/3MLsC22tV+RocJZuIyiOwj9XUve1/+ROfwBHk9xK6Uxotg1mKyAWWs6OQs40iRI
         1lW4IggoecbeIp7v8sdD/ne/MaBsi5YW0nF11BGXzxJ5o8Y3fkmuq7S5CrWD8diwfAx5
         BLDyCE8JcTOUjFFAgsyBGd+M+TCjJYMPkhRWHrT63hjJAJawdMrym5PnupJJnAUdaXX8
         LAptAc8c3l+W2D6ef05KjDw6ainon7FVjOi9snRXXZOgBYktSGrGWxIP+vTfrLRHdBgx
         mj8Hv472Zfp9XkUq6OhQlPIlTH4lpSTMxeT/BC+siRwlzd7rhUY+416nn4NNc+17gpO+
         t/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Od05kzN2NpVWncNXJSYI1Xvu8ZuC6VGCP7DqnLgYjSuXs0D0JIw2Pdwgf6pvFT4xRtWlP38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJnLcoeKerHwlSM28Oy6EY+Xq2/9bxLcLk3hJG/01KgLsw30f
	yGu6sXGb3bj1BCxJRY81a/+3A+6nh6MMVoswPEknW+CJ2ci00mf5rDnp7v73l1822K1HNzp89hW
	ILFqyCng7Wk6M/xolupLpNXC1orwtd2BDCM5ig5Qj
X-Gm-Gg: ATEYQzxkGWb7PrnUw3Eqr87bm4XWo9KEa2YiVwoNCGv1+lOIlmkpJMjE12ARP+J9GES
	wBbr2C5lQZfHybBalo8hyuytwy89L3vKSSbLTozZXGTuRU9aK7QUKCQUCizasQLtG/uLmE/QMBW
	1TghZydl73vPEO7oiZ0p77Lw2WcAIB/ZnGECGwxuHcXCCT5AM4iWvxcqklRxfs1a/9Ui4JLMIRP
	stUvlc/bl8Nilyn6DabsozrBIJKxCIK7qOlwFRpoUFZ2AXd+DVSKchHWCVucxpS+Pf8vN1dCCrG
	Vxv+cPOB01GKQhIJAbkt44sVMaS2MgPnNgJ8eHAW6uwp6HknWZO849tg0KTYpf6fvLOX8Q==
X-Received: by 2002:a05:7022:4591:b0:123:2d9d:a90d with SMTP id
 a92af1059eb24-1278fc21264mr5498886c88.17.1772566117550; Tue, 03 Mar 2026
 11:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-4-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:28:26 -0800
X-Gm-Features: AaiRm51OpyhqToCsVHo_j_zBexs7LaklUrpKfriCBpVbr43Ml-FKm0GCK1wDsrw
Message-ID: <CAAVpQUDANYSoqwnrUnb3n7q3eM0FwUS8VDUScvwbsvtpUk2D=g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/7] net-sysfs: add rps_sock_flow_table_mask() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 167901F5F9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263384-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In preparation of the following patch, abstract access
> to the @mask field in 'struct rps_sock_flow_table'.
>
> Also cleanup rps_sock_flow_sysctl() a bit :
>
> - Rename orig_sock_table to o_sock_table.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

