Return-Path: <netdev+bounces-263404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCwIC/k+p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C3E1F6974
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4294302A9D0
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE063395D96;
	Tue,  3 Mar 2026 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSIsRVe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BA389117
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568309; cv=none; b=kImGtoWIa4tD+Hw3ZrF6VVCUikN/bbpfaIJPWnrBy8z+B1Zdm5cI9uxskvQhZxj6ZZIxaIb9pNWftTSjLwG3nfQXLpox6tPJ6kr8xfm9bmME+Dofz0ir+rVy+87zc+BHWz5VRcP0uzQB5YKnau+wkbpNiDsRAcDO8cEcbn6FtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568309; c=relaxed/simple;
	bh=bzPb6xmAmChlVP1q/WZM2tU9RBqtVAwunFB11U2PeFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDDixKtRYvppYeTX75WPW88Pt/d/a3hXGInThvCQ9Ya91ApfehxX35nn0IqexH21j3tjnS4vQF6ZZVE1rUMxCzVuP0bfm7ic/jenMkjEdniii10h26HRucIBnLD9Z/qxgKA4fTVV3tXfGfAgyTqLh/4m+/d1idzqc4aSULI9Fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSIsRVe6; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4b77adso7888542c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772568308; x=1773173108; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HuHhGttXcFsF+4KHE6jrs5iwTBoeSrOICFq+9jlRCq0=;
        b=bSIsRVe6UZvWI4nIJSQTLM2z/mRTQTIzATYGx2TntqAnXap3tmmLkSLfW37VEEQPbG
         Coj+sog5Kav5y8SSyaTUJTA6XBN5UxnLLyn8rPIwHnAX0jgGUq74/fMNpRVCdS8eacJi
         BR7c2IwyAFQVkIC0I1fqKOSCe5D5d86/div2hvsGsHuUZq6FoTif1NdHDvxsmYISW2aT
         pQmQVZ9f6cjEf27FTX9rWYOIO7rfblQ7pV+3KMyzE0LCttzjxkcVe4Y4CddADgxf1pXX
         Nwjt5pgKaS94yu80oruGpIyJWOtuZjo93uFFToglgA+vlaerNDeZONsds4aDcA5iFjkn
         LLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568308; x=1773173108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuHhGttXcFsF+4KHE6jrs5iwTBoeSrOICFq+9jlRCq0=;
        b=d2hNNcWdP31o/heqIMuuJneQ2psxL7pG7Zd6g5fwRQkU9wQGDUuVXBmUiZaGA5FAT/
         P2ppiaZHb07ULRgIAWyy8gDQ6usoPLBLGyFm/li2B8biMP0GfmWuxGeThkVVfqACQjMl
         jU/epaRqpd56sBEIFimfWTNtQ5trzsiR3xlXw3q5KfK2IcG1NB9DY0S5MMHQB9QuQXzj
         mQO3gA17xG8dwXEkI/M/inSVqd4Z8/BdwNqkncnU6CS4tnTZuXAKovF04ZTusavSschU
         /LBwSclPBi3Y847vbOd3SvQlok/C7Q7YS+VB5y2lwgX7IGLrvQGN/uuVxBSF2BeQHNcm
         yD9w==
X-Forwarded-Encrypted: i=1; AJvYcCUA9C2EQFS6xVN2ZvQxOmh8RTSI7PETnkcEDIJ34m6PWoox1rRdXxp1+pJoQjX2uXoA4jzJaSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4kS2JhGqG8VKxQG5HfoyeGNi0pV+5taQqVwpP85K9y83ZqJo
	qBfnzSOHBqvZ8qTeEpRr1aBrZL2yntr4M5x7vYQxErSpj6Azr/7JhodL
X-Gm-Gg: ATEYQzyrypIp0TNTCaAgSNXa6wbfLR5wKXFz8iNKWpdBGWmATsPdEzRKmw7TujwjiO7
	P0SM0t3h/onnkMM4JYnWGmoyLFV2seHPl4/WqdGjPzDH5MI3KjL/BoUbyFNV3C2oKpN8yq8rmGM
	n51LRQO5uP9air9RNflTuPNqXUaT4aq6My7BZYtVdXTue6/7F0DiE23jSN0/8Oa99YojrLKP3C2
	NhjnxYRzllV+25Bmr9w1V1i7ybPzhHHFKOyibqngvOIBfPSsTNeKZq2LRQGzwRWXO0+mRLvnqBA
	x+KDmsCLWdGSTp/pBuabvUR4OsKQoRwE2YLDVcS8YGrITwWN4Z9j3Sm6/DPhOMh6JgSjLIVZAJS
	bKgntUjnNOHplaAI00nehtbnvN6Z7QCMX8lInoXtBAIIgpVgBOGoJKBpZXJRBG3vBxqEXsB+zDE
	8EQMHJEbw1oDUI0Knk/1aWRAqGrzhoOhvgFS7VT2B5GH1YsjSgjqzAzbub0iKEflBN8ZuI5Jhdn
	wRytnv2
X-Received: by 2002:a05:7022:b97:b0:11b:9b98:aa4b with SMTP id a92af1059eb24-1278fb6859cmr8038142c88.6.1772568307717;
        Tue, 03 Mar 2026 12:05:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm20207397c88.5.2026.03.03.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:05:07 -0800 (PST)
Message-ID: <c40dd219ea60f810d52576f998e68cc0d731f761.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
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
Date: Tue, 03 Mar 2026 12:05:04 -0800
In-Reply-To: <20260303095427.38981-2-slava.imameev@crowdstrike.com>
References: <20260303095427.38981-1-slava.imameev@crowdstrike.com>
	 <20260303095427.38981-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C4C3E1F6974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 20:54 +1100, Slava Imameev wrote:

[...]

> @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>  		}
>  	}
> =20
> -	/*
> -	 * If it's a pointer to void, it's the same as scalar from the verifier
> -	 * safety POV. Either way, no futher pointer walking is allowed.
> -	 */
> -	if (is_void_or_int_ptr(btf, t))
> +	if (is_ptr_treated_as_scalar(btf, t))
>  		return true;

I'm probably missing a point here, but what's wrong with Alexei's
suggestion to do this instead:

	if (is_ptr_treated_as_scalar(btf, t))
		 return true;
?

Only two new tests fail:
- #554/62  verifier_ctx_ptr_param/fentry/pointer to float - invalid ctx acc=
ess:FAIL
- #554/63  verifier_ctx_ptr_param/fentry/double pointer to float - invalid =
ctx access:FAIL

But I'd say this shouldn't matter.
This will also make selftests much simpler.

> =20
>  	/* this is a pointer to another type */

