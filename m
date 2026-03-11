Return-Path: <netdev+bounces-266698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DJaFpGZsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:34:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 011AA26769A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10EE308704A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0237267D;
	Wed, 11 Mar 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb3qgogW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35EC2517AC
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246681; cv=none; b=kuru7aVvO26Ybx1b/aGdhwABQzlF4oeUEcM91DucUQX1XZl6R5kJ03/5kq6+REA3cS1Ton4nYdU0scHZl6XTMThpMGmuKk/GxwS66snv/C8mfAgUhQoanV4KmIWVdHSByZC28Ky6r24WBpOa0WLTlghCOyQ6LZq9o3Uilv+eYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246681; c=relaxed/simple;
	bh=Kd2o1aBEobvspvm60zCAF7juO/ZjobOchZgqbSx1vIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r24Xu92iO6oNpmxEVfIVhT5X76NBcikavKraElaRA5ozv/qPaOSAYq9zBCOezKN9C74c+JnyMUgXt3vl6OhzKnu+ZLGpHS9HCsTGAr5kmL26jiq5vE1s3laZ17bYkY+4ig4JOp3JRxJkn+CdsKThoh0ejxOCp+FcmMt3we/zy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb3qgogW; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1271257ae53so5314c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773246680; x=1773851480; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kd2o1aBEobvspvm60zCAF7juO/ZjobOchZgqbSx1vIM=;
        b=Cb3qgogWrAS2nG2no+ttZFOwVLlRLl8W+29UIzO6at+gdjh7XQ9MJvzOLuGzTsP5LU
         7WtjhlUX7qlb1HWtHpaF/m+YzBja5iWY2jpdeQcy3cawQ4hQYFmVqhzFjpu4E9px0Rf0
         VLDOakntGF4qjy8U6H699pFTnMKTI/C+T4RvJE8JFtbUPjlKgZIK6a+1+8aZKaawK+Ek
         EPh5LMX+vPgMjqbB6hstBggMwE5F9BrM8S/7UgUiDYAGKfYoPtMXtXR51HxGhDMB+Yle
         kzxNyfFlDh1TDXAZ1Q+LlUlXIRdW59GOWhuPDXi3WQuNPQXuAf6z21Ay+CJeoeWFNwVx
         7IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246680; x=1773851480;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd2o1aBEobvspvm60zCAF7juO/ZjobOchZgqbSx1vIM=;
        b=MIlUvckyRrC1CypFQd9clgXidbSfYd/a6cjZ29eckYuSw+KkwMsS2XEo8MkTAniDWs
         HFhwwaxzeUW36nlHRMsnnT3co/s2rGu27xkMknwk2psJYgzHvt952iUL3dSAXxJ494vD
         xiG03pZdoo56TuSsu7+vV/MPdeFPeG66WykZwqNP3vzUZu8DyO7bfjlvXkB/TUA4Vr2Y
         UjPWAmkUSzfoFArH4uB/1E8Mnv8+VKbBFfAkVlWLQ611ijE2DfO9v60oNDxjrnWS8fln
         Qj54rXt4kxDxzE82cffbY9sPLHOtc2aU5JeLl7Qh1BBdvQ8gQhCgxCzhemFITdTbvhot
         2dAA==
X-Forwarded-Encrypted: i=1; AJvYcCXSBOX5znRwXgTrHSy0oMlgMi2PfQzueWoIofUkO7JLilDMdU6hFXTkfEROMmVXQQetjkbd8i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlh14E26J645zAz+y0+T7ZLZhP2Lio8rApGxPNjn58AKoeOnm
	fUcQe8cn7A/7dYluVu3CetG3WoBkHT+uKdAe0Fk8MybozQjEPfrSswI+
X-Gm-Gg: ATEYQzwwh64EoIAcFekvmV++iy1I87vIkkaubuZeLEjuxtR0ptfUnlG+GsauJscb8ie
	2tXwsAy5O0I9CP0PwsJB5SBRsHlQOvn6LZFWsgk/ossb2UDzfXXvV0woG+LeXcIGgU/hu79xsuT
	qwUo0E6iWJhW8JmHyvfG+0Htc19CERfrTgdXJVKqLHh27Ml1rmjjImZS27W2LIw2VlinCSOom/x
	dfkag9YPDMj19TJQuw5aaaqzmBiEuHBH4lOR/YR9LLMjLyuiikvyk0g2EnXfIiNCGrxGY5arkiF
	kOUSziWycL8uXkpJ9iGUbYFm42DcAd/pCVCTue/r8ExV/DF7F/TbazPY4zQkwdJCojGnVNbjPS/
	rBMWRjMfdHkBq+fCiiaLt+U1GUcday8p46AvVf2URZVO3CZw3f/Z+BeX2hZ0uokvM7ZTfzbaUgM
	XGEr/C7xZ1H+bqKB/YEKUQBj6/m1DbGeyBcHlRmc0ao3TVsD0Eq3bOT4aH+8PhJXt9cdrQZC3R5
	5P2ztk=
X-Received: by 2002:a05:7022:218:b0:128:d7a7:526e with SMTP id a92af1059eb24-128e77ae81bmr1331880c88.13.1773246679819;
        Wed, 11 Mar 2026 09:31:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7458:e476:e695:15f3? ([2620:10d:c090:500::3:a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7c1780bsm3445083c88.7.2026.03.11.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:31:19 -0700 (PDT)
Message-ID: <55f48be8727546631aebacc847bede5ce2de85c4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, horms@kernel.org, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, 	pabeni@redhat.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, 	yonghong.song@linux.dev
Date: Wed, 11 Mar 2026 09:31:17 -0700
In-Reply-To: <20260311130711.33966-1-slava.imameev@crowdstrike.com>
References: <979c7539ac475b3c428f609066e947844b6dd8b0.camel@gmail.com>
	 <20260311130711.33966-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 011AA26769A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 00:07 +1100, Slava Imameev wrote:

[...]

> Adopting the view that vmlinux BTF is consistent, we can replace
> btf_ctx_access's condition for inferring scalar() for pointers
> from "if (is_void_or_int_ptr(btf, t))" to
> "if (!btf_type_is_struct_ptr(btf, t))".

I think it should be fine to adopt this view.

