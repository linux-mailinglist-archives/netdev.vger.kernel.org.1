Return-Path: <netdev+bounces-259195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vEL/BY8alWkdLQIAu9opvQ
	(envelope-from <netdev+bounces-259195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:49:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF815293C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 822443018769
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660912D9ECA;
	Wed, 18 Feb 2026 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHOMC/8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9C19D8A8
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379338; cv=none; b=MroEOxhw4DAv0RSsPaRPz6QJEUABB7qdAPcrgVhyPw92rNJniivD2OFCDnTFv0pO8yO3m9CzVooypggzw79kf6/vIOM3nKIk3IC6Y8j613JMpI/72ee1h9rfhzLMeGz+hKWh79JNzF76qzz65xeDJMPgiX6e2FbV+2rsBt5ExOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379338; c=relaxed/simple;
	bh=1YkQ1xknk3HXPo2U6IC2skc9hdqA4WxM02nBDF9vNoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZM6/0LAiar+9Wy99doj8XxSyEM/3wDnTaaX8swxlmPfg9Jv2fjlnMe1WRe7webgdtCEs8YT/tJGE99a/12KWGsP+ZZ9ad9++u3cL9lFeqi5vDLoSwpeiZuOos9uyFPrSUvgOy9GYwOn/tidp14shfGYJkpAZY21+YUwrzXhedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHOMC/8/; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a635476fso5387021c88.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771379336; x=1771984136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xs2eo3fi6sWBx7GfJK+0RFL6Et71ppgQ7nK94o1qrG8=;
        b=NHOMC/8/pmqYNAZceAkWeY9z48c0FFTwTGdqIz6lh/+Akad1+huCUi5RYrsirV3EqC
         ASoxBe6JD0sMHJhqt6OT3vXkPd9wsnTKJ2r+Bp2FEo+wvk+TXCZQWReMgA2j+6pPmsmr
         Ik5P/HvegSPUk1YPtt5i7/gENOMvgc7XKlprDUe85RFe/+LuYH9yovcvCDEfS3o4Napf
         JkcpTyfQJUap1SB/MaTflukQaikuHRFj7OSV7f1bq336KRpCv/33US8Rm+bHom4aDpji
         upSAxGZs+49bMmiCGCouONQoVjVa2QgYSYSCt1DturZ2KAin6I7gHqZPf16wsHbLZGgu
         TCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771379336; x=1771984136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs2eo3fi6sWBx7GfJK+0RFL6Et71ppgQ7nK94o1qrG8=;
        b=uAFJlj7ci78bS/rR/LoBY+W2WgG5arY1s6b1Y0Do6BUckMo8FRBUiwScYnu+cLzibF
         R2IyuCV7VWX+fDlowAszd7oSI1ybR5VUTonp6c9axSUXNmV5Nf6jwfpkUvWswqWUtVra
         Qj9FYcxhvkeeLqhopGzXCMEGWwDNw2lyjHKGyWVC/R6AdJ2HKhdehNxsW0rhCMBSilCt
         aunLmhLaq7ybI69uTrxa4FxBqM7nnxqXW3qWes1kzzYonxB3nJCRTsGIK75nBgk6taqn
         SY8uzB6AVpQ6AJn+VoVdeHfngIdrNU/pIAi9qMtB4EF2VJcK5bAmLkC0PPXr0/e8QMJI
         9IEA==
X-Forwarded-Encrypted: i=1; AJvYcCUzlModynINlZPvDOo8q22pWKIWwMvMrKNbmK/BAG17zxRVhEt3nmtMGB12QD7UTXni1fjNyaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTBLi8OuMos4ZvPh3lqH7CWhP3vf6kL1hWX+rMFg00/2EvHI9
	IHzUimlcW/vr+90TlRzMrVkNoKqMujkd/RmVPbAYG6kQ5Ha5tw20ZBw0
X-Gm-Gg: AZuq6aLZSV3mJzz5MvsVydJyHLuo7y+6M9mFbA+Nf4kZDPumaMKzTQkmE+CKdWquw9e
	3dl8t4dMvTb8uOOEmO863VSewn8J7YeS6QiOIh2mWDacAHLitD50kC8v+ZgqwQjqd6XJcHmbMY/
	ANkt2ANCs0dVhGgz9R+zyQLlhZTBwBEyo+CWBYFrwN0yWfy0w7ZPWZYuO/bl1fCbTtP8GuDERxt
	u4lARo6L0/rfhIJy5R0fCKAZc1eoA9RnX4FjAR848rTZOcVoFrL7AnU86hS/B6Md3IxSS0iVbii
	kD/IyM5d/h2XQWGT4qqILtidN710f4rsMHiPsqV4q+3Y4rpGfLAXsKukHWwX2pBp/ucgs/ZKMgN
	DwSk5NFJrFdTpJ6Jpzl9OGwY25G5EfqPH7hlOSfB4ktDiX1xvIMHYTToAvrr+AejOgZy3ElNri9
	aKL1sYQdI939S2YgWy6KiDk52KKLeeb/NRnjvL1VNUrTu4484fjj2ywsaAAOEsUb7+EBYb7J4/T
	TB46BU=
X-Received: by 2002:a05:701a:c94e:b0:127:1b8f:aa02 with SMTP id a92af1059eb24-12759a653f4mr129033c88.28.1771379336298;
        Tue, 17 Feb 2026 17:48:56 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ea8a:2651:c8f:99eb? ([2620:10d:c090:500::3:3a6d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cba118sm20594390c88.12.2026.02.17.17.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 17:48:55 -0800 (PST)
Message-ID: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
 support for trampolines
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
Date: Tue, 17 Feb 2026 17:48:53 -0800
In-Reply-To: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
References: <20260217221357.18215-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CEF815293C
X-Rspamd-Action: no action

On Wed, 2026-02-18 at 09:13 +1100, Slava Imameev wrote:

[...]

> The verifier assigns SCALAR type to single-level pointers (void*, int*).

So, the simplest change for pointers to pointers would be as below, right?

  --- a/kernel/bpf/btf.c
  +++ b/kernel/bpf/btf.c
  @@ -6906,7 +6906,8 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
           * If it's a pointer to void, it's the same as scalar from the ve=
rifier
           * safety POV. Either way, no futher pointer walking is allowed.
           */
  -       if (is_void_or_int_ptr(btf, t))
  +       if (is_void_or_int_ptr(btf, t) || !is_ptr_to_struct(btf, t))
                  return true;

          /* this is a pointer to another type */

Except that loaded value would be marked as scalar() and one would
need to cast it using e.g. bpf_core_cast() to obtain an untrusted
pointer.

> For multi-level pointers, I selected PTR_TO_MEM to enable memory access
> through a single load instruction for the first level of dereference,
> with subsequent dereferences becoming SCALAR. This design eliminates
> helper call for parameter dereference, replacing it with a load
> instruction (e.g., void* ptr =3D *pptr).

If going this route instead, is there a technical reason to limit this
logic to multi-level pointers? Applying same rules to `int *` and
alike seem more consistent.

[...]

