Return-Path: <netdev+bounces-297677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n/RWOvpiKWpcWAMAu9opvQ
	(envelope-from <netdev+bounces-297677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:13:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B06699FE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NiirN0jc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297677-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297677-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BFE5300514F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701240801D;
	Wed, 10 Jun 2026 13:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA306403AF7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:09:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096945; cv=pass; b=RD9nmbpB108u3gruJURMJN5sWkgRjsCEf/XZgO9vzGaXqT/rkuAUODHAcc5odw5Yq48kT6l/iTT1nZAfWPjRRm4fWazFT2R6zfV1CLKlnG5Vygl7cdFLuIen3Skr3HWXfRpWuhHNW3p9yx9+GjHSP0Of0DwvUNpb9a8jwsQ1PW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096945; c=relaxed/simple;
	bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZlnixBm2/8h81zdukvrk2agG+7QPJpzWGNKpda41RrCHD/CyTTfvvK40S0pcY1pcUJmAhk0lNjBKml8XIs7SmxoAohjV5AadOydx93N9y70MxM4saSNB1xpp8CAblh9rg/igJnkDiwMQYsTvP51Xejp58F/bKsefIStm3Q3NqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiirN0jc; arc=pass smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d3d3d8f8so479107eec.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096944; cv=none;
        d=google.com; s=arc-20240605;
        b=M/hVubRGV94jh7zOqRuCCJJ/XmjDZauvFJqfoeF0TwoiNL9k1eh3ye9Fdv7r4q8+PF
         xEN85pdQRGdpVuUnRAAWWtBamkVMFcOd6xnI7c2kedPuEN/qhlRnu7ysP54mdtLHMKQT
         bkUjTQGlc/JoJ9NVqqLtIZ4P1HkOBICCSSb5rZi4giY9FVWwENlVs7orWmM3dWMh0lKg
         cOSGke8ulFWAul7Nsp87DLg7QCTXmf1/I0Fgs0xcVumMW6ZYhCQ9hIP75unD5mqQY1vv
         F1xaox7VNlRw/zRG9ghZFK11DLzSX6kw8olI+W0PiX94oPbxtsdS46lcbpU6RkL++i9y
         nIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
        fh=b1vWvx3bcXlYz4qEJYJOoWw9dG7OaI/KZm628IrXB7Q=;
        b=E82VNxTURsdSx4S+0bjp3dFfo6BwsG37rIV0CgwWSqEL/Q7FJqmMbrMH9xUSnrEkL8
         lC1Lxd7w8W5466PI6PkOE1otvBOmaxz9YlTWoY8FzXvFEMBl6pr1vRU4/tCEdV5Feya+
         RT++hcQDbwb2+zzCW3whijWSj1zUb3w4A9YwiWFFp5Xa8aqQsn/DnH2w39HYENN1iK3P
         WVnYM9uoxcBi6qWk65G1GtjCek63luMvU/OiP4Y5E3msbB2So3UuVNTcTGQ/fnV/K+Gu
         oFGSar+gsnJOMCPEVG9P82d5zUUMhVbxoPHbKUAQHNpLqF/QwDHdtHP1vHp6mLh4SKAP
         W/1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096944; x=1781701744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
        b=NiirN0jctNGp0Xrul/PNU/K1v50I4gqMb1n5zsGuOSqZ9g/CVyFXVr8ghr+rfk1CsI
         UKE3zToOcUOOXUjhn/hg+PCw6NC2vLMwJUBE2fXuGjm7Ua2ABhupZFBNIxxLsleDl1Mg
         Pd/zOK50sgJDgZ72jd9xv9PzllIHHABaqVTQ4x45JOfzn+ujt87qqNKoiQPicapBBtpT
         C5pTxgw3NgDCWafzAzr8iADMKy36+2bLdv7GEG6nhGFkik10OPQToFstgpc0OTHwKyHD
         5sh0IfRAbxmng3n2aaTPytTttR6TMHyz8Z5OmstlLced1rct+3t4XgBZO3uhra1yE+ao
         nP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096944; x=1781701744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMO+q+CyPLuQfigTmgGUaVN+qKKBldwqNdWDRJi9STE=;
        b=JfBH48MMK2O6zw6aChhwih3l7PsCWluXiUTikkU7gKSNNzYTYc623fpQBgeBHYsJcL
         XfGF2Bl5Zdwe6Gpis2/BN+dxMICjZB5iYrNLYxpJUupyqGEqEfoywIXzlb+rrLKVynSN
         Z4mYM7rhy5foCjHCvalL3JJw0eyQ3LNfq1U2ka3/8I9WkOhIIT551mTL0VS/CPFWKiec
         qiZsap0xxrviDUkRKlEspf3+A7F3NEA8Myces3BCIV5OIE5EqOa3GNI+P9BeIXKebRg2
         aCPQAde7weX5Zew3hQfAu77wVgfvWsYwlMpXkrlKTrfvbRhT82N4ycZWDqZJMsO41If8
         hS8w==
X-Forwarded-Encrypted: i=1; AFNElJ9TlPgZVJGODgJ7H3Kqw4UgRrMp+Z0cZwBWOK85eFrU5O83eo1ciXDHKwtDoUh8fNoOFerY8M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobqhDQINm/9ORqdzBdPidZMaK+KoHhTCrYpMNpB7rWYqB0luI
	OENgpfm/rUEMs+gDC0ZkEp7JL48t17LIq11Y2qDAJk/nxPfI2cfx0uivrTd1fmuhn+Cr5e7J266
	G2cQkpThbaOcoM/8JMuIeI9Q2mvH+8Ug=
X-Gm-Gg: Acq92OF9D4DNR5NcsXZEnrMdpncNE/mkffhfgahyfrszd2CkL8dYXjfO+D0qTYLeGVG
	O1x7k1dfa98+03Cn+wBIBMRabb7PMpYv4JUcLocV2Jsan6bDqF3a2cgDiDWe+oBO7EOY9FYsPfh
	CAs3JzgmqdVZmRIhBJSJxQZQ9rDKhLKDvfRbohC8st6uCkLpGafdABx46WkLEdQpAIjTrEgOmNs
	iIAhepMaHvGrTGUiPugFRXiRBeAxEszVeJOJY1VrzHJsxLYFm0ReLxSm53UyGc6FuywebAJvzvx
	QsXwOEyClycNFV+wnViZ6iwNiTNxZUlUL8jV41yYgAHejEPlNXTvvlHXcjHvH2Z2USY3CKQDhWu
	onB6Pcw8fqosspa+m03lUmxlN4B8ZFRd/fw==
X-Received: by 2002:a05:7300:1352:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-3077b576885mr6517116eec.3.1781096943682; Wed, 10 Jun 2026
 06:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
 <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
 <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com>
 <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com> <CAM0EoMn9EA_TS80QzXsTscBpCgfJHssq0GHtiNbrMU3FAiP2mw@mail.gmail.com>
In-Reply-To: <CAM0EoMn9EA_TS80QzXsTscBpCgfJHssq0GHtiNbrMU3FAiP2mw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jun 2026 15:08:50 +0200
X-Gm-Features: AVVi8CfHlwkVTHo8xz3kijx6SbCXBkd0w80sby_--JSQFG4p4xR4OJZ4-aRIac8
Message-ID: <CANiq72ki_YW=0UbadZ8pp0Np3Je3W6gLvAw3GJgRmzjXZ5RBVA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:ojeda@kernel.org,m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:hxzene@gmail.com,m:victor@mojatatu.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E45B06699FE

On Mon, Jun 8, 2026 at 10:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> I think it was too early AM here when i was looking at this.
> The answer was right there all along in what you said: The missing
> piece is commit a005fa5d7502

No worries, it happens :)

I see a005fa5d7502 is now in the release.

Cheers,
Miguel

