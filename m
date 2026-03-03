Return-Path: <netdev+bounces-263406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EFPJAJAp2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:09:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF371F6A0D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36ABB302295D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07A392C28;
	Tue,  3 Mar 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJkcv25a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD38397691
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568529; cv=none; b=WuTZi8MeRWrb7Y0seXYnSnaV3fxRYVhvqCysdOq8bqXfd55XMyYvoHw7FHF3Kgs1r1LjQSG81y1YAlMeVAkyuVg4OVJCwX+TWhfjHb4WAxE58Jbp7JoodFFpdtYDeX0pU92bOg1EkrWjA7PW+eFHOqRILjMDEeOBmwCdeElYQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568529; c=relaxed/simple;
	bh=ISEtte2YRGcmWkrcUHpDS6PMfMZOWkZs5vlInnwzUbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csHtuJ/ORPvT5KgwQ/8n2Vw0F92X05PQTwT9IvndGvjDgmLIQdRWeXtnNtmnd69oBNZhv+WBnkyQYS1qBIb/Pk1cYBaSZYykLOFmc777aK6MCy1M+oUrkbKSQ2gCMFmBlGAPqkkQU9wMUE4VwZLKnhgkSnPqzHsAr7DeWZV9LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJkcv25a; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12713e56abdso3755334c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772568528; x=1773173328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9yF/aUyo6FiFRr8w9SYSbT1Zd6hZOeTGHVjT13l1hoE=;
        b=HJkcv25afmCkUv3iLfkgKqnRrPxiIGQbc8eY35jXJy2JamiAwn6n+/2NrnoDWeeH+F
         Ip89KJrdxqwG/DdWvI8V+oGBpiPYQgGPHrcvJ4PZy7kVhgCUs83bPytcLGrLM9OWpT16
         BAutvlZgJ/+dH1cy6mMst6RE0mYgTyIZe/tSWqMgHN6xJ177tc0c2fD39iYPWN4kAPEm
         H0ZEpGSZI39jS1xfKxgKF7PTe6cKc1h0egdst2bOgB7VLoQ6MjFbNKX9x/hg7KuhPOVl
         qeOqm6/OtPMb0BO24N/AkfeJAClt91AgJjl5Rhi5zQDBsqApA++M+hql2kY9r9JvOPDE
         aNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568528; x=1773173328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yF/aUyo6FiFRr8w9SYSbT1Zd6hZOeTGHVjT13l1hoE=;
        b=YCUXn/ViMCXLEhriF06QDYSm6W44j2fhN46T6xS7l2dauD74JcGj/1mRO2df9IPlbE
         9jkHSHm/YsETlg2oJJxnQmQUsySpsPyjlzSa6lvb/lXphSlFJvDpmM1Mdslyl3POtWgC
         Kda6LcazvZaSV7VQWgYlymRfz9EzZIqXBFJD3ny/m/o5kQJ7eMz2ZRaxQQNsl9yHetXE
         5X/87+hrFAdg8MtiUr92Rbkj+MWzNw5B8qTm/J1PwxSAW/ak6bVSiubvUF1anokz/TrN
         ww6ImEnn4HSNCwe8DEwwIUqMNoizwgm5ydDDtyWPHm33ioxivRLKhuJUacBdLFo4lMS3
         9HpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBIJ92AiBJ7FHELDJz8PoB2zsCr7kZ/dEsVDcHfxxVmkfoBgXY/DfwYy4WRsKUgzTW29/Wwws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/Q1xePPjy2gAD26nyUNyS0YjOx/OowpWLG0ooApc80Mnu1Yn
	o3ziywbEtMtmIS+BntYWnOaSHVsO9Jode0LnaNvrG6bq/A9bJzWmHSgW
X-Gm-Gg: ATEYQzw/1PMsyOF6SxwtyG2BHHXnizcXiTgNHUeUR0C3K+13W8wlhRWy64Y7QOzZAF3
	YEICOopTH/n77Vom368UfP+GBK2pV0fbRV4h9D+U7fk1UnlMcX9K3gabjT3LbZDVeH3qwVtw7j9
	ny48vdktgnF4aoHHPeBvs49YCe19HVWSDPx3ZqcxOhpXJG+zFfGzi0/drdRYpMxd0TQ7HCup4gl
	65BddnlBucgGGJ3BKoqsG1uOuVER9XFWS3YeHYGH7r7rnxn/c4sOcScn/IHjnByhLTKeXUqQett
	OVgvV9TuwHUW3OUfgopUUEAqXdE4gKrTtCViSrhk5IFvHjsEvS5bTfz86Oy64OaxcdttSzlslRT
	9cADbdw8uyZV3l/UCI23Uyymo82SqUi8CzCpEQw0Amyhjh3RUIryMdXFyfI0W+NKnI3cH+bfjq/
	CLWUZY5yYdVfHhFh9R9mVaS6yd20biQ04tjfB74ZU7OzbeOqIaA19UTYI9BnJXbR1wPttmUt9Yv
	NGrKJeE
X-Received: by 2002:a05:7022:7a3:b0:127:9432:485f with SMTP id a92af1059eb24-128b0ce47b5mr1159115c88.5.1772568527731;
        Tue, 03 Mar 2026 12:08:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32633sm20160083c88.9.2026.03.03.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:08:47 -0800 (PST)
Message-ID: <24dceff5bf15b6c3e204c69617ac249de497b034.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add trampolines single
 and multi-level pointer params test coverage
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, 	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
Date: Tue, 03 Mar 2026 12:08:44 -0800
In-Reply-To: <20260303095427.38981-3-slava.imameev@crowdstrike.com>
References: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
	 <20260303095427.38981-3-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3AF371F6A0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263406-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 20:54 +1100, Slava Imameev wrote:
> Single and multi-level pointer params and return value test coverage
> for BPF trampolines:
> - fentry/fexit programs covering struct and void double/triple
>   pointer parameters and return values
> - verifier context tests covering pointers as parameters, these
>   tests cover single and double pointers to int, enum 32 and 64,
>   void, function, and double pointers to struct, triple pointers
>   for void
> - verifier context tests covering single and double pointers to
>   float, to check proper error is returned as pointers to float
>   are not supported
> - verifier context tests covering pointers as return values
> - verifier context tests for lsm to check trusted parameters
>   handling
> - verifier context tests covering out-of-bound access after cast
> - verifier BPF helper tests to validate no change in verifier
>   behavior
>=20
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---

Again, I probably miss a point, but with current implementation it
seems sufficient in verifier_ctx_ptr_param() to add one or two
tests accessing void** or similar and checking verification log
to validate that parameter has expected type scalar().
Why so many tests are necessary?

[...]

