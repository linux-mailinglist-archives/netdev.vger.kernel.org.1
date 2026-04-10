Return-Path: <netdev+bounces-277272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAWyD3ab2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0E3D2DD1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 437CE3008D7D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1B38836D;
	Fri, 10 Apr 2026 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEHE6PY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08710387373
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803252; cv=pass; b=JtFJk1x2BlkOw1kuuZqJQUNjafONu1o6SqZdM2GSr1aogeTBnn1mGire1nirvSO/A4OteXC9q0/XSi9vfu8kxg1DdYXrmMg6gaHvvW+6uaRSZV8JxgHQ+YbEFc71vd3X2wxyaUYzn8xkBlI4yCJMOSwr+yx8B7bKRFAiFn2xWnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803252; c=relaxed/simple;
	bh=DMAKrl64OQ4qyDrv7kaUVNKQcJ/sC0akF0j723ydj8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYo4A8fagPSvt4xpKgjoIjZc81IPgK5sEvUMcUtyctt9zV7mej5aGd1NfRwWOy146ZDabqrBF/3czC8CeOTHCm2g6TdF8gF35Eq+wuGYVfuel8sUJyeOuYw7/3cjE4qo4JbjJcJp2idSyvwKz7f9SaR9nmQ351qpGEh4WU7jr6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEHE6PY5; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1279eced0b9so2441366c88.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775803250; cv=none;
        d=google.com; s=arc-20240605;
        b=FjH7+4eznsgOAMSY/BDYZluZd5A1ZQ54t60kYW9jRI8qMo0X7BROTRIaGGivKoAiSc
         69+U6R0trwFh9nIHKLUzr36ac2o7UPnh8cdW0uAHw+8yg8io5jyozbeATmRWf1EKJ1WT
         7u+nEoQTgeU1k1+G2VcVCA6a9Qx55WveWqnv2PVEgH/PGFbS85CDT2gDaLVXerieydvI
         gZemrJpiLIq7xlOvED0cGn0VbtmCAbSnDZgea4bq6u280UkTHk/5DFktL+EHTXciESbr
         OWnE897CDKwLpMHUd4Psc0nY6/gUB+c2QZO0uvkf946qn1d7XtlFzn3rPSfwsqbGR9NG
         zhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMAKrl64OQ4qyDrv7kaUVNKQcJ/sC0akF0j723ydj8Y=;
        fh=G0GPzF2JPDFP+LLekNtYus8wd/3yrixLLEFTLp9JDMM=;
        b=EGs0MCtcg/cuKbcVeoBiXEVBf30jnFvpUFnbGVJb8TCAoSIw0HQOgr+7NOQludAHdj
         HxyBkYoxlxl2O/+inZWCoXdKQho1kC5msdrSvaLMEdtIStRUqqHRx1PpGET/6Jf+Pyd4
         Kn3GsJ6UCnG7rGvXgk0fuDprMxOn21AMDf3/tp48BUilvEyYLa1vFJgwMFMNQVXUz33g
         L7Znd3mMwoaH8eN0rWSqllgEfAe6ILdxbkXl+mCLgiuzUK2EWbXC9z5VysK1Z4CC84O/
         AlLqymh5gy1AB4uB0Z6L7mIuXqXo2EueA/ibUcY/alpkvVE0Uxa3AxIpOgKAmbo7G0Lm
         RIFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775803250; x=1776408050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMAKrl64OQ4qyDrv7kaUVNKQcJ/sC0akF0j723ydj8Y=;
        b=DEHE6PY5gFx4xW/FbJ3Nba6QsKJFQEAYWvHsf7Gly8E8kVNrvMpfsSaO/UnsXgz3CA
         Syb65eAgZ+RRt3mogzJBDO4hPY1WcgNwfM0jKA1zvY39MZvq46mj6aM2nF3ZjOIR8hT1
         Ume1LxZRHLSpZOohqi3b7FKR0CdevWoTTePXCv5nPIlwlxGNrhrvkrrTiFs6SAOmsPea
         jziKTy7+Dy3qYMbV4pNW5zUvcvN2Powpn/1uZ9lFO44S+90C3vAW6c5+gthMwNtjUakW
         q9eA4B7U3aCcjh7+mwAziqIPDNvl/d8dB/B++vNYH6PkuaPs4e86nLqwzRg9gwbAl7WW
         fJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803250; x=1776408050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DMAKrl64OQ4qyDrv7kaUVNKQcJ/sC0akF0j723ydj8Y=;
        b=QwsR58tJPNqRiOTijRrn5LbIIpq3+tQZpgCjk1x25WxM8HyuvIoTNas4uAQTWF2NF8
         +3k106JFdexXep9SD4PSSlXJEerGZqJC3/6LGhdYix5GlkrMMRaYYpm0OqHQxhOuxYRc
         +JARMMvfZhuxGrMBmHVEpnCVJ97NCxJhm3MZ90gfa4SMuilrs9fpbt5ix/vcENdEMgIj
         HQq0hGq4UV6u8fOLeEm0qrNNVcnncjHjZpSJW09Kf2l0RsnRYfN+a43Jm7XRmHIlWjCI
         DlGflLRz8jceGTP1uY/dDvmkK52BZ6VTnrjyagb3jcKMTsZytJDrCTGL0l767331qLtF
         exBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9FwVOCqoBxOmgbCRdLdTvxUiiphNiQ4ZjhzlrMc701pNqjTn20SUHOGQS8s2uFM/xAjVROxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy463xxWKEroKRJrJn1MFOB2ar+hTUHqn2hDB9s4FtdKeCXAI96
	tgKgmsknnqqDDvGgmuzUZxmF+W/Bhwls7zqCWxS2UvgWtoS112JDPLvmpZUrQ3dKQ/mqSa8isbN
	Dk95vboCLFp+Vvz9HmrLjO2m6RBowDEIcKRXvTeBgc0cAl4rZZXsvD4pG
X-Gm-Gg: AeBDiesxjnbEoExudGUunBH6YifHzQiF/eS/lZJXjwHeaXnhMH0fDZWZt8cSQ9/coEv
	ZMYNhSnSVG7PS+a4eG+RPmwgGNWbAG5f0f8NT9+fJagONabGVy+LsPVt8k0KOXopixo4RciiRMV
	GfRqFaWHlm86gmPbqrfc89hH2SmLlzW6bhLiI9LL/9MS2ZD+NEBQuxtO1uSmQtJIBJS9TBu3QIx
	ZsyEIkwR0SxG0RN6A4hlMFEadExHAZjSKpO+PyBOiZxZydsSIzT1BW/pCyIeDq2aXET0+YNZayn
	fz34cdTqIKdlk0HjtLcm5fHtuYikD0yTHuKT9dfnw1xmYQmkliOxfqLpxAxRBE3yEF/8cxs0Dbm
	dafr0QX0=
X-Received: by 2002:a05:7022:250d:b0:11b:b3a1:714a with SMTP id
 a92af1059eb24-12c34e8f8a4mr1325949c88.12.1775803249428; Thu, 09 Apr 2026
 23:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-10-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-10-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:40:38 -0700
X-Gm-Features: AQROBzBDhp0ZqyoDg0bhktmSV6Aa5figfs_vUCsyeJKog5pLduGHStx9cOmEJio
Message-ID: <CAAVpQUDdGUunCHGGWaAS=a5SzBu_A3JXhQp792Qk+JPA2B1amw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/10] selftests: net: Add tests for team
 driver decoupled tx and rx control
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277272-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5E0E3D2DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> Use ping and tcpdump to verify that independent rx and tx enablement
> of team driver member interfaces works as intended.
>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

